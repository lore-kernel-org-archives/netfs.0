Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5717545
	for <netfs@lists.linux.dev>; Wed, 17 Jul 2024 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198074; cv=none; b=CHH9D7s57+rfxkhrB9EfdsAaR8JdtUVZgw1sNKRQk3iXV1/3reDvxj+RM/KpLJAjKccG4wisbb+hzIGEHEOsTRHzXWieJxD+JbXWAbeK2t/fLZk4O0bdg2/kHTfd55MwfJ3JWSEqmz/bAZKJjpbAc/gwgSKPznD4jfT136x4Oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198074; c=relaxed/simple;
	bh=uWgQqfYFRgmDO8Jurd5UNddb20XMhBF06IYnB+OSbFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gH367zEPRD+Hpz0vJSYOBjJCHUoCShsTP7P729JigOJEXgIMP6COrGTqP0XFa0vZyjnqwmeDKXkkG7F3zmEIOvr6QyQqNfh2uqZLubE29rCIp6uFysQCq9wdBXYzDEUMQeP4suUTQbBYUJHW9o1l9/PworZTUGazHiy1JrUaeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WP5dD5mqfzxT4d;
	Wed, 17 Jul 2024 14:29:36 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F1F5180087;
	Wed, 17 Jul 2024 14:34:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 14:34:28 +0800
Message-ID: <9e531afd-45e8-471b-8074-8ae5c90aceb0@huawei.com>
Date: Wed, 17 Jul 2024 14:34:27 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support STATX_DIOALIGN
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>
References: <20240716124534.2358151-1-lihongbo22@huawei.com>
 <afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/17 10:00, Gao Xiang wrote:
> Hi,
> 
> On 2024/7/16 20:45, Hongbo Li wrote:
>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>> alignment restrictions are exposed to userspace in a generic
>> way.
>>
>> [Before]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:0
>> dio offset align:0
>> ```
>>
>> [After]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:512
>> dio offset align:512
>> ```
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/inode.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 5f6439a63af7..9325a6f0058a 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, const 
>> struct path *path,
>>       stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>>                     STATX_ATTR_IMMUTABLE);
>> +    /*
>> +     * Return the DIO alignment restrictions if requested.
>> +     *
>> +     * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
>> +     * the compressed file, so in these cases we report no DIO support.
>> +     */
>> +    if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>> +        stat->result_mask |= STATX_DIOALIGN;
>> +        if (!erofs_is_fscache_mode(inode->i_sb) &&
>> +            
>> !erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
>> +            struct block_device *bdev = inode->i_sb->s_bdev;
>> +            unsigned int bsize = (bdev) ? 
>> bdev_logical_block_size(bdev) :
>> +                        i_blocksize(inode);
> 
> I guess in this way you could always use
>              stat->dio_mem_align = bdev_logical_block_size(bdev);
>              stat->dio_offset_align = stat->dio_mem_align;
> ? since bdev won't be NULL.
> 
Yeah, only the EROFS_FS_ONDEMAND config is on, the s_bdev can be NULL.

Thanks,
Hongbo

> Otherwise it looks good to me.
> 
> Thanks,
> Gao Xiang

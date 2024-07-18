Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B529CFB
	for <netfs@lists.linux.dev>; Thu, 18 Jul 2024 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273766; cv=none; b=fRPrA/Yu6vXw5H+enW4MIaVW3UbO2FxdnjT17ZkuBowB/HiqxHZsjVvM63PHTIRXKq6AMsI/2I4XCMVQ979AS4reOix9LIj/Bh5QTu22lY2vki6oMH8VlIIY/06FH27obd8zUrl0snio5mGD5ApsGZddsJIQl/GDb/C0fhrIxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273766; c=relaxed/simple;
	bh=oghq8vvuOikgzpcghDOKSNNc49OZh6aXA48mRNRd/P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NOBdqqBuVIZOmUsa4BUfIjx2vS3Q5RC9uJWXB2pAlhGJbm1CvI+DuF5Ql5Brm4mpKUUJ2MHy8xkhizIGU0Mq1gaxyJHiBjrUHcSUFmv7ijcPvOa5eRbsI+/RVE1vVZ015sd8vxkdv7a/PcV9PsHvz+VumLse2jI0TKI21vjGcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WPdck5XKFz1JClN;
	Thu, 18 Jul 2024 11:31:02 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 71CA418009E;
	Thu, 18 Jul 2024 11:35:55 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 11:35:55 +0800
Message-ID: <4f477570-bea7-4008-b823-b3d94fc81243@huawei.com>
Date: Thu, 18 Jul 2024 11:35:53 +0800
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
 <9e531afd-45e8-471b-8074-8ae5c90aceb0@huawei.com>
 <e0f9d85f-3b5f-49e7-b702-8c41188de44f@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <e0f9d85f-3b5f-49e7-b702-8c41188de44f@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/18 10:41, Gao Xiang wrote:
> 
> 
> On 2024/7/17 14:34, Hongbo Li wrote:
>>
>>
>> On 2024/7/17 10:00, Gao Xiang wrote:
>>> Hi,
>>>
>>> On 2024/7/16 20:45, Hongbo Li wrote:
>>>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>>>> alignment restrictions are exposed to userspace in a generic
>>>> way.
>>>>
>>>> [Before]
>>>> ```
>>>> ./statx_test /mnt/erofs/testfile
>>>> statx(/mnt/erofs/testfile) = 0
>>>> dio mem align:0
>>>> dio offset align:0
>>>> ```
>>>>
>>>> [After]
>>>> ```
>>>> ./statx_test /mnt/erofs/testfile
>>>> statx(/mnt/erofs/testfile) = 0
>>>> dio mem align:512
>>>> dio offset align:512
>>>> ```
>>>>
>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>> ---
>>>>   fs/erofs/inode.c | 19 +++++++++++++++++++
>>>>   1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>>> index 5f6439a63af7..9325a6f0058a 100644
>>>> --- a/fs/erofs/inode.c
>>>> +++ b/fs/erofs/inode.c
>>>> @@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, 
>>>> const struct path *path,
>>>>       stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>>>>                     STATX_ATTR_IMMUTABLE);
>>>> +    /*
>>>> +     * Return the DIO alignment restrictions if requested.
>>>> +     *
>>>> +     * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
>>>> +     * the compressed file, so in these cases we report no DIO 
>>>> support.
>>>> +     */
>>>> +    if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>>>> +        stat->result_mask |= STATX_DIOALIGN;
>>>> +        if (!erofs_is_fscache_mode(inode->i_sb) &&
>>>> + !erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
>>>> +            struct block_device *bdev = inode->i_sb->s_bdev;
>>>> +            unsigned int bsize = (bdev) ? 
>>>> bdev_logical_block_size(bdev) :
>>>> +                        i_blocksize(inode);
>>>
>>> I guess in this way you could always use
>>>              stat->dio_mem_align = bdev_logical_block_size(bdev);
>>>              stat->dio_offset_align = stat->dio_mem_align;
>>> ? since bdev won't be NULL.
>>>
>> Yeah, only the EROFS_FS_ONDEMAND config is on, the s_bdev can be NULL.
> 
> Would you mind sending a v2 to fix this?  At least, s_bdev is always
> non-NULL currently.
> 
> I could apply this for this cycle.
> 
I'm working on ondemand direct io mode. This will affect the 
STATX_DIOALIGN result for erofs_is_fscache_mode case (.ie the 
dio_mem_align is i_blocksize(inode) in erofs over fscache). Should we 
apply this first and then modify it after the direct io is supported in 
ondemand erofs?

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>
>>> Otherwise it looks good to me.
>>>
>>> Thanks,
>>> Gao Xiang

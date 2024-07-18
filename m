Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D851C36
	for <netfs@lists.linux.dev>; Thu, 18 Jul 2024 02:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721270522; cv=none; b=h1QFHnS7ZujLKNdrK8SdPhbr7aGjGYJPSlai75Xvr1xFgrj+DTNADRxIq5TFLwMTzU8meVQ/HD9zdB42c95GRuFZrwycnOsGO7wBVmCWE1cyLnuNuGCwN8iAnWs8tqWwmhyKYPwSko3bkSB22GVyME0FBdoIhQVtuRWVGAl8tHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721270522; c=relaxed/simple;
	bh=YL/Pcv+ia1KTWPmGiAJBsW6RV8N2HnQiMDEqBE1gVCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLCFcGgCzBNZz3yeCP1ULFOhIqSkTCWlv+IHg8361uaoRd6yZR0JDX9/jU6vF5hoXNNIZO+sMfuji8uryen4kwy/S/kJVf5gEeNs1827ilQfPzHRi9TM2qGbSpSdNLMTEKHDk8CtfcV1rqIBltzOp9SVepLzzGsTelZtb6PeD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hvyr/lBd; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hvyr/lBd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721270511; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cXpfWt/AEfl56W8cB+bG0PA1Hg8iftNO+NUPlLqgr3s=;
	b=Hvyr/lBdk8v9RTXCxfexAOpEdwCNJeE1DFXxKEcHp2g9sVp9hOg3c5unOD9P35MLeSfwksmcOKfPJK6jn8qLMm9wvFmeW1yNr3T5nlUs6RQJV0nipt5oXX3fhOSclXMlR0JeJOIudEDxarC33EdQ766jb43dUmEbOXw1Eck0jSY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAmbqZC_1721270509;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAmbqZC_1721270509)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 10:41:50 +0800
Message-ID: <e0f9d85f-3b5f-49e7-b702-8c41188de44f@linux.alibaba.com>
Date: Thu, 18 Jul 2024 10:41:48 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support STATX_DIOALIGN
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
Cc: linux-erofs@lists.ozlabs.org, netfs@lists.linux.dev
References: <20240716124534.2358151-1-lihongbo22@huawei.com>
 <afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com>
 <9e531afd-45e8-471b-8074-8ae5c90aceb0@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9e531afd-45e8-471b-8074-8ae5c90aceb0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/17 14:34, Hongbo Li wrote:
> 
> 
> On 2024/7/17 10:00, Gao Xiang wrote:
>> Hi,
>>
>> On 2024/7/16 20:45, Hongbo Li wrote:
>>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>>> alignment restrictions are exposed to userspace in a generic
>>> way.
>>>
>>> [Before]
>>> ```
>>> ./statx_test /mnt/erofs/testfile
>>> statx(/mnt/erofs/testfile) = 0
>>> dio mem align:0
>>> dio offset align:0
>>> ```
>>>
>>> [After]
>>> ```
>>> ./statx_test /mnt/erofs/testfile
>>> statx(/mnt/erofs/testfile) = 0
>>> dio mem align:512
>>> dio offset align:512
>>> ```
>>>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>   fs/erofs/inode.c | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>> index 5f6439a63af7..9325a6f0058a 100644
>>> --- a/fs/erofs/inode.c
>>> +++ b/fs/erofs/inode.c
>>> @@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>>>       stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>>>                     STATX_ATTR_IMMUTABLE);
>>> +    /*
>>> +     * Return the DIO alignment restrictions if requested.
>>> +     *
>>> +     * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
>>> +     * the compressed file, so in these cases we report no DIO support.
>>> +     */
>>> +    if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>>> +        stat->result_mask |= STATX_DIOALIGN;
>>> +        if (!erofs_is_fscache_mode(inode->i_sb) &&
>>> + !erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
>>> +            struct block_device *bdev = inode->i_sb->s_bdev;
>>> +            unsigned int bsize = (bdev) ? bdev_logical_block_size(bdev) :
>>> +                        i_blocksize(inode);
>>
>> I guess in this way you could always use
>>              stat->dio_mem_align = bdev_logical_block_size(bdev);
>>              stat->dio_offset_align = stat->dio_mem_align;
>> ? since bdev won't be NULL.
>>
> Yeah, only the EROFS_FS_ONDEMAND config is on, the s_bdev can be NULL.

Would you mind sending a v2 to fix this?  At least, s_bdev is always
non-NULL currently.

I could apply this for this cycle.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>> Otherwise it looks good to me.
>>
>> Thanks,
>> Gao Xiang

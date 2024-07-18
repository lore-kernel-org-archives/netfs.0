Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1891B86FB
	for <netfs@lists.linux.dev>; Thu, 18 Jul 2024 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277359; cv=none; b=eFhoqQKDe+QZbvxC3l47RuVgm2kUfKOeEGPphbB8hFujgqopE1onbYmECPo9tfLNvWXj2ZEFWP1lubfUVwaO6QmEJ+qbUwFzI7ywizcELClIAn0Gy6Iv5aAaFRHW7hqweyPP4cMa2BNvi4osoVdBP4KNmKbF8ELNbkubbIkuXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277359; c=relaxed/simple;
	bh=6fpxI6eCuXkomioxS4k7jgQvvyudSXo66Xmu6TrBqb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwP3YGs6jeTE6BfeqslwllGwyGRFLRW09/s4bqifgOQzOMv2ZnT2whVgL/fHO7KtNpffblqTFDcwBmOAR8RkWA6V/ZObn9hL0AzmNfCEuS9Xfl9pCq/cHFLaoZkpWyfRy4LWEdKXBel1sniPiD77Lp7/cdS2YghPjSBoe8yDm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jSfL62Dw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jSfL62Dw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721277349; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qwnp/Xu2THJPRPDnDNp5Z+FL6aaixEwcWqFwZgPz0Kw=;
	b=jSfL62DwhFHGp4fwVELhSd07LFeL6F+Rhn5sFi2Sy6IRgHP/UjQ0G6zny9TCQy5wdIOV7w9ffHP//XSCX/ye+7bmwfh4uiGhFNeKwz2XY5fOPynFsn7sHLgV0f90jK+6dSiXun6arQ+sB3FB1BHmKQ6B0hjgPAf1U6nh157NoPk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAn7AEy_1721277347;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAn7AEy_1721277347)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 12:35:48 +0800
Message-ID: <5dd2c04e-50eb-4619-a746-ff7ea9f3326f@linux.alibaba.com>
Date: Thu, 18 Jul 2024 12:35:46 +0800
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
 <e0f9d85f-3b5f-49e7-b702-8c41188de44f@linux.alibaba.com>
 <4f477570-bea7-4008-b823-b3d94fc81243@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4f477570-bea7-4008-b823-b3d94fc81243@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/18 11:35, Hongbo Li wrote:
> 
> 
> On 2024/7/18 10:41, Gao Xiang wrote:
>>
>>
>> On 2024/7/17 14:34, Hongbo Li wrote:
>>>
>>>
>>> On 2024/7/17 10:00, Gao Xiang wrote:
>>>> Hi,
>>>>
>>>> On 2024/7/16 20:45, Hongbo Li wrote:
>>>>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>>>>> alignment restrictions are exposed to userspace in a generic
>>>>> way.
>>>>>
>>>>> [Before]
>>>>> ```
>>>>> ./statx_test /mnt/erofs/testfile
>>>>> statx(/mnt/erofs/testfile) = 0
>>>>> dio mem align:0
>>>>> dio offset align:0
>>>>> ```
>>>>>
>>>>> [After]
>>>>> ```
>>>>> ./statx_test /mnt/erofs/testfile
>>>>> statx(/mnt/erofs/testfile) = 0
>>>>> dio mem align:512
>>>>> dio offset align:512
>>>>> ```
>>>>>
>>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>>> ---
>>>>>   fs/erofs/inode.c | 19 +++++++++++++++++++
>>>>>   1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>>>> index 5f6439a63af7..9325a6f0058a 100644
>>>>> --- a/fs/erofs/inode.c
>>>>> +++ b/fs/erofs/inode.c
>>>>> @@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>>>>>       stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>>>>>                     STATX_ATTR_IMMUTABLE);
>>>>> +    /*
>>>>> +     * Return the DIO alignment restrictions if requested.
>>>>> +     *
>>>>> +     * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
>>>>> +     * the compressed file, so in these cases we report no DIO support.
>>>>> +     */
>>>>> +    if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>>>>> +        stat->result_mask |= STATX_DIOALIGN;
>>>>> +        if (!erofs_is_fscache_mode(inode->i_sb) &&
>>>>> + !erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
>>>>> +            struct block_device *bdev = inode->i_sb->s_bdev;
>>>>> +            unsigned int bsize = (bdev) ? bdev_logical_block_size(bdev) :
>>>>> +                        i_blocksize(inode);
>>>>
>>>> I guess in this way you could always use
>>>>              stat->dio_mem_align = bdev_logical_block_size(bdev);
>>>>              stat->dio_offset_align = stat->dio_mem_align;
>>>> ? since bdev won't be NULL.
>>>>
>>> Yeah, only the EROFS_FS_ONDEMAND config is on, the s_bdev can be NULL.
>>
>> Would you mind sending a v2 to fix this?  At least, s_bdev is always
>> non-NULL currently.
>>
>> I could apply this for this cycle.
>>
> I'm working on ondemand direct io mode. This will affect the STATX_DIOALIGN result for erofs_is_fscache_mode case (.ie the dio_mem_align is i_blocksize(inode) in erofs over fscache). Should we apply this first and then modify it after the direct io is supported in ondemand erofs?

Yes, I prefer that.  If you submit a new version
of STATX_DIOALIGN, I'd like to merge this for this
cycle (6.11).

But fscache direct i/o seems that it needs another
cycle tho.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Hongbo
>>>
>>>> Otherwise it looks good to me.
>>>>
>>>> Thanks,
>>>> Gao Xiang

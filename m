Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A8ED8
	for <netfs@lists.linux.dev>; Wed, 17 Jul 2024 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181655; cv=none; b=YibMr1kTXYnX96mxaS73r8z+XRRuCZK+jIaRCieIQmSGQWKJU35wTS/h/PPqElCCTrq2pT9t3KRRFaqc6MYjC9G2pkNfJZ1OfISA+WvCBqK7JxF+EZP5w87qN8TFmN3CgeM4A1OGhDsD1BF/LFPB9VAwstZG73ZfEuaq4Vota+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181655; c=relaxed/simple;
	bh=AmMhNazh8sw6udDDiCsu3CkUaL9eaAujbzFMasRRAeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpmMi8B2qzl32eLJLi/BUp0pmI+d5gWiiv1mQNESUJk2+CWVWI0RINX9QNpt9MXTP41tEG4bs2KNlY0mXorBtbZDJelaZG2v5+4Rm+Q/BMet9xUkOUn+aMRyBQPAvTDY7+Rmxr5r9f0zhA/Ut063p2ohs6Dq6Jfl4z+2mVG6Ezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HuYBQFPo; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HuYBQFPo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721181650; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qn4YNmQesyYA7x5FZl+8m77z1qbmFe4k/1rGJiEHD6Y=;
	b=HuYBQFPoEl7ihchENzCPvRt/8qoLaQFWV/ZAmrD6GKnRNAtozsF+fb6u2quFu6XJhGCDA/zKObsHxyytqjGQL4TS2rEHdDpVZUwFC9ny4vvdKPLJZOE9+tW6Zd8X/EBj4Z/lOOwfwxDrIbvXs1xK3WtFncVqULk2hw5+GPsmEN4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAircwo_1721181648;
Received: from 30.97.49.55(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAircwo_1721181648)
          by smtp.aliyun-inc.com;
          Wed, 17 Jul 2024 10:00:49 +0800
Message-ID: <afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com>
Date: Wed, 17 Jul 2024 10:00:48 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240716124534.2358151-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/7/16 20:45, Hongbo Li wrote:
> Add support for STATX_DIOALIGN to erofs, so that direct I/O
> alignment restrictions are exposed to userspace in a generic
> way.
> 
> [Before]
> ```
> ./statx_test /mnt/erofs/testfile
> statx(/mnt/erofs/testfile) = 0
> dio mem align:0
> dio offset align:0
> ```
> 
> [After]
> ```
> ./statx_test /mnt/erofs/testfile
> statx(/mnt/erofs/testfile) = 0
> dio mem align:512
> dio offset align:512
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/inode.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 5f6439a63af7..9325a6f0058a 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>   	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>   				  STATX_ATTR_IMMUTABLE);
>   
> +	/*
> +	 * Return the DIO alignment restrictions if requested.
> +	 *
> +	 * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
> +	 * the compressed file, so in these cases we report no DIO support.
> +	 */
> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> +		stat->result_mask |= STATX_DIOALIGN;
> +		if (!erofs_is_fscache_mode(inode->i_sb) &&
> +			!erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
> +			struct block_device *bdev = inode->i_sb->s_bdev;
> +			unsigned int bsize = (bdev) ? bdev_logical_block_size(bdev) :
> +						i_blocksize(inode);

I guess in this way you could always use
			stat->dio_mem_align = bdev_logical_block_size(bdev);
			stat->dio_offset_align = stat->dio_mem_align;
? since bdev won't be NULL.

Otherwise it looks good to me.

Thanks,
Gao Xiang

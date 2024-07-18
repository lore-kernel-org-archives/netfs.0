Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293E1C36
	for <netfs@lists.linux.dev>; Thu, 18 Jul 2024 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721270442; cv=none; b=aCeyoAqd+RBn2IWlTPodY6r6Mx5lG0v0UlHyaknG/i33pK1ACSl0u4365pb/IjlBAUFnumLEkkEm5sCCwS3z1ol75qWMlMigoBapW+g7/CtB0kOXRP5ZJ8fIeYlKhKAzRkAEOYQ4x0QhY/qjF2dCuOp3y6A9s08OLjWDeOk8HtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721270442; c=relaxed/simple;
	bh=0HdDC7fVDMEeh5o5KnSuZKrnvQOvOTGfvNLk3ec6AZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HM+sirh+ncD1y3QH0SpvXHQJWQjsnMOmwo85TEkoU1TPA++bxgXng8K+bT3enu1+8Gs5in5D3IqU35pbaRwBeiAeN7eo98j1ocrEfbs6jjxs0cUvIW3c6IezlSJxIeJWcPos28qYU0vdkslOLKV4K66ap8k5XxvWMhcFP37yFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eoFGK5BF; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eoFGK5BF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721270430; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hap/+GDinbL0Z9ZN59JAi9K4fUlBe3k2BO8OnTBEuKQ=;
	b=eoFGK5BFNwmI8+od0tbyMYIPnMHFDIRVT4+EiDcSE0WxFK+Fu4KTYPhvuMfK/CuqBXKLjkiiOdz+dS3hKGo+JdMcCDJcvsG5LMiqfRMzrYtMupoPqznRiBm8WXfeiuHkPnQnTz2u4lRPU79UO5ko0p2NMmkBb/pz7GHFKg7ihoo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAmk5Mb_1721270428;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAmk5Mb_1721270428)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 10:40:30 +0800
Message-ID: <54cf962f-dcdb-465a-ad83-f292f9b84b02@linux.alibaba.com>
Date: Thu, 18 Jul 2024 10:40:28 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support direct IO for ondemand mode
To: Hongbo Li <lihongbo22@huawei.com>, jefflexu@linux.alibaba.com,
 David Howells <dhowells@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, netfs@lists.linux.dev,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Sandeep Dhavale <dhavale@google.com>
References: <20240718010545.2869515-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240718010545.2869515-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hongbo,

I'd like to request Jingbo's review too.

On 2024/7/18 09:05, Hongbo Li wrote:
> erofs over fscache cannot handle the direct read io. When the file
> is opened with O_DIRECT flag, -EINVAL will reback. We support the
> DIO in erofs over fscache by bypassing the erofs page cache and
> reading target data into ubuf from fscache's file directly.

Could you give more hints in the commit message on the target user
of fscache DIO?

For Android use cases, direct I/O support is mainly used for loop
device direct mode.

> 
> The alignment for buffer memory, offset and size now is restricted
> by erofs, since `i_blocksize` is enough for the under filesystems.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c    |  3 ++
>   fs/erofs/fscache.c | 95 +++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 8be60797ea2f..dbfafe358de4 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -391,6 +391,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		     iov_iter_alignment(to)) & blksize_mask)
>   			return -EINVAL;
>   
> +		if (erofs_is_fscache_mode(inode->i_sb))
> +			return generic_file_read_iter(iocb, to);
> +
>   		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>   				    NULL, 0, NULL, 0);
>   	}
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fda16eedafb5..f5a09b168539 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -35,6 +35,8 @@ struct erofs_fscache_io {
>   
>   struct erofs_fscache_rq {
>   	struct address_space	*mapping;	/* The mapping being accessed */
> +	struct iov_iter		*iter;		/* dst buf for direct io */
> +	struct completion	done;		/* for synced direct io */
>   	loff_t			start;		/* Start position */
>   	size_t			len;		/* Length of the request */
>   	size_t			submitted;	/* Length of submitted */
> @@ -76,7 +78,11 @@ static void erofs_fscache_req_put(struct erofs_fscache_rq *req)
>   {
>   	if (!refcount_dec_and_test(&req->ref))
>   		return;
> -	erofs_fscache_req_complete(req);
> +
> +	if (req->iter)
> +		complete(&req->done);
> +	else
> +		erofs_fscache_req_complete(req);
>   	kfree(req);
>   }
>   
> @@ -88,6 +94,7 @@ static struct erofs_fscache_rq *erofs_fscache_req_alloc(struct address_space *ma
>   	if (!req)
>   		return NULL;
>   	req->mapping = mapping;
> +	req->iter = NULL;
>   	req->start = start;
>   	req->len = len;
>   	refcount_set(&req->ref, 1);
> @@ -253,6 +260,55 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   	return ret;
>   }
>   
> +static int erofs_fscache_data_dio_read(struct erofs_fscache_rq *req)
> +{
> +	struct address_space *mapping = req->mapping;
> +	struct inode *inode = mapping->host;
> +	struct super_block *sb = inode->i_sb;
> +	struct iov_iter *iter = req->iter;
> +	struct erofs_fscache_io *io;
> +	struct erofs_map_blocks map;
> +	struct erofs_map_dev mdev;
> +	loff_t pos = req->start + req->submitted;
> +	size_t count;
> +	int ret;
> +
> +	map.m_la = pos;
> +	ret = erofs_map_blocks(inode, &map);
> +	if (ret)
> +		return ret;
> +
> +	count = req->len - req->submitted;
> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		iov_iter_zero(count, iter);
> +		req->submitted += count;
> +		return 0;
> +	}
> +
> +	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
> +	DBG_BUGON(!count || count % PAGE_SIZE);
> +
> +	mdev = (struct erofs_map_dev) {
> +		.m_deviceid = map.m_deviceid,
> +		.m_pa = map.m_pa,
> +	};
> +	ret = erofs_map_dev(sb, &mdev);
> +	if (ret)
> +		return ret;
> +
> +	io = erofs_fscache_req_io_alloc(req);
> +	if (!io)
> +		return -ENOMEM;
> +
> +	iov_iter_ubuf(&io->iter, ITER_DEST, iter->ubuf + iter->iov_offset, count);
> +	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie, mdev.m_pa + (pos - map.m_la), io);
> +	iov_iter_advance(iter, io->iter.iov_offset);
> +	erofs_fscache_req_io_put(io);
> +
> +	req->submitted += count;
> +	return ret;
> +}
> +
>   static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
>   {
>   	struct address_space *mapping = req->mapping;
> @@ -324,12 +380,13 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
>   	return ret;
>   }
>   
> -static int erofs_fscache_data_read(struct erofs_fscache_rq *req)
> +static int erofs_fscache_data_read(struct erofs_fscache_rq *req, bool direct)
>   {
>   	int ret;
>   
>   	do {
> -		ret = erofs_fscache_data_read_slice(req);
> +		ret = (direct) ? erofs_fscache_data_dio_read(req)
> +				: erofs_fscache_data_read_slice(req);
>   		if (ret)
>   			req->error = ret;
>   	} while (!ret && req->submitted < req->len);
> @@ -348,7 +405,7 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>   		return -ENOMEM;
>   	}
>   
> -	ret = erofs_fscache_data_read(req);
> +	ret = erofs_fscache_data_read(req, false);
>   	erofs_fscache_req_put(req);
>   	return ret;
>   }
> @@ -369,8 +426,35 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>   	while (readahead_folio(rac))
>   		;
>   
> -	erofs_fscache_data_read(req);
> +	erofs_fscache_data_read(req, false);
> +	erofs_fscache_req_put(req);
> +}
> +
> +static ssize_t erofs_fscache_directIO(struct kiocb *iocb, struct iov_iter *iter)

How about get rid of upper case names, e.g.
using erofs_fscache_direct_io instead?

Thanks,
Gao Xiang

> +{
> +	struct file *file = iocb->ki_filp;
> +	size_t count = iov_iter_count(iter);
> +	struct erofs_fscache_rq *req;
> +	struct completion *ctr;
> +	ssize_t rsize;
> +	int ret;
> +
> +	if (unlikely(iov_iter_rw(iter) == WRITE))
> +		return -EROFS;
> +
> +	req = erofs_fscache_req_alloc(file->f_mapping, iocb->ki_pos, count);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->iter = iter;
> +	init_completion(&req->done);
> +	ctr = &req->done;
> +	ret = erofs_fscache_data_read(req, true);
> +	rsize = (ret == 0) ? (ssize_t)req->submitted : ret;
>   	erofs_fscache_req_put(req);
> +	wait_for_completion(ctr);
> +
> +	return rsize;
>   }
>   
>   static const struct address_space_operations erofs_fscache_meta_aops = {
> @@ -380,6 +464,7 @@ static const struct address_space_operations erofs_fscache_meta_aops = {
>   const struct address_space_operations erofs_fscache_access_aops = {
>   	.read_folio = erofs_fscache_read_folio,
>   	.readahead = erofs_fscache_readahead,
> +	.direct_IO = erofs_fscache_directIO,
>   };
>   
>   static void erofs_fscache_domain_put(struct erofs_domain *domain)

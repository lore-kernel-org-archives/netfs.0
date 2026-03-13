Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F293A6F03
	for <netfs@lists.linux.dev>; Fri, 13 Mar 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415502; cv=none; b=eyYy9FqPi9rD2sUj/jffOGdupnYDGXbgISK+JM3Jhyt1lSiq9yHgjqQ6je1Ux0EFyMdCISC+KljVtUbMqqnGvKGYVzOd4PR8INrXgTxsY0DuPX9I+HNjmN02hzWEzxYlAXgXxj7DhPzosJx9Fv4SNBs7XYiH857isgRETsQIxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415502; c=relaxed/simple;
	bh=aeYBl3gPJNWi0Lve/lzpygmP/EsHvS5N9VSLTE8DkAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ1zywxF0WQF0IXQiIPz+xUwQgtaH0pnfilvHVIMwwzV0oGaeFM0Z+h15xs4Ah5ZdtWq8P81kvxU7kNs2VwAd2SY+u3OXYlW+9X/B02ln+OSuCtQ9TcNYN6/jvEEO3V8NxbqGs5LSdBgZrcR+2qp6yCLPAR0/m7H7b8CljZdrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 39ECF72C8CC;
	Fri, 13 Mar 2026 18:14:54 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 324BA36D0187;
	Fri, 13 Mar 2026 18:14:54 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id 0EB7B360D793; Fri, 13 Mar 2026 18:14:54 +0300 (MSK)
Date: Fri, 13 Mar 2026 18:14:54 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: dhowells@redhat.com, pc@manguebit.org, jlayton@kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfs: Fix kernel BUG in netfs_limit_iter() for
 ITER_KVEC iterators
Message-ID: <abQoe8YqMc-xa8KA@altlinux.org>
References: <20260307090041.359870-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307090041.359870-1-kartikey406@gmail.com>

Deepanshu, David,

On Sat, Mar 07, 2026 at 02:30:41PM +0530, Deepanshu Kartikey wrote:
> When a process crashes and the kernel writes a core dump to a 9P
> filesystem, __kernel_write() creates an ITER_KVEC iterator. This
> iterator reaches netfs_limit_iter() via netfs_unbuffered_write(), which
> only handles ITER_FOLIOQ, ITER_BVEC and ITER_XARRAY iterator types,
> hitting the BUG() for any other type.
> 
> Fix this by adding netfs_limit_kvec() following the same pattern as
> netfs_limit_bvec(), since both kvec and bvec are simple segment arrays
> with pointer and length fields. Dispatch it from netfs_limit_iter() when
> the iterator type is ITER_KVEC.

  [    1.901035] kernel BUG at fs/netfs/iterator.c:248!

We hit the issue in v6.18.17 and the patch resolved it.

Tested-by: Vitaly Chikunov <vt@altlinux.org>

Thanks,


> 
> Fixes: cae932d3aee5 ("netfs: Add func to calculate pagecount/size-limited span of an iterator")
> Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
> Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  fs/netfs/iterator.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
> index 72a435e5fc6d..154a14bb2d7f 100644
> --- a/fs/netfs/iterator.c
> +++ b/fs/netfs/iterator.c
> @@ -142,6 +142,47 @@ static size_t netfs_limit_bvec(const struct iov_iter *iter, size_t start_offset,
>  	return min(span, max_size);
>  }
>  
> +/*
> + * Select the span of a kvec iterator we're going to use.  Limit it by both
> + * maximum size and maximum number of segments.  Returns the size of the span
> + * in bytes.
> + */
> +static size_t netfs_limit_kvec(const struct iov_iter *iter, size_t start_offset,
> +			       size_t max_size, size_t max_segs)
> +{
> +	const struct kvec *kvecs = iter->kvec;
> +	unsigned int nkv = iter->nr_segs, ix = 0, nsegs = 0;
> +	size_t len, span = 0, n = iter->count;
> +	size_t skip = iter->iov_offset + start_offset;
> +
> +	if (WARN_ON(!iov_iter_is_kvec(iter)) ||
> +	    WARN_ON(start_offset > n) ||
> +	    n == 0)
> +		return 0;
> +
> +	while (n && ix < nkv && skip) {
> +		len = kvecs[ix].iov_len;
> +		if (skip < len)
> +			break;
> +		skip -= len;
> +		n -= len;
> +		ix++;
> +	}
> +
> +	while (n && ix < nkv) {
> +		len = min3(n, kvecs[ix].iov_len - skip, max_size);
> +		span += len;
> +		nsegs++;
> +		ix++;
> +		if (span >= max_size || nsegs >= max_segs)
> +			break;
> +		skip = 0;
> +		n -= len;
> +	}
> +
> +	return min(span, max_size);
> +}
> +
>  /*
>   * Select the span of an xarray iterator we're going to use.  Limit it by both
>   * maximum size and maximum number of segments.  It is assumed that segments
> @@ -245,6 +286,8 @@ size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
>  		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
>  	if (iov_iter_is_xarray(iter))
>  		return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
> +	if (iov_iter_is_kvec(iter))
> +		return netfs_limit_kvec(iter, start_offset, max_size, max_segs);
>  	BUG();
>  }
>  EXPORT_SYMBOL(netfs_limit_iter);
> -- 
> 2.43.0
> 

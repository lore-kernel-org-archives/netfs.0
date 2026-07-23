Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD874A2E24;
	Thu, 23 Jul 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810659; cv=none; b=G1ZFFaLr2YtU+baazxLS94HDnZE048+G74brH+WDREQK94oBW6ZGQygXnVpUN4/AdxCjyyPU1R/f6WWmjZee0/wrUADEm//RBZJMIxYDybScGytkYU3miV7p28sU6NI6zZ23f4GBGDgrSyAbi15DPVmh8/H1ehIz19OA2lDGoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810659; c=relaxed/simple;
	bh=lGeLbf16MXee3PqMov6cT8VpzruQr6N3DpbClzPVVlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5hJUSpxKz06NxWtTnPODop5UMkgNgz1jzDjKmJ4kFTILjg87OPBYasdzqsU9ROMLgrs5RR3dZTwvVWtxrYQF9eZ75jgMJZEeSF1qx0aTVvZFQgxAmFkGcMBnXfQlNqXqjUjzHAjswnXk/tOi3pdtUYwv93n1/O5zivhdhHYicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VUI07Z8L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUI07Z8L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iMqN3Xy/AjggyqFlBuASl9hL2B+OGaQJcbX0ehQ/U1I=; b=VUI07Z8LLLroyVsLGUgsscNW/r
	6NsW1GbZulsUabspLZxwwvrEiG0WVzinZIx4g52T01RBB7aHL5w2HMFrM5/ZhX0+BaxvRouJ9zW5q
	nooBmDIompNbhgE8wEmWmOjsjx6l98Mb2zt0qlFIqx2nFNpXxaH0jMmSNwZSgPCBrc6CePH2FPZGD
	p9E+0kABm98Ski3CsZGLg/hL4Bmwbj+ERwBO/BKMnJTIpb5/lVD678PRpY2nBqQzwvevAvFMst33M
	djFTm04T7dhS3Aa6KcT//ck4lepKjjn5tZrTUr3axSH3zNbpasKA9ro6e7bZ2Wu7U9gHWhvcf9g2Q
	FfAdjNjg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmsmX-00000000WyN-46rl;
	Thu, 23 Jul 2026 12:44:10 +0000
Date: Thu, 23 Jul 2026 13:44:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Yun Zhou <yun.zhou@windriver.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, pc@manguebit.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Is writeback_iter() missing some error handling? -- was Re:
 [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to drain all dirty
 folios
Message-ID: <amIMmbxG2PM5yMo6@casper.infradead.org>
References: <20260707052555.2055002-1-yun.zhou@windriver.com>
 <82546.1784729043@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82546.1784729043@warthog.procyon.org.uk>

On Wed, Jul 22, 2026 at 03:04:03PM +0100, David Howells wrote:
> This seems like the wrong thing to do - or, at least, a bug in the
> writeback_iter() API.  Getting something like ENOMEM would seem to indicate
> that all subsequent writeback_iter() calls in this loop are pointless as it
> looks like the sequence will just go { lock, undirty, dirty, unlock } for each
> folio.

I'd find it hard to call a bug, when it's intended behaviour:

                 * For integrity writeback we have to keep going until we have
                 * written all the folios we tagged for writeback above, even if
                 * we run past wbc->nr_to_write or encounter errors.
                 * We stash away the first error we encounter in wbc->saved_err
                 * so that it can be retrieved when we're done.  This is because
                 * the file system may still have state to clear for each folio.
                 *
                 * For background writeback we exit as soon as we run past
                 * wbc->nr_to_write or encounter the first error.

Why are you getting ENOMEM for a sync() writeback anyway?  Is this some
stupid error injection?

Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863336B924;
	Sat, 12 Sep 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789200426; cv=none; b=XkO7POIOMgBRhpmrouxgWgz3kXDRLB+b9/TcWfZLO6yR18GdCVlGxNAvSErJQ/N9G1DRwfavG4Dbpjhsg0Xhk+5BU/U+jLYz53whk24AwGUKwiuCX0emQR+TtqSfvQREjdCsdFJNRENac9eM9icpeb6rPzJV7XLtHirILZfm2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789200426; c=relaxed/simple;
	bh=/BhRoQbM4rP89P2ikDKz8jOhz8dXtsuo8bPeY5ofiS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA6Mk/bFswErBsgcD1jl3+/HXqNRCyRWFzlnyNCDicu0hZ5zI9OKH/SgW2l1BDmvaH7TlwsS4Vdk133r7NlnEY/FWqcdXxa0jBKnPcq1gs8rD/KzUuKvdzAhLQ7ZpevsZVDiGX6p5mioLkRc70D7SvV+eAAP3QUyX4j2pOG+Da8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nF9u0Uha; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nF9u0Uha"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7062814C2D6;
	Sat, 12 Sep 2026 10:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789200420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5LEpHwAy9JD2eAY7Qow4/2xCaLLZEG8/rtZT5kPrKY=;
	b=nF9u0UhajVH4cAXJFiQzFTPSy1Sy2vk3paA7WLKDCd/t3iRv8RXk0wU0gbiiHnValzGfCr
	otOkRXs0YU3SYgeBLqA1E7msdp5MvJHSX4FFaDDPy9E9Q99/2Ei5RxcE6tjuy7wjL6qCV1
	at16F5eEtR4IgXQzVVcaEkRt+dtBZyfGlfcpDl85W1EWnPY8XWdR2T2ObAsn+oVfNv7n2v
	q39MDk+75rkwO6/EVv2FOquNxEcg+sz8bkoToUc0UQUbbAyEnirLMtJwlLKY34UeOPtxhU
	+Cg+vn9EprUtkfGDkW5Y/BTnfm5AZjlUTNzeQ74kIAhJMdVF+NsGNvKJWML56g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f9e640e6;
	Sat, 12 Sep 2026 08:06:55 +0000 (UTC)
Date: Sat, 12 Sep 2026 17:06:40 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Michael Mulqueen <mike@method-b.uk>, ericvh@kernel.org,
	lucho@ionkov.net, pc@manguebit.org, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL
 corruption of file data on cache modes with CACHE_WRITEBACK
Message-ID: <aqUIEEvKad-o-zft@codewreck.org>
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
 <2226525.1789118704@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2226525.1789118704@warthog.procyon.org.uk>

David Howells wrote on Fri, Sep 11, 2026 at 10:25:04AM +0100:
> commit a7f0af2e23c3ab191c08c1041dc67afd971a8c49
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Sep 11 10:15:43 2026 +0100
> 
>     9p: Fix v9fs_issue_write() to update i_size and remote_i_size
>     
>     Fix v9fs_issue_write() to update i_size and remote_i_size to the new size
>     of the server file if we made it larger, using the start fpos and the count
>     returned by p9_client_write() to calculate the new minimum file size.
>     
>     This assumes that if the 9P server makes a short write (say it hits
>     ENOSPC), a reduced count is returned.
>     
>     Fixes: 5fb70e7275a6 ("netfs, 9p: Implement helpers for new write code")
>     Reported-by: Michael Mulqueen <mike@method-b.uk>
>     Closes: https://lore.kernel.org/r/fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk/
>     Signed-off-by: David Howells <dhowells@redhat.com>

Thanks for the patch, I sent it to lists as a proper patch so sashiko
process it (please send patches and write your comments after the `---`
line or just reply to the patches, it's not just for sashiko, it's also
much easier to pick up patches rather than chunks like that -- I had to
save the mail, manually edit and apply...)

Anyway, quoting the report
https://sashiko.dev/#/patchset/20260912071940.3-2-asmadeus%40codewreck.org
----
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 2b6ca573f955a..52c4cf54b833c 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -54,11 +54,37 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
>  static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
>  {
>  	struct p9_fid *fid = subreq->rreq->netfs_priv;
> +	struct inode *inode = subreq->rreq->inode;
> +	struct netfs_inode *ictx = netfs_inode(inode);
>  	int err, len;
>  
>  	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
This is a pre-existing issue, but does using subreq->start here corrupt data
on retry?
If a network error or short write causes a subrequest to partially complete
and be marked for retry, the netfs retry logic resets the io_iter but does
not adjust subreq->start.
When v9fs_issue_write() is re-entered, writing the remaining data at the
original subreq->start offset rather than subreq->start + subreq->transferred
would overwrite previously written data.
Similarly, the new size calculation below propagates this flaw by failing to
include subreq->transferred, which underestimates the file size:
    uoff_t end = subreq->start + len, i_size, remote, zp;

> -	if (len > 0)
> +	if (len > 0) {
> +		uoff_t end = subreq->start + len, i_size, remote, zp;
> +		bool set = false;
> +
> +		spin_lock(&inode->i_lock);
> +
> +		/* We can read the sizes directly as we hold i_lock. */
> +		i_size = inode->i_size;
Does reading and updating i_size from this asynchronous writeback path race
with concurrent truncate operations?
If a concurrent truncate shrinks the file while this async writeback is in
flight, overriding i_size to the write's end position without holding i_rwsem
would undo the truncate's effect locally.
Also, reading inode->i_size directly without i_size_read() bypasses
i_size_seqcount, which can cause torn reads on 32-bit platforms.

(+ something about breaking builds, I guess sashiko's tree is missing
2c8f4742bb76 netfs: Fix potential for tearing in ->remote_i_size and
->zero_point ?
this patch does require it but it seems fine as that also got backported
to 7.0, so this fix can be picked up fine)
---

I don't want to think about what happens with parallel truncates so I'll
ignore this one, but the other one looks correct (checked AFS and CIFS
for comparison)

That can wait for the next cycle and I still indend of sending this
patch to Linus in a day or two, but please send a follow-up patch if you
have time (or I will when I can find time)

Thanks,
-- 
Dominique

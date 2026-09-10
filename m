Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C7493D4E;
	Thu, 10 Sep 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049243; cv=none; b=IKp+n7ZdgKijk3WzNFv0piCXglTMDzWQ2cBtSEIWU09geIlJrrpwcenLRtXfLTwcdoHM7eWWivpJXF4NkOf9knTq2G8OJg7C/TikTk/XfqlJKwckKA6L8B3+HBUnczpJAQoSpX4KQKwwQ46iHfECLKTqDiR+e3vhQmWpyNNbA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049243; c=relaxed/simple;
	bh=7AHrBlllx7CTtEZHixjBstoCtU2GH+xx1JqNfNfIt2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jg58i9ZmNhg1lgPzk/Bu6+wXuiZ2/b27COari8Xs8cTi/RVC936YR0MAh9wlyOkXzB8Zzc2e+D59Kop46WUplVhP9I7ah9SUyajTCCdW2TvNG+Jn1amZX2xBTU5HsWF2bavWkYVwvHQDl3zE9jeNZbgv1jXH+18YFESHgFdot4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=utaqg+UL; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="utaqg+UL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=yVckXBT7ZkvtaRt/2Meu8jC/A0/uqyEsunIirUSTZHc=; b=utaqg+ULBFDjUrgWDK56ADnEFi
	+fOPt3KUC1VWCk6SdJfjBhwvLYciV8l1jyIgZ7ZBF2+c4PkfcjisGoSracBN9ObFtlNM7XT7VnMEo
	PgdwSGQuA42piRBu1PCfiXYmLHZQF9ZlJ2gCgwxYiFNYj5ftmq1BYb0fDr9Wk2JrYC7rlNC9d70g3
	cjzV+gs7/FXMB/PKscEegj/hE7jxOumIGrTQyaiuy8MOcJX60OVVFrREcMQOEeZ+JEVT2HEbBgPJm
	rQwuJRj99TjTkQR+wNcGllN7bYuFmqPJ6ir9MUTvYdm2VnATNnwauAO0ZzorFq76+VCy6l5+OqcRc
	9vuL4tRcze/kFcz4nPsUcJE7cO7IxFvfVccAHO+FOpvpUO7F3rB4I78mCEfyClCve+xvjtYLyHug0
	IwpcWKMPvGszWrNM4irJNbSuXzraKM1HlMORWW0bF1KT8s17NpT7alA3475ZK6wG0txI9EhWapjUi
	cRmz5FlAtMZGIgjcocC5TQpGkOYPeBOCP32KdIAdrQcrQnFSniP7oay2Nf4iugq/EtZPinvZioIhl
	jKo02CMnWxQxQQVxVFTUXoUsOhdSD/g36o4ZR/ti4uwMRiKgaCWJGYDW24qnNL7yTr4aUVxpIOAL1
	cmhWFRhQyRdSv0bW6WO/Kn/fW88IdWpZUMIziNft8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 dhowells@redhat.com, pc@manguebit.org, Michael Mulqueen <mike@method-b.uk>
Cc: v9fs@lists.linux.dev, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject:
 Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL corruption of
 file data on cache modes with CACHE_WRITEBACK
Date: Thu, 10 Sep 2026 16:06:51 +0200
Message-ID: <10911959.nUPlyArG6x@weasel>
In-Reply-To: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 10 September 2026 12:56:24 CEST Michael Mulqueen wrote:
> Hi,
> 
> This is my first kernel bug report, so let's hope I've done it right!
> 
> [1.] One line summary of the problem:
> 
> A 9p mount returns NULs in place of file contents the server holds, and can
> write those NULs back over the server's copy. Nothing reports an error - the
> read succeeds and the file is the correct length. Affects CACHE_WRITEBACK
> modes - mmap, loose and fscache - but not none or readahead.
> 
> [2.] Full description of the problem/report:
> 
> I enclose a reproducer script that shows the two presentations of this bug:
> 
>   - Read side: a range whose folio has been evicted reads back as NULs
>     while the server's copy is intact. The whole file comes back as NULs.
>     A fresh open() on the same mount reads them too, so it is not
>     confined to one descriptor.
> 
>   - Write side: A partial write into such a range destroys data the server
>     did hold.
> 
> I came across this bug on a cache=loose mount in ordinary use, I was seeing
> this sporadically and I think git was usually the trigger. I switched to
> cache=mmap, which made it rarer but did not stop it.
> 
> After the client's own writeback extends a file, zero_point appears to go
> stale and the zero-fill branch in fs/netfs/buffered_write.c fires for
> regions the server does have. The sites were that branch, fs/9p/vfs_inode.c
> (use_zero_point = true to netfs_inode_init), and fs/netfs/misc.c.
[...]
> I then built and tested the likeliest commit and its parent:
> 
>   - 2c8f4742bb76 ("netfs: Fix potential for tearing in ->remote_i_size and
>     ->zero_point") - clean.
> 
>   - 4543a4d73794 ("netfs: Fix zeropoint update where i_size >
>     remote_i_size") - CORRUPT.

So that was:

commit 4543a4d737944134a1394afe797622546fbcc98a
Author: David Howells <dhowells@redhat.com>
Date:   Tue May 12 13:33:43 2026 +0100

    netfs: Fix zeropoint update where i_size > remote_i_size
    
    Fix the update of the zero point[*] by netfs_release_folio() when there is
    uncommitted data in the pagecache beyond the folio being released but the
    on-server EOF is in this folio (ie. i_size > remote_i_size).  The update
    needs to limit zero_point to remote_i_size, not i_size as i_size is a local
    phenomenon reflecting updates made locally to the pagecache, not stuff
    written to the server.  remote_i_size tracks the server's i_size.

[...]

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index bad661ff2bec..723571ca1b88 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -307,10 +307,10 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
                return false;
 
        netfs_read_sizes(inode, &i_size, &remote_i_size, &zero_point);
-       end = umin(folio_next_pos(folio), i_size);
+       end = folio_next_pos(folio);
        if (end > zero_point) {
                spin_lock(&inode->i_lock);
-               end = umin(folio_next_pos(folio), inode->i_size);
+               end = umin(end, ctx->_remote_i_size);
                if (end > ctx->_zero_point)
                        netfs_write_zero_point(inode, end);
                spin_unlock(&inode->i_lock);

That would explain it, as _remote_i_size is only updated on explicit stat()
(Tgetattr 9p request); with cache modes "loose" and "fscache" not even then.

That's actually David's domain, but maybe something like the following might
fix it?

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 210eb8f3958d..9585274b118a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -73,6 +73,8 @@ int netfs_folio_written_back(struct folio *folio)
                spin_lock(&ictx->inode.i_lock);
                if (fend > ictx->_zero_point)
                        netfs_write_zero_point(inode, fend);
+               if (fend > ictx->_remote_i_size)
+                       netfs_write_remote_i_size(inode, fend);
                spin_unlock(&ictx->inode.i_lock);
 
                folio_detach_private(folio);
@@ -90,6 +92,15 @@ int netfs_folio_written_back(struct folio *folio)
                        goto end_wb;
                }
 
+               {
+                       unsigned long long wend = umin(folio_next_pos(folio),
+                                                      i_size_read(inode));
+                       spin_lock(&ictx->inode.i_lock);
+                       if (wend > ictx->_remote_i_size)
+                               netfs_write_remote_i_size(inode, wend);
+                       spin_unlock(&ictx->inode.i_lock);
+               }
+
                /* Need to detach the group pointer if the page didn't get
                 * redirtied.  If it has been redirtied, then it must be within
                 * the same group.

I.e. updating _remote_i_size on client's self-inflicted size extension after
write completed?

> I searched the v9fs and netfs public-inbox archives and did not find this
> reported - apologies if I have missed a thread.
> 
> The nearest existing thread is Pierre Barre's "[BUG] 9p: data corruption
> with cache=mmap under concurrent stat/write" (24 Dec 2025). I believe that
> is a different bug: it needs stat racing against writes and manifests as a
> wrong i_size. What I have here is single-threaded, deterministic, and
> destroys data rather than mis-sizing the file. It is also absent on v6.18,
> the release that report was made against.

Even though unrelated, that's not fixed yet either, is it?

/Christian



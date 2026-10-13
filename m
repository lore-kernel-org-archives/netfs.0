Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC538E119;
	Tue, 13 Oct 2026 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887815; cv=none; b=ZsGzg+6gHwvOfhaBNku+MFjCDdWEn9ZIExXBM8RCXodjiH3vqzUNUIX6XnO3bLk7EEKOxmu86GUHi/pkHty2lSmtfzP3codRczdyJSlqVTTi0VjHfDzPZLcobwawiLP+oTYxiTwqeViRd9/utsnKkk4uwt7v4Wp8yvXGj9yhuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887815; c=relaxed/simple;
	bh=9xpzhBX9bVODJ7T949uGXxxTTpEcqf0d9mhMcbnd3oc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hHURIp9/eM8/rSnqGu4Kk8vRRwCogI8yqKkaemdblkrrrs4CFgth0HNrRWw6zITtW1vgs8PR5+1OSzR4Uulf8kjWLwU4zwkusnjoo8m57eG+qY271a8aRjVF+A+CvRwI2siFuRnSE6hkbJwijbvGFfvEZsPDKi+Yzg0wHKwz0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eq+CRITg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eq+CRITg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945401F00893;
	Tue, 13 Oct 2026 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791887814;
	bh=jX/yNOIC6Jpf9v2/9mUw1TR5CYbZoTxidVxMQmCCSvU=;
	h=Subject:To:Cc:From:Date;
	b=eq+CRITghPt18X6K9fRpjcx6ntO2NROGYit1xylNtJdGWTReUNjAiKmCZZjL09d/Y
	 fe0Yx5fso7mSTw+MWNy6hioRcw+Q/zqdNXx0gC1bLOaMrzNezBKtca12jD/YmBrQoG
	 GQapkTbqVH1VkJAz5cO3Sl4uTbDi0R1GKbsC6auc=
Subject: Patch "netfs, afs: Fix symlink reading" has been added to the 6.18-stable tree
To: brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,linux-afs@lists.infradead.org,marc.dionne@auristor.com,netfs@lists.linux.dev,pc@manguebit.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Oct 2026 12:36:43 +0200
Message-ID: <2026101343-refurnish-cornhusk-d955@gregkh>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    netfs, afs: Fix symlink reading

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-afs-fix-symlink-reading.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From c51e89c5b5db3e1927738fad7cd18b66dde68aed Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 15 Sep 2026 17:21:59 +0100
Subject: netfs, afs: Fix symlink reading

From: David Howells <dhowells@redhat.com>

commit c51e89c5b5db3e1927738fad7cd18b66dde68aed upstream.

Fix the reading of symlinks from the cache in afs by making netfslib trim
the amount read down to i_size.  The problem is that afs sets the size of
the iterator to the size of the buffer (PAGE_SIZE) so that the cache can
round the read size up to the cache's DIO size.

Note that this also impacts the reading of AFS mountpoints as they're just
stored as symlinks with an odd file mode.

Link: https://patch.msgid.link/3912795.1789489319@warthog.procyon.org.uk
Fixes: c0410adf3da6 ("afs: Fix the locking used by afs_get_link()")
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_collect.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -409,6 +409,11 @@ static void netfs_rreq_assess_single(str
 		netfs_single_mark_inode_dirty(rreq->inode);
 	}
 
+	/* To do DIO, the cache has to round the size up, so we need to undo
+	 * the rounding.
+	 */
+	rreq->transferred = min(rreq->transferred, rreq->i_size);
+
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
 		if (rreq->iocb->ki_complete) {


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.18/netfs-fix-folio_queue-enomem-in-writeback-by-adding-.patch
queue-6.18/cifs-call-pagecache_isize_extended-in-cifs_setsize-w.patch
queue-6.18/afs-fix-the-locking-used-by-afs_get_link.patch
queue-6.18/netfs-zero-the-tail-of-a-short-dio-unbuffered-read.patch
queue-6.18/netfs-afs-fix-symlink-reading.patch
queue-6.18/netfs-fix-zeropoint-update-where-i_size-remote_i_siz.patch
queue-6.18/netfs-fix-missing-barriers-when-accessing-stream-sub.patch

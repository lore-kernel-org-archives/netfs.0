Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AC14F9E1;
	Tue, 23 Jul 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733855; cv=none; b=Pxd7tVp8AD/Olv4gWVBRzbFcM0+Rk3mBDpxTIp05mIethUyLWr0WfolgdoMROFy1eQAxVNKxjkAdXfOJunPPHC1MVopZmGt87jFuSG3CZz4dENumUBdEIqE8uW9aLRRI4WGgDzacd0Q+bi4eC2whtoCPMePuuI4pvrOtfhMvvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733855; c=relaxed/simple;
	bh=8tcX3ravFCvacKuAtuQ/YQoCw3mf7V/gwg9MD4ykR1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XhgBIUlSO3IHF7i05tmk94anRivGR4vSS/Rja7FN7JUSVviXaaqKSzvXgzrlzBcrsTJUOGwk2KtidK0K76b4GOrxO/8ngk624qsxjuX2iHEGPO+H0IYSO9e9IOgK22SKJMObaoZN63oC+iFpATfnOtArcdFz85rNjCuYvxIjGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vit7MszS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vit7MszS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24B4C4AF09;
	Tue, 23 Jul 2024 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721733855;
	bh=8tcX3ravFCvacKuAtuQ/YQoCw3mf7V/gwg9MD4ykR1U=;
	h=Subject:To:Cc:From:Date:From;
	b=vit7MszSSzfDWV70iek14rfASUVIBW9UM8uLxirRrxeGBSbMmKBIwjodxIec7eK4i
	 QWIxCluYSBqR6BabCUVsgXWyooW0QXYlpMqp96DIsM/S62Qi/T+xSX4Fu6kNmeyM9o
	 NY/Fm/qa9nxtTNttcgyVB7IypdvWUn/5d+VBHCfU=
Subject: Patch "cifs: Fix setting of zero_point after DIO write" has been added to the 6.10-stable tree
To: dhowells@redhat.com,gregkh@linuxfoundation.org,jlayton@kernel.org,netfs@lists.linux.dev,pc@manguebit.com,sfrench@samba.org,stfrench@microsoft.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Jul 2024 13:23:54 +0200
Message-ID: <2024072354-aide-entomb-3674@gregkh>
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

    cifs: Fix setting of zero_point after DIO write

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cifs-fix-setting-of-zero_point-after-dio-write.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 61ea6b3a3104fcd66364282391dd2152bc4c129a Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 19 Jul 2024 14:07:07 +0100
Subject: cifs: Fix setting of zero_point after DIO write

From: David Howells <dhowells@redhat.com>

commit 61ea6b3a3104fcd66364282391dd2152bc4c129a upstream.

At the moment, at the end of a DIO write, cifs calls netfs_resize_file() to
adjust the size of the file if it needs it.  This will reduce the
zero_point (the point above which we assume a read will just return zeros)
if it's more than the new i_size, but won't increase it.

With DIO writes, however, we definitely want to increase it as we have
clobbered the local pagecache and then written some data that's not
available locally.

Fix cifs to make the zero_point above the end of a DIO or unbuffered write.

This fixes corruption seen occasionally with the generic/708 xfs-test.  In
that case, the read-back of some of the written data is being
short-circuited and replaced with zeroes.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Cc: stable@vger.kernel.org
Reported-by: Steve French <sfrench@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/file.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2364,13 +2364,18 @@ void cifs_write_subrequest_terminated(st
 				      bool was_async)
 {
 	struct netfs_io_request *wreq = wdata->rreq;
-	loff_t new_server_eof;
+	struct netfs_inode *ictx = netfs_inode(wreq->inode);
+	loff_t wrend;
 
 	if (result > 0) {
-		new_server_eof = wdata->subreq.start + wdata->subreq.transferred + result;
+		wrend = wdata->subreq.start + wdata->subreq.transferred + result;
 
-		if (new_server_eof > netfs_inode(wreq->inode)->remote_i_size)
-			netfs_resize_file(netfs_inode(wreq->inode), new_server_eof, true);
+		if (wrend > ictx->zero_point &&
+		    (wdata->rreq->origin == NETFS_UNBUFFERED_WRITE ||
+		     wdata->rreq->origin == NETFS_DIO_WRITE))
+			ictx->zero_point = wrend;
+		if (wrend > ictx->remote_i_size)
+			netfs_resize_file(ictx, wrend, true);
 	}
 
 	netfs_write_subrequest_terminated(&wdata->subreq, result, was_async);


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.10/cifs-fix-server-re-repick-on-subrequest-retry.patch
queue-6.10/cifs-fix-setting-of-zero_point-after-dio-write.patch
queue-6.10/cifs-fix-missing-error-code-set.patch
queue-6.10/cifs-fix-missing-fscache-invalidation.patch

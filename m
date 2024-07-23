Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477BE14F9DF;
	Tue, 23 Jul 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733838; cv=none; b=P9AbE0AIBZz31qNJs15usbU11JVEs3rY/TUAZClhqnnNRKwrh2qJSc7Wm52uPDsnEbJB727YumIe58PUsxUrQXWjZEsyjmgCL2h3Nt407DqNF/NZmStV124n0PHv526zDAQV0DVJvjfy9XTnaMwex+0C529kTt0/3yofa/UakMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733838; c=relaxed/simple;
	bh=q2F8gpSHIZAxmfD/Eeif6SRSlUp5vfXiXonjzbYfVtU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=USs9xu9imJFPxoluLKYmnT/AErRI9PSpi6ikiFXDTJkaCNIo8d/UjmmEjEwOzr4FUM5JYkEZTQAFPh4EDA/xZJeForhDTHE68XigFov4xwE2iHfTVeFuIc7ORXbE4Jfm4j2bLBsLiYqwYykOyFEpBBhx8HTqN4JGyXaH2s2kf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdpL0uDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdpL0uDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BD2C4AF09;
	Tue, 23 Jul 2024 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721733837;
	bh=q2F8gpSHIZAxmfD/Eeif6SRSlUp5vfXiXonjzbYfVtU=;
	h=Subject:To:Cc:From:Date:From;
	b=vdpL0uDsRp23+PVccfz5xfKl+0KD4G6fXCW3xadQ4YROVpFzE45v1sThbtsFkahlY
	 WNLh9T4vkuDcCwGjprF0BeLuwgOSnrVUf+gqodbqclayz2AHM5AxlyROr6qcJlu6d3
	 TFS8TyoQJLqoBioriZi1fPdBu3pvpkvAHe/Dhu6E=
Subject: Patch "cifs: Fix missing error code set" has been added to the 6.10-stable tree
To: dhowells@redhat.com,gregkh@linuxfoundation.org,jlayton@kernel.org,netfs@lists.linux.dev,pc@manguebit.com,stfrench@microsoft.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Jul 2024 13:23:54 +0200
Message-ID: <2024072353-ripening-sniff-a950@gregkh>
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

    cifs: Fix missing error code set

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cifs-fix-missing-error-code-set.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From d2c5eb57b6da10f335c30356f9696bd667601e6a Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Thu, 18 Jul 2024 20:55:20 +0100
Subject: cifs: Fix missing error code set

From: David Howells <dhowells@redhat.com>

commit d2c5eb57b6da10f335c30356f9696bd667601e6a upstream.

In cifs_strict_readv(), the default rc (-EACCES) is accidentally cleared by
a successful return from netfs_start_io_direct(), such that if
cifs_find_lock_conflict() fails, we don't return an error.

Fix this by resetting the default error code.

Fixes: 14b1cd25346b ("cifs: Fix locking in cifs_strict_readv()")
Cc: stable@vger.kernel.org
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1374635e89fa..6178c6d8097d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2877,6 +2877,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 		rc = netfs_start_io_direct(inode);
 		if (rc < 0)
 			goto out;
+		rc = -EACCES;
 		down_read(&cinode->lock_sem);
 		if (!cifs_find_lock_conflict(
 			    cfile, iocb->ki_pos, iov_iter_count(to),
@@ -2889,6 +2890,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 		rc = netfs_start_io_read(inode);
 		if (rc < 0)
 			goto out;
+		rc = -EACCES;
 		down_read(&cinode->lock_sem);
 		if (!cifs_find_lock_conflict(
 			    cfile, iocb->ki_pos, iov_iter_count(to),
-- 
2.45.2



Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.10/cifs-fix-server-re-repick-on-subrequest-retry.patch
queue-6.10/cifs-fix-setting-of-zero_point-after-dio-write.patch
queue-6.10/cifs-fix-missing-error-code-set.patch
queue-6.10/cifs-fix-missing-fscache-invalidation.patch

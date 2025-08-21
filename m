Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC131CA6E;
	Thu, 21 Aug 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780769; cv=none; b=KBO7aV3KJTPTdDK0sdpo0hGzcGuVf4iXxHZHkuB1Nc8Wwf4svqrpuwvbHxfmI7ovuYbGCxt2TbdmWBMmXoJstNuqFOS3lA3Yjo1eSiSZzEBRLuLWQzRq6WSYy8FQzzb2zYKXzUByxpFsAufaHoQ0iddrrKWkrs5sHCuRb99Xwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780769; c=relaxed/simple;
	bh=VUdq9kxgH5EdBPdiXDUFgk3xyBD4ESffuBhxIhRahrM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JkgUTLJUCwQDb75VKW7KusuGe3QNQJ1kX4M1/duwkN8njHh/LSMzj0evjUrMIAR5h6RXNj1Ftf0IIBuEnSbzgXML6c9bnUOdysbf7vmOnT1K+Rc3ShJJHc0w3dEcMTpkksAFX4WjA+EwbDBigB1qOo2NZV20kb/KKv7u32TJsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFhSA9Ah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFhSA9Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C161EC113D0;
	Thu, 21 Aug 2025 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780769;
	bh=VUdq9kxgH5EdBPdiXDUFgk3xyBD4ESffuBhxIhRahrM=;
	h=Subject:To:Cc:From:Date:From;
	b=BFhSA9AhUhi93+7BHkMdaYnd2Tnk/FQKsq2xn9SDS9XnUFkqGusy1dzx3n/L9Evlq
	 mX+BD+HMEMt5O2QvJxSrykdjvNpyyUBikOhXLydxCAmFKGonja2r9PahFswdPObQz5
	 MnkGoApAIjcJWphw6ME83wy60QR8JwHWaIXkG9hA=
Subject: Patch "netfs: Fix unbuffered write error handling" has been added to the 6.16-stable tree
To: brauner@kernel.org,dhowells@redhat.com,fengxiaoli0714@gmail.com,gregkh@linuxfoundation.org,netfs@lists.linux.dev,pc@manguebit.org,sfrench@samba.org,sprasad@microsoft.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:50:13 +0200
Message-ID: <2025082113-passenger-steed-0d63@gregkh>
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

    netfs: Fix unbuffered write error handling

to the 6.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-unbuffered-write-error-handling.patch
and it can be found in the queue-6.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From a3de58b12ce074ec05b8741fa28d62ccb1070468 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Aug 2025 22:45:50 +0100
Subject: netfs: Fix unbuffered write error handling

From: David Howells <dhowells@redhat.com>

commit a3de58b12ce074ec05b8741fa28d62ccb1070468 upstream.

If all the subrequests in an unbuffered write stream fail, the subrequest
collector doesn't update the stream->transferred value and it retains its
initial LONG_MAX value.  Unfortunately, if all active streams fail, then we
take the smallest value of { LONG_MAX, LONG_MAX, ... } as the value to set
in wreq->transferred - which is then returned from ->write_iter().

LONG_MAX was chosen as the initial value so that all the streams can be
quickly assessed by taking the smallest value of all stream->transferred -
but this only works if we've set any of them.

Fix this by adding a flag to indicate whether the value in
stream->transferred is valid and checking that when we integrate the
values.  stream->transferred can then be initialised to zero.

This was found by running the generic/750 xfstest against cifs with
cache=none.  It splices data to the target file.  Once (if) it has used up
all the available scratch space, the writes start failing with ENOSPC.
This causes ->write_iter() to fail.  However, it was returning
wreq->transferred, i.e. LONG_MAX, rather than an error (because it thought
the amount transferred was non-zero) and iter_file_splice_write() would
then try to clean up that amount of pipe bufferage - leading to an oops
when it overran.  The kernel log showed:

    CIFS: VFS: Send error in write = -28

followed by:

    BUG: kernel NULL pointer dereference, address: 0000000000000008

with:

    RIP: 0010:iter_file_splice_write+0x3a4/0x520
    do_splice+0x197/0x4e0

or:

    RIP: 0010:pipe_buf_release (include/linux/pipe_fs_i.h:282)
    iter_file_splice_write (fs/splice.c:755)

Also put a warning check into splice to announce if ->write_iter() returned
that it had written more than it was asked to.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Reported-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220445
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/915443.1755207950@warthog.procyon.org.uk
cc: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_collect.c  |    4 +++-
 fs/netfs/write_collect.c |   10 ++++++++--
 fs/netfs/write_issue.c   |    4 ++--
 fs/splice.c              |    3 +++
 include/linux/netfs.h    |    1 +
 5 files changed, 17 insertions(+), 5 deletions(-)

--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -281,8 +281,10 @@ reassess:
 		} else if (test_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags)) {
 			notes |= MADE_PROGRESS;
 		} else {
-			if (!stream->failed)
+			if (!stream->failed) {
 				stream->transferred += transferred;
+				stream->transferred_valid = true;
+			}
 			if (front->transferred < front->len)
 				set_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags);
 			notes |= MADE_PROGRESS;
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -254,6 +254,7 @@ reassess_streams:
 			if (front->start + front->transferred > stream->collected_to) {
 				stream->collected_to = front->start + front->transferred;
 				stream->transferred = stream->collected_to - wreq->start;
+				stream->transferred_valid = true;
 				notes |= MADE_PROGRESS;
 			}
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
@@ -356,6 +357,7 @@ bool netfs_write_collection(struct netfs
 {
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
+	bool transferred_valid = false;
 	int s;
 
 	_enter("R=%x", wreq->debug_id);
@@ -376,12 +378,16 @@ bool netfs_write_collection(struct netfs
 			continue;
 		if (!list_empty(&stream->subrequests))
 			return false;
-		if (stream->transferred < transferred)
+		if (stream->transferred_valid &&
+		    stream->transferred < transferred) {
 			transferred = stream->transferred;
+			transferred_valid = true;
+		}
 	}
 
 	/* Okay, declare that all I/O is complete. */
-	wreq->transferred = transferred;
+	if (transferred_valid)
+		wreq->transferred = transferred;
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -118,12 +118,12 @@ struct netfs_io_request *netfs_create_wr
 	wreq->io_streams[0].prepare_write	= ictx->ops->prepare_write;
 	wreq->io_streams[0].issue_write		= ictx->ops->issue_write;
 	wreq->io_streams[0].collected_to	= start;
-	wreq->io_streams[0].transferred		= LONG_MAX;
+	wreq->io_streams[0].transferred		= 0;
 
 	wreq->io_streams[1].stream_nr		= 1;
 	wreq->io_streams[1].source		= NETFS_WRITE_TO_CACHE;
 	wreq->io_streams[1].collected_to	= start;
-	wreq->io_streams[1].transferred		= LONG_MAX;
+	wreq->io_streams[1].transferred		= 0;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	= true;
 		wreq->io_streams[1].active	= true;
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -739,6 +739,9 @@ iter_file_splice_write(struct pipe_inode
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
+		WARN_ONCE(ret > sd.total_len - left,
+			  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
+			  ret, sd.total_len, left);
 
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -150,6 +150,7 @@ struct netfs_io_stream {
 	bool			active;		/* T if stream is active */
 	bool			need_retry;	/* T if this stream needs retrying */
 	bool			failed;		/* T if this stream failed */
+	bool			transferred_valid; /* T is ->transferred is valid */
 };
 
 /*


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.16/netfs-fix-unbuffered-write-error-handling.patch

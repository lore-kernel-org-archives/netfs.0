Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9822A80D;
	Fri, 22 Aug 2025 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843945; cv=none; b=uKlw7VxJi+Usv0bw43lA/nG2DW9ECvhgKZYbF/oFqHcGRThPCg6LQsAUolU4Nlf8WfzwmCB1md7cknLptJjZ8JGhF5m+mdbg7BzjePO4GfYv4/T1wTYYpLSQZ0yUNey61N76tmY1HhLD5E9UbwVE8SUILsNdhfxSLTszTWz8ge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843945; c=relaxed/simple;
	bh=ktzLe1gjPYGXtP6/yGL+4CFkcYYlf02QmFHiN/LckE4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=AISH6bvCupP9MMvE893AnZDwn9X2vylSec2mOFv0IXn0LW4gft7tU8nruW49D+xzv4Vu6h+7fOS7pzwFtFdFoGHIQny4I7qS7FMOM88olEgRAU32KV9RWnB3TtidrPa41F6+G4wbVsfNXg7KhLFz4YlRr4UviKI00BAwdwsk4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHFHQeZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHFHQeZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39615C4CEF1;
	Fri, 22 Aug 2025 06:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755843945;
	bh=ktzLe1gjPYGXtP6/yGL+4CFkcYYlf02QmFHiN/LckE4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=nHFHQeZtt8k0Mc7dg+bzS3Rz22ns3uduRf05NibuJ3AcWPoZ1kpPFHHN33JOzZICT
	 EpqkJDCbAwJOjZafbk9mghI99Jx9HaWpqBrsDkgJHTo4lotc+++esJXfRCo404ZvQJ
	 W5yKGHjmbleUPoeilDiv56cOxFJG766b8Ak6fBEQ=
Subject: Patch "netfs: Fix unbuffered write error handling" has been added to the 6.12-stable tree
To: brauner@kernel.org,dhowells@redhat.com,fengxiaoli0714@gmail.com,gregkh@linuxfoundation.org,netfs@lists.linux.dev,pc@manguebit.org,sashal@kernel.org,sfrench@samba.org,sprasad@microsoft.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 08:24:48 +0200
In-Reply-To: <20250822030800.1054685-1-sashal@kernel.org>
Message-ID: <2025082248-grading-trial-e05b@gregkh>
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

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-unbuffered-write-error-handling.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-172251-greg=kroah.com@vger.kernel.org Fri Aug 22 05:09:26 2025
From: Sasha Levin <sashal@kernel.org>
Date: Thu, 21 Aug 2025 23:08:00 -0400
Subject: netfs: Fix unbuffered write error handling
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Xiaoli Feng <fengxiaoli0714@gmail.com>, Paulo Alcantara <pc@manguebit.org>, Steve French <sfrench@samba.org>, Shyam Prasad N <sprasad@microsoft.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Sasha Levin <sashal@kernel.org>
Message-ID: <20250822030800.1054685-1-sashal@kernel.org>

From: David Howells <dhowells@redhat.com>

[ Upstream commit a3de58b12ce074ec05b8741fa28d62ccb1070468 ]

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
[ Dropped read_collect.c hunk ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/write_collect.c |   10 ++++++++--
 fs/netfs/write_issue.c   |    4 ++--
 fs/splice.c              |    3 +++
 include/linux/netfs.h    |    1 +
 4 files changed, 14 insertions(+), 4 deletions(-)

--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -433,6 +433,7 @@ reassess_streams:
 			if (front->start + front->transferred > stream->collected_to) {
 				stream->collected_to = front->start + front->transferred;
 				stream->transferred = stream->collected_to - wreq->start;
+				stream->transferred_valid = true;
 				notes |= MADE_PROGRESS;
 			}
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
@@ -538,6 +539,7 @@ void netfs_write_collection_worker(struc
 	struct netfs_io_request *wreq = container_of(work, struct netfs_io_request, work);
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
+	bool transferred_valid = false;
 	int s;
 
 	_enter("R=%x", wreq->debug_id);
@@ -568,12 +570,16 @@ void netfs_write_collection_worker(struc
 			netfs_put_request(wreq, false, netfs_rreq_trace_put_work);
 			return;
 		}
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
@@ -115,12 +115,12 @@ struct netfs_io_request *netfs_create_wr
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
@@ -744,6 +744,9 @@ iter_file_splice_write(struct pipe_inode
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


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-6.12/btrfs-send-use-fallocate-for-hole-punching-with-send-stream-v2.patch
queue-6.12/usb-typec-fusb302-cache-pd-rx-state.patch
queue-6.12/btrfs-move-transaction-aborts-to-the-error-site-in-add_block_group_free_space.patch
queue-6.12/btrfs-send-avoid-path-allocation-for-the-current-inode-when-issuing-commands.patch
queue-6.12/btrfs-send-keep-the-current-inode-s-path-cached.patch
queue-6.12/btrfs-abort-transaction-on-unexpected-eb-generation-at-btrfs_copy_root.patch
queue-6.12/btrfs-always-abort-transaction-on-failure-to-add-block-group-to-free-space-tree.patch
queue-6.12/btrfs-zoned-requeue-to-unused-block-group-list-if-zone-finish-failed.patch
queue-6.12/btrfs-explicitly-ref-count-block_group-on-new_bgs-list.patch
queue-6.12/serial-8250-fix-panic-due-to-pslverr.patch
queue-6.12/xfs-fully-decouple-xfs_ibulk-flags-from-xfs_iwalk-flags.patch
queue-6.12/btrfs-qgroup-drop-unused-parameter-fs_info-from-__del_qgroup_rb.patch
queue-6.12/btrfs-send-make-fs_path_len-inline-and-constify-its-argument.patch
queue-6.12/netfs-fix-unbuffered-write-error-handling.patch
queue-6.12/usb-typec-use-str_enable_disable-like-helpers.patch
queue-6.12/btrfs-send-add-and-use-helper-to-rename-current-inode-when-processing-refs.patch
queue-6.12/btrfs-send-only-use-boolean-variables-at-process_recorded_refs.patch
queue-6.12/btrfs-qgroup-fix-race-between-quota-disable-and-quota-rescan-ioctl.patch
queue-6.12/btrfs-send-factor-out-common-logic-when-sending-xattrs.patch
queue-6.12/btrfs-codify-pattern-for-adding-block_group-to-bg_list.patch

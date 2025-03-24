Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE12638B1;
	Mon, 24 Mar 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833130; cv=none; b=IrTwDR5gOBfsz36vxX7jCh/7eRDiZwaiV+8TVL9K/7Z389GUg5Xbd/XAB0QxlWmdrgwTZov8L6cdyFY0eQLlPr5DWhxHCU/vRcPHXd9trvFzKNrp+j5WSWUcebZCizFKuMzFfR0jBFZXk3u6qrhVlmcg5ma6PLHlVrwApi0junM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833130; c=relaxed/simple;
	bh=3JtewHZLxetEGezPiOyN8pZ4BxTDGBa+EUF6CC0lDJ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fqwSECmCPG8EVDnNymWhrIT1SUeZVnn6AxgWmJzzl25MBv4EigTfoaY/clZ174S1W0zKhgTkCIEOkRlWe8sVc4OmJ7I5l2Tbmue3a3Yp+cwIowjVW2GN+XUMP8+jBPbTaL9I5YS/VBRWz72a8e5oLzzJCBcvMBywBtT8eHsXSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zT8ETZIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zT8ETZIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5EDC4CEE9;
	Mon, 24 Mar 2025 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742833129;
	bh=3JtewHZLxetEGezPiOyN8pZ4BxTDGBa+EUF6CC0lDJ8=;
	h=Subject:To:Cc:From:Date:From;
	b=zT8ETZICrMeMZZIoCIP7p50OBc9VMYlTNPIVLbUNxlK7OnX2af8XAMXIyXllL5avg
	 6vQywawSvzxEGrC3DeMMjGVORMntmyUs/QUucKmsSvDQQxo2v4vto+Nm2mBltdpYRT
	 1Fb8i0hHLPvGoQOrzxBthE8/OUOIj2OcXERX2tfQ=
Subject: Patch "netfs: Call `invalidate_cache` only if implemented" has been added to the 6.13-stable tree
To: brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,max.kellermann@ionos.com,netfs@lists.linux.dev,pc@manguebit.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 09:13:47 -0700
Message-ID: <2025032447-mortician-catalyze-76bd@gregkh>
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

    netfs: Call `invalidate_cache` only if implemented

to the 6.13-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-call-invalidate_cache-only-if-implemented.patch
and it can be found in the queue-6.13 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 344b7ef248f420ed4ba3a3539cb0a0fc18df9a6c Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Mar 2025 16:41:57 +0000
Subject: netfs: Call `invalidate_cache` only if implemented

From: Max Kellermann <max.kellermann@ionos.com>

commit 344b7ef248f420ed4ba3a3539cb0a0fc18df9a6c upstream.

Many filesystems such as NFS and Ceph do not implement the
`invalidate_cache` method.  On those filesystems, if writing to the
cache (`NETFS_WRITE_TO_CACHE`) fails for some reason, the kernel
crashes like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0010 [#1] SMP PTI
 CPU: 9 UID: 0 PID: 3380 Comm: kworker/u193:11 Not tainted 6.13.3-cm4all1-hp #437
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
 Workqueue: events_unbound netfs_write_collection_worker
 RIP: 0010:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0018:ffff9b86e2ca7dc0 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 7fffffffffffffff
 RDX: 0000000000000001 RSI: ffff89259d576a18 RDI: ffff89259d576900
 RBP: ffff89259d5769b0 R08: ffff9b86e2ca7d28 R09: 0000000000000002
 R10: ffff89258ceaca80 R11: 0000000000000001 R12: 0000000000000020
 R13: ffff893d158b9338 R14: ffff89259d576900 R15: ffff89259d5769b0
 FS:  0000000000000000(0000) GS:ffff893c9fa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffffd6 CR3: 000000054442e003 CR4: 00000000001706f0
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x15c/0x460
  ? try_to_wake_up+0x2d2/0x530
  ? exc_page_fault+0x5e/0x100
  ? asm_exc_page_fault+0x22/0x30
  netfs_write_collection_worker+0xe9f/0x12b0
  ? xs_poll_check_readable+0x3f/0x80
  ? xs_stream_data_receive_workfn+0x8d/0x110
  process_one_work+0x134/0x2d0
  worker_thread+0x299/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 CR2: 0000000000000000

This patch adds the missing `NULL` check.

Fixes: 0e0f2dfe880f ("netfs: Dispatch write requests to process a writeback slice")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20250314164201.1993231-3-dhowells@redhat.com
Acked-by: "Paulo Alcantara (Red Hat)" <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/write_collect.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -575,7 +575,8 @@ void netfs_write_collection_worker(struc
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
-	    wreq->io_streams[1].failed) {
+	    wreq->io_streams[1].failed &&
+	    ictx->ops->invalidate_cache) {
 		/* Cache write failure doesn't prevent writeback completion
 		 * unless we're in disconnected mode.
 		 */


Patches currently in stable-queue which might be from max.kellermann@ionos.com are

queue-6.13/netfs-call-invalidate_cache-only-if-implemented.patch

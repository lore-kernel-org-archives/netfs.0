Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0E2641C5;
	Fri, 14 Feb 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539823; cv=none; b=k40RYuY/DAII8f/l2EePrOQcD8xDsCu0TbHVUKfPxzM6pjChsbs6xq6zqQMwOS1q0aAYLYs1GCtmCiErHOQB2MCUsiTkucR4QAxSbtfbVxtOgPmpZOGMXPaSK6XT0G2FOds28kKadY1Qeqqsv/BrfiGsWr4VYRsPxX1cTSrayZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539823; c=relaxed/simple;
	bh=jtGJCzKnReRNa72dlgWJHgBYlhstzHJFNgs+ebNPTUo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=coXoQTRvVuM8NHvs+AcUG4U8qQ0M9y4lv0KWkG3xF7l+BtPeS6lNuHtS7xCToF5omJu9wT+/icpCVSNd0EubodadWa8pzGmaXvvYoThpfz3mHgrXZTxIRlMdbeoPFDRbxrO9X99PQPv7fwLgkri1kUUt+3ujEsX/FI+qjS03I+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYz65J75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYz65J75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97870C4CED1;
	Fri, 14 Feb 2025 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739539823;
	bh=jtGJCzKnReRNa72dlgWJHgBYlhstzHJFNgs+ebNPTUo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=KYz65J75RD+nJIHOg8gfdnMR4fyemM9w+5kBLtYJeDOjXQH5uFqLU7mDWG3unzJm8
	 YoW8jI2UAmzSYj6un9FHtYElEg3f2JtflNSoicprbKw+4qm9wy6NlnKgF2BdTMHzZY
	 tUajKP+AfFHxpChCBaKFbfDNqhvmp6YFxDHKAV3Q=
Subject: Patch "fs/netfs/read_pgpriv2: skip folio queues without `marks3`" has been added to the 6.13-stable tree
To: dhowells@redhat.com,gregkh@linuxfoundation.org,max.kellermann@ionos.com,netfs@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 14 Feb 2025 14:30:12 +0100
In-Reply-To: <20250210223144.3481766-1-max.kellermann@ionos.com>
Message-ID: <2025021411-village-lash-4680@gregkh>
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

    fs/netfs/read_pgpriv2: skip folio queues without `marks3`

to the 6.13-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fs-netfs-read_pgpriv2-skip-folio-queues-without-marks3.patch
and it can be found in the queue-6.13 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-114731-greg=kroah.com@vger.kernel.org Mon Feb 10 23:32:01 2025
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 10 Feb 2025 23:31:44 +0100
Subject: fs/netfs/read_pgpriv2: skip folio queues without `marks3`
To: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>, stable@vger.kernel.org
Message-ID: <20250210223144.3481766-1-max.kellermann@ionos.com>

From: Max Kellermann <max.kellermann@ionos.com>

[ Note this patch doesn't apply to v6.14 as it was obsoleted by commit
  e2d46f2ec332 ("netfs: Change the read result collector to only use one
  work item"). ]

At the beginning of the function, folio queues with marks3==0 are
skipped, but after that, the `marks3` field is ignored.  If one such
queue is found, `slot` is set to 64 (because `__ffs(0)==64`), leading
to a buffer overflow in the folioq_folio() call.  The resulting crash
may look like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP PTI
 CPU: 11 UID: 0 PID: 2909 Comm: kworker/u262:1 Not tainted 6.13.1-cm4all2-vm #415
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
 Workqueue: events_unbound netfs_read_termination_worker
 RIP: 0010:netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
 Code: 48 85 c0 48 89 44 24 08 0f 84 24 01 00 00 48 8b 80 40 01 00 00 48 8b 7c 24 08 f3 48 0f bc c0 89 44 24 18 89 c0 48 8b 74 c7 08 <48> 8b 06 48 c7 04 24 00 10 00 00 a8 40 74 10 0f b6 4e 40 b8 00 10
 RSP: 0018:ffffbbc440effe18 EFLAGS: 00010203
 RAX: 0000000000000040 RBX: ffff96f8fc034000 RCX: 0000000000000000
 RDX: 0000000000000040 RSI: 0000000000000000 RDI: ffff96f8fc036400
 RBP: 0000000000001000 R08: ffff96f9132bb400 R09: 0000000000001000
 R10: ffff96f8c1263c80 R11: 0000000000000003 R12: 0000000000001000
 R13: ffff96f8fb75ade8 R14: fffffaaf5ca90000 R15: ffff96f8fb75ad00
 FS:  0000000000000000(0000) GS:ffff9703cf0c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000010c9ca003 CR4: 00000000001706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x158/0x450
  ? search_extable+0x22/0x30
  ? netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
  ? search_module_extables+0xe/0x40
  ? exc_page_fault+0x62/0x120
  ? asm_exc_page_fault+0x22/0x30
  ? netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
  ? netfs_pgpriv2_write_to_the_cache+0xf6/0x3f0
  netfs_read_termination_worker+0x1f/0x60
  process_one_work+0x138/0x2d0
  worker_thread+0x2a5/0x3b0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_pgpriv2.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -181,16 +181,17 @@ void netfs_pgpriv2_write_to_the_cache(st
 			break;
 
 		folioq_unmark3(folioq, slot);
-		if (!folioq->marks3) {
+		while (!folioq->marks3) {
 			folioq = folioq->next;
 			if (!folioq)
-				break;
+				goto end_of_queue;
 		}
 
 		slot = __ffs(folioq->marks3);
 		folio = folioq_folio(folioq, slot);
 	}
 
+end_of_queue:
 	netfs_issue_write(wreq, &wreq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);


Patches currently in stable-queue which might be from max.kellermann@ionos.com are

queue-6.13/fs-netfs-read_collect-fix-crash-due-to-uninitialized-prev-variable.patch
queue-6.13/fs-netfs-read_pgpriv2-skip-folio-queues-without-marks3.patch

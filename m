Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91712AE74
	for <netfs@lists.linux.dev>; Fri,  1 Nov 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477849; cv=none; b=llGiEHzDiFn6Tw/q6HsnTx+73PmI78TX6Wv+PRsgIJM1B5CLKt799dkLqHsn8Ji4HjvfbNWJJxDj6xsFA+/o0KcjRhSg6Xp6sQdIXDQ0/R11KUD1xmiNbs7LqXZFpBwe4ULmXDKA5A0ijK1j9x0hyHjUQui1wuyYG1KcB+ihPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477849; c=relaxed/simple;
	bh=nVULbjv6YuyY1vxh4bylOrKcXpIYJ/H/W/m0DmtDfv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDfBAQi6d3RpYjLS3cZ8kJ3QtOucRW968s14AB0IL1SYPzETxvCaBR7+GlqHgwrX7s/iyL+vvq6l0Q5j/TPGL7k1jTTe/HTYul0gvBB4V7lu0PuEQIy8k079fQR6VeYhCoBMOlqnlD85cLzBvAp5vrSh0nMVQMvCL+zwmssrBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LExWvQe9; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LExWvQe9"
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:44a9:0:640:e314:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 6BFE7608F1;
	Fri,  1 Nov 2024 19:17:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EHfmWAQk9eA0-SczbkVso;
	Fri, 01 Nov 2024 19:17:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730477835; bh=r471h2znUy6Cq0dvv9Pq60BVTS4e7P8tgE8DwE4h6r8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LExWvQe9ab/ZAD+YwPrPGF5hiVWFGU5BRk/1zp7l72kYfTdbKy3whH/wOSHJZjRwZ
	 NtrvZ8Ufmrw9H+eC75/X4ajO/RoUuF/0Vc4cMJdmoqwmtrDWCqnyA3bVCxhNIaugZX
	 yEV2qM4UxwtEn52Jz5/Hs4NrBqI6tjMC6GE0434Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Subject: [PATCH] netfs: fix kernel BUG in iov_iter_revert()
Date: Fri,  1 Nov 2024 19:15:41 +0300
Message-ID: <20241101161541.346044-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following splat triggered by fault injection:

kernel BUG at lib/iov_iter.c:624!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5767 Comm: repro Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
RIP: 0010:iov_iter_revert+0x420/0x590
Code: 42 80 3c 20 00 48 8b 1c 24 74 08 48 89 df e8 17 07 43 fd 4c 89 2b e9 04 01 00 00 45 85 ed 48 8b 3c 24 75 16 e8 41 48 d9 fc 90 <0f> 0b 41 83 fd 05 48 8b 3c 24 0f 84 58 01 00 00 48 89 f8 48 c1 e8
RSP: 0018:ffffc90002f4f740 EFLAGS: 00010293
RAX: ffffffff84bba22f RBX: 000000000001e098 RCX: ffff888026309cc0
RDX: 0000000000000000 RSI: ffffffff8f098180 RDI: ffff888024f92df0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff84bb9f14
R10: 0000000000000004 R11: ffff888026309cc0 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888024f92de0 R15: fffffffffffe1f68
FS:  00007f2c11757600(0000) GS:ffff888062800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557cafd1eb48 CR3: 0000000024e1a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die_body+0x5f/0xb0
 ? die+0x9e/0xc0
 ? do_trap+0x15a/0x3a0
 ? iov_iter_revert+0x420/0x590
 ? do_error_trap+0x1dc/0x2c0
 ? iov_iter_revert+0x420/0x590
 ? __pfx_do_error_trap+0x10/0x10
 ? handle_invalid_op+0x34/0x40
 ? iov_iter_revert+0x420/0x590
 ? exc_invalid_op+0x38/0x50
 ? asm_exc_invalid_op+0x1a/0x20
 ? iov_iter_revert+0x104/0x590
 ? iov_iter_revert+0x41f/0x590
 ? iov_iter_revert+0x420/0x590
 netfs_reset_iter+0xce/0x130
 netfs_read_subreq_terminated+0x1fe/0xad0
 netfs_read_to_pagecache+0x628/0x900
 netfs_readahead+0x7e9/0x9d0
 ? __pfx_netfs_readahead+0x10/0x10
 ? blk_start_plug+0x70/0x1b0
 read_pages+0x180/0x840
 ? __pfx_read_pages+0x10/0x10
 ? filemap_add_folio+0x26d/0x650
 ? __pfx_filemap_add_folio+0x10/0x10
 ? rcu_read_lock_any_held+0xb7/0x160
 ? __pfx_rcu_read_lock_any_held+0x10/0x10
 ? __pfx_proc_fail_nth_write+0x10/0x10
 page_cache_ra_unbounded+0x774/0x8a0
 force_page_cache_ra+0x280/0x2f0
 generic_fadvise+0x522/0x830
 ? __pfx_generic_fadvise+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0x43d/0x780
 ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
 ? vfs_fadvise+0x99/0xc0
 __x64_sys_readahead+0x1ac/0x230
 do_syscall_64+0xf3/0x230
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c116736a9
Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc78181c88 EFLAGS: 00000246 ORIG_RAX: 00000000000000bb
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2c116736a9
RDX: 000800000000000d RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00000000004029d8 R08: 00007ffc78181658 R09: 00007f0038363735
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc78181cb0
R13: 00007ffc78181ec8 R14: 0000000000401120 R15: 00007f2c1178ca80
 </TASK>

This happens just because 'netfs_prepare_read_iterator()' may return
-ENOMEM (which is actually triggered by the fault injection) but such
a cases are not consistently handled in 'netfs_read_to_pagecache()'.
So introduce 'netfs_wrap_read_iterator()' to handle all possible
-ENOMEM cases and mark the corresponding subrequest as cancelled.

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/netfs/buffered_read.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index af46a598f4d7..706862094c49 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -174,6 +174,21 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 	return subreq->len;
 }
 
+/* Wrap the above by handling possible -ENOMEM and
+ * marking the corresponding subrequest as cancelled.
+ */
+static inline ssize_t netfs_wrap_read_iterator(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	ssize_t slice = netfs_prepare_read_iterator(subreq);
+
+	if (unlikely(slice < 0)) {
+		atomic_dec(&rreq->nr_outstanding);
+		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+	}
+	return slice;
+}
+
 static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rreq,
 						     struct netfs_io_subrequest *subreq,
 						     loff_t i_size)
@@ -284,10 +299,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 			}
 
-			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0) {
-				atomic_dec(&rreq->nr_outstanding);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+			slice = netfs_wrap_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
 				ret = slice;
 				break;
 			}
@@ -301,7 +314,11 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			subreq->source = NETFS_FILL_WITH_ZEROES;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
-			slice = netfs_prepare_read_iterator(subreq);
+			slice = netfs_wrap_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
@@ -309,7 +326,11 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 
 		if (source == NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-			slice = netfs_prepare_read_iterator(subreq);
+			slice = netfs_wrap_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}
-- 
2.47.0


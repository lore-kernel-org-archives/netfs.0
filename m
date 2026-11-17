Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920498;
	b=wmkPjvkd6oa0/egK8PB9xNgyzP9CZ+UUIs8JC+yEXqcaoW6OAljhDJ1EKuD1RMl6Ndni
	 eXq3+t6rBrhjRGRjnv8KFOyBKZQuvG8QbdrYgz+QKnbVF4TZ0jnxIla3Tl5o3owVFtYs3
	 Y0wyqgQlxaCgisHu6DrXtyGyqts9g8KrJqb2EkTFqvbbREi59cke+T7n+AwpZq+AF1I5B
	 H/TukkU1P9aLAqyZt+n2XxAvN2VdTpWhH42KWgZbkP00XfHOENslHj0wuPtUqJsy2bJWA
	 pbz1f3oWLtQIwDMu3yV79T4U8auX+uYuok//MNEkR6abK4d26WgdvSCkzCvxdlQ3tCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920498;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=C1KvfIlmYLhRC6mILExamhcqe0Ob4HfESY9lTwphRSs=;
	b=zv6RHB+G/bdmIsoPTF5Bdg4iaKJTRc+97Cz+r4UvDweXJU+jrPQDo3ywGjdIIKuAxSTK
	 E7K72e1vm+YtDdYIUUMnJcHcWeDU9e42v7B0BJK0wMWxyHmv3nlttIpYKwrh/HTNOkmtH
	 GWMLuCuexNkNpxNVN2zOWKRJ54tNSuzOO7UCecsgzxCsStRNSEjW41INa1CZ6iWcxTpFk
	 kRX+DqIGlsXdXZrekZ9GIJDtkwWrhMa0BsqUoVHVa6Jw6m9bMS8Wv+7hTvJFA6Mpv/9OQ
	 jtB4wFhUhwLa6bYyE9WOCKQ5TETEvh8e70tOCo6D4HsFMl8bsGLP12mmNoHwf5fRyqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78647606A337
	for <netfs@lists.linux.dev>; Tue, 17 Nov 2026 13:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78647606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-862ab20625eso1366418a34.2
        for <netfs@lists.linux.dev>; Tue, 17 Nov 2026 05:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920497; x=1795525297;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1KvfIlmYLhRC6mILExamhcqe0Ob4HfESY9lTwphRSs=;
        b=ZqMc5hBOxm+/oTEAleR3Xl8gxfCw4hzk8d/weKakhiaBPal1x+D5uIzYgAhbrlikHp
         9hn9VAz5lCQu7Wzh5UtJiX0dIy2IG2QbsgfddQv2rYqETf1r8nnZGLmtQ51EebSDWVrp
         d+2yhIS2FcQGeo+Bt2FOIalCgmODWXPAfAXfBJGPmSwAcRrwTaGYm7qZTR5YgNgOywDh
         uWIfSxMEbzfpdWBc+D+mmvfYnG4pNnrQQg4FyZmzNZvQWnWOIjPz/Y/mFebqUMLcNdnv
         Wka49c5q7LamxUPA/FR8wx7KzpdnzPhB2xyc1i/BQJ4JlcjTHTlWTyE0JoIH8ySwjXcm
         EqUQ==
X-Forwarded-Encrypted: i=1; AL+hErGhfRQmKrNsjLe9dGoVlyJHxFMOKgHrYA/0In64gFtPLZGwV4oZ1C2ov8/XEOthGhrvqjLlZQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9pcCIkvKSJMlloZJbKfzzRgYcKgTSh2UT261uKjCLfxUCBowcF
	qvYxQvZHL9lV4c1iOIOny4HOvg5/44JWUBbUf0cq8KeddmDXAVboOowiOog1CsgoEnmOo+4Fdx+
	8gNmZffByord8U24d1Uikm2OTBg/pFRk/5DLgfC7CeEcLEVCvy7zfzinpwxY=
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14d2:b0:568:39f2:1254 with SMTP id
 5614622812f47-56e64dfaba9mr11653354b6e.47.1794920497369; Tue, 17 Nov 2026
 05:01:37 -0800 (PST)
Date: Tue, 17 Nov 2026 05:01:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afc5031.8f566acc.2517be.0001.GAE@google.com>
Subject: [syzbot] [netfs?] possible deadlock in vfs_iocb_iter_write
From: syzbot <syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aebb72744764 Linux 7.4-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14046dad580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cc6a7ee2d24d208
dashboard link: https://syzkaller.appspot.com/bug?extid=deb8af81d91415fabac1
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-aebb7274.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/89dc91c65baa/vmlinux-aebb7274.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ada32ef78ae3/bzImage-aebb7274.xz

The issue was bisected by AI to candidate commits (most relevant first):

e044374a8a0a ima: annotate iint mutex to avoid lockdep false positive warnings
80105ed2fd27 9p: Use netfslib read/write_iter
0d73a55208e9 ima: re-introduce own integrity cache lock
46ed60dcd4f2 netfs: Implement unbuffered/DIO vs buffered I/O locking
047487c947e8 cachefiles: Implement the I/O routines

AI reasoning:   https://syzkaller.appspot.com/ai_job?id=e6954bda-cd55-46d8-bb68-67259c9bb743

AI-generated root cause summary:
In `security/integrity/ima/ima_iint.c`, `ima_iint_lockdep_annotate()` assigns
`iint->mutex` to a static lockdep class array
`ima_iint_mutex_key[IMA_MAX_NESTING]` indexed solely by
`inode->i_sb->s_stack_depth`. When a network filesystem using netfs/fscache
(such as 9p) caches data on a local backing filesystem (such as XFS via
cachefiles), both filesystems have `s_stack_depth == 0`, causing their
`iint->mutex` instances to share the same lockdep key `ima_iint_mutex_key[0]`.
This collapses distinct locking tiers into one class, causing lockdep to flag a
false circular locking dependency among `sb_writers` (acquired during
`do_open(O_TRUNC)`), `ima_iint_mutex_key[0]`, and `inode->i_rwsem` (acquired
during `netfs_buffered_read_iter()` when IMA measures a file).

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=deb8af81d91415fabac1

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.0/5351 is trying to acquire lock:
ffff88804421c478 (sb_writers#12){.+.+}-{0:0}, at: kiocb_start_write include/linux/fs.h:2799 [inline]
ffff88804421c478 (sb_writers#12){.+.+}-{0:0}, at: vfs_iocb_iter_write+0x1cb/0x5e0 fs/read_write.c:929

but task is already holding lock:
ffff888047183c00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
ffff888047183c00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: do_truncate+0x18f/0x250 fs/open.c:63

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#25){++++}-{4:4}:
       down_read_interruptible+0x4b/0x3b0 kernel/locking/rwsem.c:1584
       netfs_start_io_read+0x25/0x180 fs/netfs/locking.c:67
       netfs_buffered_read_iter+0xd6/0x160 fs/netfs/buffered_read.c:940
       __kernel_read+0x4ca/0x960 fs/read_write.c:512
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
       ima_calc_file_hash+0x451/0x890 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x51b/0xa00 security/integrity/ima/ima_api.c:300
       process_measurement+0x1272/0x1c10 security/integrity/ima/ima_main.c:425
       ima_file_check+0xdc/0x130 security/integrity/ima/ima_main.c:686
       security_file_post_open+0xb3/0x260 security/security.c:2777
       do_open fs/namei.c:4853 [inline]
       path_openat+0x1748/0x20f0 fs/namei.c:5016
       do_file_open+0x23e/0x4a0 fs/namei.c:5045
       do_sys_openat2+0x115/0x200 fs/open.c:1443
       do_sys_open fs/open.c:1449 [inline]
       __do_sys_openat fs/open.c:1465 [inline]
       __se_sys_openat fs/open.c:1460 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1460
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       process_measurement+0x7d0/0x1c10 security/integrity/ima/ima_main.c:319
       ima_file_check+0xdc/0x130 security/integrity/ima/ima_main.c:686
       security_file_post_open+0xb3/0x260 security/security.c:2777
       do_open fs/namei.c:4853 [inline]
       path_openat+0x1748/0x20f0 fs/namei.c:5016
       do_file_open+0x23e/0x4a0 fs/namei.c:5045
       do_sys_openat2+0x115/0x200 fs/open.c:1443
       do_sys_open fs/open.c:1449 [inline]
       __do_sys_openat fs/open.c:1465 [inline]
       __se_sys_openat fs/open.c:1460 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1460
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#12){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write+0x48/0x1c0 include/linux/fs/super.h:125
       kiocb_start_write include/linux/fs.h:2799 [inline]
       vfs_iocb_iter_write+0x1cb/0x5e0 fs/read_write.c:929
       __cachefiles_write+0x6c9/0xbd0 fs/cachefiles/io.c:355
       netfs_issue_write fs/netfs/write_issue.c:290 [inline]
       netfs_advance_write+0x328/0x4b0 fs/netfs/write_issue.c:331
       netfs_write_folio fs/netfs/write_issue.c:510 [inline]
       netfs_writepages+0x12d3/0x22b0 fs/netfs/write_issue.c:600
       do_writepages+0x338/0x560 mm/page-writeback.c:2562
       filemap_writeback mm/filemap.c:386 [inline]
       filemap_fdatawrite_range mm/filemap.c:411 [inline]
       filemap_fdatawrite+0x1e9/0x2f0 mm/filemap.c:417
       v9fs_vfs_setattr_dotl+0x4dc/0xab0 fs/9p/vfs_inode_dotl.c:585
       notify_change+0xbba/0xea0 fs/attr.c:556
       do_truncate+0x1c2/0x250 fs/open.c:68
       handle_truncate fs/namei.c:4306 [inline]
       do_open fs/namei.c:4855 [inline]
       path_openat+0x18a6/0x20f0 fs/namei.c:5016
       do_file_open+0x23e/0x4a0 fs/namei.c:5045
       do_sys_openat2+0x115/0x200 fs/open.c:1443
       do_sys_open fs/open.c:1449 [inline]
       __do_sys_openat fs/open.c:1465 [inline]
       __se_sys_openat fs/open.c:1460 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1460
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_writers#12 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_key#25

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#25);
                               lock(&ima_iint_mutex_key[depth]);
                               lock(&sb->s_type->i_mutex_key#25);
  rlock(sb_writers#12);

 *** DEADLOCK ***

locks held by syz.0.0/5351: 2, on CPU#0:
 #0: ffff888042230478 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:531
 #1: ffff888047183c00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
 #1: ffff888047183c00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: do_truncate+0x18f/0x250 fs/open.c:63

stack backtrace:
CPU: 0 UID: 0 PID: 5351 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_write+0x48/0x1c0 include/linux/fs/super.h:125
 kiocb_start_write include/linux/fs.h:2799 [inline]
 vfs_iocb_iter_write+0x1cb/0x5e0 fs/read_write.c:929
 __cachefiles_write+0x6c9/0xbd0 fs/cachefiles/io.c:355
 netfs_issue_write fs/netfs/write_issue.c:290 [inline]
 netfs_advance_write+0x328/0x4b0 fs/netfs/write_issue.c:331
 netfs_write_folio fs/netfs/write_issue.c:510 [inline]
 netfs_writepages+0x12d3/0x22b0 fs/netfs/write_issue.c:600
 do_writepages+0x338/0x560 mm/page-writeback.c:2562
 filemap_writeback mm/filemap.c:386 [inline]
 filemap_fdatawrite_range mm/filemap.c:411 [inline]
 filemap_fdatawrite+0x1e9/0x2f0 mm/filemap.c:417
 v9fs_vfs_setattr_dotl+0x4dc/0xab0 fs/9p/vfs_inode_dotl.c:585
 notify_change+0xbba/0xea0 fs/attr.c:556
 do_truncate+0x1c2/0x250 fs/open.c:68
 handle_truncate fs/namei.c:4306 [inline]
 do_open fs/namei.c:4855 [inline]
 path_openat+0x18a6/0x20f0 fs/namei.c:5016
 do_file_open+0x23e/0x4a0 fs/namei.c:5045
 do_sys_openat2+0x115/0x200 fs/open.c:1443
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae7e7a94d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae7f5b4fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fae7ea25fa0 RCX: 00007fae7e7a94d9
RDX: 0000000000000300 RSI: 000020000001cac0 RDI: 0000000000000009
RBP: 00007fae7e83804e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae7ea26038 R14: 00007fae7ea25fa0 R15: 00007ffedf7b33b8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about AI bisection see: https://goo.gl/tpsmEJ#ai-bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

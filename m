Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401528;
	b=ls39vZCWrPZmPwOS4eNfJWCODyFWMgHMAVhmYYikrttb3W5ZBs3uaExSz2l0lbUAHEKG
	 m2FFaXUhF1DegpPxxO6sDDuQkuKXsGXCPPLtGz6noRG1ITksuf3RmCJTNzdPViIzFvT3+
	 09PbCOEqmANQHhDVLw1JWGSWsq+lOqxSQnfWUgIaQ3rh9dIExW2AUTXRxOaZZ4A7M0Jmf
	 QJ0dwb+EWP5N2j7jDlumc5vg5yUyZz1inKLrFyNRp7SDKLynZclrFXQ0czB3rWhx+bkGl
	 k4had3VlKEIDTv09uBZghm4Sz0FWIQww3k6mHWp4ewSNfXZYtlFQzOgp3UNZ9S7VuQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401528;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=r+NOcmmbW7rtw5ts41xsWNc/iGPBCitC+rKmnfKq7Cs=;
	b=odtYoDcnj2sWbXeJdOr5M6DJx+Lx/jgt9Oufob4nfyVike5JVxm225tewPqDXxJxG+G0
	 00s05/qti/dC94Za0/KuMyhj9v84XH0LdFHbzZyKKBMwGZi7m4V2UWa7xWibNaWcVaGd5
	 1s3W9aYhsE+SDjE85ztZqLYNec3KlSm9seUsWCc58pN3PaixvyAUF24XwOlW8bblfRJO6
	 1qfRH6RZByiP3AUjlK2BLUDbY20VZRzN3v0TnoCm5Gy5eJzuLDkS9fxF+H4PB5Z8o2biR
	 Rd/FT8bG6INl95sqOFezsjloGWPOEJ6C3oypYDcl9UffifM5yo1WYbkWRJjbRJmtfCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55B606A31A
	for <netfs@lists.linux.dev>; Mon, 23 Nov 2026 02:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E55B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cbf700ddccso2138340b6e.0
        for <netfs@lists.linux.dev>; Sun, 22 Nov 2026 18:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795401527; x=1796006327;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r+NOcmmbW7rtw5ts41xsWNc/iGPBCitC+rKmnfKq7Cs=;
        b=vRwctEyUIcEbMtyLk2lL29mjv1aBt1aJeInGfsaEp0DG8ytW351GxgarLw5WCmfcCk
         YxpTHfaUlZn5OWDA6x6ib1SyoEL7UHMYca+FBYS8461Ukx4DHdOmFYy9A6MNo0BajPOX
         e/bx0eCcL72gbsxfkC1pIemI7sKFhx0dGY1+EQzxlSmcDRbdYaCL1zAxGkJF4FDSqoyA
         +g/WERWUUAlCpPuEba9dHv2dZXbL45MBzMaUMGwosOEgw52y/p/uxYrCiwS9qbD5/bxv
         uaYIvs8XxNX1D7euTQGoHjEtjUnOOm9P0nViQM7wG7ZjI3lEhC4t5IpymkiOD3BKn8yE
         qBPw==
X-Forwarded-Encrypted: i=1; AL+hErFftJiSNT5zASQLWMZMuzJSNbJsEmRPi92xtbifJ6Ix4jr+mAor187/n0As2IourDAAW0CC1g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+kRkK/Wg0TX/MjbJbd0C0nR7s3x58Ix1jl7RmyF/rmqtmVuBn5
	c/agjPEXj0IlX0WpIKH6L7mw2vPpOLeaWN3UBoast0EPsNONbfS6PUOPpmNaFyZt9jNCA4V3iY3
	JmgJkZYLbXHxnE2+zmCTy8ZU+d1rSnw762V2Rbag0J0/5DTmK9z54IPdZ0Kg=
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:244e:b0:568:c71:5338 with SMTP id
 5614622812f47-57a0a10954bmr9734535b6e.18.1795401527348; Sun, 22 Nov 2026
 18:38:47 -0800 (PST)
Date: Sun, 22 Nov 2026 18:38:47 -0800
In-Reply-To: <6afc5031.8f566acc.2517be.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b03a737.44b41460.34b83f.0025.GAE@google.com>
Subject: Re: [syzbot] [netfs?] possible deadlock in vfs_iocb_iter_write
From: syzbot <syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com>
To: dhowells@redhat.com, dmitry.kasatkin@gmail.com, dmitry.kasatkin@huawei.com, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4843f6873f7c Merge tag 'sysctl-7.04-fixes-rc4' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ee66bd580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cc6a7ee2d24d208
dashboard link: https://syzkaller.appspot.com/bug?extid=deb8af81d91415fabac1
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1118446d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c512bc580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98fce4d0b21b/non_bootable_disk-4843f687.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86db8b334894/vmlinux-4843f687.xz
kernel image: https://storage.googleapis.com/syzbot-assets/94ea4dad441a/bzImage-4843f687.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/b2622425ced2/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13c512bc580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/0089353ceb53/mount_8.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16ee66bd580000)

The issue was bisected by AI to:

commit 0d73a55208e94fc9fb6deaeea61438cd3280d4c0
Author: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Tue Dec 5 19:06:34 2017 +0000

    ima: re-introduce own integrity cache lock

AI reasoning:   https://syzkaller.appspot.com/ai_job?id=1dffa081-8679-4b43-b77c-809761df2cb7

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

The cause commit was identified by AI and may be wrong.
If you agree with it, please also add:
Fixes: 0d73a55208e9 ("ima: re-introduce own integrity cache lock")

XFS (loop0): Ending clean mount
netfs: Cache "CacheFiles" added (type cachefiles)
CacheFiles: File cache on CacheFiles registered
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.18/5600 is trying to acquire lock:
ffff888014340478 (sb_writers#12){.+.+}-{0:0}, at: kiocb_start_write include/linux/fs.h:2799 [inline]
ffff888014340478 (sb_writers#12){.+.+}-{0:0}, at: vfs_iocb_iter_write+0x1cb/0x5e0 fs/read_write.c:929

but task is already holding lock:
ffff88804381b620 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
ffff88804381b620 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: do_truncate+0x18f/0x250 fs/open.c:63

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

locks held by syz.0.18/5600: 2, on CPU#0:
 #0: ffff888043d40478 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:531
 #1: ffff88804381b620 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
 #1: ffff88804381b620 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: do_truncate+0x18f/0x250 fs/open.c:63

stack backtrace:
CPU: 0 UID: 0 PID: 5600 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
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
RIP: 0033:0x7f7db21a9559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7db17fe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f7db2425fa0 RCX: 00007f7db21a9559
RDX: 0000000000000300 RSI: 0000200000009b80 RDI: 0000000000000005
RBP: 00007f7db2238136 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7db2426038 R14: 00007f7db2425fa0 R15: 00007fff21afb1f8
 </TASK>

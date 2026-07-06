Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7B47DD4E
	for <netfs@lists.linux.dev>; Mon,  6 Jul 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374261; cv=none; b=P7HrlBCedKNEB+Dlp2Ce66kh6wen4rG7VGnxtoNtip0KTSyMnYq2UOFAf61DRgb43zAiq7j7c/YpDz58eonvZDwm97qDXlzMob549y98ONQfSD1yMFJXVteJ9oPKQx6MXdnHElWdjXlX/K/XcF58l/qJ0iLRFsZsiBsUBL2HC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374261; c=relaxed/simple;
	bh=e1SF7iWuEYA7wT1vRotUpCtzMz+9DM8Fel8wN4Y9PmI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UC8Iwszq/O9Z0MUB3sGJWCxFScuFdc0uLr83lXnQLW/v1ILprDwFHnmgmkET5wVAckOEgdPFC3MN6mg7nI6d82Os6u/IvOyWrRrMEG9YeEun8ZR/evrPONlEN/YmDh01pybl57UJj2W0IaNJJnIue/SpgWMZHGdbKVnM0hTzlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6a0e3320c53so4127205eaf.0
        for <netfs@lists.linux.dev>; Mon, 06 Jul 2026 14:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374259; x=1783979059;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvmabBm/M9qkJJFMc6B6+g0RDsgWnVpyxWpzSORwHSo=;
        b=Rrc23W1CCKg9VWaAxQXI4RZbI24UoSVS6ogZksoqvwC0e/ckvKFwkTGLu+6i3JOLBa
         AF68hqn03nSxpq6R3epWBXbNnr3vVqjcNPtxtQ8/YKhz5hmlHnjX2J7SbcneXRiam2Sf
         9qcBLy0FoTWHtSEXKYioeNNhW3i8LNRx9x9c09KqdjoD4c7zSIpCf/aFb9L6t/Ohikjz
         ok847frHwfTE0EpPNPDh2sCKt8fRM+u467SqXhLHPafpS5Z9z8JzveNmi2ciYlsccjq/
         T4Y7Q9KpYtjqeZ025G7CF9cijvZ5MzHg7Zz/YoQnmstdzicoHQfdQPr9p9mQ3NcOj4bH
         zAaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mHBLgGU/NGngk5BoybcW8sZQO7uBej4gqPQp25IyZJT+NpsJ69/Vcq/ZdazCqquib544Qhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo0bdcLKRIb3BIw+k5rF2rbjGTUzGEJO8W0m0g6TVSy+jaM5SM
	BYMRGAyzDmnebS+SAiUJ61BNsM8kfn9PxrO9z/ZF8fCSawWbsZXcR4ec4jh+isGhgj032pvYGet
	Cyv7H1CfPbin0Ovy07Klz+Wl5yoWFGlMnE+V1uzlwv09MkBSpRXL7Bky89dM=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1797:b0:6a1:50e9:d586 with SMTP id
 006d021491bc7-6a35556394fmr1504720eaf.67.1783374259504; Mon, 06 Jul 2026
 14:44:19 -0700 (PDT)
Date: Mon, 06 Jul 2026 14:44:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
Subject: [syzbot] [netfs?] WARNING in netfs_writepages (3)
From: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7404ce516372 Merge tag 's390-7.2-3' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119f1661580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1727ebde580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172dbec1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-7404ce51.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e63433d84892/vmlinux-7404ce51.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7542fae0615e/bzImage-7404ce51.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com

R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fe029a25fac R14: 00007fe029a25fa0 R15: 00007fe029a25fa0
 </TASK>
------------[ cut here ]------------
folio != NULL
WARNING: fs/netfs/write_issue.c:603 at netfs_writepages+0x883/0xa10 fs/netfs/write_issue.c:603, CPU#3: syz.0.17/5919
Modules linked in:
CPU: 3 UID: 0 PID: 5919 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:netfs_writepages+0x883/0xa10 fs/netfs/write_issue.c:603
Code: 48 89 df e8 3f 8b 7b ff 48 8b 4c 24 08 48 89 da 4c 89 e6 4c 89 f7 e8 ec 34 7f ff 48 85 c0 0f 84 c1 fe ff ff e8 0e c7 3d ff 90 <0f> 0b 90 e9 b3 fe ff ff e8 00 c7 3d ff 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000415f178 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00014f2580 RCX: ffffffff824b4bda
RDX: ffff88802bcea540 RSI: ffffffff82cc0992 RDI: ffff88802bcea540
RBP: fffffffffffffff4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000415f348
R13: ffff888046848bc0 R14: ffff888046848dd8 R15: dffffc0000000000
FS:  0000555567857500(0000) GS:ffff8880d60ec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002901 CR3: 0000000025ac6000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 do_writepages+0x278/0x600 mm/page-writeback.c:2571
 filemap_writeback+0x22d/0x2e0 mm/filemap.c:387
 v9fs_mmap_vm_close fs/9p/vfs_file.c:496 [inline]
 v9fs_mmap_vm_close+0x137/0x1e0 fs/9p/vfs_file.c:489
 vma_close mm/internal.h:190 [inline]
 vms_clean_up_area mm/vma.c:1318 [inline]
 __mmap_setup mm/vma.c:2476 [inline]
 __mmap_region+0x890/0x2db0 mm/vma.c:2756
 mmap_region+0x527/0x620 mm/vma.c:2860
 do_mmap+0xc63/0x12f0 mm/mmap.c:560
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:581
 ksys_mmap_pgoff+0x3cb/0x610 mm/mmap.c:606
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe02979de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3ad0a858 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fe029a25fa0 RCX: 00007fe02979de59
RDX: 0000000000000002 RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 00007fff3ad0a8c0 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fe029a25fac R14: 00007fe029a25fa0 R15: 00007fe029a25fa0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

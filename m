Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2E371050
	for <netfs@lists.linux.dev>; Fri,  6 Mar 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778981; cv=none; b=NemZNG6kR3LcLjgrDI6r0aQqLM0X5mCUA/3tcr3RqZOMZYvhodw3Tja0UFOj1mXU0z+7S9Jmr4toJMmHjoMEYZDDwVTOjMijCfc6/jlVEwZLCgGjSZMWmfX8K708B9sJeTDQPZR0nH16+UyrUKJAwbD0Tjq7Em86WgP0N31ku94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778981; c=relaxed/simple;
	bh=vNum4srGc5ORMInpONutwPrC4E9EEdH+0lnajRvuj9w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M8JOMxpFu5oY+XkQmdyijbeQUoOij67i+EqzgSUO6Cm6J9vdf5zIK13+hzmPUjOtlS3wiYYkoPCRax8WNVCfVUCKgYCHeotc473XwdOeLlIzx5xQoLdu4xNEfJF79jNO3dXKB3lgoLyWCsi68Sa7Xj1194NI7rMYAtPJoK9OXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679862e4413so135786352eaf.0
        for <netfs@lists.linux.dev>; Thu, 05 Mar 2026 22:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778979; x=1773383779;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJ64YFn8UUA1y2uPrXf95iWTGshR2gj7Q9p2jyzHyL4=;
        b=o02S4rA1h284bwbi6fkXhN8lSPu6bULeoEZVu252aGiKH85O6/aqAOf98se96cdNDJ
         o0q4eI/HVt/N+StKuRx8k/qEc+3TMOXRMf5eSYgmjpd8XLlL+sOA696g+jEywpqIMonh
         muarZvrc/+p8iV8zwUXOEAf6RtZRFNQKmczkd1vknYX9ko/ReNToCDJh6xu78c60J3F7
         E6SdU856+ZopJA0fuIYEO3sGYUKNK7bHtQLs61Cn0gnSbSFj8f/Be+92PDwE5mdgsNtz
         oE5GyyJnkOQyKOrChtimBwcrI+ED/FStlXXXOBwwHW7xOs1FFSVvuazHzgJRf2ejtZ7S
         +Nug==
X-Forwarded-Encrypted: i=1; AJvYcCUng6Y1Vxq0kTMPBXbQH7DbSk/1yv0vuoB1POsdR5XIFcBF1cmydHcMXcLpCKRxgzDpZjKXEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEkRl2oioarDkytxpzYf8R9qKkA/g6jSuWOyVgtF1QTiX5qgHu
	DlRppJVjMmLcBG2gL0y7J5PBxXjepccRwlUHaLDxuFwnnxouvngRBkUgNUq0aP5mhIcwiAc5QZZ
	eVW760wnwfiR85sw+e+qyW58QoKeTYuXrp206SpXev6ogGd4kGPJlH+c03WM=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81cb:b0:679:f11b:a511 with SMTP id
 006d021491bc7-67b9bd1690dmr825645eaf.45.1772778978939; Thu, 05 Mar 2026
 22:36:18 -0800 (PST)
Date: Thu, 05 Mar 2026 22:36:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69aa75e2.050a0220.13f275.0010.GAE@google.com>
Subject: [syzbot] [netfs?] BUG: unable to handle kernel NULL pointer
 dereference in netfs_unbuffered_write
From: syzbot <syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c107785c7e8d Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15db7b5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1628ab5a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a5414a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c107785c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a4a4abcd973/vmlinux-c107785c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f60667f16840/bzImage-c107785c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com

netfs: Couldn't get user pages (rc=-14)
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 31867067 P4D 31867067 PUD 0 
Oops: Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003b7fb90 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88803bd3a5b0 RCX: ffffffff82c49d0a
RDX: ffff88802b9ca4c0 RSI: ffffffff82c49b9c RDI: ffff88803bd3a500
RBP: 0000000000140000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88803bd3a598
R13: dffffc0000000000 R14: ffff88803bd3a500 R15: ffff888023066580
FS:  00007f9e9a09f6c0(0000) GS:ffff8880d6644000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002c65b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 netfs_unbuffered_write+0xae5/0x2080 fs/netfs/direct_write.c:189
 netfs_unbuffered_write_iter_locked+0x801/0xab0 fs/netfs/direct_write.c:287
 netfs_unbuffered_write_iter+0x40c/0x710 fs/netfs/direct_write.c:377
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e9919c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e9a09f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9e99415fa0 RCX: 00007f9e9919c799
RDX: 000000000208e24b RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f9e99232bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9e99416038 R14: 00007f9e99415fa0 R15: 00007fff05034208
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003b7fb90 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88803bd3a5b0 RCX: ffffffff82c49d0a
RDX: ffff88802b9ca4c0 RSI: ffffffff82c49b9c RDI: ffff88803bd3a500
RBP: 0000000000140000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88803bd3a598
R13: dffffc0000000000 R14: ffff88803bd3a500 R15: ffff888023066580
FS:  00007f9e9a09f6c0(0000) GS:ffff8880d6644000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002c65b000 CR4: 0000000000352ef0


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

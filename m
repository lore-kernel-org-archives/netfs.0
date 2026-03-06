Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296A368284
	for <netfs@lists.linux.dev>; Fri,  6 Mar 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778981; cv=none; b=VbIhB+cDdDDcMJI/Z1v5ZY4BFuVwSYGbvP9nbsk2nI594mltPVXh0u4uM5W3ihz2cnYjys8SNbVjM3fJUyLufpZKAGU1+C4g4tw0MiRE9KM1QeT7rtaMhBqSiNNgecEZHDXlSATVOqUiyyIa2doyrmjo3L9EnWJgAbdHUQQ/A5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778981; c=relaxed/simple;
	bh=vOFWcD9VgS+J2CrjRSLI6m6RzJjvI4JzAWbvcLw4kfw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=koNFrZEw6Mqo9bY4rC4jZrqym8OlAbUXdklI3qRA8MQP5S9IRZQTFTZAxjsYnpIBBK5zHRfVGOaZaGd3osz8JlveBrKmZgKIEtEA2Ss920LLKponYbXhZ8ikF5brvLWtorEorCM0lluoPhLp7YGLoOrenr/Qejf05xiAXQZe5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679dda090fbso151536533eaf.2
        for <netfs@lists.linux.dev>; Thu, 05 Mar 2026 22:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778979; x=1773383779;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjCUsjN0/IVVP3mFuyWfmY85swmEI0tCp3uwii5R7sU=;
        b=p3Jyfa3Zy+oDD2hd/aCTHaV6aXLhlW/32TdRr1GRvwJ6aZ2h/nJRxTSx64YWXn3sL0
         Z2IyQOf33LXb/Xs01mj20PIyiQMzDH37vmyL1CYL2eX1atK7ZRC2SNqUPtx4CyD+jWgK
         kqHjtent/yEXFBglTGUiKG5WkfxKj3J02IEiVhGYfkvBvIi3e9msgIWKjEZ/lPRtSs0T
         5h4+64+OujeEwBQdfrSD9bbwYzbFx3QrBaJY0PxTCk0QPdcIzexdzocy7t6RtzkDXqTX
         XiKYeh9tj+5B4q5T8dLtY/Ch79tdqzUv+Y7tvEGrYnxDkqqyYHZEeNazeg0SEyFGsHv0
         tO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEEd4ke35jGaqURDRjeJd6vqola5yRf9OfvWtG08VHGeOTRGQpZjIzg2Ec6n+P9Mhx/O4/Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFKw8DE82wU4qQ04j2HEoOTWrdQIk+xyCOCej6SpfaG+CVtdIh
	dUXTcZ57iBj9G28CpPOLHI5zCusTY3Ugj7cF+/rcExoAMkc71nwzwQuLlkP99JDtWngM9JbPEdV
	FRCbkDpqDCCKxS/9+EpDgvWXMhmG8ubFl//nxTKDdmcHxYMx1aFLwqidHCfM=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1607:b0:663:40d:4893 with SMTP id
 006d021491bc7-67b9bc4f053mr834261eaf.3.1772778978736; Thu, 05 Mar 2026
 22:36:18 -0800 (PST)
Date: Thu, 05 Mar 2026 22:36:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69aa75e2.050a0220.13f275.000f.GAE@google.com>
Subject: [syzbot] [netfs?] kernel BUG in netfs_limit_iter
From: syzbot <syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c107785c7e8d Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d408ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16421552580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166a97e6580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c107785c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a4a4abcd973/vmlinux-c107785c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f60667f16840/bzImage-c107785c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/netfs/iterator.c:248!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 6437 Comm: syz.9.39 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:netfs_limit_iter+0x100d/0x1100 fs/netfs/iterator.c:248
Code: ff e9 a4 f4 ff ff 48 89 de 48 c7 c7 a0 db ab 8e e8 e8 3f 74 fe e9 59 f6 ff ff e8 9e e8 b1 ff e9 6f f6 ff ff e8 74 6b 45 ff 90 <0f> 0b e8 fc e7 b1 ff e9 cd f9 ff ff 4c 89 f6 48 c7 c7 20 dc ab 8e
RSP: 0018:ffffc900040e6d18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82c3391b
RDX: ffff8880298a0000 RSI: ffffffff82c3484c RDI: ffff8880298a0000
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000005
R10: 0000000000000003 R11: 0000000000000012 R12: 000000007fffffff
R13: 1ffff9200081cda9 R14: ffff88801c7f3960 R15: ffff888022886580
FS:  000055556085f500(0000) GS:ffff8880d6644000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c008fdc000 CR3: 000000002f279000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 netfs_unbuffered_write+0x25d/0x2080 fs/netfs/direct_write.c:128
 netfs_unbuffered_write_iter_locked+0x801/0xab0 fs/netfs/direct_write.c:287
 netfs_unbuffered_write_iter+0x40c/0x710 fs/netfs/direct_write.c:377
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 __kernel_write_iter+0x2ac/0x920 fs/read_write.c:621
 __kernel_write+0xf6/0x140 fs/read_write.c:641
 __dump_emit fs/coredump.c:1221 [inline]
 dump_emit+0x21f/0x330 fs/coredump.c:1259
 elf_core_dump+0x2127/0x3d10 fs/binfmt_elf.c:2062
 coredump_write fs/coredump.c:1050 [inline]
 do_coredump fs/coredump.c:1127 [inline]
 vfs_coredump+0x27bc/0x5570 fs/coredump.c:1201
 get_signal+0x1f2a/0x21e0 kernel/signal.c:3019
 arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:98 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
 irqentry_exit+0x1f8/0x670 kernel/entry/common.c:219
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000200000000088 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f5120e15fa0 RCX: 00007f5120b9c799
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000008000
RBP: 00007f5120c32bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007f5120e15fac R14: 00007f5120e15fa0 R15: 00007f5120e15fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_limit_iter+0x100d/0x1100 fs/netfs/iterator.c:248
Code: ff e9 a4 f4 ff ff 48 89 de 48 c7 c7 a0 db ab 8e e8 e8 3f 74 fe e9 59 f6 ff ff e8 9e e8 b1 ff e9 6f f6 ff ff e8 74 6b 45 ff 90 <0f> 0b e8 fc e7 b1 ff e9 cd f9 ff ff 4c 89 f6 48 c7 c7 20 dc ab 8e
RSP: 0018:ffffc900040e6d18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82c3391b
RDX: ffff8880298a0000 RSI: ffffffff82c3484c RDI: ffff8880298a0000
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000005
R10: 0000000000000003 R11: 0000000000000012 R12: 000000007fffffff
R13: 1ffff9200081cda9 R14: ffff88801c7f3960 R15: ffff888022886580
FS:  000055556085f500(0000) GS:ffff8880d6644000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c008fdc000 CR3: 000000002f279000 CR4: 0000000000352ef0


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

Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457D3B7760
	for <netfs@lists.linux.dev>; Tue, 14 Apr 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175112; cv=none; b=a4/k5Yg3m6l8BPao//dPcJDYDpYtrew6vh2Fev0llD0F6VhPyhhmv8ka2tbgXAGvhdg/gEuguQj7aNISxqcI9x3JW46Im/iVUhE9Gy/zLONSv9uCXoXboXcPVfQW3z90+Hnuk2wldftCFeI5Q9aWfRp8H5kmLXLCqWwx9avuX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175112; c=relaxed/simple;
	bh=J4D67UWjuFui1G+Wxv//O7qqWMvG1YuiXR7YExP6Rlk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GyX2KAuSrXYF7gd6bJj+AcpAaQWfClxylHTeY5Ji5H0iGfjLwILfAQaiSSPoCeS9g2RIHk/pcWOLHo+l0JDcUSElUW3N4ZlDa2ivNnxRaMlMYvmyC+EqLWk4bj547nuMylqSJRHYwOqqoN5s6PPVwEnK1hvdmoN8TYhevJEMxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6861462170aso11015095eaf.0
        for <netfs@lists.linux.dev>; Tue, 14 Apr 2026 06:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175110; x=1776779910;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBgdAsL//GQnTapAXF/VlCVSr0qK85PQANpDue0Mnv0=;
        b=WtEhsPr4I4y4YNJtaDH7pqQhG+qdngzzbO1ShhG8yYGvPkPaHpxRlqadBD84peqGlR
         A8dITrtda6L5c/90z2qO4bZuIyoJrF162+lhlM7soFJexy4Om+knwUcLZIunc2w5ABLj
         jiHbdRVOhxvsg3k/2+zJUhE0osBqeKCSkk8NyOkVGbDFclqkYoK2m6VOtPNzPzTYbpQK
         XNg20J+tOnmkuhCv8kcb10ilYdI+IfETobqIBsc+rB03XJDrRP1wz6aQ8jX+iTiCE0y2
         iYfzWff92sqLttkrKlpqsNs+RdGP+oHOg+4MlJ2qKxy12UwNQeFKmegrnM9eetmf39yT
         McVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S9DTK5tiOoIeLUrgA/eBagRoVZH4hdYNEUM83rEwpCxmCnv2utcruyWzidahfF9gzRjvcfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6JZbBcG+VwirTr5o8HBStE6myOd6LgWUbwCDY/06ABa6H7AeN
	jZsSnRhspWy9PX8syHi/dgxEGpqBExSBCot4FUl/5vctbsggwRLiCYxfxmSqJfweTVAFq8jKVkL
	Kgw2tzZZS3Spa8xKR/HOiYruzyfx4fh/X9Pqol/BZbg1yGfSkJljPT53XHuQ=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a4a:ef03:0:b0:67b:b0bd:8bd2 with SMTP id
 006d021491bc7-68be89e6708mr5870736eaf.59.1776175110028; Tue, 14 Apr 2026
 06:58:30 -0700 (PDT)
Date: Tue, 14 Apr 2026 06:58:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69de4806.a00a0220.475f0.0043.GAE@google.com>
Subject: [syzbot] [netfs?] general protection fault in netfs_put_subrequest
From: syzbot <syzbot+a0788ffdca16ee21c493@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9a9c8ce300cd Merge tag 'kbuild-fixes-7.0-4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142de106580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=a0788ffdca16ee21c493
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9a9c8ce3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/073107a6c46a/vmlinux-9a9c8ce3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6457493483c/bzImage-9a9c8ce3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0788ffdca16ee21c493@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000055: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000002a8-0x00000000000002af]
CPU: 1 UID: 0 PID: 1247 Comm: kworker/u32:10 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events_unbound netfs_unbuffered_write_async

RIP: 0010:netfs_put_subrequest+0x88/0x4e0 fs/netfs/objects.c:248
Code: df 48 c1 ea 03 80 3c 02 00 0f 85 fa 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 2b 48 8d bd ac 02 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 96
RSP: 0018:ffffc9000619fa48 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88804679adc0 RCX: 0000000000000000
RDX: 0000000000000055 RSI: 0000000000000008 RDI: 00000000000002ac
RBP: 0000000000000000 R08: 1ffff110055b509b R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: 0000000000000001 R14: 0000000000000002 R15: ffff88804679ae10
FS:  0000000000000000(0000) GS:ffff8880d6438000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002b072000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 netfs_clear_subrequests+0x158/0x260 fs/netfs/objects.c:106
 netfs_unbuffered_write_done fs/netfs/direct_write.c:59 [inline]
 netfs_unbuffered_write+0x13ac/0x2260 fs/netfs/direct_write.c:202
 netfs_unbuffered_write_async+0x19/0x30 fs/netfs/direct_write.c:211
 process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
 process_scheduled_works kernel/workqueue.c:3359 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_put_subrequest+0x88/0x4e0 fs/netfs/objects.c:248
Code: df 48 c1 ea 03 80 3c 02 00 0f 85 fa 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 2b 48 8d bd ac 02 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 96
RSP: 0018:ffffc9000619fa48 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88804679adc0 RCX: 0000000000000000
RDX: 0000000000000055 RSI: 0000000000000008 RDI: 00000000000002ac
RBP: 0000000000000000 R08: 1ffff110055b509b R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: 0000000000000001 R14: 0000000000000002 R15: ffff88804679ae10
FS:  0000000000000000(0000) GS:ffff8880d6438000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000031877000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 fa 03 00 00    	jne    0x408
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 8b 2b             	mov    (%rbx),%rbp
  1b:	48 8d bd ac 02 00 00 	lea    0x2ac(%rbp),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2d:	48 89 f8             	mov    %rdi,%rax
  30:	83 e0 07             	and    $0x7,%eax
  33:	83 c0 03             	add    $0x3,%eax
  36:	38 d0                	cmp    %dl,%al
  38:	7c 08                	jl     0x42
  3a:	84 d2                	test   %dl,%dl
  3c:	0f                   	.byte 0xf
  3d:	85                   	.byte 0x85
  3e:	96                   	xchg   %eax,%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

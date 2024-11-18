Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56882126BFA
	for <netfs@lists.linux.dev>; Mon, 18 Nov 2024 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731904463; cv=none; b=dr+hCYfJGkHfI+SfaB1QNKvJmB/G5j+MJx4wq7FndvEQRdxnUQfbLf6b5c8PMQ2HcUEq/JQMeKh2ACViByvXPFgSIUJ5GwSv2llIbcj/py8A7cdm2DrytpZ6vWRlLDhk06ecVxEL4QZcbGPGlUc0g8Qb9wZTP6Hvoh9wfyF5DME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731904463; c=relaxed/simple;
	bh=nAYYGGKvPU2SLH3YjjcZ1qwvVhwc2kLU819TpGwtePA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kulUUgJo95MN12OrcHxsL+59p/oJrBU+Pp+Kicu97CCE1b2QnC4PBiOd0JqOiSVJesdBSk54ZHcSA+IAcqOzQHmS5mCGBeIwd68qPJAtfqgsWEmXXyBfFJJKjN/5axrsGwMtQTcMGgbWZ6YQwI3LUAEvJBrW7D6OCsGO4MELDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83b6628a71fso399742039f.0
        for <netfs@lists.linux.dev>; Sun, 17 Nov 2024 20:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731904461; x=1732509261;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rwgSRg0agNab0QoDWUuCny3dkOl6ihcHjI7LHymwSU=;
        b=v8p+tZ5yidg8vMvP5hmYXAsnnv0SdSeDnkJLW8PwONZZJwfQts13l7+4D/5Y+hnh9m
         A07DqqIz5oGJbIu7bupj24cJPtZ//cdIS3rsaJXTHjeQLshYwP5UnL9BLAMd3vwKMhLB
         lkShXWNAVfRz2D3HLctTCmPpyyvJS1SrdylvoLzUL666Czc5s5lktk3PQscBeDJnwSrh
         r87ngJy+6NggG95/UTKTGgvpvP2mtS/rY+U0d/QREuXjdtQbjBoH2Iv9DVEofVK0gvtM
         a+pLvv4O+lwvvDo6y/Hb3VKCCjb6C1X6EX5ermmkyUbpJfNTqT1ssEXVz8+ZcOglgM8j
         J1cA==
X-Forwarded-Encrypted: i=1; AJvYcCUCgIjwLTrFDIXJ71pZWkrhEifKEJoQs+T0Y162ldVdJP19ZECDczZxWKdvYHE8DtaXhRgQ8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWYs/r8NRGSpHFezFe0bk8anlQUPl+/7g76euIAmTtWRS2E70x
	fLDt4tBqgHj9edgAdi1LWSjJ15ziluu14xAbfDVW5VAgvP8Bh31FZMJNMpEL5zAHtCNnSiwDCR3
	D8nxmXlZPY6OB6EP85f/j8dNsXJYeFSBQ8jk1TxjBptOGzjeJOfucdfc=
X-Google-Smtp-Source: AGHT+IHal0Idqvv4i8Vbv2KmbcqwGuSpRgyw+XbDXbbZrBEPHIurwqpSpQ/hikNunViYMYUZD+zuWslkBzntZSRGVmC+uGCuZbqg
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c6cb:0:b0:3a7:6212:f87e with SMTP id
 e9e14a558f8ab-3a76212fa23mr34212145ab.20.1731904461553; Sun, 17 Nov 2024
 20:34:21 -0800 (PST)
Date: Sun, 17 Nov 2024 20:34:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ac3cd.050a0220.87769.001f.GAE@google.com>
Subject: [syzbot] [netfs?] WARNING in netfs_writepages
From: syzbot <syzbot+06023121b0153752a3d3@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1b785f4c787 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f5ace8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=06023121b0153752a3d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2eb65d2a03c1/disk-f1b785f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70c538f32a8e/vmlinux-f1b785f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79fc36f9a44b/bzImage-f1b785f4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06023121b0153752a3d3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 35 at fs/netfs/write_issue.c:573 netfs_writepages+0x350/0x9d0 fs/netfs/write_issue.c:573
Modules linked in:
CPU: 0 UID: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.12.0-rc7-syzkaller-00042-gf1b785f4c787 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: writeback wb_workfn
 (flush-9p-3)

RIP: 0010:netfs_writepages+0x350/0x9d0 fs/netfs/write_issue.c:573
Code: d5 05 00 00 4c 8b a5 90 02 00 00 4c 89 fe 48 c1 e6 0c 4c 89 e7 e8 00 04 54 ff 48 8b 44 24 10 49 39 c4 7e 09 e8 41 02 54 ff 90 <0f> 0b 90 e8 38 02 54 ff 48 8d 7b 28 48 89 f8 48 c1 e8 03 42 80 3c
RSP: 0018:ffffc90000ab7400 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffffea00015c0700 RCX: ffffffff82397910
RDX: ffff88801e292440 RSI: ffffffff8239791f RDI: 0000000000000006
RBP: ffff88802aac0000 R08: 0000000000000006 R09: 0000000000000000
R10: 810f000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffffc90000ab7790 R14: dffffc0000000000 R15: 000810f000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc1ba1a2d3d CR3: 000000003660a000 CR4: 00000000003526f0
DR0: 0000000000000003 DR1: 0000000000000004 DR2: 0000000100000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x166/0xfa0 fs/fs-writeback.c:1658
 writeback_sb_inodes+0x603/0xfa0 fs/fs-writeback.c:1954
 __writeback_inodes_wb+0xff/0x2e0 fs/fs-writeback.c:2025
 wb_writeback+0x721/0xb50 fs/fs-writeback.c:2136
 wb_check_old_data_flush fs/fs-writeback.c:2240 [inline]
 wb_do_writeback fs/fs-writeback.c:2293 [inline]
 wb_workfn+0x8c3/0xbc0 fs/fs-writeback.c:2321
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

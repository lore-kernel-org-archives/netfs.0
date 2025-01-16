Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651B13C8E8
	for <netfs@lists.linux.dev>; Thu, 16 Jan 2025 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736994806; cv=none; b=sJE46+dA9+7FGILB/MSUweXyGNh5n0zHxCXWagvTYVNvO5EHH0HiUvGIeeglfEEmwmEMk3qelDBJViyEYOKcp3fAG4gnRqBkDpjkWueKUecXe3BrbbE6zEjbElbC7eHerR3He7p1Mm/1BjIQ77m7RHZORHctE7hiU0IJ1mZ9yss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736994806; c=relaxed/simple;
	bh=SkVeLdXm/hes0GEhE+bXX6u8BBd5Cj5myhyEOGaFkiU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pnu8/DqjbAB5UY8aP8EEEsHkcjGJ8f1SiPlM54SdgD8SyBRiC0grM560MoqbMreiigXJTWNbME8fRLK69mlZ8ntV5L0KocTeRUfAMWqoNTFT3wl/99PF3Nn9WDGA3+3S3flxKV4aqAQ8y33m3FvWD/3TBUYZof4qrO/K+1tFW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce8868a7a5so3905965ab.1
        for <netfs@lists.linux.dev>; Wed, 15 Jan 2025 18:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736994804; x=1737599604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygrqID4GW9vjVLnoIi/TTeBK5vUcLhSYRXNONKpMWss=;
        b=E0ImCyDfbr7IkWWivHZpSFbUZY4nieaAQgsIbmrDKUamUL1Z0hoETxAfsEFjZA0W4D
         qa5fwjwODYbCUmvt94gLIfJvsPSo5Dk1bD7Vr8MjYEkvUkH8zFAkjxMTrM9ELKQwlcdI
         Txbn0lyTSRMLrQo3tzhjRI1rDrLEAFmLDGyNYM32McbIzZv6WPyK2Ssklw6DF3DLrqLH
         Bl3GxLMTWmQQ7ppZk8TAt2IcrR62muiSZ5bY0hE779Fr3tMaAyuQVaEDqbQZ0UkcFXpK
         vGCorP+2fnmEzQqKqTw5uw4pdynCEJeAd3nd0geEMk0jsN1NawRXLhBTn/oHtbJ4aB1J
         tTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA7h1ObxtNPn8Z6R6ZWdM3tm+c8ROxiv9DTXUI3gKFybsJF24ENion8DT8FNUUMcZeEYRydw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXVLc3hd6/TcSoHltOs5ASK+AE21k8YmGHjkIGBQU2eLhk6hXG
	017ij8BVT8/WRAc4Q+X8pGlRmwHZY6J6Dw+ixG1HWZeBuX1BHHiW37xH4TTT/B8CchSr5RFDnEl
	x68ZvL+CEzqbuJqtPQLYCKrZ/9UNDv6CH00bWePvkF9nae+JBVrTpJHQ=
X-Google-Smtp-Source: AGHT+IEKf7DIpMTf4nfvUNHPaNYpFxjDa14ZXk0f7fUIcLgdO/BU7ytKLJGRsshplYFQrqOi9c16ABSbJtk0w3SVl13qnN9Ckt1U
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3ce:7b33:8c3b with SMTP id
 e9e14a558f8ab-3ce849de894mr50861285ab.5.1736994803960; Wed, 15 Jan 2025
 18:33:23 -0800 (PST)
Date: Wed, 15 Jan 2025 18:33:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67886ff3.050a0220.20d369.0021.GAE@google.com>
Subject: [syzbot] [netfs?] INFO: task hung in netfs_retry_writes
From: syzbot <syzbot+666a9cb4c41986207cdf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4b9bf203da Add linux-next specific files for 20250107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1386f218580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
dashboard link: https://syzkaller.appspot.com/bug?extid=666a9cb4c41986207cdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b0def8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135e2bc4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c179cc0c7a3c/disk-7b4b9bf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdea80f2ec16/vmlinux-7b4b9bf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a277fcaff608/bzImage-7b4b9bf2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+666a9cb4c41986207cdf@syzkaller.appspotmail.com

INFO: task kworker/u8:2:33 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc6-next-20250107-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:2    state:D stack:19696 pid:33    tgid:33    ppid:2      flags:0x00004000
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x18f6/0x4cd0 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 bit_wait+0x12/0xd0 kernel/sched/wait_bit.c:237
 __wait_on_bit+0xb0/0x2f0 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0x1d5/0x260 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:77 [inline]
 netfs_retry_writes+0x16e/0x19b0 fs/netfs/write_retry.c:215
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x2f90/0x3bb0 fs/netfs/write_collect.c:374
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
2 locks held by kworker/u8:2/33:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90000a97c60 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000a97c60 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
1 lock held by klogd/5196:
 #0: ffff8880b873e958 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
2 locks held by getty/5595:
 #0: ffff88803598a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fd62f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-executor286/5854:
 #0: ffff888034c86420 (sb_writers#9){.+.+}-{0:0}, at: direct_splice_actor+0x49/0x220 fs/splice.c:1163
 #1: ffff8880770c0e28 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: netfs_start_io_direct+0x1d4/0x210 fs/netfs/locking.c:188

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc6-next-20250107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111


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

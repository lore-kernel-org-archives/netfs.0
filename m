Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047B272E7A
	for <netfs@lists.linux.dev>; Fri,  8 Aug 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647048; cv=none; b=dqcZSGioKvBN6663u+Q5EFkRlTOevhMeHY/Zqcuejz2Tun4cnztVBSan+AKpvNhaWuLD5Kw8Jflvi0wpcZNZ3GA2hSATEUxqn7GFNQRF4AeNU1wj13MU3uaGkgbi71sDdGCPUhDavqawIDm2UF5z8wZxJ+ZZaV36D7Lma8nyaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647048; c=relaxed/simple;
	bh=TPJYs/iw92Nbw7ATS6naCYSud4glO597/Ri/HejkiYM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dlu6FEaELNTQUfOMSscNSIo87922gt9jyU2TOV5zJ0bl4XjxoDQtm86f1CLpHyO3GFbxfnAPRzOwsAV9d5X9mLopRWoivokCXHI2SSVuJyy0V0YG2uhC/M4rwPZACKZuW9EIwL4gFIy7NX/U1FioETklfZCpgHxCrvEV68P/MvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86a5def8869so579528939f.0
        for <netfs@lists.linux.dev>; Fri, 08 Aug 2025 02:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647046; x=1755251846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCrShbMYYAvyYdKTx5yX6ZumNb/l20QYxJfbyUUYJk8=;
        b=jztao5aiQo/zxvtWHEltV7ufpdedvsS+imWVDPHFhlbZXw8YeyiDvjCL7loa3C8ip+
         U+W1JQbf0V76QbZwfAgAr58tS+HQqHNKZSIBZjMRdd3XzkTrZBFa7rbF3DbQsex5g8Cl
         ItFFDrR9sg5LTlXf56ASUFnJoF0NRDeijiGizz+c5+W7lKI5Tzch3vdwylibkOOt8+hl
         vv9yQ+cbpt9mzP7racb0ylU+0qGDgnxRlXWccBt2Rk4mlXL/L0IvTbETeuqHWfkSsEt0
         Ou8WUDf5G0YMsws7YPwh/oPspzLkaden7yZLIBJs5bYNx55p7rkarLC/ogITIsyqRENS
         lrEg==
X-Forwarded-Encrypted: i=1; AJvYcCXS4OxsB9290znni6E3FBe8qyYqBQeBRrROYpI+3rzmqQnmREZnHnEpVxlPM5/9S3EklrePLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVbqiFy4kZGEspizxgXpszCFgU/BQYeVeplZ13b+VKwuMYsl29
	CjU0GMKk+fHqhZl49vnegfSJZHtpo+R5IGvoEwWCOYR/Q+MBndNx71TvqYOI4wW5JJMFZEfPlpY
	sxUgMKE1wyfaoyoTFSewRJObBf7PjUklGfpqpU0iTQkBJMA0vBrphgSYj4Js=
X-Google-Smtp-Source: AGHT+IFCmzk3LVZoCkYG45B+wq1hKTXgsYGNQdqiqXXlceN+G3olTbQHeGdPIPqcQBcgTEaxGWeuR9f6YkoW5LqklkWTI3l5Addc
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3319:b0:881:776b:62b with SMTP id
 ca18e2360f4ac-883f12791b7mr329579739f.13.1754647045903; Fri, 08 Aug 2025
 02:57:25 -0700 (PDT)
Date: Fri, 08 Aug 2025 02:57:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895ca05.050a0220.7f033.005b.GAE@google.com>
Subject: [syzbot] [netfs?] WARNING in netfs_writepages (2)
From: syzbot <syzbot+b3b2525cb55ad5a59499@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    038d61fd6422 Linux 6.16
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104e0434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=515ec0b49771bcd1
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b2525cb55ad5a59499
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34e894532715/disk-038d61fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6a27a46b9dc/vmlinux-038d61fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f97a9c8d8216/bzImage-038d61fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3b2525cb55ad5a59499@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12 at fs/netfs/write_issue.c:587 netfs_writepages+0x613/0x900 fs/netfs/write_issue.c:587
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.16.0-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: writeback wb_workfn (flush-9p-7)
RIP: 0010:netfs_writepages+0x613/0x900 fs/netfs/write_issue.c:587
Code: df e8 b1 c0 b9 ff 49 c1 e6 0c 4c 8b 2b 4c 89 f7 4c 89 ee e8 bf db 59 ff 4d 39 ee 7c 07 e8 55 d9 59 ff eb 10 e8 4e d9 59 ff 90 <0f> 0b 90 eb 05 e8 43 d9 59 ff 4d 8d 74 24 28 4c 89 f0 48 c1 e8 03
RSP: 0018:ffffc900001170c0 EFLAGS: 00010293
RAX: ffffffff82664c72 RBX: ffff888058820280 RCX: ffff88801d2a5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 810f000000000000
RBP: ffffc900001171c0 R08: ffff888058820287 R09: 1ffff1100b104050
R10: dffffc0000000000 R11: ffffed100b104051 R12: ffffea00004766c0
R13: 0000000000000000 R14: 810f000000000000 R15: ffff888057520498
FS:  0000000000000000(0000) GS:ffff888125c57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000059812000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_writepages+0x32b/0x550 mm/page-writeback.c:2636
 __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x6b5/0x1000 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
 wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
 wb_check_start_all fs/fs-writeback.c:2284 [inline]
 wb_do_writeback fs/fs-writeback.c:2310 [inline]
 wb_workfn+0x90b/0xef0 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036C157A46
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865246; cv=none; b=BpPU54ffM3OP6nE/Lbh6oF22YmdN9qGUNiXQ96TJY/yWbuxUpo1qf0kOU9fo5gkWVUUsu0NpIBd1TN4kV/ljq1Tyyko/pK1/N2qkOo2gUbv0CsIxV+AsPR4O4KpiZN5tdvuruJuHxQ26iau26cwvYBMuN3ZlXYfmO8T9YbZzPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865246; c=relaxed/simple;
	bh=qZ/uICPY2dq7EMrhEvmi9Lt3yrzqEBcFQ4vMTDWEJgc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SfudyYqfVGxmjXtyvgUJ2Qfw4ZkSnJu2vPxiRFSP/umqJQkNR+HRdokCQSheASaQq5yU+l7XKD+wx8lQHnsF7ttrdloKscleoO61rdG4A6fXk/dvwWzjjiMrVcKnMUF9mr+w3JJSwP3H6MALmZfcJzolRPXFM+VjYurMNIMRr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8418307b4f9so142742539f.1
        for <netfs@lists.linux.dev>; Thu, 28 Nov 2024 23:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732865244; x=1733470044;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t+yCvLqPaPl8VBtNzjGkNzg501tc5nDnJ48ZnMcu+s=;
        b=dNYrXBwAk3qHki0AJYtxdayZHMhjsusGDUkhGqVeKuWLQ0OV2NgIrzY3zRVlseAQTD
         TYnsTVKCMwUU8O+HHk9FGNzRJDkf8RCKRF0rN2tu3f4rZCvXOcvI/4P40a4jUfH7uuYe
         l6IbdJQy67syCsAJdTZYxfxGHAMBCIEP/iP9osQpbND39Kp214bTXoHdZyu0O/scT1qD
         1Em/FPUaptj8wFivYgie6SFBSubdaJepnAe8wLQRhghRxKhEVgdG/Bd9pVYoxBE/P40z
         Os+oUHNekV569WZTj1EEAQ/L+6uAbPp0S49T+ze+9iltp9BwPVarq+XM5/xGlYbUAdv0
         PhkA==
X-Forwarded-Encrypted: i=1; AJvYcCUq9NY9O+RPy7+IMlEAo5VQH3VZDZyvSe0hCMvEMeSLwfDd91c8T4c37eYhScdZH++aSFQGqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+bKdJaY6EFyaL98tV6QAElXnPs/ojkZHYOgZabjflrW9hJ24H
	JdJpbxk4iqPBLsTF2SpD4Zfi+HgUIdWfuhridgld4eDEaFGT+vpxxdGqZ7F/uXThyNhW9HGeirL
	mMvliqV3stOmr1u7ltdmUDqKF4ZgM8/G0LQcae6AyMdeoRJ4e8qNUTDA=
X-Google-Smtp-Source: AGHT+IFMswTPiNG+WhDA9tzI3s8K/Gi1GhVWJcOG4BsIvm7hfEp0yz22wXkyOmcc/AdmZfd7HSwGlTBJlEKMuAmndiI/ZtqzNe20
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3a7:87f2:b013 with SMTP id
 e9e14a558f8ab-3a7c5525326mr119878605ab.4.1732865244039; Thu, 28 Nov 2024
 23:27:24 -0800 (PST)
Date: Thu, 28 Nov 2024 23:27:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67496cdc.050a0220.253251.00a5.GAE@google.com>
Subject: [syzbot] [netfs?] WARNING in netfs_retry_reads
From: syzbot <syzbot+fe139f9822abd9855970@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bhelgaas@google.com, dhowells@redhat.com, 
	ericvh@kernel.org, ilpo.jarvinen@linux.intel.com, jlayton@kernel.org, 
	jonathan.cameron@huawei.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	lukas@wunner.de, netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    85a2dd7d7c81 Add linux-next specific files for 20241125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D10e3a5c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D45719eec4c74e6b=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfe139f9822abd9855=
970
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1334dee858000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14e3a5c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5422dd6ada68/disk-=
85a2dd7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a382ed71d3a/vmlinux-=
85a2dd7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b4d03eb0da3/bzI=
mage-85a2dd7d.xz

The issue was bisected to:

commit fad610b987132868e3410c530871086552ce6155
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Date:   Fri Oct 18 14:47:47 2024 +0000

    Documentation PCI: Reformat RMW ops documentation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16de15305800=
00
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D15de15305800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D11de1530580000

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+fe139f9822abd9855970@syzkaller.appspotmail.com
Fixes: fad610b98713 ("Documentation PCI: Reformat RMW ops documentation")

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=3D2 set at [<ffffffff817=
7bd66>] prepare_to_wait+0x186/0x210 kernel/sched/wait.c:237
WARNING: CPU: 0 PID: 5848 at kernel/sched/core.c:8685 __might_sleep+0xb9/0x=
e0 kernel/sched/core.c:8681
Modules linked in:
CPU: 0 UID: 0 PID: 5848 Comm: syz-executor189 Not tainted 6.12.0-next-20241=
125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024
RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8681
Code: 93 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 fe 38 9b 00 48 8b 4d 00 =
48 c7 c7 80 2d 0a 8c 44 89 ee 48 89 ca e8 b8 e6 f0 ff 90 <0f> 0b 90 90 eb b=
5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
RSP: 0018:ffffc90003e465a8 EFLAGS: 00010246
RAX: ff5208356e89db00 RBX: 1ffff1100fff22ed RCX: ffff88807ff90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807ff91768 R08: ffffffff81601b32 R09: fffffbfff1cfa218
R10: dffffc0000000000 R11: fffffbfff1cfa218 R12: dffffc0000000000
R13: 0000000000000002 R14: 000000000000004a R15: ffffffff8c1ca120
FS:  0000555573787380(0000) GS:ffff8880b8600000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff2460a1104 CR3: 00000000745c2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wait_on_bit include/linux/wait_bit.h:74 [inline]
 netfs_retry_reads+0xde/0x1e00 fs/netfs/read_retry.c:263
 netfs_collect_read_results fs/netfs/read_collect.c:333 [inline]
 netfs_read_collection+0x33a0/0x4070 fs/netfs/read_collect.c:414
 netfs_wait_for_read+0x2ba/0x4e0 fs/netfs/read_collect.c:629
 netfs_unbuffered_read fs/netfs/direct_read.c:156 [inline]
 netfs_unbuffered_read_iter_locked+0x120e/0x1560 fs/netfs/direct_read.c:231
 netfs_unbuffered_read_iter+0xbf/0xe0 fs/netfs/direct_read.c:266
 __kernel_read+0x513/0x9d0 fs/read_write.c:523
 integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0xae6/0x1b30 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x520/0xb10 security/integrity/ima/ima_api.c:293
 process_measurement+0x1351/0x1fb0 security/integrity/ima/ima_main.c:372
 ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x2ccd/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_open fs/open.c:1425 [inline]
 __se_sys_open fs/open.c:1421 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff24603d929
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9079c548 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff24603d929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000340
RBP: 00007ff24608a257 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000023fb0
R13: 00007ff2460bab40 R14: 00007ff2460bcd00 R15: 00007ffe9079c570
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

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

Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465346AF25
	for <netfs@lists.linux.dev>; Fri, 29 May 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084891; cv=none; b=kXTctNbnKcqDQKBMDbVlFAidtetHd4SOnEmy3HP7QTLb9jYXGG/YCEP9Gzx+ikzi69dXhK/OefydA9HCUMOrwB3acnBhMK+icf7HXLU2zVgIDtVFhV2FzhlbLpCFvl+p7q0zy1CQpzlDIwRFiaDF3xyCzEGV/u+e3L1A15gnj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084891; c=relaxed/simple;
	bh=RGny/la2xCXvhDntgZ3IOWpx9qp8epYuc2DA0FjUw7E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DUR75h0lwQ6svKi7JIqM57VOPUTkuR/aKMDtvLWbnTbV+d14uNHJQCDCNeOlg+SoYWegg/LW8BunUjST2eeXGHMl9PSAfW4eqhk32+wJsrAjBM3/LrGVSCdyPqppNolm3i6bwkxExCYCnBIDdeliMaJ+tQPsyer2eqUMnRA/IvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-43cabbedc29so11593fac.0
        for <netfs@lists.linux.dev>; Fri, 29 May 2026 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084888; x=1780689688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cIy58T8b6smMDrJfBXFqT2PqmOH5/pUjAmtMG/RVqs=;
        b=fn7JUEQFhGkF/G6fwlt6ENQJAGhznjZD+7i4v45O8p/Yrgy6phdHvVaoZxQWbCJWnn
         M9nNTXu6rPdmEU4jmFatVTDuducU6ZNpqLtcPRfnBtGhhPZAP4QL5imAGd/mhz3H2m38
         WEsb06GdviBS87Xfe6rDna1SOHV/GtE85xSBdZKs+q1XX4hAJe/jV46Nh2PHalkVHzt0
         TO9Zop5kJSNkZXmnLH2xkIJ50aKeE1lnnl7KuZSB3ldBmNNL2IeMIlh6/lykcDrQMF2h
         DCNekapA3a4A7fH5pU99VFXW9wUp351WgkrvnbjCP09zTsLn1qVJXy9rdWktlZYnMkE0
         a8NA==
X-Forwarded-Encrypted: i=1; AFNElJ8mKGXM4Osh5GCSQAIzYMvEnoldXAgFX1r6lLsacGsQjC21rl/kkherYi6qnTZWk44IkNrMpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwQey74Q9/NLAk4QX3Wgjg56SYa8XlhN4NrIU0EIi94s9h6bJ7
	r6xTqqSOH3bR8+5P7qAxcwdWUzRf/lk/yFnBfrYpbGAj4gl0X2T1v9Qb8ZuLmvFDrWzi6+FArTZ
	3lOvyAWC3O4F6oz7XQSD0xjk/ODMDUZANIH0qnZqXKbYH9YB0VrjH4o9D+rY=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a4a:e846:0:b0:696:6e28:8c19 with SMTP id
 006d021491bc7-69e043898a6mr1693673eaf.20.1780084888344; Fri, 29 May 2026
 13:01:28 -0700 (PDT)
Date: Fri, 29 May 2026 13:01:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a19f098.abb04025.19af7b.0003.GAE@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-use-after-free Read in netfs_unbuffered_write
From: syzbot <syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8fde5d1d47f6 Merge tag 'acpi-7.1-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107a02b6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bedcb6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171b697e580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8fde5d1d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/529080512bd5/vmlinux-8fde5d1d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39c09b74f46c/bzImage-8fde5d1d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in netfs_unbuffered_write+0x1c21/0x21e0 fs/netfs/direct_write.c:119
Read of size 2 at addr ffff888022e87864 by task syz.0.17/5936

CPU: 1 UID: 0 PID: 5936 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 netfs_unbuffered_write+0x1c21/0x21e0 fs/netfs/direct_write.c:119
 netfs_unbuffered_write_iter_locked+0x7e2/0xa90 fs/netfs/direct_write.c:294
 netfs_unbuffered_write_iter+0x442/0x740 fs/netfs/direct_write.c:386
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2eecd9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2eedc49028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2eed015fa0 RCX: 00007f2eecd9ce59
RDX: 00000000fffffdd8 RSI: 0000200000000540 RDI: 0000000000000003
RBP: 00007f2eece32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2eed016038 R14: 00007f2eed015fa0 R15: 00007fff0ed7a0b8
 </TASK>

Allocated by task 5936:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_noprof+0x241/0x6e0 mm/slub.c:4906
 mempool_alloc_noprof+0x1b7/0x310 mm/mempool.c:566
 netfs_alloc_subrequest+0xc1/0x3c0 fs/netfs/objects.c:204
 netfs_prepare_write+0x76/0x780 fs/netfs/write_issue.c:172
 netfs_unbuffered_write+0x7b8/0x21e0 fs/netfs/direct_write.c:111
 netfs_unbuffered_write_iter_locked+0x7e2/0xa90 fs/netfs/direct_write.c:294
 netfs_unbuffered_write_iter+0x442/0x740 fs/netfs/direct_write.c:386
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5936:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6378
 mempool_free+0xde/0x130 mm/mempool.c:711
 netfs_free_subrequest fs/netfs/objects.c:239 [inline]
 netfs_put_subrequest+0x282/0x4c0 fs/netfs/objects.c:255
 netfs_unbuffered_write+0x13ed/0x21e0 fs/netfs/direct_write.c:118
 netfs_unbuffered_write_iter_locked+0x7e2/0xa90 fs/netfs/direct_write.c:294
 netfs_unbuffered_write_iter+0x442/0x740 fs/netfs/direct_write.c:386
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888022e877c0
 which belongs to the cache netfs_subrequest of size 200
The buggy address is located 164 bytes inside of
 freed 200-byte region [ffff888022e877c0, ffff888022e87888)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22e86
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888026b62001
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801fab5680 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800190019 00000000f5000000 ffff888026b62001
head: 00fff00000000040 ffff88801fab5680 dead000000000100 dead000000000122
head: 0000000000000000 0000000800190019 00000000f5000000 ffff888026b62001
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 4032896346, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x11a6/0x3410 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x6c0 mm/slub.c:3525
 refill_objects+0x277/0x420 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x375/0x650 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 kmem_cache_alloc_noprof+0x480/0x6e0 mm/slub.c:4906
 mempool_init_node+0x2f7/0x6e0 mm/mempool.c:259
 mempool_init_noprof+0x3a/0x50 mm/mempool.c:289
 netfs_init+0x16c/0x2b0 fs/netfs/main.c:128
 do_one_initcall+0x121/0x750 init/main.c:1392
 do_initcall_level init/main.c:1454 [inline]
 do_initcalls init/main.c:1470 [inline]
 do_basic_setup init/main.c:1490 [inline]
 kernel_init_freeable+0x6ea/0x7b0 init/main.c:1703
 kernel_init+0x1f/0x1e0 init/main.c:1593
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888022e87700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888022e87780: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888022e87800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888022e87880: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888022e87900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

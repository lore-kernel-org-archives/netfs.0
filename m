Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174844C66D
	for <netfs@lists.linux.dev>; Fri, 14 Aug 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698340; cv=none; b=mBfbg3vd3YoMcMkKJtcBPr5YiNnnw0wGPg8aPJ1B4s+l4FoXlMYxN+dkRV2+gzGHX9fQSezExHJ/mosJmmUT6O7LpnGwNyVDdlTNCep77tnzr9GdGYmAa76gcXQIsE08dOVCLkB+LxnM1VxOD/5YNR0iySu7F9hGtoOWmswniYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698340; c=relaxed/simple;
	bh=pXNBcDJc7JEmHOF1oYWDB65q0kJq62SwvX5R4BbyMuk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WY10P7zN5HMYimbQ13h3kb7QeBfx1lvdIauwFyny1HOILPflbQVbb4QC6eWhDRQA9nDi9Ucb4uxIltVbMFAvHsebdJ7LeiB+XtvDDZODdgALZPeHJw+ZTtpstmZClcOdIi4FmqLPv/KJbUinO0cYg2WdrAgyk1Ay3ZYdYbb09SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ebe970a21fso939350a34.2
        for <netfs@lists.linux.dev>; Fri, 14 Aug 2026 02:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698337; x=1787303137;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wbWqAAsFZY+VZeHO9DNgH/ZNhuxffmGdhf+iFEA1sE=;
        b=Oqbf+e/kbd15++EpKnZoPkbbFeSLVRtEyi+2UND6XleOUSP9+ah528KIH5g9c/p1CI
         PTpCu3mFfUMg0ZB2U/9eYVbxgx6gjuFYTcETqAXcsl58qFGRsdMQblVOEbDx6CwKiES4
         uQWXrswVwp7pAg7XvJ4GRb4BVdSUd/JyNMmkd7HFNTJNL7AV+8MC2dhrA4zzPHpDzhXN
         i5Vu4jWkgQ9k6837RHTdVoAwhnYwvEQq33zAndVAODukMqln/WF5BAiLI9ovv1gMTg0m
         og+QXKdwqAQE0IiiWeckyBFjwEkY+BHWIYj/ayGaR+1jLwjpsMgV7GXjp+awcg+WkA8J
         fyzQ==
X-Forwarded-Encrypted: i=1; AHgh+RovbQrKDKRW6zVKEsg83kXQLmr/SGnNA3AQ4972aLmxZG1Y9Bn67hvcddCArziE/APYQQy8Dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJwhkVOHckEQB/6WmRXIeH7/ea3OAqCheOdzqniZZzDot/Eqwc
	vlIVukszCyaaJKgocw9Lwu0gG36CDFsDklLbTAFdbKFB9lyzn4TQbkGvg1yvq8DyREj0R+fp9Pr
	/NhIM0HuQOdgucjbjQiel1DXQDHRbkt9tSARwC8KlsdIg8ejZ/Ejn46EydgM=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6aea:b0:6aa:d97f:453b with SMTP id
 006d021491bc7-6b0d68b223emr3642130eaf.28.1786698337436; Fri, 14 Aug 2026
 02:05:37 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:05:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7eda61.9ebadd4d.20b15e.0002.GAE@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in cachefiles_set_object_xattr
From: syzbot <syzbot+62b392c7348147ad767d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f1baf1fc892 Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1065f149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=62b392c7348147ad767d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1465f149580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62b392c7348147ad767d@syzkaller.appspotmail.com

evm: overlay not supported
==================================================================
BUG: KASAN: slab-out-of-bounds in __swab64p include/uapi/linux/swab.h:202 [inline]
BUG: KASAN: slab-out-of-bounds in __be64_to_cpup include/uapi/linux/byteorder/little_endian.h:75 [inline]
BUG: KASAN: slab-out-of-bounds in cachefiles_set_object_xattr+0x713/0x7a0 fs/cachefiles/xattr.c:88
Read of size 8 at addr ffff88801c329b52 by task kworker/u33:5/163

CPU: 3 UID: 0 PID: 163 Comm: kworker/u33:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: fscache fscache_cookie_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __swab64p include/uapi/linux/swab.h:202 [inline]
 __be64_to_cpup include/uapi/linux/byteorder/little_endian.h:75 [inline]
 cachefiles_set_object_xattr+0x713/0x7a0 fs/cachefiles/xattr.c:88
 cachefiles_commit_object fs/cachefiles/interface.c:319 [inline]
 cachefiles_clean_up_object fs/cachefiles/interface.c:344 [inline]
 cachefiles_withdraw_cookie+0x8f4/0xc50 fs/cachefiles/interface.c:381
 fscache_cookie_state_machine fs/netfs/fscache_cookie.c:780 [inline]
 fscache_cookie_worker+0x54f/0x1270 fs/netfs/fscache_cookie.c:835
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 163:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x322/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 cachefiles_set_object_xattr+0xef/0x7a0 fs/cachefiles/xattr.c:53
 cachefiles_commit_object fs/cachefiles/interface.c:319 [inline]
 cachefiles_clean_up_object fs/cachefiles/interface.c:344 [inline]
 cachefiles_withdraw_cookie+0x8f4/0xc50 fs/cachefiles/interface.c:381
 fscache_cookie_state_machine fs/netfs/fscache_cookie.c:780 [inline]
 fscache_cookie_worker+0x54f/0x1270 fs/netfs/fscache_cookie.c:835
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88801c329b40
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 18 bytes inside of
 allocated 22-byte region [ffff88801c329b40, ffff88801c329b56)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c329
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801bc42780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5919, tgid 5919 (dhcpcd-run-hook), ts 64295555076, free_ts 64295085659
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __kmalloc_cache_noprof+0x479/0x6c0 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 slab_free_hook mm/slub.c:2629 [inline]
 slab_free mm/slub.c:6377 [inline]
 kmem_cache_free+0x412/0x6b0 mm/slub.c:6504
 tear_down_vmas+0x2a5/0x600 mm/mmap.c:1262
 exit_mmap+0x469/0xa00 mm/mmap.c:1320
 __mmput+0x12a/0x410 kernel/fork.c:1187
 mmput+0x67/0x80 kernel/fork.c:1210
 exit_mm kernel/exit.c:615 [inline]
 do_exit+0x8b1/0x2ae0 kernel/exit.c:997
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1152
 __do_sys_exit_group kernel/exit.c:1163 [inline]
 __se_sys_exit_group kernel/exit.c:1161 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1161
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5919 tgid 5919 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 tlb_batch_list_free mm/mmu_gather.c:161 [inline]
 tlb_finish_mmu+0x27d/0x810 mm/mmu_gather.c:552
 exit_mmap+0x454/0xa00 mm/mmap.c:1313
 __mmput+0x12a/0x410 kernel/fork.c:1187
 mmput+0x67/0x80 kernel/fork.c:1210
 exit_mm kernel/exit.c:615 [inline]
 do_exit+0x8b1/0x2ae0 kernel/exit.c:997
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1152
 __do_sys_exit_group kernel/exit.c:1163 [inline]
 __se_sys_exit_group kernel/exit.c:1161 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1161
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801c329a00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88801c329a80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88801c329b00: fa fb fb fb fc fc fc fc 00 00 06 fc fc fc fc fc
                                                 ^
 ffff88801c329b80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88801c329c00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
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

Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27C31A071
	for <netfs@lists.linux.dev>; Thu,  4 Sep 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008111; cv=none; b=Od43bOG3IochvDuYs6vGJKr+fJLIDLz0sTIBGtQUf3UbSn/A6gpby1h7m/UaQn3Qnph8QtY8VyDU6tSTiew+rq7Pt9aYYKKaFeP9bZ6qAQqm/XNwLHhtkhgkNy6BdR4txXBqyAYsmhb/6bP7uuAAvoYK827BWS0vZ2HgeK/aj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008111; c=relaxed/simple;
	bh=Eo5PkbzjAOHY97S8uUo9ASpF6VTl0SxVkhrPDhMreco=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G6/kVd3CumVV6UsZI2JAefX5GImDc20GLk8iu16mW+q1ilM/lOy7onwnAwoXaGLKg0OsSQpaIZQZ/8l1/eOi1iz+8Je1nBhRL0KLEoyj+Ed5YUCDlHPLgSR/DZrSttnXnHf5/UHkZ5FAjBNHUBL2f/0gtNMjX36ywWASar7d1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3f66898cc14so12385645ab.3
        for <netfs@lists.linux.dev>; Thu, 04 Sep 2025 10:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008108; x=1757612908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+zOurPqmR97hG4tmCRiM4iRRtIBoeJhad60A7hG6t4=;
        b=lnT7MQhmCr1WVzq5nv5EKaL3O3EfPcfemd6Lds31yDUkz3v6xFeCNpHSCRi4qNr3aW
         SPz00L36hTzh7eUAgO8aVoHC370gUJbBJhpG6wVKA5KN6Ya5c5yGlgz6EXRM7Ty0cYY0
         LV+HvdhZ7i1d2xdnikYTTjrv7Wx/vy1y5L35oM5Fl3DMlY+h2Yb34b3feR4gpMiZuIMp
         lECTins8Yp3oNfE0jWoj2nTEHTiDAsdSr51zc4WMU+hIjqI5G4Ny2fS9mjDMGHhPBwzE
         3L5YNz/yws7FuXbnpOtth9yOTQVwgaHACKkCZuRNYDQ6bGUKZkIjZ86PaGjC5x7GFLAv
         IWag==
X-Forwarded-Encrypted: i=1; AJvYcCU+z0naBCn3xDTJrSCTA4RR1U+9OhgLH1+geYRWQ7muuF6ZxGpssKc5J00HY1xrjU7xaIlgDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr1zp/EHggH6gCpVUW6madUwpCQ4PSHJg+tX48GxBtiVyXzPwv
	tYM/QJXiq4i/Wzm5ay7yo0I85NPZGiuCuGlkWsnwLhKJ3huuUBzgi8LZQODiVVA5tNS3+sk45bP
	bFzPPhV2inrmuZCLybP0rlPF2FVXpcCGzTvKs/efjfWznxRF2LfjlIDJMS7U=
X-Google-Smtp-Source: AGHT+IHdxzAqvNc1kbRMPgppkI0daWBZ6pkUukZVCXOSmk/WxJVWw2hPzgQc4Ns1nF6XLrMw3L5B/LsXOYdmAyDOAvq8VTo5Z0b2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:470d:b0:3f6:5e1b:f1f3 with SMTP id
 e9e14a558f8ab-3f65e1bf224mr116169475ab.24.1757008107883; Thu, 04 Sep 2025
 10:48:27 -0700 (PDT)
Date: Thu, 04 Sep 2025 10:48:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b9d0eb.050a0220.192772.000c.GAE@google.com>
Subject: [syzbot] [netfs?] kernel BUG in netfs_perform_write
From: syzbot <syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b9a10f876409 Merge tag 'soc-fixes-6.17-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148b6312580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=b73c7d94a151e2ee1e9b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dd1a42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12eb0134580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f78fc7403c46/disk-b9a10f87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a6cdb7126dd0/vmlinux-b9a10f87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e315b6f116e/bzImage-b9a10f87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com

 kill_anon_super+0x3a/0x60 fs/super.c:1282
 v9fs_kill_super+0x3d/0xa0 fs/9p/vfs_super.c:195
 deactivate_locked_super+0xc1/0x1a0 fs/super.c:474
 deactivate_super fs/super.c:507 [inline]
 deactivate_super+0xde/0x100 fs/super.c:503
 cleanup_mnt+0x225/0x450 fs/namespace.c:1375
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1498!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6039 Comm: syz.0.22 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:folio_unlock mm/filemap.c:1498 [inline]
RIP: 0010:folio_unlock+0xb3/0xd0 mm/filemap.c:1493
Code: b3 5c c9 ff 48 89 ef 31 f6 e8 f9 ed ff ff 5b 5d e9 a2 5c c9 ff e8 9d 5c c9 ff 48 c7 c6 60 19 b9 8b 48 89 ef e8 0e 0d 12 00 90 <0f> 0b 48 89 df e8 d3 bb 2f 00 e9 7b ff ff ff 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc90002e97980 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802f3cc880 RSI: ffffffff81f231a2 RDI: ffff88802f3cccc4
RBP: ffffea0001850e80 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90ab5c97 R11: 0000000000000000 R12: ffff88805caf0f00
R13: ffffc90002e97de8 R14: ffffea0001850e80 R15: dffffc0000000000
FS:  000055555d2d5500(0000) GS:ffff8881246b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0071b4000 CR3: 000000007d73b000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 netfs_perform_write+0xacd/0x1e60 fs/netfs/buffered_write.c:407
 netfs_buffered_write_iter_locked fs/netfs/buffered_write.c:452 [inline]
 netfs_file_write_iter+0x495/0x570 fs/netfs/buffered_write.c:491
 v9fs_file_write_iter+0x9b/0x100 fs/9p/vfs_file.c:407
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1f5f98ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd97e08798 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1f5fbc5fa0 RCX: 00007f1f5f98ebe9
RDX: 0000000000000018 RSI: 0000200000000380 RDI: 0000000000000007
RBP: 00007f1f5fa11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1f5fbc5fa0 R14: 00007f1f5fbc5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_unlock mm/filemap.c:1498 [inline]
RIP: 0010:folio_unlock+0xb3/0xd0 mm/filemap.c:1493
Code: b3 5c c9 ff 48 89 ef 31 f6 e8 f9 ed ff ff 5b 5d e9 a2 5c c9 ff e8 9d 5c c9 ff 48 c7 c6 60 19 b9 8b 48 89 ef e8 0e 0d 12 00 90 <0f> 0b 48 89 df e8 d3 bb 2f 00 e9 7b ff ff ff 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc90002e97980 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802f3cc880 RSI: ffffffff81f231a2 RDI: ffff88802f3cccc4
RBP: ffffea0001850e80 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90ab5c97 R11: 0000000000000000 R12: ffff88805caf0f00
R13: ffffc90002e97de8 R14: ffffea0001850e80 R15: dffffc0000000000
FS:  000055555d2d5500(0000) GS:ffff8881246b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0071b4000 CR3: 000000007d73b000 CR4: 00000000003526f0


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

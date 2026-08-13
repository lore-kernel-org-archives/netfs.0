Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65D647F793
	for <netfs@lists.linux.dev>; Thu, 13 Aug 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630660; cv=none; b=MQckm2KJ8oS8F4BmyByLxcCn5qdfRQBaN1XLq/ixVxNFuGqssIn5Ex3MPGIQ2E6V+vBIGRkzAPnoD1Bq9DwIbXxGfY7uUeM8pAiO9hwZ2yktFW7ui+UrmSD49Xy7kvuufnznzlkYiqCkLfRp7oQfZhgOnxt1xXmkgXLzsz240gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630660; c=relaxed/simple;
	bh=7cSh+ZOQF1ttbEyvZ7deQKVt8lNMVdXBvyaQ+X2LFb8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ep72P06B12rKcBX15Hjk4OGMF9i4Qa2CoHezyD9cgvKgFwr7iIl1EjswtY1s2Cw8w//nP4ps7AGVFwo9lcVMjBxZetNFS0CDTUu5a52jaCZk1AO9J5IaVnEIjPjhYqnc4znebY6o/bcCK/KIwQyiub4gVbkUDjOsbfRBdhIQ1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6afead7b341so592182eaf.3
        for <netfs@lists.linux.dev>; Thu, 13 Aug 2026 07:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786630658; x=1787235458;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7683axQu9MaY5QNr0NUtJI9WWdu74T+AfXLHQ04040=;
        b=Phiq/CgJ6VPtGlc4j09vXfpjLBG+RwtXQQgLD445roVFzOjWT3t+hb1Ki84oQvT73c
         KyOaYbwnfelh6SwDzIy0ocwnAh3C4yL0AbFnAcJRpzNKlN2hsCVncjOduGh1qGAMBLEw
         mSC1qPG5U1mojVAp5DwovmqnPuqaATxtwaCkkllT/0OWebtNHZFVIqg+r9t+Sz2denVR
         LH2Qjcn67jmqos0AQHha+gMvwdf6xTrqCJTeRA+A4ft7RepI8eDzPXBgM1v+mRnPVlie
         ZomSoPsUPFIhxdvIBUjv2UhrMvOii7327qFUN8jpwnSdadIm2v7heWggossd78DRVPi4
         CuWw==
X-Forwarded-Encrypted: i=1; AHgh+Roszkl0WYrDsAtmJ6MC92INz7rtQuq1C3S/pC2PKBOByTPEDX/qbKbp4vBbH1gqZFJYdvkMVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyto1A5Tm0UZdYnVp0SmJLPcMF6oad2B3Egrf7RvJdmmY1KMecH
	d2QThc9mdu5Ca5lreNv3IRg280raHKgsEJ0zm3t7BLwGj+7JYBwWmcay778CnMr0ZoCG9Tl+64H
	t/KDp2D9/n+UyMjNC45qpsoMqEoWlQ0lWZubD+J9EQZIvo7/L5UUBa6u4OdA=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a4:b0:6ae:90c3:32b6 with SMTP id
 006d021491bc7-6b0c41afa19mr4804450eaf.1.1786630657713; Thu, 13 Aug 2026
 07:17:37 -0700 (PDT)
Date: Thu, 13 Aug 2026 07:17:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7dd201.f70deec7.2acc03.0008.GAE@google.com>
Subject: [syzbot] [netfs?] general protection fault in netfs_prepare_write
From: syzbot <syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14832c79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=6a13fc77eb6f0802be2d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12832c79580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com

RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2bf1f9f288
R13: 0000000000000005 R14: 0000000000000000 R15: 00007f2bf1fa3252
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000015: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000000a8-0x00000000000000af]
CPU: 3 UID: 0 PID: 6023 Comm: syz-executor218 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:netfs_prepare_write+0xbc/0x7b0 fs/netfs/write_issue.c:173
Code: e1 07 38 ca 7f 08 84 d2 0f 85 04 06 00 00 48 8d bb ad 00 00 00 0f b6 45 52 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <0f> b6 14 11 48 89 f9 83 e1 07 38 ca 7f 08 84 d2 0f 85 c1 05 00 00
RSP: 0018:ffffc90003ea7b40 EFLAGS: 00010203
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000015
RDX: dffffc0000000000 RSI: ffffffff82cb9219 RDI: 00000000000000ad
RBP: ffff8880383da660 R08: 00000000ffffffff R09: fffffbfff1dbdcfe
R10: ffffffff8edee7f3 R11: 0000000000000000 R12: ffff8880383da580
R13: ffff8880383da738 R14: 000000000000001c R15: ffff8880383da6b2
FS:  000055558535c400(0000) GS:ffff8880d60ec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557b8da30300 CR3: 0000000028cd1000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 netfs_unbuffered_write+0x75c/0x2020 fs/netfs/direct_write.c:111
 netfs_unbuffered_write_iter_locked+0x7d6/0xa80 fs/netfs/direct_write.c:290
 netfs_unbuffered_write_iter+0x442/0x720 fs/netfs/direct_write.c:382
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2bf1f5355e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fffd127ea28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055558535c400 RCX: 00007f2bf1f5355e
RDX: 0000000000000004 RSI: 00007f2bf1fa31f6 RDI: 0000000000000005
RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2bf1f9f288
R13: 0000000000000005 R14: 0000000000000000 R15: 00007f2bf1fa3252
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_prepare_write+0xbc/0x7b0 fs/netfs/write_issue.c:173
Code: e1 07 38 ca 7f 08 84 d2 0f 85 04 06 00 00 48 8d bb ad 00 00 00 0f b6 45 52 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <0f> b6 14 11 48 89 f9 83 e1 07 38 ca 7f 08 84 d2 0f 85 c1 05 00 00
RSP: 0018:ffffc90003ea7b40 EFLAGS: 00010203
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000015
RDX: dffffc0000000000 RSI: ffffffff82cb9219 RDI: 00000000000000ad
RBP: ffff8880383da660 R08: 00000000ffffffff R09: fffffbfff1dbdcfe
R10: ffffffff8edee7f3 R11: 0000000000000000 R12: ffff8880383da580
R13: ffff8880383da738 R14: 000000000000001c R15: ffff8880383da6b2
FS:  000055558535c400(0000) GS:ffff8880d60ec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557b8da30300 CR3: 0000000028cd1000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	e1 07                	loope  0x9
   2:	38 ca                	cmp    %cl,%dl
   4:	7f 08                	jg     0xe
   6:	84 d2                	test   %dl,%dl
   8:	0f 85 04 06 00 00    	jne    0x612
   e:	48 8d bb ad 00 00 00 	lea    0xad(%rbx),%rdi
  15:	0f b6 45 52          	movzbl 0x52(%rbp),%eax
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx <-- trapping instruction
  2e:	48 89 f9             	mov    %rdi,%rcx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	38 ca                	cmp    %cl,%dl
  36:	7f 08                	jg     0x40
  38:	84 d2                	test   %dl,%dl
  3a:	0f 85 c1 05 00 00    	jne    0x601


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

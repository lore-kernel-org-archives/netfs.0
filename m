Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F491BC094
	for <netfs@lists.linux.dev>; Sun,  1 Dec 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733076930; cv=none; b=hI1krTf2gQZWe0HrFRcGlOd9MYRKvDKId74i2m89sihUz6piWO4AzR+F/QnTOt6gzkvO0EAEjD6KpcSyTbnAe0sYt7SZuocDgMnnN9Zyv/N9xHGjleBnFz7eoYXHmOnTSw7xsJLGtwo1i0elg1/viFxJgNAiABG9i3Bm4QTeIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733076930; c=relaxed/simple;
	bh=Qm6OLsuIxJ8I0u+ZD2CtmuobsW18gm+oqJ0SiZ+Mllk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tg+xuoyEea7KyNPrXjS/kUSMnDe5cURA7w+EiaVkjU/fhYedx0z2/oCkbq+wm0QaUJ0NwI7F0vLEPTFjE/IElyw0/VMU53dpSiqYSzn5KfrRAHZJLNjHz7cA0cwgpFz35PMbdn5vVhnP2T2uy/PnHPF5bQd+wkn95cl0dSie13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e1527971so20286225ab.0
        for <netfs@lists.linux.dev>; Sun, 01 Dec 2024 10:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733076927; x=1733681727;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfXWxKK2+ijvkbDiUUwCtHhzQL1apk9vqakJtaqZfgc=;
        b=KuNzA1mUS1fqBrnsmTfd8M4kGFYFqWiURyYdVl6LSY5w+voPpj3texgrBJQ90xrzRg
         lMHv/wT529fRGb5i5mGnE+jnkRRTA0TTJ3LZG977KwqhN8F2OavAAIodwJMZG6gPhi/b
         48aqCij/1ZWScKJie3awduH3KIWhZnHVeqMZhNIY7WLL+AGv3NSxAl4+uBLIiRArIJUI
         dLT4g8Was9XlrulAOn2sktWFi0eTdoUaNkqhKaUMkCwHhzkioBl7/f1dg7mCU2CT9nzV
         7mu0Z1Y1xxlmRdXxrn+sJrKQx3MB1HeXHDFhRdYBGiD0579u8EnZbG07O9KetOcS5ygV
         SeKw==
X-Forwarded-Encrypted: i=1; AJvYcCUKV412/OpJP9kZOHhVDLlmaikWUwQ6VsHzEpywmjm2x6CscVBPmBSqOvY9kjNAM3PcJXQbuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzVr5gOKwx3aKyan903zRTe7EzIU8CcsctDn8nItqsL8YJM0fI
	FscOMyYcEMwe71kEB+twSzzupW/+wjPn2g6Ql1LWBRe/zfJ0ksYk6GEkq9InsTKLmyua8d2kFRi
	tEY6FvdIw5bvhLaim7Wun/8UKqlaIIEWONDana9bZGLKTX3PQhovR8Wc=
X-Google-Smtp-Source: AGHT+IFNUwNrHO3nfBaeEVSHwic7+12RpAhdgcQCUxJaqFwv/Qrn6SwhHR/iC0x9u/ILxjPdmovr0tivIV+6hfwqPQNgJU5rDERb
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3a7e0477ab5mr90652305ab.1.1733076927014; Sun, 01 Dec 2024
 10:15:27 -0800 (PST)
Date: Sun, 01 Dec 2024 10:15:26 -0800
In-Reply-To: <673ac3cd.050a0220.87769.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ca7be.050a0220.ad585.003c.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages
From: syzbot <syzbot+06023121b0153752a3d3@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=136ba7c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=06023121b0153752a3d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119abf78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1527dd30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06023121b0153752a3d3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 35 at fs/netfs/write_issue.c:583 netfs_writepages+0x8ff/0xb60 fs/netfs/write_issue.c:583
Modules linked in:
CPU: 1 UID: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-9p-1)
RIP: 0010:netfs_writepages+0x8ff/0xb60 fs/netfs/write_issue.c:583
Code: 10 4c 89 f2 48 8d 4c 24 70 e8 ad a6 85 ff 48 85 c0 0f 84 e6 00 00 00 48 89 c3 e8 cc dc 49 ff e9 4a fe ff ff e8 c2 dc 49 ff 90 <0f> 0b 90 e9 a9 fe ff ff e8 b4 dc 49 ff 4c 89 e7 be 08 00 00 00 e8
RSP: 0018:ffffc90000ab70c0 EFLAGS: 00010293
RAX: ffffffff8255983e RBX: 810f000000000000 RCX: ffff888020a9da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 810f000000000000
RBP: ffffc90000ab7190 R08: ffffffff825596e2 R09: 1ffff1100415a855
R10: dffffc0000000000 R11: ffffed100415a856 R12: ffff888020ad42d8
R13: dffffc0000000000 R14: ffffea0001b5e580 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f475ed5bd58 CR3: 00000000771b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_writepages+0x35f/0x880 mm/page-writeback.c:2702
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x820/0x1360 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2047
 wb_writeback+0x427/0xb80 fs/fs-writeback.c:2158
 wb_check_background_flush fs/fs-writeback.c:2228 [inline]
 wb_do_writeback fs/fs-writeback.c:2316 [inline]
 wb_workfn+0xc4b/0x1080 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

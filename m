Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E58156F2B
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918583; cv=none; b=n0fSxz0nl+D2/lVaJgaE3XPR1asDQJJavYOYjKkxSBGNpM3Jwuz0ZCqybslq6/h/DJw2oKGw40rw2iy/DhId+cznKTwZOmSYEcxZSAHCrb7YSyjADLDEwjMB+SiBQc0rTUT044IxZ7WIgJsELQWMuzmtoeKBABLuE/Yx8qCnJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918583; c=relaxed/simple;
	bh=clQzIEJlEygJfKk/lwY1Zo6DgY23EgtNhVpK+vtP2sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3gJ2KmkaxVPcRbaMbDN5K0vWidel82wS6GfGEqlpf6HdVens73uGL2HunMx91X4Yr9q6vpZTPtc0OkS9WBeTkQn9Qh7zOLCqwjCbUKFFaFnM2YdDYG/zRKeUcBVwbnS6RHkYLqYJdXEheJpRJVFeh0sg9sFDx0sSAHoEc0wNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uS2p7hcG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uS2p7hcG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724e1742d0dso1935298b3a.0
        for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 14:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732918581; x=1733523381; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxsZUVN8KZscsIKb3HLlxSbsnmv1lFqte9kn6WhunwM=;
        b=uS2p7hcGobKSlnARAptojNcDCirRqYb3f2oyfILIeX7O7T+4pgygxtEA4zNU8g7q7L
         glDTp/V8wB0t8SoU4VzffQ6IgOxG84H6/Nv30nZyHnC+VZCHT008RQb6mkZPSdStxObc
         MNLqyqxhmddIhpntVDpv33JrY71wegPa+wp8jQqhaVan1tH5qDk1tercd+brNEEAMFJq
         6ji7CJqHtbcg44igqFTh+dAA7yV2NoK09j1FSi+fb2H1Kvwc84bmmC2PsexiIiPElwBj
         egJfyh5Vwi/sG0b8eHeIoKgYq3HaW5z1uU6yQHQIiA+D+oFKs245R1Oqsrh1f/PR23Wm
         n/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732918581; x=1733523381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxsZUVN8KZscsIKb3HLlxSbsnmv1lFqte9kn6WhunwM=;
        b=MR5YQ2JgctULIAdlgER3f/BqQDEGDairfMVP1zTKltJ71tDGnFflzHrIv+FUQ/KuaR
         7JtcQJmhtRuCLac7VIMHZqVBkyL2YCNQT7bVBYUX1+VJxJ9FyuRyo7z9rtpvhdHXKL2X
         IhG/A729hCyxTIGTrqnWaN9KSOM07AP/umhtD/p2XQ/ilyZ5gXPtttwuY1KhXmYp87ce
         7c4gqdtAPAL2ASV7V9dCRUoUStnpcpjYNz0vZyl8u2tDbVMd1G/0crYKJbScQBrLZCK1
         RRYHFpBJ9AGnxXV1HLXXtZSpLuB5lBfmhAOw14597dB78BXUFvKxSz8gQmlkXpGDsxjt
         iXXA==
X-Forwarded-Encrypted: i=1; AJvYcCW3GxaSlPTmsXif/xnYAdoqtixQe50qBtZXoLjloPsokpuJgjPTc3Hin4YfLMf193ibodUgxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyOQxi0t0b+/4pXsfGRG5Y0DXWqaErbHiXTfuJZrhqEXfkBRAI
	IhCYQDYYuy0NsQb32mJAubimVPweKkeSLKhk9IMB5+QCwHr7ddSzAaMajSv2WmdPKyo7oC+AcGF
	qZWV+mrAKDAVJylkXCwKNlMDqovpporyDQC9J
X-Gm-Gg: ASbGncsq6nnYAfRK9kwkd7zeSGM0+CKwfO6Lc2UdlEK1YOTFggfx7c5GGAs6jwOXg+l
	O3TKQu8qA/wEC8hwg9QcFGRpBsTF07QWrxLpe3vZ8y60HFU/NtD1K011ic2HJ0iAV
X-Google-Smtp-Source: AGHT+IF131Zj5QA2D/jZY8ZIA/hIXIoUzblq3xPC6HUpQ+PzXA5h/65Qc9ysqz/3w1PjH/V8GLFe2jgCcTXaN19Uq0o=
X-Received: by 2002:a17:90b:3a84:b0:2ea:59c6:d6ed with SMTP id
 98e67ed59e1d1-2ee097bafb9mr16861342a91.30.1732918580450; Fri, 29 Nov 2024
 14:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67496cdc.050a0220.253251.00a5.GAE@google.com> <20241129185153.GA2768001@bhelgaas>
In-Reply-To: <20241129185153.GA2768001@bhelgaas>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 29 Nov 2024 23:16:08 +0100
Message-ID: <CANp29Y5ujSAQg4_dhoxQQFHeb15Eukkswrzv9uMiZ5m6y6z4uQ@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: syzbot <syzbot+fe139f9822abd9855970@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

The "#syz invalid" command tells syzbot that the whole bug report is
just a one-off false positive (that happens sometimes because of
memory corruptions -- the kernel just starts crashing in random
places). The bot then considers that the problem is gone and the next
time it sees a "WARNING in netfs_retry_reads" crash, it will report it
again as a totally new problem "WARNING in netfs_retry_reads (2)" and
so on.

So if it's e.g. just the bisection result that was wrong, while the
crash report itself is legit, it's better to not use the "#syz
invalid" command. I've added +1 to our backlog issue for adding a
special command to cancel only the misleading bisection result [1].

[1] https://github.com/google/syzkaller/issues/3491

--=20
Aleksandr

On Fri, Nov 29, 2024 at 7:51=E2=80=AFPM 'Bjorn Helgaas' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Thu, Nov 28, 2024 at 11:27:24PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    85a2dd7d7c81 Add linux-next specific files for 20241125
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10e3a5c0580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D45719eec4c7=
4e6ba
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfe139f9822abd=
9855970
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1334dee85=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14e3a5c0580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/5422dd6ada68/d=
isk-85a2dd7d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3a382ed71d3a/vmli=
nux-85a2dd7d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9b4d03eb0da3=
/bzImage-85a2dd7d.xz
> >
> > The issue was bisected to:
> >
> > commit fad610b987132868e3410c530871086552ce6155
> > Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Date:   Fri Oct 18 14:47:47 2024 +0000
> >
> >     Documentation PCI: Reformat RMW ops documentation
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16de1530=
580000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D15de1530=
580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11de1530580=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+fe139f9822abd9855970@syzkaller.appspotmail.com
> > Fixes: fad610b98713 ("Documentation PCI: Reformat RMW ops documentation=
")
>
> #syz invalid
>
> fad610b98713 touches only documentation, so the oops might be an
> intermittent problem elsewhere.  It's not likely to be related to
> fad610b98713; entire commit quoted below:
>
> commit fad610b98713 ("Documentation PCI: Reformat RMW ops documentation")
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Fri Oct 18 17:47:47 2024 +0300
>
>     Documentation PCI: Reformat RMW ops documentation
>
>     Extract the list of RMW protected PCIe Capability registers into a
>     bullet list to make them easier to pick up on a glance. An upcoming
>     change is going to add one more register among them so it will be muc=
h
>     cleaner to have them as bullets.
>
>     Link: https://lore.kernel.org/r/20241018144755.7875-2-ilpo.jarvinen@l=
inux.intel.com
>     Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Lukas Wunner <lukas@wunner.de>
>     Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
> diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pcie=
bus-howto.rst
> index f344452651e1..e48d01422efc 100644
> --- a/Documentation/PCI/pciebus-howto.rst
> +++ b/Documentation/PCI/pciebus-howto.rst
> @@ -217,8 +217,11 @@ capability structure except the PCI Express capabili=
ty structure,
>  that is shared between many drivers including the service drivers.
>  RMW Capability accessors (pcie_capability_clear_and_set_word(),
>  pcie_capability_set_word(), and pcie_capability_clear_word()) protect
> -a selected set of PCI Express Capability Registers (Link Control
> -Register and Root Control Register). Any change to those registers
> -should be performed using RMW accessors to avoid problems due to
> -concurrent updates. For the up-to-date list of protected registers,
> -see pcie_capability_clear_and_set_word().
> +a selected set of PCI Express Capability Registers:
> +
> +* Link Control Register
> +* Root Control Register
> +
> +Any change to those registers should be performed using RMW accessors to
> +avoid problems due to concurrent updates. For the up-to-date list of
> +protected registers, see pcie_capability_clear_and_set_word().
>
> > ------------[ cut here ]------------
> > do not call blocking ops when !TASK_RUNNING; state=3D2 set at [<fffffff=
f8177bd66>] prepare_to_wait+0x186/0x210 kernel/sched/wait.c:237
> > WARNING: CPU: 0 PID: 5848 at kernel/sched/core.c:8685 __might_sleep+0xb=
9/0xe0 kernel/sched/core.c:8681
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5848 Comm: syz-executor189 Not tainted 6.12.0-next-2=
0241125-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/13/2024
> > RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8681
> > Code: 93 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 fe 38 9b 00 48 8b 4d=
 00 48 c7 c7 80 2d 0a 8c 44 89 ee 48 89 ca e8 b8 e6 f0 ff 90 <0f> 0b 90 90 =
eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
> > RSP: 0018:ffffc90003e465a8 EFLAGS: 00010246
> > RAX: ff5208356e89db00 RBX: 1ffff1100fff22ed RCX: ffff88807ff90000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffff88807ff91768 R08: ffffffff81601b32 R09: fffffbfff1cfa218
> > R10: dffffc0000000000 R11: fffffbfff1cfa218 R12: dffffc0000000000
> > R13: 0000000000000002 R14: 000000000000004a R15: ffffffff8c1ca120
> > FS:  0000555573787380(0000) GS:ffff8880b8600000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ff2460a1104 CR3: 00000000745c2000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  wait_on_bit include/linux/wait_bit.h:74 [inline]
> >  netfs_retry_reads+0xde/0x1e00 fs/netfs/read_retry.c:263
> >  netfs_collect_read_results fs/netfs/read_collect.c:333 [inline]
> >  netfs_read_collection+0x33a0/0x4070 fs/netfs/read_collect.c:414
> >  netfs_wait_for_read+0x2ba/0x4e0 fs/netfs/read_collect.c:629
> >  netfs_unbuffered_read fs/netfs/direct_read.c:156 [inline]
> >  netfs_unbuffered_read_iter_locked+0x120e/0x1560 fs/netfs/direct_read.c=
:231
> >  netfs_unbuffered_read_iter+0xbf/0xe0 fs/netfs/direct_read.c:266
> >  __kernel_read+0x513/0x9d0 fs/read_write.c:523
> >  integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline=
]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0xae6/0x1b30 security/integrity/ima/ima_crypto.c:56=
8
> >  ima_collect_measurement+0x520/0xb10 security/integrity/ima/ima_api.c:2=
93
> >  process_measurement+0x1351/0x1fb0 security/integrity/ima/ima_main.c:37=
2
> >  ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
> >  security_file_post_open+0xb9/0x280 security/security.c:3121
> >  do_open fs/namei.c:3830 [inline]
> >  path_openat+0x2ccd/0x3590 fs/namei.c:3987
> >  do_filp_open+0x27f/0x4e0 fs/namei.c:4014
> >  do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
> >  do_sys_open fs/open.c:1417 [inline]
> >  __do_sys_open fs/open.c:1425 [inline]
> >  __se_sys_open fs/open.c:1421 [inline]
> >  __x64_sys_open+0x225/0x270 fs/open.c:1421
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7ff24603d929
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffe9079c548 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff24603d929
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000340
> > RBP: 00007ff24608a257 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000023fb0
> > R13: 00007ff2460bab40 R14: 00007ff2460bcd00 R15: 00007ffe9079c570
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/20241129185153.GA2768001%40bhelgaas.

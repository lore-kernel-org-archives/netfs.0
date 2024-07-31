Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BF1A76DA
	for <netfs@lists.linux.dev>; Wed, 31 Jul 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413789; cv=none; b=TNOp6bG3PcDUZUaPuECIX9rc77oX0WobLONyhoOKbIOlyX8GhQASn1gB185/y1YE+0+Ihu9p+Md0N18ieRD7xw2XAunmzRuSeuvMkV/K4We/IGGZGK4AaZOtuO8/eobrNvTO8eftccEfTspNYWppbI7pXg22I1EDABNnbdKHZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413789; c=relaxed/simple;
	bh=VRqKAJOy6m4p+YhsIn8BA6La5LcxiXKw7xYaFwK534M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXNwPBqaKS4nat6lcEgFzsA7lVWaiBi+KpN5IvNlElm62K+THO4RAcdurXtC3lCKg+n6rmjOi/5U9i2vpKAMQXHprpawK0sm58puRpnBQNcxkrEj5cjJYpShYYXzUVoWix6H3ni4pXKZRgrzASn6xFwBWk5cEApYWlAkoc7Jd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JSlSki91; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JSlSki91"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ad02501c3so680497566b.2
        for <netfs@lists.linux.dev>; Wed, 31 Jul 2024 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722413785; x=1723018585; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/fSCJ0gO5y0QMag6R2NrJhuJS3/7JER7LSWOIvnsvI=;
        b=JSlSki91wHR/caaFHx8YMaOOY0sLdqebJY3xLWvzReaoEErf5X3XPQC51T9WxsbQ7H
         1nSCdZosfQRrlfKK90ax8fNE6Pk2S0YtzAHoMXtWfmQf6gAyYYXi2eMaIvAXNXpoE5v4
         h3fFqjYynV7WWE1I24l6ersLFZYghmGRTOkRFXAofwXN+eIOOQpyFwKSBvR1Gg06QClE
         91gGCrctqheFf9QyaTmrMkYCL5+oOJzGZr0RhUQ05SYg1SoyBeif2VGvDP8HZmE7x6Pw
         FaAYsTwzNuxSHVbQfDe377UARpYY1vFta+UmG59b3iQiokm0e4KtxNXIRZsjG11wRtoK
         GckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722413785; x=1723018585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/fSCJ0gO5y0QMag6R2NrJhuJS3/7JER7LSWOIvnsvI=;
        b=XhzecpQfJ6kT7ZDx5UZBFtexL67o+dqGNhAKqaIfInLACsbwia1MFEjiA/DKk8uYgP
         as1I8GooHk0eVnEPlou7u3poBF4pxJ4L5vK9FOGnsdb8qWPKg4jKJa0FaG/T5ZVrwGTV
         +xKcxAF1nDlqYgrPRZACaUjrVxvcTvhK+0XxbRA/JYsCCcn71EDLkzkPiBTjgOvXgT/1
         NoN29dOX6Z38FoiITZ782rKhMoaCJH6fz/fFvfe+HAh0tJRW4zFou3KjKwOBwPKoZgs8
         +ZXq2MW0FnnlGmuh7AJlJhZL4HBuMPMqys1YhJNmhRunj/SOuY58EJtwm5qtqKTBteVD
         2CLg==
X-Forwarded-Encrypted: i=1; AJvYcCXbUAoMtDpLEKCXT9iud5m3mat1bHEnUS7alH7N9za8Ci03elV63vfslQlMDykE09ilHPBV2HwHrvf8J4eZt3hnWufskQ0=
X-Gm-Message-State: AOJu0Yx2lJ/ghxYQXLpn5KxP7PQBIZg/jLp6ihpmTU5qKWip2eznoq1o
	myuXL25woKdLIssJcJ6yPsrTgMtt6tVpOmTTtaZcUVN5lPd2K9mklyGHemk+wKo8Ed2hLBlJ6Zt
	OqI7YBCkKkJMyUnGMdrgztJo3o2m7AQfNL52yew==
X-Google-Smtp-Source: AGHT+IGMx4OsR5EFVYblD0lSG7d0iAtZq7q9ZxsA5v2ifPUDJLxXPMkDubiklXhu29AiH6QOnClEEMDErMS7Ph87Q94=
X-Received: by 2002:a17:907:2da0:b0:a77:dd1c:6276 with SMTP id
 a640c23a62f3a-a7d3fdb7ac7mr1210454866b.7.1722413785535; Wed, 31 Jul 2024
 01:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com>
 <3575457.1722355300@warthog.procyon.org.uk> <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
In-Reply-To: <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 31 Jul 2024 10:16:14 +0200
Message-ID: <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:28=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> If I understand this correctly, my other problem (the
> folio_attach_private conflict between netfs and ceph) I posted in
> https://lore.kernel.org/ceph-devel/CAKPOu+8q_1rCnQndOj3KAitNY2scPQFuSS-Ax=
eGru02nP9ZO0w@mail.gmail.com/
> was caused by my (bad) patch after all, wasn't it?

It was not caused by my bad patch. Without my patch, but with your
revert instead I just got a crash (this time, I enabled lots of
debugging options in the kernel, including KASAN) - it's the same
crash as in the post I linked in my previous email:

 ------------[ cut here ]------------
 WARNING: CPU: 13 PID: 3621 at fs/ceph/caps.c:3386
ceph_put_wrbuffer_cap_refs+0x416/0x500
 Modules linked in:
 CPU: 13 PID: 3621 Comm: rsync Not tainted 6.10.2-cm4all2-vm+ #176
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01=
/2014
 RIP: 0010:ceph_put_wrbuffer_cap_refs+0x416/0x500
 Code: e8 af 7f 50 01 45 84 ed 75 27 45 8d 74 24 ff e9 cf fd ff ff e8
ab ea 64 ff e9 4c fc ff ff 31 f6 48 89 df e8 3c 86 ff ff eb b5 <0f> 0b
e9 7a ff ff ff 31 f6 48 89 df e8 29 86 ff ff eb cd 0f 0b 48
 RSP: 0018:ffff88813c57f868 EFLAGS: 00010286
 RAX: dffffc0000000000 RBX: ffff88823dc66588 RCX: 0000000000000000
 RDX: 1ffff11047b8cda7 RSI: ffff88823dc66df0 RDI: ffff88823dc66d38
 RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff5f9a8cd
 R10: ffffffffafcd466f R11: 0000000000000001 R12: 0000000000000000
 R13: ffffea000947af00 R14: 00000000ffffffff R15: 0000000000000356
 FS:  00007f1e82957b80(0000) GS:ffff888a73400000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000559037dacea8 CR3: 000000013f1b2002 CR4: 00000000001706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __warn+0xc8/0x2c0
  ? ceph_put_wrbuffer_cap_refs+0x416/0x500
  ? report_bug+0x257/0x2b0
  ? handle_bug+0x3c/0x70
  ? exc_invalid_op+0x13/0x40
  ? asm_exc_invalid_op+0x16/0x20
  ? ceph_put_wrbuffer_cap_refs+0x416/0x500
  ? ceph_put_wrbuffer_cap_refs+0x2e/0x500
  ceph_invalidate_folio+0x241/0x310
  truncate_cleanup_folio+0x277/0x330
  truncate_inode_pages_range+0x1b4/0x940
  ? __pfx_truncate_inode_pages_range+0x10/0x10
  ? __lock_acquire+0x19f3/0x5c10
  ? __lock_acquire+0x19f3/0x5c10
  ? __pfx___lock_acquire+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  ? srso_alias_untrain_ret+0x1/0x10
  ? lock_acquire+0x186/0x490
  ? find_held_lock+0x2d/0x110
  ? kvm_sched_clock_read+0xd/0x20
  ? local_clock_noinstr+0x9/0xb0
  ? __pfx_lock_release+0x10/0x10
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ceph_evict_inode+0xd5/0x530
  evict+0x251/0x560
  __dentry_kill+0x17b/0x500
  dput+0x393/0x690
  __fput+0x40e/0xa60
  __x64_sys_close+0x78/0xd0
  do_syscall_64+0x82/0x130
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ? syscall_exit_to_user_mode+0x9f/0x190
  ? do_syscall_64+0x8e/0x130
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ? syscall_exit_to_user_mode+0x9f/0x190
  ? do_syscall_64+0x8e/0x130
  ? do_syscall_64+0x8e/0x130
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f1e823178e0
 Code: 0d 00 00 00 eb b2 e8 ff f7 01 00 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 44 00 00 80 3d 01 1d 0e 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
 RSP: 002b:00007ffe16c2e108 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
 RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f1e823178e0
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
 RBP: 00007f1e8219bc08 R08: 0000000000000000 R09: 0000559037df64b0
 R10: fe04b91e88691591 R11: 0000000000000202 R12: 0000000000000001
 R13: 0000000000000000 R14: 00007ffe16c2e220 R15: 0000000000000001
  </TASK>
 irq event stamp: 26945
 hardirqs last  enabled at (26951): [<ffffffffaaac5a99>]
console_unlock+0x189/0x1b0
 hardirqs last disabled at (26956): [<ffffffffaaac5a7e>]
console_unlock+0x16e/0x1b0
 softirqs last  enabled at (26518): [<ffffffffaa962375>] irq_exit_rcu+0x95/=
0xc0
 softirqs last disabled at (26513): [<ffffffffaa962375>] irq_exit_rcu+0x95/=
0xc0
 ---[ end trace 0000000000000000 ]---
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 BUG: KASAN: null-ptr-deref in ceph_put_snap_context+0x18/0x50
 Write of size 4 at addr 0000000000000356 by task rsync/3621

 CPU: 13 PID: 3621 Comm: rsync Tainted: G        W
6.10.2-cm4all2-vm+ #176
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01=
/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x74/0xd0
  kasan_report+0xb9/0xf0
  ? ceph_put_snap_context+0x18/0x50
  kasan_check_range+0xeb/0x1a0
  ceph_put_snap_context+0x18/0x50
  ceph_invalidate_folio+0x249/0x310
  truncate_cleanup_folio+0x277/0x330
  truncate_inode_pages_range+0x1b4/0x940
  ? __pfx_truncate_inode_pages_range+0x10/0x10
  ? __lock_acquire+0x19f3/0x5c10
  ? __lock_acquire+0x19f3/0x5c10
  ? __pfx___lock_acquire+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  ? srso_alias_untrain_ret+0x1/0x10
  ? lock_acquire+0x186/0x490
  ? find_held_lock+0x2d/0x110
  ? kvm_sched_clock_read+0xd/0x20
  ? local_clock_noinstr+0x9/0xb0
  ? __pfx_lock_release+0x10/0x10
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ceph_evict_inode+0xd5/0x530
  evict+0x251/0x560
  __dentry_kill+0x17b/0x500
  dput+0x393/0x690
  __fput+0x40e/0xa60
  __x64_sys_close+0x78/0xd0
  do_syscall_64+0x82/0x130
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ? syscall_exit_to_user_mode+0x9f/0x190
  ? do_syscall_64+0x8e/0x130
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ? syscall_exit_to_user_mode+0x9f/0x190
  ? do_syscall_64+0x8e/0x130
  ? do_syscall_64+0x8e/0x130
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f1e823178e0
 Code: 0d 00 00 00 eb b2 e8 ff f7 01 00 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 44 00 00 80 3d 01 1d 0e 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
 RSP: 002b:00007ffe16c2e108 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
 RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f1e823178e0
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
 RBP: 00007f1e8219bc08 R08: 0000000000000000 R09: 0000559037df64b0
 R10: fe04b91e88691591 R11: 0000000000000202 R12: 0000000000000001
 R13: 0000000000000000 R14: 00007ffe16c2e220 R15: 0000000000000001
  </TASK>

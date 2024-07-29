Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C278C9A
	for <netfs@lists.linux.dev>; Mon, 29 Jul 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248244; cv=none; b=NQYVQbfW+JQdKOkM6omyf1eXozZoJNg7j0VNXdp/qUZVs8m3oUtC5ufhhduAuoGL61agubBysQ0vOOjnLe+QmTe+L5siT1HsBtycYV4MNOBjCcT2Qjjrt/up46s8qtChZzIE5jzKPsp6xfBz1gvI7ilHEEbGEy6GY7Lfgjjjaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248244; c=relaxed/simple;
	bh=jzXG97HqPWVYU8NHMW+4Hs/kKhHz5TASHRFwrP5nf4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPwmBj47CD5wt+OCqkaqnkKK+6u7549GQB8zsgsHtW6DHdWpWhK+Fn/Yhynyw8ARTXU7DvOA5VEhgDM6DZf3he5vuE73PoHQpUTstIcf54PpoJysJHfK9AvH5kboDI7eS9+djAZrMSb8K08bJ2PMAaJELhbfiftjNkom3EPfHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IjBXY5J/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IjBXY5J/"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so438186166b.3
        for <netfs@lists.linux.dev>; Mon, 29 Jul 2024 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722248240; x=1722853040; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWANLo4eRjMcIZ8EuCsLzBr7AVx8n5Ln9Hy8TjY7UqM=;
        b=IjBXY5J/BjPMH5W9wYZlUQMJf8Knvliy2ZRsAxQYKKG/03cD8wGA4Y0eW9vOLD2ref
         A3UrO+7dfL5W+wD99gKU5zzwfFud60KQb/wnlepJSk7DbVujc3Mho6pbZtZFHOkjaJJf
         +z/lKG8MNcXmqgcV/hupL6ztyg+uS7ThvsMpGemwkA1JYSz9t3v1k9LIENfh94OUC0QC
         91LthsMIUNAQ78XVJj7bpaqLG3ik7+xVSNWYbJneEN5gF3yZWdY/yHdYXZV91dPO7jqs
         Go1LXv0sAFff484ZyOpExroegg1wnvrl10PZxh3QQnX8LbXkJN5YAOfJQeHVqdg9bmE/
         /W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248240; x=1722853040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWANLo4eRjMcIZ8EuCsLzBr7AVx8n5Ln9Hy8TjY7UqM=;
        b=UUtGSrJboEEm9CeQfn465RIwRZPEDGSc+Kq1oJQsIZLf/BF4zrj5pNN1vcshy29FHB
         9l+cC6GraVY9KsiqVVT6olqVEDbf//aD0Mft/k66zxc9czv8U33H91Uq8h0iQeIWZ805
         +VNfCd00ls4nYQRUnWyxR87LtHG/YWil/ErUiP7vLseZ8Lj/d5L0m75QX2qcIeJjDRfX
         dnzvQTT66BY5iN9bVqf8Uy0ipYs61kL21Tg5rNQjv6wD2XAa5K7wWBC/762vkxzQUWzs
         Qp12SqKEY9JlGo0laG8mAK5HQWdsRrWCJnyYvDKJagqLO/mFWcjKkjJxYhookXxlxSZd
         W9KA==
X-Forwarded-Encrypted: i=1; AJvYcCWLrJzL4rdxC6A8ECETyLUgatfcsl3NIR9nt37ggR6PinPRHsdD7FDqMiC7xSXBrGPYozI76g+lkTOcOQ0NfmfF53AVL8o=
X-Gm-Message-State: AOJu0YzSPalAYzSIwTLunVeaIwigv5Abb5U+SucbxSXiP5zoHDhLG77l
	H9uVPautsvKfaNxkRwLd3l2erV2Xy3ZV32bMi/G98EJdNrcT61J2gG0j1Qz2ll7F3efsqgTURzC
	X9Px07WtttqGLriGcGFb8V+93YWKOIwPb4imelQ==
X-Google-Smtp-Source: AGHT+IE8RWxrTgVdSBtvCEBCbzWs0T9CYvRFXeg3zq8/3QjJXhhhZPL50BiQ+DTswnbjSR6g/u2ccWzWojNCg41j0dU=
X-Received: by 2002:a17:907:9486:b0:a7a:bd5a:1ec0 with SMTP id
 a640c23a62f3a-a7d40042964mr491050866b.29.1722248240568; Mon, 29 Jul 2024
 03:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
 <CAKPOu+8s3f8WdhyEPqfXMBrbE+j4OqzGXCUv=rTTmWzbWvr-Tg@mail.gmail.com>
In-Reply-To: <CAKPOu+8s3f8WdhyEPqfXMBrbE+j4OqzGXCUv=rTTmWzbWvr-Tg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 12:17:09 +0200
Message-ID: <CAKPOu+9xQXpYndbeCdx-sDZb1ZF3q5R-KC-ZYv_Z1nRezTn2fQ@mail.gmail.com>
Subject: Re: RCU stalls and GPFs in ceph/netfs
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:18=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
> I posted two candidate patches which both fix this bug;
>
> Minimal fix: https://lore.kernel.org/lkml/20240729090639.852732-1-max.kel=
lermann@ionos.com/
> Fix which removes a bunch of obsolete code:
> https://lore.kernel.org/lkml/20240729091532.855688-1-max.kellermann@ionos=
.com/

These patches do fix the RCU stall bug (and should be merged), but
after running one cluster with my patch for a while, I found more Ceph
crashes:

 ------------[ cut here ]------------
 WARNING: CPU: 3 PID: 1925 at fs/ceph/caps.c:3386
ceph_put_wrbuffer_cap_refs+0x1bb/0x1f0
 Modules linked in:
 CPU: 3 PID: 1925 Comm: kworker/3:2 Not tainted 6.10.2-cm4all1-vm+ #168
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01=
/2014
 Workqueue: ceph-cap ceph_cap_reclaim_work
 RIP: 0010:ceph_put_wrbuffer_cap_refs+0x1bb/0x1f0
 Code: 30 45 89 f5 bd 01 00 00 00 41 83 c6 01 31 d2 e9 fa fe ff ff 45
8d 6e ff 31 ed 31 d2 48 83 bb 18 04 00 00 00 0f 84 e4 fe ff ff <0f> 0b
e9 dd fe ff ff 45 8d 6e ff bd 01 00 00 00 ba 01 00 00 00 48
 RSP: 0018:ffffb9a7406cba78 EFLAGS: 00010282
 RAX: ffff9a2d42b7eb20 RBX: ffff9a2d42b7e688 RCX: ffffdbdadc446d80
 RDX: 0000000000000000 RSI: ffff9a2d42b7eb18 RDI: ffff9a2d42b7e940
 RBP: 0000000000000000 R08: ffffffffffffffc0 R09: ffff9a2d4254fc40
 R10: 0000000000000020 R11: fefefefefefefeff R12: ffff9a2d42b7e940
 R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff9a384eec0000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055b248c82657 CR3: 000000010d31c002 CR4: 00000000001706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __warn+0x7c/0x110
  ? ceph_put_wrbuffer_cap_refs+0x1bb/0x1f0
  ? report_bug+0x14c/0x170
  ? handle_bug+0x3c/0x70
  ? exc_invalid_op+0x13/0x60
  ? asm_exc_invalid_op+0x16/0x20
  ? ceph_put_wrbuffer_cap_refs+0x1bb/0x1f0
  ? ceph_put_wrbuffer_cap_refs+0x27/0x1f0
  ceph_invalidate_folio+0x9a/0xc0
  truncate_cleanup_folio+0x52/0x90
  truncate_inode_pages_range+0xfe/0x400
  ceph_evict_inode+0x40/0x200
  evict+0xc5/0x170
  __dentry_kill+0x6e/0x160
  dput+0xcb/0x180
  __dentry_leases_walk+0x28d/0x430
  ceph_trim_dentries+0xac/0x100
  ceph_cap_reclaim_work+0x15/0x50
  process_one_work+0x138/0x2e0
  worker_thread+0x2b9/0x3d0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---
 BUG: kernel NULL pointer dereference, address: 0000000000000356
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0002 [#1] SMP PTI
 CPU: 3 PID: 1925 Comm: kworker/3:2 Tainted: G        W
6.10.2-cm4all1-vm+ #168
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01=
/2014
 Workqueue: ceph-cap ceph_cap_reclaim_work
 RIP: 0010:ceph_put_snap_context+0xf/0x30
 Code: 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 48 85 ff 74 12 b8 ff ff ff ff <f0> 0f
c1 07 83 f8 01 74 09 85 c0 7e 0a c3 cc cc cc cc e9 3a 62 70
 RSP: 0018:ffffb9a7406cbaa8 EFLAGS: 00010206
 RAX: 00000000ffffffff RBX: ffffdbdadc4465c0 RCX: ffffdbdadc446d80
 RDX: 0000000000000000 RSI: ffff9a2d42b7eb18 RDI: 0000000000000356
 RBP: 0000000000001000 R08: ffffffffffffffc0 R09: ffff9a2d4254fc40
 R10: 0000000000000020 R11: fefefefefefefeff R12: 0000000000000356
 R13: ffff9a2d42b7e688 R14: ffffffffffffffff R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff9a384eec0000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000356 CR3: 000000010d31c002 CR4: 00000000001706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x158/0x450
  ? search_extable+0x22/0x30
  ? ceph_put_snap_context+0xf/0x30
  ? search_module_extables+0xe/0x40
  ? exc_page_fault+0x62/0x120
  ? asm_exc_page_fault+0x22/0x30
  ? ceph_put_snap_context+0xf/0x30
  ceph_invalidate_folio+0xa2/0xc0
  truncate_cleanup_folio+0x52/0x90
  truncate_inode_pages_range+0xfe/0x400
  ceph_evict_inode+0x40/0x200
  evict+0xc5/0x170
  __dentry_kill+0x6e/0x160
  dput+0xcb/0x180
  __dentry_leases_walk+0x28d/0x430
  ceph_trim_dentries+0xac/0x100
  ceph_cap_reclaim_work+0x15/0x50
  process_one_work+0x138/0x2e0
  worker_thread+0x2b9/0x3d0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 CR2: 0000000000000356
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:ceph_put_snap_context+0xf/0x30
 Code: 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 48 85 ff 74 12 b8 ff ff ff ff <f0> 0f
c1 07 83 f8 01 74 09 85 c0 7e 0a c3 cc cc cc cc e9 3a 62 70
 RSP: 0018:ffffb9a7406cbaa8 EFLAGS: 00010206
 RAX: 00000000ffffffff RBX: ffffdbdadc4465c0 RCX: ffffdbdadc446d80
 RDX: 0000000000000000 RSI: ffff9a2d42b7eb18 RDI: 0000000000000356
 RBP: 0000000000001000 R08: ffffffffffffffc0 R09: ffff9a2d4254fc40
 R10: 0000000000000020 R11: fefefefefefefeff R12: 0000000000000356
 R13: ffff9a2d42b7e688 R14: ffffffffffffffff R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff9a384eec0000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000356 CR3: 000000010d31c002 CR4: 00000000001706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 note: kworker/3:2[1925] exited with irqs disabled

The bug hunt continues.

Max

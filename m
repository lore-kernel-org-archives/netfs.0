Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695E14EC5D
	for <netfs@lists.linux.dev>; Mon, 14 Oct 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894250; cv=none; b=nRU2I1U+wyG6bE5XhRHf4JUmK1M/swloBTCtACGtUxHEIeYq2A0pUxA528+Tt2nyq3Qk3V8JpUvUTY5oIyhhWIgeaglRfBZRpGfTorkryzXJD6eWTIFaNo475QbQXokJBRheIVQFKOet4KczyZv4a95iXpFOlfWt6U3psZHBiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894250; c=relaxed/simple;
	bh=HFT9h1iwDbbGGqhuLYDes10rtPk+7HF11pTDotWn1ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixGO7IZWpPzJ1xmJgH1K1Dc9jgR1UronNNA6zbQYxO7bz+uJHpDUEDiN61shG69TyJiqXNqzKJ+PC4pBU7B5sDWuRscoHRGhyF2in45S3vMlv8ls85P/ScAiK0CuAcz52cCoxN2nuInDSnVV1FK2JNGUs/BXo/Lg5P12bVPhiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrnzG9u9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrnzG9u9"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso34620101fa.0
        for <netfs@lists.linux.dev>; Mon, 14 Oct 2024 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728894246; x=1729499046; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6jtpd6aBQ5+6Ifa9J9iKjXNdXlmp6ptoc+HtBMR1fs=;
        b=zrnzG9u91fRYXpGz+Jdcs+2LRhiOnzUR6HgirR+azGzXMtOfvPSunJPQc7w55JSoRq
         WNnWnQjkSKKlWExG4LtBr64uY8CvSJXl9Lh0AxICQST1G+vVQT7/L600mWsw1ccfgniK
         OpaxdzDt1j8PPM9BC9f9dcWJYO7TWtHwYtAjuetwr7rhZOI6dAmosORPWnRJgseMpSze
         Uqlp2/oUglh6ocT+GexP00MUNelixNtfpP3BpwT8OX7AYRHCfbX4V45TBb2fekFWjKpb
         HbtkS/e4TdsPmp3Fu1xBVQqkHbe47tW0bHUjFORXp9NuxTmHq5C5HJgo7782sHqIRetk
         LGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894246; x=1729499046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6jtpd6aBQ5+6Ifa9J9iKjXNdXlmp6ptoc+HtBMR1fs=;
        b=oLCq19OiDwePurmgLmNstYamBwZ74MPnsINTK6gOT958SL3THZ03B0M4z0g6+RJ02S
         exKg1TxyvWhM3ac3jQjfXkaqYktXsg+D8tMlpqtmMBuzCRhVRR8YM694wtTuVEOz4kLQ
         YdLN6OASPR5L9jQoOdzBjEuc6FLuRqlm+/FM1CK0f29AhRv+w53NEGdNl5B598X/jbyn
         svTZdmz+fqN4Bf5S9xGw9J0fSkZRW88Gi0WHzB7fTYshZo+cbldWY6VOzWhoxZKEGS+r
         EUjbQj0LS2aWSl4Xlr5xFRb3i6Z4BCwRHRu75h1yp3mPKiHiLGe2CoUT/0Sb2MLJHk8m
         U2OA==
X-Forwarded-Encrypted: i=1; AJvYcCV+IIZYPEanxICG+BFObkzN4OUW51F0DbDUyqxX5csonN4UnfxsflZ42JaYAUpxaWco/eD2rA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4VDnBRlTT3suCPrxzrvxWuf9WrnTQpUiryhAhcoNydQqX+YZ2
	JF0f6nie3taeJfjNDAEwLAnBzHRvM/f6X4i2NHQltLdQtBAzVfVKlq1VrEX7HJveu6oMXKqnsPi
	1Gbx7ZXpZUjt0CniXs0FJE8dqg3EO+U18MCSF
X-Google-Smtp-Source: AGHT+IEIr3NQylCfcrZzzzlzR4+C9G7lQob/gAkh6rW7SnRgALtyVccRYC6I/9Z9kVu3Y1H0WliHmqAYbkvTrWhn1ck=
X-Received: by 2002:a2e:b892:0:b0:2fa:d354:1435 with SMTP id
 38308e7fff4ca-2fb325d4154mr41752831fa.0.1728894245639; Mon, 14 Oct 2024
 01:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <670cb3bd.050a0220.4cbc0.0040.GAE@google.com>
In-Reply-To: <670cb3bd.050a0220.4cbc0.0040.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Oct 2024 10:23:54 +0200
Message-ID: <CACT4Y+Ya4i3JwDghU1efqDETwyPGn3gwA5MHVj2-P65ku8nYjA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in compat_sys_open
To: syzbot <syzbot+0e1748603cc9f2dfc87d@syzkaller.appspotmail.com>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 08:01, syzbot
<syzbot+0e1748603cc9f2dfc87d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    27cc6fdf7201 Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13043307980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3e4d87a80ed4297
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e1748603cc9f2dfc87d
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-27cc6fdf.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ae2f7d656e32/vmlinux-27cc6fdf.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1b06a62cc1e5/bzImage-27cc6fdf.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0e1748603cc9f2dfc87d@syzkaller.appspotmail.com
>
> BUG: TASK stack guard page was hit at ffffc90002b3ffb8 (stack is ffffc90002b40000..ffffc90002b48000)
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 12425 Comm: syz.2.2179 Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
> Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 38 51 57
> RSP: 0018:ffffc90002b3ffc0 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000003
> RDX: dffffc0000000000 RSI: ffff888021edaf98 RDI: ffff888021eda440
> RBP: ffffc90002b40100 R08: 0000000000000000 R09: 0000000000000006
> R10: ffffffff9698ad37 R11: 0000000000000002 R12: dffffc0000000000
> R13: ffff888021edaf98 R14: 0000000000000008 R15: ffff888021eda440
> FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f56f6b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: ffffc90002b3ffb8 CR3: 000000005f61e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <#DF>
>  </#DF>
>  <TASK>
>  mark_usage kernel/locking/lockdep.c:4646 [inline]
>  __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
>  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
>  rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  page_ext_get+0x3a/0x310 mm/page_ext.c:525
>  __set_page_owner+0x9a/0x790 mm/page_owner.c:322
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x223/0x25c0 mm/page_alloc.c:4733
>  alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>  alloc_slab_page mm/slub.c:2412 [inline]
>  allocate_slab mm/slub.c:2578 [inline]
>  new_slab+0x2ba/0x3f0 mm/slub.c:2631
>  ___slab_alloc+0xd1d/0x16f0 mm/slub.c:3818
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4141
>  p9_tag_alloc+0x9c/0x870 net/9p/client.c:281
>  p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
>  p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
>  p9_client_read_once+0x443/0x820 net/9p/client.c:1560
>  p9_client_read+0x13f/0x1b0 net/9p/client.c:1524
>  v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
>  netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
>  netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232

+netfs maintainers, looks like infinite recursion in netfs code

#syz set subsystems: netfs

>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
>  netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
>  netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
>  netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
>  v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
>  __kernel_read+0x3f1/0xb50 fs/read_write.c:527
>  integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
>  ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
>  process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0x8e/0x210 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x1419/0x2d60 fs/namei.c:3933
>  do_filp_open+0x1dc/0x430 fs/namei.c:3960
>  do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_compat_sys_open fs/open.c:1481 [inline]
>  __se_compat_sys_open fs/open.c:1479 [inline]
>  __ia32_compat_sys_open+0x147/0x1e0 fs/open.c:1479
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf740e579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f56f656c EFLAGS: 00000296 ORIG_RAX: 0000000000000005
> RAX: ffffffffffffffda RBX: 0000000020000240 RCX: 0000000000000b00
> RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
> Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 38 51 57
> RSP: 0018:ffffc90002b3ffc0 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000003
> RDX: dffffc0000000000 RSI: ffff888021edaf98 RDI: ffff888021eda440
> RBP: ffffc90002b40100 R08: 0000000000000000 R09: 0000000000000006
> R10: ffffffff9698ad37 R11: 0000000000000002 R12: dffffc0000000000
> R13: ffff888021edaf98 R14: 0000000000000008 R15: ffff888021eda440
> FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f56f6b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: ffffc90002b3ffb8 CR3: 000000005f61e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   55                      push   %rbp
>    6:   48 89 e5                mov    %rsp,%rbp
>    9:   41 57                   push   %r15
>    b:   41 56                   push   %r14
>    d:   41 89 d6                mov    %edx,%r14d
>   10:   48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
>   17:   fc ff df
>   1a:   41 55                   push   %r13
>   1c:   41 54                   push   %r12
>   1e:   53                      push   %rbx
>   1f:   48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
>   23:   48 81 ec 10 01 00 00    sub    $0x110,%rsp
> * 2a:   48 c7 44 24 30 b3 8a    movq   $0x41b58ab3,0x30(%rsp) <-- trapping instruction
>   31:   b5 41
>   33:   48 8d 44 24 30          lea    0x30(%rsp),%rax
>   38:   48                      rex.W
>   39:   c7                      .byte 0xc7
>   3a:   44 24 38                rex.R and $0x38,%al
>   3d:   38 51 57                cmp    %dl,0x57(%rcx)
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/670cb3bd.050a0220.4cbc0.0040.GAE%40google.com.

Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D020B211
	for <netfs@lists.linux.dev>; Tue, 12 Nov 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397160; cv=none; b=e8FG4Lj0fD3zUXm3LMMbnF2ZdtudjZL3l11m3YNOWHpTv0bqgocIT9/WtrezJ7c8AMDdrh49T8+Pnea3J6mS15zHAYE5owBA3pcq2j8hprodtSBfGxoTI7zZqF+9E92AtX/LIuFa6x4xk6Xrjb/P2svNAj4gCmYenO/lhOqB1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397160; c=relaxed/simple;
	bh=brBHJST56CYaqnqRiBhljn11q0BksuZqYu1hezt+BIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F/3xjqphU6goNhqdIyxxeJx7f3qB3rsdmj3biPHeHzZ82V8cE/dCgq2IniZS4WUvLiqTcrmlVa4n8aAiBWaVgAKWOkVcwL7xBs+ZeEh6gNNigzo2s7+uCpRKu179bjm5shdgwvm07c0/UH3h4r0Opb9ga2eGmIPGbfnkzP/wn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DFqzJz06; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DFqzJz06"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99f646ff1bso804743166b.2
        for <netfs@lists.linux.dev>; Mon, 11 Nov 2024 23:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1731397156; x=1732001956; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfcnEOaKbauAnD+2AGNlRSuuYiOZTGy8vLgvL8NgRZM=;
        b=DFqzJz06IDvRYS3RDsTEXCvwGJwvuS7/Ck40O6Hu2YOLoavTMp/BXX32/SNFai2Qug
         JKFTcqFXkD8ApK4FqxB/GStN4d07KvX/Ktk2FlIYyLjjiAlG+VOjhQxstJV6eKgv2J8z
         qXUM6OGXvfYQc8zbbqaahp2EjiASTXNo7KLQI0CrawY6eQ7aoAavsyNfhdqu88MDIe9g
         ysPQlXE30rkrIHk7djtmR5TWbkn87a0jZbWTsUIaD51mTrzNoZlNQq3O8DYVKDRqR0jY
         AqlGbejO/uTjFlmzH7QW5Z0j7nnFIg99v4GbuCF0Nxx6FMJHyn8fen67ys/td2kS0HqT
         Bwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731397156; x=1732001956;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfcnEOaKbauAnD+2AGNlRSuuYiOZTGy8vLgvL8NgRZM=;
        b=dbJFUZnkc9k/LCfG6qh3NadVeQBONvEr0B8xJHSaMUcY/fUUMw9MTANg9PngKwFYqF
         bPHItO63yW/Y5xVDqNEo7QbX+2rcTMtSKim75McS/kqFnolk05BQgy6OpfBSbZJeEscA
         dNWPTo7iWH8dE9fn3TD2O1lWaMMRkyU7j3MQ5iABh84i07Ugc3IKb+3a+hl3bVvrDfoy
         nnpgZ4XWUDEGwHV1xQ7uQdbnqLr9IqR+ppbAqlJyJ0V7xQtcQLHPswRYL+GfMw6Ffqhx
         Jr+Y5wd1X0kKUESKp6dfpFFR7F7hikk40+s6gZ8DlhOv7mnjkT0+qIg/jEspyALfIrbR
         OLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9rx5QR/YsPCxwEA8dZOmy7SgDerqBTFGzBOKwQXazvNc5KCs/MLjIn4b2JAz5Gi1p9nQdcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwteWhBrLIdx35DtGiECTzN+FwIkyTvtbV5ZEX2g1Ubk0rHXpRR
	aDgnwjPyT40OTHi07jpXzRmlxxU8fXLbwguGuBmfMAvQRMYHwkS/gRGzsMxoL6Oryg9GzVXH8bG
	lJEZLflAv0/mW+WSxhL0wVbhy0AIfBiF0UxOoEA==
X-Google-Smtp-Source: AGHT+IGDLlXQepJKnl19SVL5bGpUVYo9qmwPjkHvBTYefpFDgktT7J6AJaBvxOLyJLhbKETGj7/dsHkGOi1q0baPmR0=
X-Received: by 2002:a17:907:26c9:b0:a9e:d49e:c0aa with SMTP id
 a640c23a62f3a-aa1b1057df1mr183971366b.19.1731397156044; Mon, 11 Nov 2024
 23:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
 <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com>
In-Reply-To: <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 12 Nov 2024 08:39:05 +0100
Message-ID: <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
Subject: Re: Oops in netfs_rreq_unlock_folios_pgpriv2
To: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David,

It has been two weeks since my crash bug report. Our servers are still
crashing all the time, and instead of going back to 6.6, I have
enabled `panic_on_oops` so the servers reboot automatically, hoping
that you would come up with a fix for the netfs regression soon, but I
cannot hold this up for much longer. Please help!

(Are we really the only ones experiencing this bug?)

Max

On Wed, Oct 30, 2024 at 11:23=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> David,
>
> Meanwhile, our servers crash many times a day due to this bug.
>
> The code was added by your commit 7b589a9b45a ("netfs: Fix handling of
> USE_PGPRIV2 and WRITE_TO_CACHE flags") after I found Ceph-related bugs
> in your commit 2ff1e97587f4 ("netfs: Replace PG_fscache by setting
> folio->private and marking dirty"). Since this fix, the Ceph problems
> were gone, but yesterday, out of the blue, the NFS-using server
> started crashing (after running stable with 6.11.5 for 5 days).
>
> We can't go back to 6.10 (EOL); the newest kernel prior to your
> refactoring was 6.9 which has been EOL since July, leaving a downgrade
> to 6.6 LTS as the only remaining option.
>
> Max
>
>
>
> On Tue, Oct 29, 2024 at 9:02=E2=80=AFAM Max Kellermann <max.kellermann@io=
nos.com> wrote:
> >
> > Hi David,
> >
> > maybe this crash is related to your recent netfs refactoring work; it i=
s on
> > a server with heavy NFS traffic (with fscache enabled). The kernel is
> > 6.11.5 plus a dozen patches that are not relevant for NFS/netfs/fscache=
.
> >
> >  BUG: unable to handle page fault for address: 0000025882015121
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 0 P4D 0
> >  Oops: Oops: 0000 [#1] SMP PTI
> >  CPU: 11 UID: 0 PID: 247837 Comm: kworker/u193:32 Not tainted
> > 6.11.5-cm4all1-hp+ #219
> >  Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89
> > 10/17/2018
> >  Workqueue: nfsiod rpc_async_release
> >  RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >  Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 0=
0 00
> > 0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 =
ba
> > 00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
> >  RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
> >  RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
> >  RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
> >  RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
> >  R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
> >  R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
> >  FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
> > knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
> >  Call Trace:
> >   <TASK>
> >   ? __die+0x1f/0x60
> >   ? page_fault_oops+0x15c/0x450
> >   ? search_extable+0x22/0x30
> >   ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >   ? search_module_extables+0xe/0x40
> >   ? exc_page_fault+0x5e/0x100
> >   ? asm_exc_page_fault+0x22/0x30
> >   ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >   ? select_task_rq_fair+0x1ed/0x1370
> >   netfs_rreq_unlock_folios+0x40c/0x4b0
> >   netfs_rreq_assess+0x348/0x580
> >   netfs_subreq_terminated+0x193/0x2a0
> >   nfs_netfs_read_completion+0x97/0xb0
> >   nfs_read_completion+0x12e/0x200
> >   rpc_free_task+0x39/0x60
> >   rpc_async_release+0x2b/0x40
> >   process_one_work+0x134/0x2e0
> >   worker_thread+0x299/0x3a0
> >   ? __pfx_worker_thread+0x10/0x10
> >   kthread+0xba/0xe0
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0x30/0x50
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork_asm+0x1a/0x30
> >   </TASK>
> >  Modules linked in:
> >  CR2: 0000025882015121
> >  ---[ end trace 0000000000000000 ]---
> >  ERST: [Firmware Warn]: Firmware does not respond in time.
> >  pstore: backend (erst) writing error (-5)
> >  RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >  Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 0=
0 00
> > 0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 =
ba
> > 00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
> >  RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
> >  RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
> >  RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
> >  RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
> >  R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
> >  R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
> >  FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
> > knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
> >  note: kworker/u193:32[247837] exited with irqs disabled
> >
> >  (gdb) p netfs_rreq_unlock_folios_pgpriv2+0xd2
> >  $1 =3D (void (*)(struct netfs_io_request *, size_t *)) 0xffffffff813d8=
0c2
> > <netfs_rreq_unlock_folios_pgpriv2+210>
> >  (gdb) disassemble netfs_rreq_unlock_folios_pgpriv2+0xd2
> >  Dump of assembler code for function netfs_rreq_unlock_folios_pgpriv2:
> >  [...]
> >    0xffffffff813d8093 <+163>: call   0xffffffff81f0ec70 <xas_find>
> >    0xffffffff813d8098 <+168>: mov    (%rsp),%r8
> >    0xffffffff813d809c <+172>: test   %rax,%rax
> >    0xffffffff813d809f <+175>: mov    %rax,%r13
> >    0xffffffff813d80a2 <+178>: je     0xffffffff813d81e0
> > <netfs_rreq_unlock_folios_pgpriv2+496>
> >    0xffffffff813d80a8 <+184>: cmp    $0x406,%r13
> >    0xffffffff813d80af <+191>: je     0xffffffff813d81a7
> > <netfs_rreq_unlock_folios_pgpriv2+439>
> >    0xffffffff813d80b5 <+197>: cmp    $0x402,%r13
> >    0xffffffff813d80bc <+204>: je     0xffffffff813d82f7
> > <netfs_rreq_unlock_folios_pgpriv2+775>
> >    0xffffffff813d80c2 <+210>: mov    0x20(%r13),%rax
> >    0xffffffff813d80c6 <+214>: mov    $0x1000,%edx
> >    0xffffffff813d80cb <+219>: mov    0x0(%r13),%rcx
> >    0xffffffff813d80cf <+223>: shl    $0xc,%rax
> >    0xffffffff813d80d3 <+227>: and    $0x40,%ecx
> >    0xffffffff813d80d6 <+230>: je     0xffffffff813d80e0
> > <netfs_rreq_unlock_folios_pgpriv2+240>
> >    0xffffffff813d80d8 <+232>: movzbl 0x40(%r13),%ecx
> >    0xffffffff813d80dd <+237>: shl    %cl,%rdx
> >
> >
> > Right now, the machine is running and I have an unstripped kernel, just=
 in
> > case you need more information from /proc/kcore.
> >
> > Max
> >
> > [resent as text/plain only - damn you, gmail!]

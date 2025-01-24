Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574019A288;
	Fri, 24 Jan 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743272; cv=none; b=R8e25TVRuDF92q433/pKC/s+p2BXP9jQnWfWg8d9VLbWxinmiZVGuuDRLkY0qocY1TW1a1grQ+YuKNEw4j2nAhP6WkHFUPMD+fC1iZA9a9R3J4nK7TCjvrmkazbPnrMapZXzqGTzZt9lUbeNzyr7QyXi4Gt5TsrD44uNNc1iTEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743272; c=relaxed/simple;
	bh=7SJGTarCena5sQkQGIg9PWbim87EInIxo9wKw0XMZT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBWTYP5bGrcjUDdHEWsXPt59jFLrHgfYdC9KpS3om/5v6AMxvxZFhGOXg1afFfOj99gWUE68QAvC3AlSWAzU6p746NxXNfkUrmFcQ+jQNQL2MU4TczzHBW+rrOy38/gFrlGXFrBwV4BQWmeSIyFwwhkcZwoqbMSVwyEg2Oj7Ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so428696066b.2;
        Fri, 24 Jan 2025 10:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737743269; x=1738348069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXZkbsZymQDEeD5R6N901lei4FIsTKs9xGaTy0mc5JE=;
        b=vCeFs7zYZSkAhOBc7ABR8RP43n9SbxbKtvDAhp/8Ue2Py6Lk0Iw/Nqh9WBNO0svrDS
         eIccS8u431xP6ZAkKhACvvnvSaCTTscf6IfiDU/Zmv2QYNFcRPGxqwzZS6XaqXVXlVKu
         FQ5vK/FKdUvmP6So6szwhELRZkye4/9Okumuby9B+O8+DrG9A+ro56pvCpxId6LqAISn
         CrFfFG/F0YGLszHFeSzLuglKd3aJRw6uVq7XrIUQCjARSU4Kux71ogND4thml+UK6Ik5
         8opT7ReMTWlW8EZkF8lfNEq2bDB8Ptb2h9IUMRpsRdiAHhGFdUv0M/v+JSWD6KOtydoA
         tX7w==
X-Forwarded-Encrypted: i=1; AJvYcCUHFm98A4XMwwOTKw+7bW+wwGelPmmZIelx1opGj4rfdSb9E+izsL4QeYX4lcgjpZQsHDHBeQ==@lists.linux.dev, AJvYcCWJ37V4ReTG4gwRk4mUp27N3OvSrONL9ssOJhctvd952vZCWJJJN1C2Nd78K9A9GtlggaMAlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaK9baqQypCh5afuuqrp4vh7LcdPGwUVxmutvoBZFgjesrUbZV
	YWw5nLATT2klzgHHe2fcR4KdkSknZPQijCKg5O6+Du/nsfTB/nP8wYKr9vi302U=
X-Gm-Gg: ASbGnctSxy4NdS4xpsxiBfg/ueYrxQp9Zdfsm85spOAykPevH6/NXvVsDnOIv18aT6b
	qfv6GA7HtOQKr4R/k7MFeX8x5MakmntUEFy7uW9dwnkZzAmQ3Qw5Wl1pda1X6zij7WKDDx9CYOI
	xZ5JP4QhPVYOUtSEmPqJ9odDrvu7b5xZl8kBUrFMw6XAYmwpo4oFnhcru688gOjCPrlGFIF3nC5
	ouztkAcnFmsIvGmgnOI/CUK5v0S+E31zATJKckoOKb+LlE7gdzXjqx94WWdLhiBBicjYjtSYiGg
	LwiBIlOVLdzyFaFHDRvaa8d3Q3cY0uX60ZItJC7vI7pS4eK2
X-Google-Smtp-Source: AGHT+IHVgcmcT7qtGlPaV2uNKifyj1wqnDyhjaN0mJIgn1w79RnTabuzOy4otCPPpNrf9Z4YxLs9Ow==
X-Received: by 2002:a17:907:1c8b:b0:ab3:83c2:755a with SMTP id a640c23a62f3a-ab38b402651mr2999606866b.49.1737743268417;
        Fri, 24 Jan 2025 10:27:48 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e66aedsm166717466b.65.2025.01.24.10.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 10:27:48 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so428693566b.2;
        Fri, 24 Jan 2025 10:27:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCA2kJgf/zyQtYuriFYsccI3StNQLLgaxFctc6XcbOsvIgESLSpkqXZvSBNVCxjuNQjxRssw==@lists.linux.dev, AJvYcCXhMmQu5hIenG1f7mEctK+A2/a/N6kOcb4KhLYyH+rfLDCKRqYJqYsBR7mW1KkaLokQtS8Dgg==@lists.linux.dev
X-Received: by 2002:a17:907:7d9f:b0:aae:df74:acd1 with SMTP id
 a640c23a62f3a-ab38b0b9b7dmr3175435766b.11.1737742907278; Fri, 24 Jan 2025
 10:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com>
 <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
In-Reply-To: <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Fri, 24 Jan 2025 14:21:35 -0400
X-Gmail-Original-Message-ID: <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com>
X-Gm-Features: AWEUYZlb36GF3Tcj0JvJQORKz4x4XpHrlQbMsxXnEx1A7tVtE0HWDV4nwAVkVJo
Message-ID: <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only
 use one work item
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <christian@brauner.io>, 
	Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:00=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Monday, December 16th, 2024 at 12:41 PM, David Howells <dhowells@redha=
t.com> wrote:
>
> > Change the way netfslib collects read results to do all the collection =
for
> > a particular read request using a single work item that walks along the
> > subrequest queue as subrequests make progress or complete, unlocking fo=
lios
> > progressively rather than doing the unlock in parallel as parallel requ=
ests
> > come in.
> >
> > The code is remodelled to be more like the write-side code, though only
> > using a single stream. This makes it more directly comparable and thus
> > easier to duplicate fixes between the two sides.
> >
> > This has a number of advantages:
> >
> > (1) It's simpler. There doesn't need to be a complex donation mechanism
> > to handle mismatches between the size and alignment of subrequests and
> > folios. The collector unlocks folios as the subrequests covering each
> > complete.
> >
> > (2) It should cause less scheduler overhead as there's a single work it=
em
> > in play unlocking pages in parallel when a read gets split up into a
> > lot of subrequests instead of one per subrequest.
> >
> > Whilst the parallellism is nice in theory, in practice, the vast
> > majority of loads are sequential reads of the whole file, so
> > committing a bunch of threads to unlocking folios out of order doesn't
> > help in those cases.
> >
> > (3) It should make it easier to implement content decryption. A folio
> > cannot be decrypted until all the requests that contribute to it have
> > completed - and, again, most loads are sequential and so, most of the
> > time, we want to begin decryption sequentially (though it's great if
> > the decryption can happen in parallel).
> >
> > There is a disadvantage in that we're losing the ability to decrypt and
> > unlock things on an as-things-arrive basis which may affect some
> > applications.
> >
> > Signed-off-by: David Howells dhowells@redhat.com
> >
> > cc: Jeff Layton jlayton@kernel.org
> >
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> > fs/9p/vfs_addr.c | 3 +-
> > fs/afs/dir.c | 8 +-
> > fs/ceph/addr.c | 9 +-
> > fs/netfs/buffered_read.c | 160 ++++----
> > fs/netfs/direct_read.c | 60 +--
> > fs/netfs/internal.h | 21 +-
> > fs/netfs/main.c | 2 +-
> > fs/netfs/objects.c | 34 +-
> > fs/netfs/read_collect.c | 716 ++++++++++++++++++++---------------
> > fs/netfs/read_pgpriv2.c | 203 ++++------
> > fs/netfs/read_retry.c | 207 +++++-----
> > fs/netfs/read_single.c | 37 +-
> > fs/netfs/write_collect.c | 4 +-
> > fs/netfs/write_issue.c | 2 +-
> > fs/netfs/write_retry.c | 14 +-
> > fs/smb/client/cifssmb.c | 2 +
> > fs/smb/client/smb2pdu.c | 5 +-
> > include/linux/netfs.h | 16 +-
> > include/trace/events/netfs.h | 79 +---
> > 19 files changed, 819 insertions(+), 763 deletions(-)
>
> Hello David.
>
> After recent merge from upstream BPF CI started consistently failing
> with a task hanging in v9fs_evict_inode. I bisected the failure to
> commit e2d46f2ec332, pointing to this patch.
>
> Reverting the patch seems to have helped:
> https://github.com/kernel-patches/vmtest/actions/runs/12952856569
>
> Could you please investigate?
>
> Examples of failed jobs:
>   * https://github.com/kernel-patches/bpf/actions/runs/12941732247
>   * https://github.com/kernel-patches/bpf/actions/runs/12933849075
>
> A log snippet:
>
>     2025-01-24T02:15:03.9009694Z [  246.932163] INFO: task ip:1055 blocke=
d for more than 122 seconds.
>     2025-01-24T02:15:03.9013633Z [  246.932709]       Tainted: G         =
  OE      6.13.0-g2bcb9cf535b8-dirty #149
>     2025-01-24T02:15:03.9018791Z [  246.933249] "echo 0 > /proc/sys/kerne=
l/hung_task_timeout_secs" disables this message.
>     2025-01-24T02:15:03.9025896Z [  246.933802] task:ip              stat=
e:D stack:0     pid:1055  tgid:1055  ppid:1054   flags:0x00004002
>     2025-01-24T02:15:03.9028228Z [  246.934564] Call Trace:
>     2025-01-24T02:15:03.9029758Z [  246.934764]  <TASK>
>     2025-01-24T02:15:03.9032572Z [  246.934937]  __schedule+0xa91/0xe80
>     2025-01-24T02:15:03.9035126Z [  246.935224]  schedule+0x41/0xb0
>     2025-01-24T02:15:03.9037992Z [  246.935459]  v9fs_evict_inode+0xfe/0x=
170
>     2025-01-24T02:15:03.9041469Z [  246.935748]  ? __pfx_var_wake_functio=
n+0x10/0x10
>     2025-01-24T02:15:03.9043837Z [  246.936101]  evict+0x1ef/0x360
>     2025-01-24T02:15:03.9046624Z [  246.936340]  __dentry_kill+0xb0/0x220
>     2025-01-24T02:15:03.9048855Z [  246.936610]  ? dput+0x3a/0x1d0
>     2025-01-24T02:15:03.9051128Z [  246.936838]  dput+0x114/0x1d0
>     2025-01-24T02:15:03.9053548Z [  246.937069]  __fput+0x136/0x2b0
>     2025-01-24T02:15:03.9056154Z [  246.937305]  task_work_run+0x89/0xc0
>     2025-01-24T02:15:03.9058593Z [  246.937571]  do_exit+0x2c6/0x9c0
>     2025-01-24T02:15:03.9061349Z [  246.937816]  do_group_exit+0xa4/0xb0
>     2025-01-24T02:15:03.9064401Z [  246.938090]  __x64_sys_exit_group+0x1=
7/0x20
>     2025-01-24T02:15:03.9067235Z [  246.938390]  x64_sys_call+0x21a0/0x21=
a0
>     2025-01-24T02:15:03.9069924Z [  246.938672]  do_syscall_64+0x79/0x120
>     2025-01-24T02:15:03.9072746Z [  246.938941]  ? clear_bhb_loop+0x25/0x=
80
>     2025-01-24T02:15:03.9075581Z [  246.939230]  ? clear_bhb_loop+0x25/0x=
80
>     2025-01-24T02:15:03.9079275Z [  246.939510]  entry_SYSCALL_64_after_h=
wframe+0x76/0x7e
>     2025-01-24T02:15:03.9081976Z [  246.939875] RIP: 0033:0x7fb86f66f21d
>     2025-01-24T02:15:03.9087533Z [  246.940153] RSP: 002b:00007ffdb3cf93f=
8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
>     2025-01-24T02:15:03.9092590Z [  246.940689] RAX: ffffffffffffffda RBX=
: 00007fb86f785fa8 RCX: 00007fb86f66f21d
>     2025-01-24T02:15:03.9097722Z [  246.941201] RDX: 00000000000000e7 RSI=
: ffffffffffffff80 RDI: 0000000000000000
>     2025-01-24T02:15:03.9102762Z [  246.941705] RBP: 00007ffdb3cf9450 R08=
: 00007ffdb3cf93a0 R09: 0000000000000000
>     2025-01-24T02:15:03.9107940Z [  246.942215] R10: 00007ffdb3cf92ff R11=
: 0000000000000202 R12: 0000000000000001
>     2025-01-24T02:15:03.9113002Z [  246.942723] R13: 0000000000000000 R14=
: 0000000000000000 R15: 00007fb86f785fc0
>     2025-01-24T02:15:03.9114614Z [  246.943244]  </TASK>

That looks very similar to something I saw in afs testing, with a
similar stack but in afs_evict_inode where it hung waiting in
netfs_wait_for_outstanding_io.

David pointed to this bit where there's a double get in
netfs_retry_read_subrequests, since netfs_reissue_read already takes
care of getting a ref on the subrequest:

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 2290af0d51ac..53d62e31a4cc 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct
netfs_io_request *rreq)
                                __clear_bit(NETFS_SREQ_BOUNDARY,
&subreq->flags);
                        }

-                       netfs_get_subrequest(subreq,
netfs_sreq_trace_get_resubmit);
                        netfs_reissue_read(rreq, subreq);
                        if (subreq =3D=3D to)
                                break;

That seems to help for my afs test case, I suspect it might help in
your case as well.

Marc

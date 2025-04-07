Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355118FDAF
	for <netfs@lists.linux.dev>; Mon,  7 Apr 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008467; cv=none; b=EG7CtGArouiTzH2a0Q3XtPOYdbfc6ZkxN8Z5ET06MI9R2mR0mYgOmjq0GnDbsw5SNqMslKLVCq6ORWGM2eU4v2mw4MWD9twQN4TytzonWfKrHsNFeHuqY0RyT5HqvtIepPZh4iw+A/vL9HY2SwclORLvweagY1pg+5TQ56MiIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008467; c=relaxed/simple;
	bh=ZZUlxs3lsFRlXD1ZlTsvePZjUzaO8ImiCkUhzXwumGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTKzcUpljgRA8lRqsDN2O6Cleov1tsYpd7i7JWTg5UrzfTO4wirgX+L1SGyiCww94PVXLYBxOUIX6vA25QQap3r+MYh6mxywIrC0rSmYTwb60CQfFwF4eW/IN34UQuTTA7g6yaLBSysCwIAkgS/0soS9UYG7aQlxQDuFK8jLtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnaZQfuh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnaZQfuh"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bee278c2aso53521861fa.0
        for <netfs@lists.linux.dev>; Sun, 06 Apr 2025 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744008463; x=1744613263; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms1UAcpDFGSNhniyZjZ0ChCgcYVC7iiABffsUWfRwrw=;
        b=mnaZQfuhdQkBufZshDaSwEzD1V0QITmX4QqRkWu1U0silgYXP9jNXs9E+gyUPQEKcB
         Ez3ug2oqYmPHmLL+t4oom+IUIqYaDbe3gORMJBXmpGG+yb8ZyCnV3TORT19JgI5Wc1mv
         T/+GzEXSCb70qLwES2P14AReF0YMAwmaso+t3h7Uu39DieYge6c1b2s59LVh7FTdbWWz
         jJWFFEFJmVzz3e+9yhIaHCDKDu0DPecin68RTGdkxhGROFDbbLghL2jfq7bbjcJgQDgW
         puxVNXaCTsIGAqNI4mp0zQdh3d/MQZ/sIQtSbhyLjwUis8/8GjDJwK5Xe9aA84AqZrp2
         LjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744008463; x=1744613263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms1UAcpDFGSNhniyZjZ0ChCgcYVC7iiABffsUWfRwrw=;
        b=ZHhuPh3vPHrXSv8tARhUSexp0X8dodlgQi1dVX791hXD7sQbJ72poDFLjPHK/viOHh
         c6kHewPPM1v/3nRAdz3AQms++kWC7zNeprLsiHsq58oDZN/ZklPM7QajaClG9KwcXDfH
         k7R7qS6yJ/L5YHYPbkXq4RBl8g9pdxWCREEE3Y7W3bozK2tFzlQHUJoNKMihtNnPbBMX
         9ntLluL26S9l6rf+gcfd9hozqbc8XYdTZzG1FD1H4Az84NmbGTgq3qgy/+gNQPqn17dm
         IV/2ByR/26g3j5swA5zQ6ZXCa5U6sQ5hKWGg2pjQaDlF39hNal0wbP3HbDe/1+v/isTx
         U8tA==
X-Gm-Message-State: AOJu0YwShqcC87QC78/ri8lEZMRKC2lO5+1MFpCSKZLWMV78QIcqRmzI
	iQcYJZOIFBklsolYllKP+nOg3+tfhnXuxHoO7mnoL/f4kkYDfTKgEGZQak6r6xBhTL9219PM67N
	othPaPdEFYvqdqkCB6354kqhb8zx1IYRgDj3O
X-Gm-Gg: ASbGncuA9Aq2ukwAuRMDqrt7TvdjD97xxaEKkqWQGSadRgkwEcoC5LeA75miIWZGEdI
	mxYIkATbSvcXiDkrgQkU6htr1zNAdJ23WVrsbrYBre8LcjdXdJMuca2eEDbOY1tAwm097cizEj/
	48oL++0P/RVHJcCtk/4I+X18GgDcHmt52FZ5GwA4vXQ0RpZSDiOyetZuhSEis=
X-Google-Smtp-Source: AGHT+IGrVS1ofF7pMvIo9a1jNvDgHerGlh/bxMZ+RvFlA+EKoKXxvFP0gHAFyYErWgpL7mNSG+9d12VXsjTw4QLLyy8=
X-Received: by 2002:a05:651c:b2a:b0:30b:c328:3cdc with SMTP id
 38308e7fff4ca-30f0a556c9emr32012911fa.2.1744008463266; Sun, 06 Apr 2025
 23:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALkECRjJ-zzOq1L6F=QULhGmybkBSiQ7yociOzzUgYCkeejEAA@mail.gmail.com>
In-Reply-To: <CALkECRjJ-zzOq1L6F=QULhGmybkBSiQ7yociOzzUgYCkeejEAA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 7 Apr 2025 08:47:32 +0200
X-Gm-Features: ATxdqUGxyWfHZweNICHPkFLh6LLN3ZMIC-l5dBcj5bOPpInySuGgKICEiMP1zvY
Message-ID: <CACT4Y+bxqWzhDALCz9TeuBc=66sLraWCqbksGKgNpzvHZ0xqbA@mail.gmail.com>
Subject: Re: [BUG] NULL pointer dereference in iov_iter_revert() via netfs_write_collection_worker
To: Abagail ren <renzezhongucas@gmail.com>
Cc: netfs@lists.linux.dev, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Apr 2025 at 11:16, Abagail ren <renzezhongucas@gmail.com> wrote:
>
> Hi maintainers,

Hi Abagail,

Kernel mailing lists and developers don't accept MIME/HTML emails:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#no-mi=
me-no-links-no-compression-no-attachments-just-plain-text

Your reports may have been bounced from the kernel lists.


> During fuzzing with the Linux kernel,
> we encountered a kernel crash (KASAN null-ptr-deref)
>
> in `iov_iter_revert()` triggered in the `netfs_write_collection_worker` c=
ontext.
>
> The bug was reproduced on `v6.12-rc6`.
>
> ## Crash Details:
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000023: 0000 [#1] PREEMPT SMP KASAN NOPTI KASAN: null-ptr-deref in ra=
nge [0x0000000000000118-0x000000000000011f]
>
> CPU: 1 PID: 3000 Comm: kworker/u10:3 Not tainted 6.12.0-rc6 #2 Workqueue:=
 events_unbound netfs_write_collection_worker
>
> RIP: 0010:folioq_folio_order include/linux/folio_queue.h:291 [inline] RIP=
: 0010:folioq_folio_size include/linux/folio_queue.h:305 [inline] RIP: 0010=
:iov_iter_folioq_revert lib/iov_iter.c:599 [inline] RIP: 0010:iov_iter_reve=
rt lib/iov_iter.c:644 [inline] RIP: 0010:iov_iter_revert+0x2ec/0x5a0 lib/io=
v_iter.c:611
>
> Call Trace: netfs_retry_write_stream fs/netfs/write_collect.c:181 [inline=
]
>
> netfs_retry_writes fs/netfs/write_collect.c:361 [inline]
>
> netfs_collect_write_results fs/netfs/write_collect.c:529 [inline] netfs_w=
rite_collection_worker+0x3c94/0x46f0 fs/netfs/write_collect.c:551 process_o=
ne_work+0x99c/0x1b80 kernel/workqueue.c:3229
>
> worker_thread+0x677/0xe90 kernel/workqueue.c:3391
>
> kthread+0x2c7/0x3b0 kernel/kthread.c:389
>
> ## Summary
>
> The crash happens during a call to `iov_iter_revert()`
>
> inside a `netfs_write_collection_worker` task.
>
> The `iov_iter` appears to contain an invalid pointer,
>
> leading to a general protection fault when dereferencing memory in `folio=
q_folio_size()`.
>
> Specifically, it crashes at:
>
> movzbl (%rax,%rcx,1),%eax <-- trapping instruction
>
> with:
>
> RAX: 0000000000000023 RCX: dffffc0000000000 RDI: 000000000000011e
>
> This implies an invalid `folio` object is being accessed.
>
> A check on the validity of the folio (e.g., via `WARN_ON()` or `IS_ERR()`=
)
>
> before use in `iov_iter_folioq_revert()` might prevent the crash.
>
> ## Environment
>
> - Kernel: `6.12.0-rc6`
> - Platform: QEMU
> - Trigger: workload involving `netfs` writeback
>
> I checked the dashboard, I think this is highly related to :
>
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1300b618580000
>
> https://syzkaller.appspot.com/bug?id=3D78d77d1af0176dc57be694578c1ac93e92=
587191
>
> The config file  and crash report are attached below.
>
> I hope this can give you more information about the opening bug.
>
> Let me know if you need additional repro information or traces.
>
> Thanks,
> Zezhong Ren
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
/CALkECRjJ-zzOq1L6F%3DQULhGmybkBSiQ7yociOzzUgYCkeejEAA%40mail.gmail.com.

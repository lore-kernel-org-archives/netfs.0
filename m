Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604B1EEA3C
	for <netfs@lists.linux.dev>; Mon, 12 Jan 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230994; cv=none; b=kRnmb4kltLcE+UUtgXAYYacZw9cEmjsdV9eRNmcTLwUFwhUp5cKszJXKzYT7wZ346e1lfCcdpXdFqZT+oOb0HHnq7OGYqDSEMYHowfuS4LESQOXhCBoWetSc7YGnOaNt8wurd73v3kJdP99AU1OUrzXGuHpfVxvAcBIaM27hnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230994; c=relaxed/simple;
	bh=S450hIDOWWsDIofXxicq/L+YCE1u3Z2yrEPfLDSBbqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdDfTMU3LMFrcQXWgeidABlgy6Dt/lzNrKe2vjp3QSdy+AX+gRCkaEfKrDK413tm91uq4G4zCGfy4S9kJOoiX8PmBX7sg2ikA+Jhy/8lCkhQzhpLeHFMq8YDoc1P76l3x6vmNBDbyCIAYnU2amj5eNvQ8RPCvMYxFLJx0oIa+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAuDk06c; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAuDk06c"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8887f43b224so101903826d6.1
        for <netfs@lists.linux.dev>; Mon, 12 Jan 2026 07:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768230992; x=1768835792; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MoKlWPcUEY0HTUZFf3NIt2JrP4vfvCGXXVYplHzrD0k=;
        b=FAuDk06cfsDyyoOZ/B9vCp/PyoZ11xG2B+XKip27PFFhzbx8cQAVWHjHWfzfxXYmX6
         g8RX0Oi/GDfJAJI88OrzLyQlCHimTHq63ZwjBIoMQxRdkO8DHDXk8cyPOJ6nk+qxe5QY
         IUI2rOhCTCrXSkdoioyYW3ZpGMF7CVNKZ6agNhm0yFl+d9P7G360xjdXEwIMiMShlSEB
         KsmJLrwD/6DFR/XUTPooa79vYk4D3YwnyTrOm+quRpmjt7KKLhxLbuKHmBTSM7C4C2sR
         5Jn8XZCk0xgSsZjYGqfGYQ8OyrnEW3MZlVJAv/ivWTKtifLpxxxkVDMVN+ebfD9Gr0Tp
         h3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230992; x=1768835792;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoKlWPcUEY0HTUZFf3NIt2JrP4vfvCGXXVYplHzrD0k=;
        b=ImiiC6NYEhtkA20ablw342IQEfaSASUuRsvjl5X5LP0Ni96dPZU8dh8wiJ934+14rE
         OhBjfpzioECSs0GAVnRnYRacyo7DLzU7poZ6f0JVlNCBNGt86b2t9Gy2Po/qPRRswMvR
         RbbsxKcvLYw0ur0qdh2Uj55l5DcUfJwjg/E98b2RF+mYqVa2B9oceQGM/PQdge8E+EsW
         1vyjhBTYD10mDxkqQ5yeE6QUb3O6BbDqTWw9EjDYM8IvE98zpRkqk22UtfKHgIVcQJp7
         ZPF4Whg5ANQnYhA65XCoZxHy9R9loU2Yi4sKYjddG7t4iwFpfTyihBDeLcC3GZten0xB
         ufNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLxsKS4fd10JTUmpiGfeZOK93nlMt6nd+8rZ4cw3yEaauDtgYWKowDyf8T5P0znQ1YfMCwsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeYkXtIBmOme7tYgAfgZnzKv5heQqSzo7RtE5TgAt/StSArh4S
	Qf0S8t+X9PnU4qDP9m0VEHGuHcCoEuUMSw+mZGcbsHTZv6qs9AG9MriqcWKkMv231pIOVBi9yLY
	1pePecpLjyQlLLUnELu01U13tDfQOp2Q=
X-Gm-Gg: AY/fxX5VlKwbS5Vf4+OdDsAQW3IzQ2QKw6ZydKpPPkSFjQ0VfBLktlpKowYCODnSYLs
	dnBJJ4K4tm6CmQIokAkESGgHxYYCKywNaGdMNpE08NpoQv76dFrniO46/WlxBeuEMtFdNku51pf
	UX14g6iwgrk/ac19a37QLOdp90c4Kqn1XZx8HxixUTPkWkFPZkK97v6Riv1w9wfK6+uuquvdTn8
	B/83Xc6ov5ZoLwYiuIVBgR4UpYoqzkcplFX5mKkIobuhBoR4vzWPAvnFlRtZdNYWQvhUdcJDOO7
	udjzWqP3Itfdg0bprov2LEfiqg==
X-Google-Smtp-Source: AGHT+IFeiEU2FlSzR7eAgESQKlIGW2EkPddzGwQiXS9SvwHpuA7rZaW6nlLUS9tbLtioPq38cf5mtSMlGjCF6Hj7/4I=
X-Received: by 2002:a05:6214:3f89:b0:88a:3b1d:2f70 with SMTP id
 6a1803df08f44-890841e461cmr236461286d6.10.1768230991390; Mon, 12 Jan 2026
 07:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
 <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
 <CADFF-zcFgycZ7c0KC_5eUafjvba_ZxhzED0a7yDR4oip4_KxbA@mail.gmail.com> <aWIgdDImfFg6fgxn@kernel.org>
In-Reply-To: <aWIgdDImfFg6fgxn@kernel.org>
Reply-To: mjnowen@gmail.com
From: Mike Owen <mjnowen@gmail.com>
Date: Mon, 12 Jan 2026 15:16:20 +0000
X-Gm-Features: AZwV_QjMDrGAS_wx8jscHyCw9C1LIQWE5jfMK9Fw02L8E8FeVM3CydfaZTNQK8M
Message-ID: <CADFF-zf1qypwRDYkCPH9MFVLoPgsJxsNXZ7-qEbiMLo-L3Ldsg@mail.gmail.com>
Subject: Re: fscache/NFS re-export server lockup
To: Mike Snitzer <snitzer@kernel.org>
Cc: Daire Byrne <daire@dneg.com>, dhowells@redhat.com, linux-nfs@vger.kernel.org, 
	netfs@lists.linux.dev, trondmy@hammerspace.com, okorniev@redhat.com
Content-Type: text/plain; charset="UTF-8"

Ah, this looks promising. Thanks for the info, Mike!
Whilst we wait for the necessary NFS client fixes PR, I'll look to add
the patch to 6.19-rc5 and report back if this fixes the issue we are
seeing.
I'll see what I can do internally to advocate Canonical absorbing it as well.
ACK on my log wrapping. My bad.
Thanks again!
-Mike

On Sat, 10 Jan 2026 at 09:48, Mike Snitzer <snitzer@kernel.org> wrote:
>
> Hi Mike,
>
> On Fri, Jan 09, 2026 at 09:45:47PM +0000, Mike Owen wrote:
> > Hi Daire, thanks for the comments.
> >
> > > Can you stop the nfs server and is access to /var/cache/fscache still blocked?
> > As the machine is deadlocked, after reboot (so the nfs server is
> > definitely stopped), the actual data is gone/corrupted.
> >
> > >And I presume there is definitely nothing else that might be
> > interacting with that /var/cache/fscache filesystem outside of fscache
> > or cachefilesd?
> > Correct. Machine is dedicated to KNFSD caching duties.
> >
> > > Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).
> > Similar settings here:
> > brun 20%
> > bcull 7%
> > bstop 3%
> > frun 20%
> > fcull 7%
> > fstop 3%
> > Although I should note that the issue happens when only ~10-20% of the
> > NVMe capacity is used, so culling has never had to run at this point.
> >
> > We did try running 6.17.0 but made no difference. I see another thread
> > of yours with Chuck: "refcount_t underflow (nfsd4_sequence_done?) with
> > v6.18 re-export"
> > and suggested commits to investigate, incl: cbfd91d22776 ("nfsd: never
> > defer requests during idmap lookup") as well as try using 6.18.4, so
> > it's possible there is a cascading issue here and we are in need of
> > some NFS patches.
> >
> > I'm hoping @dhowells might have some suggestions on how to further
> > debug this issue, given the below stack we are seeing when it
> > deadlocks?
> >
> > Thanks,
> > -Mike
>
> This commit from Trond, which he'll be sending to Linus soon as part
> of his 6.19-rc NFS client fixes pull request, should fix the NFS
> re-export induced nfs_release_folio deadlock reflected in your below
> stack trace:
> https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=cce0be6eb4971456b703aaeafd571650d314bcca
>
> Here is more context for why I know that to be likely, it fixed my
> nasty LOCALIO-based reexport deadlock situation too:
> https://lore.kernel.org/linux-nfs/20260107160858.6847-1-snitzer@kernel.org/
>
> I'm doing my part to advocate that Red Hat (Olga cc'd) take this
> fix into RHEL 10.2 (and backport as needed).
>
> Good luck getting Ubuntu to include this fix in a timely manner (we'll
> all thank you for that if you can help shake the Canonical tree).
>
> BTW, you'd do well to fix your editor/email so that it doesn't line
> wrap when you share logs on Linux mailing lists:
>
> > 2025-12-03T15:57:25.438905+00:00 ip-172-23-113-43 kernel: INFO: task
> > kcompactd0:171 blocked for more than 122 seconds.
> > 2025-12-03T15:57:25.438921+00:00 ip-172-23-113-43 kernel:
> > Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
> > 2025-12-03T15:57:25.438928+00:00 ip-172-23-113-43 kernel: "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > 2025-12-03T15:57:25.439 is bellow995+00:00 ip-172-23-113-43 kernel:
> > task:kcompactd0      state:D stack:0     pid:171   tgid:171   ppid:2
> >    task_flags:0x210040 flags:0x00004000
> > 2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel: Call Trace:
> > 2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel:  <TASK>
> > 2025-12-03T15:57:25.440003+00:00 ip-172-23-113-43 kernel:
> > __schedule+0x2cf/0x640
> > 2025-12-03T15:57:25.441017+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
> > 2025-12-03T15:57:25.441022+00:00 ip-172-23-113-43 kernel:  io_schedule+0x4c/0x80
> > 2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:
> > folio_wait_bit_common+0x138/0x310
> > 2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_wake_page_function+0x10/0x10
> > 2025-12-03T15:57:25.441024+00:00 ip-172-23-113-43 kernel:
> > folio_wait_private_2+0x2c/0x60
> > 2025-12-03T15:57:25.441025+00:00 ip-172-23-113-43 kernel:
> > nfs_release_folio+0xa0/0x120 [nfs]
> > 2025-12-03T15:57:25.441032+00:00 ip-172-23-113-43 kernel:
> > filemap_release_folio+0x68/0xa0
> > 2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:
> > split_huge_page_to_list_to_order+0x401/0x970
> > 2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:  ?
> > compaction_alloc_noprof+0x1c5/0x2f0
> > 2025-12-03T15:57:25.441034+00:00 ip-172-23-113-43 kernel:
> > split_folio_to_list+0x22/0x70
> > 2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:
> > migrate_pages_batch+0x2f2/0xa70
> > 2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_free+0x10/0x10
> > 2025-12-03T15:57:25.441038+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_alloc+0x10/0x10
> > 2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
> > __mod_memcg_lruvec_state+0xf4/0x250
> > 2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
> > migrate_pages_batch+0x5e8/0xa70
> > 2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:
> > migrate_pages_sync+0x84/0x1e0
> > 2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_free+0x10/0x10
> > 2025-12-03T15:57:25.441041+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_alloc+0x10/0x10
> > 2025-12-03T15:57:25.441044+00:00 ip-172-23-113-43 kernel:
> > migrate_pages+0x38f/0x4c0
> > 2025-12-03T15:57:25.441047+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_free+0x10/0x10
> > 2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_alloc+0x10/0x10
> > 2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:
> > compact_zone+0x385/0x700
> > 2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:  ?
> > isolate_migratepages_range+0xc1/0xf0
> > 2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:
> > kcompactd_do_work+0xfc/0x240
> > 2025-12-03T15:57:25.441050+00:00 ip-172-23-113-43 kernel:  kcompactd+0x43f/0x4a0
> > 2025-12-03T15:57:25.441052+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_autoremove_wake_function+0x10/0x10
> > 2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_kcompactd+0x10/0x10
> > 2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
> > 2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_kthread+0x10/0x10
> > 2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:
> > ret_from_fork+0x47/0x70
> > 2025-12-03T15:57:25.441055+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_kthread+0x10/0x10
> > 2025-12-03T15:57:25.441057+00:00 ip-172-23-113-43 kernel:
> > ret_from_fork_asm+0x1a/0x30
> > 2025-12-03T15:57:25.441058+00:00 ip-172-23-113-43 kernel:  </TASK>

Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB561CD1E4
	for <netfs@lists.linux.dev>; Mon, 24 Mar 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832201; cv=none; b=U99BIlJ4s3T95BFPkPtTRONuAe8F8e3twQGzPir7b3n5AmGRBjuBA0MLUfqXYnuYbAy5RSpUdlNbQrD3m8TnefDVxsq6Zouzdqq5s6iK1HtEY9S2S0rfBjIiM72S7nkdr06qzZ1JN6RYmGYW3QMqRmZ90Rz3cc60+hgX6SXA/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832201; c=relaxed/simple;
	bh=9FU0ifTamX5piTP5b4Ro9Ugpo0FdpNJ35VxXTjvf2j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJr3jxDqPl0599ulNuo6475pedm529ufErOKZd49xBXkOInM/PFXHIBkydxdis+A9RY8Y8TtZT/fvLU7ra6EzNIuzVKsUv03+DU/ooJnptVd8gDxSzp/g2QxFwh6bB7MFG595GZk+v/RMqs/ZIHcZ+FVq+lf7pDt6WWJr8fhhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTbY3L8A; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTbY3L8A"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so8105242a12.2
        for <netfs@lists.linux.dev>; Mon, 24 Mar 2025 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742832198; x=1743436998; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QWkU/bMqwAqGIllPSmXgHuefvas1isqn0786Bpkz2M=;
        b=GTbY3L8AagJRGqWdNaSosrHrqC9wra7Os10Og8LMC/qoBxhOj0neCiCqFEl53r1QEy
         hF1/HH9vSqxZoL5jeeIXIefiJOUWta1XdhHiZyCEMwu1X4BSZ59k57UaFX3HS+Wt2Pa1
         vbxnpwCZbxSTpQWreCfWIwnm4BJbkJWdWaq5PsD27nhmMMUW2kwtSGsFnqeCctNIEH3+
         GeQ1injz256ZFUlz8pISKfP+aSc+44l3la48CHPPb3bTPmTR3iHP2aL8WMoUeTAqkPuk
         T2mYdRauQ1KM2+2LtDIls/9I+/3kCHXmzbauCXkRuaB7PiNkw8sTArAFGuN44E4WEiIK
         8FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832198; x=1743436998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QWkU/bMqwAqGIllPSmXgHuefvas1isqn0786Bpkz2M=;
        b=IlVguTIGpFjCMgaV2W17fZTXzk7yFGQUnXvM7API6OHaI/rwxnpNHZjWHbWgu+Pwvn
         rjpn6KbR1kbCCQqGbhvnQl8466YqQwxI/wj0kg5+J6ctiFS9f6wUoQpGxg3JylFNunYw
         D82bLbFZoRKVqSOVr8tKjQUyvxhTvJ9ZjIq6LI9NJZIBnBYpCPaxuNc26Po42ChYl4vV
         OkV262KtKl9mDPcJk+o09hZcRR21EtskjX969AZXhABhLGQcqd6K7M9WOEpimdPE987L
         daNHwk3T+xUMCR52MZ1tAC7FRR4c3DjQkPpJ1Ppxpnuy7OEX9KpKJlrwhw/CFnz9PSZF
         COYg==
X-Forwarded-Encrypted: i=1; AJvYcCXSjZsJaxtZYaPu5n/dRdfkDtxBlyMCANnw+EW/QDUxxRCOoJcxq0AOs4OygzuZRoZVj3lK/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvJ2I3qXhKWPSUu1/liOBvOz7eTGh6XJ7kCl9tTRVrsYWf64MG
	DxHtullakTdFr3kr91dLfknTOKxAEZyEHDrAFFENyxtGuRo0wSFCwk4MCfUsaob3Rq4R7qOjoWi
	FNZD3IXfs8YWZm2vbbWvzritElJc=
X-Gm-Gg: ASbGncu2Dr0eE12trxoLfg9VUR60EqC3pM03+2hzOpJd+xVgh7zqoD5V5xAFGvGFFJu
	bv2YF631TKt8qOLaerIimpej5Z2AE18qd4YiyIHQoXiVQ6f1D5QhfJRxOkpwIZVPnm16e1Gnvzf
	o7ICG1ayQppmlHmEg4AI3LG0fK5w==
X-Google-Smtp-Source: AGHT+IG2+OeCLLVerEDx+IngTZJIlJRTqun6x/Jhs9u5Ler7WQckD41CQaVLpBgtja/BwNKAX/6oWi8OAjVk+dSeKpw=
X-Received: by 2002:a17:907:bc8b:b0:ac3:3e40:e181 with SMTP id
 a640c23a62f3a-ac3f1e04bfdmr1370423866b.0.1742832197605; Mon, 24 Mar 2025
 09:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250323184848.GB14883@redhat.com> <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com> <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com> <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com> <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
In-Reply-To: <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Mar 2025 17:03:03 +0100
X-Gm-Features: AQ5f1JqcXy-bG1AdbIVqBBipWfJLjXRMqOFRTPcGpSJ3frxXEsEwWshQXjEegpw
Message-ID: <CAGudoHGdOf35YM013VjGKQJF81OeMN6XQfkx8oF7PKLe08CjDQ@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>, brauner@kernel.org, 
	dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:52=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> So far, with tracing, this is where I'm:
>
> o Mainline + Oleg's optimization reverted:
>
>      ...
>      kworker/43:1-1723    [043] .....   115.309065: p9_read_work: Data re=
ad wait 55
>      kworker/43:1-1723    [043] .....   115.309066: p9_read_work: Data re=
ad 55
>      kworker/43:1-1723    [043] .....   115.309067: p9_read_work: Data re=
ad wait 7
>      kworker/43:1-1723    [043] .....   115.309068: p9_read_work: Data re=
ad 7
>             repro-4138    [043] .....   115.309084: netfs_wake_write_coll=
ector: Wake collector
>             repro-4138    [043] .....   115.309085: netfs_wake_write_coll=
ector: Queuing collector work
>             repro-4138    [043] .....   115.309088: netfs_unbuffered_writ=
e: netfs_unbuffered_write
>             repro-4138    [043] .....   115.309088: netfs_end_issue_write=
: netfs_end_issue_write
>             repro-4138    [043] .....   115.309089: netfs_end_issue_write=
: Write collector need poke 0
>             repro-4138    [043] .....   115.309091: netfs_unbuffered_writ=
e_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>   kworker/u1030:1-1951    [168] .....   115.309096: netfs_wake_write_coll=
ector: Wake collector
>   kworker/u1030:1-1951    [168] .....   115.309097: netfs_wake_write_coll=
ector: Queuing collector work
>   kworker/u1030:1-1951    [168] .....   115.309102: netfs_write_collectio=
n_worker: Write collect clearing and waking up!
>      ... (syzbot reproducer continues)
>
> o Mainline:
>
>     kworker/185:1-1767    [185] .....   109.485961: p9_read_work: Data re=
ad wait 7
>     kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data re=
ad 7
>     kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data re=
ad wait 55
>     kworker/185:1-1767    [185] .....   109.485963: p9_read_work: Data re=
ad 55
>             repro-4038    [185] .....   114.225717: netfs_wake_write_coll=
ector: Wake collector
>             repro-4038    [185] .....   114.225723: netfs_wake_write_coll=
ector: Queuing collector work
>             repro-4038    [185] .....   114.225727: netfs_unbuffered_writ=
e: netfs_unbuffered_write
>             repro-4038    [185] .....   114.225727: netfs_end_issue_write=
: netfs_end_issue_write
>             repro-4038    [185] .....   114.225728: netfs_end_issue_write=
: Write collector need poke 0
>             repro-4038    [185] .....   114.225728: netfs_unbuffered_writ=
e_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>     ... (syzbot reproducer hangs)
>
> There is a third "kworker/u1030" component that never gets woken up for
> reasons currently unknown to me with Oleg's optimization. I'll keep
> digging.
>

Thanks for the update.

It is unclear to me if you checked, so I'm going to have to ask just
in case: when there is a hang, is there *anyone* stuck in pipe code
(and if so, where)?

You can get the kernel to print stacks for all threads with sysrq:
echo t > /proc/sysrq-trigger

--=20
Mateusz Guzik <mjguzik gmail.com>

Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EC2E6138
	for <netfs@lists.linux.dev>; Wed, 11 Jun 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650912; cv=none; b=Mk4mb8mI0ECuYxEAAaSH8fvefFAGWApXNl84p7JlQWaSCzHLGZk+NENzNX9jvG2+sAbUg6ee0qIyyvxlE6PmOswxv34f8AXOERBElzHXj7gNvDBK15NYvdAYV6I6qrwrrYO4s4/mnU2WKCwXzBiLZjR1LY2mM2DjoviqtFquD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650912; c=relaxed/simple;
	bh=crgnnjHZaqIsGOZjsjV7ZUBqvIC371P0i+OWUX75ppo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI0U0kUkGeaWLYqi2YQPAYKDx7m/G+SzaNAUGjkBmUoFWRVwhCuntUxwlGkm2J+P9yvEcjnaxwnfGasLlYYLL7rJT8J/A+/c0LtHwd/TMhbLqA2GGrSghgWEccNc3AFG2pjhNTU5JyZHHMryge4zHScdig5UBd0BHaupXVa+emI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=293treE8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="293treE8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-312028c644bso5192210a91.0
        for <netfs@lists.linux.dev>; Wed, 11 Jun 2025 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749650911; x=1750255711; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMCP5+i49Ei6OGx1t9OxUl2Teswzg233SMev8hs02gA=;
        b=293treE82dFVIzknAWsFS9E0ygEzjSBfVC2HpSKrPnSOkNkT7fvdCxySGsZg5YuOt2
         HpV5tTqIhPJCRpNds1epTXYe61RSSKEd2pQOyQd5HC2Hzln8WyP+oX+2eAxOw/14qi3b
         4uMdakVPla9/u954PzMN/nqUAtQv19j0KGXcePKckygetQJVoTn+9zfaI5JKjChbJ1+6
         4x0wqHjhxkrI1MwgCZPC0mXqLHu+vwFS8AmDL1uuJlCVemNntDMcgKo+Yn4L27++Boj7
         c3tPbyzz8hDWaY3djZvnzT6W+gnEcE1Fo6gmekf5OKduFSzlyJK2hccyZUqNYYsMnnyg
         k7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650911; x=1750255711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMCP5+i49Ei6OGx1t9OxUl2Teswzg233SMev8hs02gA=;
        b=lrVkBTyOilqtO1viljblbSViA+0kqoy07vytJ8sujGH5awk12bQY2VppyhwHmlbI5c
         i//Y2u29cAnO0S+OLaOt0MA88rrHS3G5QjWNUfIb3fMWhMjobCJVQXfya1OB/VeiuIbi
         L3X0/zukak9yohyFjuU/Y/f30MwxIcTiJRbAnNM7xRnC4/SigLnoifiQ940BzWUMMXyL
         CuBEP+mL7nX6joWrSnbwltR2is6+Ls0kZ5y4lPDeeZ0MLk7cwQg/Vpqy9dKOGPSLsh4l
         JGWUYYyzrzk31b6JTy7Hs0H8MLlqYT2Afx2sABTTFWqvY79rp5I9qeHQ2BliwWmmvzrC
         Hjng==
X-Forwarded-Encrypted: i=1; AJvYcCXJeaL7MdaUBUMig2HQVkiHnEa/+ATM0d/It3wOU807uv8xr9VPrtldXSmbWaW2WYkmiMnnaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFj69UB8R+kn2LeUM50NLwb/SYjEY77dksOuhoD1V4oV+WnSJU
	l/FzbYIRlHX1W//4P9Z9pnq8/i+NDeLtzDcjJVX3Bff/AADYZAaHBFt3AwMaqLvj2kSM0MBzgr1
	XtwaNSGcOBOOfhpGUnX9A2K0h4ZRHYq7A4w6qMbkG
X-Gm-Gg: ASbGnctcbeUQN/0Yn44qJaw++L4LHRj/IgzbmmrePQ7Q9CMHNQHhlXBT6PSWAvLargy
	ZXHVPOUGkEcqaDwF2MLH0nl/WT/upbXreU8cCelylmLwclN/gsA0vL1v2+KoF/WRaM1hc3eTevT
	juEGucvGINJ+v31flZBpG+2dvA0cTPlZDgwxxTcCcUsByZfEJKF78GdCkAeetgj9XGbleZJ3r9+
	w==
X-Google-Smtp-Source: AGHT+IE/zvALO/G36bMoEv9R3dBG9othx0hsbt6Wq2S7X1wCHNt0X1XpaAnFyLsBZjSEIc47LngfEr1Y5l2TxATtW/4=
X-Received: by 2002:a17:90b:3c0b:b0:312:1dc9:9f64 with SMTP id
 98e67ed59e1d1-313af26720fmr4514767a91.31.1749650910565; Wed, 11 Jun 2025
 07:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67b75198.050a0220.14d86d.02e2.GAE@google.com> <683b8ea2.a00a0220.d8eae.0020.GAE@google.com>
 <aDueHCMDLPs2UtY2@casper.infradead.org>
In-Reply-To: <aDueHCMDLPs2UtY2@casper.infradead.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 11 Jun 2025 16:08:18 +0200
X-Gm-Features: AX0GCFtUWXqinF3FxOk9yB1Et5-WWvCDPttaSsMJxKkZJmtGttcHC7lVof6yARE
Message-ID: <CANp29Y5H3VTZAVZjde5bVRajDUESAnCX+6H1wD90ArpT=EiU3Q@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>, 
	asmadeus@codewreck.org, chao@kernel.org, dhowells@redhat.com, hch@lst.de, 
	hdanton@sina.com, jaegeuk@kernel.org, jlayton@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 2:26=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 31, 2025 at 04:20:02PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 80f31d2a7e5f4efa7150c951268236c670bcb068
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Thu May 8 05:14:32 2025 +0000
>
> That's not possible; this commit is after the original report.
>
> That said, there _is_ a double folio_unlock() in this patch, which
> I'm about to send a fix for.  It's just not fixing the original report.
>

Thanks for bringing this up!
The underlying problem is that syzbot has merged several unrelated
kernel crashes into one bug report (`kernel BUG in folio_unlock` is
just a too generic title). The reported bisection result seems to be
correct, but it refers to only one of those incorrectly merged bugs.

I've just sent a fix for the syzbot's crash report parsing code [1].
It won't affect this specific bug report, but once the new code is
deployed, syzbot will re-report the two underlying findings
separately.

[1] https://github.com/google/syzkaller/pull/6081

--=20
Aleksandr

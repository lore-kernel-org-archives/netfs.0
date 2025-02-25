Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F82222D9
	for <netfs@lists.linux.dev>; Tue, 25 Feb 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524171; cv=none; b=Tnqq/dVn2BIWCuxU+IvRY5Sey82IgCMNuZiOuUriSm6o9h7a/VqGbXV7JumkYP0BgHxgQ4c+UbUHXQSXQBjVNKvMoKnEs2GGoTOCbkLR/icgrfaxJScLKRamVQabQM1f+XytAJ2BiOiyQD9GU5/PUvWFmYNcujtI62NBlv43n+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524171; c=relaxed/simple;
	bh=WP5ICD/fUvspwcDOC+vCPGstk3m2lObTd1WmHN0cTTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Go+a/21rPPQd0dPwZd5fTn/R8eXPcEWspVfa70bwpII30YGRcZWpwHAvsmxbBccXvxn0Yi2Q6wE0FNUyJq2UUjqI/y06BIdSlmlM6+M8o9ufoEKModPkbiKb1Bt/NEVEFzaqh46R8TYSdqoF+vEaPiHLw0zzjHTqZWrDUjTkNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahmpj0Fl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahmpj0Fl"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54529e15643so260365e87.1
        for <netfs@lists.linux.dev>; Tue, 25 Feb 2025 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740524167; x=1741128967; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgEgO8Ju/firUMwZDW4ea1qs6sMMAvv6pWGk9qZ2srE=;
        b=Ahmpj0FlyM2cx3xquT1pkrJuB0uHHAkBwcr3xkp1w7mVtfkuklKf/k8TGGETaYLMLL
         k4f2AxIZK1bxXdp56tmrnsVy6c61ECIrF+wvCIBQkk+eDhqVnX+E+Q7uDjZFUlFr/b/p
         qxcCSzuaUWOhZwI2B3vAYZXU8wPcD/45n0zNlzxaQLK1Omm1guTjKuZJzoKoVkjIINjx
         zxFbNzliMz/z7DLcJLEKG8K9694Yi2QaGytA2tGYU+iH34ywCpo3AWlI0G0caQJSQxvo
         4ld9/qY64p2hN0o65Ti48xiXAF/fKu/DFZQ0XJrho97psiSroFqgxNlpXsouWExus2rL
         Nm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740524167; x=1741128967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgEgO8Ju/firUMwZDW4ea1qs6sMMAvv6pWGk9qZ2srE=;
        b=Xi6xgEhc8pMZxu1Fy1+0s4W9fsaFik+VK9XBFzcvaIRYvIn2waWTn+0ubAgXRVgY95
         MWGMK5lanHYqqqNDW9VQDuzNtsbRSvUshVeHFcvpinw5ONNOkGdoUvZh1Y08wtoKWYLW
         4CVpx2s4MxFqscYcm9X2fxg88xzox9mqzQv59G+d5dvlZhs5ltNxygl+bPDSPQTXutVy
         ZlyWf10AqdcOiTQKPgZdnYulFSQs74rCyX9/t1jUVY5X0O/VOSZMEC9C6+e+4nHtcpqV
         Ma6hqutSr/sNXED8tiwhQx1P3PGmD9+KGMa1hbn+569i6BJ1eIRP0hzTuSOk431y5Ezz
         3DVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVA/kQT7U23RPsKVqDMB7XpfNXOl2X6J6WGYVjJw/EaJRIVgoR7aA1QjNVbmb4uY2KvnLIsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6YeXnN1A6jhuvsCSlmibdJ51cYxZS9qz/GSNJhmryqzreb4KM
	aWf+cuByipWd8ygqeGAi4rAnUHjPz3csYS16XC9vxrwI3x/Nnu4wmVtKErllCzfTqhIG3S0YVWO
	ZWXGkUAvBbSq0yUxdMZXrr321m0s=
X-Gm-Gg: ASbGnctqYwPGRsmk8skLfooqd2xAl7d08HgXucLRdn19GpeqlXjmRvq7c+sqU4M+E+D
	2CpXNhGPqnc4uy7V3VsiBM0TliUbkagpAd2HazY+ezlm3Wesa+1R9ZLXd60TkzfcQOF1TcrfvEz
	bee48Dh9c=
X-Google-Smtp-Source: AGHT+IHwSWJ7XNj4Mb9xUjz4kISutQjQS5qgcJOweA9fncToSusgnMBoMCQnx1ZOHcc9hRULT9kO2A2WM5J2rYS4I5k=
X-Received: by 2002:a19:4317:0:b0:549:39b1:65d4 with SMTP id
 2adb3069b0e04-54939b16edbmr1848816e87.0.1740524167158; Tue, 25 Feb 2025
 14:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2433838.1740522300@warthog.procyon.org.uk> <20250225223826.sm4445vrc56mfuwh@pali>
In-Reply-To: <20250225223826.sm4445vrc56mfuwh@pali>
From: Steve French <smfrench@gmail.com>
Date: Tue, 25 Feb 2025 16:55:55 -0600
X-Gm-Features: AQ5f1Jo6XXLVbjx1gBz329g2rRAPrhuHDOb-nfzLQJUf_2H9sBrfoXnqj9dxnNE
Message-ID: <CAH2r5muYgfd-GmwQKt-ZHgt7Up57j1OEJy-6e9OdN--aiQHDGQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix the smb1 readv callback to correctly call netfs
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, Paulo Alcantara <pc@manguebit.com>, 
	Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick fix and reviews/testing.  Merged into
cifs-2.6.git for-next.  Will run some additional tests on it tonight

On Tue, Feb 25, 2025 at 4:38=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Tuesday 25 February 2025 22:25:00 David Howells wrote:
> >
> > Fix cifs_readv_callback() to call netfs_read_subreq_terminated() rather
> > than queuing the subrequest work item (which is unset).  Also call the
> > I/O progress tracepoint.
> >
> > Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only u=
se one work item")
> > Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219793
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <stfrench@microsoft.com>
> > cc: Pali Roh=C3=A1r <pali@kernel.org>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
>
> Thanks! With this change, I cannot reproduce crash anymore.
>
> Tested-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Steve, could you please include this fix into some queue? This should be
> merged into next -rc.
>
> > ---
> >  fs/smb/client/cifssmb.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> > index 6a3e287eabfa..bf9acea53ccb 100644
> > --- a/fs/smb/client/cifssmb.c
> > +++ b/fs/smb/client/cifssmb.c
> > @@ -1338,7 +1338,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
> >       rdata->credits.value =3D 0;
> >       rdata->subreq.error =3D rdata->result;
> >       rdata->subreq.transferred +=3D rdata->got_bytes;
> > -     queue_work(cifsiod_wq, &rdata->subreq.work);
> > +     trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
> > +     netfs_read_subreq_terminated(&rdata->subreq);
> >       release_mid(mid);
> >       add_credits(server, &credits, 0);
> >  }
> >
>


--=20
Thanks,

Steve

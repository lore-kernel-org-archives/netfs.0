Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50D2E7193
	for <netfs@lists.linux.dev>; Thu, 26 Jun 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946883; cv=none; b=HI9uXM0OH0Opir8K1X6QH+ArQRmF/8L6oip9yX3BSjysrBc2YPI5tlmL+cHFdHCK87IpI1i2THCigVnY6VB0lNvxEVvhhba+BK2xqmH6xRXl04C/9KXG4v1O1+HjaHtZ2iC12WiVrVmMzqm6gIXMxAc1BIAtY0XUSre0X5ktB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946883; c=relaxed/simple;
	bh=W9tHbxHnKeRQE5geeibzijql5KBQit7N4QCOc9dhrsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtA+rsiQCVoGFQSA2sh//KEpVr587oQBrGglAIUhglMhkUda67Ah6fj0R/Kz5kTrDZt8JehWSsyl1wiq57W5y/KpigR7mKuPt2Jfpo4DZ7m85hCO3fXye5zcBJYiVWzbY8wSjA/lGIPlFky4wYenRzDM3q7RiQITrvlC2N/UHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE9p65Jr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE9p65Jr"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso11199626d6.2
        for <netfs@lists.linux.dev>; Thu, 26 Jun 2025 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750946881; x=1751551681; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AFJAJWMJoLX2aT06uj/U15KdrwYtiZtVOwqSV/4SzY=;
        b=BE9p65Jrxq5a/cTMiKoRXPgJbonuOJCbNKmsicnd7500TG0O0uoUOlWQavhDHu9syb
         NXsgc9SrjsAvnxUUh8NklM0FSlIT9SnlBFxZ9ZLmCqjQP7cgcatCD2MpNK7cu31w2pOj
         Ybla0x6qEcOkSzX7SRW0/EXqp7OzMVNvHG2KCFqJm2k0LY1a67UX/i5FYnX7zHzbwz4F
         OoPpsQgkZ2V3gfFraBmTNBqrjGGYJEVjRH/FtHtdg7sy8AWGhic41g/PGQZ3hVOtPTnQ
         k2rDqLsOB5wEmTb3YPYDgmi7f0HpKRcKFVL6keQf1nDv+hUdE0RCGFszuUB25VzfEOeo
         R3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946881; x=1751551681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AFJAJWMJoLX2aT06uj/U15KdrwYtiZtVOwqSV/4SzY=;
        b=cH1jtioBNjGk2yhpshB/bfnwvNa2aR7Px+sYlgj/pR+md2c9Iv2Uz6l0w5ZGqeI9tt
         Js7ju8beh6uQEW/15LdyUT6y/yvYSnVYwjgQT1hEMTN6kMSof36j8PeCgs2UVYLjM+iR
         WRa+Gs4uBL5Mq1RbkGG1VM4NMt9v9S9UrAxgV0B8zF2znjZRIhzD16pj576JqRc8Q7wM
         i+yLw82X7Jd8gUMATvaglYUlj2NA0M6IXuNU/iDGEZTb/7BNdoc7wUZ4d894dgL4d2V3
         lv2k2C3Z+5lODy4Qjxlt3YcBSH/+r4gqEd5jxmT0KUO1C7unF1L4rktHOE+DZxdO5ScS
         qExw==
X-Forwarded-Encrypted: i=1; AJvYcCWJtRWli31lFozq+Udw4b7ToGID/w5TgTmX/gVX6OU4kEsDjAn30UkgzE0pdOVL5UGPJ6sZJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuHpbepmb1q+zfS5s8hmiPnMQVwucYGH7NgBmZeP8j2EubvHNY
	CuxmS4e8h71nZLn7/xrL1rdybM2OsxvOJ+FoMyDM27xBon0xPCAQocp2UvJ11j02eJw96UIiwsy
	JOLKm2zGpn06DdhNNgkyac0DTF+0nY8U=
X-Gm-Gg: ASbGnct/tzPWmkx+SZ1BNCTXMF3Irzm/fsgXjt5qNZvy2fiBMn95PK99tRq/vpWgPfT
	SbhYQ/TKWMPQJUaxVDmo/5S3MB9lqdmpHStSh0xzBBLGe5ywAm6AjWf1qcy1zlk+QiVG9ysZ1Kg
	NMw3lsNvnF13mkabTemiX/eqU75QGdXcImApfIbHGuJWHnp2Wi5D66E5+jUojkjUAtcxJTCU+xS
	eDFtA==
X-Google-Smtp-Source: AGHT+IFuTBd/k6VUgHv/Tqnp8nePZb+/XSJ00N/ywtLL9ZMOQqvkiEoIBt16EJ8iSVWekrkdSUFODlbllPETtxHu3oE=
X-Received: by 2002:a05:6214:5bc2:b0:6f8:f1a5:e6a4 with SMTP id
 6a1803df08f44-6fd5efac2c6mr119139766d6.22.1750946881068; Thu, 26 Jun 2025
 07:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1576470.1750941177@warthog.procyon.org.uk> <dd1b01babe2b5023e9e26c56a2f2b458@manguebit.org>
In-Reply-To: <dd1b01babe2b5023e9e26c56a2f2b458@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Thu, 26 Jun 2025 09:07:49 -0500
X-Gm-Features: Ac12FXyyhbfNlNMpQYe9aZUeZ4JpjPV4v5OkXG2uBhjAE4kIr6iaVInUeAOolnI
Message-ID: <CAH2r5mus-f5y+p16hkaYZWA=fCAiMGT1vpMawbVCZ2EC0K5Pxg@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix i_size updating
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to for-next pending testing

On Thu, Jun 26, 2025 at 8:39=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Fix the updating of i_size, particularly in regard to the completion of=
 DIO
> > writes and especially async DIO writes by using a lock.
> >
> > The bug is triggered occasionally by the generic/207 xfstest as it chuc=
ks a
> > bunch of AIO DIO writes at the filesystem and then checks that fstat()
> > returns a reasonable st_size as each completes.
> >
> > The problem is that netfs is trying to do "if new_size > inode->i_size,
> > update inode->i_size" sort of thing but without a lock around it.
> >
> > This can be seen with cifs, but shouldn't be seen with kafs because kaf=
s
> > serialises modification ops on the client whereas cifs sends the reques=
ts
> > to the server as they're generated and lets the server order them.
> >
> > Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/netfs/buffered_write.c |    2 ++
> >  fs/netfs/direct_write.c   |    8 ++++++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>


--=20
Thanks,

Steve

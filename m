Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A88374EA
	for <netfs@lists.linux.dev>; Tue, 17 Sep 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608282; cv=none; b=rOpGGS9JaUeNIvIro2nPzok8EWalDXcQ1/K/1oo3qrY4zvZjGolvD5U3lL+z536mcHxGXyExdIJYm5kPTQhSJJDXRFwSXsEjFzHoEOBPX727w0M2YM0+7rpnB1wTAU118rIl5VqFU8+0MasDPP0xI2iheEtVOY38E366H3pOfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608282; c=relaxed/simple;
	bh=qbzwExx8laMrc91h0RhCesWw10Mfdv3PH8Szj/HZGbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOVpII8OOnJDWuGBcFNmefAVJBZVROeRRs0UeoHkH557eHv5ti3PxsbIhDWqMB9Q6YGZ2McSzYJ0HMA0PJLkm/ZcM9SGvjNJxuKWNDNMD+5YmVwx1gsQglgsBDltVnLQsjODJ24Qfh1lCnGAypBNBvapT+hfu5FDR655dh3fGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5jU8lrH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5jU8lrH"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365b6bd901so6798281e87.2
        for <netfs@lists.linux.dev>; Tue, 17 Sep 2024 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726608278; x=1727213078; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nELtIw4Zh0M13uRB/wUCoEnw1PUF7WXP5SyljJ7urZo=;
        b=O5jU8lrHN0Dyw2B5M0mDcOAH/h3/XuhJpyZlC+oHe39QoJ4icEXMalGeCsFdHHN2OY
         PC3aU084MoEXFLpufKORVB2m5ngKslwMfTH7v4W/sfNbqIq2neVYQ09kyG6lLNftQPrT
         10EQFp1yGv2CRwUcOYehxgtqlcFiEmurklNVjGl5b4AfWxcPNMcMxtif60ZY4be/8wIt
         cLIeSPWgALhg141cnUSjqR3KuV0nG+HMyPvekQduFuXoTiLob18e6p3OhPq5QC7JN12X
         a+FD3Bno7pC37yqxnGm2S0qmTWP44P6o4PCp9Wt7fb3liI/D1qWu0gnro0mOBa0ab26x
         rEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608278; x=1727213078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nELtIw4Zh0M13uRB/wUCoEnw1PUF7WXP5SyljJ7urZo=;
        b=ayG7fF0XPgwSQqDkIxNnrphszUpD4aEyjF/R9g5SkDOpAODTinbYQWS8NNWzs3dnkW
         wDNvfD19dMGNE/0yJGQfDNKFzWSsQ3lr/0zaxpHZ3eTGLqbHNaW/st57d6FGovumtf87
         3bsTC9K3zAX/U709imDghXUisdSuVVzbeozLuklOC9obzV36Dsfha1CVs/gYnCWe32xk
         68PotUb3xwCoGUGFTorBDFQVPjRD8kbRuEkN2GFwGvrGEG2ZCQOXbZqLENKlhFZNa4B+
         W+Sk9dZFWbLqj6Ldf4fX4Q9aG/nXceFKRMhTV1B0uLojsbx+gFshNgoKyccFUVG01yEn
         Vrew==
X-Forwarded-Encrypted: i=1; AJvYcCXJntT0ZYDKoOtaJs67s36QLJv2cY/ILsmXJlupsq4kqeDlG9emvuR7q67jL08J3WujTiE96Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOyuC7Z6AO84IyMf26kxzWRVpl/zOGTCqCbH45y6lfjcICuheN
	vmobOVWIbTrP4NQq5jDOkx+VcGRraj4qtYN8BucSvM+8Jso0GzgHw11mdKGvZ1CubYtDjvHT4ML
	a9tsWxMu/B2dzTD+g7tTeIJwvRtY=
X-Google-Smtp-Source: AGHT+IHpWygKBqdIpti/xTdN/vHJot0ZFGpOZk871PgTIMb/gjAsmuos+l2tbd/Rrtz8eDF8oHlZxhDKZPQxWoo6z4Q=
X-Received: by 2002:a05:6512:1384:b0:52c:e1cd:39b7 with SMTP id
 2adb3069b0e04-53678fb1e9fmr10522085e87.5.1726608278095; Tue, 17 Sep 2024
 14:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2106017.1726559668@warthog.procyon.org.uk> <4bb2eee39bec0972377931aa8f4c280e@manguebit.com>
In-Reply-To: <4bb2eee39bec0972377931aa8f4c280e@manguebit.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 17 Sep 2024 16:24:26 -0500
Message-ID: <CAH2r5mu3TBeMugfWddNYSpPZiYe8Hhv7DYY52rsMb-Zs8BMv4g@mail.gmail.com>
Subject: Re: [PATCH] netfs, cifs: Fix mtime/ctime update for mmapped writes
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can also add "Tested-by: Steve French <stfrench@microsoft.com>"

On Tue, Sep 17, 2024 at 1:01=E2=80=AFPM Paulo Alcantara <pc@manguebit.com> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime an=
d
> > ctime need to be written back on close, got taken over by netfs as
> > NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer t=
o
> > set it.
> >
> > The flag gets set correctly on buffered writes, but doesn't get set by
> > netfs_page_mkwrite(), leading to occasional failures in generic/080 and
> > generic/215.
> >
> > Fix this by setting the flag in netfs_page_mkwrite().
> >
> > Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs=
_inode")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang=
@intel.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/netfs/buffered_write.c |    1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
>


--=20
Thanks,

Steve

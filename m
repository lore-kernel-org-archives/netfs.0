Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C13314A9
	for <netfs@lists.linux.dev>; Mon, 23 Feb 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867917; cv=pass; b=oxnF2g1DD0JBdstyZHq/UsutxoEVVqrxF9xIrvSa0Q/FeKv0tKtoXn/s1AjtWsEKodizrrWm7uN60e403bj06hf2CvjxIrB6BPwRTyaRy/SHvCfT2P00qOQsZ4U+Dop0Giy6l3FwV+Qw5Le8uonQK5X31W+773+5wSYfbtDOeCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867917; c=relaxed/simple;
	bh=hK/0jeoKCkucbRZSvX1AYVctVojQdWNjxRFJpKPT85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwDOElIvLjyezxN3sHvi4WDB8GMLZL4wW44KYYxog/nApNQGogUEX9ifhnzfwN+1mE7jgZBI9zJRru5jeFaIhnHu7fRaxLPy7A3ky6ECX/rRqSI4V74X/zFxaYw1cxAX+PvjOjsJwO/BZ3RPnUIpoB+cyX9sy86ZnymtKd0P0xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ESamhAP5; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ESamhAP5"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354c16d83b2so2163544a91.3
        for <netfs@lists.linux.dev>; Mon, 23 Feb 2026 09:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771867915; cv=none;
        d=google.com; s=arc-20240605;
        b=VFR0nvwGRfLIMVBe6QNrxszRdwmKXD4Z2v3QV9YXrvO7sDvbn7znRSyHv5jrrv3B3l
         RbyYU0jaj0Nnjt0hxT5xUtw5YH4x0laqTReQ3MjjTgas4LX057YIHxRgoOKzNZeMtwJC
         t+AbMyQkw0xDOrw1o7iFyrEJwtoVUdbSSsDlT6tU3pO9Xnszf4t0JugH3fAFY4zoI0fj
         G1vixceVmWALayoNlpl6HhPiBXxYQaKJJj7RqpiA5nnr2pfL+r0+F97atU2eDlkMDQqy
         si8DgcwBDPNxLIDTZW9vrmE7f6Ej1hCdMkKG4uyA25LQU1Vgd1uK1Jp6TsWb6COncfGa
         +aoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        fh=kfJ4Mlby5YZPm4Sxs5bXwJacW2/RA/c0jU1cFMRTqpM=;
        b=HLTT/S/plpVwGDHDF2cE2QiB1f4Yayy6UfpuqC9qoxxGwzmvzRyesUL5zLnpLyS8tu
         otURU9H7scjk+N7553xgfhLk5fxu6zsVqw6aSEAYzrI0zUUM9F6Eu+WPdnTAw4RPfY2N
         r5mfUJIM1JGmqseO3u6uP3QJFfK7+UCpYE4mgvZ8mGk7NlL7j3rgc/vT9vH67L4ZTaDM
         I4aaFeFkN0OEVW2NiFLkzK0q8jImWjhQZeiJFX+th89yjW0RCqRa27M49YeXNBPm05Se
         Hpif9ovz6aJbPLPan948FL2Z19ii48imUokxghCB9bWrslzbSb8jWk/5ho5QhwMugLGo
         T2XQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771867915; x=1772472715; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=ESamhAP5eD25waILQPG4cVqAjZsDzAUjfdBCOh1MUwT9ZlgVWFO+qEWaX+2MiE1Jq4
         iJ3GBDY3Oi7sQwGVxOk50n6J3oQhJsHt9nIytvVKDAf7yDJYwALJz65wXXVWQCBhXFql
         Wzh1qzmeOybHRAnDaGiXGmmR6BecaKHO0NuKDppu5jeNNQBztl5WNtuFPz7WQIwUE/ye
         oYKTmfHzFg3OslWPHkOtWSoRL8yRx/efnuXtvDUTH3+XlbZShi0k4gVe1hPAMBrakaJB
         Xn4mzyZpoW7Vy8YK4Hlq83RGdEZvHF8uyw0BkljR946Ey81ZyfAOFpQVSS0suUukjcGP
         sKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867915; x=1772472715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=AUhrAf05KOCWYstTkeuUjfpMoWG5Qz+uiBxVSPgu/QCAPHZJR/4yrPyxEsRQgdPr7w
         zE58aPLzD7VUUvkqh5fhKkIZvIQ9rrP+P1Ojx2PQAcGsY+0Ky2/09lgCN6QDxhDA5fY/
         ydtZoJRWgu+mAXDfHgnbXa0RwkuQYnnwvU+wdQLtxHAy5sghq80qCwuS0UxXgjNDFjoi
         25eaJulQtoIbFjrtYn0Z20A8i4bLQvQCl2TFXP98xQXSe9whlhHYW0jlsG+HF0tzjJY3
         0ig2qi8GbmULYQPA9zj22zijxBkFHm/0oSF8J8H6CoOmTgj2are3txoPiCxau/iyo6Oi
         tccA==
X-Forwarded-Encrypted: i=1; AJvYcCVfb7+QegoJtoala2yTvfU1w6RngjVuqkcSHGv1Np9urYdSr3GJT53InF4CM8BZoBKgarAMOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKpmRM1c1gQkgjrR6+RE0Zm7MDWTcfHJ0lvUQmbqvRgEyu+7lO
	189oXyPQgN8N7Y2IMUAFNNIoUtGOAQfcG3Gcm63WbvWFpSCbKgf13i0nG2maFtBo7QuodWy3NxF
	IRhW3+4hrRIvsayHDp9P4Wo2I8s2mBk3ReYyrscJc
X-Gm-Gg: ATEYQzydxCuDLLQrWbKYkwRHTp/4eY7k2dWA+5+d2CxCwCl8C/jlPpADGdRtt8rakmV
	9P3x7irYBWuxrcAzr2+nsKm0svFv1snyIIoILak8AGK+anDgC73jWQldYWt9dWSyAbMPlTkSdiv
	EYh3Sk3sAJe4gzg74v/uELMFbur0l/JZp6hz3k6WR6UOqDT/c//f0p+oS0eoDyfBVi653cptJUY
	Q0dvf5iEbyl/GLKCtTllLjw/gecNxP/TvKASiCh4pONOURGHrI9pE3UNRlE3TDSgmcUcH2c4TjT
	S/TzquU=
X-Received: by 2002:a17:90b:2543:b0:352:b674:2592 with SMTP id
 98e67ed59e1d1-358ae7c3605mr8357173a91.7.1771867914678; Mon, 23 Feb 2026
 09:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-7-neilb@ownmail.net>
 <20260223132533.136328-1-clm@meta.com>
In-Reply-To: <20260223132533.136328-1-clm@meta.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 12:31:40 -0500
X-Gm-Features: AaiRm52jwDH7iM8Njra-WDPg6xnZ2flvbCTBnLCHZ5MkdIrvbyo0z9crRKbktmQ
Message-ID: <CAHC9VhSVjLNeTdxHmwYsGX75Z4FOAP+26=PjVdFxpmEkTrPvxA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] selinux: Use simple_start_creating() / simple_done_creating()
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:26=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > Instead of explicitly locking the parent and performing a lookup in
> > selinux, use simple_start_creating(), and then use
> > simple_done_creating() to unlock.
> >
>
> Hi everyone,
>
> Amir suggested I run these through, and this commit was flagged:
>
> commit bc981629767980bbaee2ca3c7348b5a648665a9d
> Author: NeilBrown <neil@brown.name>
>
> selinux: Use simple_start_creating() / simple_done_creating()
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup. The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds. Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 3245cc531555b..7d4f90e5b12a0 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1931,15 +1931,16 @@ static const struct inode_operations swapover_d=
ir_inode_operations =3D {
> >  static struct dentry *sel_make_swapover_dir(struct super_block *sb,
> >                                               unsigned long *ino)
> >  {
> > -     struct dentry *dentry =3D d_alloc_name(sb->s_root, ".swapover");
> > +     struct dentry *dentry;
> >       struct inode *inode;
> >
> > -     if (!dentry)
> > +     inode =3D sel_make_inode(sb, S_IFDIR);
> > +     if (!inode)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     inode =3D sel_make_inode(sb, S_IFDIR);
> > -     if (!inode) {
> > -             dput(dentry);
> > +     dentry =3D simple_start_creating(sb->s_root, ".swapover");
> > +     if (!dentry) {
> > +             iput(inode);
> >               return ERR_PTR(-ENOMEM);
> >       }
>
> Can this cause a kernel crash when simple_start_creating() fails?
>
> The function simple_start_creating() returns ERR_PTR on failure, not
> NULL. The check `if (!dentry)` only catches NULL values. When
> simple_start_creating() fails and returns an ERR_PTR value like
> ERR_PTR(-ENOMEM), this value is non-NULL and the error check is bypassed.
>
> Execution would continue to d_make_persistent(dentry, inode), which
> attempts to lock dentry->d_lock, dereferencing the ERR_PTR value and
> causing a kernel crash.
>
> The old code used d_alloc_name() which returns NULL on error. The new
> code uses simple_start_creating() which returns ERR_PTR on error, but
> the error checking pattern wasn't updated to match.
>
> Should the check be `if (IS_ERR(dentry))` instead, and return dentry
> rather than ERR_PTR(-ENOMEM) to preserve the actual error code?

Good catch Chris, yes, please change this Neil and feel free to preserve my=
 ACK.

--=20
paul-moore.com

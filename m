Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC934F244
	for <netfs@lists.linux.dev>; Mon, 23 Feb 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839329; cv=pass; b=o8AxSR51ueurw13LZlr49w7VaxvZpEv0GhJ/KnWl9WNWn45FNOjPuZ9fGosu8yslBCOhBhqz6HUwiUPQwU50/HbkCU5qzP6a9jVXO3lrP8p7gMUNFHIet1JU3L6X1y83I4S5JEhHjzERImccHI2IiL3IhIYax37ugVERQq6v2ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839329; c=relaxed/simple;
	bh=mAAOjC5VpT1HkXsRAwtGw0eUE/35I2Skqe677nArRZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtBPTwE/DMvJJjX4fDz1Lkwc5iuu5BpFpSmR8RUzyoDRcLpkG2Ouh3ZVusWT8xcuLhMJqNRgcRQAwZ3o1WOBTtX6juib/3HMm7ruPW1q6j9RD1pIuk0itT2zUqp/f8sEt/67AiS5qW9DttdVciu6qruu5iGfZIZivrX3kRNgqqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+9HOdgX; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+9HOdgX"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65a11e565a9so4369358a12.3
        for <netfs@lists.linux.dev>; Mon, 23 Feb 2026 01:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771839326; cv=none;
        d=google.com; s=arc-20240605;
        b=MQIqkKpsNw3G9nrHA5gWJ3G5vXNWdKmpbX0PbOPOrPoJHV+cWRXWWB2eKd54YC8rA/
         XUUTEQXfoMGMyfMpm9I/r29VcojbgH8P/nXCEfL2l5/7LRP+O1onjvFrtVppUE66mw27
         oACQtFr77tt34JsyHiUc/ywQ0p7L5mtVkUUdtpkXDgwP7RnDP8pLDZCTHssp2RkFYQ/D
         ssnlaGhdEsSalyw1vNkwnQluLca2ntX5Bg+uwG2QbiFWdI6s4hsfbLZkSTSgjInM99ct
         xz9kOkJyqnxGQev/RO/xqHfdy3Bv0cG0qJvmu8fiOUZ4Gjp1qgfgttgXccFkvdt11qKx
         Yt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        fh=pC7kQ/hsbxdnKiDWCJ4YpUt7gg9OdMxFgP2QB/FMi7I=;
        b=DS/XcItJEiUpoo6u6PlbtU9mGzxAlHtxoUQ5PuWbIrG34duTIhRZdmTAYCYqsqCfZx
         hm7RYGE3oQ7sqBPYGSHl1hRgnY3s+C1p6CuMPTeKYZsip1v4XKA+2kDBKzCZD70Fryjj
         e5lUksic8lji1vHlkTTOz5+9xFnmou6dknE8AJXKJVwIZ64aQ6IbBDD+pCNOOZYsUGzE
         bsDC6TaeCaz+JiwchwO9g+WE8gVaC3LVkJI2PCc64Uy9eG400wT/eYr9/zC0P1KRXKw8
         SxIVgTqRjaZSO1sZcjmdwkkkWsP84UllYSvRmttnJcKGglb+nTnIc1K47IGlWT7d+Elc
         BXlQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771839326; x=1772444126; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=X+9HOdgX2/nOje6U9/ubHd4f1NznyuRgO6ELBcohdZKY7jdOyenmZ4MOuoqWq55S2o
         TQWFwDXV0lnpwdN5RnMKflC7OFqiY4yNNALWXU7OCw6/crniRrAduV9mGWRR/aDwuoEr
         Zt2RknqScqolWqd04YFSsU/8Hn6iNzPs7v2ES+Zrit2JF27HHemz4kASLQ4FXa6N4eqQ
         VXbs1ty5diYbzJmKz6AoX6bkvOfshSTTxmsnymfwVNPiLuoWrZemEd2Z6A+llx2tz6s5
         9iZa8lwwHm2cHilqF2sAzR27qe+jW4HUlj5DJO0u2rrjzGDDKlqwGOSJKiu5WVa5nW2h
         rYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839326; x=1772444126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=YFl8q7ZL8SoxNcnKfcv6IPNvF6mdSoUxR4EdZHBuL4x/sHwlByAnZHP5O1NvSEWVWJ
         PnHtmwStkzvEN9LysofhIuTOt0Jh69Lj0/EO2CI7YZZq2D0veLgCrKjFk9ikO2mKtAD0
         NbHyozZTDt7itlX3hhEDgEMzOPKcPmSKpt8BabTnAk3arej1WmpmrWr+EgdVjlFrDZDR
         qnSBjstMQAvCpGk5RVnYCNB08pJFSomMpoow9Z1ntI7ufEEixsyIqk9eULZAeiQ+yg1X
         9ojqZ0DV79UBaAoMvooDE/sZHP+IF3Rf2CGPvOl0ZHefTHc90PgG7op9hQKIT/b9TeTw
         SBQw==
X-Forwarded-Encrypted: i=1; AJvYcCUsLNUtR2J/oUpbQneC1RV0Sk9fiZMXzSAlNhxvirGXytY2klY7hWGdRBn2sjLUyR6sPQsebw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJUx+WpGG5BGlsURUDArTabMZBzswO7wL/b3Bju6KvNznTquxh
	vNQy0fL029oDmNtsHn1f3Z7SzklPQVaAwcEe25NovgIdEMusZVJXboy1Rf2z7UbG3mR1L1w55J+
	qkjasSnOPjsM6/G12gMtpLz/2RjwsDz0=
X-Gm-Gg: AZuq6aLuYbzgUn7jbQivt2mwGdQJC9Hxl50eUlX4XPSVxif0lT1X8In8u5Jezg4fcc2
	lOvTJjvv2wihnJYNsVFGAzAmIBvRJxq5/dSZn5BgzbK92gs3uZxtFqm2PFtyo28QD71UGQ3JIy4
	jwaGZH/8urALEPt1OS4nkIsisLepB4CGzRZXtACAEaeEYkgmTL9PzTC9c9uRpTAWApKBtT4/AdP
	ubZp5thM6L5RgBObBaGhtmCrfrN3GzRCbPVxQClNdGqfTX/zFfsYFDTpFCiZF9zgDo9wQbE1wIz
	DQMBpebXw5rL79wO2fHLThtr2uWY9oR0unj29/zYHQ==
X-Received: by 2002:a17:906:7307:b0:b88:5002:50c0 with SMTP id
 a640c23a62f3a-b90819db296mr564028666b.20.1771839325394; Mon, 23 Feb 2026
 01:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-12-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:35:14 +0200
X-Gm-Features: AaiRm51zLgcrRbPb_4HmwkH5uY0J9aukMWrvlX2vP_E-cCHRJFMZshxY7_A02Xw
Message-ID: <CAOQ4uxibL=2Z0FZMz5wMAo=JMaJouOVo3p7t3Fi3FR59U5Tu=g@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] ovl: pass name buffer to ovl_start_creating_temp()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:14=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Now ovl_start_creating_temp() is passed a buffer in which to store the
> temp name.  This will be useful in a future patch were ovl_create_real()
> will need access to that name.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..c4feb89ad1e3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -66,10 +66,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  }
>
>  static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> -                                             struct dentry *workdir)
> +                                             struct dentry *workdir,
> +                                             char name[OVL_TEMPNAME_SIZE=
])
>  {
> -       char name[OVL_TEMPNAME_SIZE];
> -
>         ovl_tempname(name);
>         return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
>                               &QSTR(name));
> @@ -81,11 +80,12 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>         struct dentry *whiteout, *link;
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
> +       char name[OVL_TEMPNAME_SIZE];
>
>         guard(mutex)(&ofs->whiteout_lock);
>
>         if (!ofs->whiteout) {
> -               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> +               whiteout =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(whiteout))
>                         return whiteout;
>                 err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> @@ -97,7 +97,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>         }
>
>         if (!ofs->no_shared_whiteout) {
> -               link =3D ovl_start_creating_temp(ofs, workdir);
> +               link =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(link))
>                         return link;
>                 err =3D ovl_do_link(ofs, ofs->whiteout, wdir, link);
> @@ -247,7 +247,9 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>                                struct ovl_cattr *attr)
>  {
>         struct dentry *ret;
> -       ret =3D ovl_start_creating_temp(ofs, workdir);
> +       char name[OVL_TEMPNAME_SIZE];
> +
> +       ret =3D ovl_start_creating_temp(ofs, workdir, name);
>         if (IS_ERR(ret))
>                 return ret;
>         ret =3D ovl_create_real(ofs, workdir, ret, attr);
> --
> 2.50.0.107.gf914562f5916.dirty
>

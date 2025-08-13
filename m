Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467772D7392
	for <netfs@lists.linux.dev>; Wed, 13 Aug 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069743; cv=none; b=A0DBM5ZT2vFBWM/Y/FhNN0oJcOfh5bp5iUW06NB5+6i3Q3mZ0QsPmNF4G41HoIvqEB2ePr0ge4cMqDH/rlBWmCriKO5b/zCqdR1+ldrL3EhzrFq07DEcb4clBGmlvDw6wPWrCth/UMmZ9SinzC8VDzjHHkUZCqm+RGtFoDceX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069743; c=relaxed/simple;
	bh=qvHDqa87IahpN0q2iuMXBlLhZe40i3HpmTPbG77YsM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sr+RLc14h6JOJPu2XncsUuSoz0+1VRWdCLw3xnSH+3Q5prlXwanGNz6Q+xtDw6XWjpip5K26yFG77ikv7+SIBPqtuXDH4EnTEUSkWjpNmf0quv/vyvsngNnDxnFEa3K+lFePedXZLSLGizFdxeyPZdpdaDr2hLGhtfR6ZF6C1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxroBGNl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxroBGNl"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so8670275a12.3
        for <netfs@lists.linux.dev>; Wed, 13 Aug 2025 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755069740; x=1755674540; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orpa4r8gH8eS0evni3lIuGSBjIWNZOO2BZpAbJmaB6A=;
        b=UxroBGNlygVW5aeXBiRueMOopu09eRcjXhPLrOjNK0NgBHEGRTlFzGv4GRL4o41y/b
         RPR2Zcr/ahZNO6akbT/Ab1dDIQYLtetAiDuX4ntmB0EbVAMXvHa2+U05szvt6s9EfxR2
         WF4g1i1Ie3+9Pf99Nm8OP0ChEyxwP2Uce/7BsMpkqoeQ2weHWF8pQB9FFWTsjl5kPvl2
         VlQmOaTYdETReZITUStUOmGWL5lNNFxAdZDMCpscIVICS2acYVC8JCveO12d8GQYvy5r
         WwqcP9yBsp9KFx6Fc4GMggnhhjL3ZPxu7uWwMJShxw6lg4Q1JnHlb+M29C3Ayv91iBmZ
         9heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069740; x=1755674540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orpa4r8gH8eS0evni3lIuGSBjIWNZOO2BZpAbJmaB6A=;
        b=ADWAtrLy00PUHyali0UuN6ypsmfh3SpFI0B+OLKpZFKL5/Yynh/tzbHO1hn5b0IQtj
         8VC9T5L1JTQfT5qcMbDt7L849qJzIJ9HyY0IWBSSta6tPn8OlE7tlnDHEl7cImR3koFr
         DRvLcdbX6SpJaN38Xl7FL99snUmwoS63n3msKbF8Oz0rAxvm9j3bUb+ayHvIe/i6fRYn
         7/P7TMQnIbrbYU/1kyzUyTEVbuZ0Lon7Ga1mryvZULA/s6rrQgQeWFuWmosf0X3HwwqM
         dVPWtRdtClKFvC28jGNDd+yrslHTuee0FjMpxdZzLmTmnHVPsTjcnohu36oShMy3ULLd
         1zsA==
X-Forwarded-Encrypted: i=1; AJvYcCXx2/zmxLtvyQ7lI1ni+4kR9ajGxr9w7cizKXX58Lz69oQFw/Sr0XLvkhKkiH79iahnf/Y/kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrIAmSDt0ta0Sf+WNa8TW/W72wllgeLPo0UnlixbBFVBlaVJe2
	I8ELaqn2ShV8YTM/O5fpcrnsbxqWsLTBIVH4M9yNnojFDUCeCJO1UPM9PnLzGfowIx0yyLy5YTR
	2hnUfMd+nXt3jEXcY3SKeYMZwyx7BquY=
X-Gm-Gg: ASbGncurT+16o7zXCYeKq2RhUNh32q3Lo83QyAi8YeOnaItycqQZdr+bPsxE5Llb0oJ
	xAbDneM9FR/xj9pbqRx4ouu5qqGgZwnigmiV88kxnQwBvltiDOeZO9KciH2J9EzoIObfhQ8vsME
	ZXleLAHlTPhqMgtAJAKA8bXTre5AB4nRyYQ5HgXoJNyslwBqXwUNYfoFRVGHI7kS6TQLOd2UhmE
	7653CVyq0KlzrTQzg==
X-Google-Smtp-Source: AGHT+IGOXg/qO7nOvSc+9upBTuFdN9gkoZr2ooHCH00oHdLGmBP/f/jaP6ih0T+T7ZtaDnRktY5n/bEZet/hUzbOyNs=
X-Received: by 2002:a17:907:7f90:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-afca4ccbdf5mr186837966b.5.1755069739183; Wed, 13 Aug 2025
 00:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812235228.3072318-1-neil@brown.name> <20250812235228.3072318-8-neil@brown.name>
In-Reply-To: <20250812235228.3072318-8-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Aug 2025 09:22:08 +0200
X-Gm-Features: Ac12FXwtRWkT3_8pRQNxkfPe9bIkc7MlydN-xB3KA9S7ZYYDtuYZQn46STskK1g
Message-ID: <CAOQ4uxhU12U8g_EYkUyc4Jdpzjy3hT1hZYB0L1THwvTsti8mTw@mail.gmail.com>
Subject: Re: [PATCH 07/11] VFS: Change vfs_mkdir() to unlock on failure.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Proposed changes to directory-op locking will lock the dentry rather
> than the whole directory.  So the dentry will need to be unlocked.
>
> vfs_mkdir() consumes the dentry on error, so there will be no dentry to
> be unlocked.

Why does it need to consume the dentry on error?
Why can't it leave the state as is on error and let the caller handle
its own cleanup?

>
> So this patch changes vfs_mkdir() to unlock on error as well as
> releasing the dentry.  This requires various other functions in various
> callers to also unlock on error - particularly in nfsd and overlayfs.
>
> At present this results in some clumsy code.  Once the transition to
> dentry locking is complete the clumsiness will be gone.
>
> Callers of vfs_mkdir() in ecrypytfs, nfsd, xfs, cachefiles, and
> overlayfs are changed to make the new behaviour.

I will let Al do the vfs review of this and will speak up on behalf of
the vfs users of the API

One problem with a change like this - subtle change to semantics
with no function prototype change is that it is a "backporting land mine"
both AUTOSEL and human can easily not be aware of the subtle
semantic change in a future time when a fix is being backported
across this semantic change.

Now there was a prototype change in c54b386969a5 ("VFS: Change
vfs_mkdir() to return the dentry.") in v6.15 not long ago, so (big) if this
semantic change (or the one that follows it) both get into the 2025 LTS
kernel, we are in less of a problem, but if they don't, it's kind of a big
problem for the stability of those subsystems in LTS kernels IMO -
not being able to use "cleanly applies and build" as an indication to
"likelihood of a correct backport".

and now onto review of ovl code...

> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 70b8687dc45e..24f7e28b9a4f 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -162,14 +162,18 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         goto out;
>  }
>
> +/* dir will be unlocked on return */
>  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent=
,
> -                              struct dentry *newdentry, struct ovl_cattr=
 *attr)
> +                              struct dentry *newdentry_arg, struct ovl_c=
attr *attr)
>  {
>         struct inode *dir =3D parent->d_inode;
> +       struct dentry *newdentry __free(dentry_lookup) =3D newdentry_arg;
>         int err;
>
> -       if (IS_ERR(newdentry))
> +       if (IS_ERR(newdentry)) {
> +               inode_unlock(dir);
>                 return newdentry;
> +       }
>
>         err =3D -ESTALE;
>         if (newdentry->d_inode)
> @@ -213,12 +217,9 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
truct dentry *parent,
>                 err =3D -EIO;
>         }
>  out:
> -       if (err) {
> -               if (!IS_ERR(newdentry))
> -                       dput(newdentry);
> +       if (err)
>                 return ERR_PTR(err);
> -       }
> -       return newdentry;
> +       return dget(newdentry);
>  }
>
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
> @@ -228,7 +229,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>         inode_lock(workdir->d_inode);
>         ret =3D ovl_create_real(ofs, workdir,
>                               ovl_lookup_temp(ofs, workdir), attr);
> -       inode_unlock(workdir->d_inode);

Things like that putting local code out of balance make my life as
maintainer very hard.

I prefer that you leave the explicit dir unlock in the callers until the ti=
me
that you change the create() API not require holding the dir lock.

I don't even understand how you changed the call semantics to an ovl
function that creates a directory or non-directory when your patch only
changes mkdir semantics, but I don't want to know, because even if this
works and I cannot easily understand how, then I do not want the confusing
semantics in ovl code.

I think you should be able to scope ovl_lookup_temp() with
dentry_lookup*() { } done_dentry_lookup() and use whichever semantics
you like about dir lock inside the helpers, as long as ovl code looks and f=
eels
balanced.

>         return ret;
>  }
>
> @@ -336,7 +336,6 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>                                     ovl_lookup_upper(ofs, dentry->d_name.=
name,
>                                                      upperdir, dentry->d_=
name.len),
>                                     attr);
> -       inode_unlock(udir);
>         if (IS_ERR(newdentry))
>                 return PTR_ERR(newdentry);
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 4f84abaa0d68..238c26142318 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -250,6 +250,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_=
fs *ofs,
>
>         ret =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
>         pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZE=
RO(ret));
> +       /* Note: dir will have been unlocked on failure */
>         return ret;
>  }
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index df85a76597e9..5a4b0a05139c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -328,11 +328,13 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>                 }
>
>                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> -               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 if (IS_ERR(work))
>                         goto out_err;
>
> +               dget(work); /* Need to return this */
> +
> +               done_dentry_lookup(work);

Another weird example.
I would expect that dentry_lookup*()/done_dentry_lookup()
would be introduced to users in the same commit, so the code
always remains balanced.

All in all, I think you should drop this patch from the series altogether
and drop dir unlock from callers only later after they have been
converted to use the new API.

Am I misunderstanding something that prevents you from doing that?

Thanks,
Amir.

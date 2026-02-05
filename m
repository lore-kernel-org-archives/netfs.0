Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D773D413D
	for <netfs@lists.linux.dev>; Thu,  5 Feb 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296696; cv=pass; b=leHkgFZPBplgTLltZctpwJUlQiR/MJApgMvAtdXGc5oBDJnvQ+unslGVDDqooDPhIYUvSrpOjdYEhVGI7kce0wCwGatXLDHJJ8YHZBdRS8hRz7XnzvOV0S859Z55I7GD4Fvjvj3My9x2nRSR5sRtLpELxZ9P+hQuc8sjdRWD9uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296696; c=relaxed/simple;
	bh=N2c1RM0b4ERNHu8Wc50fN3R9BsKRWCfa11p9n8FFco4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eok5C+7ffALHn+vK+LUNGzMJRcGbFUsSdo8UJSz/5WlLjcetqaE39uZ2E8AjMbOUSW36BYagf0Tp7/ckuc6BjOTKz9NnXc4kpJJ36qwDziz0PgMXD8f6DPkaWCTdiYDU3u4dlsRRg+M6hksM/7RcLsV7WhE3FujonheQYhSOjSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuUReMh+; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuUReMh+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-436263e31abso386007f8f.1
        for <netfs@lists.linux.dev>; Thu, 05 Feb 2026 05:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770296694; cv=none;
        d=google.com; s=arc-20240605;
        b=IljZrNNFQkY8vO6X3HXfnXW4CVCzVwTL7kAH+qqlH+5UUCK/DX1n0TVn1LrkOEO2A9
         ZLozYTpSbQWHJTu6VU7sybCz3axuZ+mVB3gXTM8KR0/JZnlmA2p2G3jqmKrYZ9QkIZ40
         1feEFEC/mRiOtSjNrBVUhmDyxzsfRnxSLERG5ZQv/RKp1crh1/0yiwUvnpyjiz0+RlZy
         5EoD3XiHcoPyQeHOTfBVKf9cYIo+sNIPLM7AFsvcEWKpkFBvMw7RRnIr4GO/PjJNoqut
         Lb/a6zuQL06yRdO4aG7U3Ar5cnBsW4bVdcT140jy0AU4UlLANTjIvRmt26pYz02gZpcf
         Swaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        fh=gqE0KzzY4tKuSya+iFo7YrOjSFUvuP7Y5heOvolgfjU=;
        b=iFrV+slrOtkOVqRsscnjzS8qb1EFbgmWoSK8O/Q5wwze9u9wULj++4aYtJ3g2QtfcQ
         +pQxohjTrJhqIKSZti8W2d5qazG5E17StzqAlPzDWeDtQjI/e9RsZIC+0RBRWmEkWiZz
         X0hvJuT1Hvwl0fgsiqiWdCIuD1ytv5PUrFEnapkSPEbK/Flw9BB56LrQQ3gNLGu9yqm1
         VlJtfeQvGfvyplCqIflCyqiApzVbLfm+Gmv+RX6EtgdlqQ+hbFGO/OrY9vvykBV3KMc6
         FVtc9UazT6bgGk7qH/3iFSe4KK++GPOujL4nJC/eJ4kKio7081MTZ8hbwDB9cjLMHHEf
         /5JA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296694; x=1770901494; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=SuUReMh+1TidPuYU/u1WjJ0R7EL3fOQdK/EM3kUkBdaKHt/MbstjWdvHw0DFB0ecqe
         QZntXzNHUFEk3TOECDXZ2/bAAxgiIz2E7GiLhs3bZj98xZ4d/GsdXlqGVk2HOmZBbBJX
         LXmPQFnuHGXU388/Kluxi0GBKToSe8XtXXjBFbkFssTIE1juGA6OqyWNdip4p1cZ045V
         cN1yxHWNz6ztmgDxP+hg6fR3dV4SabTjrk15dcJDgR+mikh4Tzt8ahb6YBo6Xeuc5thN
         ugC5v5+3L57U70lkLeh9uPHi3MVF9T9kldlQ1ptDkIugeb4ZlCAWCwVmjMPlqMN8UO5k
         g0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296694; x=1770901494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=r52h/Qx5vcp6pUq9zITtqv/OQ/uew0isvL92DxQRcjqhAhaUeedeGCiTypVh8tEanq
         WshTmHjh6d7ww6aQ7l8TxaeDwKHdHHQLPsdiqPfoMgfVqONclEoF9pFaRqe0fa78obza
         X7tdYQT4fH3VJ9drUTFQLtdcZUA8/7Up/OYp/n52ImBAvK70iFHdLZi3JgYdhm0zWezr
         JYbwqWMDer6+wHtjQEnULoEXchGiT1S4n5pPSrwovMojjj7DOBAE7JkI5WyDHx9WxtnW
         ZIKEq5ERYPmcrebl8ADGUriewyGDZcWO1R3ADo+k5vFkK7ZzHx6KhTOuLHP8vDdrxKQq
         w6BA==
X-Forwarded-Encrypted: i=1; AJvYcCUiAxf0TtbQYGBUfqamFLawoKfXnk9unUlFEc6SGNAx+yL1UJZlvdZ5J7YsOzYoppkk+P+ELw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdNX347YEJFiBkgyDp7fdvbkau2YE9kHyIs8RS18qw/ChpKri3
	zw4WD8By8+/zLdKQO0Sk1MO2n1R505TVnu7VVV6gUIPHPp+iiphNsSWBCDeYAotvHhD13bH4cqE
	bLaKTH7Xfpx7P/8e8nh/7m+4VKM1Q4Vw=
X-Gm-Gg: AZuq6aK3IzXMj4vgAL1wy7D8O2O4snccjvHVHW0MVlep14GNJ1paDU/ghkcceADLjMi
	aOCz9ThkGZJu/Z589c4JhMv5f1lpfFWzJg6Fjm7SZwFnglByqeiKrZLglCwPGCamIRl8zqPPkBF
	VuWBCzXWvBAzR4Sdu3t4H7ZTHdo18ey98BmAhmzJaA84a/7OXK6FQ+dPmY3WP5j8qNW+ooSHYPQ
	IhOV2vyHZ8KESPVRwPawmiOtgpj8/tWvqtP+vaSsYtDARjf+m84ipLuemT9zO+3C8pmLukmGo/E
	3JCL63mD9nHBNzlUipxY7N26tT06Tw==
X-Received: by 2002:a05:6000:1acb:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-43618053bc4mr9962281f8f.39.1770296693827; Thu, 05 Feb 2026
 05:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-9-neilb@ownmail.net>
 <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
In-Reply-To: <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 14:04:42 +0100
X-Gm-Features: AZwV_QhEkTNuUX-zP-udJB3TTtiGdaNYEr11QFKjoqWXaHOUCtxdu5bQUZv0f1A
Message-ID: <CAOQ4uxh_Ugyy9=Vx_XOzWMTdhqVx6kAu43q+F+afhNF_Zv_9TA@mail.gmail.com>
Subject: Re: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > The primary purpose of this patch is to remove the locking from
> > ovl_lookup_real_one() as part of centralising all locking of directorie=
s
> > for name operations.
> >
> > The locking here isn't needed.  By performing consistency tests after
> > the lookup we can be sure that the result of the lookup was valid at
> > least for a moment, which is all the original code promised.
> >
> > lookup_noperm_unlocked() is used for the lookup and it will take the
> > lock if needed only where it is needed.
> >
> > Also:
> >  - don't take a reference to real->d_parent.  The parent is
> >    only use for a pointer comparison, and no reference is needed for
> >    that.
> >  - Several "if" statements have a "goto" followed by "else" - the
> >    else isn't needed: the following statement can directly follow
> >    the "if" as a new statement
> >  - Use a consistent pattern of setting "err" before performing a test
> >    and possibly going to "fail".
> >  - remove the "out" label (now that we don't need to dput(parent) or
> >    unlock) and simply return from fail:.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
> >  1 file changed, 26 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb1567..dcd28ffc4705 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct =
dentry *connected,
> >                                         struct dentry *real,
> >                                         const struct ovl_layer *layer)
> >  {
> > -     struct inode *dir =3D d_inode(connected);
> > -     struct dentry *this, *parent =3D NULL;
> > +     struct dentry *this;
> >       struct name_snapshot name;
> >       int err;
> >
> >       /*
> > -      * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> > -      * from racing with overlay rename. If the overlay dentry that is=
 above
> > -      * real has already been moved to a parent that is not under the
> > -      * connected overlay dir, we return -ECHILD and restart the looku=
p of
> > -      * connected real path from the top.
> > +      * @connected is a directory in the overlay and @real is an objec=
t
> > +      * on @layer which is expected to be a child of @connected.
> > +      * The goal is to return a dentry from the overlay which correspo=
nds

As the header comment already says:
"...return a connected overlay dentry whose real dentry is @real"

The wording "corresponds to @real" reduces clarity IMO.

> > +      * to @real.  This is done by looking up the name from @real in
> > +      * @connected and checking that the result meets expectations.
> > +      *
> > +      * Return %-ECHILD if the parent of @real no-longer corresponds t=
o
> > +      * @connected, and %-ESTALE if the dentry found by lookup doesn't
> > +      * correspond to @real.
> >        */

I dislike kernel-doc inside code comments.
I think this is actively discouraged and I haven't found a single example
of this style in fs code.

If you want to keep this format, please lift the comment to function
header comment - it is anyway a very generic comment that explains the
function in general.

> > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > -     err =3D -ECHILD;
> > -     parent =3D dget_parent(real);
> > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > -             goto fail;
> >
> > -     /*
> > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > -      * from racing with underlying layer rename. In this case, we don=
't
> > -      * care about returning ESTALE, only from dereferencing a free na=
me
> > -      * pointer because we hold no lock on the real dentry.
> > -      */
> >       take_dentry_name_snapshot(&name, real);
> > -     /*
> > -      * No idmap handling here: it's an internal lookup.
> > -      */
> > -     this =3D lookup_noperm(&name.name, connected);
> > +     this =3D lookup_noperm_unlocked(&name.name, connected);
> >       release_dentry_name_snapshot(&name);
> > +
> > +     err =3D -ECHILD;
> > +     if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> > +             goto fail;
> > +
> >       err =3D PTR_ERR(this);
> > -     if (IS_ERR(this)) {
> > +     if (IS_ERR(this))
> >               goto fail;
> > -     } else if (!this || !this->d_inode) {
> > -             dput(this);
> > -             err =3D -ENOENT;
> > +
> > +     err =3D -ENOENT;
> > +     if (!this || !this->d_inode)
> >               goto fail;
> > -     } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> > -             dput(this);
> > -             err =3D -ESTALE;
> > +
> > +     err =3D -ESTALE;
> > +     if (ovl_dentry_real_at(this, layer->idx) !=3D real)
> >               goto fail;
> > -     }
> >
> > -out:
> > -     dput(parent);
> > -     inode_unlock(dir);
> >       return this;
> >
> >  fail:
> >       pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
> >                           real, layer->idx, connected, err);
> > -     this =3D ERR_PTR(err);
> > -     goto out;
> > +     if (!IS_ERR(this))
> > +             dput(this);
> > +     return ERR_PTR(err);
> >  }
> >
> >  static struct dentry *ovl_lookup_real(struct super_block *sb,
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Otherwise, it looks fine.

Thanks,
Amir.

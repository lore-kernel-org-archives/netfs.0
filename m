Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BC3B8D65
	for <netfs@lists.linux.dev>; Fri,  6 Feb 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384939; cv=pass; b=r1b3L8V2+1w7DaXRlfMK6uErDA/HQJ4eDkXd2EWsxgYFu1F+l+sm4oET8SXHeCp82Ht5dcCKM85pq1s+kO7E3QSqVwKCrRBlOruFwlG2DdRSlMvT+qh96yHQhe3lCJ0fLdrY97y+aXjUOQjPbFnO1TFWacXjEyHfbxB/ZTTUYUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384939; c=relaxed/simple;
	bh=RxTY2ZddbzZaifKXYPGFFlp4mavJ0NrEEi4EM4pjmj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEHzs/ge3WV0KoA+tjh8gWh5Od6sMCsJYXXPf47eCf7rYiRM8gPLNm80oqB8pOm7of7r7gcgDQNEC8ypSBTufqJGPE1MLRq3Uz5OX9/jqWRCy+gpGq4JEfG4EfH+Eis4hBWFVhRp7DIQcEXMTEnp0Xhp0X8pbAF8hndnBv7F1+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKj7akIs; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKj7akIs"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-658cc45847cso3133240a12.0
        for <netfs@lists.linux.dev>; Fri, 06 Feb 2026 05:35:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770384937; cv=none;
        d=google.com; s=arc-20240605;
        b=cEigK8OlCSRLF1S0GNbmz7pHUtYRSpVIt3NxCWljchYmC+yJsjjwIMDoVwaycaFzxg
         GjGgiVk2OzfE8M4MhfkvJt+h0HvENcDBg0I7Ioid9jHW6zqXC1ip5K9ZkNPDMDN2ZxjW
         OALi6CWN1B0Z7rYG7swfptKKiuRR/RuJr80SOjeMxdVM9ART88SujhuYTGeSgR28MzDY
         IeLWha2gMPg6v050Bd9bS7Ngx+RmaPUguAOjw40MMiFTih9ojwBeDUraP28Gx1UnEO0T
         T151cZrN6Nm7+7YrkBED7J2XSulhf4VsCvH7BtRagm2VnPAdr46gLYMxxfMThy/kUNiz
         TJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EpmWnKuQAvcxfN2n9Aws3fxLD/5TLycZ+iQI8ZhYj4E=;
        fh=x6P4ZfhE5bFrloQfxmygy5ITY+TAAET6TTJGMiS+hkM=;
        b=dWyD0Z6dTbcvxtoutu3wSp/j502X0EKpmSl7tqQmzC3VxSLtjXTXVkypDJjm9Pt4JX
         UDu8sIPjrP9Bk62g5Pi0iqPqcLQ01YzeC7Miq14CL3PL9fwPAR44RnUlLN+j8vMEV3c7
         OwJt1HDqgsHQ0/4TFLMPet8nTMPg7lzgWf+KS0ZD6MkghX3DS7TFLkSd+xgcSF/R+EM9
         CBzj4zgirLGQGTzsd42mbr72MeH6K9le9XQEgVBWDI8Q7WQlBcW8RrI0pEn3qw2yNRS0
         ZIRWoUnNF3T8aM4DhLjeMesSSAzYNNUiQ/Bez11eIhGI6MQSIHpke/5TXFJ1vewL501g
         CMig==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384937; x=1770989737; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpmWnKuQAvcxfN2n9Aws3fxLD/5TLycZ+iQI8ZhYj4E=;
        b=dKj7akIs2tNNGjt/hUaCrh9cgOvA2HDH98k2Zc7XbomnyXn55mnB3+De1lDjNSnt9n
         Lbu3aUSK5iPNb50xMwPZYr+XcPVg3Tx8m2SrB+f7XN1bUg05nCYcCrQkl8ZC65h2SanY
         E8IxZSWLQycQErRQ9+mR3GZMUD7zGMk2HTII2zPXyYlG1xaPGU45+zGk7hqHG00a1vCe
         8OpCQ6QojYIe+EHyk7H4ngyFpQFksvC05+UVoDymezXtpGAlYwDNjVDP/nIuMLA3Qo2u
         IzcX28DRvJEyk+53r1yeA0sKR9mf4Hg0QkIHTOrqF43mjUqB9F50lvtkMe8ZUMul2unW
         Msuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384937; x=1770989737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpmWnKuQAvcxfN2n9Aws3fxLD/5TLycZ+iQI8ZhYj4E=;
        b=xSjjgmQ9E4PsmFdXnXNnK8Jh/DGlA9OTWI2UOoB0oQhDpYHY+BLq2MwSoEJ7ts70AD
         LFsh6ZF26up/YyK0I+ZsdAwavA8b7yqdqoKIMIiRBS8fx6PJaI4RNUCJ0aTse8InJ26e
         257Kus/52/zpmPdv/8YOsSCVYgqEI5lidFgwRgKqPNkNJVLc7FpWXEsJD7x7xV23CwG8
         PwbreiBxkKuSvgpAsxpa49GawzKB/U0YQl1Gp1ZndgxTFUFvdfF0FIsVYjNoUvLsji9Q
         Qrh8d06TZ7fNN9pz3+3bu6zYvfmtu6T+MBbTOp9zoz6DmCFSBWYlN5M+dp/8W0AlXUPh
         u7LA==
X-Forwarded-Encrypted: i=1; AJvYcCUFNaW/+CV/O/Jek8RMMyx22WcFF81h26+QIdZon9J4iPp5ojZtnH6EbtXl3vKArZlKbvJsMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGPWGTB+o10yHa4GTFOAa9+NvNuT1nEzz4Yt29CRrvGbDH4NaF
	QJoFm+Lb90SomLz6rmfkea6O6QTMTtqlflZoyBEcDeqOodDkjxkswXTPLKD2LDBkpXc1CfXUvmR
	abUNoWBgOXAPPBK71ugZW/8OLzlKlYWU=
X-Gm-Gg: AZuq6aIv7WV6rsM0jgBESnsfLYotKtN1ODzjhIY81V5HlFCIyczv1t3oByAZvtu7YDB
	39iLhruedr0usgTeY3HD7dsVyn6DUBYcQWrGwH4HTidxjv9ayMbc/NZm40tspOPdxVz+6Asoo5H
	v1ET5ECM1G4QDu4zV8RGvcTZ8K+GjaMtfrTdNmAGF7l5rlYoHAt9ccDkzraVujupuehVrC7kJWN
	FNUlpw3nVW6KwA/O3t4ihm//pYIGdwPu69EEbQnAiRmOasA1XI1tfpIiOh7+GCg+K4CcewDhRGb
	BMhPmjqno3t/6F4wUCtyvzVbdeezWvnHUpmNb75K
X-Received: by 2002:a05:6402:518f:b0:658:bd60:43e2 with SMTP id
 4fb4d7f45d1cf-659841692cdmr1419837a12.17.1770384937041; Fri, 06 Feb 2026
 05:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-11-neilb@ownmail.net>
 <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com> <177034031005.16766.246184445940612287@noble.neil.brown.name>
In-Reply-To: <177034031005.16766.246184445940612287@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 6 Feb 2026 14:35:25 +0100
X-Gm-Features: AZwV_QjjYiogfyc5arz_rTitKV8bnytIdEM4CjRfI_5mGtvMvwFYoZk4un_zak4
Message-ID: <CAOQ4uxiWE5eVTrL-2EWVHGQEpEX7HSstj_+kEp-b7xZrnfoXMA@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 2:11=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> On Thu, 05 Feb 2026, Amir Goldstein wrote:
> > On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wr=
ote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > When ovl_create_real() is used to create a file on the upper filesyst=
em
> > > it needs to return the resulting dentry - positive and hashed.
> > > It is usually the case the that dentry passed to the create function
> > > (e.g.  vfs_create()) will be suitable but this is not guaranteed.  Th=
e
> > > filesystem may unhash that dentry forcing a repeat lookup next time t=
he
> > > name is wanted.
> > >
> > > So ovl_create_real() must be (and is) aware of this and prepared to
> > > perform that lookup to get a hash positive dentry.
> > >
> > > This is currently done under that same directory lock that provided
> > > exclusion for the create.  Proposed changes to locking will make this
> > > not possible - as the name, rather than the directory, will be locked=
.
> > > The new APIs provided for lookup and locking do not and cannot suppor=
t
> > > this pattern.
> > >
> > > The lock isn't needed.  ovl_create_real() can drop the lock and then =
get
> > > a new lock for the lookup - then check that the lookup returned the
> > > correct inode.  In a well-behaved configuration where the upper
> > > filesystem is not being modified by a third party, this will always w=
ork
> > > reliably, and if there are separate modification it will fail cleanly=
.
> > >
> > > So change ovl_create_real() to drop the lock and call
> > > ovl_start_creating_upper() to find the correct dentry.  Note that
> > > start_creating doesn't fail if the name already exists.
> > >
> > > This removes the only remaining use of ovl_lookup_upper, so it is
> > > removed.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
> > >  fs/overlayfs/overlayfs.h |  7 -------
> > >  2 files changed, 18 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index ff3dbd1ca61f..ec08904d084d 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *o=
fs, struct dentry *parent,
> > >                 err =3D -EIO;
> > >         } else if (d_unhashed(newdentry)) {
> > >                 struct dentry *d;
> > > +               struct name_snapshot name;
> > >                 /*
> > >                  * Some filesystems (i.e. casefolded) may return an u=
nhashed
> > > -                * negative dentry from the ovl_lookup_upper() call b=
efore
> > > +                * negative dentry from the ovl_start_creating_upper(=
) call before
> > >                  * ovl_create_real().
> >
> >
> > According to the new locking rules, if the hashed dentry itself is
> > the synchronization object, is it going to be allowed to
> > filesystem to unhash the dentry while the dentry still in the
> > "creating" scope? It is hard for me to wrap my head around this.
>
> It can be confusing....
>
> It will be important for the name the remain locked (and hashed) until
> the operation (create, remove, rename) either succeeds or fails.  So
> leaving a dentry unhashed will be OK providing a subsequent lookup will
> also succeed or fail in the same way.  The caller must be able to use
> the dentry to access the object (i.e.  the inode) on success, but they
> is nothing in POSIX that requires that the object still has any
> particular name.
>
> >
> > Or do we need this here because some filesystems (casefold in
> > particular) are not going to support parallel creations?
>
> There is no reason that a casefolding filesystem would not support parall=
el
> ops. And it isn't just casefolding that acts like this.  At least one of
> the special filesystems (tracefs maybe) always unhashes on create.  You
> only ever get a hashed positive dentry as a result of lookup.
> (overlayfs would never see this case of course).
>
> >
> > >                  * In that case, lookup again after making the newden=
try
> > >                  * positive, so ovl_create_upper() always returns a h=
ashed
> > >                  * positive dentry.
> > > +                * As we have to drop the lock before the lookup a ra=
ce
> > > +                * could result in a lookup failure.  In that case we=
 return
> > > +                * an error.
> > >                  */
> > > -               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, p=
arent,
> > > -                                    newdentry->d_name.len);
> > > -               dput(newdentry);
> > > -               if (IS_ERR_OR_NULL(d))
> > > +               take_dentry_name_snapshot(&name, newdentry);
> > > +               end_creating_keep(newdentry);
> > > +               d =3D ovl_start_creating_upper(ofs, parent, &name.nam=
e);
> > > +               release_dentry_name_snapshot(&name);
> >
> > OK. not saying no to this (yet) but I have to admit that it is pretty
> > ugly that the callers of ovl_create_real() want to create a specific
> > stable name, which is could be passed in as const char *name
> > and yet we end up doing this weird dance here just to keep the name
> > from newdentry.
>
> There are three callers of ovl_create_real()
>
> ovl_lookup_or_create() does have a "const char *name".
> ovl_create_upper() has a stable dentry from which it can copy a QSTR
> ovl_create_temp() would need some sort of dance to keep hold of the
> temporary name that was allocated.
>
> If it weren't for ovl_create_temp() I would agree with you.
>
> Though we could have the three callers of ovl_start_creating_temp() pass =
a
> "char name[OVL_TEMPNAME_SIZE]" in, then ovl_create_temp() would have
> easy access.
> I could do that if you like.

Yes, considering that two of the callers are from the same function
(ovl_whiteout()) I think that would end up looking nicer.

Thanks,
Amir.

Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34C301002
	for <netfs@lists.linux.dev>; Thu, 14 Aug 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178209; cv=none; b=PG+Z95Hh1uOrY1/obL9J/Egaq2phEt4EGSJ/Qal5uEbU+xIx89HUeIGPqaj5zdirjegGYIZ9ZygvgiiY4yPcOcSJaUslltwhSepFBhKkLIO+H/ECykNRVVNcTexA9ZGzGtp9bP1zZLEAehJQRv+GWANPDhNEGXx+GU6VMA/a9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178209; c=relaxed/simple;
	bh=mz/EB8bjGVFaTkJpTORl4PmW5zhONLp9lrpEf91GTfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC32oC8zIvwHBZ6vIJfjtozeAv2LVCh7nCXW5SS7VcIV/UXJ2hfYSI3hpul7KsCVGVH1h18vdZkmq04UOexiA/a4GkhBPpFvQjLOovQFRxfSYmRw6cU/gd5+a61gHXOCe0CpiAn8i4dvqGFQ/M5LZlM2PCofVpUAIhlbFxapk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpcsWB+7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpcsWB+7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso132179466b.1
        for <netfs@lists.linux.dev>; Thu, 14 Aug 2025 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178205; x=1755783005; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+sFdasJXWxfNXSbJ4iDlEiy+aB7L4ETM4G4NZ6zYjs=;
        b=bpcsWB+7JSzpOk7Ah05dvkVt9aY+ZINLCKVgTxaaXNz3a4yidcDTUTBAtijdxnqPXO
         PU5UXmMJQ1cicU1FSHfb1Jsgf8e00UvJIdB1akZonZl36f0GraMHSuHgVIQPh7iKXlMJ
         LSKiKpzHrmuRUrOqNB1PsEbvDIlf/DBypUxnoeeuPgz2RFJysISHLCvVczT3jehMReS3
         m/70SYf6x2Cf+gT37R1MRG3+tCZlK76GDXnY0E4Mz3wvNNRvmgwmX7MuQYd6InV6JmkD
         8iFY6eDpnOITt9pxhnBg5qQb/xwY97eJzSrQtIpnJmpVfPBNTKriFKIhtFGc7aIidxgT
         LMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178205; x=1755783005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+sFdasJXWxfNXSbJ4iDlEiy+aB7L4ETM4G4NZ6zYjs=;
        b=oIyaApGbuqSFUpoU9zNWJwP1qFkKmBpiqV/BNyOuLYldKJOPmRtJ9/2uLV0zk/fcZg
         1nYYrJyqMjpSWRKMB5df05jAdE32+goa4FNwh0kROqkbOObRwWJcNtdNhlkTlJkC0IvL
         NdObGDRLkRrxyQypP04nJ6p2Mo+dZUZWvRJNdbgQBQOyM/8LL76K2xWQyogdbIrnZtRP
         fJbQMf9AE1Ne0wtTtAIGQeb05TpP6qomyAAzgytv/e167/YMspCHPRNo3UE59+EQIn+b
         aS9Ug7agc3F7wjbigCwctSgd/tEVBS1e9XfzeTIFPPTxj6cTRznUnaPmPOC4kHNsibSL
         Btfg==
X-Forwarded-Encrypted: i=1; AJvYcCXWmkvlDx3maXdoDMl2WQFfS4xnft8BfxJItwdlzUyJAaN8Ime095ijRSjsdgWRfdC9aIPk2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YywLswDJEF22rXMYzL0DjVamRen/Tzwt7/aFDU64BlMiJsuFVCa
	EK5cSGqbcE1vp7VTj0CUhRufq0mWZOiFuI4WGSO/XqQIrHxihJtgN3FYMgjSQdUTzcveU5+0VYj
	DBiyFCAr/VW4rThuJegh9cqVi9dLIaDA=
X-Gm-Gg: ASbGncus9zyTMqrXZJI/MEIGq6leWjt4DtWrhB+XCirB81wRdwXIiHrr3qaWbOSbj9H
	OJGFWzX6+3AkoyEFnfKFmrzQUzGacEKmqrrskCYA9NBxlZUG3xrcB//mXgs522jIGgWUOPeNEmE
	EhLEKlzPQnY5PdCcOodlTXqih0lUlOpv4xkPc+dkfvqZP18MbJ5IgiUBqi+xCwV9aJbyC5sSzD+
	MVtSTY=
X-Google-Smtp-Source: AGHT+IF84TnvlblMj92h1a2Bo7TYhB47u4luhSDqElmXWYB8ydmWjP6VQfTOERhCfol8XKnqfmbc3XrMKYns1uVE0xg=
X-Received: by 2002:a17:907:608b:b0:af9:6e2b:f30c with SMTP id
 a640c23a62f3a-afcb986ae60mr289124166b.34.1755178204916; Thu, 14 Aug 2025
 06:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOQ4uxhU12U8g_EYkUyc4Jdpzjy3hT1hZYB0L1THwvTsti8mTw@mail.gmail.com>
 <175513400457.2234665.11514455496974675927@noble.neil.brown.name>
In-Reply-To: <175513400457.2234665.11514455496974675927@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 15:29:53 +0200
X-Gm-Features: Ac12FXxaF_DShrx33OMj2V-_0xjYwSUw8hYkyRK9A3TCkQqo54t8CoTIX4YaDII
Message-ID: <CAOQ4uxg0K8s=dB6rG19bwj6bamsUOY7mRNhhg2ES-Y1CK7+3OA@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 3:13=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 13 Aug 2025, Amir Goldstein wrote:
> > On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > Proposed changes to directory-op locking will lock the dentry rather
> > > than the whole directory.  So the dentry will need to be unlocked.
> > >
> > > vfs_mkdir() consumes the dentry on error, so there will be no dentry =
to
> > > be unlocked.
> >
> > Why does it need to consume the dentry on error?
>
> Because when the recent change was made to have vfs_mkdir() and ->mkdir
> handling the fact that the passed-in denty might not be used, that was
> the interface that was deemed to be best of all that were considered.
>
>
> > Why can't it leave the state as is on error and let the caller handle
> > its own cleanup?
>
> There are three possible results from vfs_mkdir()
>  - the dentry that was passed in has been instantiated
>  - a different dentry was already attached to the inode, and it has been
>    splice in to the given name
>  - there was an error.
>
> In the second case it seems easiest to dput() the original dentry as it
> is no longer interesting and that saves the caller from having the test
> and maybe dput() - all callers would need identical handling.
> It seemed most consistent to always dput() the passed-in dentry if it
> wasn't returned.
> >
> > >
> > > So this patch changes vfs_mkdir() to unlock on error as well as
> > > releasing the dentry.  This requires various other functions in vario=
us
> > > callers to also unlock on error - particularly in nfsd and overlayfs.
> > >
> > > At present this results in some clumsy code.  Once the transition to
> > > dentry locking is complete the clumsiness will be gone.
> > >
> > > Callers of vfs_mkdir() in ecrypytfs, nfsd, xfs, cachefiles, and
> > > overlayfs are changed to make the new behaviour.
> >
> > I will let Al do the vfs review of this and will speak up on behalf of
> > the vfs users of the API
> >
> > One problem with a change like this - subtle change to semantics
> > with no function prototype change is that it is a "backporting land min=
e"
> > both AUTOSEL and human can easily not be aware of the subtle
> > semantic change in a future time when a fix is being backported
> > across this semantic change.
> >
> > Now there was a prototype change in c54b386969a5 ("VFS: Change
> > vfs_mkdir() to return the dentry.") in v6.15 not long ago, so (big) if =
this
> > semantic change (or the one that follows it) both get into the 2025 LTS
> > kernel, we are in less of a problem, but if they don't, it's kind of a =
big
> > problem for the stability of those subsystems in LTS kernels IMO -
> > not being able to use "cleanly applies and build" as an indication to
> > "likelihood of a correct backport".
>
> Renaming to vfs_mkdir2() might be justified.  I think we have to change
> the interface somehow to enable per-dentry locking, and I don't think a
> signature change would be justified.  So maybe a name change is needed.

Fine by me. as long as we avoid the risk of hidden backport traps.

> >
> > and now onto review of ovl code...
> >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index 70b8687dc45e..24f7e28b9a4f 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -162,14 +162,18 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs=
, struct dentry *dir,
> > >         goto out;
> > >  }
> > >
> > > +/* dir will be unlocked on return */
> > >  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *pa=
rent,
> > > -                              struct dentry *newdentry, struct ovl_c=
attr *attr)
> > > +                              struct dentry *newdentry_arg, struct o=
vl_cattr *attr)
> > >  {
> > >         struct inode *dir =3D parent->d_inode;
> > > +       struct dentry *newdentry __free(dentry_lookup) =3D newdentry_=
arg;
> > >         int err;
> > >
> > > -       if (IS_ERR(newdentry))
> > > +       if (IS_ERR(newdentry)) {
> > > +               inode_unlock(dir);
> > >                 return newdentry;
> > > +       }
> > >
> > >         err =3D -ESTALE;
> > >         if (newdentry->d_inode)
> > > @@ -213,12 +217,9 @@ struct dentry *ovl_create_real(struct ovl_fs *of=
s, struct dentry *parent,
> > >                 err =3D -EIO;
> > >         }
> > >  out:
> > > -       if (err) {
> > > -               if (!IS_ERR(newdentry))
> > > -                       dput(newdentry);
> > > +       if (err)
> > >                 return ERR_PTR(err);
> > > -       }
> > > -       return newdentry;
> > > +       return dget(newdentry);
> > >  }
> > >
> > >  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *wo=
rkdir,
> > > @@ -228,7 +229,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs=
, struct dentry *workdir,
> > >         inode_lock(workdir->d_inode);
> > >         ret =3D ovl_create_real(ofs, workdir,
> > >                               ovl_lookup_temp(ofs, workdir), attr);
> > > -       inode_unlock(workdir->d_inode);
> >
> > Things like that putting local code out of balance make my life as
> > maintainer very hard.
>
> I understand.  By the end of the change this is no longer unbalanced.
> Keeping the code perfect at each step while making each step coherent
> enough to be reviewed is a challenge.
>

I am not sure when "by the end of the change" is going to land
but I do not feel comfortable leaving the ovl code in a hard to
maintain state.

>
> >
> > I prefer that you leave the explicit dir unlock in the callers until th=
e time
> > that you change the create() API not require holding the dir lock.
> >
> > I don't even understand how you changed the call semantics to an ovl
> > function that creates a directory or non-directory when your patch only
> > changes mkdir semantics, but I don't want to know, because even if this
> > works and I cannot easily understand how, then I do not want the confus=
ing
> > semantics in ovl code.
> >
> > I think you should be able to scope ovl_lookup_temp() with
> > dentry_lookup*() { } done_dentry_lookup() and use whichever semantics
> > you like about dir lock inside the helpers, as long as ovl code looks a=
nd feels
> > balanced.
> >
> > >         return ret;
> > >  }
> > >
> > > @@ -336,7 +336,6 @@ static int ovl_create_upper(struct dentry *dentry=
, struct inode *inode,
> > >                                     ovl_lookup_upper(ofs, dentry->d_n=
ame.name,
> > >                                                      upperdir, dentry=
->d_name.len),
> > >                                     attr);
> > > -       inode_unlock(udir);
> > >         if (IS_ERR(newdentry))
> > >                 return PTR_ERR(newdentry);
> > >
> > > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > > index 4f84abaa0d68..238c26142318 100644
> > > --- a/fs/overlayfs/overlayfs.h
> > > +++ b/fs/overlayfs/overlayfs.h
> > > @@ -250,6 +250,7 @@ static inline struct dentry *ovl_do_mkdir(struct =
ovl_fs *ofs,
> > >
> > >         ret =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode=
);
> > >         pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_O=
R_ZERO(ret));
> > > +       /* Note: dir will have been unlocked on failure */
> > >         return ret;
> > >  }
> > >
> > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > index df85a76597e9..5a4b0a05139c 100644
> > > --- a/fs/overlayfs/super.c
> > > +++ b/fs/overlayfs/super.c
> > > @@ -328,11 +328,13 @@ static struct dentry *ovl_workdir_create(struct=
 ovl_fs *ofs,
> > >                 }
> > >
> > >                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> > > -               inode_unlock(dir);
> > >                 err =3D PTR_ERR(work);
> > >                 if (IS_ERR(work))
> > >                         goto out_err;
> > >
> > > +               dget(work); /* Need to return this */
> > > +
> > > +               done_dentry_lookup(work);
> >
> > Another weird example.
> > I would expect that dentry_lookup*()/done_dentry_lookup()
> > would be introduced to users in the same commit, so the code
> > always remains balanced.
> >
> > All in all, I think you should drop this patch from the series altogeth=
er
> > and drop dir unlock from callers only later after they have been
> > converted to use the new API.
> >
> > Am I misunderstanding something that prevents you from doing that?
>
> I think I tried delaying the vfs_mkdir() change and stumbled.
> The problem involved done_path_create(). e.g. dev_mkdir() calls
>   kern_path_create()
>   vfs_mkdir()
>   done_path_create()
>
> Changing semantics of vfs_mkdir() necessitated a corresponding change in
> done_path_create() and doing that necessitated prep elsewhere.
> init_mkdir and ksmbd_vfs_mkdir follow the same pattern.
>
> Maybe I could temporarily introduce a done_path_create_mkdir() for
> those.
>

Can't say I went to check what all this means, but introducing
temporary helpers as scaffolding along the way and removing them
later is perfectly fine by me as far as the ovl code is concerned as
long as ovl code remains readable and well balanced.

Thanks,
Amir.

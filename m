Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92442848B4
	for <netfs@lists.linux.dev>; Mon, 10 Nov 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790952; cv=none; b=eWgML7OaXmpvq85oTNwc3W3LtjG7f0l5kV1s/tvMLM/PPua4K8ZvjD0DV+EdOv37Z7+o9ydMq8p11jGWGx6axZovni0CNNuOHkR1MM/z6HhJ9XknlVrQRJF6kLzWsL8QzgJ5mwQ/7G0dQpqTZXscdlUgkzbOaQlAognBUWy+t8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790952; c=relaxed/simple;
	bh=OKZOzwPNbZ0eA/RzD6GT+kbo2DW/QUWT3Vl/4pt9v6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiwKgSHQEF73kOO9dmrILHlUsd/bCektTGGEAS7Phte/PdB+OubmFyYW7SlGyCe/NVv+ioZUIrBvEzQwZZllq3+3+HjnrOWbJBkmkNkrgN69QUPeQEb01dqlhlPF6JffhI/DQg+N+gCRFNH9Q8foNlF1vwG/ia84SH+2yLFaN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyLVtpvx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyLVtpvx"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2602338a12.1
        for <netfs@lists.linux.dev>; Mon, 10 Nov 2025 08:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790949; x=1763395749; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s031glNNGPLU3pRhUQF/ls9Tz5E2v6rbM7VrNj/wX3k=;
        b=CyLVtpvxzWPKyKXe5al/vII+vaQv0q/a9u7dwcJeu1e6qzqb35EPe4/R9Bc4ndFtvs
         2hndebO91Mjbj5a2hm6WEZRludI20YelCvlatji0QzvbQwgdMeBGXHOXJJhuZPaI7dgS
         O6o760s+yc19EWtZJ02U/jathg6YR6uFByV9s5qzZyeQr+WFWpitjjQLre2V3bOvDW++
         zXJnuDeGyo9L+FPYqGytQ6tbU1D2nrx5j2f38vCdl9aAvJ+50thCicyVT3abIMmbiH84
         sSMKp9xDB6WjywAMzewt36vjSXM1S2XsBPkJg0j/x4SDsawal8jSnDJfvCSdN0Cmed0R
         QsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790949; x=1763395749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s031glNNGPLU3pRhUQF/ls9Tz5E2v6rbM7VrNj/wX3k=;
        b=irBjubRgDkB3dX5k/gStXrJG24GbgIlFA3BIYFLAhUC+fmZK2JFfCuWKJytUE3LDjv
         rlrl/oMGE0haWa1EMDjKX1bvLi/W+NMRpUjN4xoguQ/fXDrvI+OGH2zmQwGbdcv9WQAJ
         5dPNS1BwM3L+16hyrk5SXs0wcvTrNLKEEshsz3VNkbZqxCNJz+SVEmwVXw2Hr4y7tGTM
         oVPIw19odkD3zetVJ0tQsvUx7zkAQn3/zrQt9QrLe87Qlu8G13hp4pB+9Sac3oo3Y3V8
         KQCqB6lO3nWYgL4ACRytcUu46x+sgzqX2wBQlLCxDnSRaz9rrTYctmx1hJEJQDk/McC7
         jtew==
X-Forwarded-Encrypted: i=1; AJvYcCWRLzsQFHUc4M3GF7J5uYk7gQ04w35mvOFkI8y2deKFqQPR/CFIktdg57ciJqK7tpBDGjfcOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEk2w/bG8eUSxqFM0G/HhoGHxKcIkbDGe6kdgHskUN02hkiTOA
	ORCY33JJ+QkcF/6M8/9jAh4oKsAYCIuEVPWXvcoYlQRPugH434I2J59/LKGfEg3u9kONivHNj6Z
	NZ48qu59FKMBdDkrbxkYmK7gFzns+Nvw=
X-Gm-Gg: ASbGncuTTLRi8AeTJHXELcLK9SAu/5D5GnnFqeIcNtFL+c4MDytUlnzX3b2nfOYv2xb
	yxJtpa3VcmtYrKgWOvDtObMWR4Z4jjuSIQgQ92O1quSnqmnQxzQ9+ebIN0k+VM5ByIQeCqJouRF
	wsFZlXOEVpiD1Snjcv7M6JMyvdSCEfCMxruh6G0+JpSRyqyFXin2/+rDxr3KbrWHcidhkg2J7qO
	iZwHggTcj1k9VK1NRyf9HhjGXogJyhCl19+TNkHBvFomdxkYVK/XtpWZ9ITfxVN1tcIPGo=
X-Google-Smtp-Source: AGHT+IHOYPI89bvNijFudu8ipuYpe33+VB7nbqJZeXEdLg498kOVR3mmjHBZOcylAlfsBqli+DO2uzjCmhEfT9se4Vs=
X-Received: by 2002:a17:902:fc4f:b0:298:2237:a2eb with SMTP id
 d9443c01a7336-2982237a409mr51261425ad.16.1762790948766; Mon, 10 Nov 2025
 08:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251106005333.956321-1-neilb@ownmail.net> <20251106005333.956321-12-neilb@ownmail.net>
In-Reply-To: <20251106005333.956321-12-neilb@ownmail.net>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Nov 2025 11:08:57 -0500
X-Gm-Features: AWmQ_bnsQdAKOPc2sWsQJTL6A89EPTloA4MsBf1tbsCjlSWDuuet8e3lOwk-mCw
Message-ID: <CAEjxPJ528Ou4dvRwHo+kXjWreGicda8BOXkQRvq3vMED6JQKOQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] Add start_renaming_two_dentries()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:56=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> A few callers want to lock for a rename and already have both dentries.
> Also debugfs does want to perform a lookup but doesn't want permission
> checking, so start_renaming_dentry() cannot be used.
>
> This patch introduces start_renaming_two_dentries() which is given both
> dentries.  debugfs performs one lookup itself.  As it will only continue
> with a negative dentry and as those cannot be renamed or unlinked, it is
> safe to do the lookup before getting the rename locks.
>
> overlayfs uses start_renaming_two_dentries() in three places and  selinux
> uses it twice in sel_make_policy_nodes().
>
> In sel_make_policy_nodes() we now lock for rename twice instead of just
> once so the combined operation is no longer atomic w.r.t the parent
> directory locks.  As selinux_state.policy_mutex is held across the whole
> operation this does open up any interesting races.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
>
> ---
> changes since v3:
>  added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
> ---

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 232e087bce3e..a224ef9bb831 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_=
info *fsi,
>         if (ret)
>                 goto out;
>
> -       lock_rename(tmp_parent, fsi->sb->s_root);
> +       rd.old_parent =3D tmp_parent;
> +       rd.new_parent =3D fsi->sb->s_root;
>
>         /* booleans */
> -       d_exchange(tmp_bool_dir, fsi->bool_dir);
> +       ret =3D start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_=
dir);
> +       if (!ret) {
> +               d_exchange(tmp_bool_dir, fsi->bool_dir);

I would recommend an immediate goto out if ret !=3D 0; we don't want to
silently fall through and possibly reset ret on the next
start_renaming_two_dentries() call, thereby ultimately returning 0 to
the caller and acting as if nothing bad happened.

>
> -       swap(fsi->bool_num, bool_num);
> -       swap(fsi->bool_pending_names, bool_names);
> -       swap(fsi->bool_pending_values, bool_values);
> +               swap(fsi->bool_num, bool_num);
> +               swap(fsi->bool_pending_names, bool_names);
> +               swap(fsi->bool_pending_values, bool_values);
>
> -       fsi->bool_dir =3D tmp_bool_dir;
> +               fsi->bool_dir =3D tmp_bool_dir;
> +               end_renaming(&rd);
> +       }
>
>         /* classes */
> -       d_exchange(tmp_class_dir, fsi->class_dir);
> -       fsi->class_dir =3D tmp_class_dir;
> +       ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->clas=
s_dir);
> +       if (ret =3D=3D 0) {
> +               d_exchange(tmp_class_dir, fsi->class_dir);
> +               fsi->class_dir =3D tmp_class_dir;
>
> -       unlock_rename(tmp_parent, fsi->sb->s_root);
> +               end_renaming(&rd);
> +       }
>
>  out:
>         sel_remove_old_bool_data(bool_num, bool_names, bool_values);
> --
> 2.50.0.107.gf914562f5916.dirty
>

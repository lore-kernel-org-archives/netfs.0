Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAA3D3484
	for <netfs@lists.linux.dev>; Thu,  5 Feb 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294398; cv=pass; b=FzUBGnDwjx/NdTL1y/9800bGUweKzSrOYTQjp/A4YOflzECPyAgcH/w3wIxoueqoEIcTMqwQwUqkOGUE/yMoVjOeI5yuDOdLV82pukagztLPcEGD1H0MtMViCK2BXLmwCnJXM/kczcte23qnas/SH/rldrcE2PLS7C6wrml07E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294398; c=relaxed/simple;
	bh=C5vOLxPnRhY6qi4kHmtoIzIplBE7B/w6zl9ie5PvVMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQkQPE9Gwl7T5yBxjGp1xW7t7moC8+5Nz/LcoUXyitXrjz/k2Zd0RHBQnE9lTZ+R0FavZ4mqlTGQ3oXbv1iOA/abZXeOI1I4U9TqBvelIWmDzKmKAvgJDKo3IhFypTCDTmLnqngq0oAHxVW2MTR6ahMWLp9utK2ctCSFCGtnqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTZuH6TI; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTZuH6TI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so1398373a12.1
        for <netfs@lists.linux.dev>; Thu, 05 Feb 2026 04:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770294396; cv=none;
        d=google.com; s=arc-20240605;
        b=Gng4Sx0l/N8djP7hqHP78B3dCXxlfJT977WHXM6ON4MehhHn7Ca50VHSKJKCadVOE9
         DoL970PA1iV3sVokPnhKH0Vet5Hzv9Joj0D0ieplALj2VdWB2w8VHR7G/snkbZ8UuKNt
         A+NhaC0SbxDmSok8UdtIXpVrqpWaqeyi4di5dlKv1SfAkiwTKUhzncAkHQw86IuKM73Q
         q5jRUAckn9qSRbL9fzGMwbl1KHLb2ISxuDa3WU4PhRKsVFSi6Qgfl3LxTUDom0vm1wG6
         VcJTeVq0qSITOORAY6x+lLAuILmv4a7HZbFpBfwB/4jGMGkRNaM2hpRIh845LOURUCdb
         DmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        fh=AJltnx8L6DTJqOZCBLtCz5CytGmuoXWtw23JdyqN/6w=;
        b=KOKT8Ykk2I+dYIxNPzERD1i3HeiVjbrQDIcWXCQg4TPeFqR/JRh5zhBERnYBXlu4NN
         LLK/89ZC96iiTYtRBj8+GVRkovElcgYr2zZKWKKvtb6OdSTfgpmeIOtJ4MQO46eeSVya
         toKckPDhvze9JfBo8fZGsDngLVghmoHz1XHCY8m8ZJwAEgx6kVqb2sFWzleDBYAyFGvF
         Ki1cUNBoT0juw2fGNjbhdW1JucLbMxACyO3zrmLG9xEZKYRR6yrN5+1jtH7hEs9h9/Nw
         ilJ6an8fPDrVTyDo4vtiZEAR7QgBFQQ+Im0J74nKjLFl4PO/aRwtPam/P5V1ghWgtzBH
         IYIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770294396; x=1770899196; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=RTZuH6TI/47ECCmNFYvWlEDz87Bhta1YTbkJw9yZCee91OjwT0UKQA+T0t7L6qhc1d
         dGqUwnnjXLnYrSCN0jAzRc6SWmL2uR2rKMD9jme6haRSDVEQYzaE3OOlWc7yOc5hADre
         QtkJaQAsEKJMsyzE+mpEVMxOa0QyoaQR60uM3O/hLSg7R9JaOtfylFXYTc2aQk2mDHac
         0JbtjtxYMIAUE6rS67ou/cHMNPigD1OD/4Xf8kHXFLdd3kV2CBCjJ4JNaiu4ZvGCwic9
         fkBpQRzCDucwyMzDJa1vEes2Ek1yrwMFw7y5XqinFS2yQNmzirTpE+yo7rd/jVIuSy0v
         VeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294396; x=1770899196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=agUS4Hh0pKKxp3PLA9gdyPo/bhDCHT4oMtsrgWH5UtiNrdfE9H4OyJzMFUb3gcCgGN
         I0aAwWrVjfkU66DiUkmQs64Ck+aYrpIF7mHmrAV7Y7AevCrCKhdk1OwNHZIVSZcSkb2F
         RsuYZtfpsp7JCznMcy6at3lw7s5e1lX2WVwOZ1bf/S0ClbumPeNMIjZjiOqxcOTa4PNL
         DM8yteSdkRUVZ0GMJwjzXsb1a3QEqSSD1N/9RNaSfOji1tr5//LcN8urPWH+myqh/Fwx
         VXr/F8wDMmR6crkO2Gfv7wd3wrZD/JufxAXJGZ1eyd0lLr6O7Azdy/FkrZtfcbjBDaEF
         LoSA==
X-Forwarded-Encrypted: i=1; AJvYcCVWPOI7lSdHCVv+YZYuAwe6epF5LsSpO9FSxgBziTjpqTIRfhQLuuQhx8rL7LiFV66R3RsvLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRHiUsS0CfeSt5QCwJRPuAppABAQz5u05ZE+DMq233fKtxzEmQ
	A48b8pkJiXGs3lUyyz90LbmA+/WgN2EVsfCf+xFa8SNZPF6a6xPj/JHgep/HAslOZF98NS045FY
	iAtH4zwgR1oBX1xiPHvuYJHZIG5YJTvo=
X-Gm-Gg: AZuq6aITphH2bbRuL4bbntur5peR7GHs1TX18dog9DwMSasiPksy5UDqYwgl+sppE6H
	4rrK/jc1vary0CtUaqqNZS2DCvgbvqqSZ5bGO0YvPwFgJH/1lBCYvXCqiKRozBI2wSyb6VB/21J
	eL7N+2dUH2oWRHf4NOeIv8atnsClWqTPe+HCm4Owl1k1DoEk0DpYERnzQRc3J4Bjj5p2ZXtqVSe
	3jo1d1mqF0zl8e5+ABqQ/2Mi9w4F8i+M2Wdg1AYW+RUH2qoRfULAlK30hQQAsqGIIc76vLuPA4d
	0TlFIRy2saXwBTekIMVYopoyeDZ8FA==
X-Received: by 2002:a05:6402:2711:b0:658:da9:787d with SMTP id
 4fb4d7f45d1cf-65949dc2762mr3243637a12.21.1770294396096; Thu, 05 Feb 2026
 04:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-11-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-11-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 13:26:24 +0100
X-Gm-Features: AZwV_QhSomAYq3e-9LVlkwiUvLVwnQqEgYbdyasP4aBJdb_z_a8NyX57euMmGhk
Message-ID: <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com>
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

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> When ovl_create_real() is used to create a file on the upper filesystem
> it needs to return the resulting dentry - positive and hashed.
> It is usually the case the that dentry passed to the create function
> (e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
> filesystem may unhash that dentry forcing a repeat lookup next time the
> name is wanted.
>
> So ovl_create_real() must be (and is) aware of this and prepared to
> perform that lookup to get a hash positive dentry.
>
> This is currently done under that same directory lock that provided
> exclusion for the create.  Proposed changes to locking will make this
> not possible - as the name, rather than the directory, will be locked.
> The new APIs provided for lookup and locking do not and cannot support
> this pattern.
>
> The lock isn't needed.  ovl_create_real() can drop the lock and then get
> a new lock for the lookup - then check that the lookup returned the
> correct inode.  In a well-behaved configuration where the upper
> filesystem is not being modified by a third party, this will always work
> reliably, and if there are separate modification it will fail cleanly.
>
> So change ovl_create_real() to drop the lock and call
> ovl_start_creating_upper() to find the correct dentry.  Note that
> start_creating doesn't fail if the name already exists.
>
> This removes the only remaining use of ovl_lookup_upper, so it is
> removed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
>  fs/overlayfs/overlayfs.h |  7 -------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..ec08904d084d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
>                 err =3D -EIO;
>         } else if (d_unhashed(newdentry)) {
>                 struct dentry *d;
> +               struct name_snapshot name;
>                 /*
>                  * Some filesystems (i.e. casefolded) may return an unhas=
hed
> -                * negative dentry from the ovl_lookup_upper() call befor=
e
> +                * negative dentry from the ovl_start_creating_upper() ca=
ll before
>                  * ovl_create_real().


According to the new locking rules, if the hashed dentry itself is
the synchronization object, is it going to be allowed to
filesystem to unhash the dentry while the dentry still in the
"creating" scope? It is hard for me to wrap my head around this.

Or do we need this here because some filesystems (casefold in
particular) are not going to support parallel creations?

>                  * In that case, lookup again after making the newdentry
>                  * positive, so ovl_create_upper() always returns a hashe=
d
>                  * positive dentry.
> +                * As we have to drop the lock before the lookup a race
> +                * could result in a lookup failure.  In that case we ret=
urn
> +                * an error.
>                  */
> -               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, paren=
t,
> -                                    newdentry->d_name.len);
> -               dput(newdentry);
> -               if (IS_ERR_OR_NULL(d))
> +               take_dentry_name_snapshot(&name, newdentry);
> +               end_creating_keep(newdentry);
> +               d =3D ovl_start_creating_upper(ofs, parent, &name.name);
> +               release_dentry_name_snapshot(&name);

OK. not saying no to this (yet) but I have to admit that it is pretty
ugly that the callers of ovl_create_real() want to create a specific
stable name, which is could be passed in as const char *name
and yet we end up doing this weird dance here just to keep the name
from newdentry.

Thanks,
Amir.

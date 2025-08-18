Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CD31B120
	for <netfs@lists.linux.dev>; Mon, 18 Aug 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520776; cv=none; b=Re+QiItNC86Z13evtyVOWFytXQIeCGnq3DW9CpP8Pkcac66T8uVer2Zfv26sS4CJ+MB0E8C7tSoJ/vWJJeMcDS+7DmCZ+cPUo7AAnCzifqKlOnR70YEu0pm0MidZ2S+FN2NTK2eZS+w4aNmy+PhTRHqXWdxG6/gWM/GTlBEaLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520776; c=relaxed/simple;
	bh=iRiQFMBV+DKdPhtateZaMw71WRCGXS+1o0qcYMlsaNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BA/AuoVy7T1bDJcoXnCcE0sq46g/D68UrXpWiFGoFLeLKPR1hz4YxV5egp7PtAvV/pJrMGSrCuH1WnkzCg0fGnlvTTdGnL3Yt5kl/SGyyK0izEQvAe3BtwXrrdAkL4pZvpMSfkTIGeaF3se3zmzpNJQT7Xwd8cQ/BYd3CxgLodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY+CfWDp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY+CfWDp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so5713375a12.0
        for <netfs@lists.linux.dev>; Mon, 18 Aug 2025 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520773; x=1756125573; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubbjo8h4cvXI+kpbxgHKGsgNRSO5oS6kJQNOdicLg+U=;
        b=nY+CfWDpLILdGT/w0qWgmj6VJ2PqGmuP2ij4FMuRQTkUIW3bj297hqBjW7luJvA0od
         K7+mioblLS32zJA4ya6yds8QJ2Btr042Ovu1nSrqY1rIpJiTLj6vvzl26Ch26Ec0Rdgl
         KWMDRRLRsisp4JZQtN60OzalaOIwlDJ452Thc2N63J2DwUTgN1mwQxEE52N5+dOFQtTe
         4eGqKqnglG9n06Nw7RPGxlMAb6UIw5YRvveGj+9paMKjI40vwetMi7TUbIanmQlam8JK
         8L3mmMDQGlH6KRkrc+fQJNAgACyNXl6YZQRK05jtighxjwYktWVqd8R7R0E6tpow3Wim
         i/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520773; x=1756125573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubbjo8h4cvXI+kpbxgHKGsgNRSO5oS6kJQNOdicLg+U=;
        b=IKjRVdeTJPYPecaS9aX6RkGFee07yoAEf/dlQUrSyMJAk/wZqd/dwZNarMPSIqr0rw
         kD2qZB2i0FfS+FYcFeocp37zjWw4OTpUZX7yiCCGnl2lYqwMsU6xmxsgD9HZFb1ipv3t
         j1kGDvwne8Ddi01sSWGVIhxX7F1VfOZuGhgYX0qEsgbwy+XHSssxcofp953ZpCIos3Rz
         mO5CJ2hPwsxDcND7qGVauaA58Ka/092gFT3Vu1/jWlRZ+cghqRXl066q2B+/n2XNHNhI
         gxJGbELwy2WVZ9fdpAsV7nme6GoeuFw1lDk5asgwRg2I0Hlh4TVobee0JeLaztmiawb2
         tOiw==
X-Forwarded-Encrypted: i=1; AJvYcCVQZ6GmDh5mKE3mzX1lMvy2Bif0ZA2+QiEpLYynzdfrWF3fHU3QjfR9ZLTO2i2/NCo5BuXt/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwm37eb1G9G63MIvcCtnPj/0o5PJPb4mxS9uCYtGriiWxYXefE
	+UgY56Tl3AgcNUzKbY/HZ+NtT/c3sNLyg96sgvsXcZ9PlO880PaivtHDCRzaIJtTr/jbVN2yBQd
	Lxd7oPRomLs4ZLK9fARrENlymPVZ8EvE=
X-Gm-Gg: ASbGncs8du1kguO15UmP1oCLb0u/as8GVtSv9IW78Dq1gAhsh2Ljsm9YOo+ULWBPCb4
	vWfgg9j+puYyIjxyhUQS3h7AIpegv62BxOd5TUaos2FGQ879O8ZsTSkTwroy0fh+ol+ZAbITHsb
	k79KXE4h5ZvUUCr0bBwXHi5q6Oy3mBOT128eeqZoYu1/9UoZDFQc9qZAg2XkdZfC2fOUXDQ/bst
	V4p4NQ=
X-Google-Smtp-Source: AGHT+IHreI+It7iS6Rfr+brWbz70Us6HtoYs+C56L+JOM9s0ucMSXKqtnWOloo9akQbTFfs/x14TcE577HD2A1hPXyo=
X-Received: by 2002:a05:6402:278f:b0:612:d3cf:d1e4 with SMTP id
 4fb4d7f45d1cf-619b707c2a0mr6715378a12.8.1755520772728; Mon, 18 Aug 2025
 05:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812235228.3072318-1-neil@brown.name> <20250812235228.3072318-5-neil@brown.name>
In-Reply-To: <20250812235228.3072318-5-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 18 Aug 2025 14:39:21 +0200
X-Gm-Features: Ac12FXwaOAmOjlUtH5bpB7wOuhOZPTQBUdVvt2kp3aUZBDH4-UANLHNzz7IOKqs
Message-ID: <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
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
> A few callers operate on a dentry which they already have - unlike the
> normal case where a lookup proceeds an operation.
>
> For these callers dentry_lookup_continue() is provided where other
> callers would use dentry_lookup().  The call will fail if, after the
> lock was gained, the child is no longer a child of the given parent.
>
> There are a couple of callers that want to lock a dentry in whatever
> its current parent is.  For these a NULL parent can be passed, in which
> case ->d_parent is used.  In this case the call cannot fail.
>
> The idea behind the name is that the actual lookup occurred some time
> ago, and now we are continuing with an operation on the dentry.
>
> When the operation completes done_dentry_lookup() must be called.  An
> extra reference is taken when the dentry_lookup_continue() call succeeds
> and will be dropped by done_dentry_lookup().
>
> This will be used in smb/server, ecryptfs, and overlayfs, each of which
> have their own lock_parent() or parent_lock() or similar; and a few
> other places which lock the parent but don't check if the parent is
> still correct (often because rename isn't supported so parent cannot be
> incorrect).
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  2 ++
>  2 files changed, 41 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 7af9b464886a..df21b6fa5a0e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct mnt_i=
dmap *idmap,
>  }
>  EXPORT_SYMBOL(dentry_lookup_killable);
>
> +/**
> + * dentry_lookup_continue: lock a dentry if it is still in the given par=
ent, prior to dir ops
> + * @child: the dentry to lock
> + * @parent: the dentry of the assumed parent
> + *
> + * The child is locked - currently by taking i_rwsem on the parent - to
> + * prepare for create/remove operations.  If the given parent is not
> + * %NULL and is no longer the parent of the dentry after the lock is
> + * gained, the lock is released and the call fails (returns
> + * ERR_PTR(-EINVAL).
> + *
> + * On success a reference to the child is taken and returned.  The lock
> + * and reference must both be dropped by done_dentry_lookup() after the
> + * operation completes.
> + */
> +struct dentry *dentry_lookup_continue(struct dentry *child,
> +                                     struct dentry *parent)
> +{
> +       struct dentry *p =3D parent;
> +
> +again:
> +       if (!parent)
> +               p =3D dget_parent(child);
> +       inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
> +       if (child->d_parent !=3D p) {

|| d_unhashed(child))

;)

and what about silly renames? are those also d_unhashed()?

Thanks,
Amir.

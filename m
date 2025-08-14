Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85853002D8
	for <netfs@lists.linux.dev>; Thu, 14 Aug 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179288; cv=none; b=U6maATFX8NDFRMtQ8p0dGN/S9iOtr4akDv356PI9yRQfiuLHis/5BXwyjY8AcDHKD8ZwFPERnqPvBRQBEgVsAciMi/caEy3iylzEOesNZXKTDWvUP8mdxrXB5RetinBO3ARaFARAjWw9IJjQNeC9nMyC77lWP4eoWngae5N5UL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179288; c=relaxed/simple;
	bh=3nDch1TwnwnOFxnyGs00pASm7HAHD3urGrnQFPRpJis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foRv5srM8RAyKFkzSdr3ojiBSkeY+4QkbPCDeaWXmg/Rq0pSfYcuePSPirBIvT4UavQd/xBdYv21+GmID3JDXXHHOXMI5K7UeRrZSKAeLeqyRmP+jM7OctsVVuFSN0nk0zEUFKictCZElcuhMF4iMZVWQUCCKaXwnZzthoXzhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqFhACCX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqFhACCX"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b656f21so1113364a12.1
        for <netfs@lists.linux.dev>; Thu, 14 Aug 2025 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755179285; x=1755784085; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kknE7rDUjEpODcHDSlY2nJGg21LqzdjsCFp42JS4Ico=;
        b=UqFhACCXbbeipBAkNSEdGOxqBb8mzFfmwUujYzcRMBoo19z/CCgxgB+Iui5Qep+ucl
         WF5P2uupR4eZC35rSGx0f/aTkr/7QtulEBUOydwohIBHIChGTHnExOSEVKu7v6JuvAgq
         y+osH2dxCt10OWh1tZjVfz32iN3XGb9Dx/iB8ZZWpiCSWm2TWX30p5hHEDJVlV6XYjKh
         UT5JpUpMciFbyf++4b1DULwmbAYscPxoGrBNE4NkEfbRl3DoMcccmNgc2wz/wrpG+28T
         fe0tX4wCot0Isd7FAQDaRQZ19eAOqecSGg/55ExA1h2a88n6P3xi9NOCE+iTDKdwq+1O
         cx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179285; x=1755784085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kknE7rDUjEpODcHDSlY2nJGg21LqzdjsCFp42JS4Ico=;
        b=Ptfa2/rHg4ctqqXdp5Zl/3I6v2wo3y1tRHBJsk05mtaO6CS4xkf/piUmR31i9ULQNM
         zRlVGnZtVoA4ydtDcEZ6EgNoNlG4b7ZTE8hlzSBVlrEjYtKxFQ5/GqQb0qjwVXLPovlf
         xJ9ZA/5oIKiymPxVoTZ0JaUBUFT44pJHvgHMG4HUzSRfMa36sltFrhzSG4hMxG0GuOo/
         se42tK7DjGa36sHl/3t/nMRkRBhZd3FlxI6pqFqXV5Lgtwh877ZWzOhqUvihsCaScVNj
         mR0taeYUUr024DdI3aoetdJWgu0ORNewbLyVyEzE6dgpVg/ki614CKWqOnXYQcx4YLPQ
         4v5g==
X-Forwarded-Encrypted: i=1; AJvYcCWsRh2+Z4SJUF7faCYNnbOSy8G0m5XtMc6xs+e8uZG7vEXp/qI3irbMXgoY3l28WaG+FR9SwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIIuf9/izBDU/RzBOsK6JNV/hMldLHZvZ0nr6IoR9nlrlsz3yZ
	2Vd2vLR+ecW4wu97cTZ6n4jpeEzl5/55Bt5Hffs0pduJpiLLAJ/kWNBpmGiG7JwmfdzfiUxMi+v
	xNtl3M8fZuFRtuf2wmRue6eFFRfaWT30=
X-Gm-Gg: ASbGnct9R/hFoobiO24mkM7RK2JDZpUUNh/qOezor0kASitdFPqMELNCcpoP40zS7rC
	qBMUrIzjPk9/xUN/05foPSCHO3PHpTfKAQeaxqk2rlTXXUIQvk+6EYsaifqJtCevXiDI1G1FBYV
	4TNemfjM70JVgn2C6hkO02ETLBIx7riFNbpaiRoO2+h6Nam00EiV1VQtySmb+gDITX9//lEoWsu
	YR/Z+0=
X-Google-Smtp-Source: AGHT+IEyNlWqeAhk/LpScYt9w4g0zV4KI7o0RDFgyEsYgfPOIWzZIEz6LWnNRfl0s84eTTaO2QcDUYXHT6IzkeoX6zs=
X-Received: by 2002:a05:6402:348e:b0:617:b2ab:fba2 with SMTP id
 4fb4d7f45d1cf-6188c1f81c9mr2881340a12.34.1755179284840; Thu, 14 Aug 2025
 06:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813065333.GG222315@ZenIV> <175513726277.2234665.5395852687971371437@noble.neil.brown.name>
In-Reply-To: <175513726277.2234665.5395852687971371437@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 15:47:53 +0200
X-Gm-Features: Ac12FXwtQAorrE4W3bWM28WxLsn_dOcgt6iMm2QuEDqDEmfUynv58IGzMVEJihs
Message-ID: <CAOQ4uxjOvsfV7o5Mnn_VBKYCR15FkmQBDASvwq0UQKPwxh1H2g@mail.gmail.com>
Subject: Re: [PATCH 11/11] VFS: introduce d_alloc_noblock() and d_alloc_locked()
To: NeilBrown <neil@brown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
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

On Thu, Aug 14, 2025 at 4:08=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 13 Aug 2025, Al Viro wrote:
> > On Tue, Aug 12, 2025 at 12:25:14PM +1000, NeilBrown wrote:
> > > Several filesystems use the results of readdir to prime the dcache.
> > > These filesystems use d_alloc_parallel() which can block if there is =
a
> > > concurrent lookup.  Blocking in that case is pointless as the lookup
> > > will add info to the dcache and there is no value in the readdir wait=
ing
> > > to see if it should add the info too.
> > >
> > > Also these calls to d_alloc_parallel() are made while the parent
> > > directory is locked.  A proposed change to locking will lock the pare=
nt
> > > later, after d_alloc_parallel().  This means it won't be safe to wait=
 in
> > > d_alloc_parallel() while holding the directory lock.
> > >
> > > So this patch introduces d_alloc_noblock() which doesn't block
> > > but instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime th=
e
> > > dcache now use that and ignore -EWOULDBLOCK errors as harmless.
> > >
> > > A few filesystems need more than -EWOULDBLOCK - they need to be able =
to
> > > create the missing dentry within the readdir.  procfs is a good examp=
le
> > > as the inode number is not known until the lookup completes, so readd=
ir
> > > must perform a full lookup.
> > >
> > > For these filesystems d_alloc_locked() is provided.  It will return a
> > > dentry which is already d_in_lookup() but will also lock it against
> > > concurrent lookup.  The filesystem's ->lookup function must co-operat=
e
> > > by calling lock_lookup() before proceeding with the lookup.  This way=
 we
> > > can ensure exclusion between a lookup performed in ->iterate_shared a=
nd
> > > a lookup performed in ->lookup.  Currently this exclusion is provided=
 by
> > > waiting in d_wait_lookup().  The proposed changed to dir locking will
> > > mean that calling d_wait_lookup() (in readdir) while already holding
> > > i_rwsem could deadlock.
> >
> > The last one is playing fast and loose with one assertion that is used
> > in quite a few places in correctness proofs - that the only thing other
> > threads do to in-lookup dentries is waiting on them (and that - only
> > in d_wait_lookup()).  I can't tell whether it will be a problem without
> > seeing what you do in the users of that thing, but that creates an
> > unpleasant areas to watch out for in the future ;-/
>
> Yeah, it's not my favourite part of the series.
>
> >
> > Which filesystems are those, aside of procfs?
> >
>
> afs in afs_lookup_atsys().  While looking up a name that ends "@sys" it
> need to look up the prefix with various alternate suffixes appended.
> So this isn't readdir related, but is a lookup-within-a-lookup.
>
> The use of d_add_ci() in xfs is the same basic pattern.
>
> overlayfs does something in ovl_lookup_real_one() that I don't
> understand yet but it seems to need a lookup while the directory is
> locked.

We decoded a connected real directory path (from file handle) and we
are trying to lookup in overlay a directory that is referencing the
underlying real dir that we decoded.

This is the context. Not sure what problem exactly this code gives you.

>
> ovl_cache_update is in the ovl iterate_shared code (which in fact holds
> an exclusive lock).  I think this is the same pattern as procfs in that
> an inode number needs to be allocated at lookup time, but there might be
> more too it.
>

It's kind of a hack I guess.
ovl has those rules (see xino) to compose a consistent inode number
from real inode number and layer number.
lookup of children during readdir composes the child stack to realize
the consistent xino.

We could do this internally in ovl by doing lookups on the real layers
and composing the xino, but calling lookup on ovl during readdir was
so much easier :/

Thanks,
Amir.

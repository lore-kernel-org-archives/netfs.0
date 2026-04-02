Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B6037A49D
	for <netfs@lists.linux.dev>; Thu,  2 Apr 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156111; cv=none; b=NQyzB9YtcOR7/UbrV5A0ScdkfjWvy0iDln8o+6FOAebzzvTYV2plX8fsUGNomyi/TtSzLyMhreTGIlGYLTao7lZJsjvnBs0eHXyMt+aIFqlqRQnLeLSjZXJwtn5oj3xTRxOhyvqTyzOtZOVC4DSW+REqwgGlPQyZC/YdykdUvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156111; c=relaxed/simple;
	bh=2qenenM/NFJvVOmXrLREjj9JCYxIcR1TnvsYacEgTq8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3b/eeWYIIZQWp8qYESXjylHsS/G8Z+DqYciDyk78TZL1jmaEpuy00tzeDF4cDrQQ6YxUtdkrc+gFF2sRF4E0Mlw81/W7nfNdpNN+yq6+YdBDpiF/GYNk8MojEU2VzJ7tS1TRqqJj3vwPaO/4iT3gIUxpC9l+HddiiuHV3l1GkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VE9yIOYC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE9yIOYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775156107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP5895ATXKzeNsspcDiQdZDMG4VClmmAZrztImhHyc8=;
	b=VE9yIOYCf3KS5+3AsFe+tkqVIEhdWY2pUMlzWFn8zafjnoqRw0h4f4Vy6zPvcl1yjGnBzd
	f1lPuYDvOASWoiGsITe2O1OaNKy69ZF00L+GYp1aH2RbnKk1Q2RCIZowrp/AwjnWBHTEph
	cfLngEXUGfETXgfRocBHMpLn4TziCQs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-gbiF7a8IPyG1beEfa-3Vpg-1; Thu, 02 Apr 2026 14:55:05 -0400
X-MC-Unique: gbiF7a8IPyG1beEfa-3Vpg-1
X-Mimecast-MFC-AGG-ID: gbiF7a8IPyG1beEfa-3Vpg_1775156104
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-46ecd914389so723383b6e.2
        for <netfs@lists.linux.dev>; Thu, 02 Apr 2026 11:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156104; x=1775760904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAqgUQ3fPhJxhiGUcpjyYMy4ZHB+Q3w4TN9iGgHF/Is=;
        b=IwmJ0Ki1sU5hLJLPB9x7hpm3824ohShENUn7ip7YJnN+jLS8c1QIjyjwZYXeSUI/Po
         im3sDEjLDubOjnISMKuQf1Uqdb/ocXE6phC/gATDP9uWJ6m/tGYD94rPpFHOGdzLFoLN
         3NFHhgdhdPmMav2pcKiUnUCdin4EtXu/swbmvgz+UjLHNxDQ2/H6nu+SiZ1URZTlb4xL
         lkza5WpG2E986qYYomLQUAL7pZulu1S0Y8/2aw7Rlhpmn/kDA2IhnNcXDFpNXzX6G6xk
         jkn5uQeBuwuiS4EmjBD03HHsWAccosNfFpygp0RfXnmqhl0hZgw9Xnpx+PxcwCEArmSZ
         UrEA==
X-Forwarded-Encrypted: i=1; AJvYcCU12uOFx9HSJN8iVaMmyITZGcYwQ4n4GkhjTw3rnHwEpIaIEAGPx33zy1ZJAlfgOB1uZ5W9tg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5T4jPHow97pXiZaAtOQihgJMI7+Ii6Z+SO/5FUzo10yBJqd63
	U5V+qamurcO0ja1vU5y27WH7XVRjZFYGpyuiLHKc+XcrWrG0L/ynfz5qg3F2AzvcoS1rjOlkYJN
	EJjxKD6o7c3sYezCoPfi9cc61PRT2yhRmkHnxtGTfQLyJ92h7EbgPBr5C
X-Gm-Gg: ATEYQzwfjG2qcSALtVBmuhvK/JhdtDFS8TvjX5rMuEGaOPudYg6q/BVF5wxQWMZlYWG
	Q6/i5uycy5ek433dSWIRv1+50hKBIs6ejDmnNOc3Gn4RuRQxFNQbCSr5dBvaPbZEd/VpXcsML/J
	YbTs464KoB0SmkAZN0ukYyDTs1XPE+3mnfcqK9PWEirZFlp8KbUVkVcbtEUAPohwT7gAEuJRDA5
	2sLuWNx2IYqpATdUexwpCgOZzIGY81qfZFdz3ZDRjnDHLlWhYDNs85gmP6H1xXjja5uvqozw2X/
	nfHo/av4PbIl0wHKFtZIM9X1bfbK6wncQ5auYEPsgsFpJkdKtlN+AtUHPZs2FGDtDXMupPh2Sd1
	fI+OywCWCSoL49mN1IQudgs69gJMBs0aW5agte4qDLFzHmjM/fN36
X-Received: by 2002:a05:6808:159b:b0:460:f435:2a71 with SMTP id 5614622812f47-46ef8218f3dmr283087b6e.46.1775156104464;
        Thu, 02 Apr 2026 11:55:04 -0700 (PDT)
X-Received: by 2002:a05:6808:159b:b0:460:f435:2a71 with SMTP id 5614622812f47-46ef8218f3dmr283065b6e.46.1775156103974;
        Thu, 02 Apr 2026 11:55:03 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72fd409sm2594664a34.16.2026.04.02.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:55:03 -0700 (PDT)
Message-ID: <74ebe2eb03ce3b1ae3038badffc8397d82d3eff2.camel@redhat.com>
Subject: Re: [PATCH] ceph: support RWF_DONTCACHE
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	pc@manguebit.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 11:55:02 -0700
In-Reply-To: <20260401053109.1861724-1-max.kellermann@ionos.com>
References: <20260401053109.1861724-1-max.kellermann@ionos.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KHn4ru9XpDn_etjy7FZmMP3WEmxbxXpFSPPeNYgH9B8_1775156104
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-04-01 at 07:31 +0200, Max Kellermann wrote:
> Similar to commit 902893e39076 ("NFS: Enable use of the RWF_DONTCACHE
> flag on the NFS client").
>=20
> The Ceph client now supports RWF_DONTCACHE for buffered file IO, but
> it needs preserve the IOCB_DONTCACHE state through
> netfs_write_begin().
>=20
> Unlike NFS, Ceph does not need to defer drop-behind until after a
> separate COMMIT step.  Ceph's buffered writeback completes when the
> OSD write completes, so the existing folio_end_writeback() handling is
> sufficient.
>=20
> This patch changes netfs because Ceph does not get its write_begin
> folio directly.  ceph_write_begin() is a wrapper around
> netfs_write_begin(), and that helper was calling
> __filemap_get_folio(FGP_WRITEBEGIN, ...) without access to the kiocb.
> As a result, the per-IO IOCB_DONTCACHE flag was lost before folio
> allocation.
>=20
> Fix this by passing the kiocb into netfs_write_begin() and switching
> it to write_begin_get_folio(iocb, ...), so IOCB_DONTCACHE is
> translated into FGP_DONTCACHE when appropriate.  Then set
> FOP_DONTCACHE on ceph_file_fops so the VFS will accept RWF_DONTCACHE
> for files on Ceph.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/addr.c           | 3 ++-
>  fs/ceph/file.c           | 1 +
>  fs/netfs/buffered_read.c | 6 +++---
>  include/linux/netfs.h    | 3 ++-
>  4 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 2090fc78529c..b4ea3ba8211e 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1865,7 +1865,8 @@ static int ceph_write_begin(const struct kiocb *ioc=
b,
>  =09struct ceph_inode_info *ci =3D ceph_inode(inode);
>  =09int r;
> =20
> -=09r =3D netfs_write_begin(&ci->netfs, file, inode->i_mapping, pos, len,=
 foliop, NULL);
> +=09r =3D netfs_write_begin(iocb, &ci->netfs, file, inode->i_mapping, pos=
,
> +=09=09=09      len, foliop, NULL);
>  =09if (r < 0)
>  =09=09return r;
> =20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5e7c73a29aa3..341589ef32cd 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -3191,4 +3191,5 @@ const struct file_operations ceph_file_fops =3D {
>  =09.compat_ioctl =3D compat_ptr_ioctl,
>  =09.fallocate=09=3D ceph_fallocate,
>  =09.copy_file_range =3D ceph_copy_file_range,
> +=09.fop_flags =3D FOP_DONTCACHE,
>  };
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index a8c0d86118c5..6ec7c2459d8a 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -589,6 +589,7 @@ static bool netfs_skip_folio_read(struct folio *folio=
, loff_t pos, size_t len,
> =20
>  /**
>   * netfs_write_begin - Helper to prepare for writing [DEPRECATED]

The netfs_write_begin() is deprecated function. Maybe, it's time to switch
CephFS on netfs_perform_write() finally?

Thanks,
Slava.

> + * @iocb: The kiocb describing the write request
>   * @ctx: The netfs context
>   * @file: The file to read from
>   * @mapping: The mapping to read from
> @@ -620,7 +621,7 @@ static bool netfs_skip_folio_read(struct folio *folio=
, loff_t pos, size_t len,
>   * Note that this should be considered deprecated and netfs_perform_writ=
e()
>   * used instead.
>   */
> -int netfs_write_begin(struct netfs_inode *ctx,
> +int netfs_write_begin(const struct kiocb *iocb, struct netfs_inode *ctx,
>  =09=09      struct file *file, struct address_space *mapping,
>  =09=09      loff_t pos, unsigned int len, struct folio **_folio,
>  =09=09      void **_fsdata)
> @@ -631,8 +632,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
>  =09int ret;
> =20
>  retry:
> -=09folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> -=09=09=09=09    mapping_gfp_mask(mapping));
> +=09folio =3D write_begin_get_folio(iocb, mapping, index, len);
>  =09if (IS_ERR(folio))
>  =09=09return PTR_ERR(folio);
> =20
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index ba17ac5bf356..d58c614e32fd 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -414,7 +414,8 @@ int netfs_writeback_single(struct address_space *mapp=
ing,
>  struct readahead_control;
>  void netfs_readahead(struct readahead_control *);
>  int netfs_read_folio(struct file *, struct folio *);
> -int netfs_write_begin(struct netfs_inode *, struct file *,
> +int netfs_write_begin(const struct kiocb *iocb,
> +=09=09      struct netfs_inode *ctx, struct file *file,
>  =09=09      struct address_space *, loff_t pos, unsigned int len,
>  =09=09      struct folio **, void **fsdata);
>  int netfs_writepages(struct address_space *mapping,


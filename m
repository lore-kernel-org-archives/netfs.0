Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8737B03B
	for <netfs@lists.linux.dev>; Thu,  2 Apr 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159066; cv=none; b=bf0A2ONcQzDj+Se+IblbKiiek6q4K/nNf9uGywS9nlx0YQVOMX6Jw2yAhcR05nec6zghJmFUyTPJb2gcBmvfHs+gQdtTzV1d7PJp0sndjD1baQcLxFlV5ftIxObdOX9bU9AFaMCnBaGQaarSa9oMWQuaC4FkmmwAgl0BOLHFpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159066; c=relaxed/simple;
	bh=diN4qhIaSDEkeO42elFWvtgi80xN4iG0WYdtAA5YNq0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDBw2tK6ub1Nn/1vUXDyZKrAuPHk4ABtOndSeAMMKv26JswS2Bu2jZg6ndGnq5ivUSRGX5kZyfn8U2Wz1F4D4UkQIL8ZFhZ/00wU8LauHEvOs9vUj+J5zhgpZ5dUZ49eeqKx+Ug11XgFX/lD1XZmX4SPgtTd3faWN1IL7Vpeuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVIsJy9g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVIsJy9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775159064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTmbwHXJhHSz2VmJlkzIaAHdG1HMjr0j4ITtQhOVOXk=;
	b=EVIsJy9gOHqT1CRPly/7GccpbBKNIu2E0PU76mxKxG4EOXqshMFl7dNfIDoDTQaCkkPLbs
	jKpRgcSaE450HPY+2jUvBFMpY95TSjO/rL6TrXCF8111BjKBlmkFufFSIBpGlBLCkqs1Zu
	DpE63XTC2iGGSR/fWBAW/bfqLZV2tQQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-0aYSElG8MbyORErNdHszzA-1; Thu, 02 Apr 2026 15:44:22 -0400
X-MC-Unique: 0aYSElG8MbyORErNdHszzA-1
X-Mimecast-MFC-AGG-ID: 0aYSElG8MbyORErNdHszzA_1775159061
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45a8cdc7e01so2503164b6e.1
        for <netfs@lists.linux.dev>; Thu, 02 Apr 2026 12:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159061; x=1775763861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfB9s0LuiQf6iXmJ//bXhecPlnuCrZC+QJFbTGU8i38=;
        b=ZqFktcVTSnqwtAwwYBDHU3aKRzE7/DAcQB5QxrTrwUoIW3oEwSSPKQerk0QVB8Vgdl
         QA1VQo1Gv6Db1ZtHVvSB8e8W7na7yHFshLhfcAZOIPFPt2172tgQWcRSvkYDXK6a29Fi
         OUxwEAr5nkDQ1cXPj1jKH7ADwreSn6amP9yF/E0LFCY34yCwcInFmj4eDxZldWVEGw4l
         RIA5r61Bu9poRdDIKa5T6qvl8ms2740JY7+6kgD3GU+C84D1ydKny2YsEnG9uCI85kve
         lL6J8l62+ANZbunyhDBMbNqMmyCs3X7RkYn2eZPHTqtiBSMU6XnUS6J1jLdQLxZkFD/h
         owsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6SRTAkR2tlFurow2ulR7roINJmKoCC4Xv44JKwnTGxPyeFMfAqxCA+xNSrQJEXisJ3ZbmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxomHpT/61lDFkgFrMMfeWr14hfAIqPF94TnrNxfhIetPa17WT
	ySYMb8aLIvxth7oCPGsGgUXT0rGPp/nnYXxTrXXIKWp+MD5R+IjhlXzO1gmib5LFZ+C8Sn6Gn1x
	bCTU9r+sQ/YJyZE9leJxbLSjkBtb1ECbtUREIDsyLdB39tthTSQDjo87q
X-Gm-Gg: ATEYQzzz+IjJCZDUWSz95cCpJkAcq/rBj5b9cMAL9SYi3q7rXmPA8dUpFYSgO4pxmDZ
	hPeJ6VatEHxuAETLeiLqYoXZ0qvARodXqwDL4n57unD1InIP6ry+wFJm5qLeJjZbi0OfcMMqqr5
	4qnzdcbBH9QQJBk3hh23dRCjircwFmec+TROiZ1r1ArBP1HyuM/ElTvgR3cjf2GiMV2s/RZwitN
	T29H7Bc1bmhreElmHBG0ED+NBI5YLW6WINkdKFs0DFb8Rtlbyc8v/VL9Tm0WxzSTZ/FZdxW/wdT
	mZjISoM8ax6D+hGytAXKYiPXif3A5xHqMZlE/HtnMg+nZpu+6tYVUbtpafI/Rwsf/fmGBpaAtaA
	d70nM95lNJuF7s275zJ/14aAZrKV8VjvqCUxSFesMhfase5bFcwYE
X-Received: by 2002:a05:6808:1310:b0:467:cda:f189 with SMTP id 5614622812f47-46ef790e783mr355637b6e.32.1775159061084;
        Thu, 02 Apr 2026 12:44:21 -0700 (PDT)
X-Received: by 2002:a05:6808:1310:b0:467:cda:f189 with SMTP id 5614622812f47-46ef790e783mr355609b6e.32.1775159060457;
        Thu, 02 Apr 2026 12:44:20 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d8f9603fdsm2199923b6e.2.2026.04.02.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:44:19 -0700 (PDT)
Message-ID: <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	pc@manguebit.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 12:44:18 -0700
In-Reply-To: <20260401205613.2095623-1-max.kellermann@ionos.com>
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zGrmrbm3G8zclZvhNPtR1RW4Var4qyRLh27j6Yjr-ec_1775159061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-04-01 at 22:56 +0200, Max Kellermann wrote:
> Avoid populating the local fscache with writeback from dropbehind
> folios.
>=20

The idea sounds reasonable enough. However, this patch cannot be standalone
because it depends on another one.

I assume that a filesystem must declare DONTCACHE feature support by settin=
g
FOP_DONTCACHE in its file_operations.fop_flags. Am I right here?

And what's about the IOCB_DONTCACHE. As far as I can see,
write_begin_get_folio() translates IOCB_DONTCACHE into FGP_DONTCACHE:

static inline struct folio *write_begin_get_folio(const struct kiocb *iocb,
=09=09  struct address_space *mapping, pgoff_t index, size_t len)
{
        fgf_t fgp_flags =3D FGP_WRITEBEGIN;

        fgp_flags |=3D fgf_set_order(len);

        if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
                fgp_flags |=3D FGP_DONTCACHE;

        return __filemap_get_folio(mapping, index, fgp_flags,
                                   mapping_gfp_mask(mapping));
}

The Ceph write_begin path calls netfs_write_begin() but does not pass
IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
folio_test_dropbehind() would never be true on the Ceph write path right no=
w.
Does it make sense?

> At the moment, buffered RWF_DONTCACHE writes still go through the
> usual Ceph writeback path, which mirrors the written data into
> fscache.  The data is dropped from the page cache, but we still spend
> local I/O and local cache space to retain a copy in fscache.
>=20
> The DONTCACHE documentation is only about the page cache and the
> intent is to avoid caching data that will not be needed again soon.
> I believe skipping fscache writes during Ceph writeback on such pages
> would follow the same spirit: commit the write to permanent storage,
> but otherwise get it out of the way quickly.
>=20
> Use folio_test_dropbehind() to treat such folios as non-cacheable for
> the purposes of Ceph's write-side fscache population.  This skips both
> ceph_set_page_fscache() and the corresponding write-to-cache operation
> for dropbehind folios.
>=20
> The writepages path can batch together folios with different cacheability=
,
> so track cacheable subranges separately and only submit fscache writes
> for contiguous non-dropbehind spans.
>=20
> This keeps normal buffered writeback unchanged, while making
> RWF_DONTCACHE a better match for its intended "don't retain this
> locally" behavior and avoiding unnecessary local cache traffic.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> Note: this is an additional feature on top of my Ceph-DONTCACHE patch,
> see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.kelle=
rmann@ionos.com/
> ---
>  fs/ceph/addr.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 2090fc78529c..9612a1d8ccb2 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -576,6 +576,21 @@ static inline void ceph_fscache_write_to_cache(struc=
t inode *inode, u64 off, u64
>  }
>  #endif /* CONFIG_CEPH_FSCACHE */
> =20
> +static inline bool ceph_folio_is_cacheable(const struct folio *folio, bo=
ol caching)
> +{
> +=09/* Dropbehind writeback should not populate the local fscache. */
> +=09return caching && !folio_test_dropbehind(folio);
> +}
> +
> +static inline void ceph_flush_fscache_write(struct inode *inode, u64 off=
, u64 *len)
> +{
> +=09if (!*len)
> +=09=09return;
> +
> +=09ceph_fscache_write_to_cache(inode, off, *len, true);

Are you sure that caching should be always true? All other calls checks tha=
t
ceph_is_cache_enabled():

bool caching =3D ceph_is_cache_enabled(inode);

> +=09*len =3D 0;
> +}


The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
CONFIG_CEPH_FSCACHE. It doesn't look right.

> +
>  struct ceph_writeback_ctl
>  {
>  =09loff_t i_size;
> @@ -730,7 +745,7 @@ static int write_folio_nounlock(struct folio *folio,
>  =09struct ceph_writeback_ctl ceph_wbc;
>  =09struct ceph_osd_client *osdc =3D &fsc->client->osdc;
>  =09struct ceph_osd_request *req;
> -=09bool caching =3D ceph_is_cache_enabled(inode);
> +=09bool caching =3D ceph_folio_is_cacheable(folio, ceph_is_cache_enabled=
(inode));
>  =09struct page *bounce_page =3D NULL;
> =20
>  =09doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
> @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *mappi=
ng,
>  =09bool caching =3D ceph_is_cache_enabled(inode);
>  =09u64 offset;
>  =09u64 len;
> +=09u64 cache_offset, cache_len;

Why do you need to introduce the cache_offset and cache_len? We already hav=
e
offset and len.

>  =09unsigned i;
> =20
>  new_request:
>  =09offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
>  =09len =3D ceph_wbc->wsize;
> +=09cache_offset =3D 0;

Is it correct initialization? Frankly speaking, I don't quite follow why we=
 need
such initialization.

Thanks,
Slava.

> +=09cache_len =3D 0;
> =20
>  =09req =3D ceph_osdc_new_request(&fsc->client->osdc,
>  =09=09=09=09    &ci->i_layout, vino,
> @@ -1477,9 +1495,11 @@ int ceph_submit_write(struct address_space *mappin=
g,
>  =09ceph_wbc->op_idx =3D 0;
>  =09for (i =3D 0; i < ceph_wbc->locked_pages; i++) {
>  =09=09u64 cur_offset;
> +=09=09bool cache_page;
> =20
>  =09=09page =3D ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
>  =09=09cur_offset =3D page_offset(page);
> +=09=09cache_page =3D ceph_folio_is_cacheable(page_folio(page), caching);
> =20
>  =09=09/*
>  =09=09 * Discontinuity in page range? Ceph can handle that by just passi=
ng
> @@ -1491,7 +1511,7 @@ int ceph_submit_write(struct address_space *mapping=
,
>  =09=09=09=09break;
> =20
>  =09=09=09/* Kick off an fscache write with what we have so far. */
> -=09=09=09ceph_fscache_write_to_cache(inode, offset, len, caching);
> +=09=09=09ceph_flush_fscache_write(inode, cache_offset, &cache_len);
> =20
>  =09=09=09/* Start a new extent */
>  =09=09=09osd_req_op_extent_dup_last(req, ceph_wbc->op_idx,
> @@ -1514,13 +1534,19 @@ int ceph_submit_write(struct address_space *mappi=
ng,
> =20
>  =09=09set_page_writeback(page);
> =20
> -=09=09if (caching)
> +=09=09if (cache_page) {
> +=09=09=09if (!cache_len)
> +=09=09=09=09cache_offset =3D cur_offset;
>  =09=09=09ceph_set_page_fscache(page);
> +=09=09=09cache_len +=3D thp_size(page);
> +=09=09} else {
> +=09=09=09ceph_flush_fscache_write(inode, cache_offset, &cache_len);
> +=09=09}
> =20
>  =09=09len +=3D thp_size(page);
>  =09}
> =20
> -=09ceph_fscache_write_to_cache(inode, offset, len, caching);
> +=09ceph_flush_fscache_write(inode, cache_offset, &cache_len);
> =20
>  =09if (ceph_wbc->size_stable) {
>  =09=09len =3D min(len, ceph_wbc->i_size - offset);


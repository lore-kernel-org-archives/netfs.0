Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AD3CD8B1
	for <netfs@lists.linux.dev>; Fri,  3 Apr 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236709; cv=none; b=B0U+ojChOmfc98jXuUfEWFoHzQI0Xl8h2bSawfitS1AHc6Zcl2sGHJpSZ2kW6AzbwQU4BInQjsRELlMCNogui7rFLOcGHpd38SAeTnbCS5lmme78JCnTrnxSBqXPTfr9lv9YjvBK+qG7S6oeX/TTS29RzmuvsGomAKCo9SXO0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236709; c=relaxed/simple;
	bh=Cvq5tuLj5ZY1DMhHPFEu+lE7/fw/C+ofjPzqyp3q+wU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLZEsE88Vc0bq7zKl4s3ArIG5cO4mrDGGAEfzMvdxqY2fzUE1i9WqjGWS+FWA6bcmQ8JwWpE7IbIm0nfXeuwJzwD/2kLDQDLWDPCGz+IJ1CaNOqvyLLDOe6Gc6sh0m+uUJ8FewSpfiv8gofoR+1FUH6GEgqzf7FV7iN7lyoIpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/onQm1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/onQm1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775236706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
	b=H/onQm1jDTDcnplgOhY3lkd25noaX/SNgzCJqizhcedgbm5JcrNUL9yO836rFzkUaIc7o7
	eI6rMLVerDRJ2RaiAvZRdM/cyAfn8MAl8zTbyLWexB3EcRvxG9UI5aQ9HzWWfDJyBqZMsq
	amCjMOY/u98oE3Rp0OtpoWmNBvyF8Pw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-pmeA9nZFMMqIZCbIJPUXcQ-1; Fri, 03 Apr 2026 13:18:25 -0400
X-MC-Unique: pmeA9nZFMMqIZCbIJPUXcQ-1
X-Mimecast-MFC-AGG-ID: pmeA9nZFMMqIZCbIJPUXcQ_1775236705
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463a1cee56aso3745892b6e.0
        for <netfs@lists.linux.dev>; Fri, 03 Apr 2026 10:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236705; x=1775841505;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
        b=CXHwpMNeKV8VJb0jtf3XLS42FTA67WSzekIzCeOYC4l4ohJEN2wstYq2Ojei2MNYSY
         uiXedVXRqMAqwzFNBsjpLS4haQq2/XRblm4vDlaXhQET20uF3q4iWVU64qBjGWnfJHb7
         BT0PEVEAFiD5F29mojtoUmgJbeaIsdwCjHrONqeoS3x/iAYy2I2z+ZzQQKTeyWOiCUFf
         ClcXT8+dYcfsTCegumuTGUTHvR4oiZpEER/ldCEElt7NrzXO6pe9Ct6YFbNVHcR4saaV
         yFUV8QPaTFqFVwXF3NKcPag0rB4LU64qAcimig8mMp2q2/yBKZn2Me9QN2BUoWd3QhfD
         eeQg==
X-Forwarded-Encrypted: i=1; AJvYcCW/7CdpOel8jbT0DUnPfjGC7ZA6mYzhcbUjlaXdFyu53Bop8D0UFblI92+fdm6hNl+GWKyfMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf7PX0KcEKQgQk8rU5KNDCADMcYfmrZX+wrXJdueNHZBKU3Qpq
	i/cbZUhKaRDCG5X0S3lyzWhz/jeTaIAzV9ZgZR9J30B8WNpJn4ItjkzSO2JlAcijzYffWWq6avr
	o66e8vGt8rRNB2CsU5PqUKdcUd3oZ4KSj2IIRRB87iEjdf4PL1BYk2V+c
X-Gm-Gg: ATEYQzw06OoGTpvnI1uUIWv+gw41VIy9hffzZVainhqu2gXkrb/8FEEiSnoR49IUMob
	99mEj6D1LR1LRkkC6GqfCTuR2ZMVdFeZGLtynXAahEhPJ2J4J4q7ENcIzdyF69293dXcj6HI3ye
	ePofVnneancwr40AfgPQXDH/r2NtsdnHHf68ycGfLmtaCVwu6BA0R76M6goTW6U0Kttdty8KsCM
	jkHvqrovARdXr7I9/cSqxrVvqey4LcWuti/Oc8QjIDmF3vEEJ4r7TznEtnpfFVPoyffBVjc2r1p
	7+xBKMRO9vtDewd8edoVrOmjrQ8yuo02uMK4hDeVi3uns37H61veQfJExQrAYllcrwIH/NEMFMZ
	tpTBEvnVptf9Q4TZQ7dQzZXNry/Q3AHVezmRsdez7x58m4rvSkyHg
X-Received: by 2002:a05:6808:6503:b0:467:46e7:e6dd with SMTP id 5614622812f47-46ef5fed372mr1930294b6e.16.1775236705043;
        Fri, 03 Apr 2026 10:18:25 -0700 (PDT)
X-Received: by 2002:a05:6808:6503:b0:467:46e7:e6dd with SMTP id 5614622812f47-46ef5fed372mr1930282b6e.16.1775236704582;
        Fri, 03 Apr 2026 10:18:24 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm1611319b6e.4.2026.04.03.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:18:23 -0700 (PDT)
Message-ID: <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 Apr 2026 10:18:21 -0700
In-Reply-To: <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
	 <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
	 <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4EHv68-_rn8cjjKs3ZVMvJWlPWbORoFT4UkptPWk_z0_1775236705
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-04-03 at 08:52 +0200, Max Kellermann wrote:
> On Thu, Apr 2, 2026 at 9:44=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
> > The Ceph write_begin path calls netfs_write_begin() but does not pass
> > IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
> > folio_test_dropbehind() would never be true on the Ceph write path righ=
t now.
> > Does it make sense?
>=20
> Yes, see:
>=20
> > > ---
> > > Note: this is an additional feature on top of my Ceph-DONTCACHE patch=
,
> > > see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.k=
ellermann@ionos.com/
>=20
> The code in this patch is not reachable until my RWF_DONTCACHE patch
> is merged as well.
>=20
> > Are you sure that caching should be always true? All other calls checks=
 that
> > ceph_is_cache_enabled():
> >=20
> > bool caching =3D ceph_is_cache_enabled(inode);
>=20
> This function is only called if caching is enabled.

I think that such interface will be more clean and safe:

static inline void ceph_flush_fscache_write(struct inode *inode, u64 off, u=
64
*len, bool caching)

>=20
> >=20
> > > +     *len =3D 0;
> > > +}
> >=20
> >=20
> > The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
> > CONFIG_CEPH_FSCACHE. It doesn't look right.
>=20
> All of the old code is out of CONFIG_CEPH_FSCACHE, too. Does the old
> code look right?

As far as I can see, all fscache code is under CONFIG_CEPH_FSCACHE compilat=
ion
option. If we have some issues with old code, then it makes sense to fix it=
. But
this code is fscache related and it should be under CONFIG_CEPH_FSCACHE
protection, from my point of view. Moreover, other fscache related code is =
under
CONFIG_CEPH_FSCACHE protection pretty above the code of these functions.

>=20
> > > @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *m=
apping,
> > >       bool caching =3D ceph_is_cache_enabled(inode);
> > >       u64 offset;
> > >       u64 len;
> > > +     u64 cache_offset, cache_len;
> >=20
> > Why do you need to introduce the cache_offset and cache_len? We already=
 have
> > offset and len.
>=20
> These keep track of the region that should be submitted to fscache.
> Folios without "dropbehind" need to be excluded from that.
>=20
> > >  new_request:
> > >       offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> > >       len =3D ceph_wbc->wsize;
> > > +     cache_offset =3D 0;
> >=20
> > Is it correct initialization? Frankly speaking, I don't quite follow wh=
y we need
> > such initialization.
>=20
> Technically, cache_offset does not need to be initialized as long as
> cache_len is zero because then its value is never used. Would you feel
> more comfortable if I remove the unnecessary initializer? I wasn't
> sure which approach would raise fewer eyebrows.

I am simply trying to follow why we need in cache_offset. We are using the
offset currently:

/* Kick off an fscache write with what we have so far. */
ceph_fscache_write_to_cache(inode, offset, len, caching);


Why the offset is not good enough?

Thanks,
Slava.


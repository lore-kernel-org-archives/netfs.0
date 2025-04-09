Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25125E836
	for <netfs@lists.linux.dev>; Wed,  9 Apr 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206895; cv=none; b=NLNOjAmc5qTSXc8H7GI57URO34RtbA7cKPbTLtDBOP5+hwW3j6cV2as6k6Mm2XaseRKiEtGmsOreDS1zMSFwUfBmTKpQ2xISynXAYU1evLYej/yJGy9slTLvD7i9sl7J0oSCR4r9mj9YQqgOlZSuF8AcDDlDLmHFguOUSLEYrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206895; c=relaxed/simple;
	bh=l62lfA+qsXO3Hty6YOKap+JHa82eWUyqYR7tITdVoW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdJXNemPPVXkDJTx5VKhyYaHdWwtGpNVlZH/Ul78sqMZoQyJU1cAsm/weaNPe0TNMOKhdNn1MBk+pO8hqY5Ycz5pOL7pc8SfjIXNhLOQGWd6f0USnjQ0SRhdsOeUiyH0qSJQpR2alkzUNZiUT0Y6qR7j3C1Myyy6IA8rLxmKdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYGm5yfq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYGm5yfq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so5595227b3a.3
        for <netfs@lists.linux.dev>; Wed, 09 Apr 2025 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744206893; x=1744811693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck5x1Os3XZK/0cyOU2zPrzfxe2MOfnv7kkKaywV0D1M=;
        b=HYGm5yfqnxKISS34+i/Btd4xmULeYrIjNvcuoKvvol8u2DoKw3z1CkdPo8szYdufVG
         jF4CSl4a6W6ngJ5VOB6ZvlXwsuFKnKsXljAdanpwFW554cIFFjEGux3mOvJQTnvoni6h
         2tITJZxjYjzDTwctC/0o8z83SSvLKFcdtdK+pDuDPvobRiH8Vc8GNlee+g38VO+bACX2
         I4dimf26WgX4Pe9B1e8d+PhZyddtPZRRh02u4N5JP3sR0Qd0CWdw8w3PC5ZpHHGK9cIV
         aYp1Ci42kbG81q2eee0SfX8cQ8t/RyEMZHAGM9Xmz1aBdtBnTAfE8eAp5mYrks0EZ5uY
         LEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206893; x=1744811693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck5x1Os3XZK/0cyOU2zPrzfxe2MOfnv7kkKaywV0D1M=;
        b=Zt3zDNPLeUkmDnqKaVGipXylAvD5Z+J3jPY0VfnA+RxFhvQPnwLJsu09wMBG49MzON
         N36lorOHCiE1ouCKRkXYhvb0bB47mvksY/iXypF1lpDZ+8queyjbFrugfb8NUIbAyFru
         3d9guWw76ToM+X3k0GEGBIGJKDDUodTk4rU6YGWwhDAH741fyiuxMjyBm8vUtocDqVy/
         dvOvlTuhSTMYOVC8n2YUclTaTkBj1iG66tkkz4+m8PIPcc7jCe9gDbNcF/K/FNMKk/qT
         pfymrce0XWDGSwcaORIswU3IUf5BtZWNismSHav7bfbGK9/Lj/1fLSuogBENG7V+qElq
         XVZw==
X-Forwarded-Encrypted: i=1; AJvYcCUKOK5zsTiHN2lem9clGbX2B4Coj9b9NWgvG9dNwEKb9MwQ6cM5aFLlpLiS0e9IOJoJr2wT6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLyCCN3jlBxwquFgUeJJCmdSrZ+JpyDxE5xcW1RpVLWTlzLG/0
	PlFlwxO8xjuxMlXTj+rG/AEh/s6N2LkuPrxl0h9j1opc0sGU4Dm4MejLoQ==
X-Gm-Gg: ASbGncsNlTHGNaL74q8ZhoWM0rLFf78keYrSnApopgwIZ4xusWOb58V/JNKvAp0Ibl3
	9XPX1Cm+ayi3dqiZ0whi0Ye2cphxf0HdmGHBE5CAomTdhdJVZLS7gFQc/6Y8RX6DQ0uGR+w6XzY
	B73F5kYr3YIJ6/l4bjjccFfKRZ/98Kzq4MsXjU9L0GY2G+yA7gJL2LCjCoYiC9Iv4Qo9vwkYqcQ
	PPCRAbn3jK0eb7AEKdvWfLIHqBNph79SkWtSlihh+r9kFvUDJ5Dl6/loZn3SVzk1C0STap8xrcL
	mzlN4QrQdmSbyKgwxIBEM5yfC1r9gIzCQaRlCtwq
X-Google-Smtp-Source: AGHT+IFEi7SqRiamwHVaIArODOzildac58F8STHvutYU/t9tuBTrTIgwu0rNZ9BjKuR7FVoLvQ6nVA==
X-Received: by 2002:a05:6a00:2186:b0:736:5dae:6b0d with SMTP id d2e1a72fcca58-73bae4c410bmr4085500b3a.10.1744206893312;
        Wed, 09 Apr 2025 06:54:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d469aesm1368048b3a.50.2025.04.09.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:54:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CBF324236D23; Wed, 09 Apr 2025 20:54:49 +0700 (WIB)
Date: Wed, 9 Apr 2025 20:54:49 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>, Timothy Day <timday@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>, netfs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Update main API document
Message-ID: <Z_Z8KVgaH-ksEKog@archie.me>
References: <Z_ZHoCgi2BY5lVjN@archie.me>
 <Z_XOr4Ak4S0EOdrw@archie.me>
 <1565252.1744124997@warthog.procyon.org.uk>
 <1657441.1744189529@warthog.procyon.org.uk>
 <1676060.1744205063@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mw29LLaiVHxc5DtG"
Content-Disposition: inline
In-Reply-To: <1676060.1744205063@warthog.procyon.org.uk>


--mw29LLaiVHxc5DtG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 02:24:23PM +0100, David Howells wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> > > > > +Further, if a read from the cache fails, the library will ask th=
e filesystem to
> > > > > +do the read instead, renegotiating and retiling the subrequests =
as necessary.
> > > > Read from the filesystem itself or direct read?
> > >=20
> > > I'm not sure what you mean.  Here, I'm talking about read subrequests=
 - i.e. a
> > > subrequest that corresponds to a BIO issued to the cache or a single =
RPC
> > > issued to the server.  Things like DIO and pagecache are at a higher =
level and
> > > not directly exposed to the filesystem.
> > >=20
> > > Maybe I should amend the text to read:
> > >=20
> > > 	Further, if one or more subrequests issued to read from the cache
> > > 	fail, the library will issue them to the filesystem instead,
> > > 	renegotiating and retiling the subrequests as necessary.
> >=20
> > That one sounds better to me.
>=20
> I think I like this better:
>=20
> 	Further, if one or more contiguous cache-read subrequests fail, the
> 	library will pass them to the filesystem to perform instead,
> 	renegotiating and retiling them as necessary to fit with the
> 	filesystem's parameters rather than those of the cache.

I prefer that above too as it is more explicit.

>=20
> > > > > +Netfslib will pin resources on an inode for future writeback (su=
ch as pinning
> > > > > +use of an fscache cookie) when an inode is dirtied.  However, th=
is needs
> > > > > +managing.  Firstly, a function is provided to unpin the writebac=
k in
> > > > inode management?
> > > > > +``->write_inode()``::
> > >=20
> > > Is "inode management" meant to be a suggested insertion or an alterna=
tive for
> > > the subsection title?
> >=20
> > I mean "However, this needs managing the inode (inode management)". Is =
it
> > correct to you?
>=20
> Um.  "However, this needs managing the inode (inode management)" isn't va=
lid
> English and "(inode management)" is superfluous with "managing the inode"=
 also
> in the sentence.
>=20
> How about:
>=20
> 	Netfslib will pin resources on an inode for future writeback (such as pi=
nning
> 	use of an fscache cookie) when an inode is dirtied.  However, this pinni=
ng
> 	needs careful management.  To manage the pinning, the following sequence
> 	occurs:
>=20
> 	 1) An inode state flag ``I_PINNING_NETFS_WB`` is set by netfslib when t=
he
> 	    pinning begins (when a folio is dirtied, for example) if the cache is
> 	    active to stop the cache structures from being discarded and the cac=
he
> 	    space from being culled.  This also prevents re-getting of cache res=
ources
> 	    if the flag is already set.
>=20
> 	 2) This flag then cleared inside the inode lock during inode writeback =
in the
> 	    VM - and the fact that it was set is transferred to ``->unpinned_net=
fs_wb``
> 	    in ``struct writeback_control``.
>=20
> 	 3) If ``->unpinned_netfs_wb`` is now set, the write_inode procedure is =
forced.
>=20
> 	 4) The filesystem's ``->write_inode()`` function is invoked to do the c=
leanup.
>=20
> 	 5) The filesystem invokes netfs to do its cleanup.
>=20
> 	To do the cleanup, netfslib provides a function to do the resource unpin=
ning::
>=20
> 		int netfs_unpin_writeback(struct inode *inode, struct writeback_control=
 *wbc);
>=20
> 	If the filesystem doesn't need to do anything else, this may be set as a=
 its
> 	``.write_inode`` method.
>=20
> 	Further, if an inode is deleted, the filesystem's write_inode method may=
 not
> 	get called, so::
>=20
> 		void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
>=20
> 	must be called from ``->evict_inode()`` *before* ``clear_inode()`` is ca=
lled.
>=20
>=20
> instead?

Oh, that's what you mean. I'm leaning toward that.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mw29LLaiVHxc5DtG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/Z8IgAKCRD2uYlJVVFO
o5HPAQDy1q+hkQLGUz2eIQuYUYZGJRqgXajUmKCcHO/UePy89AEA2vX0c8cV0sWf
wkzObFZq/dAFvmxB5foaGxCw0X9M8Q8=
=RmrE
-----END PGP SIGNATURE-----

--mw29LLaiVHxc5DtG--

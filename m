Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49E25D52E
	for <netfs@lists.linux.dev>; Wed,  9 Apr 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193447; cv=none; b=C4gvYaCvLho3Pz1VIY3FN39wONO8HXz8pUULDQmUNVluXaWWhfAKzNZQ2l6OFUOgm3+iiUD1sGn17ofIbKxhdhtGZOeMDd6FAzCHaRySVlch91I8LYn+NAybUFVl1xPQIUmFq05e7E83W4VLdb0f7+ors6aagsYK9i5ZllKHvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193447; c=relaxed/simple;
	bh=hNrJ/ccAQlLCeeRpKoQJKKWsRNyGqVchdeOfcX/ZiDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grt8WeKuKtULQIU1dgPLcTYR4CXtImKrUeydsLz1oIGFWuLVZwT6t7up5UEtFxFD/x3BrKcmiZb6dnAUuSi/IZiPML5NsvRL4n1tpT94nGiVttg53OCnkOLzxJUk2XPEBuqTgX2MunpE2j3Jr2WmVOgpCY+Jj0l+TcUt5KjHqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9kUYlKR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9kUYlKR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7370a2d1981so5578799b3a.2
        for <netfs@lists.linux.dev>; Wed, 09 Apr 2025 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744193445; x=1744798245; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHa1lD9OM2siXZI+Fk8h37HkF70Jc4GeVcg8Hqzei70=;
        b=T9kUYlKRMZRK5GLQ0lBW54OgM+0+38wE44hGQgbLWDNMxzTfXBlDjG1rzCqyYHepDH
         QI+sRe1WM0Et5NdusdoUmprOxlihoNacHe+CQ7LSkVNEXGECpV8Tbn/6ed57gvXCm7sk
         k1rnnDD7vYBjb2WMYNO+Y4sKKUakz8EfLj7EEqWYxnC0kqNDFpl/nCv/bd5xh85JU3Tx
         h1sKyRnxtAtYwNt79Lzbbo9IcQkvd9Y4jpMvLuBhOagniFk1XED/2e7dqPHbVHQxfYRi
         xoa/uO55FGpfwAXWywJNJ8mngGZwuK0jkeNJBIDqoz9/CTjtlaY8rAg8rQAWJ8cKPDhA
         0yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744193445; x=1744798245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHa1lD9OM2siXZI+Fk8h37HkF70Jc4GeVcg8Hqzei70=;
        b=gcOB5RI5upd//SKVjXZWM5v6Aa7SR5lKJvg9vGiD/wlt4CCzZx2tase1L02uE9f7Lt
         0xvhUk+JsTIxVtl5TzN6JW5V0gpFB8yucRkv88mUT/xbvR7B5p1AwGcE8KmPDzXu5Fvf
         Wwb8h5CCO29k08T3mmDNpBQjbQTurCuPPPFAPNU6nXSIcioSYI1LpucND11wnmKcYz4l
         0elvAuw5eK2pvZ5GPo0cGDvB9kYasYVup0aMwTvejMjh4RN7YVYj2dlXyydPDrLfsAJj
         mRoWUN07TIQQ2OVwzVP2Da3SrCyRuOoCRSrlkSEIh/ao2g58OGpqdOgYlpIv1kh1m4/3
         mdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWidqWaCM52P+NHiB4K+2YFgcb11C8YPntGJwK20z+8JSmBqBu7g/ioeeC0l5gjM3BA0VIfZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy38JghRvTCc3ZIjnF3IE9GYzXEg7X2CwMAXxo767AkUakFgURz
	li7Huy/3dhW/QiPi9iH4DCdp/PmZ4RVjvXJBc/troZbOwLSF9AWX
X-Gm-Gg: ASbGncvhhCBTZ5FYYCk7l3pNlboTujcYW77YmFH1FCfip2i8V4RoWgOUlKXpxgMZMzX
	YmSHrNGtIfEL6Qc4n054CpdufawQYpOoe6ucEgBsgsyS997iWMolaG5DKVcqS6psFXo4kvyzLPK
	3dCtHv/Vc+pgsyyrZOsx8DC+KQQcKh85Vl2vuV66bUA6ZA6ckCthK8gwJo0acK3QC2fVkenYWVg
	heYE0ItS1K+Xp+zBBLx0c1mkVz/lFTRk7Ao/fLHpJo3fVRz8Yp0KPU60BjSILpKPtjQOoHgqU5g
	IYOX9TvEhXyropKO6ZYPYzMImpR0+kRTsPqOYwVv
X-Google-Smtp-Source: AGHT+IHQAF/RGnL8ythIUl3544itvHiQ4tndYDfavVjoYnzvbTxExsWO+GFwKENdwurwiQE/DaSyOg==
X-Received: by 2002:a05:6a21:9106:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-2015b00f776mr2580775637.42.1744193444326;
        Wed, 09 Apr 2025 03:10:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e4d8e8sm899059b3a.126.2025.04.09.03.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:10:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A57404236D23; Wed, 09 Apr 2025 17:10:40 +0700 (WIB)
Date: Wed, 9 Apr 2025 17:10:40 +0700
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
Message-ID: <Z_ZHoCgi2BY5lVjN@archie.me>
References: <Z_XOr4Ak4S0EOdrw@archie.me>
 <1565252.1744124997@warthog.procyon.org.uk>
 <1657441.1744189529@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KOQW9OuYN0wKoufu"
Content-Disposition: inline
In-Reply-To: <1657441.1744189529@warthog.procyon.org.uk>


--KOQW9OuYN0wKoufu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 10:05:29AM +0100, David Howells wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> > > + * For writeback, it is unknown how much there will be to write unti=
l the
> >                                              "... will be written ..."
> > > +   pagecache is walked, so no limit is set by the library.
>=20
> No, I mean "how much there will be to write" - ie. how much dirty data th=
ere
> is in the pagecache.

OK.

>=20
> > > +Further, if a read from the cache fails, the library will ask the fi=
lesystem to
> > > +do the read instead, renegotiating and retiling the subrequests as n=
ecessary.
> > Read from the filesystem itself or direct read?
>=20
> I'm not sure what you mean.  Here, I'm talking about read subrequests - i=
=2Ee. a
> subrequest that corresponds to a BIO issued to the cache or a single RPC
> issued to the server.  Things like DIO and pagecache are at a higher leve=
l and
> not directly exposed to the filesystem.
>=20
> Maybe I should amend the text to read:
>=20
> 	Further, if one or more subrequests issued to read from the cache
> 	fail, the library will issue them to the filesystem instead,
> 	renegotiating and retiling the subrequests as necessary.

That one sounds better to me.

>=20
> > > +Netfslib will pin resources on an inode for future writeback (such a=
s pinning
> > > +use of an fscache cookie) when an inode is dirtied.  However, this n=
eeds
> > > +managing.  Firstly, a function is provided to unpin the writeback in
> > inode management?
> > > +``->write_inode()``::
>=20
> Is "inode management" meant to be a suggested insertion or an alternative=
 for
> the subsection title?

I mean "However, this needs managing the inode (inode management)". Is it
correct to you?

>=20
> > > -The above fields are the ones the netfs can use.  They are:
> > > +They are:
> > "These fields are, in detail:"
>=20
> It feels unnecessarily repetitive to say "these fields", but "they are" a=
lso
> sounds stilted.  How about I rearrange things a little.
>=20
>     The request structure manages the request as a whole, holding some re=
sources
>     and state on behalf of the filesystem and tracking the collection of =
results::
>=20
> 	    struct netfs_io_request {
> 		    enum netfs_io_origin	origin;
> 		    struct inode		*inode;
> 		    struct address_space	*mapping;
> 		    struct netfs_group	*group;
> 		    struct netfs_io_stream	io_streams[];
> 		    void			*netfs_priv;
> 		    void			*netfs_priv2;
> 		    unsigned long long	start;
> 		    unsigned long long	len;
> 		    unsigned long long	i_size;
> 		    unsigned int		debug_id;
> 		    unsigned long		flags;
> 		    ...
> 	    };
>=20
>     Many of the fields are for internal use, but the fields shown here ar=
e of
>     interest to the filesystem:
>=20
>      * ``origin``
>     ...
>=20
> And then put the bit about wrapping the struct after the field explanatio=
n:
>    =20
>     If the filesystem wants more private data than is afforded by this st=
ructure,
>     then it should wrap it and provide its own allocator.

Looks OK.

>=20
> > > +   This is not permitted to return an error.  In the event of failur=
e,
> > > +   ``netfs_prepare_write_failed()`` must be called.
> > "This method is not permitted to return an error. Instead, in the event=
 of
> > failure, ..."
>=20
> Seems superfluous, but okay.
>=20
> (Btw, can you put a blank line before your "> <snipped>..." to make it ea=
sier
> to go through your reply?)

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--KOQW9OuYN0wKoufu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/ZHlgAKCRD2uYlJVVFO
o3SfAP4ky3mQ4SL3aFrNICEAhPDaiLmNTwZVUKj0hCDGGB4v2gEAu82AiCi2iPt7
KCtYDhPrYatH491Cs2azUBWzbpO+wg8=
=2vDf
-----END PGP SIGNATURE-----

--KOQW9OuYN0wKoufu--

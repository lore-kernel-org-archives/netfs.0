Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF39347512
	for <netfs@lists.linux.dev>; Wed, 25 Mar 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443439; cv=pass; b=c/QKNQTGEulksB1UicDS//gzgI+Cdz0URNhhZaBT/A7rugOaMwivGDn17Ib/DVZhjz+rNUCHAesutEytX3cqEFG7yODLt7kTQSX0ZJ0Pi3U3vq5F43H3i5JMltWHRbaOKc8ZosRja4XJnCOTpIvxdGrKCbBXKjOZfgmbRrqjMZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443439; c=relaxed/simple;
	bh=I6nu+W5oQXgoBediHBI1nxFNIoHjXKwmRc/d4+b+Voc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or0DemWBkoHcJ4si03hCDR5oKWz1Wif9YnosXIHLobeau7iPujN/Y5UckVwPD1KdqG1ECfu6Wy5g+G8z8m9TETtv1585Hyb4fJUP4gSTaThsAW7Znkng7xPu+PrIwL1hR78Sr9xop2dA8pBCJp6O0aNHDVGEficaYSeIRHxnMgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLLPqzNU; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLLPqzNU"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c160308a54so567718eec.0
        for <netfs@lists.linux.dev>; Wed, 25 Mar 2026 05:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774443438; cv=none;
        d=google.com; s=arc-20240605;
        b=D4wAGoWj8dKlkJwZQsHnuDZ64Bq0YQ5XpESpMZNQU3dRu1og1lUAiFexzItMT2hXbW
         Q/D5lejRJgjG5Uuk1zCT+ckxxW30u6ZxfZBkGUUNGjDmykmdcc+2q665cnrXi4cCiQVx
         kYOBpzrzNWiLPVufbVrrzFASM4AMJDWqRrAFarSmTC+wW7abOao3/GGtCj0n8tC1D/TE
         5Sch1L7BeLRxUCnYWVQj5j7ZMwj7X00ss1PZwWn7iietgIMRd+bbbyzxtaiRFa5Iu4WL
         61qD1cPvqeHhbQ31RUxnkp2RvTCauNq6Q3AaRMt5dnmNC2IMuefTSu45aS90Qr9f2LeO
         aRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6rECN2hnxCRa03RaIkDSyMoiGlA3vF3EfjC2Pxqcgk=;
        fh=Jl26MWXxdqHVWC5jHonNjcKtHLJZrlRsZUFWsRdJbSo=;
        b=GKKHHKpwobNgiqOPE22gY+WIoPHEYjLU5a57/RXFuUIYrH/XXzbmCJg9V6m6xHGuRK
         HKcc2asPb7UReDpnd26EPdafTZRcA7liHFV0EufCFrfd4mbMojoH5V8DiQb7cBHbop4X
         zqrulELAw35k+XcTtGcapRF19q1woZS3kgUBiZKe2JBg3Bym8brqu5+5tHdv4oWDVbgE
         vrIE5QwSunK7oq9W4+3zWiHRVH5bIXyLnX0uBeDD30NRSTWUc/4W4lvcddKzJFwko3VJ
         ZBBI3LXE5D30zr1DsQEwIMYvGwxAsFbL+Gq9S/JnNPMMFHjJKcih2bxatE9/TBxzox0e
         sXSA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774443438; x=1775048238; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6rECN2hnxCRa03RaIkDSyMoiGlA3vF3EfjC2Pxqcgk=;
        b=WLLPqzNUzy8hRALX9tXTtqduWTkdSwdRQtda7G2nrShoPd+zjGXgnB7LdKUp+DzOCG
         lj9zsRfzLGMLfe7DWggMv+zo7lW+nt6B73rFFMq4CmE2QFGnmKwFgemleRW0HXw6i9jk
         Z3D366YoY1XMjLqDsgF85Lgof7GLAgK2V9pf9jHOirjC7bOFt/cQ3RhAuCijx//97wBR
         kcIVKSecjcDsg2uVPrszOLgetHYz8lwTT5rzMv1PghBaT/2px7HwzHMYTIiZ5mbWY2b1
         xwZEaNOfpmQ6cIARWoq03hm5laNdvLXiHOMGAcGbsdFodG9HHkhUuKsS66Z3Paj6ZdaL
         p1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443438; x=1775048238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f6rECN2hnxCRa03RaIkDSyMoiGlA3vF3EfjC2Pxqcgk=;
        b=HJeemDKiq4QwCWK5ec/tFcqqF8dmot95IJGhcU+tqfyAyHMUsE//9s15ZbhA1Ujz9f
         Xi22bkVZgXpETGVsl14SeoXoUBcsLZnv3cKWWPZqJmWiuLOqBLWJ/MiOcGfTEn3DM57x
         db+vIF90ZuXN4uYrD/49//LHuari18cHV2rpSG9etlkZcWxGhV02qPDBwSotIreAQJhJ
         KtkEfRbTXk22bU9nXE2d8c3saoCzt48u2GG+ZaD0LaYMqul+35qiy5mpmfyyd3wkPfep
         Utzft4ltD/Ylm3LaGblCcOE2k9TSzR+yK/GbqcnNMah2f+bZ544yQgN6RF9trpp50OmZ
         MxXw==
X-Forwarded-Encrypted: i=1; AJvYcCW0FmYmqmsK+BhpISVL23enpduBlapIy7nlyyKOlAydHUfU9CD3SsaGjw1RhcKE335e62q5Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw69pxB4p4UstnMUPDEr4S76kCHvtQZQi4J6qFVhiKPJ2L0XT3E
	r+eaGMWi1a4vtjuZ+MaQjd3zwvDwaJ0KTIOTtI4N96iqQF7MY3DLFpphUARBKdfqpNOWEJu18Q/
	lNW1qwbEvhIDHgZPMXkdJIPPvspQYW+4=
X-Gm-Gg: ATEYQzwXFLDD4COqcCYgVqx4MUmx2oKpKaAZrfeDxRxe7wk7OTx6odOOOYP9Fcs4cKe
	rR86NpkJssaNrv7emonUAsOxfuyn6DKhK5ApVCY0gwjdZJ2nsxuEqTZMPsxuK2+0pNhDqIEKvwi
	9kVPugKw891NsqXUDCYTFF/X80mA0hDV/rBuA98GHmcesVJ41YYkjCuNvX5fYZgvlWxAGEog5C2
	/RWU6K+05quEW551J5Jh4Qgt/090HFMgQBcnqxQbbZmWCnHfa2wyK2ljzwC1Nv66h9qy/Rwr17n
	6a53
X-Received: by 2002:a05:7301:4446:b0:2be:8216:57db with SMTP id
 5a478bee46e88-2c15d26fb14mr2019315eec.3.1774443437531; Wed, 25 Mar 2026
 05:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4001609.1774391729@warthog.procyon.org.uk> <4002225.1774392603@warthog.procyon.org.uk>
In-Reply-To: <4002225.1774392603@warthog.procyon.org.uk>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Wed, 25 Mar 2026 09:57:06 -0300
X-Gm-Features: AQROBzCCntXGzWRv1Zw1UxwJFz_M34nFofbkb9RgsykrtknfvGumglgDUw89JVs
Message-ID: <CAB9dFdvs4=ZbqHeoMFXj39tPxCxKsApHXdyCxvjT8aAAbRCf6Q@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: Fix excess dput() after end_removing()
To: David Howells <dhowells@redhat.com>
Cc: NeilBrown <neil@brown.name>, Paulo Alcantara <pc@manguebit.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:50=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> David Howells <dhowells@redhat.com> wrote:
>
> > Fixes: 7bb1eb45e43c ("VFS: introduce start_removing_dentry()")
>
> Actually, this should probably be:
>
> Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing()=
 and end_removing()")

I think it is the correct Fixes tag, but I'm not sure that this is
actually the right fix.  7bb1eb45e43c switched other callers of
cachefiles_bury_object to use start_removing_dentry, which gets an
additional ref, and removed the extra dget from
cachefiles_bury_object.  In the cachefiles_cull case however, the
dentry is from start_removing and has a single ref on entry to
cachefiles_bury_object, which is an issue as "rep" may be used there
after end_removing may have put the last ref.  So the correct is
probably for cachefiles_cull to add a dget() before the call to
cachefiles_bury_object.

Marc

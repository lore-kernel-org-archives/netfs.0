Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74D1F8908
	for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499297; cv=none; b=gyDCYTdEetxPy41bMB40Nkxn7f0pI+o6C+dg1eXZtfBU6rYc1qGy7yF3Tn8wNfB5puR892MbV54vuS9S5bTUiQ67ZvJs1OA70u5ADvBRuFB1T5bSv9e/0N1V2BGUuCMwcIEL+i5E31ItkHGpofmLMkULdgxE8fPxLD8Oaasp34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499297; c=relaxed/simple;
	bh=VV96BKA7n1T9Z9K5RS5gOsaZbYgfs/EtKzNGtrNnVDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2k0Pd95Cek3rFL+2tZhf70kgw0W0qYLCLIl0xYx/ihDNOwP/j17KS1VCyuPta2pCIpROxRUavYgP2daSMv5U+5qaK3M7h8JkE6CjHesaCA9lsh7wUN5cxbJmR2JE/jv39tRokiHBPkyTX9JFV/5358QCos9u9d508Vn8UDso9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N88KBegt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N88KBegt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso45532275e9.1
        for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 14:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737499293; x=1738104093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wELvxIWjZ3o1+myT7SjLWZTVBUHnTEeaocAhargmOc=;
        b=N88KBegtp+KzXDf+WLMItRjit+SI0alSMXp73K/ECgDkpahQIMqQ4xoNbnV5NtPy++
         sG5DbfPk89QUHiUc+Qyo04ACc3UCaqRGD4WHGo5V7mwLNN5zvB/6EFlvvO56Vp0YRvAv
         IfCtwSPHSYlx2atEHfgnAS5d2To0MTvhgv9U7Dh2EChaSOq9fk/juE7z1it6O1g9FGmt
         gpAr5LzqNfHYwOA9eNQxp+71rBJajKEa1W7494sYpmV2NIwNOO9ujFFJOSaTn720eUs1
         mMxA/oUdP7vjTUH66+PKPvNPIGbe8FAKZYUCzOOuULQB4QLsDRbmTef0Itayvy6VKUyq
         uYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737499293; x=1738104093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wELvxIWjZ3o1+myT7SjLWZTVBUHnTEeaocAhargmOc=;
        b=ol7d6XZda8JfcbYUxXjG2rdAM9zE+kfGX+tKcQsNZUvENraW1NCd4FeF5gyFKdaIS3
         7Sk3nmHRdClnPwDNEApd6eR9jEIdh9cDBXXMgMJ4TvQ3KFw1jNhjhkkKrQnHNQUtbXSm
         1Qyu8MwJi1AyEW88BIRY7LNSHjefvKs7KmS5IiD0FjmvUBXrp6y6in+V+CY6TE2rmaoI
         0NdUHvU7wR0TAvNJQyPThSkcxlEXtggE6a5Wr8iGhFO2jB1t2akdZOeOr2plhwAXCbzC
         Tt60mEUpXznkGijfrb/3C8ee6fjlBUG4iB5f1gZekbbGTmtVvqMhwHpQZqof3KtJBueS
         W/yw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Oba0IeK2b5Ipqv7EuA8OR4fbQblCFDsusl1mModjS8dO5fBF57JSlrbfF1TfNnGjRKxSBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6qBISnVI5lcxfWC6ikHbSXXnMeFuJRe/PqiEdg4H1+f/F9VJw
	ygLSTyMX2MIFfYHKLticl+dD4pnpEpGYaB5fK7MJrp5dbXn533WL
X-Gm-Gg: ASbGncv6NlOQPWPK6PBvffr19gyp5kH9KFhmwd3vFKOiLPDfERDWCA5xrwRC8zpozHv
	zr/zKBLQmYgY+5BBNG6GaJ0ZDuCb20hrVbeOSzNrGA1PXmdEgSJx85yWEWqM4JRKIT/aOyn4GY+
	u9ShReKE8rHrAO/PzXhrZvkbwH8A8d4wQ1qk2icX4Te/3l/SI4BN2MRq5FAh1DNpgngiBhgD6TE
	zkQiDq7+XGUNlX4tMxq54jXsKzDdFJpqwMQYKfvpwBb4X0oNvR9OhDOIfmsM0urGWaYJVhpnQuo
	GMo9OpfuVfcBXWBAMmtLTJ0k1hV2MGpZ
X-Google-Smtp-Source: AGHT+IE77RhxIfEBu84FoFSqZD9kaJn3Z+8Po/Qu+1cdf6gscxWiJK7G11SduoQGviebJ+sngk+vQg==
X-Received: by 2002:a5d:6da1:0:b0:385:e411:c894 with SMTP id ffacd0b85a97d-38bf57a6844mr17710712f8f.43.1737499292924;
        Tue, 21 Jan 2025 14:41:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3215066sm14818377f8f.11.2025.01.21.14.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 14:41:32 -0800 (PST)
Date: Tue, 21 Jan 2025 22:41:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cachefiles: fix build with GCC 15
Message-ID: <20250121224131.3845bfd7@pumpkin>
In-Reply-To: <20250121221911.424a2003@pumpkin>
References: <20250121091530.1316673-1-brahmajit.xyz@gmail.com>
	<20250121221911.424a2003@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2025 22:19:11 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Tue, 21 Jan 2025 14:45:30 +0530
> Brahmajit Das <brahmajit.xyz@gmail.com> wrote:
>=20
> > While building with GCC 15 I noticed these build error
> >=20
> > fs/cachefiles/key.c:12:9: error: initializer-string for array of =E2=80=
=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
> >    12 |         "0123456789"                    /* 0 - 9 */
> >       |         ^~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >=20
> > This due to GCC 15 having enabled -Wunterminated-string-initialization
> > by default[0]. Separating each characters to ensure NUL termination of
> > char array.
> >=20
> > [0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-=
unterminated-string-initialization
> >=20
> > Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
> > ---
> >  fs/cachefiles/key.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
> > index bf935e25bdbe..555a0ec9eff4 100644
> > --- a/fs/cachefiles/key.c
> > +++ b/fs/cachefiles/key.c
> > @@ -8,12 +8,14 @@
> >  #include <linux/slab.h>
> >  #include "internal.h"
> > =20
> > -static const char cachefiles_charmap[64] =3D
> > -	"0123456789"			/* 0 - 9 */
> > -	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
> > -	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
> > -	"_-"				/* 62 - 63 */
> > -	;
> > +static const char cachefiles_charmap[64] =3D {
> > +	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', /* 0 - 9 */
> > +	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',=
 /* 10 - 35 */
> > +	'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', /* 10 - 3=
5 */
> > +	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',=
 /* 36 - 61 */
> > +	'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', /* 36 - 6=
1 */
> > +	'_', '-' /* 62 - 63 */
> > +};  =20
>=20
> That is just horrid.
> I think there is a attribute that stops the warning.
> Or just convert to unsigned char [].

Bah, neither works, but see https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D=
117178
and https://gcc.gnu.org/pipermail/gcc-patches/2024-December/671714.html

If/when applied adding __attribute__((nonstring)) will disable the warning.

In this case just changing the [64] to [65] will do no harm.

But perhaps the warning should just be disabled for now.

	David



>=20
> 	David
>=20
>=20
> > =20
> >  static const char cachefiles_filecharmap[256] =3D {
> >  	/* we skip space and tab and control chars */ =20
>=20


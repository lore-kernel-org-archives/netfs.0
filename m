Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D318AE2
	for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497958; cv=none; b=ua6r7IJ66PtoMT7sEwrELsvvnDliKUOJzmgqlwcMazLKHCR+E896PlZiLBlTivR01lGw9L5902CHMNP+9Erl8gJ9Xs5KfXE37JuUsHMhsPV5cPu8Xtq46kKTDuYHLZE5jZnjiqxJFXYSsJ8Ec+4G5htY7J9BT9sg88GiHmnGS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497958; c=relaxed/simple;
	bh=n1gw9wqSpzGGWq3ON8IDLwgsArUOIACfgtrnjL2ECYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMXz4Hjd4GRNX8h3y09gIKZCNJc3OlVC26lmH5NZmYR7s1/Al2K80nF5VD1hQXpdW3fUBtFiA5OYwyDr3e/W+SzExBilyK47nsU+qISwvV89wsWTpYGxfk4CCtKHytpy6jC6fSzAf3R5RXfKbBira8hSgMs+6TAJ3oXPt9/9o0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHFGKtv6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHFGKtv6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43635796b48so1672665e9.0
        for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737497953; x=1738102753; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNy6Fc2BkHYA7xaM8m7c/fElG1Q5tjJMMXzKaihomq0=;
        b=FHFGKtv6T/2PC3x+wCwUERqZdK4el+fy9Rm17p5BhwqVDKJCi/AY9b7Yyp/MB0FJtx
         xWRh/E/jn0gwJf+LfcaEFIVONybekuN8AKUL719BsHyKj6eCfUgp9J/mRLHjw4Bv8kop
         gqXcP1TF5ach7umrfnfQXzvSdtIBhlQdzAE/M2tLjHLbRWyELY2J0a6EYQWoYj9S/SNG
         yyjsekrSJkQG3x5l0ZHhbG3kTN38rCJ36WquRpJNnQQqQFQmOH7oKaqkCNHMqJ0AJrXm
         ek1C962GPi4QU3EHZhx7tngxWq/qjSusCwv6bPLICqsAk97IEE0SToEgYuIODfwaPW55
         bk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737497953; x=1738102753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNy6Fc2BkHYA7xaM8m7c/fElG1Q5tjJMMXzKaihomq0=;
        b=wYn109RicpWTIg1qIkG0FTKfemBacxOe3eOBNQXSgAIFZbcZBgqugURzpjFCraCqsG
         cDAOqUuLRHVj4BRpKQxQGlcm2eaI72m4jiKMfxi5h/QqSY2cyswUK1dirOmEzPct2x6X
         Kzxg1TeoZ7tAZTQA/RgSuSCUWtuAYv1bVboyQa6OOq7V/OmMv5cPYNFC8bwQ/ljwbU05
         VKOoF3FseeMUJIF1s1oLBLvuE/gOd1k2CCA/6jPsxzcl2PErDR/BO4ULBaASLXNH0Tlh
         KVuC9qhOEAC0EzsHiuR3kkaEC2w8MrKMgd6ftVhrWPpLPzKNonv/V7IwPI6CU70GEVhm
         XV6g==
X-Forwarded-Encrypted: i=1; AJvYcCWOnvP3t4NPt9g0yDokvkoYvRbW3JH0zLij/o+v3GFo+tP6P22WuG1n5ETKWJ//h91Zh+NEZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1WOKVDEMWwD7nn5AM9RLomwgxLtsfrfjhYbnXk7EY6ICctywM
	yi+ZrNR4KPeZp2LvzFSzFBI537CivnKu+HuC/z/VYqYJ/Uzr2Mvz
X-Gm-Gg: ASbGnctCXnK3LhLtzOhld+RgekFmk+FoNDS5HNACK8V4WXJ7ck71CNbdQigSog0DLTA
	sfNaHY7xsEef9GSFxOzNk3q0CATqRtIxZLI86nPWcCxk7neerI8lo3Q87oKRJzteoHJRjJbmJlS
	H0s6tFfDaI+8+H6mW9R86+I1IEnX0QS5TNt5aNUiARbvpxvvr6+p4SYpJUPBOOwLVs1NAGFusyR
	UqUc8jHiiX3/YF0vtF2bi9fOjFOe/YmF16VD5MRv/ZYySK2VnTUa3zovbZF5MXyNxCULzKY5bj2
	id6urE8bdEoXNWP6G1aKSCxatP2TMWYX
X-Google-Smtp-Source: AGHT+IHIgbIfwQDQLiYa07yfjF82SfjSsag0JxwnWSQVgMqdbqxu96UMDMUi8f/mhZvd6kAqM+654w==
X-Received: by 2002:a05:600c:1d0f:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-437c6afdc92mr260136185e9.9.1737497952576;
        Tue, 21 Jan 2025 14:19:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31d987csm124405e9.27.2025.01.21.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 14:19:12 -0800 (PST)
Date: Tue, 21 Jan 2025 22:19:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cachefiles: fix build with GCC 15
Message-ID: <20250121221911.424a2003@pumpkin>
In-Reply-To: <20250121091530.1316673-1-brahmajit.xyz@gmail.com>
References: <20250121091530.1316673-1-brahmajit.xyz@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2025 14:45:30 +0530
Brahmajit Das <brahmajit.xyz@gmail.com> wrote:

> While building with GCC 15 I noticed these build error
>=20
> fs/cachefiles/key.c:12:9: error: initializer-string for array of =E2=80=
=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
>    12 |         "0123456789"                    /* 0 - 9 */
>       |         ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> This due to GCC 15 having enabled -Wunterminated-string-initialization
> by default[0]. Separating each characters to ensure NUL termination of
> char array.
>=20
> [0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-un=
terminated-string-initialization
>=20
> Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
> ---
>  fs/cachefiles/key.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
> index bf935e25bdbe..555a0ec9eff4 100644
> --- a/fs/cachefiles/key.c
> +++ b/fs/cachefiles/key.c
> @@ -8,12 +8,14 @@
>  #include <linux/slab.h>
>  #include "internal.h"
> =20
> -static const char cachefiles_charmap[64] =3D
> -	"0123456789"			/* 0 - 9 */
> -	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
> -	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
> -	"_-"				/* 62 - 63 */
> -	;
> +static const char cachefiles_charmap[64] =3D {
> +	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', /* 0 - 9 */
> +	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', /=
* 10 - 35 */
> +	'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', /* 10 - 35 =
*/
> +	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', /=
* 36 - 61 */
> +	'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', /* 36 - 61 =
*/
> +	'_', '-' /* 62 - 63 */
> +};=20

That is just horrid.
I think there is a attribute that stops the warning.
Or just convert to unsigned char [].

	David


> =20
>  static const char cachefiles_filecharmap[256] =3D {
>  	/* we skip space and tab and control chars */


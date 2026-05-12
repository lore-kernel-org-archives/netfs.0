Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BE33CEA7
	for <netfs@lists.linux.dev>; Tue, 12 May 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592191; cv=pass; b=BN7qgoFrZxSAg5V7eReor7GxncPK2LZbMWDkoU17wgRYokpN7fcbwIQBlUzaY8kwye/ENNk3t2urPsA1/vwramIEbWAvzTIbQehameG5oug8wTv+bYRk1PHnWLPZREbmwP3aSsXwV2Qouhhh+Giscg9AFdhzt/50CcgtS43J3Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592191; c=relaxed/simple;
	bh=oLNne5cobDJZx5zkoUSLGFP9qe8rytYx2dxIodND2sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2BX61ZV9SjeJqmiI67SSAvxL2gy74Gelahiszpeyyi2G7pdc9zUh/BV6mV67OmjyNjK88E30iCWdAAtDJUl//Tcu8mA2iZQaemRJOk2jQ0gb8ggOHq3+K1BZMctAEKEGNVR0CnRbt+3ZsU4G3MEWgAdezDpD8WYw3NLS3wluyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE906vhk; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE906vhk"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-651b17f1bcdso758990d50.3
        for <netfs@lists.linux.dev>; Tue, 12 May 2026 06:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592189; cv=none;
        d=google.com; s=arc-20240605;
        b=L+hc8saGfap1dBmP/I3NE7zgYDWi6fdd6x8K/nxXQlXGxulakxP8N3RZnesidZcjcL
         J/p5BN01WMc1oULFX8w5EqlV+O/NxCvCRoDXC3K35JoFyR7dEvtjRSps69XPihZpyXYw
         bFxhi+Zr5s5dgW76JbjmKdcrFq4BzQamZWaPYQ7pefW9Sg1oyA2pLl4a5iozghw/yZ0A
         cxkPG+y1orsTq0IXlkaQszP3DXnStzvtAmcakx0dsePSyQ53kqiDrfMcGpIaHsxMK0Tx
         0bOdKq2+ed3er4UQ+a6P+KOFRiSSFG1CC6WT+Gfujoo0lu4ckBzt7aUY10JvR1l817s3
         rGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        fh=xDOqFQTDnG9/SC1a/7gP6S+ytUBTp0VCiycZZkg9e/c=;
        b=aaYXDjacNSJ1qZnsVhG9FV00tIzi9Wx7S2hI4jHFjchfXD+WSzz/UevxeAldGTs5QU
         MqM4HS1nT6YBnuZ/PGNyVoYloKeiQDaoJu34md7YH6WPKdeaip0cv5y0lXlGUJI/FzfI
         Xd2ETsS9MLy8jlyrtT/uAVi51W0MUJxvKlQaMqmP6Cq+4U5o+Zsl67sPTWzyOKam6U5B
         2xPTym2b2M4VreyYVTJqtX/MpoIAAFr4B0HEcJmvychzcEibxjLY3Kieo0MC4LNNxJGO
         lSnjih51qGIz4uMG2Dmf5NMICgTg3HhMaFE/tGZ8xoPuZXv5EWgNhQXni026AnyXSB9J
         MuEg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778592189; x=1779196989; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        b=ZE906vhk24MtZqz8jZ7HfeP8eCL+Ok3deT4N/vDx0CUYzp18Hv2LlA08RWK6Syrpxw
         D/XxoCBb7NrkLooQnjSdO6WuFFAek6MHc8RsoAX8LnntgP1eM+U2cAkDmb2VzOPdmdXA
         4EPBba2ldEAetTHibHNV1cp4ayEcs7qqzXD61LYO0b1aqO5lizx9roPaEXC3yci6AIeH
         o5zfAOQ/n3vrwRriWpLGp9Fhl1ZOxLcPLzqhTTiLP99s2lkrARXFbibSQ/wN5fdHu8hb
         6j8VG1LYUPhmkGYkv3U/gLBsrW1ex4BXYC4ljJjLd5amOTqAqoY86EPs6ZQTkqp0eRk3
         JODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592189; x=1779196989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        b=d6GuUlIXsvedNBOiMYwmwWk4Ln1qOAnaUX9N3tEyR+vc9vZZ+8i1S8BJy6YmVyoCC9
         hnOrUWW3xDa3JNzv60SR0zGDHOY+pzWJHhZzxRjs81pirVIzjr1p1vwbzV/gq8hYzaTD
         CaV84ZWl6GhdWxhFFuW7sRkY4nR56Ddxqx0AzxaNOpjJi4gexH99ZUCeZN1PUgtm2PFr
         iXPJLL7Q0Y0khuWG66I+Ta/nrktKVmcuJ+arp/iuX8ktd5OepR61b09MdFOQtw/nv6lB
         ULK2uymXZUETxz3hCLr6kyB1a4YWOTgRhxmhgWNelTJIhJIifTnrLvKczjFO6ScSdw99
         Ds4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Mtr7iYwy5JZG/hDyVw150GQtQmKReMT4W9PzOGAgxmTrMPEMv7xmtNcsAz75dKtaJHQW6Ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuJYLHintrJTWcF9V90X08cDSf7vSvAx8xaWVqAprUYirJYX7m
	wAog9jNfbAwHLsLlEGh1ypQ4L20cKjWyKGpBowO91YO566y6ZgXtXIVSHMgqecVyi5TQgPZTWwU
	4+5ZQR3g49m6xeZguXGUqiXghezvb1yk=
X-Gm-Gg: Acq92OGUjrrOmQ6lazNvoxFnUv1CH9J0c8IqPVXIayNSrQ5sxW5E1drJRaMvUytoN/5
	tPifliKkHfqvEXq6A0FJB3dpHD92WDQtQkGuLOPar4YPYSFPq0Y71CIbQHlAGoFuiyXkynwfgdp
	XI6dhXVRjfdTpD74ZEQ8tbSpyw5RVxfPNpEqd8wxbe+y9bNydl4mboeseFKNZAWS8Ij9doxCt9f
	apn6Qm257C7MG5fQ68t/sPQ6XKNxwDzPCPKkYW5zmxguYVtfE4F3IheC6Y12wrYlLeS1VyEPoMk
	7BE3Z6wh
X-Received: by 2002:a05:690e:128f:b0:65c:124e:61ce with SMTP id
 956f58d0204a3-65c796f49e5mr19234437d50.0.1778592189338; Tue, 12 May 2026
 06:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512123404.719402-1-dhowells@redhat.com> <20260512123404.719402-9-dhowells@redhat.com>
 <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
In-Reply-To: <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Tue, 12 May 2026 22:22:58 +0900
X-Gm-Features: AVHnY4JVdrnalD3VcY2gJzGM9eUXbqquyOoAkwfHaKwpTwhqh9XLF19h2Tihueg
Message-ID: <CAMrLSE6Ff-_Kuyk44U1kbe6gjaeLuXanXUoBA5As69EYhZzw0g@mail.gmail.com>
Subject: Re: [PATCH v6 08/24] netfs: Fix potential uninitialised var in netfs_extract_user_iter()
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, David.

Sorry for the confusion. I was looking at the current mainline code,
but after checking
the version with commit 8ef352bc015d, I agree that `ret` needs to be
initialized to 0.

Looks good to me.

Thanks.
DaeMyung

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:07, =
CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi, David.
>
> It looks like ret does not need to be initialized to 0, because it is
> only used after being assigned the
> return value of iov_iter_extract_pages(). In the zero-length case, the
> loop is skipped and ret is not used at all.
> What do you think?
>
> Thanks
> DaeMyung
>
> 2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:43,=
 David Howells <dhowells@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > In netfs_extract_user_iter(), if it's given a zero-length iterator, it =
will
> > fall through the loop without setting ret, and so the error handling
> > behaviour will be undefined, depending on whether ret happens to be
> > negative.  The value of ret then propagates back up the callstack.
> >
> > Fix this by presetting ret to 0.
> >
> > Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC =
into a BVEC iterator")
> > Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowell=
s%40redhat.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/netfs/iterator.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
> > index 154a14bb2d7f..6903028b7162 100644
> > --- a/fs/netfs/iterator.c
> > +++ b/fs/netfs/iterator.c
> > @@ -43,7 +43,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig=
, size_t orig_len,
> >         unsigned int max_pages;
> >         unsigned int npages =3D 0;
> >         unsigned int i;
> > -       ssize_t ret;
> > +       ssize_t ret =3D 0;
> >         size_t count =3D orig_len, offset, len;
> >         size_t bv_size, pg_size;
> >
> >
> >

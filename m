Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC201E25EF
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115409; cv=none; b=aFtk8r2Cye1nFWZUZ4xD//jBVikF/g0vQtMde+lzsyOjXpkgoAZnKn7SZR9Y6zfIw+gyY0U9WbEht1UgEoZQ3b3H7WDQWe4McNMyO8xFdjqFx3x86lL538iOQUMVglx33Dq4lm3mAy2r2nBpXCNu8lMIwde0xJw0+BMsyTDRQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115409; c=relaxed/simple;
	bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUPq9I9BtOQY0/JvJB/XVyun3WLIsbryQY3y15fxK0RRxVQOUKakFo3qUt77P3+6OZhSG4ZBr66A2UsRRIsV/jV5H3k9a1RAqRGH0okT11CVvprNqxlxCIlO6sdKKRUKuglW6Eoyman3A0CiUoDzXkXYkbYU3oTl8KnDyVcKpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gbM+M7Hg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gbM+M7Hg"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0e7bc49263so589985466b.1
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758115406; x=1758720206; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=gbM+M7HgnPKijg9zlR0ww2T4kULLiBDk9inlZUcsVuBKAGuqve+zaP0aouDug1JGfY
         WCcIweGQPbaVjiNHIPCuP6rMF48FcPNBuT2NNa9nrm3EhkptbTPTNQAx+MJrhpmnOmBn
         gqBTxlYhB2E3+raeVH0i915DDOShWdJV7MKZF/ORDNWMa9EL+Bmv9fTuGkViySYvWnlk
         b5YR6BFAxnszR2myh2LrchlittaMx2H/q2auvYwW+EvaYHrgvXyAeH1nZiv9b9OcGpDY
         YZFcYlGNJIv7fSbfT2ZXXBtB0aLp2D2ho4hvIinAH37ZlLvnjYnCOJVR+CKzfhW/JQOB
         jh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115406; x=1758720206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=sXjJIYoDDUquxfWqu1UjuuodGSwXLO+B6F5Zn3VzNCf93IVLuMIjT1BOPAyGC9ympv
         4CpgyTqHuJ7RVuwG/ulJ/I1w1oeovtyegsSHXKMfmu301hoeQ1E3HL/BraCBAJI5R6zL
         0vFDU6aiYjjjCuLcvHB26XWzKbGqX0ejNsYQ7OqxI5NPMYrwyl5avoR57lwP5PGB9GSo
         UFEeK99B5qYY0FvkkrNpySUtnbABCJcYBx+lMD6qrKk6YBkicw30xlvsR/d1fg4GbFzZ
         j7ErDwYnORHr4+laFxJxvZf7XnLd3f9VcG2+EcGrWMRNYK9p4h+siUv5YCOvkY5axD0V
         gnhw==
X-Forwarded-Encrypted: i=1; AJvYcCWLAvWbh/Im4TBfwgr6buARF9baaENct8aoyYaQ4zodwKXQxZYWwkJfgXgc1NcxJsLSbfA9iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YziH0O1mTOzlTXK+QP1wI0Vz/LPw/64UctH4tcm7H3mytdJLyuK
	F+1x/fPCMMXAvaKwSHrFNUfJhxxnjQtL8pdZymnUYpevdwlB7NBbu6jtIfRsQBWLpTm8arW1cBm
	gt4FnwpAB2i1u95GQjv/wRYDSSC5ooQR37P6V2M3/Kg==
X-Gm-Gg: ASbGncsnBPlFCwzDXok2IHkPtRO/8j+iP29WkHV7Km/uNhiXqOa0/3dUqlzZL5NxlXc
	JQMpv66B57+fe2UP/q/VuXup3Wkfk0oRu3VGNNlfxUsiD1OswZOKr/rDVmbDoppZkIzf80l+oCL
	y8UqirL4xCIoW4rXToMgejw+DJ2hAYU2ICoy7FjoiD/Eo6a8QkPDah2dhx59MkCzk9hCYjrQMbk
	8ymtT66es7TBlkfxbBNGGXjtVvq5oTXdxY4Q1V3A0T77KE=
X-Google-Smtp-Source: AGHT+IEgewShkTB3IO6iy5D1trv7nKdXbV9WtwtBpgyTEh9TZKuca5Qb4ed3HJ87AvQ3ZW2yo7J0WCyjmW8j05mLxIk=
X-Received: by 2002:a17:906:7309:b0:b04:5200:5ebe with SMTP id
 a640c23a62f3a-b1bc1ed67femr266992466b.54.1758115405633; Wed, 17 Sep 2025
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:23:14 +0200
X-Gm-Features: AS18NWBL5l4pIlkCFqkI5FbYZctT10PlbPlrGgAIhMPZCsLLpTd8MK5AI9j4JqQ
Message-ID: <CAKPOu+_EMyw-90fvNXXRHFpbi8FDc=fd1kGs21iE9+M4ZZSWeQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Given that this is a reliability fix I would forego optimizations of the =
sort.

Thanks, good catch - I guess I was trying to be too clever. I'll
remove the "n" parameter and just do atomic_add_unless(), like btrfs
does. That makes sure 0 is never hit by my own code.

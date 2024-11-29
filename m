Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2D39ACC
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732914407; cv=none; b=JP+JE9xadT7owjmoHIa9GFk6EkNdr7DrzsASTPSlWV8WXcmdh7QzA4YtlDu4RIkhNzZ2K9p3gZOq0oZlFBzZg1dOibw0f88we8hEXSjgwHEsLuhaEAUfoev1a9z1YFjrdmADKvrnNa+0Pu5BkIcbskd8sOyLXfo/LMjYzAO9mac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732914407; c=relaxed/simple;
	bh=lzNRaVJaJp2dzBZ6WM1499zCj89Aa4u1k1tcAs2WbIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTHynZnHjTgtZ4TNlk7UcqTYxMm+oyrFYXa7MoweXFjJrWyxDcWN9vu7xjza0fwikZdE8U1w1qBr/o+3a/41vYd0LCb45girNOI3y4veJVf0URk5Q0ZbPBIuB9vuYhRU11k4FuqbeGFqTNcFNL4pabUgFP21SwWhDl/Q3+isUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NLAHeDcJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NLAHeDcJ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa52a5641f8so300893866b.3
        for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732914403; x=1733519203; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZSitS3zyNpA94USiEVzv1WV1TBBjL6Dz4RMgR2XZp8=;
        b=NLAHeDcJIyOd8tPceE+HNnjDR6bPo3fsvsZ3SE8QTGyeKjduf+kgxeUjKs5iYFOr6g
         xbZuWt3kWHhXRFaAV3+OA++9B+EXm/T/yJIpdWWSpJY/lKTYA6OFuwcG6xM+qsQhiK+z
         t8yohxfce/HwVTLO4nH/j+MVCb56ofIIRWK26PuwJym+RFnpqYqeIqQrx4DMWiBwqZZS
         PGYeHujpVqdWKYvFAUkrSAANy+ivmg2Z3ozvrp7v7krizk1wR+PTWFPGIqNbte55C2nG
         TNB5BL/V8byc4uBWhgOm3zDqGrIMx7oxbnbr4w2Cjf0/80ErwCk7pLxbGUzeB2r0Xu02
         8yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732914403; x=1733519203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZSitS3zyNpA94USiEVzv1WV1TBBjL6Dz4RMgR2XZp8=;
        b=rEgzjt6Y4h/RY0ZXW4V+CSvvx9GZoiCMFi1CzFNDLUmlsszwY9kkhDFYdiqW+GeakC
         1USinmbWyU8RFwMx4DUr9nN6ERZnZKH5qOg+FTrAK05PZgjTWml+9gQjphSYY82XSsuL
         fxGaSx8tOYtxoDBg+2o+zW3uDo+Gq5kukvWXuZ8iNO+haMTj1BgqdMO1IUk4yiNeBi1l
         BNWVQLXMZUGiHFpyXrPfmTlFRehwpZCTO1q00UFFzrfgpY/XeJtkOYe7Tx2Js2f+RS+c
         byW2PvGasjGjgemeOuTmtpMkIOBmvqbE1RcnHgfkeYAmEMjYOW0FmgNe+Lw9xyzvSCGr
         le8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjeuDh2dK9LfZ6jmnVWOrt/FWF4VMacowFQjPBZJFYLQw4lbQp+165ayETAt8mZF6571xADw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGTE3amOILrzHbhQ3Vdn81Pt4W/EPMq+H8+pZ7NBW6BnCvZVTe
	Msl7RF4jEGlHMNTSv01zAbHFJ9TlcHotsnlTvfa4idIFiYsJ3sl+fvy2LrhuAR5/jKLGbP1Pvci
	DSykXts2GevAU4fF0hpGsAd+4gKp54pSKM4kCTJR2VHGeu51bcqw=
X-Gm-Gg: ASbGncvJ1LuUMkih8JzJ57ScJGeoCgmBwv0k9HbYMYMP2D9XtO8KxXX2gd3FEsoDtJd
	5+iJqUSTVUSr2qWhbO/QCGDCTEYoGaQXwscDzlsEnoWFfZZdsClRn0keQKN+N
X-Google-Smtp-Source: AGHT+IFFQ1ppSleB+5O9jB2zUGGpHTd8sboY4WGdSMJOjNUHLd8vEIxJUbqGBGpA5TJKSfoSypAwnC12VceTC1y4Xjs=
X-Received: by 2002:a17:906:18a1:b0:aa5:48b1:d282 with SMTP id
 a640c23a62f3a-aa58103dde1mr877608766b.37.1732914402947; Fri, 29 Nov 2024
 13:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk>
In-Reply-To: <3990750.1732884087@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 22:06:31 +0100
Message-ID: <CAKPOu+8dBuoCLBAbge+TFCOz4Rtyo2Vx_PbXai+BO19HX-9S+A@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:41=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Could you try:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-writeback
>
> I think the patches there should fix it.

Confirmed. I have merged this branch on top of 6.12.1, and the problem
no longer occurs. Thanks!

Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C531EBFF7
	for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769847489; cv=pass; b=bPpA/oMEsF6yUlNZ3AzYQ4jglvCve1feP2wCXuWOJJ94ydvCzNPmd6arnnQeiCRGrJawdlf4Pogc5XRDNh0a9AuThTnFHtW4NKTn4rj9d2jwnZsmFN0IQn2AvzlzBzNFqW8CKkZ50l1tkzMbkA24zmmKCU/t172od3FD16bpK6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769847489; c=relaxed/simple;
	bh=60qsLSBNqHOopC5OMglkxnWLEQmgwca3rl0WV0mEDv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwaSPhnsvhW5tJF1Gxpp/BYgBba719pH+HKC5whsF/3TrFUVq0mrUqLzwJ0nT+8toOs/Y2YAzBSU3GWL3alz3L5Z8752c2RCnE9navlkBYfuGvM3okDivRMeI6aV7oZ0GLrQIt6vuEP1CjE0alRY7+APLOv1L/Ei2QU//b27fNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BueCkNtY; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BueCkNtY"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso4233616a12.3
        for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 00:18:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769847486; cv=none;
        d=google.com; s=arc-20240605;
        b=Qso/VRd6xAf1Q3d5rCYZMWuAF6iEiMeqb3E9E6sDOjJvLTS5dor1rHGWknsauAyrHx
         JT1jFaLQB3jFGhi8UGtn/d4h0tC83Bh7a98EJqRZsVTbodlGt/cZYe9I+ENBbPaqb5e8
         vayt1dvh0e+SWkZwR8QMkRLn73pCf0iiI3rTpE18bVVxg9+870nsKiPF32qYyvcAtKvg
         FNVGKUiOesPYJOobkc7CxqrCHkFkvzLCgVOdKfy23Kd79JB0aUHS7egVvzXX7q66L1yN
         O36eyAibcymV/Dm/2bEMP9k0s5JUzb4MOLgl7nfR0bshME6Bo3+eMCyl+qkllKXz2C6A
         3C7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q30alRj8Wb8qXQ+y61l3KWAv3g1oNMl2F7PgQ4Yu32Y=;
        fh=77AaMocgol0POocV7KHU99FXw2+V/irst5WkKRf1noA=;
        b=DLixMHkwr61Sn/Mzjw8/vx2fCcuRFfgHIkgNSNghuBg8XJpXAOEWFTWjl1ychJHHeF
         GDNI0Xf2/L7mc585kpbtSrfUuxh0R+pYiK38SRQ+aapp9H91y5UsXUb8UFNITto2gbjx
         0Gwua1GnEyojleq2GlHBHFX1HwRkRGrG9xWqgAtBDL+lprdPbS4M5jNFqjlBWax8aB4F
         zs1C54kwZS+0LfVbHmBXww/hzXuwtV7BGS46GvUTnJ1Va04dnDrUmm/Xpz0db2eKjrFV
         Vw3aqulcWir3tVXEHWWntHaWTSTOZ2b0Rr6i/0+diR7rnXhmbjKoucUXyHSfLWmwbiA2
         PdZg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769847486; x=1770452286; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q30alRj8Wb8qXQ+y61l3KWAv3g1oNMl2F7PgQ4Yu32Y=;
        b=BueCkNtY4ivC2GJoCPu54O3KRXGO1uNE52E84R6TYD2bi/V8pAgPVG46zKjs/5Nw+A
         G8u1mRphbK3u8v6zvQFKibL5lrt0BKsB0BOut6RS4pP1f95o6DAAaCXyehSQ9KTYUb6i
         xVrWDZcjPlfJaHM9DvCL3Mi3MBYnZQyfelgBuEPSGjEv0uIuawBPgAhLSxBYGvBHkMU4
         enNnUgEqhzXAurjMUeEh9vcVndUfpY+QdwhVuqh6Lcmsbbi8z5Zfka1j7inoYvHNGzpT
         xzrNK/mq1s9QOniL+o9SSmxXH1rB1K/dVUKn3/Sm05Gr6YBu79JADPX8GcDyTRFjpvLP
         9QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769847486; x=1770452286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q30alRj8Wb8qXQ+y61l3KWAv3g1oNMl2F7PgQ4Yu32Y=;
        b=F1ySgrDDIeMc2+DuZThSXxBPKKP5io5/Cymvq129jJyGKnldLEcmkv6/JS8MsvqUvQ
         U5NpB1LLRErdzXHlR2H9DCAMeCd0iXOiqGN5ounJ1ITzIGGfbGhWQR/I7h73mGPa97fZ
         MNeTS6TRUTZbjr15+ys8/IZnc+UDUnzKqi+4RYviHidX0fAOewtqFnyIb8AtwtySDIop
         aw5b1GvNNQ88jprHpFUHIoML6TwY+Dy5F1/ZJH6tbNvzhYoy7vP//aJY5tcxtyDoHeUx
         QVnrsboP2BbkFK33aCHCAZbbtkLxiOClmfZSoIj5J/yMxWPv2gsRi4Uuneg7qhbO+xnT
         tq0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqWLj8EZPt+mRbOUueTO6Lqf5vfsJlBfFGIz2r2PpzrSFkTAL5BrKI2miioDtfXhGfcPhdYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIMGgyavcq1uDGboMqYc85pZSXjS5UD5Vl7IDQUv34qmbpv1k9
	Fy1hdQyPaG6h6YAlRKPl76rmZZJZssFk02Dy/lbmYFMucB9LeX+ErUc1e+5PGui6BQwfAz5hhBO
	Wq8LwkFFOaMLKGU7aa8IM2JGG+SeMFaU=
X-Gm-Gg: AZuq6aKcvavI9Vuk1RNk0SYZ6fkIsO5b64RxYs5Yx+beFKMizOG7/3pJiOE+PCUmm3N
	kfDbXyJMqzLWPC4yXU0Jwx1eQo8Z8hvDG1NupMwg0M4S2hVWBDwFkwZYfp38WWqefXLIN1iQEAq
	DfGgzcQhJ638il2WVnYU4wPXNgwG/aIGVugOIFE/YznP7kc3VRGXKra0WkI1ZTrR7QUp48ir5GV
	D/vkQ90J/b63AItNUYiie4azbS7vZvkclp2pHISK0xekTIySiS5TIoR4jZvTBxozsBrOdWmJIQF
	yezL
X-Received: by 2002:a17:907:d644:b0:b83:95ca:23e7 with SMTP id
 a640c23a62f3a-b8dff56f484mr300443366b.4.1769847486310; Sat, 31 Jan 2026
 00:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260129173725.887651-1-sprasad@microsoft.com>
 <20260129173725.887651-4-sprasad@microsoft.com> <2263956.1769780212@warthog.procyon.org.uk>
In-Reply-To: <2263956.1769780212@warthog.procyon.org.uk>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Sat, 31 Jan 2026 13:47:54 +0530
X-Gm-Features: AZwV_Qi6WWCLEpZ4y7hPAgndKU5UUwX1Nga2np48VplqWRbOm8FyUalkD5q3huM
Message-ID: <CANT5p=oL+tP5_SFNRabROCqDMjriXj5osnyyAjrMeq6BiJcr1Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] cifs: make retry logic in read/write path
 consistent with other paths
To: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.org, 
	bharathsm@microsoft.com, netfs@lists.linux.dev, 
	Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 7:06=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> nspmangalore@gmail.com wrote:
>
> > +     unsigned int                    retries;        /* number of retr=
ies so far */
>
> Is this redundant with netfs_io_subrequest::retry_count?  (This can be ch=
anged
> from u8 to unsigned int if it helps).  I suspect that there might be a fi=
ght
> over who gets to increment it, though.

This is mainly used to track the number of retransmissions from the
client (retrans mount option) when soft mounts are used.
I don't mind netfs doing it's own tracking (the purpose maybe
different from what is there here). I don't see a major issue if
they're not in sync with each other too.
So I'm okay with that.

>
> > +                             if (is_replayable_error(rc)) {
> > +                                     trace_netfs_sreq(&rdata->subreq, =
netfs_sreq_trace_io_req_submitted);
> > +                                     __set_bit(NETFS_SREQ_NEED_RETRY, =
&rdata->subreq.flags);
>
> You didn't see MID_RESPONSE_SUBMITTED, so I would pick a different trace =
value
> there.

That's a typo. Thanks for reviewing. Will fix it.

>
> David
>


--=20
Regards,
Shyam

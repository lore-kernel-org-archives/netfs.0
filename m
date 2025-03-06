Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CD20E31B
	for <netfs@lists.linux.dev>; Thu,  6 Mar 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267181; cv=none; b=MYwU6iLcplN/N0kM9Cijwubczq8auJ3pRKAd99UJ+kfMUkCd3zHNo8g8TLl06DFt4XHjFww34xGkq9wd5z2jivlQEprASOmm0meTh9T08j5xYgjopQZybTPwgU3C6X3oJI1dU7pGYzhyjzFaBWbpKSy+vwJSWP/o2NPEjvQ+DIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267181; c=relaxed/simple;
	bh=/UmRarJMMJ5YwDkxVjdSIsPu4GtiRgK/KoqehN6cnEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAJFxjPhMMftZ9BdQTH7ZOLmU5EuQyd6VkPgY0dQ1CIskw610YbkeBszUrUdYq9ptMT/TgBjDWxb1EPfZYZ0L9UleDy34UXsRzNaKuDguiz6yoxpZXyr8TVRC2VE1s9YuNk10lWNNeX6tR1jY+22vxaC0NGeNN2QbZ6UKTqRbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSuhOF+D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSuhOF+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741267178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UmRarJMMJ5YwDkxVjdSIsPu4GtiRgK/KoqehN6cnEI=;
	b=LSuhOF+D4oPYDnnWBmdnnYWQdck5dj42G3W6cIbLW5oEL1YKEqiAh7olHXtLrCPIkAS41D
	VhPXCmrWw40nWdYrq6u+QFuBxeG7qu0VMjjlUyW6WmfVXqoal9XiybLfILm7bGChjG4krg
	ienX8hDzSFmB/FqsjV5TXkP11ohktsw=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269--tv8Lo4UMF6RTFhr4-9lGw-1; Thu, 06 Mar 2025 08:19:35 -0500
X-MC-Unique: -tv8Lo4UMF6RTFhr4-9lGw-1
X-Mimecast-MFC-AGG-ID: -tv8Lo4UMF6RTFhr4-9lGw_1741267175
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-523a02ace1bso884947e0c.0
        for <netfs@lists.linux.dev>; Thu, 06 Mar 2025 05:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267175; x=1741871975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UmRarJMMJ5YwDkxVjdSIsPu4GtiRgK/KoqehN6cnEI=;
        b=OPdhUR6QxuF857a0cHdYJDXDezDar1Ux48IFWn7DYBCjxSM7+2Q6jIR9I/PBa9w5jy
         43FAcWAAQy3HSjAwiaooWFXFGtYs+uqmG3h8cmN+NwSZK+PaK7CnVWyedU0QaIofKq2p
         eU5R0ktcFZsAiJ3fd610+QWpo2F4ybuzboAxpbZJJh/xXEwEiM5zcRzddrF5aDf0Cdne
         kSJMe/AKs+dI1djspyTSXuaSbvNAoe66v9btSU4hQiNpiQwXDCBufjxFFpSt2J3T3Lqg
         J0VXnDQ9UUbtlDSUtEMO52lYK5rJQwOQJnaMezZhtn4boAIDInpaFO5c+TA/+3wBJ5cd
         PA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe9wlB2679/CuBxga3CUQGsDpGFHS21OellG4QXn6kAEnDL+/AgRYnemY9GTrg03qFyZaU+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNjSPG6lKT17AySI73e2pNjXwNwefrnX9H4RsEHzGg92/mm7hS
	lMXZ80oMP5cxcM/UieLWi5khI4/yjmqGGIkJEQp8zwSqtcveQUSnLyXtZ9UJqAVxI7Rf0zDL+f3
	FHp8A9bMstaFrHsFhCfAOcSEUfCsZuzCDZG2Tc4YTxTZWyHmLEXY5yGlZT8clcKZ8N/64VcoGqG
	/7heK3+Mn9pWSeOKXNLDFKO3ZPj+0=
X-Gm-Gg: ASbGncvZna8u299+jjhuzyeHN7nFtMjTIavkjD8YOuYHUlAumhoBKducd1OG8Sy0RSh
	bJM7a4Mu6THEWSZmuggWr357aXTcjLsP2ytEQFN6uk9++OfyG6B7y1xCZcIh5rdlxq5bEuUyh
X-Received: by 2002:a05:6122:2011:b0:520:5e9b:49b3 with SMTP id 71dfb90a1353d-523c614d999mr4605209e0c.3.1741267174869;
        Thu, 06 Mar 2025 05:19:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHLEtL0W98X3g+hM+4bHJAgb1OIWKIGaTCaPzhCsDaa/IpOXbx0OwPWffGYSed4LbV0sDemUiBGgJXdVEG/3w=
X-Received: by 2002:a05:6122:2011:b0:520:5e9b:49b3 with SMTP id
 71dfb90a1353d-523c614d999mr4605187e0c.3.1741267174635; Thu, 06 Mar 2025
 05:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com> <4177847.1741206158@warthog.procyon.org.uk>
In-Reply-To: <4177847.1741206158@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 6 Mar 2025 15:19:22 +0200
X-Gm-Features: AQ5f1Jo-1L5xeXHFhQa3Tt-48u5cZdpLKv9zx26z8y6mEFdAUXn0xGXyLS1FSA4
Message-ID: <CAO8a2SjC7EVW5VWCwVHMepXfYFtv9EqQhOuqDSLt9iuYzj7qEg@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Gregory Farnum <gfarnum@redhat.com>, Venky Shankar <vshankar@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1he9PxSqWNON88UtIbMtqm1gh0xrPZi_OSL437lDKiQ_1741267175
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, that won't work on sparc/parsic/alpha and mips.
Both the Block device server and the meta data server may return a
code 85 to a client's request.
Notice in this example that the rc value is taken from the request
struct which in turn was serialised from the network.

static void ceph_aio_complete_req(struct ceph_osd_request *req)
{
int rc =3D req->r_result;

On Wed, Mar 5, 2025 at 10:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Alex Markuze <amarkuze@redhat.com> wrote:
>
> > That's a good point, though there is no code on the client that can
> > generate this error, I'm not convinced that this error can't be
> > received from the OSD or the MDS. I would rather some MDS experts
> > chime in, before taking any drastic measures.
> >
> > + Greg, Venky, Patrik
>
> Note that the value of EOLDSNAPC is different on different arches, so it
> probably can't be simply cast from a network integer.
>
> David
>


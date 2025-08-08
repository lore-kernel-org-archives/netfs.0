Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B6199385
	for <netfs@lists.linux.dev>; Fri,  8 Aug 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675876; cv=none; b=ABKWsyeMCYCp8POdJjFWi7EW4sCRzBdcGLmgGI+J3jNMQsntwXEt2MAPz/bR5rnB5ARRwGdptyhhS6ZT+ITaT/JvVgSWK9KmQ9snq1QuHZmxenL/SIy0Ir3BMoNDWMeUiM4ESU48pUYodLVZWyHgC67nPAHpOZkwIR5pjconkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675876; c=relaxed/simple;
	bh=qWqV/cCg9Bg1mfVGpZAit/gBF2fPmoGWUXgNrlU0GJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAQGMDGO1CPUzYe7dg+0vzewDojh09Qr4EY4HKqt5ljVSloVTdxRqos5L18tis+68wSaGOT5G8A66WHNWtLZxP2JJGxs4e/CZVyLs8LkxDfHtzKur5NQ4lfE4ZNBEBxgSNcnIKXARLopC8BjOaE2/ecTMJZAxg9rWwTPFp90I3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxIyo6pk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxIyo6pk"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ba0f2f081so643e87.1
        for <netfs@lists.linux.dev>; Fri, 08 Aug 2025 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754675873; x=1755280673; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXaRHIxKHmo+v71n2kAA1c+fGSZPzmAH7E7N7+TC49Y=;
        b=hxIyo6pkuZOw2GEftpCRzNxytCWxJtXBHjqDTyzTYXdllG3BYb60Oic7tCzChoWdpf
         4u7SMtcShJ03LNorVclUmM2OnpSOTiqXgA7DA0UnicCwR7QX5qIee2mCTBFaam90dqsV
         eVvtLVKWr5vDlXRzOHy+dWssJfgwWmM1BoYPKxIdiMe2JflgM94KHM0Lk6tsflP8ZVlC
         lSVYblvPb13cnDewD+DKyPpNxNKXJ6hkWefiHCc7CFSxHZg/BwEq7m5yur6kP3Wb90Gh
         bdj0MMwOx2kz/hNuqEeYkgtJ/dnzQzOXTIICigN0RP1U2gp/8D9nldrOQWfcBP6ahoDN
         btOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754675873; x=1755280673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXaRHIxKHmo+v71n2kAA1c+fGSZPzmAH7E7N7+TC49Y=;
        b=A2gYZVzBP7VeiKn/MUcS9LoiiTzQ7lt+kgGcalE1+RhriFYpLCPf2Yn2FJ2Y3E24An
         VScifLtgU2ObPJMeM21s5Uh1XYmL9nn+9ScRZUrRoE8nG3F5Yqauv9fo3lHwMh0qJkix
         g1Y6MKZixR+6D7dbor1sCRgcXBqz0jfNN5YEm9dFI3aaXREy1CJoLP4oI8KJV6HtlxlK
         qi/xipLrJjx8Y6T5HbLYH6+b9AnHBeQhq81cwZJXqNYn3Oem47icO76AsvogUeCr9Cjf
         o2zN1uZpTyjY+qznZo8oNlopGSbvHJkQ522WvP44aSuOV5z4JBzZxSTxoUEwGiSGbmRz
         Usgw==
X-Forwarded-Encrypted: i=1; AJvYcCURBJKwwznuMlv12LnWf1uQsH7B8NyXfBmsYXjMN1u+cjS8lGHd/aNP8f8VV8KhGiHKEEIhxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvoSIHIhHRBev/kWMvjUhic8JApMjTREmzqEammQN7bsD4ZepB
	9qCtXMQ+pHe4oX7789SMObGD+DndzwpxaJmyW18qTRBZ7WpoY6Op4HksIAsErIDF6S9ColER1VK
	EPc9eSVtnorPvdflNchYAVR7gq0HGm0x95bGQ8vKZ
X-Gm-Gg: ASbGncuw+mE5TpkImNCCJ4AiAoi63hp5C5gEtckeNgXVLC2b+iBdW4NKXGVHuC0Er6d
	SZ+lvJd+5cP2koiq0QHsqvycIF026PBhTmJCdlZXg75DNgGWUK5SbBgMPq0Zw/3zj/cQZKJdvvJ
	WUhBKjV+MZsF/oSh4RUnRNaGVkR5ErurcJ1Yfa4AIEYDTwXYmVtLw0ovV4jWIC3uOSQV+vgi2dO
	aL7IpFIt8RM4RnjJOyL646E8mDABMF4LKw=
X-Google-Smtp-Source: AGHT+IHH/Bdfwpdrye1XnlPV3h9HpFB1/06JHSyWIEdcjNIJ0rmEv5ndWkpAOlHZcLVkI6FjX6YHe5vd+NN3G3A6EIU=
X-Received: by 2002:a05:6512:3683:b0:55b:5e26:ed7b with SMTP id
 2adb3069b0e04-55cc77c7fafmr13830e87.0.1754675872884; Fri, 08 Aug 2025
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2869548.1754658999@warthog.procyon.org.uk>
In-Reply-To: <2869548.1754658999@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Aug 2025 10:57:40 -0700
X-Gm-Features: Ac12FXxXcgcstidfh2aNH0PAqgqSvM--1mzTOrN4RVQkgf4ePB5KwUufWkqhH1w
Message-ID: <CAHS8izN89j9deyODUjxQroKrLoiAq1kF+RVowuvVecmg4tNAUg@mail.gmail.com>
Subject: Re: Network filesystems and netmem
To: David Howells <dhowells@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: willy@infradead.org, hch@infradead.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Byungchul Park <byungchul@sk.com>, netfs@lists.linux.dev, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 6:16=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Mina,
>
> Apologies for not keeping up with the stuff I proposed, but I had to go a=
nd do
> a load of bugfixing.  Anyway, that gave me time to think about the netmem
> allocator and how *that* may be something network filesystems can make us=
e of.
> I particularly like the way it can do DMA/IOMMU mapping in bulk (at least=
, if
> I understand it aright).
>

What are you referring to as the netmem allocator? Is it the page_pool
in net/core/page_pool.c? That one can indeed alloc in bulk via
alloc_pages_bulk_node, but then just loops over them to do DMA mapping
individually. It does allow you to fragment a piece of dma-mapped
memory via page_pool_fragment_netmem though. Probably that's what
you're referring to.

I have had an ambition to reuse the netmem_ref infra we recently
developed to upgrade the page_pool such that it actually allocs a
hugepage and maps it once and reuses shards of that chunk, but never
got around to implementing that.

> So what I'm thinking of is changing the network filesystems - at least th=
e
> ones I can - from using kmalloc() to allocate memory for protocol fragmen=
ts to
> using the netmem allocator.  However, I think this might need to be
> parameterisable by:
>
>  (1) The socket.  We might want to group allocations relating to the same
>      socket or destined to route through the same NIC together.
>
>  (2) The destination address.  Again, we might need to group by NIC.  For=
 TCP
>      sockets, this likely doesn't matter as a connected TCP socket alread=
y
>      knows this, but for a UDP socket, you can set that in sendmsg() (and
>      indeed AF_RXRPC does just that).
>

the page_pool model groups memory by NIC (struct netdev), not socket
or destination address. It may be feasible to extend it to be
per-socket, but I don't immediately understand what that entails
exactly. The page_pool uses the netdev for dma-mapping, i'm not sure
what it would use the socket or destination address for (unless it's
to grab the netdev :P).

>  (3) The lifetime.  On a crude level, I would provide a hint flag that
>      indicates whether it may be retained for some time (e.g. rxrpc DATA
>      packets or TCP data) or whether the data is something we aren't goin=
g to
>      retain (e.g. rxrpc ACK packets) as we might want to group these
>      differently.
>

Today the page_pool doesn't really care how long you hold onto the mem
allocated from it. It kinda has to, because the mem goes to different
sockets ,and some of these sockets are used by applications that will
read the memory and free it immediately, and some sockets may not be
read for a while (or leaked from the userspace entirely - eek). AFAIU
the page_pool lets you hold onto any mem you

> So what I'm thinking of is creating a net core API that looks something l=
ike:
>
>         #define NETMEM_HINT_UNRETAINED 0x1
>         void *netmem_alloc(struct socket *sock, size_t len, unsigned int =
hints);
>         void *netmem_free(void *mem);
>
> though I'm tempted to make it:
>
>         int netmem_alloc(struct socket *sock, size_t len, unsigned int hi=
nts,
>                          struct bio_vec *bv);
>         void netmem_free(struct bio_vec *bv);
>
> to accommodate Christoph's plans for the future of bio_vec.
>

Honestly the subject of whether to extend the page_pool or implement a
new allocator kinda comes up every once in a while.

The key issue is that the page_pool has quite strict benchmarks for
how fast it does recycling, see
tools/testing/selftests/net/bench/page_pool/. Changes that don't
introduce overhead to the fast-path could be accomodated, I think. I
don't know how the maintainers are going to feel about extending its
uses even further. It took a bit of convincing to get the zerocopy
memory provider stuff in as-is :D

--=20
Thanks,
Mina

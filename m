Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244628B7F9
	for <netfs@lists.linux.dev>; Fri,  8 Aug 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695720; cv=none; b=GHbjfjgLLteFslHuevfT3NI1bOGCTORrY4EdHimpS5sL89In99sIedTQripgG01FLd33SXD/Srd5IM/FIWVyB7N037njxFa+MmK0uEpktwdzUH6mQkMzv5TLPGiDWQhaNMs13ipi+YTNlYN2ZhIXClsfyDE0y1q4Znaff05F5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695720; c=relaxed/simple;
	bh=vUytq915rflhnGC0E7wPq7cgARuQAeoXoFWbIqg4MQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX6TOofganjbZU5iYVREKrBs7IbITdsLVm5C2380Ic7E4+zHkaHRYJjwico0rZhKX2KSKlZX8jBCivfMc+W/sJ2ntUO5CcjTSIwkzaNteGXECgRvrJKTOZrju9oohmr6KCw21PMoignwj2NXH/VEWy+X8QgxrGaunymezd5mzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHTuVnx5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHTuVnx5"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55cc866f01dso1386e87.1
        for <netfs@lists.linux.dev>; Fri, 08 Aug 2025 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754695717; x=1755300517; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+d20oXyWLn5bjTnK6D4tXgCVrsEi/H5G9og2EbOp+8=;
        b=WHTuVnx55upU48+4kk1BN94kST8Jm4KtMOecvkHxxRfZ/BxCo7/mLX8XAjk8i1YS2+
         J4on26K/XjAbei6jkXECdiGJFhKNZ3WrGdpMSprTbFn5IVLgY2YjdOfesaW/JFEie7oX
         Y23xWwb5/LlJ2Ymr+gZrE+yzCwaN8dQJJli5AuG8YmVeg+jpyxnGAFdZ06KleRP4FE7W
         +aA1FjwhaNAGDCutgk+xYAzdI1NFks+MC5qkbTJu4tKjvfVe9vXeGzXg6a2TEYbDCwWL
         Qo6X/Aq2pTF7Ny83KCkrpXHDj4IE2yKetts2deG7ou8SeNbYf+f3T9M64iV3UdzTfoBA
         m/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754695717; x=1755300517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+d20oXyWLn5bjTnK6D4tXgCVrsEi/H5G9og2EbOp+8=;
        b=pHeW+x/OK+tEatMr1GgJdwKciQI1DGZUl1Nv2wB685Nnl5E20GQFvOooZs3Eu8SkKK
         JC3LXik61GLBP6rgBZcnpkzTwtHqCiHxvWyyK0PyenqIIXR/bPsVDNcimhEfm66vxc/5
         JpZDQpNtuNUgKaepLF82ZoCkeojbWbKF6ClSm2l3/hWp02eYx1SwX2hp1pC2DEJHno/a
         LsNY1g8PHtczcDtNM1r7UUzBfm/R4goflcms2cecN3zNM/clsG3hDyVg79tAnyeNLZYQ
         E7K0Wp0A5oHmQLPZjR/eSKBRhBqy+dcnCuoiqLSbWiB0Km43GCIchBbJucDtfdPVgaeq
         am+w==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1wibNSZmUJt5JGDiqfuqTAYjG2kA8kC1F4QDY9nb58Dgj4H8TV0aAMZXXdqVbIH3O74H6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLPN6a1qAbkv3UonpUpruyjJeGPvtG5fJp3Uwq/vt1ZHD7LM8j
	6Hwz6oxDSbKXV9YI4VIL4BqlB3uyjFfihaKhF5pKz0h5tiDy3Zq4Sneb6J3q98S7ztnjTEb2nkT
	herKyCrNibkhTQVKpMfK0khL6egzUy5h3P4BxXH1b
X-Gm-Gg: ASbGncvzCU0GXTB26x0rv8P0V8QRoAWfOupeolecMY3UQ6vnjsf61tOAVBwl96RWj2e
	0dB2ahL5CrcnVI2sL5+THX4TLV+NSKGZwTKpqLimjAV1GdmpE6URF1k3RfZRc9GZloN0GnhX/Ld
	Yngi6ogqONtkEqycMkS0eJ804ZNcKnv8d74Wyuux51VPzwCCJmJuISXq4hfYAHR2MsyYt6PhIIp
	QQEu/bQrol2syycdVUK+r4Q2WMLty9lOo67dEUP5+3y78SD
X-Google-Smtp-Source: AGHT+IEdv1w7QaR/0N5fORVsH+DJ9deVF62A3/i1e5So5KwiAuzIy0EDfzma97+kI6RU9BDDGv1QEy9xGRRRodJA/0Y=
X-Received: by 2002:a05:6512:1145:b0:55b:af38:41db with SMTP id
 2adb3069b0e04-55cc89c7bbcmr60515e87.7.1754695716156; Fri, 08 Aug 2025
 16:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2869548.1754658999@warthog.procyon.org.uk> <CAHS8izN89j9deyODUjxQroKrLoiAq1kF+RVowuvVecmg4tNAUg@mail.gmail.com>
 <2941083.1754684186@warthog.procyon.org.uk>
In-Reply-To: <2941083.1754684186@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Aug 2025 16:28:23 -0700
X-Gm-Features: Ac12FXyPh-Jfeqe4_Ia59zNE4ggMPY6p0Hb0AzjzpPYfgU0oYp45vqpTmqQE3_w
Message-ID: <CAHS8izOj3OCD6+6GD9foc53J7u9o6-VK+YS-1RUWU4NR6d-9bQ@mail.gmail.com>
Subject: Re: Network filesystems and netmem
To: David Howells <dhowells@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, willy@infradead.org, 
	hch@infradead.org, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Byungchul Park <byungchul@sk.com>, netfs@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 1:16=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Mina Almasry <almasrymina@google.com> wrote:
>
> > >  (1) The socket.  We might want to group allocations relating to the =
same
> > >      socket or destined to route through the same NIC together.
> > >
> > >  (2) The destination address.  Again, we might need to group by NIC. =
 For TCP
> > >      sockets, this likely doesn't matter as a connected TCP socket al=
ready
> > >      knows this, but for a UDP socket, you can set that in sendmsg() =
(and
> > >      indeed AF_RXRPC does just that).
> > >
> >
> > the page_pool model groups memory by NIC (struct netdev), not socket
> > or destination address. It may be feasible to extend it to be
> > per-socket, but I don't immediately understand what that entails
> > exactly. The page_pool uses the netdev for dma-mapping, i'm not sure
> > what it would use the socket or destination address for (unless it's
> > to grab the netdev :P).
>
> Yeah - but the network filesystem doesn't necessarily know anything about=
 what
> NIC would be used... but a connected TCP socket surely does.  Likewise, a=
 UDP
> socket has to perform an address lookup to find the destination/route and=
 thus
> the NIC.
>
> So, basically all three, the socket, the address and the flag would be hi=
nts,
> possibly unused for now.
>
> > Today the page_pool doesn't really care how long you hold onto the mem
> > allocated from it.
>
> It's not so much whether the page pool cares how long we hold on to the m=
em,
> but for a fragment allocator we want to group things together of similar
> lifetime as we don't get to reuse the page until all the things in it hav=
e
> been released.
>
> And if we're doing bulk DMA/IOMMU mapping, we also potentially have a sec=
ond
> constraint: an IOMMU TLB entry may be keyed for a particular device.
>
> > Honestly the subject of whether to extend the page_pool or implement a
> > new allocator kinda comes up every once in a while.
>
> Do we actually use the netmem page pools only for receiving?  If that's t=
he
> case, then do I need to be managing this myself?  Providing my own fragme=
nt
> allocator that handles bulk DMA mapping, that is.  I'd prefer to use an
> existing one if I can.
>

Yes we only use page_pools for receiving at the moment. Some
discussion around using the page_pool for normal TX networking
happened in the past, but I can't find the thread.

I'm unsure what it would take to make it some-tx-path compatible off
the top of my head. At the very least, the page_pool at the moment has
some dependency/logic on napi-id that it may get from the driver, that
may need to be factored out. See all the places we touch pool->p.napi
in page_pool.c and other files. Or, like you said, you may want your
own fragment allocator, if wrestling the page_pool to do what you want
is too cumbersome.

--=20
Thanks,
Mina

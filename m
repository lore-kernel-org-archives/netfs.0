Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2923A9
	for <netfs@lists.linux.dev>; Thu,  6 Mar 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269329; cv=none; b=KI8RLJojuDP55MCfD0+LlmKtSbBXVO1WURtX9lxGWVNwyL11yc2DrBzp2ynI0K+4VWlT6jgUY8BQj5eowfnCVqtMnKVjIH4JgxLlYfXxHOcI7FmZPV2EmlHlGBKlLUgTsc+9rGviid4RE13UJuOkpQPTm21EfWemveEfj3/IuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269329; c=relaxed/simple;
	bh=e4dIS6uRGrNz4cNFNpjtZYbdKDDxOseAZRayz8xAZGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsfDylWvtFCnIWZ6PxoXs1G+xNTEEyvGtmcjFhomaAi3ZOVn2z0wGjuCKGhvglVYGytIf/GM+kfYT5sim+sK0WKQonWLSssLtQCYt9rkeuUNIVkW1KW7AwjbPnpKoRthQVZD1V8OP0Pw+TL3yapO5p93uDsmNveISnUq8KhoGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Geq+twKJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Geq+twKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741269326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4dIS6uRGrNz4cNFNpjtZYbdKDDxOseAZRayz8xAZGs=;
	b=Geq+twKJxPJn63PMp3/H7Z97bMi9ZakXlz9UO0VXPKXKK0H69u8C6H/JVtAWZ2/XuFoeM6
	DeKh4opC7A38K1DBHRDzW1qKSQrMdGckFS5amiIlVnUV1+FrX/fIRb5idhKCIpjVhfkdDd
	+RCBq/+TH2FmACWmDrya1BCU8cfdcGU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-peGCmptrOKK1KtL1R33atQ-1; Thu, 06 Mar 2025 08:55:25 -0500
X-MC-Unique: peGCmptrOKK1KtL1R33atQ-1
X-Mimecast-MFC-AGG-ID: peGCmptrOKK1KtL1R33atQ_1741269324
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-523a02ace17so998494e0c.0
        for <netfs@lists.linux.dev>; Thu, 06 Mar 2025 05:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269324; x=1741874124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4dIS6uRGrNz4cNFNpjtZYbdKDDxOseAZRayz8xAZGs=;
        b=coomaYQN6yNmLEXY17ipnSlvw3MZhCc0h1Uz8DBXrO7xpKvDjyrHtqvYuwJL/c4nOX
         3YuvF06dFPieLKxx2NNR2hgzCFrsT+mZVb9jjTzAQbcENZOrnekTNm1IrifNMpMxVlEc
         UfEUYvDqBjedMJV0X1Ee986Ie4ADx0gdycrGWkak6lYP+KeITAbz4lE44ULyHZhnZcr4
         V5NqhZMmjEHXx+Jq0IQfGN49RIVcsjshoOdzI4iWWP0DRSD0gaQTCUv2jnjpqE0kiVyW
         R3q41AH3mUBTVw51JNcD+CE7unuZbF51py6a2TwENa3du26TE/baxn9fW+Mw4slU6pKA
         Gy5g==
X-Forwarded-Encrypted: i=1; AJvYcCUGX3jNVJvLmjvFtVPGlglkWcs8MmLWraj+IyOH1VI8ylQEyHC2DOJPlb9JQRquUUHFoU56bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxITUbqWoWmXP4Na/JDUtQ5h+KYfh1JHLLnhU4K9boRdhzW9cUE
	YJh+rKi4PUEK5UhxCkOvd8jNaFvv5a2/lFPqyMdxhxqLTfrKw7pvnEbllTTr0umI7hrClj18W2S
	9h3AqP9a3su22dLvsN9i8Ra5cDAoSt4vOrJzrN3+mxJ0WBn2JN7MeUWEEnHOdi2+3Oo9nkXOvvj
	2X5hq+hGeV6dx9IFKP9HeKcy+dthY=
X-Gm-Gg: ASbGncsKX+2b39Ky7Qji7PKX4hvdkvCNFqM+6wqXNSMundHiXnUujGeqAUiO7k9dB+t
	sIM0z2qPCapA9bbI0PetbYhaMspU74+B0YeVZRY5WTLPmOdFp97QRn772Nof8GC8gDV5UtDGg
X-Received: by 2002:a05:6122:311d:b0:520:8a22:8ea5 with SMTP id 71dfb90a1353d-523c62d0b59mr4131933e0c.11.1741269324518;
        Thu, 06 Mar 2025 05:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTTtFaQhbGWpFrtu91D+m0udH4MOo8rOp9CuZE6mF/YlW49JAX1pbPGdZ/JS2Fbm94bLdqsM0Q1gDbgqI9T6Q=
X-Received: by 2002:a05:6122:311d:b0:520:8a22:8ea5 with SMTP id
 71dfb90a1353d-523c62d0b59mr4131927e0c.11.1741269324263; Thu, 06 Mar 2025
 05:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
 <4177847.1741206158@warthog.procyon.org.uk> <CAO8a2SjC7EVW5VWCwVHMepXfYFtv9EqQhOuqDSLt9iuYzj7qEg@mail.gmail.com>
 <127230.1741268910@warthog.procyon.org.uk>
In-Reply-To: <127230.1741268910@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 6 Mar 2025 15:55:13 +0200
X-Gm-Features: AQ5f1JpnxGdeKrhKSz9blMqZa5LrOlpVW18iGxm4IojQwEugdRw4hShfJAhqRKI
Message-ID: <CAO8a2SiCLxrLMFx94Au2X47fiTwBhW=6YZrfC8O4D5G0x+VRjQ@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Gregory Farnum <gfarnum@redhat.com>, Venky Shankar <vshankar@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bMmTdHFQb8iTImAX6uI0H1UBkwXaRDVFMsQ3pOubI18_1741269324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's just one example, presumably any request that is serailsed from
the network may contain this error code.
Specifically the ser/des of the messages happens in net/ceph
(libcephfs) code and fs/ceph handles the fs logic.

On Thu, Mar 6, 2025 at 3:48=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Alex Markuze <amarkuze@redhat.com> wrote:
>
> > Yes, that won't work on sparc/parsic/alpha and mips.
> > Both the Block device server and the meta data server may return a
> > code 85 to a client's request.
> > Notice in this example that the rc value is taken from the request
> > struct which in turn was serialised from the network.
> >
> > static void ceph_aio_complete_req(struct ceph_osd_request *req)
> > {
> > int rc =3D req->r_result;
>
> The term "ewww" springs to mind :-)
>
> Does that mean that EOLDSNAPC can arrive by this function?
>
> David
>


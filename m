Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377A322A3F;
	Mon, 18 Aug 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525709; cv=none; b=Jm2yamjwCXDfF1Bn6JimnXLwxAwQQIVLxJ4sKVQ7f4fBPNW7XpjeLoOO85x+aPhV3L3UCtYaf7lXJ5FjYN61BJL/pxLOC/2sHhys5+zvbq7brGGxHB4VB+exz2bqdhxEmIuc5lXoYkJ11Jv/GkDg5ql37ecKjFE6FaFWgsxZj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525709; c=relaxed/simple;
	bh=y2Nw6yRVcmnnk3DER/vCk4B9KctzAxdvSFV70vMgIxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoQqatGmn/Cwsb1OFWn7xy3OexBOFOdtFF5P5ckXes+Z+xRMirvAM6Vt4YhhdKOFd+R+jCOD+Nrv0inMh3tHtVwghi/d4weDf0Rt6mQtAjDb3G2z+qktLfVBO0c0AovQ22EH7DTzZqr02xLzAKhUWeKpM35Yoa694avpd8rn88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX0kH8J3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX0kH8J3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00a65fso20706055e9.0;
        Mon, 18 Aug 2025 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755525706; x=1756130506; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7aSm/eI7kfLNdmsL2BItZGDfjAkMGxOsO5FNkHNx+Y=;
        b=fX0kH8J3/RtjHDdQzydEMy2K9LGSijVc5ROaUFUrruXX/8GKSPaZeiUBVnCzQOo3Yt
         os8RJM6qXbHMZ27ZJrXwvUIxFcbqnchY2RWiLxlBmSKhuRHFJc9YkeC2/qv0/A9jiY0D
         GBKfZVmZQIJi7wtfMVSRcezBbqBFG1pnhrNLAx0SED0aLVHPTSKY/8VnFUlhgNK0y8jG
         9l/RT9kJRcatd5lMELaFPy8Np5j2FQuCvnSEq4T4rA4aXC/5puv2IlE277kCvyGQVokD
         u5ruLr4xIxTNLDfLIOobMsGnwvR+wW63om3tFSttq8FlB0Hj1pTsDHldZZAZ/8AuZKpS
         nFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525706; x=1756130506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7aSm/eI7kfLNdmsL2BItZGDfjAkMGxOsO5FNkHNx+Y=;
        b=sW7e0igh/tdnx9NPva3f1mEkOrR1FfxDrEh2G4q7/OYy5Z10bY4u79brFKuvhC5BiO
         Xg3GtT3qlxcRcv8plM4D2Z0KjXN8NBeAQde+KMe8WgAmLQDkUTY0k3sWvn6HhaqsI0pN
         bI6tZOBlDMDyW2POeeHWqoMJR+FDVMk8b56C6bvNLqUyS06Wztwq3989b+IRVAkJkwSC
         bVGZyZfU1XC+cV7e+jBt1/KTSCSa4kNoJXt6CT7yx17zkApO+6YYW33kwf9Prq/YHnXy
         AtSUNHe8gpE5L475vMnQ169oQvsk8qg35DwJox4shR8m3OmP/VltPmoLKT1QXXOcR2d8
         Wrxg==
X-Forwarded-Encrypted: i=1; AJvYcCUyw1JnWhepyrXobu4CtPrchrH7AUW0rC4fq6y8nVIEFJmzwMh7oTtan+zISwRtVtLaWtuqcg==@lists.linux.dev, AJvYcCW+bCyE1tIGI/Hr73Mbw/soIDLBJyXgCOBkhDxDR7ksLv3hjRv3VRzI+yJogK3QEci6CZBpYckpReacF4o=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDADa2pDMucPd62Q7J/K9fbj0uydsjlGlDGypAYm4n69Jt1gwJ
	GzXGXsKQskAmRAm0D6Fdt8NEjh+VItFXSFVaFN6IBnVfzP8Ovn45iI3s0Pf7g4EfOYQ=
X-Gm-Gg: ASbGnct+4ZMs3nyoahTZPB1Ni39ZTMoiuQi8Ehs0cj7VPO6Hd06v+7IuKAGsVl2SQmc
	TWxnGH1moTS6zAaNxJJ903vU1PvHGsgGscofOVwYT9j6WsLxj9rTUbH2PJJJjskzF6zoZ9dN1WK
	j2HNMZc3MvwfQW1Sjc1PZZWeo6dcad6Kg9CXNVUk4f36+6Ow3L8bBiT+cuZCFR+ke1SC0UzUczO
	UbwtzYdgRIjo8Cd+RN83MdMiZksJ6RgiKdHsGhDJbGB1NONF4LhLlrJ2suXafoF5oP1cLK20ciV
	Rt+la151e30Rr5QCPTb2K0D26nuVijCSmc+A48ntUdUhw9bvwN7l88j7YsdCinxvWf/n7f4qrVL
	Uh/ILbeS3FNMgBrOCaxRZscR7icIi4RdY+ggOtj12FVRmp9CLIjIKcm4=
X-Google-Smtp-Source: AGHT+IHo1jNpqNRhxvdXmyRhn4pc2gYVNGj28wCYI+06cBtWEKoBFRZ4/BiPgAXoKdGQaE5FzdBuhg==
X-Received: by 2002:a05:600c:190e:b0:458:bc3f:6a7b with SMTP id 5b1f17b1804b1-45a21859692mr91052485e9.18.1755525705541;
        Mon, 18 Aug 2025 07:01:45 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23323c56sm70600845e9.9.2025.08.18.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:01:44 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E4231BE2DE0; Mon, 18 Aug 2025 16:01:42 +0200 (CEST)
Date: Mon, 18 Aug 2025 16:01:42 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Benoit Panizzon <benoit.panizzon@imp.ch>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benoit Panizzon <bp@imp.ch>, 1111455@bugs.debian.org,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [bp@imp.ch: Bug#1111455: linux-image-6.12.41+deb13-amd64: kernel
 BUG at fs/netfs/read_collect.c:316 netfs: Can't donate prior to front]
Message-ID: <aKMyRpQig9j1M8gF@eldamar.lan>
References: <aKMdIgkSWw9koCPC@eldamar.lan>
 <20250818151814.18d5dcd4@go.imp.ch>
 <20250818152409.2d2db023@go.imp.ch>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818152409.2d2db023@go.imp.ch>

Hi,

On Mon, Aug 18, 2025 at 03:24:09PM +0200, Benoit Panizzon wrote:
> Hi
> 
> May be related:
> https://security-tracker.debian.org/tracker/CVE-2025-21988

This *might* be a different issue. We had the metadata wrong in the
security-tracker in Debian.

The mentioned commit was specific to 6.13.y and 6.12.y and for 6.12.y
it landed already in v6.12.20 as 62b9ad7e52d4 ("fs/netfs/read_collect:
add to next->prev_donated"). 

Regards,
Salvatore

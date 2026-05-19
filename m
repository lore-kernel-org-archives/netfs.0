Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864F25A2A4
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152083; cv=none; b=quQD3IIDk84jhfijrykhY+rixP5FyAYgnAAliRACdyiWkf6kOo7IBCO7d30Ra2TQdpZiqTAb+t3/qOHGVsLm3IYg8HozlmdC27ZuPEUicL2YsJJcq43Vg5kyRWCghSXLtfO/fH+H2lEPad0c6BvH42Lp2GZmMXoVWDG8Cic3K7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152083; c=relaxed/simple;
	bh=lSja7ZbOLuuM+tCrgRWCxBG/Huz3q30x9CbuMKnrvBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUJkxm8i5oXC/+sl54ENJZhmM/6FZrJnPKQaO1VPt3X+i6DStyZVXpkN1zri+JIGZJgwK7o3JUYO3eqryFQgZTZ+EJp/E5P6j358hzZbW0gQwh/+/umQIuFyldikz450LfSs6fcP4u9avml5VcML9MUi93DrmXWWXaI5LG0a8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1IN7I9M; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1IN7I9M"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd11a3729e8so493721166b.0
        for <netfs@lists.linux.dev>; Mon, 18 May 2026 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779152080; x=1779756880; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CP8YOlMTq6wrxw+7ONW3izZGo2Gu6xGgxSrk4HzA858=;
        b=N1IN7I9MLLadHAFpQ43wxMIhcSa5VWbOQFkPpCOccXD9ktWsYIJMS0rgkmBlnq4upJ
         Qq3McH1ckoE0LeQkUQTFGloSmt9ySoTC0mv1bRml+dYivgs726wIgJoGx75gyShoo06D
         yTqS6kq1L12cB6UEA+tA3RJJ4lnq5cL/KSEm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152080; x=1779756880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP8YOlMTq6wrxw+7ONW3izZGo2Gu6xGgxSrk4HzA858=;
        b=PdoR8K+o+r0jfoRd0eqs71n3IwnoSoUbWeCX9tQKxY8byaMV0EaTty4wlgau5eSCVD
         WDsIy/03UafCqzGIwMH9khBQvcPTrFMPVB6314yBAzwdD4wSLog5VdSPt5zBfYbrdTzB
         0GD/y/XQfVCaAFAU3wX0yoZENcWWdwoa0ok8I9aywJGkIaCpcb3fD3DByYx8tV2Ss+Uc
         hqE0UOTWpo1usYbhFoUKqT+9D151g/5j60r3o3HNIOED3EOIVENrAXxzq5awzr9cE/9J
         YSDmWpPqmEQvusx0ZKaW+p3vMDyjHIC2rXmZgXKxhxkTeCo4P+HVet/wSNyOfMDPvv3m
         QbCQ==
X-Forwarded-Encrypted: i=1; AFNElJ80A5RASVQg6GfDlvHUPaIrS6Yj3n3k6bfW0gQpDBtMaTk/DqmqC+MofisEf2Qp4OsBGNjXTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ9UCYBRhDTDzg8aVs1EJYe6BylrKXvBbONZCQDWrMAvOxN2Di
	KRBMmUO54gmDRkU7XmnAKexoQ2Sxi6+WA4ynn2lSaEFiQkrmPq3AIVpkt71HJ3zNn2GC1dgPDUu
	4xhNQls4=
X-Gm-Gg: Acq92OHl70M9C7p0GK1TSTIHrAPGEDHKcVQTe3p26SWDxPjrBi3xK27joHt9FtyYt3Z
	vqGkc8jF+G79rt8d8lnlyE3nLODSvKwpD1Rgq2c/jMqsHdeQMfyvRWqMzD8Zfgk/QJUIW2D8TJK
	l81R8NFDWHBc85GCNvhN6VupoGDTvDPrY2sbWFhA+Zdug7w+T0lgOqbXnXoHbOuOssM2hkXapmy
	mx3vm/4Piy3Pz9hhLbpqua/KugDlBDUEcIw3VzscN+CaoQ2RnqVK/UjJPi/7d3NDHSbjC/K3UgT
	wjSQGPMmxSwWcHFMEg377K+IJ8SB/qfFr0KPb3i0zPat/7da7TDXwMsXPf+USy7Dam44A1EC3gk
	TJ6Fo3OgzDGoR9cqpQis9n0iN0Yws7urzSrgTafEtl7y/d7Yg3bsPeMX10esr+HvGy09XqfqXl9
	01j2pofs8Q8Li9qwxd0N1LnnU1uatXWL3vm5bsgFttrZQTkvfHJ0jnp985bTvZ05tRg8lwOM70
X-Received: by 2002:a17:906:6a01:b0:bbe:384e:4c4d with SMTP id a640c23a62f3a-bd5177ee4e7mr948869366b.14.1779152080314;
        Mon, 18 May 2026 17:54:40 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c2a68dsm643163366b.18.2026.05.18.17.54.39
        for <netfs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 17:54:39 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so5181894a12.2
        for <netfs@lists.linux.dev>; Mon, 18 May 2026 17:54:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+HLBCFxE+rVALeNRq5L0O9hI7EOrco9gabpunTOXljlCegSQsJPAJhpcBND7hyvrIiVSN4sQ==@lists.linux.dev
X-Received: by 2002:a05:6402:a204:20b0:674:74bf:8813 with SMTP id
 4fb4d7f45d1cf-683bd28e6a2mr6610808a12.21.1779152079390; Mon, 18 May 2026
 17:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <413536.1779138789@warthog.procyon.org.uk>
In-Reply-To: <413536.1779138789@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 May 2026 17:54:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf32qPV86aShAgdqyBBNogwtsHzTD0_EvS-E5hqqOmVg@mail.gmail.com>
X-Gm-Features: AVHnY4KUQimu0k87RSyMxbO9S8Svq-BAbgZL8GTzoxNq4QpYl0eT4JDtoHR9hKI
Message-ID: <CAHk-=wjf32qPV86aShAgdqyBBNogwtsHzTD0_EvS-E5hqqOmVg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix undefined variables
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Nathan Chancellor <nathan@kernel.org>, 
	kernel test robot <lkp@intel.com>, Paulo Alcantara <pc@manguebit.org>, Matthew Wilcox <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 May 2026 at 14:13, David Howells <dhowells@redhat.com> wrote:
>
> Fix a couple of undefined variables introduced by the patch to fix tearing
> on ->remote_i_size and ->zero_point.

Applied directly.

              Linus

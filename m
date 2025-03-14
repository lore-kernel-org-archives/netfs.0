Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6A158870
	for <netfs@lists.linux.dev>; Fri, 14 Mar 2025 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937748; cv=none; b=Q2BdpaateTHF33xIcd8mwUd691SRHbOto/caOEUCqkmpPJ/GvLa6m9NUAEiq07l15n8ebe8M6KS07ku3OvC0RUXCwEPO1e74BuWzURz5eDk91C5EzFX22OAk+Lws4gQWzbp8yHHqlexUwy2y+qR5MtKJhPhlr2YFQhc2+3Zu7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937748; c=relaxed/simple;
	bh=BKb0+8vbrDMdWpSZOZ73KCKfNl8XpBBpEuDQ9z5rALw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e5BHvFFpnubPlBmhsosOBVuvD2u1t5GI+wcjcxUj8959oTuqedqr6VzSB2c1X12NC3C1eB2BtI+T0q1EfB5HNVjKBNWj3QeW2UrEPER6tzf7WAOUHs17K0zWba7apsjrElV7zLrDQxHVTn8/Ru1BWtFQHW8kZ2Jls0HRSf+oJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IlU8rp0H; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IlU8rp0H"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so337395366b.3
        for <netfs@lists.linux.dev>; Fri, 14 Mar 2025 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1741937744; x=1742542544; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlmZlv3M6KwRa5lk0ty8uEbkHF2GhMIuGONmyl2bBXA=;
        b=IlU8rp0HV/Y8srWNLJkPpXUhtFIG+f3FHDqYuBpxkPzWU1cMEunKWZajsmfySjulDU
         PHwxOOBEmQnTvtiUtfw2G19jiJDqpgsVX8QEm+Z91q7wzvBTXPNDIStZZmBY0LDWuWEs
         TbKSYAKnonI4mQJRLOrx9zqMLcLqu2whR1DE+BIOtoaFA0faItDsRm49WVcXsASs0tfI
         FvWkvjVCoz1jtnBSY0yFsoqBOB7YdstZCqNN7csB2DmYYPRkS6D6vBjTFkepoFDJjnYa
         un4E+YYaaMoDOg0xwBmlJCx39kJK5oRD0s5lM5OAY1u+TbqTMceKWz0aKYMX9wOyj0uP
         y7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741937744; x=1742542544;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlmZlv3M6KwRa5lk0ty8uEbkHF2GhMIuGONmyl2bBXA=;
        b=W7bP31ZuwnL91ngc7Tyxwi5LeD68OL6aaTr2Nnoek8QbVFtHixNpVCfUl90Vgmbbnc
         BrsLCr7zpOA7paY5NJya/0Pv29lk5nXtyWxEIdgolgfunw/f7rJEcia+DWUYX0MvT3p2
         Fg2kSJgvo/2DJl317x8OmvzD1XAkciYUQYCq5ZIbwJQN+/RcBNl/LJ3HLzQmla3aMaBl
         L14JvbKMG3kfgtGNU24SlRHufrNEu4zb3Fl6CmEVAhCawbIBrDIE5sxyGXEhS6Ylu2gO
         m8bcEgaTbCVgHKQ2WOKNzkVBqxOezaLed0xQu+ecqFglZRUjGq4oABMsv/CHZpvh3xSE
         SWAw==
X-Forwarded-Encrypted: i=1; AJvYcCWxKo2ruGDxcFFsD8nV60Ckj9t8q1pLw36b66+WTGThTqzISQsNqm6mDcq9Lr4R6Ub/V5sBHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEbl0uGV7u5duPM7SSJCxoPaKjfi66qwKqT6tVWQ866cRGS757
	CORiWGPSAf+3mv7zzsSubw3nPyFHsznXVUbKf0cGm/fbAZZ3G2DZNFVd2G4LxRnpd3fnyVSDgn4
	WZo23PL9XhwFc5kZkBpiVsiaRnZEq46Ha36aj+A==
X-Gm-Gg: ASbGncu/l7r6NI6Jiu1e7JyMfnMxLLhNfRh9bvqIYQjdUDZwbrMNXRQ5bwbwMezEXSE
	l02uBuWrV7XnAgRWP9mhbW5LYgSzam4jy4YkaHCPoaPDWJ6988lj3ECDGUEOORyIF/Pg7Fbf9fR
	322d9gOQyqodOQoYRc2jE03ldhpW8dEI1BizzcNRLwpSg4uMX5F63vtFo=
X-Google-Smtp-Source: AGHT+IE7Xaa46SPAaXON+whlmQwGK4hrFPmRNmw/cKo9nkMuQI2CfRhnfIk0Y82sVcmMcd8X/iKP//nfd54dSp/6HqQ=
X-Received: by 2002:a17:907:2dac:b0:abf:7b38:7e64 with SMTP id
 a640c23a62f3a-ac330396bccmr157332166b.43.1741937744629; Fri, 14 Mar 2025
 00:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250228123602.2140459-1-max.kellermann@ionos.com>
In-Reply-To: <20250228123602.2140459-1-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Mar 2025 08:35:33 +0100
X-Gm-Features: AQ5f1Jpirsc84DWFiXiiJv-4Da16R-ZlTaCwBS8wuRISQWEDlmmeBRkTXeg9pmA
Message-ID: <CAKPOu+8XzPixswU9srF=DK=MkE9tUhHtVxAwwA-xq=NAo9Ljjw@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/write_collect: call `invalidate_cache` only if implemented
To: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:36=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Many filesystems such as NFS and Ceph do not implement the
> `invalidate_cache` method.  On those filesystems, if writing to the
> cache (`NETFS_WRITE_TO_CACHE`) fails for some reason, the kernel
> crashes like this:

David, it's been more than two weeks - please don't forget this patch.
It's yet another netfs crash bug fix.

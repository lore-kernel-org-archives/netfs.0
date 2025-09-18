Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6427280B
	for <netfs@lists.linux.dev>; Thu, 18 Sep 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170612; cv=none; b=igeHtAYndpWFnHyxMAvk7HCY+vL2TIff/UaqCjWAc8qIiSLPhaS7/Wo1tHaQGBzVX9Ien7QqOtmg/l65z3VFbLhIXHyBUEhLmgoDiAKgI4pxqCCmehNmAsCPj2keMJGosiN3tPLz2LCGGW/ZTpJXkMa+zEG2LMxm0wDjNWQgT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170612; c=relaxed/simple;
	bh=bvQKqbZUHSmC9Cgyqlv2yW20y6m1kbKZ+PzcmlxuJdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTlhG/4RNaQ2gdFD8Ss611UMbMmVtAmDEn0D6V08ccgD26YU/cmcJcZpHtCUfNPvd2AMeASu8KpRa8ihcrZ97nyMM/Z8mQgJvXKaLf1pzzZ+D8Exqt2LofBL6f9M7Eu81pB5G6o17hTx0myDQzspE9JZ1zvMfdjWP0L5krK/ERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dsOXW9go; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dsOXW9go"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso67200066b.1
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 21:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758170607; x=1758775407; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=dsOXW9goOVdjNWVYGSlvj44q1xn+pgPY2oIQTkKNgF4uMKiEuUePREVGYxCuuxEk+6
         OPGBXvskW3OeacuHfuMaPmKPY2ilPtGROnn2NZKRH8D1Fv6OLjbacIqcXI035PDtpgVk
         Ldhqbg7uhQ4fnaLv54ep/DaOI3aXGtBYEtDMFNbMUgfnisJcJEWwUQkpy/fz5kC4FQKE
         GCFFO7S7I0j3DRknnGWYCjloQFtc/6j0vJYrrL/FzBh2+otjc9IwsjhxJrQqrmba7LOw
         R9HTKqYMzw/KpguzEPJ4tPmkb+WIfMAVqy+Bnr8uYDNtOGKWQqeHlypdXvh2d8TU57Sg
         fE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170607; x=1758775407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=ZudQ8izDaMBC0MiXI36+CaecW56H74c5FTjG2l2lV5BRf+DK0WHStFJDPsG7VkC9sP
         cj8cVCDl3P8qu5UweUrVz6L7qXxYVifvVACtZQpQgiBCahnsi/oRTsgZM8v5xuFP3DjW
         HKGLigV5sHWHawZXMzxr+m+K9KOWmqcnQ79AXnufOqCDpCzodhdJ0KTU0m7qmn2JTQlM
         Owb9Euj+1+o3ZoELypeTp1k/YWs582fVxnHfYOeutrTfEwGBbz7lnYxdHH7NpYj2AFY1
         QuJqquu27z0gFrONS+beYgM5TUgQbED594j+eMtVfL9Igx1f+p6zub1FATCFDBz1nBfO
         oU7A==
X-Forwarded-Encrypted: i=1; AJvYcCUSQkAxnOyS0bk0Bp/HRYqzdz622Z9LMTT65NFbY79oonOYNIRKigwsul7tbC5w1Meqw3EVfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlMYObne57v6Dq+S4rZB7NhIYno6QLLeMxKRaWB8wfe5yio4ok
	pvHDvAu6ylRvCXFr4VQt/73+D9R6l5JoqTHoo2dwlPfUaYRdWilSpamFWOPNWW/uPvAmC65Ss9A
	kCoEXvAw/5S8FxEeg9M1rnjvo8ReDtaClH4G4d0MvRQ==
X-Gm-Gg: ASbGncvmXbH97NqjBlCqYAy2lPLDZzKZRgmzXSfP5FewYXvD+QuDRXGaXCgkd61SlPA
	Dwhn4Y1DEg2E6svuPCZfPzVAIOf9EiejTTz6bZQytJtmmeLHoj9baqFZ7SRUUcjzbwxH5Sj9Zwm
	VFLLBmhX7X3lMhtl3zu7Vsv+wHaMqQSnnk+D81vqEs2HefyGenHmv+ZQq7PSENmAaDXeoLL6dem
	HLWAexPVYK89AcMdy39cALgUvQpY5tSVHROn0wM6gtQfdxeEv77mDk=
X-Google-Smtp-Source: AGHT+IFdanVNfWfNv8HWsgTltRUqGbgVYdYb/7YWgH/k9KVu04DfDvwoBsaR56HasWl+Vm1bcuV82HMzZ0TGHEI2ctM=
X-Received: by 2002:a17:906:4fca:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-b1bb17c9028mr565217566b.12.1758170607385; Wed, 17 Sep 2025
 21:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <aMs7WYubsgGrcSXB@dread.disaster.area>
In-Reply-To: <aMs7WYubsgGrcSXB@dread.disaster.area>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 18 Sep 2025 06:43:15 +0200
X-Gm-Features: AS18NWC_NdTi_yqxzEjcc4DGgSbWqBjqdGn8xuCbd_fnQdBXhfAk81_WXjHssKE
Message-ID: <CAKPOu+9io3n=PzwFPPgmGSE0moe3KDbyp7MXmwx=xU=Hsvqrvw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> - wait for Josef to finish his inode refcount rework patchset that
>   gets rid of this whole "writeback doesn't hold an inode reference"
>   problem that is the root cause of this the deadlock.

No, it is necessary to have a minimal fix that is eligible for stable backp=
orts.

Of course, my patch is a kludge; this problem is much larger and a
general, global solution should be preferred. But my patch is minimal,
easy to understand, doesn't add overhead and piggybacks on an existing
Ceph feature (per-inode work) that is considered mature and stable.
It can be backported easily to 6.12 and 6.6 (with minor conflicts due
to renamed netfs functions in adjacent lines).

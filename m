Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB401D5141
	for <netfs@lists.linux.dev>; Wed,  7 May 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632920; cv=none; b=NfCEPPzYYt5UUKBg7yGfeMPWOgv+b4pW+E+LFNr1y84VtwGDefNYRLT3czyw6GGqT718DCj+DdhOQrxe2poweJn0B3GrGG3RSkYO55UT9lO2tdz1Q9xT5saCQO4mbOZWhKW9vlmvUDYDI42NKrGjz+nuzYeHQI0BmFHJ/zz9sXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632920; c=relaxed/simple;
	bh=RmNN38IOqGOxQw3vAObUst92tVyWxds+Q/EvUHM6Nys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k/VhK3u5mAQWBEftV+l9kYaB0AihPKkqtc3ZjkMK8EYD/WP6QH1X3pyaWnw95KowfGvQ2t6MKJG3na6E7vuQj5aODfWDnf3UoRR/dr+gBUNaD0aODjuZvxrlybCheqVgfZv4zqr3YN05wQMJSz6h9odUWzeCsAY9Pp98xc959Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=S98mxF6+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="S98mxF6+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2963dc379so1036352266b.2
        for <netfs@lists.linux.dev>; Wed, 07 May 2025 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746632916; x=1747237716; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmNN38IOqGOxQw3vAObUst92tVyWxds+Q/EvUHM6Nys=;
        b=S98mxF6+4Cbt8Km8TniH/mfT4C8oNv3TIOCSugRu3olNOdPJ6WzuK4ZaqzgE8o5/1I
         1v1A1k9j6vPdlKvtklI3yF9A+RvODejuBG/81TUtoa8otNz/Jfj7Lgn3GI8p/5uR2epm
         KFYkJA4G+0nQHfZl0bd43uoDqUrZjzOBDbtCiQ6Snk/4dE7gYTsbFU5eqi3qvxBiPqV6
         tEc2rJDOBs/XKsTR3PxxP0xCgvhg094fzwe8ATXfpyC9CGTsVZhMcmWoZWNmrQYuSlYD
         or+P7MWROXHqJAARQzjvEP5xJHGeiIOfYqmgNNIWvueu0DOS4QbT6fzxHus+4KvbX2aK
         xwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632916; x=1747237716;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmNN38IOqGOxQw3vAObUst92tVyWxds+Q/EvUHM6Nys=;
        b=WW/ZPBB4tNVnOdLr/RZIvBS7uP4XCyHy813pcoXypiLbA0gp5MKBFVXLZmtrRwaE8B
         a3knzKh3eAo0Dxa0Vi7YcVm2AJjbP9syEVRr9SwdjEprnyjr3lZGmvEPgV9TbphomCcm
         mFXdvRH1F6MBPYnqpN1TsDNO3jMnYxGZgwrEBwDxLWsKIigyYj+tVT/KHhgFr0HeMa2Q
         Bs1wfE84pDIBfTyPGHCq61J3X9OMQOc20lRKl8SQ/pk927rk4G2KIJCFhz6C44t5VWMZ
         uG81at1MKW5o+9zkjtDyvEMU6v+vB/eSondOmbvL5xjjWsBQuG8FzGkfJQDdAVifQckM
         mxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmYazFc02mcehJ6tfgo+6vUMDaHZao/i5lHdfosKDwC/9wVR9pDCiCuHa81keuI8aoTGIPWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyASBRgXwB1HQcq4M1dnbe17J6k/dQCRaF0MeiNiwF5J5nrC25y
	u7iUfZirc+R9jWEkK7bvmhWpqj0YmxNiyQMDUg60dpj+Gaig7T5QAAb0CQCzqtpZy/x0Fe5o80Z
	AQjFNoXS9MeZfehHA5ojq7APUKwhGvP3gqGw/Yg==
X-Gm-Gg: ASbGncthH7DUtwJtuerkpIijd+6Jt8oIWbzzSF5L9ZLHqxtloroifuF9dhjMIRf+YBU
	p8r42vYgvEMstr8skBtzE5Lgd/oAoUfhUeSgWQix26G39XmpGTF9SLoGQbYraGaNmrscX2Yiskr
	LPHj+wrKEW9ftyQISHfh8I5YRKkt0m9rrQjE8w8LZyD2s3GXKPnHEMHzm/0AsCyA==
X-Google-Smtp-Source: AGHT+IEAltjxdalh/5XKuPwAg0pv1b4lg33oCEm/9+0ThGBN1Qpg5xKiNbvqIrHXaTlQhgG7QhMV/i8ffK6cBVRnyqw=
X-Received: by 2002:a17:907:874e:b0:ace:cb59:6c4d with SMTP id
 a640c23a62f3a-ad1e8d545eemr366290466b.43.1746632916020; Wed, 07 May 2025
 08:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250428154859.3228933-1-max.kellermann@ionos.com> <202505071602.yJrZsTiu-lkp@intel.com>
In-Reply-To: <202505071602.yJrZsTiu-lkp@intel.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 7 May 2025 17:48:24 +0200
X-Gm-Features: ATxdqUHZtrIZ4qATIqCPYmFI3WbE7fVjUqBiwmJIjt8Br1WsR1D-K7F_EFAuSc0
Message-ID: <CAKPOu+-y6vng-hc7HN=+0U0cuEZCWm-BuYC3GOGGTwJHrJMDjw@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/netfs: convert `netfs_io_request.error` to a `short
To: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 11:01=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:

> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [fs/netfs/netfs.ko=
] undefined!

Okay, not all architectures support cmpxchg() with a short. I can drop
this patch, but I'm curious why netfs_read_to_pagecache() uses
cmpxchg() when everybody else simply assigns the value. Maybe, if
cmpxchg() turns out to be unnecessary, we can keep this patch? David,
can you explain? You added it in commit ee4cdf7ba857a ("netfs: Speed
up buffered reading").

Max

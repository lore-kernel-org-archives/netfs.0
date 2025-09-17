Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1631A7E9
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116395; cv=none; b=f5ZSF9AyaWmMAJYNFViS6WZ3o4s7wQHMkC9zsHuZSvimUPYcuvXxerr/F2zHic8hBKuU3h7KivusqpGtTvSToiID0/eQj6/Ak0gkWES7wJxTA7/fApE9bN/UqbiY3l1B65FTYbeeLCVSLle55A4BCYXTVh6kMsYgrceeN/QgiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116395; c=relaxed/simple;
	bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYe8JUGejL1dSSIGcPlCxo+2x9bvd21E0ZlskC+wwRY6UCSt3uRPPmtaGD5byHqBmgFoL6ZOCQuiA709gJrOplEIEYO1tWjosVegLqX2qacDp6MR92LYplJ3Zncv5ZeNQwHXwo0MDdCrbMC8/zQ+H8arYVcvA0gPaQf1rt7WWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HmCCjK6y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HmCCjK6y"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0428b537e5so912962666b.3
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758116392; x=1758721192; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=HmCCjK6yE1PIdu9Uboumeu9NREnZaFBk7h/50wOeOgbwJQMIqrGVJ9JTaIhaXrWALh
         j4sTqXtrbBX2x23hBF11z47PBKNYQ1jjIo7RnCVzdBtgrSACtD+djsbX90NZzBWj0/9B
         ZeLXMzVXpISJhFkusqiYiy20SXA84I3w1Ic2UQoTQUsmux2kinSTmIPqdiYLqLKPFgFi
         g+LyzVIJJQmcA/shxFNl4w/wBDrqhYcUlJAyhSVbnzESBMh8DnA0huFZ7+9woYMIGmYE
         /mqt0vSGfM26azCBChbqNrhUvM4UFoab9UIvpsuUmNHxSAzZ8YxeWP++0RuE5DV17o8F
         GS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116392; x=1758721192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=EDElhLwhqQN7wBi3WkxVn6xgW/ce7inS1OIiKktPPwe4mTsd3b5E+SO7b5ZEX+Rfza
         630+Ee+sFc4XVqSQjXXjVUkt7N59jBvzJBf+4oQrlW6d1X5o7cdvtttlk25u9CakwimW
         VumnO6SMB79y7ppQG3+nLSqe22MFhEmZJYOM7WfcgZ6iiylQxBqdCs0UpyeAKeEavJKA
         CMv5WN20HmIOlnKsnpM67KEmExNaF+hL46qjU8jksUR/sErYtvDDseZgnH4t6KQ+IRGZ
         ebi6g/KfnC0yzwRdxNXWB3v481mii5OHBCo358AIzeZqcRP6GLDMujKJY4RLvA/Z4Ozl
         bQFg==
X-Forwarded-Encrypted: i=1; AJvYcCWuPExITL0vcpX/0yWHyWeyz+pEhmHZ4RqrJcGXZlvkoU1qvU339Pt2qelMaIDjoL92zc/MJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvG4ESk5pb5mf+kiHJh5B+FocK39Nljln2pe3x8kLSeQWgRIdF
	/AAZm8XQz2H+qibG83jvuWj86kfjVRZL1mVwBTT4VN1+WSGHY4ccqgxPk9lwEOb0DN1fxQkcnCC
	W17kHRHPfvl9gZ8gbd4c4MS9cM1IRUFmXYDNSMVaP+A==
X-Gm-Gg: ASbGncs9VSpt42+AUkzrChp8l0fAZomwZXo/MMkR5J0F2YoQbkssoFSGdd4cJt3S4W4
	Gb17N2uRS2aE0p8bUZoHPU9neWgdt/uQovZ22v7pgiKWKkqO+mUmu2+4CRUTMsKfcKcFl5jbn+g
	cviH0Q5qSv44bjXwsIlbKZLCJaLneh2vddKF4415fN3Cd+mNUKfkqE0lQrSUZKKf29sL9uTzAKH
	kDVYOuAqtadgla4a7gyhcRmltIIpWiKS4qF
X-Google-Smtp-Source: AGHT+IGqqKefXP8WxcN/+l1jwy9unDcdcYQ+LOIaW5Cks3BIj9V+aI0trws7o6JbFaSx8xHpY7sjGGzFBBSJONjxZms=
X-Received: by 2002:a17:907:9687:b0:aff:9906:e452 with SMTP id
 a640c23a62f3a-b1bbb0678f2mr302885666b.31.1758116390548; Wed, 17 Sep 2025
 06:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:39:39 +0200
X-Gm-Features: AS18NWCdr6GqUOQd4v8IrrCyA7jXtDhoQx-mp5NUMtPzl5TNlq5K2XQ23QjAEV8
Message-ID: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Does the patch convert literally all iput calls within ceph into the
> async variant? I would be worried that mandatory deferral of literally
> all final iputs may be a regression from perf standpoint.

(Forgot to reply to this part)
No, I changed just the ones that are called from Writeback+Messenger.

I don't think this affects performance at all. It almost never happens
that the last reference gets dropped by somebody other than dcache
(which only happens under memory pressure).
It was very difficult to reproduce this bug:
- "echo 2 >drop_caches" in a loop
- a kernel patch that adds msleep() to several functions
- another kernel patch that allows me to disconnect the Ceph server via ioc=
tl
The latter was to free inode references that are held by Ceph caps.
For this deadlock to occur, all references other than
writeback/messenger must be gone already.
(It did happen on our production servers, crashing all of them a few
days ago causing a major service outage, but apparently in all these
years we're the first ones to observe this deadlock bug.)

(I don't know the iput() ordering on umount/shutdown - that might be
worth a closer look.)

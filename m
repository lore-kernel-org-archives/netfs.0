Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDC1E231F
	for <netfs@lists.linux.dev>; Tue,  7 Jan 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247531; cv=none; b=OpJD1gP900EYvgTyLjdF9/bunK538gTQOWKLnUsuorj2le0+oXysIpJQxHNkkuscZaHKX2WmVze5fzq7uj5u4QAXLmXMKSFA2GtRp0gEBswEews9D9qoOhB88IMEVj6Ba+2Ba/IG6y02ybgzbpGodfl0CnUdjcSjHnX2NuGsKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247531; c=relaxed/simple;
	bh=r9cba/X2LZ+xXzIfLu11VdFcsGQUaqpTLxJ+TPcAd0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHttpOHS8c2E9IFkLlbloLx0NKLj+abELuNA3+Im7WfBcORADAOmsfbSmJZnaUaiKNC8lZeZr7ACN2489hndRoESo1naAxhaEZYBK3Ye0n5EEvZ+psAGNPpy8GVjH4kjxvvxlW0sLolxUh3RYQ7INSgSLsqZ6FeCkkMFv96Scgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OIxZBfEd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OIxZBfEd"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa67f31a858so2773842166b.2
        for <netfs@lists.linux.dev>; Tue, 07 Jan 2025 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1736247528; x=1736852328; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9cba/X2LZ+xXzIfLu11VdFcsGQUaqpTLxJ+TPcAd0U=;
        b=OIxZBfEd+OIWKMFIz7tNXGnc524pjiiZjlFRR3Hj6ReP+gq7F16gGNBBf1h3Vk/hpB
         Vf9p/4IsiPLc4lu8zSP46ved0QrbcbyopTSmahzeJb1DiWgNJ6iOe6aZP295lHmgMik2
         CMKz/1AkkxWgLfuwm6R3rXh2jyu1QSVs19HOeRVSwxdJDIIaCLv+9G/SJtZI3j5BQuRN
         TPaU8B5J/7tMyWNuKGf4XJCsY/e3iuGwJ7kkGscB7aco+c66vSkIUvZJq2KU3zP6DUoO
         Y35u3pTGTlNyI64sFNA+K86oUZFTos7wpGtvE0y4OF5X76C73QZLaAOY7Uy2cY4ums9y
         AnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247528; x=1736852328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9cba/X2LZ+xXzIfLu11VdFcsGQUaqpTLxJ+TPcAd0U=;
        b=LCkF8yzfSLP+Rdsq2cgBljUBiq1KijBzegqG32gMVKfU5sPGO949cuh9wWV0Ymgydc
         UCJ8Y3OuAeMAaz4b2/zIt1PolN4kvYREH5z0gpTWbO/EF+Cxk1OeXs2Glm36fowhCe5G
         t+StZGwGBwEj4jVPXavnWUY+d22f7Ws1QUxdkhBluZr+ESfZcx4ocbknSclF69jYhwv/
         r95DxyYQ5fB89h23vTovPeZh7V4AhAYD1hdf71uGDzEarSgywzsz/sR6Y/J7fZU3aotk
         nsNE9ZPLaoqBF1Ho6G/KWz3mJT/8pcc4+augJqQ7BUCHV2S9xCPs44e6Ege5Iibpziq/
         0qAg==
X-Forwarded-Encrypted: i=1; AJvYcCU+HsHMXVv0lNCOtU/927/YbVtsxpoOHIEd2Jr00YJ+qxd5x9Tfm7uAxqB2P4n2XsR2mW2srQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUS88D+sIevmjLwAiRQ6ERXyppu52VD5bWGeo0OLLJYoTONSMI
	MZu2p0qb6DcqEgre3MpCCixXPsByV5g0EMUQV53LLBR34chrzVAI5PzmC/vI7QqRT6p/YJXCpze
	DJxkXt5v0hstEvzV16JlrJhwNeIYW3nDvuNDcog==
X-Gm-Gg: ASbGncu5GNOUk7sku1Vn/lUQCMmyq0afsQQmxhTg1MWPIHniLbcUaa0QjbRHUKnl8cp
	JNVuMtFWYVPRKhaiM8+TB7TW8lzXBSeflzenJIpNUzEHir9H3B7JSL116gf55E8RcT+4=
X-Google-Smtp-Source: AGHT+IETZOmNG/e0pTEpYkVhrwGsLepWld2hp3oIZEoqxA3MiEDxyRVbckh1TvXsfUQviSS2Bg03tqiW0zDp2s9kgt8=
X-Received: by 2002:a17:907:1c10:b0:aab:eefd:4ceb with SMTP id
 a640c23a62f3a-aac27025de5mr5732340766b.10.1736247528011; Tue, 07 Jan 2025
 02:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
 <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
 <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
 <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com>
 <2117977.1733750054@warthog.procyon.org.uk> <CAKPOu+-Bpds7-Ocb-tBMs1==YzVhhx01+FaiokiGR3A-W9t_gQ@mail.gmail.com>
 <2787700.1734019232@warthog.procyon.org.uk>
In-Reply-To: <2787700.1734019232@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 7 Jan 2025 11:58:37 +0100
Message-ID: <CAKPOu+-O4NVRO-oEsSv_GG__q5tdC-X8zPUnLkJ+9iDaVp_UyA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix ceph copy to cache on write-begin
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:00=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> How about if you add the attached?

Still no change, first try led to hang, as always.

(Sorry for the late reply, I was offline on vacation)

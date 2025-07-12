Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169115E5BB
	for <netfs@lists.linux.dev>; Sat, 12 Jul 2025 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752297923; cv=none; b=K+nddA+/y9x1O/UXkgRdqcjMZqqLf/AkdQFafxJeeO9zLfufGsP6WMxhk0kQ/WtaVnEhLDmYUM5QX+26QZs4hCW15tLOJx3YQ1v4G80XAlZ9v/4PYQU2dbPzV0Fj2uk1NU/m8WFkSzwFIoakbqYcVI5iS0y1z6x/oWDs8n78Cwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752297923; c=relaxed/simple;
	bh=OzWsfRdh2rEvxUhB0pK+C5jZ3YphBuaX/nfPDWir2oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Upxog+7axXkf+ZPXmNeh0supo3JCTXmI+8OgdVmSEr/K1KrPdqXxTyp3FKNRDwpBB85WHxtrDn8Y987ukimK/YbsYiyo50jsDKBKd/o4C3A3Rz5nrtrIX74lGg+WrlbougEy39tJAZHMiP/Ip8zDf6Ic5hXNF52U6FCdbbNhLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CrJITZw7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CrJITZw7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0de1c378fso435372466b.3
        for <netfs@lists.linux.dev>; Fri, 11 Jul 2025 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752297919; x=1752902719; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=CrJITZw7MSRptEY9hZObN/NgYNAOzg+/tGgFrTVuOHCCo0omuXCg8ajkq07CMONzs5
         jmdIhCXUv7QTiG1MhFTC75uFPrCWPICYhbFsNbz0biZIw0OSqPYyf8jkS0KqP8pZZi7a
         Q2QL/q5uy7v32EPCQ/XKIdMFUt/D20XFVVUDwshI26NvMYKsq6lbGpGql06a1++n3JjY
         djd7pWHahJNUo22Ydug+FrBEbxw9O3f6Arcw1+IvGCviWBZUHVkaJlh2wjtuTkhCNroJ
         Efl65TY1/4SamhwH31VcW5meSP0D4GNgAzZ0OQ9UhQUnexfQwtfoPZE99HW9rYdYC/uS
         c6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752297919; x=1752902719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=ElB8yc26gL6GHxWoPyU6BYmH/F9pZ4nNyLfFAJRxuPvoYMojOFY077eMDBetRan+qN
         mtV7yV6oN49pEIc7hLiO20UAl75O/lxnyw3HcQgJXd9gSiItVT7NAcfIfyCk3WsEVsvE
         X7s3vgYPMjq7lHdUiCLD7RuWszk0PGu59u9+ZJU5ZYzR7j/n/iYGBEoN0reFiv2hu+l/
         VyUD3Z/sT3pPOT7ipsL8//xWY0JJ4tE6HETZM8amzusF3jqAecYUJmekvF2wrl3JEMbb
         36d1BLPXR3F7/W6upUWcKTH+/4WYUqXM97YFKt9q7md4PtkhqLVX4OUS60SuImUsedVV
         LZBA==
X-Forwarded-Encrypted: i=1; AJvYcCVHPBrL/QL+q6v/61TSA9RtItsevpRQ4yITaa+uLhJbZrFjuelo68H9ezffNbFoC+vkPKGyDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxM+cR5hO/rMp3+4hC8V6Sli3mlQfVVQnfSNsC0u5xz7OJEYmS
	ewbYI9RMScUHp99jLmaA24ZIE2HnPjx2P5tTiH4zKr6lyaGP3LFZKRRaIvYDdwfAK9sRH2hJFED
	LzTmZzbKckgbBCQ5mi74nvpictPLDhol5ehcPRV8naw==
X-Gm-Gg: ASbGncvSo7LLHNqepl0M7hERRkSNhtHM8ebEhqyXVsO3jNXJKIzt4v+k4d5UvZ14e4Y
	99pwVph3iIgVmpKvclEGzMUbMI7RCTea3kJZ7JaYZcp8eYxdHtGtPeRa4ILPMSHNb712cKPbZlW
	h6E7CWci8wQqLe13hTZOzCoiLQAJ6yOboMby3v9uhox7OeiJae6A2hyPici/C3wyBIaqUxOEqiZ
	erla50CmrGzSCvB7+3fx5Cm2HO+yBOF1yI=
X-Google-Smtp-Source: AGHT+IHRqhss1VHoNOeBE3dSH85TBdQyutMEzLaeevjSPISD0eb6jad4c18gV5T9kZxrzRKcHgf2BSQwMPB2TaBTj0c=
X-Received: by 2002:a17:906:fe05:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae6fbc9275emr580496666b.22.1752297919256; Fri, 11 Jul 2025
 22:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250711151005.2956810-1-dhowells@redhat.com> <20250711151005.2956810-2-dhowells@redhat.com>
In-Reply-To: <20250711151005.2956810-2-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 12 Jul 2025 07:25:08 +0200
X-Gm-Features: Ac12FXwI74XFtOm4i3YUfybrD81gXwe_XUMrlDA403K5FZ8k3_E2nvLf9lzB7zA
Message-ID: <CAKPOu+-Qsy0cr7XH1FsJbBxQpjmsK2swz-ptexaRvEM+oMGknA@mail.gmail.com>
Subject: Re: [PATCH 1/2] netfs: Fix copy-to-cache so that it performs
 collection with ceph+fscache
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 5:10=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> The netfs copy-to-cache that is used by Ceph with local caching sets up a
> new request to write data just read to the cache.  The request is started
> and then left to look after itself whilst the app continues.  The request
> gets notified by the backing fs upon completion of the async DIO write, b=
ut
> then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
> set - but the app isn't waiting there, and so the request just hangs.
>
> Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
> notification from the backing filesystem to put the collection onto a wor=
k
> queue instead.

Thanks David, you can add me as Tested-by if you want.

I can't test the other patch for the next two weeks (vacation). When
I'm back, I'll install both fixes on some heavily loaded production
machines - our clusters always shake out the worst in every piece of
code they run!

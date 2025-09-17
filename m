Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E7332A53
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116733; cv=none; b=D0I1Lg6wp9zH4o2hVtDUUp4r0lab4oVsimJpri7HfG8WQLTEeKJTc84eqwj+RnK22oFhG40gMo4iKex7gHFhe4xvwBMzBEcD1AQf5RGyawm4ftwZC6ToIEXGRdFyRmNZKyEEsapqRyOB5IuIEFJ98ForpKJgxD0/xh36XEDVccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116733; c=relaxed/simple;
	bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugkPCDBs0DwnPhSXfb4i8tvqKznWDnHTjNy/GPWA3Rl3km7SHy31uUoeyT2KbCSVyqV2zudfVIkRM0LEG2ajw7V1AIoZ7OcU0MJO5jUaQIUT9RfYr+wjBCSxcPl0HfGUGXCcGnoIY9R1r53yR6QeiibtJpjTKwxVO3r2+/Ro1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATIf/YmW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATIf/YmW"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso8277789a12.3
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116729; x=1758721529; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=ATIf/YmWGpSM6+NT4lRF7E/M/TUmcngZh3f9smSRzGSXjTtLZjJOzSRnWQBqEwtH2r
         UJz+2bOOFlkPtPFc9vFAmyzwaLbb6tVjJFG8dT+GtjVMa3KZQ1gkCkJOJwThlVFteJat
         tD6OJD0aRkE7zyJ6L6sogftM7nzeRmn+2lTUmfPLmk9T1t+Hy6ieMYdEcTzdRhwirJLH
         8B59ItCak8+cag0Xh/dhlM0oakpCX3ZGzP0WirFYC5QM1gGZHbJHEjbMz5SOiNDyqXIv
         MNNgWJm3YhOHYyNq8llIJ45Tml6UT8ZCCaQqrY5AMw/LeqRYJBUAyMWtU/6PSfACmZ/7
         hahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116729; x=1758721529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=DbdmC4Mp45glEXRzhqA91uVQaqNEBdH/UTx4Nprz1Z+YIr7wRlllqQudIOyEhPkvOA
         B5OB9N3NHiVMjEz/cjkWwLk3zAFnzZC6ewSsBpItHdF31cCRWYLGbbsL2wQIKdLV9twJ
         9Q6H6S9QTyvzUjbedHzJdJn+/d1ihNjl5XaGJ4tWlDRyVJR5tqhOf82J/YfL1g89zvD/
         ISHCp5k+5t5K+2FeX1vaQbi4GOMevZUR777yAH+byxj8gad0Wx1fCEWxjNxPTulx5EPj
         UgBS0be30AJa7YpvLTeuAmby/bpRY9ku0geL0xdqsq1TfXcQdOQnfb2KiznKj+rWrn7D
         eW+g==
X-Forwarded-Encrypted: i=1; AJvYcCUI195BHucLLm7iikNVTcy5c5pdZCmMN0GkDBNe90Q9K0hJKvJTbIhVH1C8ddnKibF3PdDNFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxjtMh2te8nxnxq+l3weI/klBIpARWj7RW8vc6Bj6X300F2J2r
	7olioGd8gASF8AzLJpLblOC0+GpISZhBpptgs38jW+KAVtyiGdkoV4dndMuuc6OAD/3H1SI9liA
	u51S+ERHuWRIC83JHyJ8MI77js/+HxEg=
X-Gm-Gg: ASbGncv9Eg+hKQs0k5qCWNeViCqofPSLeSa59CcZenoKYTqHljYfEP/t93EwPCSZJ9A
	oOgEU2uy1i6ir5l0d/00opq8WhvkiOjV7sz3g3gSozxC+bJXUgRSb2SudCdS//rsIMDiW3dlhpK
	/4Qr/N1pZWEZ370PlIYojZ/BmwznZ7Lx52vG66UGlxI7gAslQOsWEEtmqrxJ3+VnQOc2W78jxLC
	GEGffxgaZw/bZaaQOAS+AjpAXzCTyBZdLi4IvA+E99uRlRgRg==
X-Google-Smtp-Source: AGHT+IHJjSAqFzQR7vsvzpBHIle/SM7pkbfcfwBMTr+P1896d+alN/SQihemXVKbkiSRCNaNWJtZu6qP46KZEuNFGWc=
X-Received: by 2002:a17:907:3c8b:b0:b04:aadd:b8d7 with SMTP id
 a640c23a62f3a-b1bb5e56d85mr276690166b.13.1758116728681; Wed, 17 Sep 2025
 06:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com> <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
In-Reply-To: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:45:16 +0200
X-Gm-Features: AS18NWBMJGX1M7gmLnyGCZI8UTIw8c6hYUtKDGdB2cO4qtZ9mDWgO1MIhRf_XYA
Message-ID: <CAGudoHEhvNyQhHG516a6R+vz3b69d-5dCU=_8JpXdRdGnGsjew@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:39=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > Does the patch convert literally all iput calls within ceph into the
> > async variant? I would be worried that mandatory deferral of literally
> > all final iputs may be a regression from perf standpoint.
>

ok, in that case i have no further commentary

> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).

Well only changing the problematic consumers as opposed *everyone*
should be the end of it.

> (Forgot to reply to this part)
> No, I changed just the ones that are called from Writeback+Messenger.
>
> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).
> It was very difficult to reproduce this bug:
> - "echo 2 >drop_caches" in a loop
> - a kernel patch that adds msleep() to several functions
> - another kernel patch that allows me to disconnect the Ceph server via i=
octl
> The latter was to free inode references that are held by Ceph caps.
> For this deadlock to occur, all references other than
> writeback/messenger must be gone already.
> (It did happen on our production servers, crashing all of them a few
> days ago causing a major service outage, but apparently in all these
> years we're the first ones to observe this deadlock bug.)
>

This makes sense to me.

The VFS layer is hopefully going to get significantly better assert
coverage, so I expect this kind of trouble will be reported on without
having to actually run into it. Presumably including
yet-to-be-discovered deadlocks. ;)

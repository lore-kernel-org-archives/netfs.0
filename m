Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134031A07C
	for <netfs@lists.linux.dev>; Mon,  1 Dec 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613018; cv=none; b=kST3h5BUZJ+uhKzvF/YFDbQsT7/ZYzfSIDOYGRuEKsvpjVb5CyXzUtbOdDVF1RoDx11gf70ggZUaGGxa/Y1FEBZjEu4ZD1D2EfoqPCfySQjQ79wWSFCuRjF0IP+0AKovUFR7ptl/VMtkh5TwbgAp3OKN5vDTyIyCqXCAcvczPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613018; c=relaxed/simple;
	bh=ppk1uMVa5C3mwrdd8AKTnxZaLsInyOE9IJv+OBp9CEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgziBcCgbCuducd/fnPc6HKvOdDLdqxhAtYoqy98E3xIuuAfkAuo2rCOHtb+8nhEFnM1ItBA7PNIzXxyridoAsRH1DnABvNXpExkLbkPXyB3bggP/4z3ZsUbrUDukVdEYX9jgLkHmxlA6U/Bo8oGZnQHu1qHWaiMgfM8bnE1Beo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSHHEukd; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSHHEukd"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-882379c0b14so35756316d6.1
        for <netfs@lists.linux.dev>; Mon, 01 Dec 2025 10:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764613016; x=1765217816; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+ahSNRHAPTpSStGMQ+T6U8mmc9yGXaa07sdg/NiO2Y=;
        b=OSHHEukdsPr24eTpLPiX5vu71LfHF/hdmDcMzor/JwBBwIjknY9jh1Wxu6L24T9mn0
         Ab5qZrDvNAYHazeLRevjGVLWabw2mG1629QSriC6ty281QMI+d9fon4DYp1A6EuQTM3Q
         qpB8BzGf0GTJb5PZdVIZrP1RjizPy11aOD0s9UWoqFUlIze9vVx2KofuMh5oOyQGouoQ
         K6Sk23RGm3mZFzvfHj/eXrGPHP+r+Yg3BZvGJ+mGApfXMJNP5cEHBuvv5Q5DwEkrROFY
         NdEJmgVYuvBBBILVF8hMtk8MWwSrzR1QX5GfvwOn8Z+sF+hLaA0oKQ5UKsOwduKMnNws
         EPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764613016; x=1765217816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+ahSNRHAPTpSStGMQ+T6U8mmc9yGXaa07sdg/NiO2Y=;
        b=Pvk6ubYcdZi79mEsq5d15iYzHj5v6U87cQZiktxPFWMcAt3EpSWKbgfMfL+5/1L8yh
         YeeR2UzmPQOl84u+vxj64JhZWMzhH+m+c9a+Y7BSPKmNF0p/A+HOAoa/sw30C2L3PnV6
         6lU9kMStSm5c35ZkdoYo/j+yYcPEH4UBWeimqcPGIq1UX1xHWW0mYGhjcmm4647R9C3f
         Thfi0Lre01Cn6J6OPSVepZkvfU6s0kzp7vlC0fK5iYPLiPrUaE2HC+6Uq218Ih6yfgAV
         GlgfCfB74ZTxgXjXVHvsDACM1YRbKySRcktBqGiBWVfA+bzNhO00cqNNH2KoN86UaGmG
         c56A==
X-Forwarded-Encrypted: i=1; AJvYcCUEg+Ucw5B4Uk/zMLYyl4EPLEc/hTsmhqGheaqRw5S8zuHibT1/KZasoA7wI+bULZvXyMWUaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4dyL6MnuQOTm3n5GuAO2Tngryh4bDoZPoYgMKkxbRSpUBxHsl
	h2SDaqlNUXKOy+8barSi5ZrsFIgEI1kvBxHxx7NBehuMlEQYPqZhEtx54TmdyF4IDQwth4H+taD
	KJjVfPF3H8c0prhAXPzD77UgCaaHrJLo=
X-Gm-Gg: ASbGncsj4VhcsPOtbjWkVWlVjYkBQHOTkgKnLu0ABU1hLNrX3MUZZ6FucXokq5725mx
	SKfb9eugT4JGm+NV+Hm3Xuhz2dLQYjWqV0dybl6hP/z5XT4VqbPtm/XvjO8VFB56QokL4VVpTWv
	2WQuTgcbozeckSx54ZaCLof0qTJdTkCjCUlnTd6V9y0R/qkJP6D+wzH4KTvy9O4g5J4hXdFzRiZ
	flJdknZyyM0M049MaUativSR/W/oPBiilzJ+eH2OiNI3sP+qf3QnIqakJO5sf7o17S5IpjkZkBr
	z6AtjueDNwvT4lPbFcyJesvRNTDQYFynfFKTrXpaCBzPtJxsQAV3PP6ZofSuRHKhxc55aaxN0Yc
	XyNga2wyzsKNsSe/PLl/Ix8cEPGKW47C+tvBFTwO+KgvdHe3AIdPo64VI8weGspdtxEvMwpTTez
	6Fx28gQG2lQvMoAB4IO7Y=
X-Google-Smtp-Source: AGHT+IFG03chWckzr6y67x90QnGTqSMzQEluv5uCYHggyp/mWqt04gwhoT62JeF58wPH5dyi6hZU8IjEaZtL+ktDuZ0=
X-Received: by 2002:a05:6214:5889:b0:880:6a57:1a48 with SMTP id
 6a1803df08f44-8847c4d5725mr517223716d6.12.1764613015780; Mon, 01 Dec 2025
 10:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1430101.1764595523@warthog.procyon.org.uk> <qvtkweac7g5ejiicsnb7cqxlxl35toi2ykdmguaszqkcnir355@zvaw3oxlxzex>
In-Reply-To: <qvtkweac7g5ejiicsnb7cqxlxl35toi2ykdmguaszqkcnir355@zvaw3oxlxzex>
From: Steve French <smfrench@gmail.com>
Date: Mon, 1 Dec 2025 12:16:44 -0600
X-Gm-Features: AWmQ_bnpAyukHfBdaWxuRuWreo2AZSOmO4GxUpTXZ0FYkkhIDzupPaCil5Cr954
Message-ID: <CAH2r5mu13Jva4nP-rdk3QeRe=Y5iE6RcM7txKdRDHJM8a6AoBQ@mail.gmail.com>
Subject: Re: Can we sort out the prototypes within the cifs headers?
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <sprasad@microsoft.com>, 
	Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't have much objection about #1 and $2, 3 possibly if not huge,
but higher priority is 4.  Agree that 5 and 6 are lowest priority
unless part of patch that is fixing (or perf improvement etc.)
something

On Mon, Dec 1, 2025 at 11:32=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de>=
 wrote:
>
> Hi David,
>
> On 12/01, David Howells wrote:
> >Hi Paulo, Enzo, et al.,
> >
> >You may have seen my patch:
> >
> >       https://lore.kernel.org/linux-cifs/20251124124251.3565566-4-dhowe=
lls@redhat.com/T/#u
> >
> >to sort out the cifs header file prototypes, which are a bit of a mess: =
some
> >seem to have been placed haphazardly in the headers, some have unnamed
> >arguments and also sometimes the names in the .h and the .c don't match.
> >
> >Now Steve specifically namechecked you two as this will affect the backp=
orting
> >of patches.  Whilst this only affects the prototypes in the headers and =
not
> >the implementations in C files, it does cause chunks of the headers to m=
ove
> >around.
> >
> >Can we agree on at least a subset of the cleanups to be made?  In order =
of
> >increasing conflictiveness, I have:
> >
> > (1) Remove 'extern'.  cifs has a mix of externed and non-externed, but =
the
> >     documented approach is to get rid of externs on prototypes.
> >
> > (2) (Re)name the arguments in the prototypes to be the same as in the
> >     implementations.
> >
> > (3) Adjust the layout of each prototype to match the implementation, ju=
st
> >     with a semicolon on the end.  My script partially does this, but mo=
ves
> >     the return type onto the same line as the function name.
> >
> > (4) Move SMB1-specific functions out to smb1proto.h.  Move SMB2/3-speci=
fic
> >     functions out to smb2proto.h.
> >
> > (5) Divide the lists of prototypes (particularly the massive one in
> >     cifsproto.h) up into blocks according to which .c file contains the
> >     implementation and preface each block with a comment that indicates=
 the
> >     name of the relevant .c file.
> >
> >     The comment could then be used as a key for the script to maintain =
the
> >     division in future.
> >
> > (6) Sort each block by position in the .c file to make it easier to mai=
ntain
> >     them.
> >
> >A hybrid approach is also possible, where we run the script to do the ba=
sic
> >sorting and then manually correct the output.
>
> +1 for the cleanups, thanks for doing that.
>
> On backports, I think points 1-3 could be done together, but in separate
> commits (per header file) to minimise conflicts.
>
> 4 looks good to have.
>
> 5-6 would be most problematic (moving code around).
>
> Not sure what else to say here, but more atomic commit are easier to
> backport than big/monolithic ones.
>
>
> Cheers,
>
> Enzo
>


--=20
Thanks,

Steve

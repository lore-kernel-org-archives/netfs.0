Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49045383;
	Mon, 21 Jul 2025 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753059780; cv=none; b=nHx6v77T3eA8iZ60AEiLO+oi8xmdaUwDaUL0dSMmpEWNiX/jscnmtl3Pvmy+/tDXdWwUdJWRY4UcVKqFL/anm0bedwe0anc9Ua9/pgEL1AyKZR2eJ2QYVWJe4DIrSCq0/+4I3/o9ZsE8wa87qW8GqVSw2OlTKhcNdmoY5z7iWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753059780; c=relaxed/simple;
	bh=2Hbmk494c/hTDYfl/ELDOh+V9j3g5RYfmcC8Wuk0EM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhY/n2/GIbBvfFiJYIZ8S3nY9+LnieJuEs580IiuOdNrU6bqVFuMlzqf8KeJ4qNJpWpu4FH+QBxMEPHvfcpZxGl8dfNN/5aXenEEjAOclElquyhHPglDF5M3vuS8+Y844eV/EKPU3R4sK4TiS2OzzOo6MUkGA3aX7NeaCCe5+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDG2KI9l; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDG2KI9l"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-88150e9fba7so5641844241.1;
        Sun, 20 Jul 2025 18:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753059777; x=1753664577; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUWA5dQohEpiNzIiLQ5yB5KcDd7NwkYx6hF+GZtItHM=;
        b=bDG2KI9ltA5aoQpXOekWMnwWtP2npuTw4IZiew/tI80HzMMT5rVIWEw3Q5h9a1d/kT
         UqIvCMCRMiy+2xh6KZ1Ek3U8JVw60qa9j1jPp3hKXsbIPQozo7tnIUc/DPXRkGCfanAz
         JSiyC6WWEjux026n6CldBIiATXg+6DRvQzVCkDjwc9Ltqjy781VdJ2AD8KPAWJd+yYCp
         ZAj7ftQuNcL80y6yCBU8CcSyLpM/vdBZ39WtepSHX0ahbIWG3J4UKDmBOq5SMcryINat
         KiKQ7ZdsrBKn9ZRp/gjhysIN5UkdsPBW/lgevFpxMtsGDJzdutG902g8yd7w3ot2AfxU
         KOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753059777; x=1753664577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUWA5dQohEpiNzIiLQ5yB5KcDd7NwkYx6hF+GZtItHM=;
        b=gUBL65kVdecWltAxo8sQl0+EVhOAZNDW+xInmYjeIAiEus3Etm4yEAPiBzIrjh/YDr
         zoI6vpl/uutdOnu9dODbLEHdgQqgOZxC5AaXQc39A3ktN2yT9A8IrOZVY1Y9Vo+7BaCS
         nKLWmhKAfwIe6qfrtmGHqrW1M7I7wNruul/W4e9V3mMB1/JpYtyopp1oKyMJaoFeQdyf
         ROLJMm2Fk7VPfP72h2k4bJJDQ64Q+ARROrqT+6eGID22JqHBLGNq9mc/SFd+tx6PM4sj
         1/h7zRjYQ02uNa6vLL5IajKxgotcVyPfB3twH/PI/z/SkK48rpNMcTjpY8ykbnrc6R5j
         XxkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAn3wwxeRYrMwYyAtVZJ4nOXjch/sNTB+vBcEyoc1O91gcYitQTTdmiJot4/0Wpi4KJSozpiE=@lists.linux.dev, AJvYcCWRJE7CMRrpfJPdmO4iEAzsiL0vxd4okXI/RbIRquE8ONid0BFh8CYxTJkpNigfJ1FH9o6ZKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzON/iTiNIRfsWyubmktNf3aIP+1oD+cGL9uqc5c2PHGeWRF/rI
	cjfIhhZB3gGkHzxIRDrZZj85sBdB6At7nf/lr7rxHtfPw3bL29DodoSejwRCi1gSSzPqwPEiyC5
	KFW2sikN2+fQf/UU6BRwuGiUBcyNGVL4=
X-Gm-Gg: ASbGncsIku1UOSOCeyTj+oB0mpjHpFTtLNE8GcdEQPSVhQ7+KU5MSKbm8JCbFGgSubD
	ynV7opwo3Eq3+P8PTDHKWTFOe8sQXVQqeTn1t+wv4j7epTDGgUr9Au8lERRxgVR2hTAJJhQCkLf
	as62/68qztQV7YQzOzkMwWeONls3HOyW/0UH4Cfgw+SbQG7WgXEypjvmw8vVwVnP1dTLf2G3ev2
	CnvYu4=
X-Google-Smtp-Source: AGHT+IEmfqw92aWBN5S+l0I76SU0igPCpvqCsAsKehe4/Ig+tf7XCtcGuzfl8boXl3T7O5lTenPtedOe1kc4xTvXkm8=
X-Received: by 2002:a05:6102:30c8:10b0:4e9:9221:46d5 with SMTP id
 ada2fe7eead31-4f9a863ff9fmr3911618137.3.1753059777443; Sun, 20 Jul 2025
 18:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
In-Reply-To: <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jul 2025 09:02:45 +0800
X-Gm-Features: Ac12FXxvyCQ0eeZOJnljUPiNW1hOMFbnyUUqpvxURHtPLurlhEFVPbwv81doELM
Message-ID: <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 8:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2025/7/16 07:32, Gao Xiang wrote:
> > Hi Matthew,
> >
> > On 2025/7/16 04:40, Matthew Wilcox wrote:
> >> I've started looking at how the page cache can help filesystems handle
> >> compressed data better.  Feedback would be appreciated!  I'll probably
> >> say a few things which are obvious to anyone who knows how compressed
> >> files work, but I'm trying to be explicit about my assumptions.
> >>
> >> First, I believe that all filesystems work by compressing fixed-size
> >> plaintext into variable-sized compressed blocks.  This would be a good
> >> point to stop reading and tell me about counterexamples.
> >
> > At least the typical EROFS compresses variable-sized plaintext (at leas=
t
> > one block, e.g. 4k, but also 4k+1, 4k+2, ...) into fixed-sized compress=
ed
> > blocks for efficient I/Os, which is really useful for small compression
> > granularity (e.g. 4KiB, 8KiB) because use cases like Android are usuall=
y
> > under memory pressure so large compression granularity is almost
> > unacceptable in the low memory scenarios, see:
> > https://erofs.docs.kernel.org/en/latest/design.html
> >
> > Currently EROFS works pretty well on these devices and has been
> > successfully deployed in billions of real devices.
> >
> >>
> >>  From what I've been reading in all your filesystems is that you want =
to
> >> allocate extra pages in the page cache in order to store the excess da=
ta
> >> retrieved along with the page that you're actually trying to read.  Th=
at's
> >> because compressing in larger chunks leads to better compression.
> >>
> >> There's some discrepancy between filesystems whether you need scratch
> >> space for decompression.  Some filesystems read the compressed data in=
to
> >> the pagecache and decompress in-place, while other filesystems read th=
e
> >> compressed data into scratch pages and decompress into the page cache.
> >>
> >> There also seems to be some discrepancy between filesystems whether th=
e
> >> decompression involves vmap() of all the memory allocated or whether t=
he
> >> decompression routines can handle doing kmap_local() on individual pag=
es.
> >>
> >> So, my proposal is that filesystems tell the page cache that their min=
imum
> >> folio size is the compression block size.  That seems to be around 64k=
,
> >> so not an unreasonable minimum allocation size.  That removes all the
> >> extra code in filesystems to allocate extra memory in the page cache.>=
 It means we don't attempt to track dirtiness at a sub-folio granularity
> >> (there's no point, we have to write back the entire compressed bock
> >> at once).  We also get a single virtually contiguous block ... if you'=
re
> >> willing to ditch HIGHMEM support.  Or there's a proposal to introduce =
a
> >> vmap_file() which would give us a virtually contiguous chunk of memory
> >> (and could be trivially turned into a noop for the case of trying to
> >> vmap a single large folio).
> >
> > I don't see this will work for EROFS because EROFS always supports
> > variable uncompressed extent lengths and that will break typical
> > EROFS use cases and on-disk formats.
> >
> > Other thing is that large order folios (physical consecutive) will
> > caused "increase the latency on UX task with filemap_fault()"
> > because of high-order direct reclaims, see:
> > https://android-review.googlesource.com/c/kernel/common/+/3692333
> > so EROFS will not set min-order and always support order-0 folios.
> >
> > I think EROFS will not use this new approach, vmap() interface is
> > always the case for us.
>
> ... high-order folios can cause side effects on embedded devices
> like routers and IoT devices, which still have MiBs of memory (and I
> believe this won't change due to their use cases) but they also use
> Linux kernel for quite long time.  In short, I don't think enabling
> large folios for those devices is very useful, let alone limiting
> the minimum folio order for them (It would make the filesystem not
> suitable any more for those users.  At least that is what I never
> want to do).  And I believe this is different from the current LBS
> support to match hardware characteristics or LBS atomic write
> requirement.

Given the difficulty of allocating large folios, it's always a good
idea to have order-0 as a fallback. While I agree with your point,
I have a slightly different perspective =E2=80=94 enabling large folios for
those devices might be beneficial, but the maximum order should
remain small. I'm referring to "small" large folios.

Still, even with those, allocation can be difficult =E2=80=94 especially
since so many other allocations (which aren't large folios) can cause
fragmentation. So having order-0 as a fallback remains important.

It seems we're missing a mechanism to enable "small" large folios
for files. For anon large folios, we do have sysfs knobs=E2=80=94though the=
y
don=E2=80=99t seem to be universally appreciated. :-)

Thanks
Barry

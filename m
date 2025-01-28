Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB51D5CC6
	for <netfs@lists.linux.dev>; Tue, 28 Jan 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079006; cv=none; b=EL7m0pcPoC263U9jntW3BgtOZCGXsKp5coPQYl8yr5Mx8NM2jwgNsZZAcGXWFY/Qf31GL96iH0dvQHa4QzoD9qi/o20fU7Jadv7Rfx/6+CLjZAOolElqflwMfFmsIzdb6IeEMkVA4n4KFgC1r1OS1KxQsAux9Lqsm7+aa+wym9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079006; c=relaxed/simple;
	bh=4CM+Y34LzyqTPbJa964bMKTZoegb6ZCbeVLJYvxkr2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMt+AABMPuVgu7ja5s1rp9eLS84Yh5NYyPLm0iPu7GsIbZ0f2vnK3d0oRfBQjVxiRBWBIYpAVVinACgPqtmNY8+3IgWwGUmgbMhg9iqPcSYFTJB3ZtzjJqzGBXpVvTOcsVZodRINwFeSS/c9F8ewctDNEojiQX+Su0l1OzcCsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WgxtXWfC; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WgxtXWfC"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e39f43344c5so8249671276.1
        for <netfs@lists.linux.dev>; Tue, 28 Jan 2025 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738079001; x=1738683801; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CM+Y34LzyqTPbJa964bMKTZoegb6ZCbeVLJYvxkr2Y=;
        b=WgxtXWfCKj/d44b6zvg4GWicB0EgP6HKpBcAwwUMyPFn+Vm4rkTI2lCJ9UNJHmvOaH
         uGsqnYQvu5W8zffwK+eJghs9YtrorK+WTv6AmVifbAFf24dcez99KqyZrS5CgPhfTdDv
         Xix+E3TUWS73CJgbLwoghdg6HhTeGwu2wBQ8+QoycohfUlH0P5LBzZ1rBdz5VQsgpWzu
         BDyqdsKQNc0jECbXjxCiP61BKJMGfb3DjQKqgF/7CL/bzCkzFvNpVT+36mNNGHuePZGj
         7lucaDpgm1LxMZuT9U42zjxwbswKhvjm8v1zqvFCiPLbWKYbbYh/31LYNJRrafP4Ktw4
         9G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738079001; x=1738683801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CM+Y34LzyqTPbJa964bMKTZoegb6ZCbeVLJYvxkr2Y=;
        b=eD/UmFTYYXgWhi9JnpbsF+s9ccsgqyf/aoaHxgyW0jjqYx05qdpblYB1+oZQqbgHSI
         ZoohYKE6e7Q+9Sgt8nFC+vxaQ2soPGdYbaHiw/tILdG/9LhxMU+KnMd/F1Rgg+MoEa5f
         7iGPqenZAlTjwV0f8ZpovaqMWFeGfYuw0sCDxWg7cNv0ljfdACoTQaPsoUlSPuuEqYr3
         dKEyRFwWmFVKaHxML4hMQ1/hN9I4tmUY4HwhX71HX7iplciEzGrl8Vaw3F9oAHzhmV1X
         WuaCStwo3lOaC0b+KPe7TF+tsQUN5udQH7k4F/JChCGg8zyPSNaKgvBgPWZz+7/257tH
         8AYg==
X-Forwarded-Encrypted: i=1; AJvYcCXgYj5SxEpiaRhZ/zc+PeWIYJazdjP1ZORUXLN4gzqivfdLOUUJ9UdkVA05tDC5lYp/fP8cgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGUUwdbAVx/47jsMM/o9H+tsrAKFqdWDpXyuBmuGZCqvX+YzKs
	0s7TG0+wr7PksVBJG0hLILQIGqlMxqfvsEFG7tDUkpA3EcV4UizZwpkzEFRFjJDzKzf3L3vWjtE
	1CLCzYQjskYSuqUOhD6sMj6ZwY+zQVBWmZBk1
X-Gm-Gg: ASbGnculDB9E+zTZVIF4jKzbdUPeWJHVE4st2+am8ApBuD+PcbGz6lHDhUI1ej5ctel
	fNtHDEmtEi54eLTqvZy7d9IPJA+FCkpi+gXSP5QMxP+iz4aRTEgvA/oRbNPv7Bn0q1cdH8ZQ=
X-Google-Smtp-Source: AGHT+IGuLqrmdoXiE8apV7tzhOJZ5Xm1OF/NxWm8Kjkh7RMoG05FR1MdO9WMx2ebniwyt0o5rEC0Jv+xP432BtVJDY0=
X-Received: by 2002:a05:690c:4d02:b0:6ef:6646:b50a with SMTP id
 00721157ae682-6f6eb6b2881mr361409457b3.20.1738079001445; Tue, 28 Jan 2025
 07:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
 <Z4+jwDBrZNRgu85S@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <nslqrapp4v3rknjgtfk4cg64ha7rewrrg24aslo2e5jmxfwce5@t4chrpuk632k>
 <CAMj1kXEZPe8zk7s67SADK9wVH3cfBup-sAZSC6_pJyng9QT7aw@mail.gmail.com>
 <f4lfo2fb7ajogucsvisfd5sg2avykavmkizr6ycsllcrco4mo3@qt2zx4zp57zh>
 <87jzag9ugx.fsf@intel.com> <Z5epb86xkHQ3BLhp@casper.infradead.org> <u2fwibsnbfvulxj6adigla6geiafh2vuve4hcyo4vmeytwjl7p@oz6xonrq5225>
In-Reply-To: <u2fwibsnbfvulxj6adigla6geiafh2vuve4hcyo4vmeytwjl7p@oz6xonrq5225>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jan 2025 10:43:10 -0500
X-Gm-Features: AWEUYZkHRaUuCTQsu1U9C5jhigmIE9c2_8OmkE_i2Qv7ILXtAaTfDLC5EcLBZNk
Message-ID: <CAHC9VhQnB_bsQaezBfAcA0bE7Zoc99QXrvO1qjpHA-J8+_doYg@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v2] treewide: const qualify ctl_tables where applicable
To: Joel Granados <joel.granados@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jani Nikula <jani.nikula@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, 
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org, 
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	Song Liu <song@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 6:22=E2=80=AFAM Joel Granados <joel.granados@kernel=
.org> wrote:
> On Mon, Jan 27, 2025 at 03:42:39PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 27, 2025 at 04:55:58PM +0200, Jani Nikula wrote:
> > > You could have static const within functions too. You get the rodata
> > > protection and function local scope, best of both worlds?
> >
> > timer_active is on the stack, so it can't be static const.
> >
> > Does this really need to be cc'd to such a wide distribution list?
> That is a very good question. I removed 160 people from the original
> e-mail and left the ones that where previously involved with this patch
> and left all the lists for good measure. But it seems I can reduce it
> even more.
>
> How about this: For these treewide efforts I just leave the people that
> are/were involved in the series and add two lists: linux-kernel and
> linux-hardening.
>
> Unless someone screams, I'll try this out on my next treewide.

I'm not screaming about it :) but anything that touches the LSM,
SELinux, or audit code (or matches the regex in MAINTAINERS) I would
prefer to see on the associated mailing list.

--=20
paul-moore.com

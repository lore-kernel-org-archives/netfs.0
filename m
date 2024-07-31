Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079571AE843
	for <netfs@lists.linux.dev>; Wed, 31 Jul 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425835; cv=none; b=n5y7Z7cbtzzSD+Xu8wXlypiRaYNHwvuQH6NTFrC61zYGhC3lKcLZ7dUhFlNA1Cbx6euaUsYapXW02QsXYE3r8AO4H3uy6sqsQhG/xXFG7lgAeDRt98N4s9c1D5f69PoZ0X9m5mzA+LB5LM0Fk0vQVV0poy4qmNy+uLlAXjcHQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425835; c=relaxed/simple;
	bh=gmAAodUXdgnNESvRXNAekJJqooqvvUxv3wuMM+/4RoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdE4VETWwp2DFrFL41pRN8mSSd3S3wnTg1hl4C1Zcz8yLFy2S4Cs5IQNAduptirLBSXw/GHzTZ16JcSEhQZBkaQcBN6ByKcZp8x8Y98r/TEDusspRX62VWlWkQY2+lAJY27b8Q9SR6qoCPgUA2jzzlfmC+WkVC2AicV92ySBSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gGpzGmNu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gGpzGmNu"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a83a968ddso785720766b.0
        for <netfs@lists.linux.dev>; Wed, 31 Jul 2024 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722425831; x=1723030631; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iVqiOcI/Lm61Kn6z1In0PhQoNC9BfNgfzLWAbxhDSI=;
        b=gGpzGmNuu1/uVLrO89JLjO+2MjW5P9jWpFsyF7CwGwHSoHDKeLagqgdc/fFJnTkbXB
         ADz27dOk/VP7zxJjGYe9UaqReZVJvimAFhjDddOEInUJwBUH/NKU1nDmR51lqQV/jqYN
         GyTtIFOXgFMPu89dB0ZOAcH6apMJPuzhUeTrlIw5jDpUyRGDRzVQd/73R0rQJBaPwpmZ
         oiXe9U9nP5DrhbbUT1t8twnmlQRYSg+FOQATNV6FDh0yFCGgh4wMyib9hgleFPPu3lDP
         mCeuJYdt6M9FxlX88r7B7I+Kzan4bmuOKbKf/LSWmlxhCJWVoZTpXUL6thn+kXFeTs7/
         uTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425831; x=1723030631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iVqiOcI/Lm61Kn6z1In0PhQoNC9BfNgfzLWAbxhDSI=;
        b=VohwpmeJWbedPMI0mDIxQgTfikCH+CE6pobITy8LlRCOO0BeyjKKTOmr0rfUWcSVDG
         SW5+Ms31rvl1Vf2yETHH5bRunRYR5eqhn+AyqU2EMrXkVOd6xagm5p9bxjwTYgZ8gzeK
         NsZdQwZ69neC2XPVBXAAgDnsq8tJ/7rbndYpXZzMNdMQtB6JIwmU5gGOWnbJ8l8mN3mT
         /XF6Xv89fo32HVFIpA9CktQjHbVp+AyBuzZS8EgbqS3hhqvr3QCYgjSr3v3Y6czJkRDT
         yoRbzMvdF2JiVIadzvqbEUeevpOYDzZmzbncnbnbLy1pvEFIyamZzthMYnt5V2NzfE7i
         gkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwD0NlkQXEFlyPQbXveYCM34/KIGf7c9T6wbMCMIIPKlU0FHVogeuz57xtahrXOgduAiLiRPfZ6iawz9Tmq9wTYNdoZ0I=
X-Gm-Message-State: AOJu0YybjPLCbDBYoq1xrkVYdIRWwsTY1RBbsusLDaq3olFJNTIC6gBT
	Z5PBfNLv2qRBukzug/ucmUfFdzGkAQo1E8j+qS7Dhf/Hl5R+UBDZw5abCo8sRh6z4bwhziVUuQb
	YEWaruHcNQW0y2Z+c8pjc4k+7YfRFbIEJfM3wiA==
X-Google-Smtp-Source: AGHT+IGKzF7L3tGT7YjvoFGJDwdINXnVaS2Vxa/MttoDWTfIP0ZESkvvOTXarzXIGvRKUq2y7x6k6CcvXSEnf4eYun4=
X-Received: by 2002:a17:907:6d1b:b0:a77:e55a:9e8c with SMTP id
 a640c23a62f3a-a7d40128ab4mr796501666b.47.1722425831422; Wed, 31 Jul 2024
 04:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com>
 <3575457.1722355300@warthog.procyon.org.uk> <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
 <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com> <3717298.1722422465@warthog.procyon.org.uk>
In-Reply-To: <3717298.1722422465@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 31 Jul 2024 13:37:00 +0200
Message-ID: <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:41=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:

> >  ------------[ cut here ]------------
> >  WARNING: CPU: 13 PID: 3621 at fs/ceph/caps.c:3386
> > ceph_put_wrbuffer_cap_refs+0x416/0x500
>
> Is that "WARN_ON_ONCE(ci->i_auth_cap);" for you?

Yes, and that happens because no "capsnap" was found, because the
"snapc" parameter is 0x356 (NETFS_FOLIO_COPY_TO_CACHE); no
snap_context with address 0x356 could be found, of course.

Max

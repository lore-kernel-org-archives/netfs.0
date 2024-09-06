Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E5175AD;
	Fri,  6 Sep 2024 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583615; cv=none; b=lQJJ4tKtSudRHwYgdaUDkG0Yu1WzIatabNfHP/8ZDOE60MKg/7vel09WEAtCMu8vAbSBx1ZcfaWQbzpjo8yA+svnFLMPd0gf/hT3DjmLSPnq7qjIF5o5qVnERL2FhviiuILmJcyOGwDuMFf5k8goWXp88PKccDCyowe6hByLePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583615; c=relaxed/simple;
	bh=wraag6XcvA/xrmjSnurt8z/qaMokfuBHSFiv3OYVrrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH4zA5AYmnnedcWIgdOz/YeIrSgC9OjPaEafo99R97hcNSfeksAUdn9r+WsihggFay0qAIFoRC5iRkUm9LBCXgM6+TfiOweVfnh7YBcuOXz4/BqESAeKzIy/4xAezkYkNzPa2AeC/hPpFg1zkgUMOEpVTbJpFHogbh4tZnTbLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6cGrFZf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6cGrFZf"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01b8738dso1014968e87.1;
        Thu, 05 Sep 2024 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725583612; x=1726188412; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjzXiDfPjHYS2m3qWrFYZULU3Lh4847YGs1rex0AjD8=;
        b=R6cGrFZfoKF3PSUSeaC4shXKMcm2sfiGPurnN9rN9CPD931MEPsy2TxFTUNTM3TiB4
         91DL96KCciA1+B70b5Ist1tcpjqW3L0OnvU9CSb3Farb7T6QCJFza4pxGRdyxw/kx7JG
         4xpQ9HvA0IB74Um5doOAcgP6voj7EioA18fVQrHu/PScCFZE1LgBgCPiyQKvVS2TpMEF
         RpJOb3B5ou5FVWKfNSzOBqHFq4DjA0/+MqHjiEm+KG6gdm/0qbDOGeJPvHcHeWiD5zk9
         +9GVXYmzMC/Xn704bT143Xtyin8XQD0TDdOTL3VFp9Zez1chHHauF9fTCcmQRHa05/b/
         BTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725583612; x=1726188412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjzXiDfPjHYS2m3qWrFYZULU3Lh4847YGs1rex0AjD8=;
        b=k6h3natnTe1iai4lmCxuGRvl1678uAMsFdatUfPEWPRqDaE3gGizOT8DDB8SRdVhnA
         xbKdH/gaCNk82ODqBJwFSpEZnxUI8bUkMaU/NBW7BSIqxxHyzCXYE7aWmx347GE+AoFb
         XhYsOefJKNo9sQVHzBjWaQyZwgv8+lorz799oxxXdxhnYsARJkI+WaXb93Q/zfOgX89p
         VJidovCAj2MWBDZYi+Y3ghabrX847iC8iFjR7udTtKn7OIt6uXzBMvfV/oMLtGuvbCOi
         5UJ+SFRy+yKJM3bfCEHpf3KaS6lT3a5eigToPAIvIervAk/yVfvsdAnQihuHzHoXtjPA
         lrWA==
X-Forwarded-Encrypted: i=1; AJvYcCUNjagA5zKNRqJqZnuO1qZhvV8yj32g7c4t4Zu8hytsbz+xPO3wRCRbe+OxtN5WPH5NSWYoZazwicZC8h4=@lists.linux.dev, AJvYcCVpkTkby57T+QAYCpUlQ4X558oQ+GII43cZDxneI6BbqOwn09VVeHMPIzrXCYRiRSnCPHFiyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxC4N1aXfTLbUS7uPgqYSIneNKw/2eAah0CtHRBtAnH1Vltik6
	WOhWjM/foIqIJnWTv1pLT8/iB5apfSr6c78gd38ZYBU96+FY7sd7MdVpgAV7RkHN+hZcxCV6Us4
	bZCYv/MgsKY1AskjGegT8cFt9kAA=
X-Google-Smtp-Source: AGHT+IEqxH77xXmK7syoAkYdIL6i1q/zug9U1ZFp27ffeFb72Ar8f0dZqbEwFB1SbaA5SwPNImYC6xhXy2zChgDKHnM=
X-Received: by 2002:a05:6512:ea6:b0:52e:9c69:b25b with SMTP id
 2adb3069b0e04-536587b4390mr331788e87.28.1725583611619; Thu, 05 Sep 2024
 17:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1dihdj9avrsvritngbtie92i5udsf28168@sonic.net> <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
 <2450249.1725487311@warthog.procyon.org.uk> <6jnidjladjose5gvv7nmofs008dlrd4cn3@sonic.net>
In-Reply-To: <6jnidjladjose5gvv7nmofs008dlrd4cn3@sonic.net>
From: Steve French <smfrench@gmail.com>
Date: Thu, 5 Sep 2024 19:46:40 -0500
Message-ID: <CAH2r5muWjARBd67oXMCgZAkOekEd=naX6x_4aDhb8YXYBMm5Cw@mail.gmail.com>
Subject: Re: [REGRESSION] cifs: triggers bad flatpak & ostree signatures,
 corrupts ffmpeg & mkvmerge outputs
To: Forest <forestix@nom.one>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:32=E2=80=AFAM Forest <forestix@nom.one> wrote:
>
> On Wed, 04 Sep 2024 23:01:51 +0100, David Howells wrote:
>
> >Forest <forestix@nom.one> wrote:
> >
> >> Write corruption still exists in 6.11.0-rc6.
> >
> >Can you try adding this:
> >
> >       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Dc26096ee0278c5e765009c5eee427bbafe6dc090
>
>
> That patch looks promising. With it, I've run my tests 2-3 times more tha=
n
> usual, and there has been no sign of the corrupt writes so far. Thank you=
!
>
> >Unfortunately, it managed to miss -rc6 because Linus released early befo=
re the
> >PR could be sent to him.
>
> Will these fixes be applied to the 6.10 series as well?

It is queued for 6.10 stable based on recent email from Greg KH - see
email titled:

[PATCH 6.10 181/184] mm: Fix filemap_invalidate_inode() to use
invalidate_inode_pages2_range()

--=20
Thanks,

Steve

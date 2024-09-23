Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F985931
	for <netfs@lists.linux.dev>; Mon, 23 Sep 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131315; cv=none; b=KKrLHvm23e/SxH3kuF1mhs3m/VcBeRMjm27RKAYBe6URgCwfGwHKl3/U+p2B+uJVBzGmiWDiiECDJGOKKlUOEgfkq8zPh07o+C8QeLJcjzf5Bi92sZyz/fH7fza4lOapl+dIG73U8sHeRW2Br6aZTA2C+rncqxpr4IMzh6eZPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131315; c=relaxed/simple;
	bh=DKxVsqI4h77W8oz4OPBGGZ2ao2HAHSeda+wfpF76QE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uW055XuqUiyDC79bYG0G1V9R4BITXSeF2VJzUP+SasdzmipmCxs4RrUpLQ24dhKrtIc1WJ1cELWJBiJUhKpnLPlOB9xXeQ5w5BBkpyLMbBGYZrTwxnzF4DlTPcSUHbUFSQVRuN+6Kqjxsdjv5IM3ssnRMCI0dh61pcld+HLDYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM1P/I9F; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM1P/I9F"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53654e2ed93so5576703e87.0
        for <netfs@lists.linux.dev>; Mon, 23 Sep 2024 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727131312; x=1727736112; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXtpj3oKM4ibzRsWBeP6PGcZJAeCJUtVQXMOUbE9ruo=;
        b=KM1P/I9FJMqo7ngeAAc2bQvSfvb+LPMp5rwceKDwc4PZEZ8vY9ZTcbyUC/6nN7k+at
         FUO/zb0jrgSAzXGDZf2WavH6qwpJz/rRuZ/rXFh8Suf5kRd14GTIy9tZhJYCgjfVrIi+
         nISOsPzrbk6Xdyvsi7maLOiilc1Mwngs8eeZQYyQNFzV0gIKPOAy9O/+OAjgrUsg2Jsa
         y1qjhk7H6fSOM3uD03ZQMFc4OIqxHS9jpNRdibGlpwEn0TxMRdEgAAltIGjAjzqZOSsp
         mvaZdbRgRmE0a+eh+jem75cgX6QcmoDZ7m/abXnroGRMu6bucEG2+T0hn0r7cT0TKMWB
         t/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131312; x=1727736112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXtpj3oKM4ibzRsWBeP6PGcZJAeCJUtVQXMOUbE9ruo=;
        b=ShYeCZRLJ95h6SbWyY8cne8NJFV6TU1TPfMHmPWZq17xL+IVCfVTrFj0SXlI7hvlYF
         JcBpZg4wuqVvlOWmm9GRhC58NAkTJWX+JdqA51w4QMFnE1iLSsBZGEOu4FMCb7uDLKVi
         rKSlkyl5oI2hvq8ceCB6yZ4rfz9X+dWACxx+8MXhGxAjRgu4S4fFKvMJ5JKAdsRPaSTj
         5fqSxNz6GT4b5hLrUW0sSQUIIczCmYMMWW2NLtNNH4dhE2yqCw+gL7j3cEjguYtswMhN
         l+IA+crkO6URaZ6ce3D6dFVXtPHLmqxBntNyvGWdKSMWjV0UjZrub6ovXJLVF0Zlgje7
         dKQw==
X-Forwarded-Encrypted: i=1; AJvYcCUEGF2aiLHhAPZcyUBb93mzznKE2ZXE4+ZHM8pVgKFfdifHAxBO0nOvhGNfl/YteJE5kx/JTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIB4TBwYoEHnvJJsmm0W0rMIi/2lHW/2wgKbQALlyOk55hSw8r
	wU0qdE5jXHO85Iwr1qJc6gGFrUSr4fV0wTggcLJeXw3VZLkS4yiAIZZ+q9e3mrM/dmP/TvWfftm
	+dRBFl4vJajh49XvVjeqY6/KYpeP8Xi1t
X-Google-Smtp-Source: AGHT+IEuyM6K1Mxszb0GP4Ue8emNvrVXI9jx9caANbmOkUNSBjPzbcALoMwpZFu5YLbqb2qx8VsIIWd5xpcoly+2giE=
X-Received: by 2002:a05:6512:2356:b0:536:9f72:c43a with SMTP id
 2adb3069b0e04-536ad1914cbmr6531368e87.36.1727131311369; Mon, 23 Sep 2024
 15:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2390624.1726687464@warthog.procyon.org.uk> <31d3465bbb306b7390dd7be15e174671@manguebit.com>
 <CAH2r5muENv0sQ0+Q6xtDA-ThVu8B1W9=3-Yy0nOhX3onVVUXFA@mail.gmail.com>
In-Reply-To: <CAH2r5muENv0sQ0+Q6xtDA-ThVu8B1W9=3-Yy0nOhX3onVVUXFA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Sep 2024 17:41:39 -0500
Message-ID: <CAH2r5ms1-EnoxoYSUGVvk-NCucCk-5d8tNAyuR30xi-qrgY8pw@mail.gmail.com>
Subject: Re: [PATCH] cifs: Make the write_{enter,done,err} tracepoints display
 netfs info
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I responded to the wrong email.  This is in cifs-2.6.git for-next, but
it is obviously not a regression, I replied to the wrong email

On Mon, Sep 23, 2024 at 5:20=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> added to cifs-2.6.git for-next since it is important as it fixes a
> regression affecting cifs.ko
>
> On Thu, Sep 19, 2024 at 11:01=E2=80=AFAM Paulo Alcantara <pc@manguebit.co=
m> wrote:
> >
> > David Howells <dhowells@redhat.com> writes:
> >
> > > Make the write RPC tracepoints use the same trace macro complexes as =
the
> > > read tracepoints and display the netfs request and subrequest IDs whe=
re
> > > available (see commit 519be989717c "cifs: Add a tracepoint to track c=
redits
> > > involved in R/W requests").
> > >
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > cc: Steve French <stfrench@microsoft.com>
> > > cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> > > cc: Jeff Layton <jlayton@kernel.org>
> > > cc: linux-cifs@vger.kernel.org
> > > cc: netfs@lists.linux.dev
> > > cc: linux-fsdevel@vger.kernel.org
> > > ---
> > >  fs/smb/client/smb2pdu.c |   22 +++++++++++++++-------
> > >  fs/smb/client/trace.h   |    6 +++---
> > >  2 files changed, 18 insertions(+), 10 deletions(-)
> >
> > Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

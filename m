Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA313D244
	for <netfs@lists.linux.dev>; Thu,  6 Mar 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269568; cv=none; b=pIc+PEMaaGuW+RWwPK5lcYEj+bACUhK+iXV9n6hN3MTU8L69mEprfXILnupNGNUF/3TE+J01myneVQIm5KjcGMXgH5cor9/GEygE8/kJW7z/HkrU8wlPHG3PWGOWkr14p3uKmGjGr1P0D5XJYnOhtBupjb3n6LpC7Uc6q2BKlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269568; c=relaxed/simple;
	bh=WrqtzWC0xwvi6F9AT2fXYa95OcNU+FznHVE/qmwTd54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYGBQ8WuUz6sLRoMGpJ+xf6Xi05o2L8Rs4yDnZpLmuy1XcvbJa080jt673w8VBSdN4zbfCzm220VnSta2fp5Vk1llfClWOjmFDCRqOTK9QRXBOqrUCaM1MshiwdArRPHKa1YlkrbgCLffAmdElgLuZCnhMPK5Khl1sicXnZEML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4fRJfx6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4fRJfx6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741269566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZooRQX1BKvmOK4sDMN2bxn8s21u0gT4SA35hpx5Jgms=;
	b=K4fRJfx6Y07Tp1F/xn7L7G/mjXRnmD6bDOfYXd1YPof34DL6zhwrGp254Q4aXfy321faCJ
	MMp3YDs7fRzbBC5tlTJke7jp1sutJU2Twm9zS41j5d7rlYPgMJ9TE566+N7MDlLB3Cv/uH
	/RK50VeZsglgwrADqduE6m5gjchvBgY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-KmnOinLrNBeP2il6-J6l9g-1; Thu, 06 Mar 2025 08:59:25 -0500
X-MC-Unique: KmnOinLrNBeP2il6-J6l9g-1
X-Mimecast-MFC-AGG-ID: KmnOinLrNBeP2il6-J6l9g_1741269564
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5df498f31ccso801507a12.1
        for <netfs@lists.linux.dev>; Thu, 06 Mar 2025 05:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269564; x=1741874364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZooRQX1BKvmOK4sDMN2bxn8s21u0gT4SA35hpx5Jgms=;
        b=rIYPJaoUQnAaRqGgEah6bTePLUF4wNjELeZGkJSfJvmTEb8gQfD2KwS3kKZ4G5kMK/
         77Ff1TZoOVuI4N2GrPZ1lRmzGoNM9csrD3UXawq3E2niDUHejesTCce/U9JFZrtVvwnt
         wHvPFynO4e+ei/2t2j9uDhwAtbG1qxS6NlFtlKd/wx59rTyOsKswWSiwE4SLCUfzzMQB
         agU+uK9kdPJCoD7SS6Z/58h6BAJxy5v/zkcVfduPNdOKSP6a7mKqRPLu6LzGxtLUhTlU
         dOEAaBzOCtogn42wQ5njl30f/xLfna0Z86gK7hOYmabQe02rIw9CrbPplAZ81Kjq0/+7
         qLyw==
X-Forwarded-Encrypted: i=1; AJvYcCXmQCy0QoHhDnpd7f3AzE81H8s3Qlz77safEwvYWDmQlA7N2MmNJFO2uTT9dYELHur2MQZAzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF02s6Q2B7Y8lxdJAkIFIEqKcBoo624jzjLRHymTUy5fQaPpTt
	Rn7Q5vapzAn+Sf/nN9WB5Snlxmpg3XKat0rSCODtDicLLjDjx0oYQneikjrXlYW0e7ECTD2I5dx
	PIvAZ60oeKqHqV5v2RctlDb3j5xm+5b5KZDfrtSNeb4rSCPyQ3bBinI9/AuJPpKAYV9+E09Xgc+
	m+yNDx25Khr13emh9o/K0NJv3BN5Q=
X-Gm-Gg: ASbGnctkt00NvdN/5Cb0mmZtVubzHWuUm6H5jE02EOaDaAJKFV/yTsvkKrixuDnd7lO
	zEnzgs2ylWYvJ2adbT45QoE6iXLD0Txn7NQvmj8Po8PaSc5FBcN8zg6fn0u9rw13s8jHmWmA=
X-Received: by 2002:a17:907:3e1a:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac20da87c3fmr775575366b.39.1741269563823;
        Thu, 06 Mar 2025 05:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/M8v+9xzTHPmLpQ75OAihzQ6mzPMwQ9pLsX1TWkjNDEi6t39DvU097jtsd97RK2Ju6JSIYApTxIBWuz8YYMc=
X-Received: by 2002:a17:907:3e1a:b0:abf:4e8b:73e with SMTP id
 a640c23a62f3a-ac20da87c3fmr775572766b.39.1741269563390; Thu, 06 Mar 2025
 05:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
In-Reply-To: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
From: Venky Shankar <vshankar@redhat.com>
Date: Thu, 6 Mar 2025 19:28:44 +0530
X-Gm-Features: AQ5f1JoxybOFaeQfOnAFb2qT6vfHxfb4ypSveZZzWheKw-_E5068fWRJzQnFOfM
Message-ID: <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Gregory Farnum <gfarnum@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 32Gn0jOwaFMUUfXdPbvMM0h921Ks317B4wNHXR0Bp4w_1741269564
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:54=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> That's a good point, though there is no code on the client that can
> generate this error, I'm not convinced that this error can't be
> received from the OSD or the MDS. I would rather some MDS experts
> chime in, before taking any drastic measures.

The OSDs could possibly return this to the client, so I don't think it
can be done away with.

>
> + Greg, Venky, Patrik
>
> On Wed, Mar 5, 2025 at 6:34=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
> >
> > Hi Alex, Slava,
> >
> > I'm looking at making a ceph_netfs_write_iter() to handle writing to ce=
ph
> > files through netfs.  One thing I'm wondering about is the way
> > ceph_write_iter() handles EOLDSNAPC.  In this case, it goes back to
> > retry_snap and renegotiates the caps (amongst other things).  Firstly, =
does it
> > actually need to do this?  And, secondly, I can't seem to find anything=
 that
> > actually generates EOLDSNAPC (or anything relevant that generates EREST=
ART).
> >
> > Is it possible that we could get rid of the code that handles EOLDSNAPC=
?
> >
> > David
> >
>


--=20
Cheers,
Venky


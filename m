Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0E212D7B
	for <netfs@lists.linux.dev>; Thu,  6 Mar 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278125; cv=none; b=YG8eWlIU/0kSWn2SBcKCx8p742/LOgDdFn0MurTMN/8pgH+EtsxWcHn8TwR8x/fCHIwmu3SLelXyZNY3v0FwSqTgI9cp4tMGopRCYqMsg9cSbUgtEX+2JE/W6VJzV4UUpbtpMkUqxLnNJ/yyq+bRWOApp2xfVJZ9SjCmC7tZlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278125; c=relaxed/simple;
	bh=6JEQjmrMba8qZUKzmUxEKp4TUW/usegCC4+9HVUbFao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPj28ArKyJRHDuFdObE++XBabNeW5mwHkH5ji8lw3C3el6ql5EN6BkLrEhKG4H7LFbzOz65u7mwT4Z43E4SuM0oM0k9/fLlP7yvHSbgYnyZdfYYHbnaXBy1Tj/r5WSH+DAtpumuDJjUCm1b5bQjSepDxc1u+nAjhVF6oE//WOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fdsxtxqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fdsxtxqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741278123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqC+Llm1WJYyckYsZ/+upOpOsuMKvlE5dwDUUY8Zj7g=;
	b=Fdsxtxqsp+fLPkvos4SVvbAjMt1qC3CH/HsL84VquUISFb36uz/7dYVkk36vKWW5HwSj9e
	YJrr3rg5/1kTPm0KJFZTOYxVSCm8KAKHLMTTSR6JP5Q4BQz+0QT5Tp/2aTx0DAhEqAbi0Q
	yV6qd6AYugwfSv12Xp/fBpkRBL6B4yQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-LY0kNcc7OXOOb0hnQ8YS1Q-1; Thu, 06 Mar 2025 11:22:01 -0500
X-MC-Unique: LY0kNcc7OXOOb0hnQ8YS1Q-1
X-Mimecast-MFC-AGG-ID: LY0kNcc7OXOOb0hnQ8YS1Q_1741278121
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224192ff68bso8816345ad.1
        for <netfs@lists.linux.dev>; Thu, 06 Mar 2025 08:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278121; x=1741882921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqC+Llm1WJYyckYsZ/+upOpOsuMKvlE5dwDUUY8Zj7g=;
        b=G9eIJ49HqfO6rXXwu5fWv19k1ZrQQdEle/ZK8XbH2Owz86XM/L8rG9NXaodstM7F/z
         I4m2/fn+NFjeqYjWfNFE9aHqFBPCg7a6g+ZKGPT/iBZV7V8bV7ZbvIxbRBOz9wKxmauZ
         6O1YQ15BgjstsLAlkFLGPHQ2T/FYuhJFoaGiqnBuEuE1f1nKyhckuv+iKEo19i2/0Oyr
         Uq/0m/iZxCRsFZbV64Qu4cjynbWWT09L9bFdGuoc9MU5QAx9v6UHvNbydR14fTdJXJ5E
         YfEEBvKPc4vgtvaC6ttD37e9KFNY2OQN0ITMiyBDKupXC62oyrtnErNtsEM1pReFkYDu
         Sopg==
X-Forwarded-Encrypted: i=1; AJvYcCX03fXioe57kY6KT+FloeSbdAZJ0wRdLQWImACKsi+PQy2twogES2h3sg526L4Lu7JRcRPlOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6AorfMjG4FFE/sHVMqWqkT29LyjIIHhQRrFVVy65IUZdjGqc/
	iesS4A4oFH1fAv4D1j6Wk8dY9uUdCxUNqXX7BWLBUsSBX9cZAPXOXUJUNrJjrDZhrdSY/ya35iY
	PBfi52VUdPZMXusJXXt6thFS9vKdps0J2i0bbNFUXH8HoaJ6v9nYURAzuyGiF8bFJN2MLZRQ8na
	hvhywnzBLEAjR2ahn/ARPFbneQvaM=
X-Gm-Gg: ASbGnct4JVW2jDt08Oc/IEUGDnn2Vwx0Hph6ItlqJOZ5mq772/f/k+/h3CFxlzqso8G
	wQ1vd56OK42TS5kxuBylL0XlddnvSdJ4KY7AXrwn6cL09awp0P5mvFSE4hVSJuYSnDuL5zc0huP
	UMK7IWwOlZff4RnhkhaToJwTkCzQl5J4E=
X-Received: by 2002:a05:6a20:6a26:b0:1f0:e3cd:ffc0 with SMTP id adf61e73a8af0-1f544cad6dbmr117473637.38.1741278120570;
        Thu, 06 Mar 2025 08:22:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBnNiZHiJ9P1cHLuxoqkZ0Gke5p5+vnyphXWaW76LGKMfyxbwfovLX3oXnrDS2K4RsAwjCEgRVZZSj048G2+4=
X-Received: by 2002:a05:6a20:6a26:b0:1f0:e3cd:ffc0 with SMTP id
 adf61e73a8af0-1f544cad6dbmr117431637.38.1741278120028; Thu, 06 Mar 2025
 08:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
 <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com> <128444.1741270391@warthog.procyon.org.uk>
In-Reply-To: <128444.1741270391@warthog.procyon.org.uk>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Thu, 6 Mar 2025 08:21:49 -0800
X-Gm-Features: AQ5f1JrunyMYAkh4fezKqE6Zg5EpuX-iNcyahs73zEQzWdI8lPNSFb7vn1fVr8Q
Message-ID: <CAJ4mKGZP2a8acd3Z7OT4UxJo-eygz30_V4Ouh05daMQ=pQv4aw@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Patrick Donnelly <pdonnell@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kI9g_CGuUCgOH8Cti0W1h9s0AO_AUmE02k98Fv7XYNY_1741278121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:13=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Venky Shankar <vshankar@redhat.com> wrote:
>
> > > That's a good point, though there is no code on the client that can
> > > generate this error, I'm not convinced that this error can't be
> > > received from the OSD or the MDS. I would rather some MDS experts
> > > chime in, before taking any drastic measures.
> >
> > The OSDs could possibly return this to the client, so I don't think it
> > can be done away with.
>
> Okay... but then I think ceph has a bug in that you're assuming that the =
error
> codes on the wire are consistent between arches as mentioned with Alex.  =
I
> think you need to interject a mapping table.

Without looking at the kernel code, Ceph in general wraps all error
codes to a defined arch-neutral endianness for the wire protocol and
unwraps them into the architecture-native format when decoding. Is
that not happening here? It should happen transparently as part of the
network decoding, so when I look in fs/ceph/file.c the usage seems
fine to me, and I see include/linux/ceph/decode.h is full of functions
that specify "le" and translating that to the cpu, so it seems fine.
And yes, the OSD can return EOLDSNAPC if the client is out of date
(and certain other conditions are true).
-Greg


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696E1922ED
	for <netfs@lists.linux.dev>; Thu,  6 Mar 2025 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281552; cv=none; b=ONemnz5baI0lRy/RrDZxMphnsBwa2KHSgL6fs/ztYfmM4GOgf23kryV2AmrGxRJWC+0iXqTfM1hg62wcxnNNKlMZ72pdUFZXprImBz0EM7BgEAVxOVeoC8F2wqO74f5hd/R3pzJnCRSGoTWYIszyqxlB01J+3QtZRam72RaZrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281552; c=relaxed/simple;
	bh=1zk/Wf5UBNnW+CYKHKRvUx81qFWSHkXU/Q2Txv1Mg1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6OTKkLoOe39gkKSwvTjiutxfAggJv9uErnvagtd4EdzE1mfFstqcmRDmYH/J3ZxflSwEJPF/sKelBIt5e8+cN/7gpMsF62qFooVmaihG6xi3Idg9shG+PdSi2UKBGfr1iFnzF/NXAuxZSxU5WRakjpPmjrn0vBJVXcFp7pYfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws9SI6Tm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws9SI6Tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741281548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUWoEwD1QtHX1NkxE737fq82KwPX2Nk79R3EEcVwNlY=;
	b=Ws9SI6TmJCkqWADyH7KWqfr7NkuWgT8ABa+ilp8JnmO5fGFD59Cq/dRnIygFfdTnlXJEiv
	vaegy5vTbPgxtQQXMigskJSHutAMpo1twxNMLGecJwkgx0EH0MgZgbWuyRpsu72hp6xdNN
	4cGEfj9I/LaJXaYlbe7Q7TqUsoG2h8c=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-YOPetKjjPOu7AFhJEtcWjA-1; Thu, 06 Mar 2025 12:19:02 -0500
X-MC-Unique: YOPetKjjPOu7AFhJEtcWjA-1
X-Mimecast-MFC-AGG-ID: YOPetKjjPOu7AFhJEtcWjA_1741281542
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-86b5cb902easo1136672241.2
        for <netfs@lists.linux.dev>; Thu, 06 Mar 2025 09:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281542; x=1741886342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUWoEwD1QtHX1NkxE737fq82KwPX2Nk79R3EEcVwNlY=;
        b=HmXfu3CLDHcXW8aMbKnnODAVXn9ZU+nRScbOq9gXeF66lVwY3WCZLx/99HG7kp4e8r
         ny65S3zPJZEsIhc3uw4/XqzrIUJ7gzbM9SyLzbOZKik0knMlXjrsg5vgdBh1URZFgkGJ
         CR/yQJaS3r/eO4b8rvxSvsNL0ASa65LPkBfdOHJz8NgwKIKRSvsVc5e4kKUzwv0edIfI
         RZ9ZcGXXJAjA+NWjq8LpQNM4ZseQFtH+2W5kac4vNJ5aQc7H4QXSNnbL/TasxRA3sRig
         bgbzgt6BfEBI/ePxRP8zOxpLcGN+wvBpVDqciqP9QYOy+W61/wo1Vmw5a+Vdvx39PLqR
         4k5g==
X-Forwarded-Encrypted: i=1; AJvYcCX1wLDa8MnwjnG6V04niq5+2XHIXxFGL4dVT2WSr0pBppMXVnexJqWw0w3//9CrpoIx5IQPsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6c0lne4M1/4uMzzZIAU3XGDKEJlNiV2CkdeqTH4/oWiXlwAYc
	pMfgI15OAF/VoMESwL6tsAON1mc356k/0kp9tS5yzGJdeIEAqFO6me9uJmWupfhuebGhw+JphEM
	WANIa7AaWn05ndRElhJbKLqeRn3cHKYSgC8+cpL/IuMRUgEYj5vxlnAdeT5h/NW55plz2lvI7Rm
	DfNQtuQSBlJNLA6FySWTx1hl0f/zw=
X-Gm-Gg: ASbGncvU1Qi6LIeHXqnZ7VhRNT44+yF13mI2jMtcx77Db3IdKxcKfMiZtGxuN2FAKii
	yTILOuPULkivUaN5g8wBTV/GHVoyBkH4WMPCE4LBLdlSM9NdUsXHhN/d0v8GpS5nzMzZuD6zq
X-Received: by 2002:a05:6102:5490:b0:4c1:9b88:5c30 with SMTP id ada2fe7eead31-4c2e292962emr5979441137.19.1741281542236;
        Thu, 06 Mar 2025 09:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7spgLqpPQaIcIR+gCiOtfl1Cc6hZYDhCnOcThE+Z2s7vNWkkQetRZiUqTe+9qs6bZrerq/C7urJCzh9HnSNo=
X-Received: by 2002:a05:6102:5490:b0:4c1:9b88:5c30 with SMTP id
 ada2fe7eead31-4c2e292962emr5979396137.19.1741281541943; Thu, 06 Mar 2025
 09:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
 <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com>
 <128444.1741270391@warthog.procyon.org.uk> <CAJ4mKGZP2a8acd3Z7OT4UxJo-eygz30_V4Ouh05daMQ=pQv4aw@mail.gmail.com>
In-Reply-To: <CAJ4mKGZP2a8acd3Z7OT4UxJo-eygz30_V4Ouh05daMQ=pQv4aw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 6 Mar 2025 19:18:51 +0200
X-Gm-Features: AQ5f1JpQcoMH0pu_ANh7Fi3mDGR-c82TH6fAs4PV2crn8yOt0NZj2cZVfepYRdc
Message-ID: <CAO8a2ShjbUuk9_+9P9oVcgTU87ZASNpa735xOyC+tMetL13bdA@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: Gregory Farnum <gfarnum@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Venky Shankar <vshankar@redhat.com>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Patrick Donnelly <pdonnell@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zy-ingtBbAdb6KXF0IgbTdtmlgSMcMHSeJu0_8vCuis_1741281542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's not about endians. It's just about the fact that some linux
arches define the error code of EOLDSNAPC/ERETRY to a different
number.

On Thu, Mar 6, 2025 at 6:22=E2=80=AFPM Gregory Farnum <gfarnum@redhat.com> =
wrote:
>
> On Thu, Mar 6, 2025 at 6:13=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
> >
> > Venky Shankar <vshankar@redhat.com> wrote:
> >
> > > > That's a good point, though there is no code on the client that can
> > > > generate this error, I'm not convinced that this error can't be
> > > > received from the OSD or the MDS. I would rather some MDS experts
> > > > chime in, before taking any drastic measures.
> > >
> > > The OSDs could possibly return this to the client, so I don't think i=
t
> > > can be done away with.
> >
> > Okay... but then I think ceph has a bug in that you're assuming that th=
e error
> > codes on the wire are consistent between arches as mentioned with Alex.=
  I
> > think you need to interject a mapping table.
>
> Without looking at the kernel code, Ceph in general wraps all error
> codes to a defined arch-neutral endianness for the wire protocol and
> unwraps them into the architecture-native format when decoding. Is
> that not happening here? It should happen transparently as part of the
> network decoding, so when I look in fs/ceph/file.c the usage seems
> fine to me, and I see include/linux/ceph/decode.h is full of functions
> that specify "le" and translating that to the cpu, so it seems fine.
> And yes, the OSD can return EOLDSNAPC if the client is out of date
> (and certain other conditions are true).
> -Greg
>


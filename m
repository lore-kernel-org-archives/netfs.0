Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E05157A61;
	Mon, 15 Apr 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221503; cv=none; b=ukdlI/tyOcUK+K9tLD1PLqR584OWrQ1JcJNfggP2xrN7zsslGA3Ii05a3Z4kY5rDkXtJLhuaTbXtfbhmiRzbJ7S7HAJxaJrOVLJAaMV8BgLRM5ksEmp5NtwmqYHsgctZbNJLAxvisBpdfcKbEwMqY0+kkO8VMzLiGlipC0/gWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221503; c=relaxed/simple;
	bh=210MiktY9ffZFXiFwX3XKrZn/rqxu8+UIHYBzztKE80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7DRg1QVy8/sHGFcWTzQngne1ZXDihtRzZU86oI8Gv9i+5UniOBKerFAAOThfj0jzS5/8VZIJrH76/khPB5VuPqB/CCf+5ow+ugT4pnkjir031Jglx/ONgHyCtc21LmCYdIvHbrYVfZVaDNNgRORGXsEyrUiSiYdG46VDk8bYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7+t1UIC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7+t1UIC"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d0162fa1so4728198e87.3;
        Mon, 15 Apr 2024 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713221500; x=1713826300; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63WuSgSRy34JNOa9pVcP0sGLwbzNT5xJkZeCbwGkCUE=;
        b=A7+t1UICArS8NaQM+rEfgZJCMmn0JsbK0SPp24FDrqbNpTm3kHaCfSwi6jNJ0lYE4o
         osrb+/coEIeucdmy3W3m4p/L3Lz9rrt0V9ZCQZU2Ik8snzKVBzWLzOKqzqT+f252z2C6
         Q9E5EbYh38SYfqNcM0wHrLGcYmirOZwM1XkyJC+7tkU9VnFLaSbqvu52F4aeam8HhXcy
         ydfYeQuPwYpgOJtxprVLq31LkciVHoBz/cpOM9+XV7jc0Myt1DpPdgaGj0MlCw8nWzjZ
         GkbsbLlxH0ruK623JS4sw2DS4tehwfgNTEBMpOWncEZ7ojStK1rkzwWClShnqf1P/uho
         gCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713221500; x=1713826300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63WuSgSRy34JNOa9pVcP0sGLwbzNT5xJkZeCbwGkCUE=;
        b=v9u2PO2Ho29dR+dtpu5mxZKuaQQSFU7wbb5Ex3fboTpdqKAlOhMehPTbdCRvAWegRm
         /DpkkzGK/z/Y4a8IoN4wCM4HKE/VFGN2qQy7UCwiGwpNAfy/l2pp/p6/UwtHL/LW8AvR
         wS8NzmKZXura/exa21ePIrWwb2MP1PxCYDtd011TX1Xk7UxfuG7L3kCVABN3JoQ131lY
         fgLWJtOZ3XeoxSw8DQjave1U+M+PBwmGHVBh6d+xhvLLSqpsIr/jS/Fwgfp0vEg5I0ss
         0KXB9W8GqsAD/ZPtoXA0twNWkP8B1+nFEw4655+KmM/fQl3IPJXpHrV/kf6Gi7xcCtvC
         6DSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoAYEhIPgi1U1m6ZbJz+ss9fLXlTowyaEJWmwQYKwMPPgaCVuCF1iv8fZ7R84G45d7/A9/BIeXmoFjGPr1Jme+/4UwVyBzUvZOdOsmQOgLXwM8G/G6jveRLCnI
X-Gm-Message-State: AOJu0YwKBihLMH0zZJVsFSWni+ocEsf07zOjQo9nTdNZp/+/wPpdDYgq
	GTWKoAKDP2b0XxHYGsUcuM6jFQ8g1NbtUGdg9P8UFbd+hbfrS7r4otpLzmcJXPAHiuWg03oTCzm
	pJVaiCI0UFIMB2IB1KHsk6+GP2hI=
X-Google-Smtp-Source: AGHT+IF8RFFMQuN5vGtuRwBPhuh0oAZccy2g38TQjUdEv5QNHmaH/Tohq78D8IN9/9jH1PsE9dc35dj2/YRmRw43rn8=
X-Received: by 2002:a19:5f1e:0:b0:516:b07a:5b62 with SMTP id
 t30-20020a195f1e000000b00516b07a5b62mr8309996lfb.54.1713221500147; Mon, 15
 Apr 2024 15:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-2-dhowells@redhat.com>
 <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org> <2345944.1713186234@warthog.procyon.org.uk>
In-Reply-To: <2345944.1713186234@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 15 Apr 2024 17:51:30 -0500
Message-ID: <CAH2r5msFoGAE79pS5bEt5T8a60LU82mdjNdpfe0bG4YpvY8t-g@mail.gmail.com>
Subject: Re: [PATCH 01/26] cifs: Fix duplicate fscache cookie warnings
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <christian@brauner.io>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Matthew Wilcox <willy@infradead.org>, Marc Dionne <marc.dionne@auristor.com>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-cachefs@redhat.com, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should this be merged independently (and sooner? in rc5?)

On Mon, Apr 15, 2024 at 8:04=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Jeff Layton <jlayton@kernel.org> wrote:
>
> > > +struct cifs_fscache_inode_key {
> > > +
> > > +   __le64  uniqueid;       /* server inode number */
> > > +   __le64  createtime;     /* creation time on server */
> > > +   u8      type;           /* S_IFMT file type */
> > > +} __packed;
> > > +
> >
> > Interesting. So the uniqueid of the inode is not unique within the fs?
> > Or are the clients are mounting shares that span multiple filesystems?
> > Or, are we looking at a situation where the uniqueid is being quickly
> > reused for new inodes after the original inode is unlinked?
>
> The problem is that it's not unique over time.  creat(); unlink(); creat(=
);
> may yield a repeat of the uniqueid.  It's like i_ino in that respect.
>
> David
>


--=20
Thanks,

Steve

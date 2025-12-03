Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE22DFA25
	for <netfs@lists.linux.dev>; Wed,  3 Dec 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801485; cv=none; b=ZPYejaZtqsWEtsb1ukJ8/6LLkbMcirF9gxzN6Xweq31qFE5LGJHtCoXALyX/RlW4tySehGSaVzkiZzMgmBYShXFwt7BbIZoiBu742rGQVAMyQAwbfbvb3LPnJLu7KQxK7nc7Uc+P59F+iOEQGoZrSSz39Hpepw5tW4q3sIuWlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801485; c=relaxed/simple;
	bh=TMPU0xrGWiZwINZkiG/dk9MKBkGkBQOX2ye2cUmVIjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8jFqAnxmRz7Pd/5Ze63pVrg5Ao2ag0/p7L6cNQEamsitBJD+7IoRnuqDDZfNgPq6XN+4inpmpEkDHyP2wVeoa0RepbgaAqBj2o+rSfeuYkR8KvwtLNqin1oaBUwuzB50jksukvdzKlHt3i5AfW8BzRfqw6tAqLsoNYOuFfciqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ght0y9QQ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ght0y9QQ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b602811a01so25144785a.2
        for <netfs@lists.linux.dev>; Wed, 03 Dec 2025 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764801482; x=1765406282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Andm1ZX43Hu18AjXpwZtY2kfGZSXKYycpsTeFL8sOYs=;
        b=Ght0y9QQ+DOQwdLWO/xsB9xK8QXJGbYYI06Uo6lL5ACJU+Tq8XxI0cyg/QCTB9dQbU
         XqDq2LtdmbnfaYgh9Tuy+HNcJ+6VMGB9SxxydP4rmsBZHwVH4p+0gEjCVy/esil8W5Rq
         7X1a5007QRJgnyG2rih1TRcYYo4YpJguq2AmrwfiYU4BDNQYTjGoEXMBQ/3E9UyoiJ9d
         0z/0/l0uU39HWhZb3MXTgir6n55vfwRwmBvq5j8j2MrGvM8CbqUoL8Lj8b07dCtS5GtZ
         NO7otSmYmIfFZU0C223pQaAKClufkEgSxuXbHQXUP1yMHKTqdfmnvq0PGS8Ta0nLEyLq
         s2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764801482; x=1765406282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Andm1ZX43Hu18AjXpwZtY2kfGZSXKYycpsTeFL8sOYs=;
        b=JvU9VmeQpZZE8v8JTNB1Md+zKN1PMCk8JxiJ0X+ecrAbLKMFQ2hw2+2278qbSuZ2NS
         hFlM+M6oE0eQtpVle8JzjUzKIRYhqOh7ygw6zypbeJWXRhc7iAV0FBjOeku3jRCwB33g
         5iIqAHEtHQpf3g9EK857Qq+N+HUNAKPH9kFoZxC3V2ghNJok6tAzABHnWNG+tu+DL7eu
         H5n/33w/77ijwmmCVrWm+/Kxet/UD4V18Lj9heDjoU/WzoUHP1Jm1xK6RqsdyeMPHXBW
         Xzd4NJjbUW9viwA4FXglH/zwKve0yoGknyw30+GqMxKDMkAn0pMTnMtEKLb3fXUqkhuK
         T0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVDYb/3dfEF4Iy72ioKl/1klvsQu/kow98310wq+Z8BTzau8aDyJgnyov9LrJrLpMeCsVXmog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQJ6RH/OKFQeG7rcUNLDT8lrrper0NelgXAjAPRWMw37xRDG+F
	6U1TBFB652rNkEtIFwuMMgm/+eLgBZ7Q3/zptV5n06yAIR1ak6u2YyGAkFFuKrsUSbCDzJG4ury
	n0YyVmF4cQk9rlcPju6E2VZk0WUqYetE=
X-Gm-Gg: ASbGncsvDS0L1CN5kPHoTRv6btp5efXMmD3p1azUE7xpvpyeII5BqvdRf3nZ/LG5ztQ
	6F6tCjWk0MapvJqgR5qrX3DrJ39d8Qx0ilOEbMUpYf+QlzuFcvC9BiO7JaXmuO2D/KebxdbU9h2
	V+XrRaJgh07ZpqJaAoroxr5la+vS7Bmxexk7ev/VmwoggqErjG7EnUviPMjROzy3axW25GLoAHY
	kMYN57/FkChf64MUukWuWDAnoR+Fmt6f5o3kx/vr0Pxq8DlCDKQseuKtoK7DmF5/iUAAR4XA6X1
	D+Ep7q/qdlUEnCKXi2BWOdEMNmqjnuJg2wFOXyYWk6AUVRDmGun3chtiln1Ggy6szS+z8aova4/
	xlV5hTY/zI/e2RpeWBJ9LgCIud4VFFz1+nlVHXWZPXQ==
X-Google-Smtp-Source: AGHT+IFytlRyeXS1uo6MPquKUsZiOY2RJ5VrFZffuPwZSJBbbxqOfStW/5ly+RkBCfgIJEDGSlsmPnv0qNRl59F2Dh0=
X-Received: by 2002:a05:620a:28c2:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-8b61812b33emr126161185a.1.1764801481992; Wed, 03 Dec 2025
 14:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1597479.1764697506@warthog.procyon.org.uk> <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
In-Reply-To: <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 3 Dec 2025 16:37:49 -0600
X-Gm-Features: AWmQ_blWPzWa-cXgJhnkMvErK2UGojdZhtDpX5kWgWoq-BIPUg0a3Kl05PfYHXs
Message-ID: <CAH2r5mvYVZRayo_dJGbSKYuL73kpBM+PwSiNm39Pr0mt37vx9g@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB1
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paulo,
Added your reviewed by to David's patches but wanted to doublecheck
that I didn't apply it to too many of them since I couldn't find one
of your notes

Does this look ok for your RB on all 14 of these - or just the SMB1 one one=
?

a6fd899da60f (HEAD -> for-next, origin/for-next, origin/HEAD) cifs:
Remove dead function prototypes
1b7270c879f5 smb: server: defer the initial recv completion logic to
smb_direct_negotiate_recv_work()
9d095775a0cb smb: server: initialize recv_io->cqe.done =3D recv_done just o=
nce
667246dbce2d smb: smbdirect: introduce smbdirect_socket.connect.{lock,work}
2b4e375e4006 cifs: Do some preparation prior to organising the
function declarations
c3bdaf3afd87 cifs: Add a tracepoint to log EIO errors
cb416ff96b83 cifs: Don't need state locking in smb2_get_mid_entry()
a64fa1835237 cifs: Remove the server pointer from smb_message
960cd2e1e28a cifs: Fix specification of function pointers
2fdd780130d1 cifs: Replace SendReceiveBlockingLock() with
SendReceive() plus flags
bb8172e800b3 cifs: Clean up some places where an extra kvec[] was
required for rfc1002
41daa3d4a238 cifs: Make smb1's SendReceive() wrap cifs_send_recv()
3ed72b50d276 cifs: Remove the RFC1002 header from smb_hdr
271b1138e8b4 cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SM=
B1

On Wed, Dec 3, 2025 at 12:03=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> >
> > If a DIO read or an unbuffered read request extends beyond the EOF, the
> > server will return a short read and a status code indicating that EOF w=
as
> > hit, which gets translated to -ENODATA.  Note that the client does not =
cap
> > the request at i_size, but asks for the amount requested in case there'=
s a
> > race on the server with a third party.
> >
> > Now, on the client side, the request will get split into multiple
> > subrequests if rsize is smaller than the full request size.  A subreque=
st
> > that starts before or at the EOF and returns short data up to the EOF w=
ill
> > be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
> > indicating to netfslib that we can't read more.
> >
> > If a subrequest, however, starts after the EOF and not at it, HIT_EOF w=
ill
> > not be flagged, its error will be set to -ENODATA and it will be abando=
ned.
> > This will cause the request as a whole to fail with -ENODATA.
> >
> > Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyo=
nd
> > the EOF marker.
> >
> > This can be reproduced by mounting with "cache=3Dnone,sign,vers=3D1.0" =
and
> > doing a read of a file that's significantly bigger than the size of the
> > file (e.g. attempting to read 64KiB from a 16KiB file).
> >
> > Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same =
way as SMB2/3")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: Shyam Prasad N <sprasad@microsoft.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>
> Dave, looks like we're missing a similar fix for smb2_readv_callback()
> as well.
>
> Can you handle it?
>
> Thanks.
>


--
Thanks,

Steve

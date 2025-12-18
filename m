Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D79346782
	for <netfs@lists.linux.dev>; Thu, 18 Dec 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071056; cv=none; b=c+VN8ayHaNGvsTSoOQYAVfRsmBOVeXgKJcPwsn3OgYhjUzAGC2AklJ4HNXydhgbMxVXcJvIWtcsB4s/yrC3fvjc2HzWIBRcskeYGR+O1KhAtVpZdKxuGwmzepQBBU8/Gj5WIRJ7w5Pc1OtXPNsPrwTqwea3IFFbVdQpD6yE9Q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071056; c=relaxed/simple;
	bh=wiQaayGqV6R38Tz/VLdb3rRA8ZnWrvRCRpcP9/jPE68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBUwbOppU9BWok+nl7Lsz1uWq1+maTqmIL4QXg0X2CCP2Sw0UaVsyuFM5t9et7gqRBu43HfIKxm8a1L/rK1aA3Bu8W+rpH9E+ld/l0MyAzFed8hsT2eY4krMR0Jk40h44RDebeXMYrr01/ffsrwy2Lk7Vi8caYdYc5zlKZGuX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtDgao/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtDgao/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C24EC4CEFB
	for <netfs@lists.linux.dev>; Thu, 18 Dec 2025 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766071056;
	bh=wiQaayGqV6R38Tz/VLdb3rRA8ZnWrvRCRpcP9/jPE68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KtDgao/PBomgHwUDgyrOAp81GXXc/eaMQ6zgzZxxKGNRsvszrHZ59YYou9VWVW0W8
	 MukrX24mYMKdSsNinU1WWuJja3lHc6C0kvbsXBQAeo3E6LfLzLEX88PNS0+gu9c2sk
	 SA+2Zp+4kO2dOX8Kj2VmGLACPIGY3fP7s6SG6ZTjbuUxxBt3DjcDKee1goaJmhcEgm
	 RHwevpR47jhAY2vq0H3ffiJDG7LItx3GqIbk3nf3dzkV3N/FRrzvy8Q9tcY1Br2WJv
	 CKyYqorkxI6iKW/JGEIJ7So+4P9mUrzUDrqUZh2/PQOI+FVrP+0GoytNp1nBZHxd9r
	 czkknzxoAQesg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7ffa421f1bso322889466b.0
        for <netfs@lists.linux.dev>; Thu, 18 Dec 2025 07:17:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXElV/IXugVRHe9paqAuO5NHQQ8bke3dC4Rz+t1NitQf1cQTc3zCRlscDEmOwM+TjcmDQeo3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiFZypupp1ya1mJUI2iJr0zGVubX1M4WIO2dpH2f671L0dZwOl
	WQLV4QT/yocH4KdP9RsOPCR2H9JjXVygxVfhmi/6s0LWPMUBO/4uFl/KBZnzG3hI9P9C2SS9qHU
	gR2uFEjQ+yxcB4skrU93ht7Ke4npxmXc=
X-Google-Smtp-Source: AGHT+IFtGcuOep+jKQD/k1z01d9sAmC6HG3VaUnfceAOvl0dHhDVM8Ca+5LZGkSHRIpF0xfLmjuSIV5QBHqNYKY37zo=
X-Received: by 2002:a17:907:3e12:b0:b7d:27dd:9a54 with SMTP id
 a640c23a62f3a-b8020634a93mr383586866b.31.1766071054068; Thu, 18 Dec 2025
 07:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251201225732.1520128-1-dhowells@redhat.com> <20251201225732.1520128-2-dhowells@redhat.com>
 <CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com> <611045.1766064976@warthog.procyon.org.uk>
In-Reply-To: <611045.1766064976@warthog.procyon.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 19 Dec 2025 00:17:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8r1j9Z_yV2EHyUJ-yN+Z4U5s6jNqni97SY0U+D8YpMVw@mail.gmail.com>
X-Gm-Features: AQt7F2pS84S-3B8FBwyVSpBfwG6J7RVNHTbpgdtOqDmfedWyD4ctvYVJJCzjZo4
Message-ID: <CAKYAXd8r1j9Z_yV2EHyUJ-yN+Z4U5s6jNqni97SY0U+D8YpMVw@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] cifs: Remove the RFC1002 header from smb_hdr
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Stefan Metzmacher <metze@samba.org>, Tom Talpey <tom@talpey.com>, 
	linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 10:36=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> > Why did you only change smb client after changing smb_hdr structure in
> > smb/common?  smb server also uses smb_hdr structure to handle smb1 nego=
tiate
> > request.
>
> Apologies, but I was under the impression from Steve that ksmbd didn't su=
pport
> SMB1 and was never going to.  Further, I'm pretty certain I have been bui=
lding
> the server and it hasn't shown up any errors - and Steve hasn't mentioned=
 any
> either.
ksmbd needs to handle SMB1 requests to support auto-negotiation. This
process is triggered specifically during connections with Windows
clients, So it cannot be tested using cifs.ko. And this patch will
break the connection between ksmbd and Windows.
>
> > Also, Why didn't you cc me on the patch that updates smb/common?
>
> You're not mentioned in the MAINTAINERS record for CIFS.  I did, however,=
 send
> it to the linux-cifs mailing list six times, though.
I cannot afford to review all cifs patches. Since this patch changes
smb/common, I think that the patch prefix should not have been 'cifs'.
That is likely why I missed it. Furthermore, smb/common is explicitly
listed under the ksmbd entry in the MAINTAINERS file. Maybe I should
be added as a reviewer for the cifs entry...
>
> David
>
>

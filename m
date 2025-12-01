Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EB3358CD
	for <netfs@lists.linux.dev>; Mon,  1 Dec 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608124; cv=none; b=u2B4PgT9SSewgIVdb1u2covqBXAAofQvz3tJmU7LIXTlh0ARWceTV8RkfmfekokfAn+Z6g7MQKGSzxBUSZMqii0i0LI+g8fzKbvMg6mQB/chPCgL+CRcb104/fXaec81GhSjygFm3zBqDw62LkmEkOqinzTB7q4jrNeubVLQ8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608124; c=relaxed/simple;
	bh=tnBeSzBy41ElJjUNzaDGRg1rFGe4xN+4QiZQOyT4O+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5hpToML8PkGWHZT33/e4JMMMsS4MTfMeYafzm+7WYA/RIxS41kefx6hDeiUWZlqeiNDobreJt2DyNIPLGWRgMtPiJLyAOhBfBwbXrBl+PZPnO3yjKRXOGFaoPV0SfJ8tw5hMwzRYve4O29SOTMRdAu9Q47KipJXkgUeWXtXNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNRwEdKn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNRwEdKn"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8824ce98111so67111146d6.0
        for <netfs@lists.linux.dev>; Mon, 01 Dec 2025 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764608121; x=1765212921; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sEVpko+5n0PJOroaHb42D9u1KdHljQU3qjynTesipo=;
        b=RNRwEdKngWH7V8QLgkpnFL5+QE7WNcPuIR9bBy9vZ4vFUgpQwh/Ic07B2oFNnQR8qu
         E43a4gNaUtMoeSFLOFKnbDr7NO6Dc0IlLXcrTePLqD3fcygsa8olFisrnbaqEXaoUiYm
         g8zphUTcsxYSbjJp+ltDrxqvDGWz/qLwX/54IFXXDen8Sr++zYOd7sXwOt9xfwZv9WZ5
         xJ57/oub3K8xwwBK+FwDNSwwpm8aOJGLCXz+Q2joCpuzvqVonr/M40pWmjdQHB068Lob
         d7HUsRFq04mw1IilYpDvmLNtP61k7GM8KUzIPOi/Zf3pq9cXYv0MFPMnfJ2xDuHHlSJN
         HgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764608121; x=1765212921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4sEVpko+5n0PJOroaHb42D9u1KdHljQU3qjynTesipo=;
        b=Wk7HW5+P0rRLmj2Ap/oaP9+3qBdQ/nsw0372puQd88W3301IeNJ4vVEpwu5WR4oces
         8XSmYtXIq8pGFHQ7OsHuNyz/2FPt6Rr3Tx1fYfy4Py9/wt4LCyyI4gt5gpkh6r19dDih
         U6FClA4pTxaxxsukW1b4obYMViuuCN5j6I0S41RM6HB7SnkmmKBiCbXfRBNmDJByLV45
         PjWwa5qEvfYDijktcF1HVPNJh5hVyRBTPWVetbMEqGpIRsmFm7QWZjR0x1zRF0yPtA14
         Q1EIqeCU7f3apGNIHfQuLUIdGvko1VeOxr43/yBjHv8A1WzDwVkGvXYnIAr0xU8Y+t9y
         OlCg==
X-Forwarded-Encrypted: i=1; AJvYcCXwoNwLw93evSEbOb6zR3R1tbY3bjcSSU0eTjh5cCL9R9D+IsuqnDmfLo4WEsuJuYmf37N0XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpKXooMAhpN6Wyr16MXWPoZipw8gvO9/gL/HamPpiUgmxfyWqf
	MLngWlCEKhujNYFkUREZSdcBZ3FwZwqXvdFNxFyJSipoxSUjzIVakx/aaeMNGP2lYrg979WlPpo
	Gdr3/H75Ls8ZTL+xClJtB1SJMH8QvwR4=
X-Gm-Gg: ASbGncvYUcyYbIpFAvBSktqvNWP6V94N1HoDFvzkM1cJ5qeG3+eNkWsTKilm7Lw0sKA
	qy4mrixct1/gZreUUaeKTp1QSiyF11wSJrQA1mLHi9YqakwC4zkwRGImp8mJJXvrUm2U6UkCXDl
	nJDyy0/f1yo4msVPD6tiRu0IItVlXb+fuEmKWqHRFEnhrt2YDDAPfKqSuiPf68y2NUpFhPfDmJE
	xM7Vr/hHo16+mI/HtM/mLB6G93PTRuzLaflLR2CshlPZWa4/TF0HjmE6sNCwVU7ToRHJ5YQaxVF
	PKjXcwQhLoQ5LCfX2/28VfWlXomk477mTGOa07NVGE5IPgXdHKqgR9G3zcwW7nP17+R/e0HCOH9
	fWzJR9SdGnYxZIEnpdE3pJOGsd9Q0vFFIIeuJ3kRXaV8ArphBwRpgLukXwdiv4HSOI3xXr7mOwk
	73ctUOMKY=
X-Google-Smtp-Source: AGHT+IEG6R92jICSyFXT632ttWwgPqabGo/7YGPVecrju8YTrqTUBKLOzvnujd7HCxZ6Q3MkFdRGL2qRP8TIEVJqoic=
X-Received: by 2002:ad4:5c6d:0:b0:880:4ec0:417f with SMTP id
 6a1803df08f44-8847c4a3f8emr545853166d6.24.1764608121279; Mon, 01 Dec 2025
 08:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1430101.1764595523@warthog.procyon.org.uk>
In-Reply-To: <1430101.1764595523@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 1 Dec 2025 10:55:08 -0600
X-Gm-Features: AWmQ_bn6VuRsE8Iui3zMCTDCVt_cM2s03jlNDIA4eOmN3RT6hBJvlGPPfTBZm0o
Message-ID: <CAH2r5ms9VSfTebnVe24bM7V5TVJkZgG=cOmZrxJo+RCPf1ZgtA@mail.gmail.com>
Subject: Re: Can we sort out the prototypes within the cifs headers?
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Enzo Matsumiya <ematsumiya@suse.de>, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <sprasad@microsoft.com>, 
	Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> (4) Move SMB1-specific functions out to smb1proto.h.  Move SMB2/3-specifi=
c
     functions out to smb2proto.h.

I am generally in favor of those type of cleanup patches (as
potentially higher priority) as we want to be able to turn off/remove
SMB1 code easily and not confuse old, less secure SMB1, with modern
dialects

On Mon, Dec 1, 2025 at 7:26=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Paulo, Enzo, et al.,
>
> You may have seen my patch:
>
>         https://lore.kernel.org/linux-cifs/20251124124251.3565566-4-dhowe=
lls@redhat.com/T/#u
>
> to sort out the cifs header file prototypes, which are a bit of a mess: s=
ome
> seem to have been placed haphazardly in the headers, some have unnamed
> arguments and also sometimes the names in the .h and the .c don't match.
>
> Now Steve specifically namechecked you two as this will affect the backpo=
rting
> of patches.  Whilst this only affects the prototypes in the headers and n=
ot
> the implementations in C files, it does cause chunks of the headers to mo=
ve
> around.
>
> Can we agree on at least a subset of the cleanups to be made?  In order o=
f
> increasing conflictiveness, I have:
>
>  (1) Remove 'extern'.  cifs has a mix of externed and non-externed, but t=
he
>      documented approach is to get rid of externs on prototypes.
>
>  (2) (Re)name the arguments in the prototypes to be the same as in the
>      implementations.
>
>  (3) Adjust the layout of each prototype to match the implementation, jus=
t
>      with a semicolon on the end.  My script partially does this, but mov=
es
>      the return type onto the same line as the function name.
>
>  (4) Move SMB1-specific functions out to smb1proto.h.  Move SMB2/3-specif=
ic
>      functions out to smb2proto.h.
>
>  (5) Divide the lists of prototypes (particularly the massive one in
>      cifsproto.h) up into blocks according to which .c file contains the
>      implementation and preface each block with a comment that indicates =
the
>      name of the relevant .c file.
>
>      The comment could then be used as a key for the script to maintain t=
he
>      division in future.
>
>  (6) Sort each block by position in the .c file to make it easier to main=
tain
>      them.
>
> A hybrid approach is also possible, where we run the script to do the bas=
ic
> sorting and then manually correct the output.
>
> David
>
>


--=20
Thanks,

Steve

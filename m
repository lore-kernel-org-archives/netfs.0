Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568680C15
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370060; cv=none; b=q2mgEz9da3VD2KgTe6KRgVDlx2nWr7DMjDjWEvDDgX600DdvUqKvksizmBT3gvraZTP3iffqMxKzeZL08ix1vOACmK9Q6Xv+Sc7ise+mqCk73PBZOGsnzkB/Ho3wu6oOCHMsZA/R/RiPKiATVtN3RufI9ZKmN8S1zX1HbRHVEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370060; c=relaxed/simple;
	bh=yIYBXGdl869XX2pTr1QmDY+AP5o/usnaarQJoGjwRv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI9+YXFEtSWwirFyMI9e3wBuTILZPefa4IhQe4rWhHVsUFSgil0Hg/23PeNHH0X6YZCNzWE/sLsWpaMzWYCEd1WyxDZ3xZ+h/ULairMx7jF7JiS0T3AF0Z+yEJzNWfX3B9+uCPdHCWL4dWvTmU4x6qFdQ124Zl47Uow+FAqJ+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL2ObSzG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL2ObSzG"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f40b5e059so6803044e87.0
        for <netfs@lists.linux.dev>; Wed, 22 May 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716370057; x=1716974857; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3RHkz1PAC1a1gnJwaqPWf+2yMWWiU1EZBBXLHMWkG0=;
        b=XL2ObSzGVqI7vCnUIghwijpRYd+UUNSJ9aL/piMLvMtDTT27nOykNlTYPMuTPTKgpl
         ByDFI7f+bWl8oNEsGKNMyTV2nN3UbBk/vQnTV3+EbqKBEutvy+uq5qK1OqJpEyrLRM7d
         bsNerjtCGxG/JX93SfbtqgQHtPRbOjzuapF5wNxAer5ZijWYG5rbs4eoxwib2PeDLriX
         FBggtjkhlsxCkFLwTzht/KKhlBF3Yb+UF+lZEceRZ2sRACkZk5vgn9EDj0nYEZKn76CC
         Sf8yOd8Lqf8FPwVZdKx/IYSZUnzJ3gMLMFf30/RGl5HZmaUGppVgaymFWxosqY4xd+hJ
         w9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716370057; x=1716974857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3RHkz1PAC1a1gnJwaqPWf+2yMWWiU1EZBBXLHMWkG0=;
        b=BNU4QgKAd4/qvFg99ZSq9gr6WW8Mv5mGTFaIf7OsrYvJfdFR3R4HHgu7ZLnzqMbodF
         pb7ER01wZ7rbnWAIr3h3n287EfdPxOeNGYus91VhS5j2TssMtiXf+fl3I+Uwmy11bXio
         oAAV8wMjo+AgMSE2s4tJeVO1K4XZuSIGx6no2M+k+x0GZDzro0oq8gWdzlgwKG+uIxYN
         0IjyvM+FXJMfZjeVVjCzSyAhct81Eao6TZFmRgzsLGjJB28ffGxSCxMEYaiel2vw92ps
         y45e2UEdV4Oge/xpm91L/r7tPvFszWXhBre6fUh6i+/H+mcKSNFGYLnpLVypFBhNurlf
         M3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNljFqYCxG2f+8sOtJVrBWsYXWyQUGd9ZeVdC2YIXFHBOijE98rvi9UvnIB+pNt3OdiSrBF5qOB6TfcSxByAXhCviTQ04=
X-Gm-Message-State: AOJu0Yz8JFOleCUbKJfHqjrgPJJAlY6Dg9g99QluwR7+3Yp0b9UEQ0OP
	vl0N6PAOLBy7tA2zExAn3f4vz316E0qo4c5PuJhiFIXeBr0DCvVhVWyvLNzL1sKWkdzuyHB0ALp
	1l4+GV1ehUg3VvzXKvXQ7KKmGDac=
X-Google-Smtp-Source: AGHT+IEFyirCOQaf4B+kNykUPvpKVUgbY2KUycXUHf9UnyJn6uHYcrCR1+MiVHLL/L30cClXAAGye9v+HQ0A/uuAH5M=
X-Received: by 2002:a05:6512:4dc:b0:519:2d60:d71b with SMTP id
 2adb3069b0e04-526bdd47f63mr896360e87.22.1716370057087; Wed, 22 May 2024
 02:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <367856.1716367128@warthog.procyon.org.uk>
In-Reply-To: <367856.1716367128@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Wed, 22 May 2024 04:27:24 -0500
Message-ID: <CAH2r5mvhyrtXSvS4du4_iHO_X=bjrhPoyn4iFCrTVhbSo1eVew@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix smb3_insert_range() to move the zero_point
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added the patch to the test branch and rerunning tests on it now

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/122

On Wed, May 22, 2024 at 3:39=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix smb3_insert_range() to move the zero_point over to the new EOF.
> Without this, generic/147 fails as reads of data beyond the old EOF point
> return zeroes.
>
> Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> ---
>  fs/smb/client/smb2ops.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index ef18cd30f66c..b87b70edd0be 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3636,6 +3636,7 @@ static long smb3_insert_range(struct file *file, st=
ruct cifs_tcon *tcon,
>         rc =3D smb2_copychunk_range(xid, cfile, cfile, off, count, off + =
len);
>         if (rc < 0)
>                 goto out_2;
> +       cifsi->netfs.zero_point =3D new_eof;
>
>         rc =3D smb3_zero_data(file, tcon, off, len, xid);
>         if (rc < 0)
>
>


--=20
Thanks,

Steve

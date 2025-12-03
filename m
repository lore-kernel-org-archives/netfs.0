Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26B2D6E4D
	for <netfs@lists.linux.dev>; Wed,  3 Dec 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798019; cv=none; b=o4baiRFXvTsoZS1S9qcO8KVu/y2kOgC0ZOaW1TQRoJ9ETg6cBAgYHEMQP4Bxyxkb0t05uXNzaOLFMPuMAdJpdAtGxLUN1rlmSY4hMb7ZlbGapqlmSuEwb0IenD6WEsGFueFqWPz0+msp+9ENl3Zb8XJHXXBLqjUI8Pu0HBorvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798019; c=relaxed/simple;
	bh=4mv07ydDIBDY+yYYyDcrBWUbY7+M8hTG8ElX+6UDZ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI6uBaktcQcvowL5rWYjETZoV+5vEvzDN6UfXIlFI5RzVwcYRr0PCQclnqBDWc0Y2ePGu8l9A0UCAF/XtNbKMMyXXjfRXpX4dWz94ZJUIj48WBb4ZODmwE3qBlV322/uRAxFNbTAyQlm9HyNsS328Uw/hX1nH3kVOCjzEjwMV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkmoqE/2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkmoqE/2"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee158187aaso2733401cf.0
        for <netfs@lists.linux.dev>; Wed, 03 Dec 2025 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764798016; x=1765402816; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4dm3yP8EhvjXM7HY/9hUsT4foK9V8lDuxE0CKRUWT0=;
        b=CkmoqE/2g/t1KS0Nq79gAQa/t4STXMwbGVmsrM3NUcsDSwC1dsXg807PSEj7RuCvkS
         9uqmnikvX/rG3jdVvJlZboI/fAmdiQst8f9fC9FIT/gkt8FBBkHIQ289qH3jnDM9dBrb
         LldYzgYMW9dEEEnLKmf+tb9aIFPq5IbCKXOvd/IvAL/2V5A7v+EejkEZbLUFc5uzraLg
         k2Fkk4KXACOp/pudC22EydUcKPmderL5pifxGSzo4bFsHSD4yXZAZ92d2eGiXN+4dts6
         R9sGZLiVL4DGKr5AyxFxB0oCQPtcM/ZrNjqP2gvYhCPl/z05VdzwrGNtk0MHvPCkXrA6
         XKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798016; x=1765402816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q4dm3yP8EhvjXM7HY/9hUsT4foK9V8lDuxE0CKRUWT0=;
        b=IU2niHh8MRdaOyw/ZTApX1M4pxaLmIAJd3tzupfoBbYK/PFLBZj6ukph9Xf4UWLsQa
         FC3zE9UX37OZWUTdMceA/+uS3GkKle0T2NIhU8UsM+GH1Pva94FJeMsEpL2/NURBGnV6
         XsEXlJtN4g6S2BeBOpu08Tb74L+Wg3OA6cOyXacq5fT/EY3njEiVVhatZ3datGGw9uun
         RmG6Z/qdzriWf2ottINmtdHKrQdPwfwAMhoKT+nU64j3JeNjblDlmmWqFS/TDpTk4gpE
         b96Za2C28OlpaTs5gwY2kVphOpcuCL/tPqNPTunqN767NBSWVlrAE2RExavoxGPy+3VX
         kkIg==
X-Forwarded-Encrypted: i=1; AJvYcCXE/Kl/CeolH8BQ60yVivMsR2+EEx1+ONTLZVve4lT5vP1nXqS8GeMkmWkh/4jUILULLaBpzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqvgmyqCnJIEJdQFtsykKiRkxNID0n9Yip4mkwMJFAz1fHyO3A
	vmmkc4Y8RjUkvFvl75LL2TCedBeo9DXTTPEFuOLF/nWbKL5FFsJra0ZW88IhaZyj9738nY8PrHL
	gAUyxRLYhisfxYWbUKbcYcmu2q+Z/B8w=
X-Gm-Gg: ASbGnctE9PAo79sueTt0cycst15AuERBRrpfapnGsPF2i+Nd4mmVBG2uRDz1h0jhGPJ
	gfVa4T+sQQrJiNLkifKNKiUXXIICnJrhqPfi2cRpj919NvIPOakjMOvPQF7fiflCWvO0/7RWNPV
	aX8mGVac3N+KtR36wjMaaz9Tgft2zztxPJ87HkmI9aDDrbUf56x9lwr9wrCDhRUnA4fnXnPm0ho
	YQ+v6I5E2MiATXf8LKXqjVdjYgPFbV8zNqiV9Ip2d43jzVjmad79rKL9hFbUBc6I3IvbfG2HBzI
	Rnnm4mM4gMrwC9PUm084W1gkxN5OcvDjiPTbwcqCN06M2D52kTAb+MgDXsOG2h0cJZ6p36+1alZ
	n1jGi2xnwyKGmG8+K80c0tqSjQWKGYt3UpWBj8S0D0ls4t34hMhgZgGlte1eGo8torN+DmmejIC
	11t6/yq1t1/A==
X-Google-Smtp-Source: AGHT+IG1RqtM4CjFZIoV9HQ/AGJf69t++XxRfMRR9/KEWXX168CW0sh0DFIGvs6Sts+Nzs+IjWJ+CH1r+PDY8raGX3I=
X-Received: by 2002:a05:622a:188e:b0:4ee:4a3a:bd10 with SMTP id
 d75a77b69052e-4f017691727mr61297771cf.60.1764798015667; Wed, 03 Dec 2025
 13:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1597479.1764697506@warthog.procyon.org.uk> <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
In-Reply-To: <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 3 Dec 2025 15:40:04 -0600
X-Gm-Features: AWmQ_bmPZtnFFmlM888CIxDrVHAGDo88ZyE8SdWbeAXL99pNPNJhCXfBTmmIgG4
Message-ID: <CAH2r5msAgsWfnCt171TcmhvCw39GtQ8nU8SwzrVpP=xw2vGypg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB1
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Any luck reproducing it for smb2/smb3/smb3.1.1?

--=20
Thanks,

Steve

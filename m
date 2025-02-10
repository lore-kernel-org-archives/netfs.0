Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EA2566F9
	for <netfs@lists.linux.dev>; Mon, 10 Feb 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209519; cv=none; b=bsEaRwZxko5JhQ4shkF/smFRdL1bDyuoGowo1MjYC/2VSekuonMTIPBAq0axJInvsaG0S2vGZGr6uPdAaYG6RY4w43mcgPUSxCGeOIoITfxmPW/Dd/CUCgsoxmXDciRN4kjbzip72+FS+kMVNSW/OA11MS9P6dm7aKB3wCgD+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209519; c=relaxed/simple;
	bh=fdNx1DUDaVtYdgrnYwf8qDr5+EznUmUeXdfIPP1MsRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGAejXCxwnTLUeaJTlqymfIclJUA1+gU0RyFh7Jt5nUzHPKteDqdd4kB1ozJfKt8H2rqtcBQqY/n9BS186R45ckmjPG4XTBt1/b5ncB+MmtmI7uEIFujPPh8ogYGDeseJdB23RmV5zoEpAsjBkak2eVuCVaJpQZX0hxtBelWw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Kj4QBK9L; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Kj4QBK9L"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab78d9c5542so584512166b.1
        for <netfs@lists.linux.dev>; Mon, 10 Feb 2025 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739209515; x=1739814315; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdNx1DUDaVtYdgrnYwf8qDr5+EznUmUeXdfIPP1MsRA=;
        b=Kj4QBK9LP+9Y6CIuctSz2F0kxg+2ME6RRRE6dF0sItzqInhdxsaehrXMpTfwrspKy6
         o7Pon3rNax4CzCOshrV/rw71CAlLdIdLSvX6sUsQ+Ju1sbphhTakx9VW/OGMikOf+aVW
         7FP5j3q1pnyyY1KB9bvEmBf2O9wYzdgWZsvbIOgAZ8p11Mcs62lRjHgnN901Izups3cM
         kg8HWnn/iJipK87PdbGt3eylzvuFrR4H6B/gcyvcfpYZ63jcqkTNxavKm5pvl6i9uhVY
         RGQifs1FcWhiBpduYgnIM3ZEenyHprY27ejRfLshg6Es0WUVrdUfqBPg1mXs/KtkRvkT
         GIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209515; x=1739814315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdNx1DUDaVtYdgrnYwf8qDr5+EznUmUeXdfIPP1MsRA=;
        b=o4FwW6h0BT04Ooe73vbfkXG2/i/HJJxTYc8KAmaCHKQiqYKEf8jn0gQXKQ6zK5afzZ
         qe6JUSEx6bzSx4Rx1y9PvDUeGKTQYu/Phkya+Jtx66+8i/ztXf4q43M+bl8zR7+fRn7G
         SvHQAohHe+DwzPrh3avgAeslazLQH51yLx3qs4Z518mmCxgX8lUZY4EnkvFRfrPKngNY
         pBg6PLV837HyfHUQkKVIw7UrKCT6arB8h5uW5Me3nXRuQ6xSqN4dJdzwBL7Uj+pLoktx
         LRemxw8G2hRooYP6Catu/xbKLYHE4dUVPUDyvsVGsYp/gN1MNSGv9hlgiYdjWFqYtU/2
         oNlg==
X-Gm-Message-State: AOJu0Yw55GfCXLRO0EPvfxaGBwpZST4QsFKhFem6GYfq9JsWROs++Yyg
	aG1WwTqw3SKQazun5n7KJnCZDo3xihi+vZEXghMV40WfCWU0eoegHEI9kPGIVv4FGD9amam+DUM
	rQXTJusjHeJQP3F7BjrzRtSpytvEDzVHhLIt3Sg==
X-Gm-Gg: ASbGncvmx3f+PRHWTTjayA7EwL0A1RCbJgADET8CcFTGxZI62rZIkT4jtDJSXPFHuxr
	3kgi3j5x1ltQcYOARRMYRH4o0AMSG9rmDVRDYzHOcS4w4mYw4aGLAlzBEMXXQQrG+om0q/m6Vkw
	FWegUAMbrL3RGNrlyInObxhxCfHQ==
X-Google-Smtp-Source: AGHT+IGXUbcrbs9jCJWCCDSj0H7A7skcP2xO/8QiwRx0Lv2OP1hLehSE5+2+D1t/ncKajx8/C0dIGmPhKHOCuJcDXr8=
X-Received: by 2002:a17:907:94d5:b0:ab7:6c50:5f19 with SMTP id
 a640c23a62f3a-ab789aed850mr1642511966b.31.1739209514948; Mon, 10 Feb 2025
 09:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <3052002.1739196466@warthog.procyon.org.uk> <CAKPOu+_tjkiU7mMC0mCwhH23BQ03o=QTgTH60TQ6=aC4fQr7LA@mail.gmail.com>
In-Reply-To: <CAKPOu+_tjkiU7mMC0mCwhH23BQ03o=QTgTH60TQ6=aC4fQr7LA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 10 Feb 2025 18:45:04 +0100
X-Gm-Features: AWEUYZmS9NnwMn_wzMK0r5f-lnnWPNLNfcts3sg_BGm3yC1zJ8jSxnW_V6mGylE
Message-ID: <CAKPOu+_Cbkq7ROF=azCnWNcgDS4V=SyKC-_ixVo9siyE_SOeow@mail.gmail.com>
Subject: Re: "netfs: Can't donate prior to front"
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:41=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> Additionally, here you have a file with a dump of *subreq and *req (of
> R=3D8). I have added additional fields "start0" and "len0" which contain
> the values initially set on these.

btw. this happens because there is only one subrequest (R=3D8[7]), but
the start offset is being rounded down (folio_order=3D2), thus
"fpos<start":

 (gdb) p/x fpos
 $5 =3D 0x1c0000
 (gdb) p/x fend
 $6 =3D 0x200000
 (gdb) p/x start
 $7 =3D 0x1c6000

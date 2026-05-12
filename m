Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABB3E1733
	for <netfs@lists.linux.dev>; Tue, 12 May 2026 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591286; cv=pass; b=JNTVtmEd0XrFXT9enkeCpr0zYQIMQUFn/S2kqi9pY/wf6E72Hu606yNRUo9EeROR8dxn6De98k6rLbTzhS17uRhImEympFXJOr4Gv8nUYT9VOosqD3N7TC6MEl2KmoMwGKFLVnKKDxuGi7ynNFRoDp8lhw/4Tz8HJ6lTt79cFnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591286; c=relaxed/simple;
	bh=+vcfNdRtvwQHAPFi9qeID7iVjTEIACNb7t52akS/Gx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lz9wbJIJUEbZi/fHo/rG/fPX5WrPjvq/LB4D0bdiWIHOot2IzYdOutzNyMhTvhCLttEW4wgwsboEd8G+AilQgeK1in0JOO6jDTqtnJiAVRfkgCeL7Em798hpO/IYK3BurFVoU7vUXo8TBCEsjd+448w+D/wfd6ABMlXlY0ZAKRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9k777rT; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9k777rT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bda45035e7so6412277b3.0
        for <netfs@lists.linux.dev>; Tue, 12 May 2026 06:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778591283; cv=none;
        d=google.com; s=arc-20240605;
        b=h0804hztqhhh0Xh0CPSza/ejnJFKiW6JmwYyXybIw/TRz14DOjWlT5Sj9gHOKj8ZDA
         yJ52YsayevxDslOdEZKEvTe3BN8NSMxG/Ift5NVbjpMAWvcZX6OVsMf/S1eM8dFJOXVa
         l5oXw91kJp6ms5z4r3Wpf0702zGsYlRrKigfozj6ayBv2JStgUSHTF5m1PPOlLhK8rjA
         ZRmxvl8HvpwLvoM0zoSySpiEzWACOClXGo6KwNTHTySbmtjM7SRjKkKVLJVzC62h0wBF
         jxPJLDWX8HcEty48i41rhhKArRJma/5H4Sr/MvmWvRNWUmAcu9J6z8pZ9NsMGX12u0nS
         yRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vnBWAAshyrw9uW2waQU9UJFxrzx86ul1N0tkpGj9Dmo=;
        fh=hmxUlKuoKwtslLt5FS2PVaXG15blorHgWu4Wyz5BLWg=;
        b=fI0AR6OkkWeLblDMzfto7cSp68+DUVTUgqew0+6+dlO75r0poQbnOG/5sjlR4CY/nA
         p+0lJzsZs3Fjqi11coqhi4nD7tZUhLL1Xby3TAmf5bBPko+a369fMbAsiT7AB+Q6czKa
         bh9XPviRiH43CQdWS4VErIP/pSY/TE/5thxEmnRqzKqiXce4nanNTP5EmYWuNFpjdL4h
         fywPCJ2/d76O8Ea8uqt5xqeiO1MBjsJhyqp5vLAy5AhoZq/TZbf00PepRcPMAk1faYdO
         riLve8G/ZTg4mRfggR7r1krTq5hE47mPLnS3uF3mK6bML0HmcYZA/5UN6iOFa9Vsi0Xp
         imSw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591283; x=1779196083; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnBWAAshyrw9uW2waQU9UJFxrzx86ul1N0tkpGj9Dmo=;
        b=X9k777rTOvMkMpc2FDt5rFc1CE0uYtPm+gIrXbe8cKlyI1tVwXjhLrA9JYrydrXozW
         B5j1HlSN1f3UOnuBHmNo/JGrZLP8d/aCIwl2I3WjH24FUAkAsQCcO6lejkuQuIlw3rPm
         cDYg7ExPFmlLuA5g28dNI1TZz9+7HoX/cgB2JojShKmujwHqqnjtO6+NbGFxkTSerX+C
         ImoTWN3bJWiQNioIoh8qTkiDj5muI+nKj0RXcynEOjZulhVP07S1e3VpNoTmpRxaUWq7
         eak3LQQmOtkb93DLImY6seELLcBiQt6R+uiYTvOrA52SGUlPC0kUHYbeh1H01XnywJFg
         GSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591283; x=1779196083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnBWAAshyrw9uW2waQU9UJFxrzx86ul1N0tkpGj9Dmo=;
        b=Hht4l6buaZoG9kvcfgYi3dPu3l+agZ9y++tHoGRq1pf5evBC7JDylIeF6mHkZcQyMo
         HvnfZotb4QZAb8WwNF0bJBgaz3aOwZIPcwkmO0T13PSQY29pFaMgnX87Lo7oUIEFFZYn
         YiPT4H/2DFNdlQxgZ3IRmFo9B00IQXL9XPmeGZZGUOjD5ggOWYA1Qna/2MR7He/rZ7Uy
         LfxkepzPYyT0IFRNyIQFbGbCe0g8ZQoahNsp55h0larMMC1c2qr4XChGNh8M0+H1uDmv
         08p+cUB43qu2aH5QkxKpEf8+ueiS8SiYCX8RYf3toypn5BiyqYLclfsfCxS8ZAEvbOer
         4bxg==
X-Forwarded-Encrypted: i=1; AFNElJ/+7Z5RH5MHebkB16RLBH3LvWkH70hJncgVJ5UAYp6nu0/eZYjCUaaoy/0OvGbmiVqz70L+uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhYmAoKt3XkDXM+II9VROJGHTBGQndRF/vme5ACsxU2EtKjWy4
	fyQwz6fDyl08YoWcSi9pxZfqB2WRjAh9po2u+L8wL5kFeQ9EsIIAIZaG9cjaaN1tcdEfjDjISCw
	KG0AmMdnt1mf+RbQAQEpa+vJFJCv3R3c=
X-Gm-Gg: Acq92OERGEmP4Zakb39MO4SqGfFpEXxpYTHe6ZPuVKUHrATGEjscDgEdU8fAdoEVttF
	qRp1j1TPM7kD/UG6ma1MsLSg8Xlu0bgzEJBikTZq4rm8k2B/MhEw0Gc/Z1tMyGlJwEx+dArI747
	FBF1c4XaZ7Q240NraAN3/jISpaE/G5KBDHJPKFgNornhaBVlGPDQvcfr2hwOAvZlshayIY5Layw
	0RBLLmYhOcF5u/TvhRIyykgXzFU0w60MfRyEHziFFx9KCRYLWqt+E+2hGZjFCtKsnCADuNPSa2T
	4qJcPJbr
X-Received: by 2002:a05:690e:13ce:b0:65c:322a:7ac3 with SMTP id
 956f58d0204a3-65c7b70bfbbmr17655158d50.2.1778591283371; Tue, 12 May 2026
 06:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512123404.719402-1-dhowells@redhat.com> <20260512123404.719402-9-dhowells@redhat.com>
In-Reply-To: <20260512123404.719402-9-dhowells@redhat.com>
From: CharSyam <charsyam@gmail.com>
Date: Tue, 12 May 2026 22:07:51 +0900
X-Gm-Features: AVHnY4I7C6CzYKo5rOIaKeFxn1UK1vSWmDrEYuJGWgiJZva0dOf3Ebu3U-sXK3A
Message-ID: <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
Subject: Re: [PATCH v6 08/24] netfs: Fix potential uninitialised var in netfs_extract_user_iter()
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, David.

It looks like ret does not need to be initialized to 0, because it is
only used after being assigned the
return value of iov_iter_extract_pages(). In the zero-length case, the
loop is skipped and ret is not used at all.
What do you think?

Thanks
DaeMyung

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:43, D=
avid Howells <dhowells@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> In netfs_extract_user_iter(), if it's given a zero-length iterator, it wi=
ll
> fall through the loop without setting ret, and so the error handling
> behaviour will be undefined, depending on whether ret happens to be
> negative.  The value of ret then propagates back up the callstack.
>
> Fix this by presetting ret to 0.
>
> Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC in=
to a BVEC iterator")
> Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%=
40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/iterator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
> index 154a14bb2d7f..6903028b7162 100644
> --- a/fs/netfs/iterator.c
> +++ b/fs/netfs/iterator.c
> @@ -43,7 +43,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, =
size_t orig_len,
>         unsigned int max_pages;
>         unsigned int npages =3D 0;
>         unsigned int i;
> -       ssize_t ret;
> +       ssize_t ret =3D 0;
>         size_t count =3D orig_len, offset, len;
>         size_t bv_size, pg_size;
>
>
>

Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0343F4B4
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586000; cv=pass; b=QgjV14332s2zQj5stes06N0dFmkwKtZN+2x59E9gjGWZs7p3YxfcqRtLPUkVLihCDv6yiJkB/YWp1lmQsz1ZJv9XyqdOZsxEKe8HOQFn8eQoDtwdVlMuMQPTraXuNOREA/TawUDVEXAc8jNAhhhgouDFJWS/L39PiKImm9JoE7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586000; c=relaxed/simple;
	bh=TKa+7Rt0HMct/L3Y9OQKcWqR+kqwOl5wJxjs0oMkUU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWxr0g7aPnJa7eStHAvJVJmXoX1jwIdWYC8zVH+O/xjPLVTybRaeymtiL8RpwbKGmUv2+taB8xeeW2qvqvwBymnDGy+wPh1bUPmbax9Qb+H78/rxbFkiKLeFV5S9n6NgBkLNSrITlGtTLKw4irMzpI5zSxd7ekaJwU+v7RXtPow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF9exY83; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF9exY83"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so6893276a12.3
        for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 08:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585997; cv=none;
        d=google.com; s=arc-20260327;
        b=OHYssQS3Vj33srO9eAlJSzDZci0Qop26f3reTLuckclFl7n05giOf8yPA4tUNvVUtS
         xHW4HJppnozWPSdsxUKzxO9jt9sZ1tHg7rgMDg5F1XWOY39yii3xLkD2PFGqMfcInuLG
         BgWYB6k9GO8WPer+jofl848alKtnZm/aWyZ6TBLNwA1S+ZXpiy33fuW/00hfupg8Dk1P
         VwkUYTZWgMtDJCpDMOZNGTRklkSaCiumtQeNIJ5scC55YOsBqHhn9WyWj2021u2ZVzZh
         gVKep/xTnSnNZTd/07Und7nUuS5Q5psU/86rHsvKNzbujV8jkTQZ9e0yCkaCLdr7oZS7
         epBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        fh=5cehit4jum4ie2TJPGOgBiwIRWIVMxa6JbRUsQETkUo=;
        b=mLAfGlY3J4LffaJeOZ/EmsE8xaonyy0BQc+5YvcQImikVCCeI3KXl2jWZ2Ad6hY8AA
         BX7TB2KO6SRPvdN1j+1MIw0X9PAX0cJJe3u5JohpLdc/7hzraqb+ZlXTV5RnO54d2lEk
         GUoUt8fbJhdyi/LA2HPjIBWF7c8TsZJtcZ9XHs4vfTzwES+bf8ds31BcLSYGsLRhzdD2
         JVD3KsAcvXS+/U3VGdERm4IEh0K7pVJd6N6QifPm6qmvOPLyiE9VXsjcyedQBMAwIrTL
         ZM2xyQG77AqRZB0EL2WJnY4Edh+QLUtpmcCjSowkhAG8i2yl6dQRwJBJXE7KhNasqqU/
         z16g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585997; x=1788190797; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=EF9exY83GnmnKwCFq+MyF0bTN9FWR8NixMvJc/KGu3u+fgbfvYnYhxKiDOW5vXx20v
         6bfH0iWj3zwv0eWN3hEES4Bhs2NyBF6zdd5vpBuqFwAk9wtLpb1XN0tkA7GBFBcaBNv4
         iWbt1+UU6nHQQuMuLNozvqW1Vb3WW4d5sKUBD+zDfeSGNkh4cZvgYG3ERDSWmu67PdFq
         rn1byrrLSgVTjodqyxAVjhd3WcIEqrrjeTrVJeCB0E05fkBohsNnuTRaVyCUls4NOWwy
         dMR8zmeF95RuVW/pgGplSjnZ5DfzUALk7qIk0+GO7z7UeIADWKnkF9At/zoVcjBjbVTv
         +f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585997; x=1788190797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=W0w5TkWN4oBIL7OoBUL/T0nAYB58op0viMvpnG4y2FxAonr9LIckAzzJbApOV3Q97j
         7H1TDp5WNNqsPn17hD+OZcWBiwNMkTYc9TXKOdkTs5QUDqhccWBesuZA+zT9ciTKHweR
         3Qeg7be4W8GWRi0gYfwvYicCQIENAXJbVdKOniTuQk2Go27T/ZRWjSPqnyo68RP5jNMj
         C+n6MyneQhlgIfPOgzjbedI27p6RJW8cYtrF2KHBPPMrP5TQSyR3/2m6MjS7Owvkg5LQ
         +MJmK4N6ysTYHfsdn3KAFghJqUS36n2aCREvKw3gQOR66AEgPApqQvULSzZ7R3+i7Ar2
         RZCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqm1galR2RGn72cjp7Ct/ZeO9J45144U5qcIEi5KHpcvVnOXYcugef5pXvSKIGxp4rV4kwOKg==@lists.linux.dev
X-Gm-Message-State: AFuF++nG+JRJpOojrQX/n5Yx+HJOMpin4soSzM21on5e1j0vWZszDuJU
	7gQxR1GUCBZ6+H1wOg5I1In6UdYhht8GPBfpIXrUfZpgsGI0RbV7AjOfmeeAqxC4/96vm/1reFx
	vl2YelTKvT0mVUtPmazEXQHcHzcJy4JU=
X-Gm-Gg: AR+sD10CWCLmZeuEZfPhmJc6EsTXObhi1ug5nmSK1jfmryWkO+ALb/PaoX6SIbXkood
	EWNC/m6LIKNByTWNyGUoqN8QcIFwJdAA0NYxri4HrBU+W3hc1n+9LaYfRoDumK+riqkSEdlVTOg
	DZk37cxA0JX8sPn+lkXqcbBuPUX8AEWN/RuTihS5BrmGtYnn1mIUl8fvUvvsivor7KHH0PXDGd2
	7mNPd9vUNHyf+c1UYybSFWfL7GJHS9LAETkTtwbMmq8Ps3uQPvgfBzq3qe+vMPBLCSyoCpwptsL
	jU+Te2KfWA0J4xrxilj8cqDUaVcxW46v0isaF8iM++lM6YJpyl0p7O9jz54LHx5N3bf7Lsd4Vpi
	X
X-Received: by 2002:a05:6402:1ecb:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a42eec0421mr29612154a12.0.1787585996720; Mon, 24 Aug 2026
 08:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260824144130.759997-1-dhowells@redhat.com> <20260824144130.759997-31-dhowells@redhat.com>
In-Reply-To: <20260824144130.759997-31-dhowells@redhat.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Mon, 24 Aug 2026 17:39:20 +0200
X-Gm-Features: AcwNN1UVhOm3jvQyZ6QNY0YG-DuDugP0zSGCGTU-9BV_0e1-yGju4sTdJrlUq5g
Message-ID: <CA+1jF5qPZUhCevwbu7zQDEVWss6gMdoDMhqKqH3k7v=WStRtEA@mail.gmail.com>
Subject: READ_PLUS in NetFS? Re: [PATCH v10 30/35] netfs: Simplify read abandonment
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner <christian@brauner.io>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Leon Romanovsky <leon@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Stefan Metzmacher <metze@samba.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ceph-devel@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:04=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Currently, if one or more of the subrequests in a read request fails, the
> read collection algorithm will attempt to salvage folios that are fully
> downloaded but that span multiple subreqs, provided all of the contributo=
ry
> subreqs succeeded, but this makes the algorithm quite complicated as a
> subreq can contribute to multiple folios and a folio can be contributed t=
o
> by multiple subreqs.
>
> Simplify this by just abandoning the rest of a read request once a
> permanently failed subreq is hit.  This is what read_folio, DIO/unbuffere=
d
> read, gap filling, RMW and write preload all need to do; readahead is the
> odd one out as it doesn't have any return other than unlocking folios.
>
> With this change, even for readahead, the rest of the read is simply
> abandoned; read() and suchlike will call ->read_folio() on each
> non-uptodate folio to retry and retrieve the error.
>
> Note that retryable failures still get retried by netfslib as part of the
> request as before.

What about READ_PLUS, i.e. sparse file reads? If you do this kind of
work of handling partial abandonment, can such a work also benefit
READ_PLUS?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

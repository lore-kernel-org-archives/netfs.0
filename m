Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648C1A6197
	for <netfs@lists.linux.dev>; Tue, 30 Jul 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356931; cv=none; b=ZXw1vrKcCED8zZzgp0Fn2sJPoNJ6ZfpdR+AGH169XO/k9yapeoM1XlyGTJ+qvcLiS63P7p3DA8cF1uoH4gJ7U5J4Ou2+Jj0mZlZzG+x59zf8/UU+JFS9wAYJTQCiRUxsVJHcCQDJ5eZ14Ymhb3hTYFQ6Qc8ZquPu4P7p42mKaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356931; c=relaxed/simple;
	bh=/WrqX39V/EGZlU7gkM+jA9j7Jyn0OjEJ1Mehdy12oxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUw9lEXt3DjadspNYD9GtdHaBaQlasr+FpTjyZk/zvwBPirsExteCaaNclGyptIbrr0Juw8DQZOH0sww/K1HnoLioj6bKhGB3ATSG1sKMtXRYyeeJs0Fzu29UQ34nA3TUg+SH7F+cVA+ammA44pkxZeDMERStEuwKo/W+artd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KeQOePq/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KeQOePq/"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so618729166b.1
        for <netfs@lists.linux.dev>; Tue, 30 Jul 2024 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722356928; x=1722961728; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=KeQOePq/lBMgI2XZFUJGY9ItM2CaOfFAXUyfdIzlH1ZhVKezC0mGQ5MxMtyD4ozk1p
         gWjKKvENu2XLWGnQX+8VbTyz6Q3D+kzcoIuD9CL6BpSapHvPFBG/PMEslgZKaHgansl2
         +5XM8XLOvN+oRZjal6r9YJePGhSXXyBmj3GWJm8cytMXJvijwhezgk7fu/Rvf/r5mcWM
         R38a5mSJd+SkVAip98kTF8xRyNTFu9ZMEJA+Slpsq6Rm/Eg4CukdrSyNryMw71EA2O0p
         XGbqk0iCJAeyizNI8eocPKYuflqp4OMRVJzP1MDLeE8DyQaQdO5PZIF13cTcW8VlP6uX
         4Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356928; x=1722961728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=iGkzR6gzv4bkdpOWvm+TDBbEJeQzv9+ducXGlPKHCEsCHPO2OlwmYffozT+/C9Uj6w
         D6BPvjwixFVrdduvEOMwplC+XjajQfzfiqs8JDTpNRYlnMjITJEOJ/et81XL8q2uLbuj
         /OzXB+K+CjF3XISckcqIYWV3h8dIstOHSZIuw+AP2zjMIL/+BpzIQyOcTsNjRVUYslvr
         QaGYrEm65aSkyo1oRS0+lAI3pZmYR05PeKblQDJ+x9UAuDFY2zD6Bm/Lyysl7/Ug7NfD
         fGn7IuRKCMdbUWXzIq+Z/VbBwz80fFEeYDHqwEanIGv1PoiFOijjszPELlYVf+winmFs
         cPQA==
X-Forwarded-Encrypted: i=1; AJvYcCV/zoZxWhvC9bCtJv1QB2COe9H7GvG47WVLtzWE9OpZTkSYHKlUXzKt2CWHJ2HxkFTpHH0x+vemAZH4WWIjH1Tg3uSYNs4=
X-Gm-Message-State: AOJu0YzDf4PLgqxfXvNxCv+u+bjfcfnP+AWlMMkVtUZ8Bdle6zYkIEwO
	Q8kaK3JdGNuZkVT8FJ9pBdR8au8WC8CzjMM4mYdM49iK8X8V6wNcqyGaUac4uMU00BKPOEGCRzk
	LfL9PVb2KIeHYZpaVX1uPQ2xL2H166UXiMt8Smw==
X-Google-Smtp-Source: AGHT+IG1VcMHenRJE4OMv8Wdwm4JETBLEpAvJgISa1/m5vlwH5K/nlA4PdfCRxYRpOU0UfdTVOnSQCZN39wxbmaGSUY=
X-Received: by 2002:a17:907:96a0:b0:a72:7da4:267c with SMTP id
 a640c23a62f3a-a7d3ffa612bmr940477966b.12.1722356927933; Tue, 30 Jul 2024
 09:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <3575457.1722355300@warthog.procyon.org.uk>
In-Reply-To: <3575457.1722355300@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jul 2024 18:28:36 +0200
Message-ID: <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:01=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Can you try this patch instead of either of yours?

I booted it on one of the servers, and no problem so far. All tests
complete successfully, even the one with copy_file_range that crashed
with my patch. I'll let you know when problems occur later, but until
then, I agree with merging your revert instead of my patches.

If I understand this correctly, my other problem (the
folio_attach_private conflict between netfs and ceph) I posted in
https://lore.kernel.org/ceph-devel/CAKPOu+8q_1rCnQndOj3KAitNY2scPQFuSS-AxeG=
ru02nP9ZO0w@mail.gmail.com/
was caused by my (bad) patch after all, wasn't it?

> For the moment, ceph has to continue using PG_private_2.  It doesn't use
> netfs_writepages().  I have mostly complete patches to fix that, but they=
 got
> popped onto the back burner for a bit.

When you're done with those patches, Cc me on those if you want me to
help test them.

Max

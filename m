Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD5266EF5
	for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537897; cv=none; b=Mhi7FTm+zL9pMB6ZRs9Rj4w4LGs7i0Lxd58x9x8R9xWRfwyDvR9Dda3ah0VUe1W2R/o/X6q+VKzAaJMjjtpIbm7GDPtJ7AFjFg9zlAc0yIBIjt4qJokowWTtSzUhVdkHQMnLGxGsqRF07dW9Pk4NVhL0Vsn5ER3dReLBJAoVxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537897; c=relaxed/simple;
	bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDSm/+F/J0PqtL71CXs0T/J8awHFOACfX/4Ws7zUMWeHgdxmuLvksSytfcrryU9/katJ9JSnbPPLCo/fi+rbDJYROvHbtKD5vVLJyfENC8S0NvNaQFFWxBMnQhhGBJF126daHm/P/sMxCqJQ77SvBHTzlCk7LNIvFXUvMQqyj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Tgm+R8Kc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Tgm+R8Kc"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso2624308a12.2
        for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739537892; x=1740142692; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
        b=Tgm+R8Kc+w2dhsZqAUPzDo/LulQEkFW4UP6X+TlU7qR0gTMElYQauzj280o6DYV04I
         P3thK1k+WJKsdpNdHNdMHAaV/iu5eaoF/c9bnGt8MKtlTFxRZ/bzz8cSRzQZZuTp0YGK
         28yUDP19EiemKzT3jHscn3YX++s+zMtpZ4R66M8ymPoNxAaup9ReV5vAr1SmlVgmWrpZ
         2c7tAbuKw3cyb/YifStoYKxPdJehp0KYEJhb63Pc1T87X7MtZHbYQiNVEet7rYbqqruR
         txkR4/cWTGco/wPTsoe83BzDHPJeEf7Io1MvvFW1bUE1O3NpjPGbTwxWXXmO0Z6Oxzu5
         rXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537892; x=1740142692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
        b=kJQUwc7pMweLW75R5sAEYtNVpA1nSVz/UGkpHmui9rA2A+nHF+yWAdg+6wBpk6qiLt
         aj92nZdhcqwQrAgy0z3eV+1FsGO7CZLyTU45lget0pE3Rj+vUciEerxn7eatHXJDg6cx
         8RtI4wizdORw1a8TBmNtoiGIbLpYbDegpPSpz2/3GHRt6L7G+e5PgGJ8z378lQPB7Jsm
         X5XGrwiYk8ammm0y9Y13aT3vXZzXTp+N2T+laahhvek6oSPDwTsIV842KXkP6MkjjiVQ
         2VDjGInrr4yLSj894lCrQF3U2VAde6Fg51L8Q6G0FdSI1Hv/kJZye+lxszYkqwBdD7DU
         Nutg==
X-Gm-Message-State: AOJu0Yxf3IBMgg70f0krq/h04CR4/KfTC8qcTuSKu4K45VolHt0H7oic
	uNxYw0J7RkRApj7TYLz78zvpokIkraR6bj2V3a3ht1n/B1u7MlpMva94Pbv660yaaS1ILCDnWKh
	U4ikxzgKuv6sx3jP+qh0+CYapdh+LRRLI4x8Kcg==
X-Gm-Gg: ASbGnctjMn8FvwTEb1iyk9nQCrkaK84/It3x58y/rypw9ALbdrZSuEVBfyz+fvsUniG
	fkO9e/cL97wO9J8UzpHMadcc8Xd+TFe9bHcLu8ubAHI6RTfAotYsDEQxgdtvo+/HhOLbB9GoAoW
	MH5o82CbvGgxyjXEgx9NGvuI6BPQ==
X-Google-Smtp-Source: AGHT+IHLe7+YddvwF1jEwniu619wHEGtN11Tr41dYTgRyswr/oDOoR/sEJkfGEC7KAtiD2iVWAPopvcxL2FDqAZcQrg=
X-Received: by 2002:a05:6402:2387:b0:5de:db71:3c56 with SMTP id
 4fb4d7f45d1cf-5dedb713c8bmr5113028a12.20.1739537892171; Fri, 14 Feb 2025
 04:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211093432.3524035-1-max.kellermann@ionos.com> <3978182.1739537619@warthog.procyon.org.uk>
In-Reply-To: <3978182.1739537619@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Feb 2025 13:57:59 +0100
X-Gm-Features: AWEUYZmPI7kPTw9KjZhYB07W4f8cfJRiru9zF2iZKyu1QvSWQCmjZ0cvWlpS8mI
Message-ID: <CAKPOu+_6v4Dc59CHOTpP0PuzY3hie=nCUjw0WNBTwiHzCRc=Nw@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:53=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks David.
By the way, we have been running 6.13.2 with these 3 patches on dozens
of production servers since I submitted them. All netfs problems that
had been haunting us since 6.10 are gone. No more crashes, for the
first time since last summer.

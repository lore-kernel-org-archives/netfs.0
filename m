Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373A6AFAE
	for <netfs@lists.linux.dev>; Mon, 29 Jul 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244736; cv=none; b=Iidl6wFgjoEQNFP6aYI24seJOTocwTxIVm7SmEdJdue4yKFdU+//sqTqFyAXDbTDs9doPhEO+aNdIWDJICjngpmleTopKpXAGqac4zbyg79NbzgRc9jU/5U3WVUuZHkUwZ0nMB7CCasmvlMidPSEZcG1W4KTl36NYLAQO7dJe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244736; c=relaxed/simple;
	bh=zP4Oo8VlfPL1y5ooMCv+q6dYa7B/A/lNVPXp7kK15YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evc5ouVE/7QlpHjMk8Knbf5f2c69TAPZqUFiSkZQXeRVpBOPNq78CyJFHpxpIPzT7W+6QkEhgqFkT3Wv3krPUDOR4vFbzMRwpd9wGJOEqsnjABD2V4JZ0DUKxF3a3ujOhg8DES8+dq4L3c1h0WDGCPLQgSndfN3yNfExJUCIV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=A7ituxzz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="A7ituxzz"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a975fb47eso472681266b.3
        for <netfs@lists.linux.dev>; Mon, 29 Jul 2024 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722244733; x=1722849533; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP4Oo8VlfPL1y5ooMCv+q6dYa7B/A/lNVPXp7kK15YA=;
        b=A7ituxzzijHH4imWQj9hqO4Ust7XzQifsdnK4Vfr24DHUzulg7ARzsjmby8HU2wWzZ
         TAlsZdZt8Tn3mpanV39r7ZggWwrvKaS/OYGNddIkhTNybzttl1m1DtW+ElQYv2IBlsLo
         doPlTqyxy/snszcCsAQW+8FUBmKA6ge3ebdlgaLrslk1Jj3xiDKwTHyVNpXXfBxOxsi0
         bkl51VNd+1cQrdLzMtyqo5YHGsqpsdKk79THJE3ngjzQCmGYoapvZ9hI2gZTiEXkWzHO
         u/C7j2Qo5CUdAhw35FIfYDlikxU95kXDyrSMXTk/gaEP8HEP/79zdh1LdsdHxKznpOPG
         lmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244733; x=1722849533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP4Oo8VlfPL1y5ooMCv+q6dYa7B/A/lNVPXp7kK15YA=;
        b=MWztIAcVbAzOFTXjN+pC3WWnUO7SRKZK6Oe+h6QlOujMuhhgfB4uGpabitJq2Nc8OE
         7c0fA0BSZg6aOVCUZjSa9/7ZJVFr3AdKaseVybb92u+BSxbF35zEf+9vl+6FkgYlPAYc
         /eF3sg/tNRvo7eo1gZzl5DGcaR2H9Te1ZQ/wcRYs18evm81x8wTMr+BwUKKcAIWtva67
         0O+MaZd3pU8sCl5+YojUyWLzU3uUaqVFHzyMWggJnaU2RL3Pk78Nlxo51eOilIJ6CpJa
         pYYnAsB5eVVjh8tsazhdoUdhmYBf7P38uSfTxMRkNfTcvCyXtIQMcDp4Y8ko1X4QKeuY
         CimA==
X-Forwarded-Encrypted: i=1; AJvYcCVM0qZJEGvjomSQ0QcnrTEt/dye3HRYT9yb7x2azP5zq8EyFQeMp/xKdSLK4CcbSFpmUDo6uJEkWGLxc68AXboIE/0oUnk=
X-Gm-Message-State: AOJu0YyK2+m7Eh/UvCMT0cEMUyyoBtStpLUiG3IYXYfvRj1ZKmD4Jp2g
	OD5SuhxUGjCdmBef4+9tNjmCP8Ecdr8/TrSmsy+Mq7dVMEHqTunHvxiFoG0wDXnpoGbQYfkdh1x
	vGwpWJEJFq3tMX6nrZcJ/E2W0yMJUdrxFz18BmA==
X-Google-Smtp-Source: AGHT+IEMMA8egk2Qrs/8YwOO8v1/PGB/RaFQ9lcTBCtxwZZFTvrycQmzBYT2gE5tB6GWwAAQvzXd5f7JMOHEksDWTYk=
X-Received: by 2002:a17:907:3e1a:b0:a77:b5c2:399 with SMTP id
 a640c23a62f3a-a7d400af792mr514406966b.31.1722244733283; Mon, 29 Jul 2024
 02:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
In-Reply-To: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 11:18:42 +0200
Message-ID: <CAKPOu+8s3f8WdhyEPqfXMBrbE+j4OqzGXCUv=rTTmWzbWvr-Tg@mail.gmail.com>
Subject: Re: RCU stalls and GPFs in ceph/netfs
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 12:49=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
> in the last few days, I have been chasing a 6.10 regression. After
> updating one of our servers from 6.9.10 to 6.10.1, I found various
> problems that may or may not be caused by the same code change
> (abbreviated):

Today, I gave this another try and it turned out to be a simple
leftover folio_end_private_2() call. It was really caused by commit
ae678317b95e ("netfs: Remove deprecated use of PG_private_2 as a
second writeback flag"), after all.

I posted two candidate patches which both fix this bug;

Minimal fix: https://lore.kernel.org/lkml/20240729090639.852732-1-max.kelle=
rmann@ionos.com/
Fix which removes a bunch of obsolete code:
https://lore.kernel.org/lkml/20240729091532.855688-1-max.kellermann@ionos.c=
om/

You decide which one you prefer.

Max

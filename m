Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7D1EDA1C
	for <netfs@lists.linux.dev>; Tue, 11 Feb 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261159; cv=none; b=W0fQExbkf6W4auxC8FiWoxp1mOi6lQm0uzAGHIvYF5XxgUpgWMk9BujQXwU5VzbNx+LHH2yUr5K9BwzYZKlrFP9PSnIfdwjkQyyR6GdX8CNoLYX45JG1zt5MnvAsMFFcyoRlW0aWqLX11+4wE6x3d8x1Du3pF+m+kqP5yGYmiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261159; c=relaxed/simple;
	bh=oZul2d/wKFmYJJHdQwxELki+d2o5+CW8gJ8R+CmprR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyOGTktE/B69LeSJ4/pgv/ZKPjU9b8ZcUCsCZfT/1R66oB6iayhPj/otDjVQAlfzQTHfehb8uOcYVSjh3G5JcYu4KJoHCpbpa/1RzAU+eWFkmBCwhkzVgl+BcM9Ze6eoj/nzzeD2dUs+c/ZBCBh3wz0/X0W8uKL82tGyeRMSHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e9bczBaU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e9bczBaU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7e1286126so68999866b.0
        for <netfs@lists.linux.dev>; Tue, 11 Feb 2025 00:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739261155; x=1739865955; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJrOUp+F89GFnzwAsaIErFuCcKPjmLvk5s9hg9IRNZc=;
        b=e9bczBaU0Cn4/JSRC/Z8ekBmJrVj7kSg8DFZJwgnUThk4Noe1o1go5AneJc0jCx6H9
         AYJIM3xOiqr9/nDsThnzjdgXjGfoqAP9TCGjDY6SUABRrOVj/WBHKBnHNcl3H+Qg3xBG
         xoEEbsbTSQl87kRrQVv2VK4Wr+Sh3jdmYezlxEz5kGQNVu0yDQKpN6r+2XikLPYrAhGY
         YwBA2wtyVQybKLr9hgWRZZjYWT/xvBd5kOpThKlR3YnZ52SYDjUfaXzQZ5Hfj3TTD8MV
         eq/QXh53w/o2Ch/2yU5opaXK8K5jNhWXBFLc3Kx6EROFGPZTtQbkJNclrOAjXRJ71fjX
         ccmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261155; x=1739865955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJrOUp+F89GFnzwAsaIErFuCcKPjmLvk5s9hg9IRNZc=;
        b=WiZrbztDKFNMTHZcmQF1wtlYIKnjkhfAv5M2R4sMaG5SN88/gzE0uBELs9Snfu4w5X
         crACCxarSPm5nJ891u9bcvvKBEt++zMp5gSN4f9/dkaCUcSz7f3feRKQYHwXIOSqsRu+
         +RCxbY0IGcz6lTS+1IMU2i4p8T1bTv1zzlI78F/OpWZoRbR0sKxekvtRU2Uun7+k4P84
         FEOfEnjwusWtPZXpefTVHF3XBgowIrhVXNppfYSzN0nOXaz+77CIh5EAQXa1k5vXbPhs
         8o0sfIAKCYZvKvBrLzrB8RqPkpkkzjXi/wZE9e634EXRmcG4P3BJN/Y+nBLndMsNOtxV
         52SA==
X-Forwarded-Encrypted: i=1; AJvYcCXd5rxx3HBpMhHwXt7qUZyE6qdrq73jfoh6ilLoD3oIwj/6onDIGQ9Q+0mTiVOXkhxL3+5CFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUpxGcGv0lkJthiKeGIzfvw499TzzPTHx76pjlHLbjNq1DrMmP
	Se/Y0oOR/w1TZm/CnKFudCSeSHJ8WyS2i8Yrb989YUiKayDgLAPy/zTgyLyd68rgqBAJUAyatuD
	tbEE3BQFKhI/U18eBSzZgVo+SbjQHklRUVjJwqdMPjW+hDomHWRE=
X-Gm-Gg: ASbGnct0/EuuSAlCVWlnK1OE7NG0QxfkVFkvSyMfQvS8sPKZ6lRTyjlbrw8Eap7I8xs
	XbfbCvTfz58ghq27EUgKqpaoPsqTFLsdMKTpa91M7cpNYx8rVVD119jgBTQNpZEIgr44k9AJNOO
	FPcyvm/Dzoe9rLcjgyPnx7HglElQ==
X-Google-Smtp-Source: AGHT+IEvCt8BeOXdJg8lh6Pl0LfjKQqELNkqQazSvkXvBC8ZT59e0sRDOAAy7KvIr0fZcwzxkMFleImklwBwEspDSj8=
X-Received: by 2002:a17:906:6a29:b0:aa6:a572:49fd with SMTP id
 a640c23a62f3a-ab789ca2972mr1452330266b.54.1739261155397; Tue, 11 Feb 2025
 00:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210223144.3481766-1-max.kellermann@ionos.com> <2025021138-track-liberty-f5d9@gregkh>
In-Reply-To: <2025021138-track-liberty-f5d9@gregkh>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 11 Feb 2025 09:05:44 +0100
X-Gm-Features: AWEUYZn8IYtLkGvSdhSF9RacLZqPPLjjSSgyWsPBEwf3ckYtzh6gc1WMb8IYbZw
Message-ID: <CAKPOu+-Mi1oCNvk3SJnui3484wpfru3fE1gA72XVcX77PFOjVA@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without `marks3`
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:30=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> > Note this patch doesn't apply to v6.14 as it was obsoleted by commit
> > e2d46f2ec332 ("netfs: Change the read result collector to only use one
> > work item").
>
> Why can't we just take what is upstream instead?
>
> Diverging from that ALWAYS ends up being more work and problems in the
> end.  Only do so if you have no other choice.

Usually I agree with that, and I trust that you will make the right decisio=
n.

Before you decide, let me point out that netfs has been extremely
unstable since 6.10 (July 2024), ever since commit 2e9d7e4b984a ("mm:
Remove the PG_fscache alias for PG_private_2). All of our web servers
have been crashing since 6.10 all the time (see
https://lore.kernel.org/netfs/CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=3DzCy=
9Y87R1qw@mail.gmail.com/
for one of several bug reports I posted), and I went through
considerable trouble by resisting the pressure from people asking me
to downgrade to 6.6. (I want the bugs fixed, I don't want to go back.)
For several months, 6.12 had been crashing instantly on boot due to
yet another netfs regression
(https://lore.kernel.org/netfs/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=3Dgcmkz=
wYSY4syqw@mail.gmail.com/)
which wasn't fixed until 6.12.11, so our production servers are still
on 6.11.11 today.
Before these bugs got ironed out, v6.11 commit ee4cdf7ba857 ("netfs:
Speed up buffered reading") wreaked more havoc, leading to 8 "Fixes"
commits so far, plus the 2 I posted yesterday.

I wrote that e2d46f2ec332 has obsoleted my patch (actually both
patches), but I don't know if it really fixes both bugs. The code that
was buggy does not exist anymore in the form that my patch addresses,
but I don't know if it was just refactored and the bugs were kept (or
maybe yet more bugs sneaked in).


Max

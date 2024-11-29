Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C014D430
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732905691; cv=none; b=uXylU2WtFoaGSnxMuTXHHmk8WTW8zXkz5RE9xqcUF6LflGT37+iZFsbt4HjiA5JQ21fmy5YR2MkOV1nw22EjxJgjFwA2r3ZHKrLGrf2XfnXar5wzjhflCWrz9/2YWAbw1NCYmqqOKBWPA29+OSVD1SfxDqWFg1Apjf77YN1Xd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732905691; c=relaxed/simple;
	bh=xAb4Le1Lr+I2C91qh3j1SB/a63UxkprFuvtEzuE2+JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3nwH/jlntwEQb8MkXWk1XenbtfZedaat0g6rEnd2wWMv5hf4BsohoV3NynEL38v0rPiic+MfF4oI0HPP48qMisO20RpMkme8kJGf8bJYSp8y/0aphSzLSM9IEEAJQzzrHCtOgMvqA2WwzuvwheZ67C+/NfnAjpG7y3ZXBg5k9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DSrkCt8b; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DSrkCt8b"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso284672366b.2
        for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 10:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732905684; x=1733510484; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NvojhvAIMBhLQh6O1cvcFUUSDHH+U81GMl9MyhQbnA=;
        b=DSrkCt8bftvl095+tqPtSiRFABVchzZedUMyDmuJjn3G4Qs0RTZibQCQJrtr/zWEDO
         mGB9mYlIa4Blsh4pXoswwjvgjEWJGqPMnfiV7FUhp6MKhVQ5KLMdMerbaslowWbHebJt
         IiXU2CxkffHIM1NVl1BCElFZxt6v8fIFM2iFZvzqhJZXmEm5p6CutMN1EG7kU75ak+Io
         2a9PTR6Sq1yBw00POqUrGudoF5Pj7kwZ12RUB2EQGG7RaLCybMcWpj3XXndwUdshl8hY
         7jxYqdZmvuB7+0oPu4wGLickqszzc4zJ63cTJ+4TKeo3ZJIm5/LGaOZ+jXJzfW/lZd0D
         0A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732905684; x=1733510484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NvojhvAIMBhLQh6O1cvcFUUSDHH+U81GMl9MyhQbnA=;
        b=cLVvm3DzElBsxJQkFYPI3qUJnXxLiQ/TveV/BMb4mrkq1/VcQRS3wj46iWCVM+dG2q
         oLYMPAMar1KE7HfHy/DWRt7e/oZR1JB6Z28YGYVEHKiDN+WN9ByTKbQZLv/d9IRQo/VN
         ftVSjWqYg4TKhPgkm80n/zQC0prVMxCfocQz46DSpn6Ltk/hi6t2ltbV/VPxseoFeI3l
         LCCCN+CCqyKmuXmGiwaf8Vw7nwMugYVhRnMYKjMrzad0sihcP+5d77BlwgGbFGgI/FsD
         ZGqTuNE5XZc/FtOh1GcnG5z1GtNMYQAPGsjYJnmLl3UoxIyX+pTFHrfyDAoj5q3HFTih
         pP9Q==
X-Gm-Message-State: AOJu0Ywt7eYOAKBMwpOfjebwa0xPTHz61mBkC/HJWS9KzWopIR/mRWJq
	P3JsYpIx4Eo0hV82yDq/I775CockxqA8FQM+or3NZhlZZz8cL63vaHAANY4anNkjDe9IH557yks
	pwRP0OKra9iRuf/2dmWqALLzUnwxRcJi8m0gh+/F7ZlzFECF7QkTK+A==
X-Gm-Gg: ASbGncsFNBszPmJEwj056vpG/zim02csWlvF8DhgWz2dpday9TxkzKU4rm/DMQlcsm8
	pJUQG1bHMdKTsJZ+4I39nqhkqUwRWVL+fLEm/hTOhwk2DI41uPXUjXxWv6/2r
X-Google-Smtp-Source: AGHT+IG2JUbCttHRySoP5H/kIF2kcMZoeZJQd1iXLDQ0okbqS9DAnasQYD6569dIdAQQ02sDNcMyILohvw5ZrxUHyUg=
X-Received: by 2002:a17:906:2181:b0:aa5:29ef:3aa6 with SMTP id
 a640c23a62f3a-aa580f0ec72mr892793366b.23.1732905684289; Fri, 29 Nov 2024
 10:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_JUNO5EZosu00H=tZsgfCAzQkBBkJjVfOHYrX_6mHEPQ@mail.gmail.com>
 <4022108.1732899245@warthog.procyon.org.uk>
In-Reply-To: <4022108.1732899245@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 19:41:13 +0100
Message-ID: <CAKPOu+8k-FxPFyomULC8MqVo-gvnaJNLrvfccVgb1uXZ24yFvw@mail.gmail.com>
Subject: Re: New cachefilesd implementation
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:54=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Now, would you be able to clone this:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/cachefil=
esd.git/
>
> Then rip out the existing code and put in your code?

You mean create a merge commit from your repository? This would make
it easier for people to "upgrade" by using a simple "git pull" on
their existing clone. Is that what you want?

> There's some stuff in
> there that is necessary to run on SELinux-based systems and it would make=
 it
> a lot easier for me just to replace the current cachefilesd package by ju=
st
> pulling yours directly.

I wrote my implementation only for our own use (it solves an important
problem we had), but if you want to retire yours and make mine the
successor ("cachefilesd v2"?), I'd be willing to integrate all
existing features. And give up the silly project name ;-) (naming is
hard)

> Also, you are using a simplified BSD licence - can you make it joint BSD/=
GPL?

Yes.

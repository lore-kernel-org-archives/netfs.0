Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC223F376
	for <netfs@lists.linux.dev>; Sat,  1 Mar 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847897; cv=none; b=ev3CFvo9DIeu5mgZzhDFu3GRjhb8LSLIsJwY10LsYPWdQmT5KQim5Z3Lvh/8QviTLVAFxe7hnQBOC7yd/jkyU9NOdMFMu4ZUIUv3qdpSIeacZjnIabqxeKRjgGQ3dW3LXWfaCwgZYBjgNtfiJbwkTUNTKmEeIUDWxAGsses+TvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847897; c=relaxed/simple;
	bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+iVBSwpzd0sD7/M2+voIOhUmGM0+iNt9IWBMrDWR0a3vvh4KPhQiFqKQmyCLX0eu6apWum59syib5DyZamBxakvMzS+LNYbA/wNXEO4OztJR7K+ka0kSbo60hHR7s+f1OBUtIb35VAUtikHxaxGV61dsQg8xXwKfwcQn8tgOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IXBmBxUW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IXBmBxUW"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf4b376f2fso136494466b.3
        for <netfs@lists.linux.dev>; Sat, 01 Mar 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740847894; x=1741452694; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
        b=IXBmBxUWOV0w2HCQLbu9Jc5MVhEqrC0H9h+YbhcZNE88Wt4n9dY0OzpBzgqyXR5FeS
         B1RIzS3YeJndTbHajHIms4cGKLLaqwJbBwtXTIRgdMWKRmTIZuV5UrQgCyFflCkRW/Qx
         NA7qCVa/W1MSYvzNCsom8FK+XDz3smjxr3SQ8oI460BVVzevXTu/ll+LXg1Ov4Z/O6Di
         C+/0qn5uqwQAE2u7d9KPt+0tTBFEtApJl8vTvWXQKt3sKzjK7vjclDksOvikm/Etokel
         yY3USSEOJ1RSYnJNPsFbejzHFbFzfZz72j4krPfq04b0Nmqly1eSDqPAppRomWInY2Xl
         aq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740847894; x=1741452694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
        b=iphxymJKCtjurNwhLCtYfPcy3HglkxOREDlu32ckftVZLvH5b/8do0WddAmpCiiGqk
         +YxOXEfv7LjdwEp82lWYjqCpsOTozQ4c9VAL79xtBlNhfgXKDEm8MBj8b+1mpFdEvIHw
         yYp3K7iBwPiOr5MmqRkD9oBY/sMdSyylu3tc89i3GAv76lk/s9EoN/PY9oJ3bP+FuWf3
         JzcZCZchL+9e7zji5fnzMlJ4223aZi0hV6dHZg5QBi41CEqwe62PmbtrwjkfkWWGt1VW
         9UHyBqmHCuTi6XA8UPGV3uwWQ1ivneUNeIr/l3wABiXZSsrwG+vbQ1FK9s1Rd59SIh2X
         RF8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9oYQj4OsLk71N7Sz4lkwKFXKJiF/xymUN+foJ8uuxmHEdBS2bi/lIeQg7jYNut992s27S4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU+UeZv9ylKTx6M3YHFAwUs+cEsGP1L6go1fcgpLKxx9zlKugD
	l/epJFK5YhS7KHRw4xLF4y3tfWFJPckVqJF3MJeQ+CNE3OynsGMObOeZinSi6z6ahe1JNn3fiQ5
	+abxm/4zfFy0xggNMtgU8tXE3RSdkMxserJHkrg==
X-Gm-Gg: ASbGncu+yLkx7ub2UfepZx7SG+ZdwsBfw/0MV3j1Wm5c5z8moRqIRFXXeeGs1J1cUtp
	bgHb7ZaAkqkO/oHawcDiAUjSu6x7ip47uodW+7+QKvy7rLIh3PCtgqYvUb+P8bp/kXAu6ufGTig
	uosO2PtA+0xbuGe8ew8fDG18yjOq3qXsFQpgQgScX7rRzcgyGaOFcwY4I=
X-Google-Smtp-Source: AGHT+IFYXvc121y6bi2508QH8dUTqeSWY5NhZJZqG4nMfOIOhL1fYaF1K2onpqRPcyP27mIyLfm41qyBG2MUuYbO9F0=
X-Received: by 2002:a17:907:9494:b0:abf:5d3e:7ca5 with SMTP id
 a640c23a62f3a-abf5d3e800amr254015566b.3.1740847893706; Sat, 01 Mar 2025
 08:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
 <2025022051-rockband-hydroxide-7471@gregkh> <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
 <Z8MW86zYK3VEPcHF@eldamar.lan>
In-Reply-To: <Z8MW86zYK3VEPcHF@eldamar.lan>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 1 Mar 2025 17:51:22 +0100
X-Gm-Features: AQ5f1Jq9sC4S5xjkMHqwwE2FS3xuXaRrtGAbEBdSC6KdiEIvXgpvhHXpBM86jWw
Message-ID: <CAKPOu+_WAM3RQJnHsKfEh5sG5tBuCPt1EWtoUFVC2ma=ORjHkg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Howells <dhowells@redhat.com>, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 3:17=E2=80=AFPM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
> Do I see it correctly that this will be 6.12.y and 6.13.y specific
> backports since the code in mainline changed substantially with
> e2d46f2ec332 ("netfs: Change the read result collector to only use one
> work item") and so your change does not apply there anymore?

Correct.

> I'm asking since we got a bug report in Debian which seems to idicate
> it might have the same root cause as you report, and it is at
> https://bugs.debian.org/1098698 .

This indeed looks similar.

Note that this is one of four netfs crash fixes I posted recently.
Two other fixes have been released with 6.13.4 already:
https://lore.kernel.org/netfs/20250211093432.3524035-1-max.kellermann@ionos=
.com/
https://lore.kernel.org/netfs/20250210223144.3481766-1-max.kellermann@ionos=
.com/
The fourth bug (that got no reviews so far) is here (this one affects
master as well):
https://lore.kernel.org/netfs/20250228123602.2140459-1-max.kellermann@ionos=
.com/

Max

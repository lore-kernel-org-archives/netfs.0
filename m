Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A837224B01
	for <netfs@lists.linux.dev>; Fri, 19 Dec 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163723; cv=none; b=Lzwn6HUzX4/hx8YC2KjUDrS/anl1TBsyPZkT0A3O3BFQqHReIwyefhjA/SAJo13Yod6mA5zR+v/dzMfkz3zQIIT0IYNI1WHHgakjzuXHpQ5oMhgBGDMuvf06jRs6J46725mdTLHYCkVpJpFCeXcFADoQ/N3QVe8lyPOCuMi7N10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163723; c=relaxed/simple;
	bh=4SOBkthImmJzxLZLQ0s6iqP5eBQoze2VaxUSBNu4DVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXfSTIlRlih6O3PYiHFo7fKfCM49TRoXhfYYshpkkUGvxSV6ZR+ukc/pWivO8+ge/YWxXYxGnr8Bl5vkhcfJseeiYbMig40xM4OigTY6tK/7lFJ7JpV5iymEMtemHHfB8xnlPTP/vCpLelsnGgrP2MUnmUYAVjAZy3nJhrVqTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=Rl8Hd/kd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="Rl8Hd/kd"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so1097512a12.2
        for <netfs@lists.linux.dev>; Fri, 19 Dec 2025 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1766163720; x=1766768520; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4SOBkthImmJzxLZLQ0s6iqP5eBQoze2VaxUSBNu4DVY=;
        b=Rl8Hd/kdW922mQfijfOCYPQ+FH4H2hq8pPmcCPAkXEAdBSIkAPJ/z4kgHwgHh+eWbm
         S2Xu94Q0PgZ7qWfD+bHY59q++kZdC/ctYc39bN/iJbsyRx/8NLetVwhTwNEcIdo5rqlF
         9ZNZUS8Puh/qG/9atCg3XNzYezdqFt5JO5Xq7DwrePDbQNoDvTM59wcsiqMf2jeWuKjs
         BnomPTDVi0SbNHUQYzjRGESBioBvqUHiQTEtItUtzAw90qjrKG3A/8cmXP0bcnNx5IBS
         2/n82eq3LAteuBdr5+jnvx/zb7UJ9xiR0M8kKHK3nESXEdo4rNgq7s1UYxh0h7fMN/EJ
         cvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163720; x=1766768520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SOBkthImmJzxLZLQ0s6iqP5eBQoze2VaxUSBNu4DVY=;
        b=P0etKZIHBbXq/jyNcgwM2blKwTo3gP31F8pnq9r4xaVF4M3esCYeh+th4nbUiUVKVm
         JMrQGR/KtW/q2G3QpysWS6z8XnYcMoOzVsvQOCUzbKX/JgZxTZC8zSvlECn6Jy59lZyX
         Lv5TJHdAbD3PKuzWbWzrmvucc4Kw2NkZs6fYJa8XUBNZER2JC1VtNhPjA0KBL03NaUrC
         OUhLr1+BMXPOvMYRBTOKwVktm1cKEjYPkrxO0wdyGxC07KCfo7HmFxiWJRual8pGBSvO
         8nf0yIBtSWOySWqWvrG08uR2JqNqlbtg9+LNQSq+kf5vQF3MezhT2X5oYHYMeD3z7T8N
         PHyA==
X-Forwarded-Encrypted: i=1; AJvYcCW1/N4dTjgVXI53BaYeyrKJzl4Rd1DFgENtIJtQesqY0MccCX9X5/LbgRuss40DUhuY7drwcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqRndTBtHKrBxIDbgMmtgB88fIYeg/26f0k03Ec3o/zVClWktN
	oP58x0/qraZi00fG6sWcejG0jEpOFcgCcLVvXXyx020/bkJqitS4I1Sp9KCp+tSV1+pFoaImvo2
	lebBnXhNdoLEjIVCl8CrInIIdj0mRlt+G1qJBDIjdMZ7njw9/X1ZDnPd1MQ==
X-Gm-Gg: AY/fxX7FVsPFv/7ILcohzfKsVozkTz8BYFVnlolbBxwITUsI4YHcXJ4IPq6r4rp5YnX
	4L4LK7Vc17ua1mr8brpKbyHBB7YojVuHbbAt+Bv4IIikMnShx0O4apmsYnktq/MNI71IRqNj35L
	eiuu+VEFdiWmDm9gAAlbnZe9Am2tkn3R2qeX26YxcbZvX/8d0Berg2xhjHEzdNfw9mFV8gq1CnF
	mXJLsOkABv8nT0FZloi/Yg9L15dYomQUssZFaF1Y+eOcMwqbN7Hk8gtMbsu+FgSEzU7KQ==
X-Google-Smtp-Source: AGHT+IFYZ+T/DDBxZfTv12nqi2MKs8l2/c/zepK2RVF8SggZrcKR3TLEu57nFKme181aAS6NO8AWiWlcMI4B7+apghM=
X-Received: by 2002:a05:6402:5108:b0:649:b4d8:7946 with SMTP id
 4fb4d7f45d1cf-64b8edb3335mr2602774a12.23.1766163719739; Fri, 19 Dec 2025
 09:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
In-Reply-To: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Fri, 19 Dec 2025 17:01:22 +0000
X-Gm-Features: AQt7F2oOfNfsPv8P8u21bp56Q8bnBK7hqHEOp3yV5u7A9mLHNUlUs2vFNcxWnPo
Message-ID: <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
Subject: Re: fscache/NFS re-export server lockup
To: mjnowen@gmail.com
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 16:25, Mike Owen <mjnowen@gmail.com> wrote:
>
> We are using NFS re-exporting with fscache but have had a number of
> lockups with re-export servers.
>
> The NFS re-export servers are running Ubuntu 24.04 with a
> 6.14.0-36-generic kernel mounting Isilon and NetApp filers over NFSv3.
>
> The NFS clients are mounting the re-exported shares over NFSv4 and
> running AlmaLinux 9.6.
>
> When the re-export server locks up, it is not possible to access the
> /var/cache/fscache directory (separate file system) on the server and
> all clients are hanging on their mounts from the re-export.

That does kind of point to a filesystem problem with /var/cache/fscache itself?

Can you stop the nfs server and is access to /var/cache/fscache still blocked?

> When the server is rebooted, most of the contents of the
> /var/cache/fscache directory is missing e.g. the file system contents
> before the lockup may have been a few TBs, but after a reboot only a
> few hundred GBs.

I can't say I've ever seen that before... we use ext4 for the fscache
filesystem mount on /var/cache/fscache.

And I presume there is definitely nothing else that might be
interacting with that /var/cache/fscache filesystem outside of fscache
or cachefilesd?

Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).

> The kern.log (below) from the re-export server reports the following
> when the lockup happens.
>
> We have tried using a more recent 6.17.11 kernel on the re-export
> server and changing the fscache file system from ext4 to xfs, but
> still have the same lockups.

We were running a heavily patched v6.4 kernel for almost 2 years and
have just updated to v6.18.1 with no patches - so far so good!

We are mostly re-exporting NFSv3 -> NFSv3 (Linux NFS storage servers)
with a small amount of NFSv3 -> NFSv4.2 (Netapps).

> Any ideas on what is happening here - and how it may be fixed?

Sorry I can't be more helpful.

Daire

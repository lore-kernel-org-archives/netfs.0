Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A4310627
	for <netfs@lists.linux.dev>; Fri, 20 Feb 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627677; cv=pass; b=IeV63D0leIO29pUodHaUjr5L7dcg+rB/VQhtGUuF6AACuAdIQkGieMTCDEsvk1N5MgD/47ZVNWsbK1eYIIhsgd7wkxrrpUza4dsme2FdCQQJnCbVry1BHjh1aNq1pRliUCkLAM5TtO+txa2fYDM84prEKC6Fh/yLE9Pak0hoTBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627677; c=relaxed/simple;
	bh=cSO5ddvam+3etx0tA+nKexvNvZkPWOiJ4oLj72nGz0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQVygIfmmGjHQ5g1z4yv2ctJ+3z+d/NIAjTlZ5l/k3Clm+0f8T9pYWRVErDRXs5U8+iqilOsXy21uH7CyamsLAoMk5iv0zjWLCdQxc9YvQhg9oReQh0Q/NP84AEsczF3BfBwAfIo5cn1dnkLlyhHxWQcDkKzQs40EajtAEVSuT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UfYif3bd; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UfYif3bd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so1087271a91.3
        for <netfs@lists.linux.dev>; Fri, 20 Feb 2026 14:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771627676; cv=none;
        d=google.com; s=arc-20240605;
        b=UKgqLWghGI9EzZ15yCcFEVP2RqELCoegAXNuOox93IP+5BUoVedCi1w4aqJThfTFex
         p+ADVARlfq7gl+NTQJeZF8mCMpRQf+2iIVKKESqBkPxs2uf9lK9GQIV1c8UP3KeBCT1C
         j5LU9HSnFK5QtwFM/YDXN+V78siqhlwPtLt4k6KtXVHj0gqEJLGD1UBZLMu3lolApgAk
         iJKyBZagkXwlReEajULCU3S703fMEv1+4FPYooZeTc/hM3UyWx6PIdictUkOgtXx+DEp
         xM6qsgqG32LGW26GBRk6eoXvYDx8VqnO4JD4WPkYBwj+eiC74Zaugm6r2XFY5JONFiih
         eqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        fh=VTCjl48mIMmK3zEwE2jNzjgtGg1xVvT1vQYNc9dA5po=;
        b=VqcD+GLEQyVyzbUSYoJg73SKYkCRKghkHFyPoZByUwTGZdi2psnROZjyEXmUP7uvQ5
         RP3IqS0Cq84Awyt9zZl/B687h1bxwujvlSnPgZuLP9H5eq5wavV/nm8fs/yu4RzA3I9Q
         Vtp1uv957LkAK7y9Tq+K4HtGN3ruR5RLD8/yPTW1ksxCxgM6GQFt8TpPkwHdqLDDUqnQ
         xmxZ60IlJgO19iw/s3jri35M3fg/qVYAV587nU9GtHAJe4EufsAkbIxg2RfxvYsQ0OHm
         uOAeeM4NV0+yS3iaRDiCtJzdxHpeuq9iTPqmlP0eHHPDIC3TVYra7YT3N5RUenLSw8Ie
         Gs9Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771627676; x=1772232476; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=UfYif3bdO4Ax5EouJPQzwBK73Nop9W2c7gXjS2ZSkz0qHQ7rygOCRyKa90qsho7MdF
         xvKW/aJrLAZ5aj9bNbx6znVBvT0iWC0CCL6Clh9VYGyzyYYxwKCc8q1DPytybVJNOKUV
         cxQZvKNM9WaK557U4u6Di6BpLJf9jmE9AoRdl8SwLzzSn35M9J+kSdqUrIDxELSo2/iQ
         MK5cgkVEN14pAmqGeN/ULavbUPsKjwwfci82EJag7u3zHO2ZDj3XwHtzsWS5quHUH671
         04iaO1IsuCPvhltuEeVv6zFFFk/9zoGb/TTu82CVDU6wPJE0L2CPss+1fFwsbIQamxIB
         myCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627676; x=1772232476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=mUDXhcRXe7yRXS9VUdpNYVmcOu5uRvKrseyakx6+t0stOvow6V3W12L4YBOy2JadAA
         bzrzPP6URJlTx0VUyynk3/Bt005kVBmtyCVmby3pFkWmo/CWyyh6Mj8mZYxWHLb1sy5p
         KOKOdnFfYc4mcWZquVIRdkN4caqZYltpr/U2vW624DZJg52pY/KxRciIWIszULZssTkU
         gbJJBXwrf6mgI2NkHIN7kKVgamNMrhLTbgDGqpDVcqAFQI89sFgNybOJlTQ7hrHwse6Y
         OERp1ZOVAXwGYhzOC7e/zTpIdyzST0CtTMRl9JRivrQobt2cavGcHy2CVKwtF+/tg/M6
         3Pog==
X-Forwarded-Encrypted: i=1; AJvYcCVrbwNho57t3aW4mfXgp4VrUKilPgS5oTI/7ZFXM7odI8k37gnCHi+h80qHGaAOXm3eeYm4DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6TQ+vwR64mAM9a6dK+S7l/oYY65U3IDpQWz3TWsnk0tmKwzZt
	QaPex8nMfohvqi/ZJ7yiELvGKZGxVvjkfdRj/IjbRwbJVT+cehlWo46tOWSMth2PEEb26A/CoUr
	y5EfDRDiMDXUQF7MR2HSvgVn67u0ir9v1OhyRxk1r
X-Gm-Gg: AZuq6aJs/QhYNEYrjG+3GOKra+7vxyCQdooXGpoSabj08ckkRNxv8EHRBiWcMk/rFgT
	tN1Oc72GOfqyI/gdFgetouHXPXU3NLYxFa8WFZmYB/FhPo6+PwL5jJVURvMR7uiaH3KKtZuQ7tx
	WkzSGRNZJO3vZQb6Q8SklyY9xh7qXS4Hkli77nCDZgw5gUuBuxw8nrMGshAndU+hQdENzhWM83E
	+NfWOJbqFKFjPMVV+ENBIqATXbALbFtyQCy1IKYxJ4T9Jrg9AtewSa7M6uLeuJYkNi2MlpvzO0l
	j/sKhuQ=
X-Received: by 2002:a17:90b:3a08:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-358ae8c0983mr894544a91.28.1771627675691; Fri, 20 Feb 2026
 14:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-6-neilb@ownmail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:47:42 -0500
X-Gm-Features: AaiRm531rz23NInLiaMybHfJxR35OGBc7KTvM6WC-U0WofFc5pma3F6ygsFUv1A
Message-ID: <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup.
> The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds.  Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  security/selinux/selinuxfs.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Unless I'm missing something, there is no reason why I couldn't take
just this patch into the SELinux tree once the merge window closes,
yes?

--=20
paul-moore.com

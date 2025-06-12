Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE21F5858
	for <netfs@lists.linux.dev>; Thu, 12 Jun 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711611; cv=none; b=edsAh0RniA3E2/uo2ehC6kj3DJ3/b1LeSkBLcLEzEdbpBK6b8/5ptY7SV3NDpk401OSjUcKL5blDOq08mtoa00NrZFwmkyNRt7JhZ18MRJZuM8rLLVdA6C4sWL450IrYhiilGggiLOfzc9I0sTCm+0aQqdO+VEadVWiOfoVWTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711611; c=relaxed/simple;
	bh=hP58mwixbZLpt4L8WGRAwg4LFZhaIzmw5nV2N9wnUG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLeUryBHbZM/B4Qnlfk5IGP9M8xamiPbWU1bhVLjHCyXHNqKBVfJE8lF/4PkGUSNDMZMTWSKSTc9ObxioQah1HwMr5p5DRV72HjfpbHNpIcPruBVNkmEutvImVjBS35RGXFhhnAITFSGlYMHF29tmyAlUgg6lFU4UkJL7of91gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfILgHR/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfILgHR/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so101187866b.2
        for <netfs@lists.linux.dev>; Thu, 12 Jun 2025 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749711599; x=1750316399; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X298AJ1vmcnnKGKwMnR0+yVEoc+HoTcMBwQlRJb3r1M=;
        b=CfILgHR/m4NYohr5R82p1J9OxVYlONiNkK8kGJoQr93GNX6nvqMzaDiztqzSiFAbdP
         JETZfRwi2xpN2g9IHyn3iKOC1jjnGo0rvsY47x3YAbPUCfD5swHsNM5tpunm9k4/P68z
         aQeRw4CpaKqZs0VakE8nvwWh/dtu/SybPQDkacBROSV7bzAYe+H3EOqDTH45WTEYgHBd
         v1d+dqkZn6mtbOx4iXsjM0UXSFODEJC/Pcjd30XoVa6RznbJogkpPTHx2LVt69Wl2A0h
         TXQBwlIIXU1uQeivydEpc7GiPy8hrNHOsHQcVSkbsPtYhLcO8MzbHhEt1oeqoDXapPzj
         wuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711599; x=1750316399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X298AJ1vmcnnKGKwMnR0+yVEoc+HoTcMBwQlRJb3r1M=;
        b=SJtlHLa66YnYYNiVK/gh7W6diGpLXbEILDyAry1v4t2bYNPDE1hBaoPPrfOCwr2yMF
         RVr03qdhWsFSrdfQKrWLr1MKfCLNBc+Z6RhAI5hwvTTFUKcl32zGmzQTeJOISUmm6vsm
         Sjc8bV4A4w91z6bAvCZgyLJG7sGJqHgEz9lGUrnmd+2J2qQUBwll3NLORTzSuRe1LcXr
         a+wHO313dB2Q0Cc48YY/fZ15vcQXh3XVhBmeHbJlTn/cBzFS94aM30XHKvQjJicQYuoF
         7ytM6IJ5mmyAx0YydB+w9h9FPaRlK1aGo+71nBtUf521GRfYCoNORuZQOtfIhBstJo9i
         BiSw==
X-Forwarded-Encrypted: i=1; AJvYcCWYpweiTltMjK4R6OVt8qW0dkj5HDm1xcv8tNB0PtEXpEF6A/o3VmiJJbCXUHw8V7341gAtJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0dLcRY4WpFGo7DQrk4JEKRyCknondK9ydSmaT09RyVEVzltr/
	JDHkl0DizPHKDjwfskHMBDksnLxU+q6N6XR0DlIFSqe6xHyXVsJ9BWT1IyZddbvAkLKqJwCuWTk
	ju4yR2QuprTNA0oMcyTt+8Frig1ffGhw=
X-Gm-Gg: ASbGnct4yuTFWUNNTBheX1XhTR0mFf/82yTmJmpZTEaMgd8HENvNUFSViHUkVc81Dj3
	qVGLqVjtzilqJBaJLHaDxXKXIuWuhptUsUK97wH57q4Psly39EBo8JKPqQq5jM63SaJFlOkLBEI
	vEPF9o81y5q9BM/1NhlRrOZTXYglMTqWn+bUtJihmvjYY=
X-Google-Smtp-Source: AGHT+IGP33kAVQaksCPNQ+fkTsAwnqDwwrSRq7UMjy+xLEY0jPC08cQGyj+B/BdOosoGWeRWXUDx+SKIKhyM2yGlOO4=
X-Received: by 2002:a17:907:268d:b0:ad8:a50c:f6cb with SMTP id
 a640c23a62f3a-ade8955ed0emr512735666b.26.1749711599047; Wed, 11 Jun 2025
 23:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250608230952.20539-1-neil@brown.name> <20250608230952.20539-6-neil@brown.name>
In-Reply-To: <20250608230952.20539-6-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Jun 2025 08:59:45 +0200
X-Gm-Features: AX0GCFsL26c6LJCX3CQkRAKbBnpI_uSHQ6IJbL_IKY5VsBhMkIpqw9gJM4WhyUM
Message-ID: <CAOQ4uxiV6Ay7iaxi3qw4nYTiVTZ6abH+W6o3z1OJVwf6ySOrzg@mail.gmail.com>
Subject: Re: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, Carlos Maiolino <cem@kernel.org>, 
	linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, 
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 1:10=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Proposed changes to directory-op locking will lock the dentry rather
> than the whole directory.  So the dentry will need to be unlocked.
>
> vfs_mkdir() consumes the dentry on error, so there will be no dentry to
> be unlocked.
>
> So change vfs_mkdir() to unlock on error as well as releasing the
> dentry.  This requires various other functions in various callers to
> also unlock on error.
>

That's a scary subtle API change to make.
If the change to mkdir API wasn't only in v6.15, that would
have been a lethal backporting bug landmine.
Anyway, a shiny porting.rst comment is due.

> At present this results in some clumsy code.  Once the transition to
> dentry locking is complete the clumsiness will be gone.
>
> overlayfs looks particularly clumsy as in some cases a double-directory
> rename lock is taken, and a mkdir is then performed in one of the
> directories.  If that fails the other directory must be unlocked.

Can some of this mess be abstracted with a helper like
unlock_new_dir(struct dentry *newdir)
which is tolerant to PTR_ERR?

I will refrain from reviewing the ovl patch because you said you found
a bug in it and because I hope it may be easier to review with the
proposed cleanup helper.

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
...

> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 8baaba0a3fe5..44df3a2449e7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -248,6 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_=
fs *ofs,
>  {
>         dentry =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode)=
;
>         pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZE=
RO(dentry));
> +       /* Note: dir will have been unlocked on failure */
>         return dentry;
>  }
>

Your previous APi change introduced a regression here.
The name will not be printed in the error case.
I will post a fix.

Thanks,
Amir.

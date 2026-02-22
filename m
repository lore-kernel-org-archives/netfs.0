Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422BE34F483
	for <netfs@lists.linux.dev>; Sun, 22 Feb 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769984; cv=pass; b=STOIAHxwS3nwQVe3em3vEwzX24PnM4p1NNrf+Vp/CiOzTapIKr5IgXvUWGCJToSt9bCcHnmrCwbiOpnNXrO5mrkpJpxTX85J8s0do6rvGALnw5EJ0J2zJK0OApIoFGMTHaeU60GPcZvq5OIF+AG5q3efbXbVvjS/ooEKxKLC7cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769984; c=relaxed/simple;
	bh=ln+l2+kKkFDBmSOGuUA2y37XlX40B6GZOr01SweZv58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXEBE8Kau6im+3nMUDaQHDgjRwagJFWa35f/u2WnNI/ThjcQ5/RWpUT4Z6jkqixeBWGSNEXYmGWKkSnogov4Tv9arXCeYCapOq+143TuTc+ROkOYvVXxPtM1u1FCp+VQTbE8fNbgoJ28rO9PD7V3HVe2ub6PuwKrb9Vv/jKi4PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NnvhpkAO; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NnvhpkAO"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824a9348603so1409277b3a.2
        for <netfs@lists.linux.dev>; Sun, 22 Feb 2026 06:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771769982; cv=none;
        d=google.com; s=arc-20240605;
        b=XgbcAYWbmB8NEjm9mdUUOkuBzbz+ehcKUXklJfkm+iLDFImDG+Y2Wivg0bCZxP4b7d
         EFCE+rLpNZWyScZ6nKr9ho70KT502VqGJeVgTr0PCovTgRDutqQMLyoswDGt0YGGU2oG
         5X7GCu9QdmuhxK7IEDLJEEvmM8lwG1ZwrqM87/dEXvfP4E8+46xAoFtqyHAGNYXO/7dD
         Tf/ytvGBgXFTTasayzjw4Twl2MIUNpLjHN8ehuBhx2VuI5/cX8/9JD+7dVQFlLTFw/3d
         Ehz9vf7VUFy/N3WWQ9CVNDSYtikrIfozg7PNns5ujUHPFnc+KqVyvGv+bQR1sJm7kEmm
         tA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        fh=fQnPKsxN9ZxQaZuInSx02nBm5tW4x5CfbdLEIgI/nkA=;
        b=kepRRxXslLWaF8aQ0HeoFjOfZTH+4t9dZx5AzdwPxX9kTERLJJqebry06D4qc7HnyI
         Uvm3FOloC3MHhAVSVl8nSbBsD+zjFPVuRO1XJMLq60XkEYG7ItpcBWQ35BdEAZjB+j5D
         6tnsFBitzaWj+IacIEpwH/R2rcU1E5Z1F/LgBq3yHKn3/5ys0xwiXJaDop0niNdVWpp3
         9UvJPgey2z9cgDPCEIja4cck79u8SjnDUREoKKL/VBFPjOrIppHrEXazqcg4rCksS8Pg
         6/bOMoThzFKkpLLBnWz67pimK/VZ6uGBf6AM7vNmb7rKRxL+PKA5U3UTAlyopzEyRR6U
         HBWA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771769982; x=1772374782; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=NnvhpkAOV2I87ODraw+P+pXjbJvl8v1MteJQwBuoYfWoZuZD/c3VfiunXQ/vbqd23N
         QbHk+SnFVsbGOXdA1NmsEwW8vkQZYA+rSqTN/kgpViws0KOxswQmFjAYvK3cc/1XClyb
         MsAO5lb+o4bFpcy6lssd1cvv0UmXonXwtIITYQuch/VbJUP2sgOzC98HKW7nDvLA9bzd
         Rf26+ialchiFeukJF6akWfh+dW495oaV4LoHYpcHmkNyHsR0NJ5MEzeUgJG19DvZOxgl
         pS1KNYLY+lFpQjcurPAYKq6Y3Fp8mUcW3XEMiHWDmtADClQQ27EsyHUWLK8ZBtM6kpYZ
         YFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771769982; x=1772374782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=Lbu/zJJ0i83aI3OTQmhf2Q7vrZ4BHdT9J1VdGdOxTxMLwysC8ICkwJ8qrbVFbzxfG4
         GwG9FpfJfzdqgb7zJ0EXNAEvXnqkMYy22WXrN5d84gu8jAVwDQfDZZuPftDjL+NM9qf6
         /TllW2cRCCTIRbGBiGyDkzlIZ+qpMeTZklRSUu7XQwfPcW0o/Sp58+7wbM+60YbpYovF
         bkpztgvs4MyIGxDY6lki/oljUU0/Mb7b9vOlPiZusBSvLigQkrjjlk1btwRw/ejdIAoB
         h4ewN2VYePeuiYQqNTBwNGBh9qxOkuk//RN1TVoazdSksMOVIQxpyg81MLktngjmjErn
         zhFg==
X-Forwarded-Encrypted: i=1; AJvYcCXEZ3IZseGzuDjBhk2B3+fzt7fNnCTnEfke6Pabz1xtPiUx61yC0lW5YjeA3NBNioEnNbhh9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8+syqqBACShfM0GApIJD3KpwbTAOPu5OdFt0uUfY1Q2gi1/j3
	ghUM2sOy9CloMjsl+Rq9aKRCy6eBRykegYyRZndoJcnLwniX+MNLGixWxZVUr1jqs/1bP7wuV5K
	wiRCpJhcA7Mk6sFZZ4PdXBErJfcQafz2HMQMzhr59
X-Gm-Gg: AZuq6aIVFHyYUJ8s1OspbFGim+zks4asJZqICSoHVt+kbYLhHmPoN+E7U7DSCEKwk7o
	ax/oFyGzZlC1EGIXnOQYiN14Gmo9eb/j3SDfC30jeuELooJU1Ixo0GSzoeQBbmNj4YUhC/8vw0e
	JuQEY/GKMwsigm5h4zlwlWRM+Zry/x+sXL8oum0/IrlHdIP54CIRXuQJnCA3GzvG2QlSx0HqCpi
	xk6aQhJQqLctfq7aaJCbwa7J2hUeZplij0rEH/DfkFSSvGuzaes4Yg3L32VQgOSjqK0mZaYWU38
	Hl0IQAc=
X-Received: by 2002:a05:6a21:6003:b0:38d:ebc4:b552 with SMTP id
 adf61e73a8af0-39545ed5054mr4712151637.27.1771769982592; Sun, 22 Feb 2026
 06:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com> <177171292163.8396.10671162503209732019@noble.neil.brown.name>
In-Reply-To: <177171292163.8396.10671162503209732019@noble.neil.brown.name>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Feb 2026 09:19:30 -0500
X-Gm-Features: AaiRm50aSxTeiNBHciBrrBXQYNf54mJgxuioR2fz7pTB6PQcKrI6Gq_TY-UauFU
Message-ID: <CAHC9VhTv+K44q7+5d17jS8h9fJY_JfQVUw5NPNvPzjkHDpqp=g@mail.gmail.com>
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

On Sat, Feb 21, 2026 at 5:28=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
> On Sat, 21 Feb 2026, Paul Moore wrote:
> > On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Instead of explicitly locking the parent and performing a lookup in
> > > selinux, use simple_start_creating(), and then use
> > > simple_done_creating() to unlock.
> > >
> > > This extends the region that the directory is locked for, and also
> > > performs a lookup.
> > > The lock extension is of no real consequence.
> > > The lookup uses simple_lookup() and so always succeeds.  Thus when
> > > d_make_persistent() is called the dentry will already be hashed.
> > > d_make_persistent() handles this case.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  security/selinux/selinuxfs.c | 15 +++++++--------
> > >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > Unless I'm missing something, there is no reason why I couldn't take
> > just this patch into the SELinux tree once the merge window closes,
> > yes?
>
> Yes - but ...
>
> Once this series lands (hopefully soon - I will resend after -rc1 is
> out) I have another batch which depends on the new start_creating etc
> API being used everywhere ...

Okay, thanks for letting me know.  I was curious about something like
that based on the cover letter, but the timing wasn't clear.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

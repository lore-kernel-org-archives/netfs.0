Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F11B86C2
	for <netfs@lists.linux.dev>; Sun, 28 Jul 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172655; cv=none; b=ofvFkw2hspwWIDVhJaGwvGh0SSNxeF7Js0lhtw4Nlmryyc16lIRxW4d+E1V665+aVFwbKRPmnxw34wUge6GoKGgCcOPDr6VZifQT1x00o5LYekTe6L3ZU9X9proQKtz91Bl0rzDuTFwYNSebjD8vYEoPAPPdxCLx1fKaU68DaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172655; c=relaxed/simple;
	bh=YdPY4IU2eccFTGlXZkRJ9P/W2uFYRJ5/DSkvzOfwor0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0vXHadbG//ix7O+WL1+l7bCAsgD6rqwoVl3BeQFeR4UZrzH8897g4Spy05d2MKSGIXm2eMXBWMIQ536fMu5mMMCZPHjSzTMNtsMm2xueND110xQEXJNon3KXpwipy5t2jzPgru66DpyBq+ICdCFoXQDQu3YdOeRbhIQQlOy8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GHOFDgCB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GHOFDgCB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a8553db90so401952166b.2
        for <netfs@lists.linux.dev>; Sun, 28 Jul 2024 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722172652; x=1722777452; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdPY4IU2eccFTGlXZkRJ9P/W2uFYRJ5/DSkvzOfwor0=;
        b=GHOFDgCB/Nua0beaV3lKnkDWSWaAiutnkF1ZOudDdEhoM6OQ6zx/oUSKqi78JC9xjw
         8bHpAiPd97RutL0tHJcBy9TItDwqvkXQi0ZEhP2kMdkYJpwfGtbIyT/6gaQAPihP/ReY
         eQxlr6Wi95kxbEHQCHJIRTI1e5MWocuE3r05U/7jugpYe5nN+VUJnlrGF7lVszk/E60w
         O008ms69GYD711JxhFIExbAIoUGJ6RMB5dG7Ry61ykIAE2PiEH/3ujsLwAOggu24hx98
         irDrip0cBL8XC6N4r9ZCYqF7FnHdoAaqAoxb7hbyk+ZqGs8ov6UxeM55jJCNqlfLuO6l
         34Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722172652; x=1722777452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdPY4IU2eccFTGlXZkRJ9P/W2uFYRJ5/DSkvzOfwor0=;
        b=UMB/+jji23JIfLD4r1bqGIIEFeSm/0Lysj2u3CbVs/kD7g9W355MJCobXBgmoCWMCj
         QMly/kvzlvM640HYE0CpK+Akajdulo3QU/a0yy6gqdYQ/lw4lxarrIYuJZbylUZzBjrD
         gvRQocgLrV9jFjvzGGjnqkfyCrk1bM8tJJi4PkBrf+etSVtru8ABewQm5lS+RhIgrsTn
         K/X93ciYK+NIvoE2yENOaYCfHTSNw0vZXi5/+GOB2h6DUP6dL+hkJ2U4yTBCclguKAqj
         +cGW8SyIOm6ZGy47DJWgZptGxisywUkVSOVL0ybca4MrxpBAlNaO1r7yEGaFUuZhD9/R
         Xycw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/OXcUsp8oaWMhKHaZBYQ0xzweOZic2LXbji/XPSq4MlCqLsA/Bqnm+YcUgM4tf1IBGiwN8yG/k+jEfV6VY4iw9LPrgk=
X-Gm-Message-State: AOJu0YxvpBn+J7HGboNdd3nzx+9o4oN7cyfDjK0NUr+eZaYV4Oe3w5Pv
	umYSq0aYEmMwcXp0aq6M17ML+5/iNJfSrDJwWHllnPGqfKBBXvFlk9yDuy2yOy/6LTGyYHJpO/1
	POV4HvEmoBhC26Gn2bSw/zuFpdL3sf6av2CJ6kSTnEcHizhiZcQw=
X-Google-Smtp-Source: AGHT+IFmZb6t693nBDAauF4mz3I52hdcdUju10lRZJqwwIsQAzHcx3rYJaYLkglaOjBj3RpAbwI7+n0a8KqtAUqO0Tg=
X-Received: by 2002:a17:907:36c8:b0:a7a:9a78:4b5a with SMTP id
 a640c23a62f3a-a7d4012b2dbmr289617466b.52.1722172651450; Sun, 28 Jul 2024
 06:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
 <e5f8c7b5d0657bcb10daa6fe268a62a7ed1b7672.camel@kernel.org>
In-Reply-To: <e5f8c7b5d0657bcb10daa6fe268a62a7ed1b7672.camel@kernel.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sun, 28 Jul 2024 15:17:20 +0200
Message-ID: <CAKPOu+_5YjJnm_4KVehELsWLRWpET-pPWo4VH1GFK_xtgd2uqw@mail.gmail.com>
Subject: Re: RCU stalls and GPFs in ceph/netfs
To: Jeff Layton <jlayton@kernel.org>
Cc: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	Xiubo Li <xiubli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 1:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> That is really weird. AFAICT, 2e9d7e4b984a61 is just removing some
> wrapper functions and changing the names of some others. There should
> be no functional changes there.

Exactly what I thought, I could not imagine how this commit could
cause such a bug. The only chance was that netfs_rreq_assess() now
always directly calls netfs_rreq_completed(), but not
netfs_rreq_write_to_cache(), but I don't know what that means - this
different code path could be a candidate for doing something
differently. Maybe it's an old bug that only got revealed by this
change.

Anyway, I tried to verify this and the preceding commit for hours, and
the picture was consistent: that commit reproduces the RCU stall
within minutes (though only 50% or so of all boots), and the previous
commit never did. There is still a tiny chance that I just wasn't
trying hard enough. I'm out of ideas, and all I can do now is start
digging really deeply into this code, but I thought it would be more
productive to reach out to the people who wrote it.

Max

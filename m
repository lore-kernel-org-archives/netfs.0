Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297B23A992
	for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538520; cv=none; b=P/VlhYVGHL0W9mhjZV5z65O+qZiN8PykiBjgKLc2W6Bs+mf8tZqgp6OrUvBy2rB1rtk01oHrMN9KVoX75P6HujaS3369721ijaq5UIMxZodu8M/u4Qhwn1knsRfKsUzupMkbyrk87+o2aDm4O/rZIVD2G1oBjBhPeEWLZVrW5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538520; c=relaxed/simple;
	bh=neEm4+Cx/iEQVvb4iKsSOqlmD79lxM637n3ua8WM8qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reu9FJPB1VzdBCSnujPE993WAI9c4q5oUTLS0D6QHzqTLTMqiINPkQDVBgzpW6CraLC+08F9THY7r041T9ZxGObwzCMsLzB2fDljMsLw6PQCZUJBWQURx4UIwGCX9YSVs+ITKNS5+btmdcFHvdMNGrzlogxp9ZOQQNqJ3AB0fM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Pnwk7EP8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Pnwk7EP8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab771575040so627839866b.1
        for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739538517; x=1740143317; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FblFcMwedzNnfAxN1Z4KRU7BW8Pt4N7aNbycDWrv6Kc=;
        b=Pnwk7EP8x+/GSfFrolO0D8ujrIwReylX6VtpzD1Jh0uBVbn3NeBvzKS+r1H4437GdM
         KifjzBL1sJbDUt89aLdsEBXyAC6m1mqqFKycXjYxRBE2Uj5fxUPkEJrVlNTcDGERSn5L
         tKGjsE+BOpM5PofEWQ3w2S5NBSopPea4+sdL0Aekmp4PtzsPKvGDlu1SqnRImiwpUDff
         wF0/7sRet9WkLU15EwqT1B/PYcW2wkBlEw1jSq1LabWC8Rme3d4JFZVDDr6jscOdO9zC
         6Rq0Y5eo+Zx9krsU0WwmRJsNvnjbKU8LAqmw71XFdSTuDWgVZrCGN6AHjwL404sSWH3D
         EcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538517; x=1740143317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FblFcMwedzNnfAxN1Z4KRU7BW8Pt4N7aNbycDWrv6Kc=;
        b=iy+bsHB6+ZFZ6UqoENaNr4gBnZKq/dQA/1X0cqXtM+DnJN2Fn/vclj8gMBqIfpKoRx
         4E/3ty5f+H2PmN3oprrpH7BxgTxJW3EWkIiFTGeT38iDm3OW12oA1vobiV2ejH/+OwO6
         s+tOpyIIYGgeP9AXYkpTM7DtANrsVsu4xF9oswmP18LJPfS53yMmibyE+If4qzar9+wp
         ox8euFdlGdallBQ9/xRyoEXSi4vltlPv9PYZmtTRlaVg9PvP0dQ23YzZA9Urh8WUWepE
         1dVl9hfED32w4KteRrPlH+C22JXx+q01L4IVCI4WNHBwBtyDZmSGfMLTRPMEHS9uiAiw
         R8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUvsVPgTiDxPTqn4YwAj/SNdCrtxldjJN/u6hQNVbqE6BU2JDDyxt5k0G7780NkHJrMBN4NTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwijlI+XPV5DoQ9eSPG2P+Zf0kNJkJol37cmEouaCjM3eLsVDHA
	jt0ElDxK6Vc57sfo4cGmuQn2YnEhb8e3j240WpcEGIujUT2OTAGXkOn2v0Y7KUj/xF4dnWvzBPh
	eYcZr2aEzRu0FI9ZAqVw1s9ZzUpzLqxfK/WjtXA==
X-Gm-Gg: ASbGncsNRXJo/GKwBl6W4my+ysrlxX5wRwdfOdGAf3xdhQJ96zaWw8ILMUaL1mMhpqs
	0KtV5Y36OYtfd8mJL0PuPgE/mifCLVIbV7WqU+dyPiO+tl9y6MI5CYKNFzSuuXAiN0/AY9cCdYA
	g5I8I6VbuXE9vV13R+Q+KJVpRt1g==
X-Google-Smtp-Source: AGHT+IF50ioArXYzWdb9AwMM5Jd2Q6Gaky4E7wPQIfV+mgA5jj7trK1nfZmCALNES+0mGT+0rIc/VOt17oANdRVwXjc=
X-Received: by 2002:a17:907:2dac:b0:ab7:462d:77a5 with SMTP id
 a640c23a62f3a-aba50fa00c1mr561174666b.7.1739538516107; Fri, 14 Feb 2025
 05:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211093432.3524035-1-max.kellermann@ionos.com> <3978535.1739538228@warthog.procyon.org.uk>
In-Reply-To: <3978535.1739538228@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Feb 2025 14:08:24 +0100
X-Gm-Features: AWEUYZnphr9tXHnNU_D4Lm2cTV5HRLCiurerIEsfzwR7a2ytXNxgP0imZ2tMeI0
Message-ID: <CAKPOu+8fGrCgzL6q0SA+WKesMTDEMWkOgTDb1AA_=GN4_k3abg@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
To: David Howells <dhowells@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:03=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Max Kellermann <max.kellermann@ionos.com> wrote:
>
> >               prev =3D list_prev_entry(subreq, rreq_link);
> > ...
> > +             if (subreq->start =3D=3D prev->start + prev->len) {
> > +                     prev =3D list_prev_entry(subreq, rreq_link);
>
> Actually, that doubles the setting of prev redundantly.  It shouldn't hur=
t,
> but we might want to remove the inner one.

Oh right, that line shouldn't exist twice. (Previously, it was set too
late, after the variable had already been dereferenced.) I'll send v2
with only one copy.

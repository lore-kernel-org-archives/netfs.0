Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B14DBD64
	for <netfs@lists.linux.dev>; Thu,  2 Jul 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002183; cv=pass; b=kHiy+O8EBtIzllPX1HMPj3i3ILZPUwKpqv9UnmNv8dTHnjiFixTBfSUyyTdvUEJczKMxmWRPAmeY9BDJeabPJFaYFH+LAotpynv6BqdDOSxKMqDb2cdxjL+FOUATCcl8+Lyt9Lw56NKra7VwEzLVPMGzbjSfzKQNAe1aZTRjjWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002183; c=relaxed/simple;
	bh=rlGJmIRph6L87Y/a4YB9PrGgW1WSQ12bPAK7QlxOnOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWyjo000PmR7RAQCrZ3tEIlwW/5JnBBMDOWceqPxiBjn1qEBzs73LxOwEG/pdM/MwFx6CYj7pm3NMG5v6BIaByt77pWAtSBmx+sclnbEbaOWBxN47wbscxFi+CGmBgzEqBCMBVho56GqxjMyWZVlfzUJOglYZRPbl/4VoZMqJyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtW+MMkB; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtW+MMkB"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-920f33347f5so98768485a.3
        for <netfs@lists.linux.dev>; Thu, 02 Jul 2026 07:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783002181; cv=none;
        d=google.com; s=arc-20260327;
        b=aSGOOWd666y27diuyumDT6YsHVdZjmuy0dnnHI2wYNIwBg4lW3K4LjwrHgED9KGLqI
         Q49xey3UeT6LrQJ4VLaaFqcg5KtCWwJrX9vDNpnWAbQMO3I345+3dI8TiCUqfH9N9ZNf
         KvA8aT0RrvRdtBI/0BRh7BOWZaHCYq9bfXHJoHHbUwjdbJNQ9LVOElgSuQEvYI+wtSWX
         co/P9MwGpLCOULcz2dUUfFqwRuRNCmL39XPo64WdoG5pj7v0ZPcLOA6GX2J1TdiY2gRe
         kfALHayt/roJZ77wtibfku0Z8hu0C3xnKV62ZYjy6unUCYcmniMSQ+eWlEUMPKCeddOY
         kYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gbH3YLpoRRRBEQibj7D2qVYcaHe6y8OssH9lEWG5bD8=;
        fh=XZ4WJk2mUTFGkMYVqEW9jGNQKnQsR6PkT7aRqaIj32Y=;
        b=DGf0V3vZc16fhpMhgfky/z/IAvgaZ1i6ovlY094VerxUKgMe5K8c1FC0Z7vTUKozuh
         LfR/Ef3ZAQx6VssafRZhvgy6zTDamKLb7IIYSfkL9o0cLhrR0iXoj8nwlNHfghDROzuy
         KXG/1LvbLIQpcx6YooImzTim29dacWgH6tbibjmEQQGITWO72OXsB2ziJscvMj5p0QwS
         xeRXQ36cVokTWPPLEVDI8HY7oq1OaSAwyv46F+yLq1RX3y4Wi8ABsN+XRDUlI8zJ681u
         vJ6ckGBrreWs8flmr/KeR66ZwjYnN+LZuVmqOhZPnLVtDuwBBaBFl+O8vQvfUMuyc3ag
         zggw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783002181; x=1783606981; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbH3YLpoRRRBEQibj7D2qVYcaHe6y8OssH9lEWG5bD8=;
        b=CtW+MMkBDMTSxFKNq1exzHmVl656BrYo9f0UVoicHFqtw8DCokuDU68EBjluNPc5u8
         aBv5jmlqn9xeRtaZoZQzx7aK4nLm5CQb7VnjIfDgUx0Ni1YBoghGrmLlnAJggZtLh4Jc
         qaItAkBNCJZCI8sIjBEW7ZUakTs6ZNx6dyoIcIncfz4MxhX7WwXZFZZEzc47YHqX+zsL
         WdcmZ2v2hZNvH+w00OzzXGzjCCHKMsiMddYJdLcUHm8tk5PnFnbhgagvLGV82m4Wm67l
         lCgDw9rURsiozlAW5jNPOrktkVLYkiASlcNtx0mt1QOBbWFn31lObKoIV6a+FNXvM2TX
         4KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783002181; x=1783606981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbH3YLpoRRRBEQibj7D2qVYcaHe6y8OssH9lEWG5bD8=;
        b=gGaaC1BiA2fyd3VqyvQo/6gSI0kREKXqZkAyNuJdugexWzKncWE9NAE45YHWN0vYQ+
         ipF1Rh0OxK3rArnXikJoOeEo7tfc3cyQMam3LSDT1FYgnb25qrrAdQXS0ouCfjswktha
         WOrW9mjvMvcaMhfVuLmLUsN/lVaEOCh+UEPyKROYUkFiQq/Zj6MTwWWfYdtNvpLuErDZ
         MfsqGzBviAK3zZ0geDN0hYLRWR4u8oyQ82+cANC4vcHQFw/yD1Ll8Wl4leb/O8/GxRor
         Y8zVykVE2sMqjRuoMmTxBzkROKMeigUGLPokGdgue7nd5zwkxd+m5kZOIWUNG0Ljjs6s
         14fQ==
X-Forwarded-Encrypted: i=1; AFNElJ9y0vk8wHuYcmIRMnyVs25DAnEkO6h3ALtyvEtgxgTDqxxPAbqZqUggXWh04nSZ2loL4YQa3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjfG0Hzs0BGaEIKRk0KA4E30329AlnnYhHUga590TUUQ52kArP
	4WyELeIkOMumbrs/sCNMSlNurnXX4U1pR4/uDqjd74JystRiFYr/SxaI86PWmgT9NYRglrCQ2x7
	zTwTvRFdGNn0I5/HHY2B6xrt7Rus/cM0=
X-Gm-Gg: AfdE7cmuNJn+uLcyT9BRQjl5+DLwHUAbAb8WkOgbvQ0kbsaklv9O3FnViMA/FRDcrG+
	7ZFxIdgahwhA9AqeVrF/6Xb9fkRxjDPmsrNYbuW2MCG4GRRQGcJGH6HiuYkC9jOWaMjAI2TJGx4
	lML17uYMvsJwG343ErCFFwSKSGYcWaDu3ZfRIy7eJnb7NGguf9ipFlPm5K+J1zcW6xESY4/7oWq
	pOBYq4Y1NJ5blumZLzR/QXHdncPtoCSc1D5Tq0GAww5v9LmrK+6gIZl4sNpn57j8+dzLIApM6KZ
	nfFHLBXG1vmnt8vCxPdZNp+JVlj9+hG3RIyHlzSLkAlY48EUD5FVzGZuRweMmL9yz8na9ycyytP
	DBh043mooH53B7NGnHPT55aCw2BRNAitXbEf0bkhyjZqtlc4KzkkvJ312ZQ45v9N4RxTHkE5cU1
	WfCP+0l/YrbYY=
X-Received: by 2002:a05:620a:4888:b0:92e:5a5c:6582 with SMTP id
 af79cd13be357-92e785220ebmr803616585a.73.1783002180509; Thu, 02 Jul 2026
 07:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <138902.1782980700@warthog.procyon.org.uk> <cfbb3e301d90d034922b945c522813df@manguebit.org>
In-Reply-To: <cfbb3e301d90d034922b945c522813df@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Thu, 2 Jul 2026 09:22:49 -0500
X-Gm-Features: AVVi8Ceh8sRx5L0qP6iLeTvZW8yFWM6AmNERvXoYUkt9pPKOdB4YYq5l691TJOY
Message-ID: <CAH2r5msCwtASOc6c3_pxKF3vPqsowbpYWTWPacetzUAeQB2Z6g@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix missing credit release on failure in cifs_issue_read()
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next pending testing

On Thu, Jul 2, 2026 at 7:53=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> w=
rote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Fix missing release of credits in the failure path in cifs_issue_read()
> > lest retrying the subreq just overwrites the credits value.
> >
> > Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> > Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%4=
0redhat.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/smb/client/file.c |    1 +
> >  1 file changed, 1 insertion(+)
>
> Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>


--=20
Thanks,

Steve

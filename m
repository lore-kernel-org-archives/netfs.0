Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C02CA6
	for <netfs@lists.linux.dev>; Fri, 19 Jul 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403948; cv=none; b=ZGzAF25Q6yhmsyzUfG8oqBMhhULqX/BsRePU/A1jydWAR/7fcce1dmS0A5si2m3J6rkkXyVwPm5B0Ho7dfWcaqI+Ploai+DvNvOmI03OEejfNmAJnoOGZBtbVJwARyL6nFV6oO5MRHG7x4PKrmXl9Nx0PB/d7Bz7/obDZboPYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403948; c=relaxed/simple;
	bh=yNCcm/QYc7w8zheT+OuyppYaZxLGgvlu6TA/NU2U62k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adhzXI17BAgP76o/H8Zi1EXOqjqwsbwb7fjaULa+7KnRCF0qJUVQ0Q5RfCsS0UGSn6os3ao4uKsNYktHgA2BmrmxawgGA5VSOEcBwg51H2pZpt/O+a7Sxg5WKTgGVWbFcyqoDEFs47z/X0Y0sVbiio4L58QiJP6V0Edbb7iDekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGFqwn95; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGFqwn95"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso1932613e87.1
        for <netfs@lists.linux.dev>; Fri, 19 Jul 2024 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721403944; x=1722008744; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uqJQihDeCDyfNsoSGpofXtXaBSCbc6LKisKLTktfKE=;
        b=lGFqwn95X8x1EbL8sCLCnsGl1f3245P95cLVBUNhQlK/0ug9c/WW7hx8IccOKevb3Q
         xzibH9oXZtA+6fVXJ3RUxrGh3YMt6l0cnkmWlqe+2jx/c5XGLtoQ/Uv3Y0HWMxqXgKGQ
         AuzXiOC4BkUX+A5ZEbjMb6oZiB/kGav94kE2qc4U4Os7+DUDpavi4aFZH2oAj6iLvbC7
         22i3wA0iZk/WT4sPQXH3ad5yBRMehSbCwfyfyTa4tRC3o1FWsOaFHwuZPhZ454ZmoRM/
         YOl+jQU6cX7jBoDblldWw28l2pmdVPRFSpqMVGJWzMXMYTEA78twjjN8eD/JJBekFNh6
         qaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403944; x=1722008744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uqJQihDeCDyfNsoSGpofXtXaBSCbc6LKisKLTktfKE=;
        b=dSA+4gsKGMYl3fYyxNaycgTbmgZWgJK65xsZj4dJhcO6ZnLr1RE3tjVwgZjXV6najk
         4fZdmvem+M3I84eTttg8fVWQJyWpDDr7H5TPB6TODeE6U22li1BQXldMgoguNgMuO/kw
         5V25+TvBLiR2QpqqDCI+2Ls3DqA8MzPjUph+0SqKZft61K397X5gDyjlVV4VwpjHayDr
         vfEx2jNW71DBzsgmt4fVmc5ETT6QbrFAOOUgfdbRqVZfqKAdl+EKxcLRvWnGkDVR69N9
         lUa+mJ0FK1QQWIwcT4UmX8kGSHnq6Ud4f0vF6f4GlafyA3M4lySOWZy2DMLOIx6Y3YjR
         5/hg==
X-Forwarded-Encrypted: i=1; AJvYcCWL/qNGPDeiC1c9v0iM6X0oOkEo6le/pPY6zNywuf720c21cuZMURxOOCNZhJgPzQvBJTQmGKAHSGXaID/EaS2eDuz5RMo=
X-Gm-Message-State: AOJu0YzS/QPuVE9G95iPxqXD9odUJb511LlPR7bLROQtRKKibe3QiqKh
	tf0udfyMtAIbfyRBz6pfnNKKzsc0sfbnNeSHaOC+ydvtlgIRsUGjgtVM4bUlHKYjHHFLbhhly3p
	3BVAg1InPf+p6GweAdysgbqXx4Qk=
X-Google-Smtp-Source: AGHT+IGWJkrS4HFCJzPyLLEzo6V7TY8hiw3Xb58MJv0SEN+IdGIQK8bacLLac1hTJTn1eVenvx9WKkM6NPZuwTmXUzo=
X-Received: by 2002:a05:6512:a92:b0:52c:d7c9:fb14 with SMTP id
 2adb3069b0e04-52ee53c975amr6090204e87.34.1721403944119; Fri, 19 Jul 2024
 08:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240719140907.1598372-1-dhowells@redhat.com> <20240719140907.1598372-2-dhowells@redhat.com>
 <129ce5e2-2dc3-4185-9057-4c88bc02c103@talpey.com>
In-Reply-To: <129ce5e2-2dc3-4185-9057-4c88bc02c103@talpey.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 19 Jul 2024 10:45:32 -0500
Message-ID: <CAH2r5mvnQzhrY1vwmK0iNoq7g73t702s9-9DPyRuxHum6HbxjA@mail.gmail.com>
Subject: Re: [PATCH 1/4] cifs: Fix server re-repick on subrequest retry
To: Tom Talpey <tom@talpey.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>, netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:27=E2=80=AFAM Tom Talpey <tom@talpey.com> wrote:
>
> On 7/19/2024 10:09 AM, David Howells wrote:
> > When a subrequest is marked for needing retry, netfs will call
> > cifs_prepare_write() which will make cifs repick the server for the op
> > before renegotiating credits; it then calls cifs_issue_write() which
> > invokes smb2_async_writev() - which re-repicks the server.
> >
> > If a different server is then selected, this causes the increment of
> > server->in_flight to happen against one record and the decrement to hap=
pen
> > against another, leading to misaccounting.
> >
> > Fix this by just removing the repick code in smb2_async_writev().  As t=
his
> > is only called from netfslib-driven code, cifs_prepare_write() should
> > always have been called first, and so server should never be NULL and t=
he
> > preparatory step is repeated in the event that we do a retry.
> >
> > The problem manifests as a warning looking something like:
> >
> >   WARNING: CPU: 4 PID: 72896 at fs/smb/client/smb2ops.c:97 smb2_add_cre=
dits+0x3f0/0x9e0 [cifs]
> >   ...
> >   RIP: 0010:smb2_add_credits+0x3f0/0x9e0 [cifs]
> >   ...
> >    smb2_writev_callback+0x334/0x560 [cifs]
> >    cifs_demultiplex_thread+0x77a/0x11b0 [cifs]
> >    kthread+0x187/0x1d0
> >    ret_from_fork+0x34/0x60
> >    ret_from_fork_asm+0x1a/0x30
> >
> > Which may be triggered by a number of different xfstests running agains=
t an
> > Azure server in multichannel mode.  generic/249 seems the most repeatab=
le,
> > but generic/215, generic/249 and generic/308 may also show it.
>
> Nice fix, and good explanation. So, is this the negative-credits issue
> we've been looking to fix? Or just one instance?

Yes it fixes the only recent crediting issues that I had been seeing.

> Feel free to add...
>
> Acked-by: Tom Talpey <tom@talpey.com>

Done

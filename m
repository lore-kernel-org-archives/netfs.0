Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876C1A23B5;
	Sat, 28 Jun 2025 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751087778; cv=none; b=iKqdiSvLELCLZLnMDgypKudhlZC0tGR2LNT5lFfqP8vj4GY5Gy+Ruhfqc1m6bQhJ3E9y6AIqyw/ZYe46olJkvQIJiInKF9yLg48AH2F9eVjBZjOPsZA3dC/oRLfGZGQpFZ1uOvsL9BL/arOMKdtd/x8j7AUXiW6WeBysrQWOzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751087778; c=relaxed/simple;
	bh=kmUNxobeB0njNMzwF7LrNaylmg8DHAlPL5J+TyxuS5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfkQcVjzgoKTWFq+coIyGqJaoMgG43VlRvarmjGRo/eOkDjNY3/+BJw56TM76kZbgI44VET5VNfNdMILEXtiV/eGxPOzvu96nBMYJed7jl8wQ8NLdXWKDvB+w6H3GZFIJKfnM9CV8q0HfDxayVxenUG63hyWrobV1+jkKEbPBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ5k01Ph; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ5k01Ph"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ff16e97d1eso21453236d6.1;
        Fri, 27 Jun 2025 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751087776; x=1751692576; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZzuLz3ZdZm/BXeBE3Uu6Q075nf+/ZJsx7az6Vf24W8=;
        b=hQ5k01PhWmnUBp/W7h2TICR7cJx0l9ZQBz/8QTQ0neutHwfHgNrgEITkGW43KEKPmn
         sAnZTy2+D0qvTzCyMbbIVlsHPgn682Pn1nloLFrvfUy2Iw1q5f+8ZQKhgEcqgZBxFAOL
         sjX/2k6R1lTzcn9LyZ2RQ5LqVI3DfU8007PeT/DOZtCkgNaqbjD77bN1xqEfg2XjIGX4
         zXafhVjRs87oO6D8chcx7pNYSKsvQa/ZWJ40HOsKxNHBRkVHQJLxoQdQjiVHhqOcQB38
         RkegkxjboLL1AO9Y3aKk9BMWF7iFzEr08ODKMyxbxxRXCyjzlovXaM92L3Gr6PNyaYUM
         aZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751087776; x=1751692576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZzuLz3ZdZm/BXeBE3Uu6Q075nf+/ZJsx7az6Vf24W8=;
        b=wXDXtjVfAZWujfBFCgrcHGQ0MD32zr1uaDqPA5BlMx5usH7ybqJrtOzyNW0ZBxD8iR
         jw7Tt1wUD/aNNcVptxhmkwSFqaQtdxyr/xSSfhVqtkkuVamfLWhrPfg4J5OCfC15W4Ko
         g4twuI6k6bGsjJLh3ii/lA7AVZxwdRz5LzUeXFNz0NqqK0/OaCUkHfkrG/2Q8tqHdXk+
         4IeRZUAOnG/bLnxQm8kznPFILE3X/oUd4W8t6rVnV9x+OBK/oXBq5ah0CiXwmZXDM1Xk
         WKTU/bO+w1D7uKinwit8JdGhI49R1gb/Ey8R701/SPMtwLuCMW1xriXNyjP1ChAf8osN
         C3sg==
X-Forwarded-Encrypted: i=1; AJvYcCX4BvX55p1N2953aJ3LFBCBjgw9SLcGv8gRDHNP3/8uap+ZBjuR/dBpVceqM1nc4vYzEyZMOQ==@lists.linux.dev, AJvYcCXPfe7ymM1oeT5+yigMvZmniytuq6hWJ9YPMeJA1DEWIU5t1IRFPpD86ZWlNmH5UgBL8HTaMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0QBrGwKkWstn0zu5th69vPYEN7ZJUaSp2cDKfpF4k5EUVxXjI
	8VXxz9aRHtoDYXAnMKwWJhYt5sCYIhcpHOdMg4FzEgVGr+cfQynVUaEMgO84L2aT9sTisRAZrQ0
	JVh/4l8hSXHwjzRHiBabvW14zaCXhpgU=
X-Gm-Gg: ASbGncs1bXiCfMZ9+IdHqrTKJy6CpDoCx7hAOAPo4l6RQEizv1/89xh8LeamZMtLfT7
	R+AvA5lSlyg45MhyrDpl7sbze/urMdE0ApF5vZ/Tlm72BDaAM79Pprvhih5vhMHfiKdHU8mcWJg
	KHXKJ4r/AmqOuOUjsmZVKmBcNZSqjv9KMfUWFyeGHTJzrfDksKeYnJr8yWdI+r9O+7R5O7jQn/C
	jFF
X-Google-Smtp-Source: AGHT+IE3pV2VIZ8GVDu8D3pAn+xP9KrFnsfkAKfJDtc+HIgTfF3yrwoj4qZhhy4gTbGbHZchNndWk9tFbBpQfYxX40s=
X-Received: by 2002:a05:6214:c26:b0:6fb:265:a2c3 with SMTP id
 6a1803df08f44-7009ec17fcbmr75209046d6.17.1751087775584; Fri, 27 Jun 2025
 22:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250625164213.1408754-1-dhowells@redhat.com> <20250625164213.1408754-2-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-2-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 28 Jun 2025 00:16:04 -0500
X-Gm-Features: Ac12FXwcDHZq4ogM0eCqt7A4iCsu0Kuzvz-14NRnkkfT6DFtusqJyok4ECDYnws
Message-ID: <CAH2r5mv2m3z+PHC_t1AaFAoV0+tU3fHU+HvX1HeK5S11u_KspA@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] netfs: Fix hang due to missing case in final DIO
 read result collection
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can add my tested by to the first 11 in the series.  I have
verified that they fix the netfs regression (e.g. hangs in xfstest
generic/013 etc.).  The series appears important to make sure gets in
6.16

On Wed, Jun 25, 2025 at 11:44=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> When doing a DIO read, if the subrequests we issue fail and cause the
> request PAUSE flag to be set to put a pause on subrequest generation, we
> may complete collection of the subrequests (possibly discarding them) pri=
or
> to the ALL_QUEUED flags being set.
>
> In such a case, netfs_read_collection() doesn't see ALL_QUEUED being set
> after netfs_collect_read_results() returns and will just return to the ap=
p
> (the collector can be seen unpausing the generator in the trace log).
>
> The subrequest generator can then set ALL_QUEUED and the app thread reach=
es
> netfs_wait_for_request().  This causes netfs_collect_in_app() to be calle=
d
> to see if we're done yet, but there's missing case here.
>
> netfs_collect_in_app() will see that a thread is active and set inactive =
to
> false, but won't see any subrequests in the read stream, and so won't set
> need_collect to true.  The function will then just return 0, indicating
> that the caller should just sleep until further activity (which won't be
> forthcoming) occurs.
>
> Fix this by making netfs_collect_in_app() check to see if an active threa=
d
> is complete - i.e. that ALL_QUEUED is set and the subrequests list is emp=
ty
> - and to skip the sleep return path.  The collector will then be called
> which will clear the request IN_PROGRESS flag, allowing the app to
> progress.
>
> Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the wai=
tqueue used")
> Reported-by: Steve French <sfrench@samba.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/misc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 43b67a28a8fa..0a54b1203486 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -381,7 +381,7 @@ void netfs_wait_for_in_progress_stream(struct netfs_i=
o_request *rreq,
>  static int netfs_collect_in_app(struct netfs_io_request *rreq,
>                                 bool (*collector)(struct netfs_io_request=
 *rreq))
>  {
> -       bool need_collect =3D false, inactive =3D true;
> +       bool need_collect =3D false, inactive =3D true, done =3D true;
>
>         for (int i =3D 0; i < NR_IO_STREAMS; i++) {
>                 struct netfs_io_subrequest *subreq;
> @@ -400,9 +400,11 @@ static int netfs_collect_in_app(struct netfs_io_requ=
est *rreq,
>                         need_collect =3D true;
>                         break;
>                 }
> +               if (subreq || !test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->fla=
gs))
> +                       done =3D false;
>         }
>
> -       if (!need_collect && !inactive)
> +       if (!need_collect && !inactive && !done)
>                 return 0; /* Sleep */
>
>         __set_current_state(TASK_RUNNING);
>
>


--=20
Thanks,

Steve

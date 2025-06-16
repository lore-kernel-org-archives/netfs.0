Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3D86340
	for <netfs@lists.linux.dev>; Mon, 16 Jun 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092169; cv=none; b=r5F98lX7nNhgoUVuoRNM+wgdOdV6yBeICLejOY8MgSmUMCtEstAcsmkzt/IXsAfpqvnap+QieYtfYGMRLwa+l+yfSANnjnzn1IRgc4xO6LIuFzLpYDfLu5f22Cadodd1wdvU3tUsFu+3XgULDQXFgTc1ObU7P7e9js45acd1rOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092169; c=relaxed/simple;
	bh=Aam2vH1DT+AxekBGgy42SoF28L3IMN/0FazHzpDFCNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+thcjz3XX8jvp40XvI+NDWsHnYypT5n3uguTHHlZigl5ZOrEQ5QbuZ+xpr6jHG0rztdNXaOYMwrv4ukXZex1swlx94uXRS/NrB5wCxdXVEHKdEvZiAtba7Q8+2QcQKdZEIas8IHNRxVxzY5u4XvJw7GxyUFylv8hYLjjyA4JV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCaYUJXA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCaYUJXA"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32a9e5b6395so39694731fa.0
        for <netfs@lists.linux.dev>; Mon, 16 Jun 2025 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750092165; x=1750696965; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGHjhkWZFw5eS8LrAUaDK4/YE+VvPVva5Ba83r2adLM=;
        b=XCaYUJXAE1rbzNTJSVEC/0Du9PEfinRJVPdTSYq0ki9v38xYyU1MRtizV0LUC4U2Xc
         2PVSlfQ77mGxXZb2K+rA+W1R/u6fNVDhoYS3CUIFfq7O6FW2jhrtH3JJ7A3fL/BBu/O5
         vG0UNR0njQnlEcUdFK4xLTMLlE5bXAE+QttuY9jXrhyTNe2B+3iM2ScrRBvDO2lK7rgt
         I6dEat6f31y35RfhtGLuyq0yTenVRwxrGU6OOWLDoTFad859DIHT1Gm1MDP4sFX9Fcbo
         Y7iTIDO6exJDuORErcO7oYa7lCk5HXso3MrP/P6K0yApaOtnivInfPBtC4BRtO1CAAP2
         pFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092165; x=1750696965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGHjhkWZFw5eS8LrAUaDK4/YE+VvPVva5Ba83r2adLM=;
        b=mdtg6hUmc6Z4Q57Bqu/sW/0kOlNVBgPs9HJI2jSN/+ejOvDdGIEEP4xYqBxT7QG50R
         1NB+kuYvuLqEDfscNAEf2TokQ+8FNt9/MZc07OXaujY1lZ4TkyE+ppFeUEb8uH8QkziM
         89/Eb/pgJes0OhVQM8EM8n4EZprXnFePS3UGZhnybfosLu3Lv06cSHkZkRDFBq/p0tC6
         3MTlTdkFzv3k2khZwQt8irTO9JmyFbSKsapj2cf47vKUj2OX1phqwTDkHVa4I/Sn73Cd
         4896zR2xkkRsfqBMZGu+eN12Ed7n8khJ8i/stn9jORCKwK7cZJJYrdhArEEZqkR10yTh
         a3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU84rQPQBSxaNRyG++eHy9prv7NRpmQyC4TO4TZRBe+XEZOi8pN/2kMrzfudIi4iGbHovQjmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAY7N8NJ457M7i5rx5cICQ+F3AM8k+6hIVBpLAphfy/w3/LMO5
	lia40EEdoYfIpfTYAzvIG4EszL30jeptTSks+fzkF953z64mE0w7zWRnFRUY2l0dpZqWdilBH+9
	0iICFfmmrdELVq91FPX/x/qDqet5iLFY=
X-Gm-Gg: ASbGncv0bKhtOnYrjzWenMPPu3dVNJdM1mxOZfkZywjbHtc6Je5cbboFCuAO3JOs/iL
	SG2PPxP3hkaqDVsWrawUwEgw7PiIXnngfTlPxwHoJ9cmEZ619E9QqkQZcIaoNF9IKxkYpKUnhcL
	fji/Gb5rm9uiFt4Thf5Vk0sl9sPuStcs8kRT8d8YeYy3Ol19583+6JhzKdV20S5tayp0BXRBxSV
	VM2
X-Google-Smtp-Source: AGHT+IH86or2b4nSd6J9yqUJQWOMlBO13YM20Bvxvom0rUZ1yN9rwRJvzisWo7kAvJ4hyXcypNhct8NM1uMudAUyl9U=
X-Received: by 2002:a2e:b8ce:0:b0:32a:7610:ccdb with SMTP id
 38308e7fff4ca-32b4a5da0f1mr25478011fa.40.1750092165208; Mon, 16 Jun 2025
 09:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <583792.1750073757@warthog.procyon.org.uk>
In-Reply-To: <583792.1750073757@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 16 Jun 2025 11:42:33 -0500
X-Gm-Features: AX0GCFuQQ2ViM7WpkUVc9dM7ciBWzW3hsNnLBL0zxXjGbJuN5zTpoPQCLObq__Q
Message-ID: <CAH2r5msJPp9PAvnjOVBOBjjZ7skWMNgH7j2s34uR3oyLxBOVug@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix hang due to missing case in final DIO read
 result collection
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

running tests with this now

On Mon, Jun 16, 2025 at 6:36=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
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
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 43b67a28a8fa..1966dfba285e 100644
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
> +               if (subreq || test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flag=
s))
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

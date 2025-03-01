Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FA7080C
	for <netfs@lists.linux.dev>; Sat,  1 Mar 2025 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790508; cv=none; b=SLf878UilcUnl2UqRXIxa8CfLjDG7NvbUZSvHDH6t94+y32hIkK6yjfkqKI2Kc7QlLlVX3mOqkaRk11/6tyqjhBWltUUbsMSrh4DL6McKmTJJ8Gm1FaHym4cpJ26GYBP0v1YFTEdDetr2ydjLyieieiUxOxVh24XcBoYJ9fHr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790508; c=relaxed/simple;
	bh=3FoZOvTBwt9MqRNEV8L9QF54pvSeq7iiX7+LkWBYvxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEoZ7GcPqSDQjWayyDDt30Tod0P0i2iYP7+GCkjedKgZoMrjA9CdQg0GWFg4lcsQaSzDtr9b2OJ0Y7QtexTPbQ88s/dS+Qy3GwpNOL/Ato3GXEPiCEyA9xqrkQyOZnyGr5aLTbRjC3KoyJogRo4lK2BNudBLMKj5xjf1cui8kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5nVeigu; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5nVeigu"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54843052bcdso2444227e87.1
        for <netfs@lists.linux.dev>; Fri, 28 Feb 2025 16:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740790505; x=1741395305; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sprwftPaK8bnJWe55CjWfHUR1fUrCBkvZCI+DKsADHg=;
        b=E5nVeiguaBlhfzAYv6YdpH4YoSGB4L2WcB/tNz109T8IqH1BQFK6CjDSGKBAC9oRgB
         u2MmBQns3HIGybusDn6+XHa3CO43KEn57tQaTQue6Dmx/gmjD0UbiOmtgzTWk8QdSdDy
         HeGdygjgJibtJC08AZR3yiBJ0Wb0Db/UoUE0m/D78d2EE4ar3FsngcAdS2lArok/H9w6
         enjn7hZwxcv5ohauEqqZp1wMdWOc+9yb6qKFqberl8O4LmrV94o39aWFYu6faeyg00hA
         t5qlU/0WYrBYckrgyLlWKoXOefEZUt/nCjOK3q9uYMPgjS1j0vitj2IbAqZMUlx2JWkk
         hWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740790505; x=1741395305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sprwftPaK8bnJWe55CjWfHUR1fUrCBkvZCI+DKsADHg=;
        b=gsQW9l3uUNjNvAmK5JiX43iQPSkInLC+TBkMKya55P9jemv3zkwxPao97hH8FQcsB3
         cF5VZnnIPpYkEndSXxbkPM0C4/Xlr/etzDI2+ZrhffdT+R3YcsS6xPZ3sF/Ji9T2KV7U
         bFKSHei62JdXaNS0tpJTk9eQQKK4jNyb34+WJ43QE4JxouYNV1Si7xm+7/zxiP3kdwd8
         ziK1PPAnEru1tsfznZBJp7lZGtv2V/4Cp651QFA5UajhmAmGqz9ETfmPiXNqbYLGTG0X
         wUJ+N0LaCVpuwqlgvUqSlpR5UIBECXQR7s2hy2yf5B7Y+F7aAUKgi9AFjHlceaqmZnIu
         DmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsAzMHxPv0f9ZWiG6rIGyI4RivV5TFrWjcNaX85jL6Qz3ZWsMLJJ+73whUvXmD95ccihVK9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKwOXHPSPUC7eBZvAIsHyuHsmshezTplMqG2dTmbAz7u3mQ3GP
	7FtEMxPCSFCOWAHgSy96UZlf0pivEtTkjbSviFQS7FLe1uuknhSfSCXIP2JJ061kwTbF/+qlOUq
	WwZEA3gejJVEwR+c+tbAygbZTr0w=
X-Gm-Gg: ASbGncs/jpW+LT+M5iykeUtqIh1Ns6DrQXCkPAbgh0WiQdns6w78Ixgk6B0HWmih23z
	sA4IhEDBDfBgz1N+mtexalJhdN+CDc+s49UbIrVNbiASSFO9SocwlFpGbL5BJSMZNN5+gMMMrpU
	4VxRwYxoYve4ajcmBZH645OqBKZuL/zKWp2gEp2djM4Zzd98GlAqIpJWs6kxWv
X-Google-Smtp-Source: AGHT+IHasULvzr6B7U4Upg+LWLLBexoCp44DyPdSPr89MzEo775rgHSkb2PdpFFLnM6x/nmZMvWiKvdDQoOUjK3LOkE=
X-Received: by 2002:a05:6512:3405:b0:545:746:f36a with SMTP id
 2adb3069b0e04-5494c32fac4mr2277268e87.34.1740790504591; Fri, 28 Feb 2025
 16:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3431541.1740763345@warthog.procyon.org.uk>
In-Reply-To: <3431541.1740763345@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Fri, 28 Feb 2025 18:54:53 -0600
X-Gm-Features: AQ5f1Jq1RjqOGjIbPeaUziZPzZ5R67gITUoR5QKVQ8qxJA12twJdkCZSGGMTfgg
Message-ID: <CAH2r5mvidbjFykpwyhicaz2nk+-Vbau2RRXqcD4u4u5qT71xUg@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix collection of results during pause when
 collection offloaded
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Paulo Alcantara <pc@manguebit.com>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am testing this fix now (especially with multichannel scenarios which
were failing before)

On Fri, Feb 28, 2025 at 11:22=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
>
> A netfs read request can run in one of two modes: for synchronous reads
> writes, the app thread does the collection of results and for asynchronou=
s
> reads, this is offloaded to a worker thread.  This is controlled by the
> NETFS_RREQ_OFFLOAD_COLLECTION flag.
>
> Now, if a subrequest incurs an error, the NETFS_RREQ_PAUSE flag is set to
> stop the issuing loop temporarily from issuing more subrequests until a
> retry is successful or the request is abandoned.
>
> When the issuing loop sees NETFS_RREQ_PAUSE, it jumps to
> netfs_wait_for_pause() which will wait for the PAUSE flag to be cleared -
> and whilst it is waiting, it will call out to the collector as more resul=
ts
> acrue...  But this is the wrong thing to do if OFFLOAD_COLLECTION is set =
as
> we can then end up with both the app thread and the work item collecting
> results simultaneously.
>
> This manifests itself occasionally when running the generic/323 xfstest
> against multichannel cifs as an oops that's a bit random but frequently
> involving io_submit() (the test does lots of simultaneous async DIO reads=
).
>
> Fix this by only doing the collection in netfs_wait_for_pause() if the
> NETFS_RREQ_OFFLOAD_COLLECTION is not set.
>
> Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use=
 one work item")
> Reported-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_collect.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index 636cc5a98ef5..23c75755ad4e 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -682,14 +682,16 @@ void netfs_wait_for_pause(struct netfs_io_request *=
rreq)
>                 trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
>                 prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIB=
LE);
>
> -               subreq =3D list_first_entry_or_null(&stream->subrequests,
> -                                                 struct netfs_io_subrequ=
est, rreq_link);
> -               if (subreq &&
> -                   (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
> -                    test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)))=
 {
> -                       __set_current_state(TASK_RUNNING);
> -                       netfs_read_collection(rreq);
> -                       continue;
> +               if (!test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags=
)) {
> +                       subreq =3D list_first_entry_or_null(&stream->subr=
equests,
> +                                                         struct netfs_io=
_subrequest, rreq_link);
> +                       if (subreq &&
> +                           (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->f=
lags) ||
> +                            test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->=
flags))) {
> +                               __set_current_state(TASK_RUNNING);
> +                               netfs_read_collection(rreq);
> +                               continue;
> +                       }
>                 }
>
>                 if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||
>
>


--=20
Thanks,

Steve

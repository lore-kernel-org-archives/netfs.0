Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B6143871
	for <netfs@lists.linux.dev>; Mon,  9 Dec 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764351; cv=none; b=oiyJbMrxPm+FMnI9C5CiB8kRIDZDcfGT3qzy4PHzaL25qV+aNn+NfEDZ0Q8UHu1xAu5k/+99J1cixvs6sYKdTNlI/8TwUOR6Osonj2oRBbaX/1lhZsslbCPG0AHGs1Z8Me0MLHNOjfPSDil3QOMz3vcCSHFvPxt96wNR6Jsj/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764351; c=relaxed/simple;
	bh=cOzd8+7H/GN0o1zps3NAZOOuJnioPUq6sgRKP597Lz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMHTjDdZIGFwuVL+vfsq8Vc2Be5qBV59k3VxNWbnesCVzjdl0A0ul0OWpxJYxyoVLyb8W3DEofBR7tYwgvxE+izd95PdXD+e6aJhtbKYk5ypVma1B2gUt2DPDKrRdjZuiCxduO2lInxJJ0fKFAF5Z6516dSCtMLfWvv/bjO/xE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Di2fzjDR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Di2fzjDR"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa66ead88b3so344636366b.0
        for <netfs@lists.linux.dev>; Mon, 09 Dec 2024 09:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733764347; x=1734369147; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaWyuI+1zfgRvLafZXYRvDDVpYcT2uiI1jU4yIWvFaI=;
        b=Di2fzjDR7aHKC7d+vPX+ULEjBQs47KFLOkrGUakpZ9FcAwQWmRiJ8dlc2BhM63mV85
         IXe0ZZUJTtAtJJ1j9y6EjQFRHZGbVbY77T6C41ljya3KfZOd/CxUU24+oNgYT+wroaP4
         oosw1qu3rRhS6UJf9cKS+4F0WS2N2elDsL0eAXeEmuEmEABoQZS4gFJ1KWrEvYs/rZFl
         pIYRYZkbEl+Rq0nY+rgj2yeLqwVuZXPIgOoS3KhDdRjX0C8lcNRpDCBjI7ky09SV12Te
         fq7qQmpK5GM+MBe+PqpP1GlKsv9NpIaAE1UVDLZmPLXNdeQq98bVEq5a7s+JdMyyrPAh
         TfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764347; x=1734369147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaWyuI+1zfgRvLafZXYRvDDVpYcT2uiI1jU4yIWvFaI=;
        b=wDkJQ/TKdyyUn1WMPfw1ViHizzkepvCvFZ7Bedj6l12Ohv4YwdiLp5PtEOTBSPgDvN
         it7vq4u8dDmHkb22pGSwKdl4yCipmN7HuL3plExdc3FIXRHMTFXtqdjIG6g4Q+aD4uTm
         O2vUxh80tTOfHAKEGKu7moMEFZLuErqjReR+YNAj4Z7qgz3Hf9VM6loBK00l9WxzYA4R
         h7WxUsXRodyt5Oh/mhv0Yoxt6vVNqEAhlO+CxdYJXLJgTY9oHFv5z8GSm1LmOFVP/wDQ
         //qVDrNGirJDPgY9zY/SUivMiI4Qfi72QOwFr+RFjxblI3biT89G1VvS8bJA3ZYgG3ED
         VCQg==
X-Forwarded-Encrypted: i=1; AJvYcCW2HnQdivmzByVkFIam33xBc3wzqoDOQRUxn+phL1EBIpncK+EqmkS0msDigqzY331CQwFe+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqXL5/xX3ufonVlexLJhO79nx8KJ2A2klSi2CPSdqyEoZ42dSE
	EwyhzKG7gli4C7YfFSanSfxRO3ZnOcJyiBUUxUsEtOBlBDlIvj2v3lwf33Zy7XxHzTtbNmPGwu3
	LK5goI4bHvBMrbnTah5/tSothREI0lLphVqYUeQ==
X-Gm-Gg: ASbGncshzR3lkMrnKpH5MmubOUujf86tD7n6SALH1nzvvKW9wlvLjyncBEb9syRYQzc
	dqELLAjVG+PX7bp3vzo6iLY/S0P5zH2VcQ9I038o3RMOHJr5xs1ZpjtUOGK/6
X-Google-Smtp-Source: AGHT+IGjhgia80GwIq5GYW/J/My9MoNCTxyL/+qNp0qo2eVT8TVjbjcgPbng+OjrTZMWEUN4ktGPt5mr5dUK2s5wNHQ=
X-Received: by 2002:a17:906:c38b:b0:aa6:7b34:c1a8 with SMTP id
 a640c23a62f3a-aa69ce8deddmr107306866b.55.1733764346946; Mon, 09 Dec 2024
 09:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-99EL_s0rhz_A@mail.gmail.com>
 <2128544.1733755560@warthog.procyon.org.uk>
In-Reply-To: <2128544.1733755560@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 18:12:15 +0100
Message-ID: <CAKPOu+8LSKtGmtjwRpY9tMnt=1Y7RvrhDxVsfSRQW02_g5-6XA@mail.gmail.com>
Subject: Re: [PATCH] nfs: Fix oops in nfs_netfs_init_request() when copying to cache
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:46=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> Does this fix the issue?

The issue is with 6.11, but this patch fails to build with 6.11 and
I'm not sure how to backport that part:

 fs/nfs/fscache.c: In function =E2=80=98nfs_netfs_init_request=E2=80=99:
 fs/nfs/fscache.c:267:50: error: =E2=80=98NETFS_PGPRIV2_COPY_TO_CACHE=E2=80=
=99
undeclared (first use in this function); did you mean
=E2=80=98NETFS_RREQ_COPY_TO_CACHE=E2=80=99?
   267 |                 if (WARN_ON_ONCE(rreq->origin !=3D
NETFS_PGPRIV2_COPY_TO_CACHE))
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~

Our production machines are all 6.11, because 6.12 has that other
netfs regression that freezes all transfers immediately
(https://lore.kernel.org/netfs/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=3Dgcmkz=
wYSY4syqw@mail.gmail.com/).
I guess this other bug only affects Ceph and not NFS, but after
experiencing so many kernel regressions recently, I had to become more
cautious with kernel updates (the past 2 months had more
netfs/NFS/Ceph regression than the last 20 years combined).


>
> David
> ---
> nfs: Fix oops in nfs_netfs_init_request() when copying to cache
>
> When netfslib wants to copy some data that has just been read on behalf o=
f
> nfs, it creates a new write request and calls nfs_netfs_init_request() to
> initialise it, but with a NULL file pointer.  This causes
> nfs_file_open_context() to oops - however, we don't actually need the nfs
> context as we're only going to write to the cache.
>
> Fix this by just returning if we aren't given a file pointer and emit a
> warning if the request was for something other than copy-to-cache.
>
> Further, fix nfs_netfs_free_request() so that it doesn't try to free the
> context if the pointer is NULL.
>
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Max Kellermann <max.kellermann@ionos.com>
> Closes: https://lore.kernel.org/r/CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-=
99EL_s0rhz_A@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Trond Myklebust <trondmy@kernel.org>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Dave Wysochanski <dwysocha@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-nfs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/nfs/fscache.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index 810269ee0a50..d49e4ce27999 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -263,6 +263,12 @@ int nfs_netfs_readahead(struct readahead_control *ra=
ctl)
>  static atomic_t nfs_netfs_debug_id;
>  static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct =
file *file)
>  {
> +       if (!file) {
> +               if (WARN_ON_ONCE(rreq->origin !=3D NETFS_PGPRIV2_COPY_TO_=
CACHE))
> +                       return -EIO;
> +               return 0;
> +       }
> +
>         rreq->netfs_priv =3D get_nfs_open_context(nfs_file_open_context(f=
ile));
>         rreq->debug_id =3D atomic_inc_return(&nfs_netfs_debug_id);
>         /* [DEPRECATED] Use PG_private_2 to mark folio being written to t=
he cache. */
> @@ -274,7 +280,8 @@ static int nfs_netfs_init_request(struct netfs_io_req=
uest *rreq, struct file *fi
>
>  static void nfs_netfs_free_request(struct netfs_io_request *rreq)
>  {
> -       put_nfs_open_context(rreq->netfs_priv);
> +       if (rreq->netfs_priv)
> +               put_nfs_open_context(rreq->netfs_priv);
>  }
>
>  static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequ=
est *sreq)
>

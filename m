Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16425A320
	for <netfs@lists.linux.dev>; Mon, 23 Jun 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688081; cv=none; b=iGqg0mco7Tlb0LfoGmJK/8lEdNlA8NrNLHX5PFu/tuFB/uA6KfqPb+/BM1syde4Mf7ivbtRigxM34uBKu8cwVFWk4AHKwN9eBQpzrGd6DkZsun0XqBBF2kyLFQ/laPoaU22EdOZFOvG3Xoset0PnfI8GhLRd4YxrNGE/emhxoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688081; c=relaxed/simple;
	bh=DrUgJmz9mv9oNuENjezJvKTNsknS0G1u9sssb8hLjWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c68E2d60EaHUgWQ9OFZFmeP/DuBC4mor/7c7EEuRDRZKpqj+pS6CYguHdiHCeqeDX77N109lBNoigz+z1kMTwCMi8Yjkv22SHPGQLXBbGZrj4oUBRxOl1UXe/qAdOJGQZZJFX2/Id/wY6QxuwodYvXjkDj1ujnUC9lDX6GxdLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKaKwDnc; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKaKwDnc"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so17401956d6.1
        for <netfs@lists.linux.dev>; Mon, 23 Jun 2025 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750688077; x=1751292877; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB5mz+FxMOMtnMLrI/M5PI/QmYx/AfyqX4qBVvMef0s=;
        b=TKaKwDnctM/vW3qnseGrkw08NyJwTPenpp8k9/miAO7507w6oAEp8ua0sHbfGIpmgf
         7hKbn4/EsSxZ3UXX03Kv5Bm+k1SsT7VpFd6O48PMLPhdIJeDQbFFZygzFJ8u4vLMsrx/
         UU6cv2V8pJ8oQcJO4Y9UWwIn97RLbXI/Z+RyVUMsie+YKzOmpTnHTtFP4dUcJwFRZ9Oj
         QbXlDHke/pdzfYD9XUfm/Lpd8R0XedGXqBNSu+dHsVQaqVTgzIqC39H//JS7TfogL0mr
         de+R+28VlEt+3p4GfHPA6lOad/rRk3hGWel1pJAp9KEcyk+Jg70K+jCw4ScvfHgvJSP4
         mTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688077; x=1751292877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB5mz+FxMOMtnMLrI/M5PI/QmYx/AfyqX4qBVvMef0s=;
        b=ZbEDwTxpCEz5wcgdRw/0/mMlSTX4YhS+DsGcWle5523qDSPVJ23eBsy5cgROJ9ZwV3
         KDJL8t70P34KHCE12m1GlurEe4m4C3uiX5Y0eDbCkO7Qm9eZomm6znGyLN9YDO5418Ly
         /3+LmZ7aKby51UBVu7Ziu/Rk2nlqkXcg14DKYVYry115K0Hr/jITqDA6QTZ1yDDMj7rU
         e8MTecr59y4Tqa6ryIkqZ7Iy2c7IR+DNVxC46am+TDIzNpyhY72qXg3pVzA0WHV3dJ4h
         NdcEct/v+az/fXoRq7pSqwUjSEb3Gnr3GV+v9fZpGVZWmmYY78RXHwlrS/cDJdNDUOBP
         000A==
X-Forwarded-Encrypted: i=1; AJvYcCWG0UsKIaXjk3bPw2gydT2gXV2e1g7dP4SpqBWJYllInzNIRhZKnkR6760NV+bcsWMWq73tkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOxvXjwaVPvQzewV0l8/pNWuXshD2DFlOLJR/e2ZGsCDQdGDIw
	izLugftLcweXBcgqD3K/HsbVNhnBsmQValWb4DOjGHiNNCmQl2l41Yyceoz2e+iFxYt123mRyiq
	ROrmVe8vmB9Tg5NxJqG4cYGbeDqzHdC8=
X-Gm-Gg: ASbGncsM8Kf7mRc1atYk48PNCu+fesliuy4m5rjjwh3eIOWpUJC/6bhVNqdR8g5GO92
	Co3kBYmqtlVgu3fdNLL8Gd4k+RinFMfNFRfKY7pGoanIbvn5zYR4VIwyEg0JfGKPZule/VmH+fa
	TdYn3W5GCrxtlFoNfYLw/0a5R4cGPg9CfJcjCbGiFsCC4q05eN1kformN+R9C6A7nTQwm5jhaSm
	FVMaQ==
X-Google-Smtp-Source: AGHT+IEkXBzeNkvGlr+MIWstDnY8eKrXwYunCgNIcOP48vnJi9qyAPRtIff07B7nuxNo4Y6YB9GTJmQfZ5jk980sLjE=
X-Received: by 2002:a05:6214:4885:b0:6fb:6778:e205 with SMTP id
 6a1803df08f44-6fd0a535472mr220001536d6.25.1750688076986; Mon, 23 Jun 2025
 07:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250623124835.1106414-1-dhowells@redhat.com> <20250623124835.1106414-7-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-7-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Jun 2025 09:14:25 -0500
X-Gm-Features: Ac12FXxLQPaj9HruER9vjDaDjWQT2gVo6q7LARadtOuRo6Y6TxV_q72wukZRZKQ
Message-ID: <CAH2r5mv5jjtNJmLAcaa7EbXpftuC04F+b_g6YZxkNDTNYnm7sg@mail.gmail.com>
Subject: Re: [PATCH 06/11] cifs: Fix prepare_write to negotiate wsize if needed
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is already merged into mainline.

On Mon, Jun 23, 2025 at 7:50=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix cifs_prepare_write() to negotiate the wsize if it is unset.
>
> Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Paulo Alcantara <pc@manguebit.org>
> cc: Steve French <sfrench@samba.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/smb/client/file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 9835672267d2..e9212da32f01 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -52,6 +52,7 @@ static void cifs_prepare_write(struct netfs_io_subreque=
st *subreq)
>         struct netfs_io_stream *stream =3D &req->rreq.io_streams[subreq->=
stream_nr];
>         struct TCP_Server_Info *server;
>         struct cifsFileInfo *open_file =3D req->cfile;
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(wdata->rreq->inode->i_sb=
);
>         size_t wsize =3D req->rreq.wsize;
>         int rc;
>
> @@ -63,6 +64,10 @@ static void cifs_prepare_write(struct netfs_io_subrequ=
est *subreq)
>         server =3D cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
>         wdata->server =3D server;
>
> +       if (cifs_sb->ctx->wsize =3D=3D 0)
> +               cifs_negotiate_wsize(server, cifs_sb->ctx,
> +                                    tlink_tcon(req->cfile->tlink));
> +
>  retry:
>         if (open_file->invalidHandle) {
>                 rc =3D cifs_reopen_file(open_file, false);
> @@ -160,10 +165,9 @@ static int cifs_prepare_read(struct netfs_io_subrequ=
est *subreq)
>         server =3D cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
>         rdata->server =3D server;
>
> -       if (cifs_sb->ctx->rsize =3D=3D 0) {
> +       if (cifs_sb->ctx->rsize =3D=3D 0)
>                 cifs_negotiate_rsize(server, cifs_sb->ctx,
>                                      tlink_tcon(req->cfile->tlink));
> -       }
>
>         rc =3D server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
>                                            &size, &rdata->credits);
>
>


--=20
Thanks,

Steve

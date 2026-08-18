Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD001643B
	for <netfs@lists.linux.dev>; Tue, 18 Aug 2026 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012227; cv=none; b=iGVDJTt5HbL3D0CiaR1TCYGQIuYBTXMYtyx+fKe68dE7GBYvNl5sVL4gRV50f2/jq09WrjaiEMRwDDQK05YBC9oETQ6TLXcKXkP1dqwti1rHTnI/2vnmWiFnzJHW81mI73G9E4JseHeI2lFyy5TKurK+LX9ho83mFLKnjlPs51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012227; c=relaxed/simple;
	bh=mjpaPiZWDdY/rvb8RX+j7EhGzvUwKXLw/9xdT1p6Ook=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK9bDZNzq0vN5pvWoknS7LfxTmD6ZgRBcqTZKN24iL0FwTjgR1PiIL2zR1duDb83mWRvcVWcd9Muuzv2T/Kxnxp2WeU6u1ej5UPuY5grVDAeO3UQoJvl/GHMaf8zf+M46rNJ7Q47rNbgg5hlWStREKB13HdDRAYZOvBELAU9DS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS5VKSUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS5VKSUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4008C1F01558
	for <netfs@lists.linux.dev>; Tue, 18 Aug 2026 00:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787012226;
	bh=LPTSQGXWsw/cWs8YBVRbC2MT7uy6Y6pyEn/3BE7meHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dS5VKSUz3MTIlgWwyN/84TBJx4o0oTtqiHyCbqvcR9H73l5/3tA0iUyHyNT7PFEWf
	 QFKmEYL9iBWNbPeJhE7n8J3WzKtXA+ohB6mzK9bWnmWCDSxI+nFZAvFXWPvMR40oky
	 7uOtNPVQ6k6HrTkvX/NYbZ7R+EFU4v6Bsrw6C0Ct5OvIJ5VXSyYcPde9VyPHxxqe7m
	 2O81uEwey/dRGxW4vGeSBPohjNliNrn0n/NbYaz7T0o2js0jSSk+Fi8/lFuna7t2Kz
	 LHVrhlET4h1M/ZkREzeDLcIbZid5la3tr3qg2F+EhpIfAei4F0/X6QLa5LoBZ8shFl
	 30T9zsCUIdrKQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso6291418a12.0
        for <netfs@lists.linux.dev>; Mon, 17 Aug 2026 17:17:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoLlqiqnFToMSykjm0lIWtrnmKodW2iENQRF9T9HjnxzwJ8jQcFN5FPmGKL6qO5o5Nfz+/WKw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9K2hK/5GOUaQbz3dFLVLBtUuWiBPw8Y6m2eIvR0vBRfVo0UMC
	NeOpq7ktGX3/Dnd6YVFscdcPGV3TmNhxr7KF5HtPbZGn1p91ElyY7vcnzzgad7q8hDxUxMX+caq
	gdHRXKAKyfH+eJ+yn4eVFbCVp2J7dG8U=
X-Received: by 2002:a17:907:5c2:b0:c16:1227:e3d8 with SMTP id
 a640c23a62f3a-c2129c1bd00mr1437154466b.13.1787012224802; Mon, 17 Aug 2026
 17:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260729220017.944651-1-clusk@northecho.dev>
In-Reply-To: <20260729220017.944651-1-clusk@northecho.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 18 Aug 2026 09:16:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9idDQd5ggKC130P5OjfcbvYbxWhKDDQ7i7fbeuFRQRwA@mail.gmail.com>
X-Gm-Features: AcwNN1Xook7nZrxU7UntBq-6js9x2sL1BRsbxOLHgd1cIxxcSQFwIp7X81K7_-s
Message-ID: <CAKYAXd9idDQd5ggKC130P5OjfcbvYbxWhKDDQ7i7fbeuFRQRwA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix request buffer leak in smb2_new_read_req()
To: clusk@northecho.dev
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	pshilov@microsoft.com, longli@microsoft.com, dhowells@redhat.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 7:05=E2=80=AFAM Christopher Lusk <clusk@northecho.d=
ev> wrote:
>
> smb2_new_read_req() allocates the request buffer with
> smb2_plain_req_init() but only publishes it to the caller with
> *buf =3D req at the very end of the function. Two error returns sit in
> between:
>
>         rc =3D smb2_plain_req_init(SMB2_READ, io_parms->tcon, server,
>                                  (void **) &req, total_len);
>         if (rc)
>                 return rc;
>
>         if (server =3D=3D NULL)
>                 return -ECONNABORTED;
>         [...]
>                 rdata->mr =3D smbd_register_mr(server->smbd_conn,
>                                              &rdata->subreq.io_iter,
>                                              true, need_invalidate);
>                 if (!rdata->mr)
>                         return -EAGAIN;
>
> On either of them the buffer is neither released nor handed back, so
> it is leaked. The caller cannot clean up after it: smb2_async_readv()
> does 'goto out' on a non-zero return, which skips the
> cifs_small_buf_release(buf) at async_readv_out, and buf has not been
> assigned at that point in any case.
>
> The write path has never had this problem. smb2_async_writev()
> registers the memory region inline and jumps to its release label
> instead of returning:
>
>         wdata->mr =3D smbd_register_mr(...);
>         if (!wdata->mr) {
>                 rc =3D -EAGAIN;
>                 goto async_writev_out;
>         }
>
> Commit b7972092199f ("cifs: smbd: Retry on memory registration
> failure") changed both sides from -ENOBUFS to -EAGAIN in a single
> patch, which puts the two shapes next to each other.
>
> Only the -EAGAIN return is reachable in practice, because
> smb2_plain_req_init() calls smb2_reconnect() first and that already
> fails with -EIO when server is NULL, before anything is allocated.
> Both returns are given the same treatment here rather than leaving
> one of them correct only by accident.
>
> Because -EAGAIN is a replayable error, the failure also reaches the
> retry block at the end of smb2_async_readv(), which marks the
> subrequest NETFS_SREQ_NEED_RETRY, so a failing registration can be
> retried rather than ending the I/O, and every attempt that reaches it
> leaks another buffer. smb2_should_replay() short-circuits on
> tcon->retry, so on a hard mount the attempt count is not bounded by
> the retrans setting.
>
> Only the asynchronous read path is affected. The synchronous
> SMB2_read() caller passes rdata =3D=3D NULL and the memory registration
> block is guarded on rdata.
>
> The memory registration failure path was pointed out by the Sashiko
> AI reviewer while it was reviewing an unrelated patch to
> smb2_async_readv().
>
> Fixes: bd3dcc6a22a9 ("CIFS: SMBD: Upper layer performs SMB read via RDMA =
write through memory registration")
> Link: https://sashiko.dev/#/patchset/20260729192002.876156-1-clusk%40nort=
hecho.dev
> Link: https://lore.kernel.org/all/20260729192002.876156-1-clusk@northecho=
.dev/
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Christopher Lusk <clusk@northecho.dev>
I will apply it to #for-next.
Thanks!

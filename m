Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398D28688E
	for <netfs@lists.linux.dev>; Fri, 30 Jan 2026 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744238; cv=pass; b=DOOSRglkpbXgjkkR0A4wcvELBIcjgZu6HSJW5X3B1THG3nd/D3UCqQ4vCzaJgyoRhEFeYLYx8fDFwKa2g4KZqJzrTRtTz4qiUu2Ppi+LwjktFkJf1XgdMyZQmNO+LRIXWCUV20rrlvCiyzkbgxqRZ2YXN5f/qaRS0LjERfWMikA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744238; c=relaxed/simple;
	bh=de3XXDcEmALUkx4TBqZ2gxpkwlii/WLm8HXIWftrCK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzSfnRoKD4M6vc5lwTCDP7MRjrfvRD42RS4STqwaaiYca/+pWO6XluUJ8OR3B/NSWNO5JpmVtb7UvpH10t4XOlKHeeJGvaJ0BJjRs7e14gIYPGx7peR4wvxdz29DjgU0zIoz/MYCiJorcEnXD17jNBYtk2E1Oy5DStClYHIyRLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlLSxd5c; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlLSxd5c"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-894774491deso22480916d6.2
        for <netfs@lists.linux.dev>; Thu, 29 Jan 2026 19:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769744235; cv=none;
        d=google.com; s=arc-20240605;
        b=Nx2S5aXDa6MGKnZJ6CXyMyM8zrRkuCGNBrhx3jWdIv+my/yg9HWC59tbSbW2Nmq3i/
         3+TqSAMwG/RLlAjdyE42MeaponCnBHLb6ggjkEu3+tVKGbUPqus0SkBr+O4g3Lpr2wTu
         SFiXQhPE6IE2hVRXHFKjblXggiJYn7Z48J+Ff6nwa1u4xQj/VnB4Gv0fA2vcevtP+FWs
         5gdZhTM3iEO9j4aOA4Wh4BpTkux53GSSJJJEbN/CHEF8zOblgkSQFIKPFfN5bHuJKZZ/
         tME0HZ5OLCbCQ5nFKVfk6jqSryC8EQG6MbxuJjL2YhSSF/WwLBrszy3lhoZZGOBIGlJ+
         kEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rh3Wzt35Btq7y0Hgb2Bh/GPm6GsGaRYyWQ7nASTF4Eo=;
        fh=qCoWGN0AB/ef6tWC2ncbZJ/w73x+VtJDnzolpS8f/Kw=;
        b=jFCCb+PrNyg6IC93fob5j4dp6N0eBuzZJDzcBdAdygQwBRJcYjvsiuRwEbxxz98fGM
         CW8f58YmBN607h4V3XXUWqHptKuKrJYX4oAB6U9Je8Qg82+dRgsVAOeplBg7ll5dc/Ex
         emwkzj2hAo1a4mIUKR0Ah4QRuQzB4bYr15+bpBLgQRENBx5kGFXRE1PzqgwR/t5D3JdN
         SDjEBJzeQ6uV2WGjOzfbsfzIXeCHmdT0Dslvw1JQGUpBX3HS7k+I6UmAANVpdRcxHcCu
         kYmWTHInYByZhiWXSyNjz9kU2cF0YxJ9hpgoaq2W6E4JESHOTUPkQ9bafUv6ixCV0+Jp
         96kQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769744235; x=1770349035; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh3Wzt35Btq7y0Hgb2Bh/GPm6GsGaRYyWQ7nASTF4Eo=;
        b=YlLSxd5cWvn0TXQUy55uJHklRE014XNGjqLPVgYYsNGg3rqiTywpfjSk7Y+iZV6CLf
         FKE+9RBpDFXSDhPVmuPUoOz54ZvxjxU8Sech6eGNNzAY5JIvUAPPSqWcm2JjYdVTMEN6
         sQsa+JKpwVzo/hvacHz1ez+6sY4W4D4Y7y5A4//wu3sfjeaX40qeUmZc1hGsZBWicxW0
         IFFDdSLLYLnWug+aEjaZxm88hWeK4FjUeGR83rvO3mmKIbZa4rV/M7JetpZ48Yad8+4N
         LIjmnfIHRAj7UROhFqbK0VmbB0uSK14rN2WnfE6UQ5Co+/YyzjkjpExTAnkGpz+Zvbby
         XhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769744235; x=1770349035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rh3Wzt35Btq7y0Hgb2Bh/GPm6GsGaRYyWQ7nASTF4Eo=;
        b=eb4EYluB+YpLuxElUIzg5NlnjgaXzdvVbWnZYhrglUG0asuT9T9sL4lB7f9F2on1N7
         YuIIhjRcHS//ReKAKRtIIC4XZgQA23FQxPK7mJoFXMQxj7Jef8wvu/n228R3e+qZbZTP
         +hNXPsUVnzaby0B0yGI92/cWXsZCjZGSvUoXQiwGIXnxlXIU4atm7AlDwcHPXHyPl4BV
         zuqgP356QhCrFH0FfcaZDidAQRaHLHyqG7FYS/rw2eZN4c1ovcFCtldA4GZfZU3jv3i3
         +ABZgoTZrfSFPdsERa1iZzjexSyjSQ09r7GHKxs1/E2hWzDoF0fL7fJaIckvsfDamd95
         9nmw==
X-Forwarded-Encrypted: i=1; AJvYcCWOrXFa1awd+H/TAcB18WtHGzva2e2ot3jTPixypPJxydrvxVEFmzsikz93WD3drSHpXIPPyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrpEEnwLwCw1LQ6ciz5YkbMADNNidMoYUjSz2g+ltMFvkqlx8r
	xYeBx2GOZpmE4X7lRVv532ewMF/0A6sYd0zwFfc5344NJWuwf4hi4XL5mI1Jc9AXo6UU1ig/1G6
	3C2wiC9XEnG32HqZOyfEL3NNxZB2Vnx7o7VKJ
X-Gm-Gg: AZuq6aK8VutPIIqvjUybh+aCbiW0RJHuWV5BaERvcLHNJ9grI2HAWPpazu3i65ljK2+
	6HYCLj3/7wXaBSleuVPzIx6Xz2VHZ8f6UX20IZtq14UUvpYvoSolH6wlfK3vIT1e+RHlsdsVB5h
	mgbUXN7hpymcPk8yXolc0N22aowlzm6yYaXD1g1RWiPHbRAkr4tQ1rbbyvbTUqXk9NULuasjGcO
	9Wd43gJp0rUZ39EtqmtQnnEp2vM09nnGw4NG9EtgrQxTUz+IeFbIlaI8oyiIQXsyb9tPEiIu9CB
	V1Ec+jUFAlmhn4MDR8L45b+5Lmr3WMPtq3/7lrDLHmQ6bgtxw6JavTbJIbFA9gIfTirI1zFasRy
	dmz0h6BA1c03j6x+ocLtSf4KB/R1x1x+e+0LbAJyzW2EtXuf66hk=
X-Received: by 2002:a05:622a:4cf:b0:502:e3c8:2e25 with SMTP id
 d75a77b69052e-505d22b6550mr21189241cf.76.1769744234755; Thu, 29 Jan 2026
 19:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260129173725.887651-1-sprasad@microsoft.com>
In-Reply-To: <20260129173725.887651-1-sprasad@microsoft.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 29 Jan 2026 21:37:03 -0600
X-Gm-Features: AZwV_QhbzIMVectmIi2_1SlJcRgrdL1QDyR8XTp6C3fl8D84mGPbVqlFLhvCX4M
Message-ID: <CAH2r5msuwKLRthznEmHfasczU8_Pti+KAi1crXcMwNBnuiubsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] cifs: on replayable errors back-off before replay,
 not after
To: nspmangalore@gmail.com
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, bharathsm@microsoft.com, 
	dhowells@redhat.com, netfs@lists.linux.dev, 
	Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Have updated cifs-2.6.git for-next with these four patches

On Thu, Jan 29, 2026 at 11:37=E2=80=AFAM <nspmangalore@gmail.com> wrote:
>
> From: Shyam Prasad N <sprasad@microsoft.com>
>
> On replayable errors, we call smb2_should_replays that does these
> things today:
> 1. decide if we need to replay the command again
> 2. sleep to back-off the failed request
> 3. update the next sleep value
>
> We will not be able to use this for async requests, when this is
> processed in callbacks (as this will be called in cifsd threads that
> should not sleep in response processing).
>
> Modify the behaviour by taking the sleep out of smb2_should_replay
> and performing the sleep for back-off just before actually
> performing the replay.
>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---
>  fs/smb/client/cached_dir.c |   6 +-
>  fs/smb/client/smb2inode.c  |  21 +++++--
>  fs/smb/client/smb2ops.c    |  32 ++++++++---
>  fs/smb/client/smb2pdu.c    | 112 +++++++++++++++++++++++++++----------
>  4 files changed, 129 insertions(+), 42 deletions(-)
>
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index 1db7ab6c2529c..df9977030d199 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -154,7 +154,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tco=
n *tcon,
>         struct cached_fid *cfid;
>         struct cached_fids *cfids;
>         const char *npath;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>         __le32 lease_flags =3D 0;
>
>         if (cifs_sb->root =3D=3D NULL)
> @@ -304,6 +304,10 @@ int open_cached_dir(unsigned int xid, struct cifs_tc=
on *tcon,
>         smb2_set_related(&rqst[1]);
>
>         if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
> +
>                 smb2_set_replay(server, &rqst[0]);
>                 smb2_set_replay(server, &rqst[1]);
>         }
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 2ded3246600c0..498a26a7bd415 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -188,7 +188,7 @@ static int smb2_compound_op(const unsigned int xid, s=
truct cifs_tcon *tcon,
>         struct reparse_data_buffer *rbuf;
>         struct TCP_Server_Info *server;
>         int resp_buftype[MAX_COMPOUND];
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>         __u8 delete_pending[8] =3D {1,};
>         struct kvec *rsp_iov, *iov;
>         struct inode *inode =3D NULL;
> @@ -638,18 +638,26 @@ static int smb2_compound_op(const unsigned int xid,=
 struct cifs_tcon *tcon,
>         num_rqst++;
>
>         if (cfile) {
> -               if (retries)
> +               if (retries) {
> +                       /* Back-off before retry */
> +                       if (cur_sleep)
> +                               msleep(cur_sleep);
>                         for (i =3D 1; i < num_rqst - 2; i++)
>                                 smb2_set_replay(server, &rqst[i]);
> +               }
>
>                 rc =3D compound_send_recv(xid, ses, server,
>                                         flags, num_rqst - 2,
>                                         &rqst[1], &resp_buftype[1],
>                                         &rsp_iov[1]);
>         } else {
> -               if (retries)
> +               if (retries) {
> +                       /* Back-off before retry */
> +                       if (cur_sleep)
> +                               msleep(cur_sleep);
>                         for (i =3D 0; i < num_rqst; i++)
>                                 smb2_set_replay(server, &rqst[i]);
> +               }
>
>                 rc =3D compound_send_recv(xid, ses, server,
>                                         flags, num_rqst,
> @@ -1180,7 +1188,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tco=
n *tcon, const char *name,
>  {
>         struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
>         __le16 *utf16_path __free(kfree) =3D NULL;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>         struct TCP_Server_Info *server;
>         struct cifs_open_parms oparms;
>         struct smb2_create_req *creq;
> @@ -1242,6 +1250,9 @@ smb2_unlink(const unsigned int xid, struct cifs_tco=
n *tcon, const char *name,
>                 goto err_free;
>
>         if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 for (int i =3D 0; i < ARRAY_SIZE(rqst);  i++)
>                         smb2_set_replay(server, &rqst[i]);
>         }
> @@ -1262,7 +1273,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tco=
n *tcon, const char *name,
>         if (rc =3D=3D -EINVAL && dentry) {
>                 dentry =3D NULL;
>                 retries =3D 0;
> -               cur_sleep =3D 1;
> +               cur_sleep =3D 0;
>                 goto again;
>         }
>         /*
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index a16ded46b5a26..7980c6f80730f 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -1184,7 +1184,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tco=
n *tcon,
>         struct smb2_file_full_ea_info *ea;
>         struct smb2_query_info_rsp *rsp;
>         int rc, used_len =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -1314,6 +1314,9 @@ smb2_set_ea(const unsigned int xid, struct cifs_tco=
n *tcon,
>         smb2_set_related(&rqst[2]);
>
>         if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst[0]);
>                 smb2_set_replay(server, &rqst[1]);
>                 smb2_set_replay(server, &rqst[2]);
> @@ -1582,7 +1585,7 @@ smb2_ioctl_query_info(const unsigned int xid,
>         void *data[2];
>         int create_options =3D is_dir ? CREATE_NOT_FILE : CREATE_NOT_DIR;
>         void (*free_req1_func)(struct smb_rqst *r);
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -1731,6 +1734,9 @@ smb2_ioctl_query_info(const unsigned int xid,
>         smb2_set_related(&rqst[2]);
>
>         if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst[0]);
>                 smb2_set_replay(server, &rqst[1]);
>                 smb2_set_replay(server, &rqst[2]);
> @@ -2440,7 +2446,7 @@ smb2_query_dir_first(const unsigned int xid, struct=
 cifs_tcon *tcon,
>         struct smb2_query_directory_rsp *qd_rsp =3D NULL;
>         struct smb2_create_rsp *op_rsp =3D NULL;
>         struct TCP_Server_Info *server;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -2498,6 +2504,9 @@ smb2_query_dir_first(const unsigned int xid, struct=
 cifs_tcon *tcon,
>         smb2_set_related(&rqst[1]);
>
>         if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst[0]);
>                 smb2_set_replay(server, &rqst[1]);
>         }
> @@ -2774,10 +2783,14 @@ bool smb2_should_replay(struct cifs_tcon *tcon,
>                 return false;
>
>         if (tcon->retry || (*pretries)++ < tcon->ses->server->retrans) {
> -               msleep(*pcur_sleep);
> -               (*pcur_sleep) =3D ((*pcur_sleep) << 1);
> -               if ((*pcur_sleep) > CIFS_MAX_SLEEP)
> -                       (*pcur_sleep) =3D CIFS_MAX_SLEEP;
> +               /* Update sleep time for exponential backoff */
> +               if (!(*pcur_sleep))
> +                       (*pcur_sleep) =3D 1;
> +               else {
> +                       (*pcur_sleep) =3D ((*pcur_sleep) << 1);
> +                       if ((*pcur_sleep) > CIFS_MAX_SLEEP)
> +                               (*pcur_sleep) =3D CIFS_MAX_SLEEP;
> +               }
>                 return true;
>         }
>
> @@ -2808,7 +2821,7 @@ smb2_query_info_compound(const unsigned int xid, st=
ruct cifs_tcon *tcon,
>         int rc;
>         __le16 *utf16_path;
>         struct cached_fid *cfid;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -2898,6 +2911,9 @@ smb2_query_info_compound(const unsigned int xid, st=
ruct cifs_tcon *tcon,
>         smb2_set_related(&rqst[2]);
>
>         if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 if (!cfid) {
>                         smb2_set_replay(server, &rqst[0]);
>                         smb2_set_replay(server, &rqst[2]);
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 5d57c895ca37a..7d75ba675f774 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -2904,7 +2904,7 @@ int smb311_posix_mkdir(const unsigned int xid, stru=
ct inode *inode,
>         unsigned int total_len;
>         __le16 *utf16_path =3D NULL;
>         struct TCP_Server_Info *server;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -3016,8 +3016,12 @@ int smb311_posix_mkdir(const unsigned int xid, str=
uct inode *inode,
>         trace_smb3_posix_mkdir_enter(xid, tcon->tid, ses->Suid, full_path=
, CREATE_NOT_FILE,
>                                     FILE_WRITE_ATTRIBUTES);
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         /* resource #4: response buffer */
>         rc =3D cifs_send_recv(xid, ses, server,
> @@ -3265,7 +3269,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_=
parms *oparms, __le16 *path,
>         int resp_buftype =3D CIFS_NO_BUFFER;
>         int rc =3D 0;
>         int flags =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -3293,8 +3297,12 @@ SMB2_open(const unsigned int xid, struct cifs_open=
_parms *oparms, __le16 *path,
>         trace_smb3_open_enter(xid, tcon->tid, tcon->ses->Suid, oparms->pa=
th,
>                 oparms->create_options, oparms->desired_access);
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags,
> @@ -3478,7 +3486,7 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon=
 *tcon, u64 persistent_fid,
>         int resp_buftype =3D CIFS_NO_BUFFER;
>         int rc =3D 0;
>         int flags =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>         if (!tcon)
>                 return smb_EIO(smb_eio_trace_null_pointers);
> @@ -3518,8 +3526,12 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tco=
n *tcon, u64 persistent_fid,
>         if (rc)
>                 goto ioctl_exit;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags,
> @@ -3675,7 +3687,7 @@ __SMB2_close(const unsigned int xid, struct cifs_tc=
on *tcon,
>         int rc =3D 0;
>         int flags =3D 0;
>         bool query_attrs =3D false;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -3707,8 +3719,12 @@ __SMB2_close(const unsigned int xid, struct cifs_t=
con *tcon,
>         if (rc)
>                 goto close_exit;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags, &rsp_iov);
> @@ -3878,7 +3894,7 @@ query_info(const unsigned int xid, struct cifs_tcon=
 *tcon,
>         struct TCP_Server_Info *server;
>         int flags =3D 0;
>         bool allocated =3D false;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>         cifs_dbg(FYI, "Query Info\n");
>
> @@ -3912,8 +3928,12 @@ query_info(const unsigned int xid, struct cifs_tco=
n *tcon,
>         trace_smb3_query_info_enter(xid, persistent_fid, tcon->tid,
>                                     ses->Suid, info_class, (__u32)info_ty=
pe);
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags, &rsp_iov);
> @@ -4069,7 +4089,7 @@ SMB2_change_notify(const unsigned int xid, struct c=
ifs_tcon *tcon,
>         int resp_buftype =3D CIFS_NO_BUFFER;
>         int flags =3D 0;
>         int rc =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -4100,8 +4120,12 @@ SMB2_change_notify(const unsigned int xid, struct =
cifs_tcon *tcon,
>         trace_smb3_notify_enter(xid, persistent_fid, tcon->tid, ses->Suid=
,
>                                 (u8)watch_tree, completion_filter);
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags, &rsp_iov);
> @@ -4405,7 +4429,7 @@ SMB2_flush(const unsigned int xid, struct cifs_tcon=
 *tcon, u64 persistent_fid,
>         int resp_buftype =3D CIFS_NO_BUFFER;
>         int flags =3D 0;
>         int rc =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -4431,8 +4455,12 @@ SMB2_flush(const unsigned int xid, struct cifs_tco=
n *tcon, u64 persistent_fid,
>
>         trace_smb3_flush_enter(xid, persistent_fid, tcon->tid, ses->Suid)=
;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags, &rsp_iov);
> @@ -5190,7 +5218,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_p=
arms *io_parms,
>         int flags =3D 0;
>         unsigned int total_len;
>         struct TCP_Server_Info *server;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -5238,8 +5266,12 @@ SMB2_write(const unsigned int xid, struct cifs_io_=
parms *io_parms,
>         rqst.rq_iov =3D iov;
>         rqst.rq_nvec =3D n_vec + 1;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, io_parms->tcon->ses, server,
>                             &rqst,
> @@ -5590,7 +5622,7 @@ SMB2_query_directory(const unsigned int xid, struct=
 cifs_tcon *tcon,
>         struct cifs_ses *ses =3D tcon->ses;
>         struct TCP_Server_Info *server;
>         int flags =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -5615,8 +5647,12 @@ SMB2_query_directory(const unsigned int xid, struc=
t cifs_tcon *tcon,
>         if (rc)
>                 goto qdir_exit;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags, &rsp_iov);
> @@ -5725,7 +5761,7 @@ send_set_info(const unsigned int xid, struct cifs_t=
con *tcon,
>         struct cifs_ses *ses =3D tcon->ses;
>         struct TCP_Server_Info *server;
>         int flags =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -5758,8 +5794,12 @@ send_set_info(const unsigned int xid, struct cifs_=
tcon *tcon,
>                 return rc;
>         }
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags,
> @@ -5838,7 +5878,7 @@ SMB2_oplock_break(const unsigned int xid, struct ci=
fs_tcon *tcon,
>         struct kvec iov[1];
>         struct kvec rsp_iov;
>         int resp_buf_type;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -5868,8 +5908,12 @@ SMB2_oplock_break(const unsigned int xid, struct c=
ifs_tcon *tcon,
>         rqst.rq_iov =3D iov;
>         rqst.rq_nvec =3D 1;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buf_type, flags, &rsp_iov);
> @@ -5971,7 +6015,7 @@ SMB311_posix_qfs_info(const unsigned int xid, struc=
t cifs_tcon *tcon,
>         struct TCP_Server_Info *server;
>         FILE_SYSTEM_POSIX_INFO *info =3D NULL;
>         int flags =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -5992,8 +6036,12 @@ SMB311_posix_qfs_info(const unsigned int xid, stru=
ct cifs_tcon *tcon,
>         rqst.rq_iov =3D &iov;
>         rqst.rq_nvec =3D 1;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags, &rsp_iov);
> @@ -6036,7 +6084,7 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_t=
con *tcon,
>         struct TCP_Server_Info *server;
>         unsigned int rsp_len, offset;
>         int flags =3D 0;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -6073,8 +6121,12 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_=
tcon *tcon,
>         rqst.rq_iov =3D &iov;
>         rqst.rq_nvec =3D 1;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, ses, server,
>                             &rqst, &resp_buftype, flags, &rsp_iov);
> @@ -6136,7 +6188,7 @@ smb2_lockv(const unsigned int xid, struct cifs_tcon=
 *tcon,
>         int flags =3D CIFS_NO_RSP_BUF;
>         unsigned int total_len;
>         struct TCP_Server_Info *server;
> -       int retries =3D 0, cur_sleep =3D 1;
> +       int retries =3D 0, cur_sleep =3D 0;
>
>  replay_again:
>         /* reinitialize for possible replay */
> @@ -6172,8 +6224,12 @@ smb2_lockv(const unsigned int xid, struct cifs_tco=
n *tcon,
>         rqst.rq_iov =3D iov;
>         rqst.rq_nvec =3D 2;
>
> -       if (retries)
> +       if (retries) {
> +               /* Back-off before retry */
> +               if (cur_sleep)
> +                       msleep(cur_sleep);
>                 smb2_set_replay(server, &rqst);
> +       }
>
>         rc =3D cifs_send_recv(xid, tcon->ses, server,
>                             &rqst, &resp_buf_type, flags,
> --
> 2.43.0
>


--=20
Thanks,

Steve

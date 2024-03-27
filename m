Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27014C599
	for <netfs@lists.linux.dev>; Wed, 27 Mar 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559270; cv=none; b=WusfntQs2H7vHvpzEKzX/8jhvzX9uQYyPRBtqdp5gWzXBegzGTrpBZICL8Qbndh70yGCMOfyohnRXFRgd9UUwus5CvLaxGads2emHXhv+dpAkGvHzMi37DAeTbjtRMZbGYOn0vG0ke4Qe902/7ILbyfXUI/breU6sGqdBnw/smA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559270; c=relaxed/simple;
	bh=U3RtwDtYT0yTxSKO6jZYN50WHbzBfyI8DDoY9EMQLEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFKVWZqt+1Mn9gXvZSoTO2Ew0mf9UJIiRrSzs+qMX9jmb2+vHICsm1dbzU1RioS/keyQ6fTtR9e+0ioijg/Qhnz9gS0iNgOC5qtoe1a4l4QuEgAPL6kn7EZBJRAScrF7ntiAjfYEUXGE2edAw8+RN3NAbFEzhHMWqpX94JERg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1vgew3U; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1vgew3U"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d700beb6beso6456021fa.2
        for <netfs@lists.linux.dev>; Wed, 27 Mar 2024 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711559266; x=1712164066; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3W9HxlOS8+3sB9E9Q/EKAZYL+1+tFa3XLjifQ5VaP8=;
        b=X1vgew3UfUV5NizGav9WsCWsogr2R+KwGaRZZFv7sBsizYHFNHXs14jX9IFhmgcPld
         /h9t1MzyfyHiPEmXtIAcBccw2XmzSA8O8tDNr14tDm3ZABszZ6/+oJwBPBZf2S8DPFfV
         tULohg23WAIa+4w5ZOTPu4PFvgP9H/jqwWBXRDXn6Lojwyu0xTYRnIEIyp3DZKQJlkym
         5Kw33RYvm1PWFvoWdRMnM0w/VwS955FnpKwzFWK8+IM4w4H368qsKqqmDQ6mKwFpLGsa
         C3yjXTSHjsxCjQCrm922wmSkPQWEnXs2FdIGyXqDkPDOkIgwxMPenN5Dp/XaWYgr4a/o
         kXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711559266; x=1712164066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3W9HxlOS8+3sB9E9Q/EKAZYL+1+tFa3XLjifQ5VaP8=;
        b=iP7f7TfwaHCSeuhRGY0uPLPC9vR7idMas1ZgnDOifPs5j7XWMwM9oMFVdiaeWBdIqb
         h25kJOWsEkUzJzJBL0cVO4sPZMOXdZW7//wA6tqtqje5Fp83gbzhjLuFaF063uglFP4F
         049fFpg/DxIV5+ttWVah2gGvf6WeBeJdUaM90mnE3ak0+a5jshuI/IR/PWHVeeAOcokl
         PA9zObqD53u7suSB1cvGbdzMRRgjZaZE+UKS3Jsje9fhOllPs/V3SulMbnWc4HsRjBZg
         rRF7xaJbSRP07OlFYIYaawh5FClrqdDnGDty6GoAIRFkWfmOrMAq5trWp+fZUgPph5fZ
         hjsw==
X-Forwarded-Encrypted: i=1; AJvYcCVtZKLc3f85cH2N5BQlYApJkuOCb1K068hSZbQDI0+GMOod7l4nm9xTPwvJ0rt3HmBYqtdpCtFrNKtw3zV2fL0ExKKsvEs=
X-Gm-Message-State: AOJu0YzI8YSgHQ+gyAqO7dyjwk1AslaoMOb6bO+hZWsjJsBjjhYDfFAa
	CU20TQRn3BAo1xW9StIOB1jB2qGY5UXGX5FAkAXWwahwl57t+iIlPqgOK/Eg7J4Rhk64c1qNgzC
	CZP36k3Ngjm5JB92Q4dnl3AQWHks=
X-Google-Smtp-Source: AGHT+IGTg5b59WH8c8XtI5m2cG3wee2fpMVNEMOz66Fi2woYZqA5DNodHPMRUJZFSv5qC/pxlAFtlSdBLcT69HeFDbE=
X-Received: by 2002:a2e:a721:0:b0:2d6:e7b6:f5da with SMTP id
 s33-20020a2ea721000000b002d6e7b6f5damr428989lje.29.1711559265398; Wed, 27 Mar
 2024 10:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2305515.1711548804@warthog.procyon.org.uk>
In-Reply-To: <2305515.1711548804@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Wed, 27 Mar 2024 12:07:34 -0500
Message-ID: <CAH2r5mujc2dPCTN15DqoDJXkg8wOUaZbpDZ562CHsStZmuAOUQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix duplicate fscache cookie warnings
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git (also added Fixes tag) pending testing

On Wed, Mar 27, 2024 at 10:00=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> fscache emits a lot of duplicate cookie warnings with cifs because the
> index key for the fscache cookies does not include everything that the
> cifs_find_inode() function does.  The latter is used with iget5_locked() =
to
> distinguish between inodes in the local inode cache.
>
> Fix this by adding the creation time and file type to the fscache cookie
> key.
>
> Additionally, add a couple of comments to note that if one is changed the
> other must be also.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/fscache.c |   16 +++++++++++++++-
>  fs/smb/client/inode.c   |    2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
> index c4a3cb736881..340efce8f052 100644
> --- a/fs/smb/client/fscache.c
> +++ b/fs/smb/client/fscache.c
> @@ -12,6 +12,16 @@
>  #include "cifs_fs_sb.h"
>  #include "cifsproto.h"
>
> +/*
> + * Key for fscache inode.  [!] Contents must match comparisons in cifs_f=
ind_inode().
> + */
> +struct cifs_fscache_inode_key {
> +
> +       __le64  uniqueid;       /* server inode number */
> +       __le64  createtime;     /* creation time on server */
> +       u8      type;           /* S_IFMT file type */
> +} __packed;
> +
>  static void cifs_fscache_fill_volume_coherency(
>         struct cifs_tcon *tcon,
>         struct cifs_fscache_volume_coherency_data *cd)
> @@ -97,15 +107,19 @@ void cifs_fscache_release_super_cookie(struct cifs_t=
con *tcon)
>  void cifs_fscache_get_inode_cookie(struct inode *inode)
>  {
>         struct cifs_fscache_inode_coherency_data cd;
> +       struct cifs_fscache_inode_key key;
>         struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
>         struct cifs_sb_info *cifs_sb =3D CIFS_SB(inode->i_sb);
>         struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
>
> +       key.uniqueid    =3D cpu_to_le64(cifsi->uniqueid);
> +       key.createtime  =3D cpu_to_le64(cifsi->createtime);
> +       key.type        =3D (inode->i_mode & S_IFMT) >> 12;
>         cifs_fscache_fill_coherency(&cifsi->netfs.inode, &cd);
>
>         cifsi->netfs.cache =3D
>                 fscache_acquire_cookie(tcon->fscache, 0,
> -                                      &cifsi->uniqueid, sizeof(cifsi->un=
iqueid),
> +                                      &key, sizeof(key),
>                                        &cd, sizeof(cd),
>                                        i_size_read(&cifsi->netfs.inode));
>         if (cifsi->netfs.cache)
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index d28ab0af6049..91b07ef9e25c 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -1351,6 +1351,8 @@ cifs_find_inode(struct inode *inode, void *opaque)
>  {
>         struct cifs_fattr *fattr =3D opaque;
>
> +       /* [!] The compared values must be the same in struct cifs_fscach=
e_inode_key. */
> +
>         /* don't match inode with different uniqueid */
>         if (CIFS_I(inode)->uniqueid !=3D fattr->cf_uniqueid)
>                 return 0;
>
>


--=20
Thanks,

Steve

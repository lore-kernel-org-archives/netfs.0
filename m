Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398D12CD9D
	for <netfs@lists.linux.dev>; Fri, 24 May 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563176; cv=none; b=OOhjkXmz0uV0RhMIiChrXByJc0nmKxPuh1MH8FI3FHK4d+RKFrXCuWr/wLTEnoclv9rKqC4Y1qNJFFlutEpodPmlJnlt7zMeuaTndd1Hd6kUrLGY7QIsi2wu16RpZXbsibdcXZKVZjE5QCyq5T/eWaIcM/tKhx3wEnU1V/BNzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563176; c=relaxed/simple;
	bh=lIuWIA15huY8TAHntCCfuKfwZ1Cq3grNeyLCV2/vITg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+HY9b9VrSCc3aO8LDx+LmlcDOnvKqFhE+0NWZg1FJQbObcbSrnIezXjiM0hUWFFZ1eOrXjJRE/buzDHAeSBEPGrDmFZm58Nryo2KbUIsCJZcZFByDmTho2N6kTQb5jPKp9fhNXfCy6up+Ua9rLI9b+mZZYOIbhEzh6wQnsfi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHBz4vQS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHBz4vQS"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52389c1308dso9075354e87.3
        for <netfs@lists.linux.dev>; Fri, 24 May 2024 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716563173; x=1717167973; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZveuMPC94oN0TWG124HXbRG9mvaQF2WN0uV/JKNFFc=;
        b=mHBz4vQS6v3eUmLnYd8Ku3jTRjX6i+i9BsLOBDF5ZHxwU9wlLKD6/HvB0A9HJxwKp8
         6R4jP889bS8T5HelWJKIjDf1Q3xJt9tnLCESKWv+f8ssl+/XPVqE7/WjRCvHjZZD/Efl
         rVL3pt2X2Tc2PGlXuyXAbTjrTrDlnDcqwL9U4gbidrcXZ2NKFQvtDXnAfAtzrRasuzo5
         xZKm5sz0v9VaN+nWXajSVfCF5piyrre4Hp6ym+6RLj3l3AgpEdSSInWH9E73nI28VpL2
         RUCmNXFeXnrNataKZ4I+G010KMpkxyWUjrb1Jj7tGuhtIVgdjC/zVy/3Ro6Z0i0fIb8U
         n4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563173; x=1717167973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZveuMPC94oN0TWG124HXbRG9mvaQF2WN0uV/JKNFFc=;
        b=wjpSUwdqUCnAFJ3K3E6icXynx+kZEH7ahrBSDFIyEqi2mB4gGgSadOkogtgr29M91X
         0USWiOnlpxCIhS9hnzEelM2jZzzTN8ctkDdqmjXNDWrV9MJQ3gQ7Iycvb/fWzPHOnarY
         ma85P0ZSLHe+rTiCPBO6K2j/qUT3bSOZ1VnNVUdYaTqNnjtGKFkAGv4WH4wrG5yIP991
         NsclTDyTONEtiQp0fQTusJlYuKvbyy0Q7x6SLfe8I8apcPIpGGdn8mfGloU33+hgBewO
         P7aCXozSrzG5hWUDMcg22H/Uv9jqJnxmVQBneob6/XYy0xbosFrxwKi1PL99MPO4nWP6
         hFzA==
X-Forwarded-Encrypted: i=1; AJvYcCWYoZB/oqmNYg2JKBlGP4Y599wFuu07zdddTtS+J1s1kUP6Kiou0dD8UZswpzGtk0W6IAth9xUhSWnXkxvUAbIIC314OA8=
X-Gm-Message-State: AOJu0YyNdFBz3CTjmXl080ZApZ+bpVyvlYTBkKn/HHwEpKsVdHFCiQrn
	ZUu4MV0fu7175Zn4qDEnMOPDXK3jhJf3N9n9fh+6oazcChvhl8w1TYOzF7egl95HEdnGu+izCN8
	dnIvDIAvTojCMY1YDazH1z8G6dic=
X-Google-Smtp-Source: AGHT+IHAryC6tWwme7krp2S20myXjYUIvB3GCJY7zNqDK2W+J0MOUmNo79QTfHF53HpbDT6v67nt8K8/EjZXM/789hw=
X-Received: by 2002:a05:6512:2087:b0:523:c515:ecd9 with SMTP id
 2adb3069b0e04-529644ec1bemr1333141e87.14.1716563172769; Fri, 24 May 2024
 08:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <755787.1716560616@warthog.procyon.org.uk>
In-Reply-To: <755787.1716560616@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Fri, 24 May 2024 10:06:00 -0500
Message-ID: <CAH2r5mu6Va=ZVEMozr04iOaq66W6Svt6oOdxtsEeaf-6CkkqcA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix missing set of remote_i_size
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next pending testing

On Fri, May 24, 2024 at 9:23=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Occasionally, the generic/001 xfstest will fail indicating corruption in
> one of the copy chains when run on cifs against a server that supports
> FSCTL_DUPLICATE_EXTENTS_TO_FILE (eg. Samba with a share on btrfs).  The
> problem is that the remote_i_size value isn't updated by cifs_setsize()
> when called by smb2_duplicate_extents(), but i_size *is*.
>
> This may cause cifs_remap_file_range() to then skip the bit after calling
> ->duplicate_extents() that sets sizes.
>
> Fix this by calling netfs_resize_file() in smb2_duplicate_extents() befor=
e
> calling cifs_setsize() to set i_size.
>
> This means we don't then need to call netfs_resize_file() upon return fro=
m
> ->duplicate_extents(), but we also fix the test to compare against the pr=
e-dup
> inode size.
>
> [Note that this goes back before the addition of remote_i_size with the
> netfs_inode struct.  It should probably have been setting cifsi->server_e=
of
> previously.]
>
> Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate ex=
tents (reflink)")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> ---
>  fs/smb/client/cifsfs.c  |    6 +++---
>  fs/smb/client/smb2ops.c |    1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 14810ffd15c8..bb86fc0641d8 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1227,7 +1227,7 @@ static loff_t cifs_remap_file_range(struct file *sr=
c_file, loff_t off,
>         struct cifsFileInfo *smb_file_src =3D src_file->private_data;
>         struct cifsFileInfo *smb_file_target =3D dst_file->private_data;
>         struct cifs_tcon *target_tcon, *src_tcon;
> -       unsigned long long destend, fstart, fend, new_size;
> +       unsigned long long destend, fstart, fend, old_size, new_size;
>         unsigned int xid;
>         int rc;
>
> @@ -1294,6 +1294,7 @@ static loff_t cifs_remap_file_range(struct file *sr=
c_file, loff_t off,
>                 goto unlock;
>         if (fend > target_cifsi->netfs.zero_point)
>                 target_cifsi->netfs.zero_point =3D fend + 1;
> +       old_size =3D target_cifsi->netfs.remote_i_size;
>
>         /* Discard all the folios that overlap the destination region. */
>         cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend)=
;
> @@ -1306,9 +1307,8 @@ static loff_t cifs_remap_file_range(struct file *sr=
c_file, loff_t off,
>         if (target_tcon->ses->server->ops->duplicate_extents) {
>                 rc =3D target_tcon->ses->server->ops->duplicate_extents(x=
id,
>                         smb_file_src, smb_file_target, off, len, destoff)=
;
> -               if (rc =3D=3D 0 && new_size > i_size_read(target_inode)) =
{
> +               if (rc =3D=3D 0 && new_size > old_size) {
>                         truncate_setsize(target_inode, new_size);
> -                       netfs_resize_file(&target_cifsi->netfs, new_size,=
 true);
>                         fscache_resize_cookie(cifs_inode_cookie(target_in=
ode),
>                                               new_size);
>                 }
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index b87b70edd0be..4ce6c3121a7e 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -2028,6 +2028,7 @@ smb2_duplicate_extents(const unsigned int xid,
>                  * size will be queried on next revalidate, but it is imp=
ortant
>                  * to make sure that file's cached size is updated immedi=
ately
>                  */
> +               netfs_resize_file(netfs_inode(inode), dest_off + len, tru=
e);
>                 cifs_setsize(inode, dest_off + len);
>         }
>         rc =3D SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
>
>


--=20
Thanks,

Steve

Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD747534D
	for <netfs@lists.linux.dev>; Thu, 24 Sep 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248382; cv=pass; b=MJtFe6asCJDQLjMXzWKscUEH9qFQqkigQ4c2peeiisca3elXmp6qMQM2SKcYl/VlY1tt2Wp+g4HBPYc6pWxhfnS7Iosym82G1hkAQQ6Xgem0zW9OrxvhxZAz6B+h1qHkQoLr6SqVcJg4AoTxkHUmvQGdQBMcAQ2oZ/avyKi4WR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248382; c=relaxed/simple;
	bh=eJYqN4wEoL/OX9Q03eUTbGvGTyg+Jo8gjHizQ3XF3AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4w8hcI79BWnTCccHabEY5juHReOJRs6p3CCwVV8RcmxAVgR3tJ/0oT9mUcvSoGKT1Rv6k8J1ln87MImJkkDM1yvzrL5buVI+32Uay+GHV2DkKlZgaGpgZSUWlJzsk/zxps48XKwUMApQw3/hEjbXT9jxuPd8wJ1fWtKzZ+ZuPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdxQkSKs; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdxQkSKs"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso3342485a12.0
        for <netfs@lists.linux.dev>; Thu, 24 Sep 2026 04:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790248376; cv=none;
        d=google.com; s=arc-20260327;
        b=Bb7g8uJrrcGT3JLxrX9AWIzj45PLgZh8eWS21vXrrUOwqsloqKfXdUSNedQwlFTGDN
         0leQBJ2r3YOmrPt6PQuE6Lg7NbiCom4SzJk2qdIVzJS/h1BR0ylnDQ+AlYqypWkbhlGO
         QwPEBtIETCfXsUTVuRxH/qBXZszXw05P/JpDRxl4WJKtlieSzahY+hbFvgEmHx7le4MK
         c1jcAYpfwO8LNsioHvkBtD5/nRt/1TgX7oPnWJJXD206Vbd9ou1Mv8Dfl36qYxG8Zw/A
         xPOuWLpVSteB9NjCTBD1Ll0FjLE3s+2YXH+ilM+bhwpJOQyBqj/iNwCLyiIou9FVHnMb
         daqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIF+DNqqKyKNEhEgpncpLAUjcdtzT9Ko8rcMz3NbVVk=;
        fh=r6SGCMvW8YMOLUBF47za+UzUKuiH5dVljzu6iVIrs/o=;
        b=ie1l7TtqGHv6CKQNidbOWl0sGS59udPM+s9gs/ULfs5WUEI4ivKeJae/aoGYqtvcHi
         DlxOH6RYIVeVLuRDpnv/hpVkGdqP3iwGfqWtjr3gTbJblbgQYclc9KJ8GVCBHXfLe8Ib
         seaEjJZXiLVClaGsn2HRdtTSBW4MWNDc7PjKZMszZ9r4EQk0WjAOrEzlJuYf+HIEMzM1
         s6ro8WaW8ITDIf/ehBOalz/U18/Hx8P3iVgRF22aIfvLXHNsJ83bGtDeZsrut+8RKJuu
         j247BGvfRiYLzRXkQ4a2IkQbPy0Ch8NI7LBiVcWYtbekd082QOraaHRcFaHGAR2HSoPC
         rbHA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790248376; x=1790853176; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIF+DNqqKyKNEhEgpncpLAUjcdtzT9Ko8rcMz3NbVVk=;
        b=GdxQkSKsbRyD3t77pQH/aa3uO6gsBorJlmjdzNd2SafvjanXcMXrYjEMB1eYkKdiCG
         CIj5RfWX2WRdqqxzLD40ZVqZdsAM9rDnYlSLOq6aXiqHctd9r2Zk5DNvfDvsN1q5/eD+
         knXBXbcBJw1T0rcrUZSepRa30gZP1oZhnUOaCHVNuiD4LP86z36qouj7KsV2/HzaX3dv
         Eiodi9R8O5oRFz0YSwz7bUE3Ny/+Ti308/m1YQb6chxTTtHRO17MzONP/HX8RGQ5q8WB
         EyyJUM7Edqo4ud9oy34iLJTG9Xee9ft80IBD5Htxf/CVZAUW1mfkfgeRf/E7jhFelqTf
         PJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790248376; x=1790853176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIF+DNqqKyKNEhEgpncpLAUjcdtzT9Ko8rcMz3NbVVk=;
        b=E79kjfW/FSPcKWjrlj04ob/8lMzWkeJCsWfTV7wlhmlTswbn0XD+f1yD3zSgShkL0F
         SZw0gYc8v3yycQZf16RB+rzDwQMLD0hzKzvqkQJiqIxdl3ct15ViCsMbfiFFG2DQpc9B
         4Qm/rAw+yDhyCEZi7UPGIRM0YzhFoI1JEncxiCU2ptthF/TwH4Uh2LY6rn6qffVI3+Vr
         9rbTPUvWf8Kpvj+QVHmpT8imqXZ8LNVm9SZUNF21W64YYhHyTwxd7mjjQba9Bw5FhaLt
         gwudjmT8fh1Ix/aelQTXIzmhbB4Yz5GQfD4Z5iRxVTtD/m70pA9SzqMWTxA+s/4rNofG
         JRJg==
X-Forwarded-Encrypted: i=1; AKwUvBzi+eigvVVSlfqBdgSWMEfeIV3krpuh8pTX3HLTx3znkOWK6uWqPqF650iXdBYfTwzX4ssCXg==@lists.linux.dev
X-Gm-Message-State: AFuF++luW2rtOSVkQ5NhdqJu97N1W5xQKyHOT643HtbFuSQcZ3AA+k4e
	C99emeHYE0UDJ5XfAqI+FRwaA1wrh5YDMlquyKr9yqYjVT4pBD2I+ArTGe0ab+Whhk4Cn9LLFzM
	vZzhCt1NrYv9+rvHlBP5oXkarX0E+D2M=
X-Gm-Gg: AYBFou0xTO09O+z/2ykgVvkPFQRGjS4omfsJJo1wnVv4hJtRHNhg0H01i+JXwWQbkKO
	+4L1yKVTDtge9UbnmzgcbOfrq5/5Q5xZuu0RddAZIjSuTgpQ2V/7b5R+vyY+8Ax0xQ4WeS+nLT9
	bSr0h+DMgW58MxdCFtIAJbpURd8dlwW+NmnURyITrl6ulxJDvw+6Ml7EegO6+nIGpCWGWe/vHX/
	txmjNaccIbHcIAoNLG8Z86ICxdrlb7RkU6YFR18ercOILTsk67gXtyEA2ULSPaKlchtERLFdZja
	uh3JI127UARNjdn/Fv0mCQB5kdlhk367r+tm/cuSaaYxupd3zQP3PJYf
X-Received: by 2002:a05:6402:278f:b0:6aa:665:830 with SMTP id
 4fb4d7f45d1cf-6aac8f4be3bmr1951363a12.15.1790248376170; Thu, 24 Sep 2026
 04:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260924104831.1081137-4-caixinchen1@huawei.com>
In-Reply-To: <20260924104831.1081137-4-caixinchen1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Sep 2026 13:12:44 +0200
X-Gm-Features: AclHuK814JZB8XXMibt7ISdY9GmULY6F59LGn_JEl7Ybs7QawxIOFdTv7Ii5ZE4
Message-ID: <CAOQ4uxhMhcxq5+crz84f8xj+Wi1bHhNqa_TecP-RvipheBR+ug@mail.gmail.com>
Subject: Re: [PATCH RFC -next 03/12] fs: pass struct path to xattr helpers
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: mic@digikod.net, gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dhowells@redhat.com, code@tyhicks.com, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, hirofumi@mail.parknet.co.jp, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, miklos@szeredi.hu, 
	senozhatsky@chromium.org, chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:22=E2=80=AFPM Cai Xinchen <caixinchen1@huawei.co=
m> wrote:
>
> vfs_setxattr(), vfs_getxattr(), vfs_listxattr() and vfs_removexattr()
> along with their __vfs_setxattr_locked()/__vfs_removexattr_locked()
> counterparts and the do_setxattr()/do_getxattr()/listxattr()/
> removexattr() syscall helpers take a struct mnt_idmap and a struct
> dentry even though callers either already hold a struct path (or a
> struct file) or have to pass &nop_mnt_idmap because no idmapped
> mount is involved.  Switch them all to take a struct path instead
> and derive the idmap and dentry from it where needed.
>
> __vfs_setxattr_noperm(), __vfs_getxattr(), __vfs_setxattr(),
> __vfs_removexattr() and vfs_getxattr_alloc() keep taking the idmap
> and dentry as they are only called from contexts that operate on
> bare dentries such as LSM internals.  The SELinux and Smack
> inode_setsecctx implementations now pass the path they got from the
> previous patch straight through.
>
> The security_inode_*xattr() hooks invoked from fs/xattr.c keep
> taking the idmap and dentry for now; they will be converted together
> with the LSM hooks themselves in separate patches.
>
> evm_calc_hmac_or_hash() contains a redundant xattr size sanity check
> which calls vfs_getxattr() only to emit a debug message when the
> kernel-side and user-space-side xattr sizes differ, without ever
> influencing the result.  Because that function only has a dentry, the
> call cannot be migrated to the new path-based signature; drop the
> check and the now unused user_space_size variable instead.
>
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  drivers/block/zloop.c               |   4 +-
>  fs/cachefiles/xattr.c               |  32 ++++----
>  fs/ecryptfs/inode.c                 |   8 +-
>  fs/nfsd/nfs4ctl.h                   |   4 +-
>  fs/nfsd/vfs.c                       |  57 +++++++-------
>  fs/overlayfs/copy_up.c              |   4 +-
>  fs/overlayfs/overlayfs.h            |  18 +++--
>  fs/overlayfs/xattrs.c               |  13 +++-
>  fs/smb/server/smb2pdu.c             |  75 +++++++------------
>  fs/smb/server/smb_common.c          |   2 -
>  fs/smb/server/smbacl.c              |  19 +++--
>  fs/smb/server/tests/smbacl_kunit.c  |   6 +-
>  fs/smb/server/vfs.c                 | 112 ++++++++++++----------------
>  fs/smb/server/vfs.h                 |  39 ++++------
>  fs/smb/server/vfs_cache.c           |   3 +-
>  fs/xattr.c                          |  92 ++++++++++++-----------
>  include/linux/xattr.h               |  22 +++---
>  security/integrity/evm/evm_crypto.c |   8 +-
>  security/selinux/hooks.c            |   4 +-
>  security/smack/smack_lsm.c          |   4 +-
>  20 files changed, 243 insertions(+), 283 deletions(-)
>

[...]

> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index e963701b4c87..6dc241f195a6 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -83,7 +83,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct=
 path *oldpath, struct de
>         if (!old->d_inode->i_op->listxattr || !new->d_inode->i_op->listxa=
ttr)
>                 return 0;
>
> -       list_size =3D vfs_listxattr(old, NULL, 0);
> +       list_size =3D vfs_listxattr(oldpath, NULL, 0);
>         if (list_size <=3D 0) {
>                 if (list_size =3D=3D -EOPNOTSUPP)
>                         return 0;
> @@ -94,7 +94,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct=
 path *oldpath, struct de
>         if (!buf)
>                 return -ENOMEM;
>
> -       list_size =3D vfs_listxattr(old, buf, list_size);
> +       list_size =3D vfs_listxattr(oldpath, buf, list_size);
>         if (list_size <=3D 0) {
>                 error =3D list_size;
>                 goto out;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index d915b87c0b06..c13f6b2c915c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -291,8 +291,7 @@ static inline ssize_t ovl_do_getxattr(const struct pa=
th *path, const char *name,
>
>         WARN_ON(path->dentry->d_sb !=3D path->mnt->mnt_sb);
>
> -       err =3D vfs_getxattr(mnt_idmap(path->mnt), path->dentry,
> -                              name, value, size);
> +       err =3D vfs_getxattr(path, name, value, size);
>         len =3D (value && err > 0) ? err : 0;
>
>         pr_debug("getxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) =3D %i\n",
> @@ -325,9 +324,13 @@ static inline int ovl_do_setxattr(struct ovl_fs *ofs=
, struct dentry *dentry,
>                                   const char *name, const void *value,
>                                   size_t size, int flags)
>  {
> +       struct path path =3D {
> +               .mnt =3D ovl_upper_mnt(ofs),
> +               .dentry =3D dentry,
> +       };
> +
>         /* Use vfs_setxattr(), not __vfs_setxattr(): it idmaps the securi=
ty.capability rootid. */
> -       int err =3D vfs_setxattr(ovl_upper_mnt_idmap(ofs), dentry, name,
> -                              value, size, flags);
> +       int err =3D vfs_setxattr(&path, name, value, size, flags);
>
>         pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, %d) =3D %i\n",
>                  dentry, name, min((int)size, 48), value, size, flags, er=
r);
> @@ -344,7 +347,12 @@ static inline int ovl_setxattr(struct ovl_fs *ofs, s=
truct dentry *dentry,
>  static inline int ovl_do_removexattr(struct ovl_fs *ofs, struct dentry *=
dentry,
>                                      const char *name)
>  {
> -       int err =3D vfs_removexattr(ovl_upper_mnt_idmap(ofs), dentry, nam=
e);
> +       struct path path =3D {
> +               .mnt =3D ovl_upper_mnt(ofs),
> +               .dentry =3D dentry,
> +       };
> +
> +       int err =3D vfs_removexattr(&path, name);
>         pr_debug("removexattr(%pd2, \"%s\") =3D %i\n", dentry, name, err)=
;
>         return err;
>  }
> diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
> index 5ae44b9c8790..b4658324b9f3 100644
> --- a/fs/overlayfs/xattrs.c
> +++ b/fs/overlayfs/xattrs.c
> @@ -45,7 +45,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct =
inode *inode, const char
>         if (!value && !upperdentry) {
>                 ovl_path_lower(dentry, &realpath);
>                 with_ovl_creds(dentry->d_sb)
> -                       err =3D vfs_getxattr(mnt_idmap(realpath.mnt), rea=
ldentry, name, NULL, 0);
> +                       err =3D vfs_getxattr(&realpath, name, NULL, 0);
>                 if (err < 0)
>                         goto out;
>         }
> @@ -86,7 +86,7 @@ static int ovl_xattr_get(struct dentry *dentry, struct =
inode *inode, const char
>         ovl_i_path_real(inode, &realpath);
>         /* Use vfs_getxattr(), not __vfs_getxattr(): it idmaps the securi=
ty.capability rootid. */
>         with_ovl_creds(dentry->d_sb)
> -               return vfs_getxattr(mnt_idmap(realpath.mnt), realpath.den=
try, name, value, size);
> +               return vfs_getxattr(&realpath, name, value, size);
>  }
>
>  static bool ovl_can_list(struct super_block *sb, const char *s)
> @@ -105,15 +105,20 @@ static bool ovl_can_list(struct super_block *sb, co=
nst char *s)
>
>  ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
>  {
> -       struct dentry *realdentry =3D ovl_dentry_real(dentry);
> +       struct path realpath;
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         ssize_t res;
>         size_t len;
>         char *s;
>         size_t prefix_len, name_len;
>
> +       if (ovl_dentry_upper(dentry))
> +               ovl_path_upper(dentry, &realpath);
> +       else
> +               ovl_path_lower(dentry, &realpath);
> +

that's ovl_path_real()

I have no technical issue with the ovl patch bits in this series.
Anyway, I guess landlock is not going to enforce anything on the
private mnt with ovl_creds anyway?

Thanks,
Amir.

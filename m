Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626038A72B
	for <netfs@lists.linux.dev>; Sat, 26 Sep 2026 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790411911; cv=none; b=pWGrrLk5B3tPI1lm8nP1TCalAixMMIPqeoenVJopTSVkE6acJYJiwAJ2kIdntsmQweL3sbzXiYvLd1JD5M2HNUAx/jGE6E+3rLSPwkO3XpaahVZlLmlKQLn2aQVonHsL/IMYBqZN6LzQ6FjzWZjJc8/hH2SYJNKTeVvfOj9RIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790411911; c=relaxed/simple;
	bh=dg1L5YWtdAyboMbKumSCH8z23MTRvvFyqARphfS6bXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCtBMOFOa0/HPfhDMsPs1L7iUtMfxSOT97lLfYWPL5UC8t1KUUyNHgosaDX9rtT17Qr/IXmnaWpGDW75HOz2Goj4qFvmrv5LJRfjkgHp/1ObWfzAzVkcMgf/VnvX10jdQnDf+axSdfc540fu6ESN+OqGW8Y1Gp3aclk+5GAYsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aszNx6Ui; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aszNx6Ui"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso2769925e9.0
        for <netfs@lists.linux.dev>; Sat, 26 Sep 2026 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790411906; x=1791016706; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9e9Ohjh62jjpKVoXb3eLlcbg9rHFeTPk+yn3uYWypA=;
        b=aszNx6UiflGIgBTS2f1z2zZ3uU/lX5c/WgvL3DgAohqdVICLJfVb3Dtnh+cykkPTSX
         oCcJWP7+JywOXeUVKLeXG48oWXOgvKzzy3gqhIQM9z7HEqiQdV0jRvxg2hBy0IuTrJQ2
         vMRTYx2qndqYZL96sU6o55BkSUbW4noUlR+BQmqjVCPSeYJVoiWwRXfMGqy2aBwgSGWL
         RWJlVdnt8ii/iWKB22ap3T5yoXLZEF1XvpvwTvjso2AFnIE9baaaOpRphT0uRZJnvwUy
         TaghvrCmldoYYJqaJpUdVeC4Uf7WfOKzYoVBiiReOAUMqTQd2Qny6X2uhBbHiFPgwss5
         FkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790411906; x=1791016706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c9e9Ohjh62jjpKVoXb3eLlcbg9rHFeTPk+yn3uYWypA=;
        b=hf/cm7FY2utP0pDxBQadoKyImeqrN9JB327zLPTY2yKnQUQTaXxlTNE8H+2/QYzgF3
         ke5JKCPUb3RTR5Lp9KKUBpG1PERpcQ9UAxXRIYNFEG9Zp9AK5xGg1AjWuRTk8hO+BEnK
         ktovnsLwo5SfFSjwdx7ZUsn3YLQarkbbU08O7XCXunCt93anbsr1qJ5b5hF35VGr7B0a
         Zg6APYWtAT+kEYY1MC1z1/5N6ehCw8RGPq6BShixUkUcchXHJ5W1yEocTVmlKSyE5/Ho
         gZtbMqBX+TXApyyry1fDD9q0hw9ptKRPEl37QOf7TPNCIFYCDs9fZaDaCBheeBf2NubU
         1BiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDaVt/oYuhL7Ime93AIlj+Ui4yTQNm5LFrEHjDinNxJ2uWTbsyLb73nwpZrEpnGwf2DAxHlw==@lists.linux.dev
X-Gm-Message-State: AFuF++k4kSbwfA+9W6q0WZm06j/yR6paHtzvptv68WKB38z9QRtTs+Wr
	h76sizuYx8LNeOicF7fUOh5MnpZfTuEiAgXVW2u9yala6PkH7Fjog4qs
X-Gm-Gg: AYBFou1ryS44yyqlZMzs6oXqU2m02A0thJgnnSbc9Cz4LDgS2Ydud5AnAF37VWydy8W
	10RxGsU7ztS/mDB37YFT0w84Fn16hJkOX+ZLqEkNkojmDJ79Nzq4oHovvKb74JrlrrWU3Xx+DOC
	NbspigTs5vu0jh0fYVa63NT1sdDG9tUfZDnsRvGksZmVaFtCzIYjVoZ0BSZzqJcyQhWH3wZ6eka
	R8Pi9JFNOjYSu9JBzE2yssDs8PtG1Xo7XKr6ERLxevuxGT3VXHB4V6BG8EpXmgQH/uhiSKZG52a
	QijxbQ9/YIPtFeOcWYVBzHwEyFH/j0AhbLJ9sFmWT35gLrBp38+NCjH4+oVdUMiBiV98iQAvJxZ
	tTcmwU6LGk1aSkDDUhy+Fm8Nqk+RWcTFgyC7r2o5zWGaon3KB/AOxwhNFuQPSGd1gkVOitkMc6i
	AcTppyFx1ZgmC6y81FCIrLoE8Q2AVEjp0oAsdPPxN9lOxbQr1EcwAlmewyoxWx9ARVjodfgf1Ud
	YpAKVsj0XtUsWm00uHCYDk=
X-Received: by 2002:a05:600c:1d02:b0:49f:fd66:5fe0 with SMTP id 5b1f17b1804b1-49ffd6661a7mr12811255e9.9.1790411906263;
        Sat, 26 Sep 2026 01:38:26 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm215396785e9.8.2026.09.26.01.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:38:25 -0700 (PDT)
Date: Sat, 26 Sep 2026 10:38:24 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: mic@digikod.net, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, corbet@lwn.net,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	dhowells@redhat.com, code@tyhicks.com, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, miklos@szeredi.hu, amir73il@gmail.com,
	senozhatsky@chromium.org, chenxiaosong@chenxiaosong.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com, omosnacek@gmail.com,
	casey@schaufler-ca.com, nanx95726@gmail.com, djwong@kernel.org,
	daniel@iogearbox.net, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	xiujianfeng@huawei.com, lujialin4@huawei.com
Subject: Re: [PATCH RFC -next 09/12] landlock: Implement metadata access hooks
Message-ID: <20260926.a96402fcbd4b@gnoack.org>
References: <20260924104831.1081137-1-caixinchen1@huawei.com>
 <20260924104831.1081137-10-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924104831.1081137-10-caixinchen1@huawei.com>

On Thu, Sep 24, 2026 at 06:48:28PM +0800, Cai Xinchen wrote:
> Implement the LANDLOCK_ACCESS_FS_READ_METADATA and
> LANDLOCK_ACCESS_FS_WRITE_METADATA access rights by hooking the
> inode_getattr, inode_setattr, inode_setxattr, inode_getxattr,
> inode_listxattr, inode_removexattr, inode_set_acl, inode_get_acl and
> inode_remove_acl LSM hooks, which now receive a struct path thanks to
> the preceding VFS and LSM refactoring.
> 
> The following system calls are now controlled:
> 
> - stat(2), fstat(2), lstat(2), newfstatat(2), getxattr(2) and
>   friends, listxattr(2) and friends, and POSIX ACL reads via
>   inode_getattr, inode_getxattr, inode_listxattr and inode_get_acl
>   (READ_METADATA)
> - chmod(2), fchmod(2), fchmodat(2), fchmodat2(2), chown(2), fchown(2),
>   lchown(2), fchownat(2), chgrp(2), utimensat(2), futimens(2),
>   utime(2), setxattr(2) and friends, removexattr(2) and friends, and
>   POSIX ACL set and remove via inode_setattr, inode_setxattr,
>   inode_removexattr, inode_set_acl and inode_remove_acl
>   (WRITE_METADATA)
> 
> Both new rights are added to ACCESS_FILE as they apply to both files
> and directories.
> 
> hook_inode_setattr only restricts explicit metadata changes, i.e. it
> checks WRITE_METADATA only when the ia_valid mask contains
> ATTR_MODE, ATTR_UID, ATTR_GID, ATTR_TIMES_SET or ATTR_TOUCH.
> Metadata changes that the kernel performs implicitly, such as
> timestamp updates on write(2) or size changes on truncate(2), are
> therefore not restricted, and neither are chmod(2)/chown(2) calls
> that do not change any attribute (e.g. chown(2) with -1/-1, which is
> a no-op that never reaches the hook), matching the behavior of the
> SELinux inode_setattr hook.
> 
> Kernel-internal accesses performed with override_creds() (e.g.
> overlayfs and cachefiles) are not affected because Landlock domains
> are attached to credentials, and kernel threads without a Landlock
> domain (e.g. nfsd and ksmbd) are not restricted either.
> 
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  security/landlock/fs.c | 86 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index cab43892ec2f..e58b2aa0da65 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -318,6 +318,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_READ_METADATA | \
> +	LANDLOCK_ACCESS_FS_WRITE_METADATA | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
>  	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
>  	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
> @@ -1676,6 +1678,81 @@ static int hook_path_truncate(const struct path *const path)
>  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>  }
>  
> +static int hook_inode_getattr(const struct path *const path)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_READ_METADATA);
> +}
> +
> +static int hook_inode_setattr(const struct path *const path,
> +			      struct iattr *const attr)
> +{
> +	/*
> +	 * Explicit metadata changes (i.e. mode, ownership, and timestamps
> +	 * set with utimes() and friends) require
> +	 * LANDLOCK_ACCESS_FS_WRITE_METADATA.  Implicit timestamp updates
> +	 * (e.g. ATTR_CTIME set for a write) and size changes (handled by
> +	 * the truncate hooks) are not restricted.

Nit: It feels like this comment about implicit timestamp updates
(especially the size change) should go in the top-level documentation
for the WRITE_METADATA right?  setattr() can not result in a size
change, after all, AFAIK?

Remark on the side, apart from truncation, normal writes into the file
can of course also change its size ;-) and ATTR_ATIME and ATTR_MTIME
also come to mind as implicit metadata changes.

> +	 */
> +	if (!(attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
> +				ATTR_TIMES_SET | ATTR_TOUCH)))
> +		return 0;
> +
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}
> +
> +static int hook_inode_setxattr(const struct path *const path,
> +			       const char *const name,
> +			       const void *const value, const size_t size,
> +			       const int flags)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}
> +
> +static int hook_inode_getxattr(const struct path *const path,
> +			       const char *const name)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_READ_METADATA);
> +}
> +
> +static int hook_inode_listxattr(const struct path *const path)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_READ_METADATA);
> +}
> +
> +static int hook_inode_removexattr(const struct path *const path,
> +				  const char *const name)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}
> +
> +static int hook_inode_set_acl(const struct path *const path,
> +			      const char *const acl_name,
> +			      struct posix_acl *const kacl)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}
> +
> +static int hook_inode_get_acl(const struct path *const path,
> +			      const char *const acl_name)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_READ_METADATA);
> +}
> +
> +static int hook_inode_remove_acl(const struct path *const path,
> +				 const char *const acl_name)
> +{
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}
> +
>  /**
>   * unmask_scoped_access - Remove access right bits in @masks in all layers
>   *                        where @client and @server have the same domain
> @@ -2100,6 +2177,15 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>  	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>  	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> +	LSM_HOOK_INIT(inode_getattr, hook_inode_getattr),
> +	LSM_HOOK_INIT(inode_setattr, hook_inode_setattr),
> +	LSM_HOOK_INIT(inode_setxattr, hook_inode_setxattr),
> +	LSM_HOOK_INIT(inode_getxattr, hook_inode_getxattr),
> +	LSM_HOOK_INIT(inode_listxattr, hook_inode_listxattr),
> +	LSM_HOOK_INIT(inode_removexattr, hook_inode_removexattr),
> +	LSM_HOOK_INIT(inode_set_acl, hook_inode_set_acl),
> +	LSM_HOOK_INIT(inode_get_acl, hook_inode_get_acl),
> +	LSM_HOOK_INIT(inode_remove_acl, hook_inode_remove_acl),
>  	LSM_HOOK_INIT(unix_find, hook_unix_find),
>  
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
> -- 
> 2.18.0.huawei.25
> 

On the Landlock side, the implementation looks quite straightforward,
without having double checked for missing hooks now.  This commit is
probably fine as soon as we have agreement on the LSM hook changes.

–Günther

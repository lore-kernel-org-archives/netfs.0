Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622423DE;
	Mon, 23 Sep 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133437; cv=none; b=POONET4/Wia8vOcPI0///xzqzdmkfWXZ/stXRSg2xqJPtws+N3EOnNVmxCnmFU2jVIsmDjm+7ambYiQjr4Sk72EqD18GrF68fPxiLVDFNU7XhHW6KYqcEcn028YYkphQGrrSXTlFh0HNhqubp92aQL4C4gX70C1+rRwgvVk9u68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133437; c=relaxed/simple;
	bh=0nsbGQ5ZG+++6fMb6NiR0gGaP+XrX2RMKND9mwuNB3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtOO4jB3T4j3qvlgQEzAGvSTGDTOCLXg3UK79wmTKTvdt5TDaQeVRKIKpQpHqNLgX83WAvwtjs9fANzEkh5IUk/ywbXx9zzgzeUD02+gT08MJrqNMAxe+OOjIZq01P4b7IyyFU45T/1Gt/mjn9GjTiZB6kqhsI7/LmR3Kzgo9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6RJI52t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6RJI52t"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so6189058a12.2;
        Mon, 23 Sep 2024 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727133434; x=1727738234; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngRtzW5JM4PktiK1i50Y+IhfPwDmKMxpAqupnEmiErk=;
        b=L6RJI52tRdqqPMWsgCwNDlH/K60Sj55PTuakAnBqKCQBf5+kJ2tc4pSDV88ZNc44WB
         94FhjtLamTVb2C+TX0uUGwdhbaipNLn9WBbbCaC3sPLvwxlPSaN5Blu5V+UrTtZ7Qozf
         dmtVl1qCm05F1yCRS29Gw9Eyi+3lCaA89b4Ntr8ysunknMvVNvN0AsxYd5UrwGxaUaBH
         WhC4hrXvg4ybernrl2mW5+RRcpoegHB+5wh7jBJ3zXRH0Pl7DHqpRGe2EB5dcwwg6vz+
         CNNrIyVQ8P2QFGPehjaE9YqIBaG4ATXXLdPYeLZEiLOjr1lW1+8YeQaf576wLjg4/H6n
         rO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727133434; x=1727738234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngRtzW5JM4PktiK1i50Y+IhfPwDmKMxpAqupnEmiErk=;
        b=jzi/0KyZhKQcjPDLVxfa9T6CZd1ZDZ4HtNWrhiAqnnZ3TESl0pRXBvNZCeYMD5DZdG
         odeI0ZG3t8eTycvOv48MJ5qJ4ylGsH+UtXZRBRwOx0yzlmjmFIfJmTr19a+ymMXD8nBW
         RvrBWlW0LtOyOnsnLO0alVnaKzLnLHtMBCWizWYrY/g+TZ9amY7mhhG/ty39coUUEv9g
         6kFE7uPXrSsu6SKeLTwOdr3l36y8qbdNI2a79kKw8QfUZ7CuO+Zey0VOWhQ4RopW5BDa
         +HyLHpKOHFVmdTGsNj5juDtvWhsyu2LysBPgSgBq6e4Fay0vPT38HAA8tuRb5wp6WkK8
         kuqg==
X-Forwarded-Encrypted: i=1; AJvYcCXCvIqV4xaY8PWE+ypvCv6mvX1R6DlU75bnvDGKl9PR+kdCZQYkUicGW5zLm22jOI7wcKhdgQ==@lists.linux.dev, AJvYcCXgBcE29uFZkc5tnQyQHpHzfyixOGVr/4fIuiPmP/jnsuXgEW5YZjWW1FQ9lPLg79odXf6zlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHkXD90LbvLbwBGBb6pofaeNjNecro07skcc/ZXbPIeJ1f+rWe
	tNquelkUWtoonTIoCPegNzD3e2Bzu/ho1Y5m1FwfGrZVgsfBPkbhkZfdOnI/6l5bZTUrKZ3qXIF
	NVWEvmtiu2ug41s165ogTskJtgio=
X-Google-Smtp-Source: AGHT+IH8LipBtLSxEtozQ2rg05n3Ixckwwsb8tD+R3wx/CmXcuSVcLfSG+Z/gs1ubLzXvUowuTAPkX6CdLZ8O6/puxQ=
X-Received: by 2002:a05:6402:3506:b0:5c5:c2a7:d53a with SMTP id
 4fb4d7f45d1cf-5c5c2a7d69amr3583016a12.12.1727133434103; Mon, 23 Sep 2024
 16:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-2-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-2-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Sep 2024 18:17:00 -0500
Message-ID: <CAH2r5mv75LkMnB4ZAWO+sxQwjMne1gKb5EGC3i7kc7h=L0emSA@mail.gmail.com>
Subject: Re: [PATCH 1/8] netfs: Fix mtime/ctime update for mmapped writes
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>, 
	Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next since it is important as it fixes a
regression affecting cifs.ko

On Mon, Sep 23, 2024 at 10:08=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime and
> ctime need to be written back on close, got taken over by netfs as
> NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer to
> set it.
>
> The flag gets set correctly on buffered writes, but doesn't get set by
> netfs_page_mkwrite(), leading to occasional failures in generic/080 and
> generic/215.
>
> Fix this by setting the flag in netfs_page_mkwrite().
>
> Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_i=
node")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang@i=
ntel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_write.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index d7eae597e54d..b3910dfcb56d 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -552,6 +552,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, s=
truct netfs_group *netfs_gr
>                 trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
>         netfs_set_group(folio, netfs_group);
>         file_update_time(file);
> +       set_bit(NETFS_ICTX_MODIFIED_ATTR, &ictx->flags);
>         if (ictx->ops->post_modify)
>                 ictx->ops->post_modify(inode);
>         ret =3D VM_FAULT_LOCKED;
>
>


--=20
Thanks,

Steve

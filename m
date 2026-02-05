Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7D39E6DC
	for <netfs@lists.linux.dev>; Thu,  5 Feb 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284251; cv=pass; b=UZNwFZEJ37n+stPmc5ktRPnK59oSEBuzzhTltFB4iBkVL98oEYxpd/agTy6JB+87wqETOeiZIDIgHCNfBibSEyQh25Qi+w8KS1m+AAUDkVN0B4OoTe5EfpQn8DzgT+02sPgYmk9AWkT1Xxp2IqmF356RlNYVoVak64qtyUZ/l8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284251; c=relaxed/simple;
	bh=O3zjcpb1gIgdrnZIOWkOIcCmTAMhdJCAtczZfkl8Mgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAzYR/ZgXqDUhQfl0FcWGaky8U5CYVpZtKdwoWWc0pXwiOqhxQUKA72zFm5xTrEgiS9Z6t0FrhTrjwSpcsqBmHXn+gTRucJ192H+l76+PGFfVcj0nELJ96/zEv4ceKfwKxpJjQSwZQ04l4ksDArzNMn2EdYxI9FzfLjxvniLD/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFKjVL2D; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFKjVL2D"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-659428faa2bso1273470a12.0
        for <netfs@lists.linux.dev>; Thu, 05 Feb 2026 01:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284250; cv=none;
        d=google.com; s=arc-20240605;
        b=VG5JBGKInvH7ZWAQIGY3xIZ/uU0FiUBDPQuB41zhgq4uwM/LJePv3vOXKBB/FDwgG9
         YJTbiY7HWCrot66nkve/ECL65HJGsbiZNHchL3s2jaupp8yie77TbN33DSsBc7XL17sA
         eKm2/stJLxMpAUsJVGHYHSknO31yHBtRaGZGJE4Hha6ika+yxq0A/5i9qJSVb5HQKmsC
         uVo3sonGLXL7llyQyMJgTSKWNpW9h0FFpRX+ucyTiVvnHeOEfPfiEb6hmLvrwJfKV2tw
         26TUYMvq/2aNlrXt6ChevQc3/RSoj7a3ZigAvEfkR3gmrzQc6Ri/AeGIntsRiQuHGk91
         HGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        fh=4k+XaUYlOgWs0ZBTauYBQGwYPpc6waTMhYr7WbgzpWc=;
        b=VoIXbJ1G+LFxKG5w198XH57fszyh+VKjKLUZSWyDSdzuyQ6g7Mj9f9QToCprxqIk87
         N37KE+Bdfib+WqGsV5xZJpbxhbLhaOPihdp2R31JHAEPLMOixnJOMh7sTZtsTkYS/HA0
         NETwm71VuAA4mQjAXu4OKUrijOgr6gTbktZmqtjp0VY2u7cIP8rr3Ly5gfqT8UyAttUb
         YXmaMMVF+itBqJFSLz6a9b4Uae6P7rUSxL6pvkCAb7QdhtsR0Nf4XxfvRi8r+RRMA+8k
         osaMzmTLCOYXj9NgI2RE9Ux98crpHhnj0RUX3hA2IhAW3n29bcNX21oVZ0woPbX3RQPe
         EFZQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284250; x=1770889050; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=HFKjVL2Dx3I36GuKEG4CpNekx1DIxaTUAwbZMBumWZQq/x7gSSwo2RPvZgpwzEsiSG
         dBjmdpC0ZGD4n8QMFIOTY54gPP63FBqBGzV5Ej4Qn9abnFiRTGfDWTeC8XlwkwmdyDOZ
         XYQU4HD2vwkXcho1PR5PKQjndyOs9R0Gjim5VTPl11o47//d80vZ3bQvWvXyIko8Wwhe
         JMnkNU1XiOROCzcCFp9kqjY+9GZ03NaEuRE7ZzTejJTKh89cdHVIoF/dcmH0cWnN87ez
         /oqel5znZzlF25saE81OFSXUsn2Df1bV1XMr84FhSuLUREvIHX3kn/GPG/TpNwcjw3QC
         8VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284250; x=1770889050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=uz5eCbsU05lM7x10kvP3rIu0cQK12wU+2EDPpEW1aTHMyyOg2cSgIi/ooT49rUE7We
         O1v0WfLoUiww0eEE3PpDfAv/7U4L2STa2tCi80FNdjmG3SSbGF59Og4TaU+L2cFQ4lnv
         4OREo/6FUx/59ttwHrIvW6oMXIkI1F3Allh8nDbdIdNnlbxtlg45h8fGS6hhVi7B1h8n
         QZwFKtKdkYOA4c17uaOM6OubQM54djCqrqSOJQ7pXn+ijGw2cRaBKgS8wPnRRU89lcGB
         ZDTcIX4Zhb82aEmyVgiM4R1RwlEnhbpvMdcQHaSSXaHUWVzIlezi5QdRoF84u3aCwbSY
         4Ymw==
X-Forwarded-Encrypted: i=1; AJvYcCUXr4lHwHnJDQOhtSQnRFROzlHPjJzV5geRSLluCcANdnQklE0Fez5haZx0k34LE8PPfe0fDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyegGUfSDJOgzeHfEE2S8G0DfXDv/Ee44pnMcGcuwqkMlnFslwU
	8fe3rvoK/+fDsi+h2fZzh1fwqRLkETXRBR1Y6sbpMk/yNHSzJFJNQN5QlzAF/pI/8ZyjM2jY1q8
	MsatZe1C1M7oqUVbzEcG5+RmIdlpdcUY=
X-Gm-Gg: AZuq6aKB3t5wVuFaNPrCyQAvm/iUFZYE9xEgvyB2+0GSYShx+s7AIMQgH5KnQkrk7Ik
	4BpqHp9GZErmzhaz24pRlHm7KIUsdKY3wOC2FzEt10ObOmxZQyPTY3l5CWX5OwmVv16nfSTFl2M
	JMvWV1jTbFx5QosVnLamF14vRYVT99ovmeNVmrIytVhzQWfiQNAilA/ymESa+zZJESCIgxHzSc/
	AKRZkpNoYAVUtjUEjcCSf/kUuU/UIkWoBeZSxOdW+BFeBgPqlZ7bBdGEYnfM+137FX2bMfvVcJ4
	D1Noa2z6BX+65giZ0HtRCwV7fWTKuA==
X-Received: by 2002:a05:6402:2688:b0:658:cf28:90ed with SMTP id
 4fb4d7f45d1cf-65949cc1e5emr3920680a12.15.1770284249654; Thu, 05 Feb 2026
 01:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-12-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:37:18 +0100
X-Gm-Features: AZwV_QjDs8XEOiRuWGAHzisKUrokVjcatEGo5N0FYjLzK48UQXH5p374RE5BkHo
Message-ID: <CAOQ4uxiYUTi=8BjRFbY_GdBZR_5CuP6680me=_xQaPcQk7EFuQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] ovl: use is_subdir() for testing if one thing is a
 subdir of another
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> Rather than using lock_rename(), use the more obvious is_subdir() for
> ensuring that neither upper nor workdir contain the other.
> Also be explicit in the comment that the two directories cannot be the
> same.
>
> As this is a point-it-time sanity check and does not provide any
> on-going guarantees, the removal of locking does not introduce any
> interesting races.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Looks reasonable

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ba9146f22a2c..2fd3e0aee50e 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -451,18 +451,13 @@ static int ovl_lower_dir(const char *name, const st=
ruct path *path,
>         return 0;
>  }
>
> -/* Workdir should not be subdir of upperdir and vice versa */
> +/*
> + * Workdir should not be subdir of upperdir and vice versa, and
> + * they should not be the same.
> + */
>  static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperd=
ir)
>  {
> -       bool ok =3D false;
> -
> -       if (workdir !=3D upperdir) {
> -               struct dentry *trap =3D lock_rename(workdir, upperdir);
> -               if (!IS_ERR(trap))
> -                       unlock_rename(workdir, upperdir);
> -               ok =3D (trap =3D=3D NULL);
> -       }
> -       return ok;
> +       return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, work=
dir);
>  }
>
>  static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
> --
> 2.50.0.107.gf914562f5916.dirty
>

Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813146C835
	for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039011; cv=pass; b=Voxx+qmWGfPxrKAMBWG5a7Jl1HtwNU6I0RrlPPmnTRjAZXTFlwIqt56ZgoqlU6w37u47DMnSi1Vz2kxjrbPDF0WQ+uA6J+IuSMqz665NvwFKzTcI5+jDwVxHreDV2+Z0dadN+9Pl0F/+Hpq+fdhev4kAt5BKW9PmSaIsFqrG0sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039011; c=relaxed/simple;
	bh=+W3Wfbrm9l0QBxIY85+kvJuwhr0yXrpNOQry462mnzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRiBlNzPK5G89Lg7rhkwyi6trB4YggD8I97w6FxNp03LiMEemMTjxmld2QmRw5ac4QCMe5Zlj1XHHSIJtXs78I9g6QT5IQhvkjBDevMTcxmFq1aG/B09LusU0+r3MDSoRGFWrxPjq57MUV3kmEY8CytjK7vnTZMhHPDbRr8JYpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oys//Baf; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oys//Baf"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c28fde3bbd2so699620266b.3
        for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 04:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789039007; cv=none;
        d=google.com; s=arc-20260327;
        b=OZ7Xp52UYYdBs+Ro3t6Sh/HVLSuejvx1vmeWx2FlvupO+FRRmPOz+i/LkoMGBhvQhO
         zxacghK26d/4xMWtqE5zdmbDUpqxj0R9+I3ylRXZDxdZRTZRRP/F+UMHVa/o8A3V/rHR
         YWgqTlRAyFusTMSeQzW6qNR3znbh60OFzz43TwHTXIUQcLThVRy0DGGCpcbTuwXSdvAM
         u4EDbxinCJ9uCG495neEPccd5Sd2caX4eZi/R6WWaOa1n9bzZ2ZO5Oqe4eD7zt1L6E8I
         8+P7AwqAloqDPjo1UsEQ6Pn8ik4AaejJ8Hpm0k0zHFRO9IQreUC6WgA147MF4CLUzBF2
         0hRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XO6VaobXZGWia1X7kMvnC3RKOfj+R33S1pbngB91qrc=;
        fh=aNNn9upiTS8p0/kTvOr+m8o/OzBgqswvffFQwc2hxrE=;
        b=dD9bmT1ckiAbRrWdTKtz/Bxl4DMbDvBYISZ1ZCM/RAXgspbUE0HO4LBXmUfTvMAy3z
         0u1uNUoUqp8gTkELcmcN42PU19CG3zGPvA4xJ1AvuTifSZXs7EdC5ZrGHsn0mfaSzO1a
         iJL1cthtj+uNM6mZCuiJoC7rsvm258TEDlc6VB3KxjsqNFjefqiCv9a/+FGA8kUjdFjQ
         jRqHyXj/pUyInSPxhBUR4xFF7kMLadUHl86Rn7AkZG7KZVgY6nzftN9Xcy1rF9vZOXBk
         JtGV4ZNm+LKzXVvDdg98n5x7IZ5zLvBKP/TVn6nl97v299ej/zOxe6iKa6S1bLcmlyKZ
         O6zw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039007; x=1789643807; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XO6VaobXZGWia1X7kMvnC3RKOfj+R33S1pbngB91qrc=;
        b=Oys//BafIagfpsNm1Vza5rpzf94oPqwUY8gHL2p/Qb52RioFDE1TAApa4+kiyiexql
         tHIZDCpcyV+8Rwaa6IcPZbkASjlBTF3+QteFkAqlyviiYbZkruv56hdw4m+DPUYpaMQY
         66nWz5OZ979+QzNCYkGR65F4Le+au99WG4N0Ju1TanaiFGLwmVuPf1RBg9We39buy/GH
         vLDxlLSlBbsP7BoS5KbImI7iJM7ssX0oI9bBu86mMkkDfOI/ucjf2gVFLTvFTZXsOSJ6
         FfDHsW6C08bafn/VtLx2oFab7UIlxF0fz1VGjK745JcPN3bB7Lcly6ZC7lmf6hiaLqa9
         /bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039007; x=1789643807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XO6VaobXZGWia1X7kMvnC3RKOfj+R33S1pbngB91qrc=;
        b=YfKw54cS4EdJMg52W+9bpGYlZlep9nn0jkq4gU+d6NOb91yOz/pa2PCHyBf0PjNvWv
         r8x0PQgneDAOu92x01SLRTmDLxtEOyhdmAsehxpvuUg9SzGhHkEP/PBI88hThEXKCaoK
         zQD0VSUzyesCFhItdYcI+W42mD+wS5qzOi/u8Svcj4Sdb/xVEyyvUPyIeovdlk0CU4lG
         5DAg8+S/KKrQ40oaNZmO7CyJxWNkCgckugAvwXJYqABHr8KmdukRukvPapK8V5+4hDvT
         yU5scQ150x5W5nYP7lOXIjXPcbKxT7QvNHZrT62bsGYX41jnojO0WojitaznEzmwbJe2
         2JZw==
X-Gm-Message-State: AFuF++mzOnLOFl1TnnlPbRyOXkBPqeNTqEqefVIgO6zONTL2YVb9S2Uv
	DrFQshytDZwgmPJbXIWoAc0aEfOwvjq9ifApclxoQCXZxQ4qVmeOQXI4PMycPuUVl9HuDq3R/Tm
	7vqIhOSar+abM6WQfcHO03zjbYu6Ya5w=
X-Gm-Gg: AYBFou0BdvT3+BtJAdR7z29uJu9mpRfVmxe01zTeTjgYYBLJLU8mh94KzZd8o4YZT6v
	8+Xj63fWrUJ/Ks6s6LU3vhZGJ+K44R0r7yMi0BCeWQw39+aqmHPd2KYqg2Y/NnRRWn7CtY5mubM
	TRHurtBIer8ME165YEdMKNLnBT68vfML1+3YuYa+g8jjtZdj6xuGN6ABGfrDQlxY74iqUWaoB+O
	lbTiVhtwiCKqe/+8j5M7dKKY6TIKAdvQmsmWUkIcO5M/Vnkv7Y+3WJ75uSUfOzFqLzPZz+kUw47
	bMgAzougqKTJKmnDiij3kyuRA5qKiPilbQUuVYs4fiKXlP3ksAzgQqyNlT2Jtm0=
X-Received: by 2002:a17:907:940b:b0:c26:1691:b366 with SMTP id
 a640c23a62f3a-c261691b9d4mr1569867666b.31.1789039007375; Thu, 10 Sep 2026
 04:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260829224500.14278-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20260829224500.14278-1-drifabdelmalekmohamedsaid@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Thu, 10 Sep 2026 12:16:36 +0100
X-Gm-Features: AcwNN1VS3paqKY9JiTjA9U6ccb_T4MIJg3qpXTm9q7N8BpiXIyE1ikzKXupgueo
Message-ID: <CA+xk8n8Ox61s-o4JXjzf_A-V77Dsg92jYQS4XUUcYohCWSCcNg@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: convert deprecated simple_strtoul() to
 kstrtoul() in percentage command handlers
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping on this one =E2=80=94 seems to have gotten buried during the me=
rge window.

Thanks,


On Sat, Aug 29, 2026 at 11:45=E2=80=AFPM Drif Abdelmalek Mohamed Said
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> Convert the six <N>% percentage command handlers -
> cachefiles_daemon_frun(), _fcull(), _fstop(), _brun(), _bcull(), and
> _bstop() - from the deprecated simple_strtoul() to kstrtoul(). These
> are the only handlers in this file that take a trailing '%' after
> the number; other nearby commands take plain values and are
> unaffected.
>
> Since kstrtoul() requires the whole input to be a valid number, each
> handler now walks the digit run itself, checks it's followed by '%'
> and NUL, and temporarily null-terminates at the '%' to isolate the
> number for kstrtoul(), restoring it afterwards.
>
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>
> ---
>  fs/cachefiles/daemon.c | 78 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 12 deletions(-)
>
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 1a66e0af2837..12c38b366881 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -331,16 +331,25 @@ static int cachefiles_daemon_range_error(struct cac=
hefiles_cache *cache,
>  static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *=
args)
>  {
>         unsigned long frun;
> +       char *end =3D args;
> +       int ret;
>
>         _enter(",%s", args);
>
>         if (!*args)
>                 return -EINVAL;
>
> -       frun =3D simple_strtoul(args, &args, 10);
> -       if (args[0] !=3D '%' || args[1] !=3D '\0')
> +       while (isdigit(*end))
> +               end++;
> +       if (end =3D=3D args || *end !=3D '%' || end[1] !=3D '\0')
>                 return -EINVAL;
>
> +       *end =3D '\0';
> +       ret =3D kstrtoul(args, 10, &frun);
> +       *end =3D '%';
> +       if (ret)
> +               return ret;
> +
>         if (frun <=3D cache->fcull_percent || frun >=3D 100)
>                 return cachefiles_daemon_range_error(cache, args);
>
> @@ -355,16 +364,25 @@ static int cachefiles_daemon_frun(struct cachefiles=
_cache *cache, char *args)
>  static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char =
*args)
>  {
>         unsigned long fcull;
> +       char *end =3D args;
> +       int ret;
>
>         _enter(",%s", args);
>
>         if (!*args)
>                 return -EINVAL;
>
> -       fcull =3D simple_strtoul(args, &args, 10);
> -       if (args[0] !=3D '%' || args[1] !=3D '\0')
> +       while (isdigit(*end))
> +               end++;
> +       if (end =3D=3D args || *end !=3D '%' || end[1] !=3D '\0')
>                 return -EINVAL;
>
> +       *end =3D '\0';
> +       ret =3D kstrtoul(args, 10, &fcull);
> +       *end =3D '%';
> +       if (ret)
> +               return ret;
> +
>         if (fcull <=3D cache->fstop_percent || fcull >=3D cache->frun_per=
cent)
>                 return cachefiles_daemon_range_error(cache, args);
>
> @@ -379,16 +397,25 @@ static int cachefiles_daemon_fcull(struct cachefile=
s_cache *cache, char *args)
>  static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char =
*args)
>  {
>         unsigned long fstop;
> +       char *end =3D args;
> +       int ret;
>
>         _enter(",%s", args);
>
>         if (!*args)
>                 return -EINVAL;
>
> -       fstop =3D simple_strtoul(args, &args, 10);
> -       if (args[0] !=3D '%' || args[1] !=3D '\0')
> +       while (isdigit(*end))
> +               end++;
> +       if (end =3D=3D args || *end !=3D '%' || end[1] !=3D '\0')
>                 return -EINVAL;
>
> +       *end =3D '\0';
> +       ret =3D kstrtoul(args, 10, &fstop);
> +       *end =3D '%';
> +       if (ret)
> +               return ret;
> +
>         if (fstop >=3D cache->fcull_percent)
>                 return cachefiles_daemon_range_error(cache, args);
>
> @@ -403,16 +430,25 @@ static int cachefiles_daemon_fstop(struct cachefile=
s_cache *cache, char *args)
>  static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *=
args)
>  {
>         unsigned long brun;
> +       char *end =3D args;
> +       int ret;
>
>         _enter(",%s", args);
>
>         if (!*args)
>                 return -EINVAL;
>
> -       brun =3D simple_strtoul(args, &args, 10);
> -       if (args[0] !=3D '%' || args[1] !=3D '\0')
> +       while (isdigit(*end))
> +               end++;
> +       if (end =3D=3D args || *end !=3D '%' || end[1] !=3D '\0')
>                 return -EINVAL;
>
> +       *end =3D '\0';
> +       ret =3D kstrtoul(args, 10, &brun);
> +       *end =3D '%';
> +       if (ret)
> +               return ret;
> +
>         if (brun <=3D cache->bcull_percent || brun >=3D 100)
>                 return cachefiles_daemon_range_error(cache, args);
>
> @@ -427,16 +463,25 @@ static int cachefiles_daemon_brun(struct cachefiles=
_cache *cache, char *args)
>  static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char =
*args)
>  {
>         unsigned long bcull;
> +       char *end =3D args;
> +       int ret;
>
>         _enter(",%s", args);
>
>         if (!*args)
>                 return -EINVAL;
>
> -       bcull =3D simple_strtoul(args, &args, 10);
> -       if (args[0] !=3D '%' || args[1] !=3D '\0')
> +       while (isdigit(*end))
> +               end++;
> +       if (end =3D=3D args || *end !=3D '%' || end[1] !=3D '\0')
>                 return -EINVAL;
>
> +       *end =3D '\0';
> +       ret =3D kstrtoul(args, 10, &bcull);
> +       *end =3D '%';
> +       if (ret)
> +               return ret;
> +
>         if (bcull <=3D cache->bstop_percent || bcull >=3D cache->brun_per=
cent)
>                 return cachefiles_daemon_range_error(cache, args);
>
> @@ -451,16 +496,25 @@ static int cachefiles_daemon_bcull(struct cachefile=
s_cache *cache, char *args)
>  static int cachefiles_daemon_bstop(struct cachefiles_cache *cache, char =
*args)
>  {
>         unsigned long bstop;
> +       char *end =3D args;
> +       int ret;
>
>         _enter(",%s", args);
>
>         if (!*args)
>                 return -EINVAL;
>
> -       bstop =3D simple_strtoul(args, &args, 10);
> -       if (args[0] !=3D '%' || args[1] !=3D '\0')
> +       while (isdigit(*end))
> +               end++;
> +       if (end =3D=3D args || *end !=3D '%' || end[1] !=3D '\0')
>                 return -EINVAL;
>
> +       *end =3D '\0';
> +       ret =3D kstrtoul(args, 10, &bstop);
> +       *end =3D '%';
> +       if (ret)
> +               return ret;
> +
>         if (bstop >=3D cache->bcull_percent)
>                 return cachefiles_daemon_range_error(cache, args);
>
> --
> 2.43.0
>

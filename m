Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F0331EB7
	for <netfs@lists.linux.dev>; Wed, 23 Sep 2026 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132812; cv=pass; b=icycmraCXOxviJEVUtbFMFTjOcLEk85956m9rUN5En7mjJGrcPrZ+E71CVo5P1H1v3i+SAJeIIsKQZgnyF+8fF0BbkmUSVEcHOzYhobYmYeIT59k0fWdch53l55pFYjnpdeoyaoU9CwlOlwtdO0xTgCjV01lkzcGnMoRNAs78kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132812; c=relaxed/simple;
	bh=vT5rt2ey3w3svwWjeKYR1sh8KkF6JvEusbX1aNDa9pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQTvlIuyN9Q4doVZCmhd1jaFAS4lfwoZ6KJmtDrzNFuwyttm7dQALU6rSBaopKZOMK9iUpHOy18l3htykXfeqg177WKp6skKjy760E44yAahJqoV4OsM54VpTQxY0b0FajKCt+dcvewggqHDJpTWjTKIWQzs0NUJWsDnziMT7OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+dHamhu; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+dHamhu"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52faa58bff5so82181cf.0
        for <netfs@lists.linux.dev>; Tue, 22 Sep 2026 20:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790132808; cv=none;
        d=google.com; s=arc-20260327;
        b=j3GfPP+AniJ7u5B7jyc3BsemuwxZtVZw3eaN7fw7HiN2hm2w7eJj7ftiOArdhuXTi0
         1kjifzCVGYKEzgAQh6FVnEZG7U9goCkitYzfDy73LKV9MI+y6sA1hTAvdIZ7WuAW4+Dz
         pNRr7CiZkJvY44c0Ylz7V2Z+iKsGnuQuMZBHDZusrUqj6ZYVUp1KBPJTEbsJbSK7W7yl
         Nc0nKxVdbUubr3h88g/8Alp7K+be3DOvuRgXv5jv4+0q9G87hZiUPUP1Gl3UANqwaCui
         cos3PL+oc3Um0pNPYz6I1gBhetbhBN9uc7mvUp7/mqMei5AKxmQOeLSKWArM9hRpGsmK
         QwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        fh=8f2d12+Ue3/QpgnpWEkwF/rRiQkiz+P4p7ImV3bC9+E=;
        b=GjG/qqwhPmb96pNlpFcX7qBGk7PSuDmaZS1c/V5gw265FYUBn5MmSBxJv3UYREAPgv
         /bGpSIQCuCufzTVSIsN3SaRHdoa9umJZKx8bYGxVMsjH7qQhxtaCZqTRm9DQC2zjqr7a
         he2dPX5JrRm6tjaNz9xzi7BqJ4K9V5WNakwWWaco4hw/XkLW53zoPlt5RcKP0rZCdc9y
         3UL/1T5cN8bGBRrI+53g4QYnZmn/VM9Df9XCc925BRH9gDax/+KrDLGwnZFNz5mcrYzI
         wyaOmFbVN1htXc7MwNqxUdCUN7BGqWJ0uX3YiLVh/nXH6497qKiEVFFFh5Kb/KbIKy1t
         K2yQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790132808; x=1790737608; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        b=N+dHamhuNdiqUFf09qmgi+S1MLRykGmNsvdq2NK7J+HZr5DxQ+p7zznVWx+kuvT3mg
         mNnP6ATvkl8XpSEC3xi8hjLGDR5FTZbNI77wi1qoiZugZCYf6BOmIgjLuY/x054w/qSu
         wMHZTdlSFpWTOpSKly3bCdVT72tgLIRdFB9ePJGVG6h4cXOBiQa2JRtfJ9ZCn6DwNQ84
         jw/c1dDcvcnfCR4pUA3sQnZrgWXgslt8vls0sWFm8RVNAMXHd8quP2MZQlBhYdcIV4DI
         O59lPNwkkHgD97npQ3Y78FKDVYtjnXpe1Q2GqwITzumoPwD9nlzkieS+jG76vfi+HlzC
         8G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790132808; x=1790737608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        b=TLHrBqjRR/kUiRNHBdXttkJhTRPQ3dj6ORnKqsbyGgs/hrk9t0y2SFaTzD/U5OUO9m
         hJosjXeUSI+HSQ1BryW9kRluaQu6nn1e39+1FITCtVcNnH8sHuYjPDxqE/H/ILpqW2+G
         uvmAUAed53eZgpX4gmAzGmBakM+tESLOjSvcGoT5ozSu2G/aNf7CIex82l8nbvct/Kr2
         +ZwtmwsPILFPC7UviD6B13kgIpN9DJ5pyAfpoDCXyqpIgn1hhB9d1VYesDxT17G0GZxe
         KEVfPwvcTj9sCa4q6rUH8oCHmoCNyezHTzNwfT1MgXA7McEz4TM0Qbc4ADaKIAVCoolv
         +OAg==
X-Forwarded-Encrypted: i=1; AKwUvBz34WRRzAJF5Zvxc4TRgHy8BIT1K4axkVLCHuUlMUXLps/vt9ahevKjeq0GjhT+RewmHMU+Jg==@lists.linux.dev
X-Gm-Message-State: AFuF++naIU+FWVzMZ3i6Tg4o02EZVHVO4t5orOneecTU6EXsyB73jIpQ
	epE/9RgM+C2fdii/STWleuYl+yBYFOCEsUoOe52ZR5Q+Xl2jSz+fJikzQqrpk5rmqB1KxF7AVwD
	LgvJ2f+OLDr2gseK1cqoKVXmetEOyw6wZ8bbCHSF3
X-Gm-Gg: AYBFou3Fsq468hGAtZ+bkDMwpH3yTyW8hGhRihZYi51ZzolIBma7BBxMPUcjCgYguUY
	Ph/hzdeZC1ya/rC+yeiw/S41m2byWJ0U2lXEHL+t3eG6IWh3N8wysDWxwx+LgNx+GuwiLXIajrY
	u6CrO1QTI3JeGQWd0kVFhnL+W8W85otp0l66ReYVr945oRZSXiCsv8IRft7IZyLwZm44Nn4wc0r
	GprW4bFbjrqI+ooVPyu7I/8R40GOzspYghYeemMuftFSjOwOhKmdXZmadECfcoxAPFUrokoiTlG
	ay3u9DlrblGBL0KFFHNXB5Ld01nQWKSswX1mVL/2OOjHAzoA+utp/dXGuUg8FD3m
X-Received: by 2002:ac8:5d92:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-532ef021d33mr4455851cf.10.1790132807938; Tue, 22 Sep 2026
 20:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922023541.51532-1-hao.ge@linux.dev>
In-Reply-To: <20260922023541.51532-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Sep 2026 20:06:35 -0700
X-Gm-Features: AclHuK_Ckf9BkzjT2yz5Z9Ieaus86uHwwpQxqkJxhDMBAS12Kru5JUofGg3dI-k
Message-ID: <CAJuCfpEFxn6peTwkE=orOuhSBchmuziYK1Xt75iwJo59rqYUQA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix missing alloc tagging of direct mempool allocations
To: Hao Ge <hao.ge@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 7:37=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Commit 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by
> adding a mempool") added a mempool for the folio_queues and made the
> request, subrequest and folio_queue allocations distinguish between
> writeback and everything else.  Writeback is part of memory reclaim
> and must not fail due to ENOMEM, so it allocates under GFP_NOFS
> through mempool_alloc(), which may dip into the pool's reserve and,
> if that runs empty, wait for elements to be returned.  The
> GFP_KERNEL paths, which can return -ENOMEM to their callers, invoke
> the pool's ->alloc() callback directly instead.
>
> The direct call, however, skips the alloc_hooks() wrapper that the
> mempool_alloc() macro provides.  The pool callbacks, mempool_alloc_slab()
> and mempool_kmalloc(), call kmem_cache_alloc_noprof() and kmalloc_noprof(=
)
> and rely on current->alloc_tag having been set by the caller.  With
> CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dy this leads to
>
>     current->alloc_tag not set
>     WARNING: ./include/linux/alloc_tag.h:161 at __alloc_tagging_slab_allo=
c_hook
>     alloc_tag was not set
>     WARNING: ./include/linux/alloc_tag.h:166 at __alloc_tagging_slab_free=
_hook
>
> at allocation and free time respectively, as reported when reading
> files on a CIFS mount.  The allocations are also missing from
> /proc/allocinfo.
>
> Wrap the direct ->alloc() invocations in alloc_hooks() with the new
> netfs_mempool_alloc_noreserve() helper.  The GFP_KERNEL paths keep their
> failable allocation semantics, they just get tagged now.
>
> Fixes: 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by addin=
g a mempool")
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@=
mailbox.org/
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  fs/netfs/internal.h       | 3 +++
>  fs/netfs/objects.c        | 4 ++--
>  fs/netfs/rolling_buffer.c | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index c79c8e69d60c..08ba7f0ebff0 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -45,6 +45,9 @@ extern mempool_t netfs_request_pool;
>  extern mempool_t netfs_subrequest_pool;
>  extern mempool_t netfs_folioq_pool;
>
> +#define netfs_mempool_alloc_noreserve(_pool, _gfp)                      =
       \
> +       alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))

I think this macro should reside in include/linux/mempool.h and not be
netfs-specific. Something like:

#define mempool_alloc_noreserve(_pool, _gfp)                             \
       alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))

> +
>  #ifdef CONFIG_PROC_FS
>  static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
>  {
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 7f6a3e912602..0b509c93d4af 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -34,7 +34,7 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>
>                 rreq =3D mempool_alloc(mempool, gfp);
>         } else {
> -               rreq =3D mempool->alloc(gfp, mempool->pool_data);
> +               rreq =3D netfs_mempool_alloc_noreserve(mempool, gfp);
>                 if (!rreq)
>                         return ERR_PTR(-ENOMEM);
>         }
> @@ -214,7 +214,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(st=
ruct netfs_io_request *rreq
>         struct kmem_cache *cache =3D mempool->pool_data;
>
>         if (rreq->gfp =3D=3D GFP_KERNEL)
> -               subreq =3D mempool->alloc(rreq->gfp, mempool->pool_data);
> +               subreq =3D netfs_mempool_alloc_noreserve(mempool, rreq->g=
fp);
>         else
>                 subreq =3D mempool_alloc(mempool, rreq->gfp);
>         if (!subreq)
> diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
> index 424e77a9a109..54867ceaa205 100644
> --- a/fs/netfs/rolling_buffer.c
> +++ b/fs/netfs/rolling_buffer.c
> @@ -29,7 +29,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rre=
q_id, gfp_t gfp,
>         struct folio_queue *fq;
>
>         if (gfp =3D=3D GFP_KERNEL)
> -               fq =3D netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.poo=
l_data);
> +               fq =3D netfs_mempool_alloc_noreserve(&netfs_folioq_pool, =
gfp);
>         else
>                 fq =3D mempool_alloc(&netfs_folioq_pool, gfp);
>         if (fq) {
> --
> 2.25.1
>
>

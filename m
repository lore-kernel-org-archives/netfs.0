Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0142C512;
	Wed, 12 Aug 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547458; cv=none; b=LIhijpqrLTwh58xE5DNWGx7ISXJRDTfKyauoExpto4dOg+x4PqXhMdMh9WQ3MiUdhUACAyf9K8j3lIamBtBipba9pSPWqtuw+5sHF7310KWXtdQan++yg0FYKDfUthftlR+Z3ShC9IiWTjDvi5NRaR85jx82290Ople98NiNk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547458; c=relaxed/simple;
	bh=rKtIjDSag7GLITybbuC5btvTBEH7EgZpyhvkP2+nQLI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DfAKac98VlVuj5JnUxYzCBHwtJt1xd8G7HajO5aopBRrtfGfcbz+u3nxLPiTRIFBOIf6gARxfL3pV3TmkO2RktUTzPeWceIL5jjR/SUbjGacMiSWnb5DB7NU0orRotrvlFwwsGS5IBs9mb1WokcIDH6IrKsD7Oj6vPXJ6qkSqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEyUEHJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEyUEHJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D101F000E9;
	Wed, 12 Aug 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547454;
	bh=/ZWJRa1Kujc46wtuDW1TyqEzOM49Ci676ogxQ8t5URg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZEyUEHJPAe+/dDY48z30dEzn47bZYkxIs8J6/nAnvhQXBdO9A/3yNIpJLvNBm659o
	 pKQ+JDd/wXb8k/3N4fJya43ZaTrRCb4ifRL37JGFib2Tdu3nkivoWOA/4x95g0IAhc
	 iXG9W0fOl9d3l+FoWRmhkiDFu12S5GmDhOGg3WQsb3jmJMbBBUZq1VO2mafeq+dNG6
	 e6AgirlOvSUeLIGINVBLNULnh8vorfNUDVahsyinf1wUj4mW2AYw4jh7mEKIiJbNhT
	 GVGjQZ+GnH+bZBPXdAVh2icl6+07S8agUQSmFrDqwbX3Kb4NIhv6RvdE7YlAnMIUE+
	 RhFaTmSMRYEmw==
Content-Type: multipart/mixed; boundary="===============8306528015998865884=="
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <94a7b419d2b1294cf953554e3a9c45f20de6d453bbda75569fae1a4b7e28df2b@mail.kernel.org>
In-Reply-To: <1046393.1786544127@warthog.procyon.org.uk>
References: <1046393.1786544127@warthog.procyon.org.uk>
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
From: bot+bpf-ci@kernel.org
To: dhowells@redhat.com,brauner@kernel.org
Cc: dhowells@redhat.com,xiang@kernel.org,pc@manguebit.org,netfs@lists.linux.dev,linux-erofs@lists.ozlabs.org,bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 15:10:53 +0000 (UTC)

--===============8306528015998865884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 3d2befc6d8d7e85b20d92f4baab590a997635d81
> Author: Gao Xiang <xiang@kernel.org>
>
> cachefiles,netfs: sunset ondemand mode
>
> It was an effort to enhance fscache as a kernel cache for lazy
> pulling (at least according to previous Incremental FS discussion [1])
> and EROFS over fscache was the in-tree user of this mode.
>
> fscache has since evolved to be netfslib-oriented, serving network
> filesystem inodes via the netfs library, but EROFS never acts as a
> network filesystem and we need to cache golden filesystem images rather
> than individual EROFS inodes.
>
> Since EROFS over fscache is now removed, clean up netfs/fscache/
> cachefiles upstream too.
>
> [1] https://lore.kernel.org/r/CAOQ4uxi4dzxArY24YO=+kBCK2gGoq3Ptb8WkzCqSogPgU_R3dQ@mail.gmail.com
>
> [dh] Fixed up comments on:
> https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com
> https://sashiko.dev/#/patchset/20260722130218.78958-1-dhowells%40redhat.com

This isn't a bug, but would it be worth turning those two review tool
URLs into Link: tags with lore message-ids instead, or dropping the note
before it lands?  The rest of the message follows the usual format, so
this block reads as leftover process metadata.

[ ... ]

> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index b62cd3e9a18e..c93324e0f98c 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h

[ ... ]

> @@ -298,90 +250,6 @@ extern struct file *cachefiles_create_tmpfile(struct cachefiles_object *object);
>  extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
>  				      struct cachefiles_object *object);
>
> -/*
> - * ondemand.c
> - */
> -#ifdef CONFIG_CACHEFILES_ONDEMAND
> -extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
> -					char __user *_buffer, size_t buflen);
> -
> -extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
> -				     char *args);

[ ... ]

> -extern int cachefiles_ondemand_read(struct cachefiles_object *object,
> -				    loff_t pos, size_t len);

[ ... ondemand section removed ... ]

This isn't a bug, but now that ondemand.c is gone, io.c is the only user
of __cachefiles_prepare_write() and __cachefiles_write().  Would it be
worth making them static and dropping their declarations from internal.h?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31607781274
--===============8306528015998865884==--

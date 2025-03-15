Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358C18FC9F
	for <netfs@lists.linux.dev>; Sat, 15 Mar 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047621; cv=none; b=ZHJtukKHuramFT1JgCIxH7Sb71g3MVrI2HJQ+LcxTfnvKFyfecCxZJ1ohLBfoJ3mjbL0xRWlaKbwtXZyDG0nE/oPAYFcDwUhkR4x0j7OShW3Wi9kn09z+xFoDF2k3akp35yR5UfZ0AEvIgakq/d9XMCSSrJwgUmbYl3X9b4j0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047621; c=relaxed/simple;
	bh=JVDbtLCVlsfAE0DKLnc7htPf2h9AUEfuVUxHXsmEtW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwzXJUpgeZ26d1JoY8/2DHPu8xXfY4gQ2z+Np9+PHSCeSeBPG8xoO2PKwkEZpfb8NfDOYLs6AQvNHfnrC1ysLcjtTnT69SuVn9CX2RMUPzGyZj5qqHurNHGPca0Q8fBPzwQsW+DqH+hQsj1e71VrqV8+6azAlmeBfOVgrPrhMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSG7RaEm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSG7RaEm"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac25313ea37so607902566b.1
        for <netfs@lists.linux.dev>; Sat, 15 Mar 2025 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742047617; x=1742652417; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fu6S1gMTWBKKSz25cBF2A3XN/mQqBpDLU5UkcNDyaKE=;
        b=CSG7RaEmVv4eKCBZMuoe+rgDdpGhf1mIHsKwJThzDhUhsgoyWVmtn75P45tWHHLdlo
         RPcw0xQ9whkpDkXOScP7jP0RO3A/tarIbp/RaXNNJGyxojgtnx6wRKgUYdW36b9wgpTD
         wKwUjx+JoIj9+wHeLpyQwgPgYXUnZfFEM3AWpOLIwOhViK/R6LA8j8blAepz3Itl/7yf
         tWuPcBzaT23qeyRFPnfCZzHYAebISE/KgPdsT5W/5tPvveeW14BCh6t9vHqjQWdyxSkN
         EYcBLchjkY95KmElO7tRPOndWMpdHv9PeOTAC5HNJ7zOQ2Kf12zmwFP92F4/qQul9Xgh
         kNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742047617; x=1742652417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu6S1gMTWBKKSz25cBF2A3XN/mQqBpDLU5UkcNDyaKE=;
        b=lrdjBgC9WUZydjHepJB8Wo4tDYySuf8AH3xzzv+ZM8eTj4M0ZPoS9bzcNemGoC1clt
         z7Bzwgquj1vOCHx4fFShFD6sdoCbQyP0fPBfJQIi6mIppdrZGlTxgJ+33uagwInTLj5Z
         ei6M3wTGTlZxHyPJ4Urkg9kgI5JEBKUcuHdPn3EpbRJVnXN5Z7rCDz6YdeMPcJBkDYVD
         vUvl/XPoRXIsQzgOV1z0hRgIQqunFekqrDuSRlYln0DhK1qkLoZKS1gLIHKgA5s+BAPx
         BdlPNTMyBMjR7t9Lv6MOL/bj8Fr0IUkVqei6v39xJLwmv8n+4M7Rpr3akNmVgIv+owAU
         jZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWcOLgra0WYH7CoSsp6Cw4X5d6k3aeDJN1q7axiMb5JRTffvyMyjqpeQ7PvYmIfaRLetpe4nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyYQBIxONZq3X00RcS3aAdzd+vZzlukhJBiIRQc+euJOG7uhV/
	DZksFwZjbyTo9/s/R4h7/d6dwmMaxhk1z5nWukNlMDbMDEDNNdS1
X-Gm-Gg: ASbGnctVl/Qo0KXsmaRcRTxjQrXFblUbKBOFHGQSUyDcxvYjS+cyVTYtKnzd9DwF7VQ
	wFWm5g+4NGfs59zOyD2wTBlCRawyl8QMpTI8kH8x22Fr3fTd2NV8z+FJI38mOGeMkyzhISAxjxk
	Lb/YbGr2DS/AiTM9YDPsQjru3Dpwyk2K82hWolSNPxuYKRgPNNlo6j/IUbxnGzouaRE7SOZt47C
	DiiUEWvnF1+YR07sUlQDuq+Gn370GQS+67QY8OS+HLJks4m1llxuQ0o4zINf3YqLkssECvOsYRR
	hW56P+pYo7rVRqRdGylYHWht8/BtYFgAx4Y04b7gWI66nL66gdPSqgoNV5ALSM84SxOFTCc4LVI
	fHA==
X-Google-Smtp-Source: AGHT+IFx4VLev9/ZgAGMtNB8wK/8e3AAjc3fTszFJmkBl77vfh+FSoCGptuIx+WDl8NiHsj9YK4mXg==
X-Received: by 2002:a17:907:3e06:b0:ac2:166f:42eb with SMTP id a640c23a62f3a-ac330110f59mr810161066b.2.1742047617447;
        Sat, 15 Mar 2025 07:06:57 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9bce7sm372338766b.164.2025.03.15.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 07:06:56 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CA3B5BE2DE0; Sat, 15 Mar 2025 15:06:55 +0100 (CET)
Date: Sat, 15 Mar 2025 15:06:55 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Message-ID: <Z9WJfyaaF1s_eJg_@eldamar.lan>
References: <20250220152450.1075727-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220152450.1075727-1-max.kellermann@ionos.com>

Hi,

On Thu, Feb 20, 2025 at 04:24:50PM +0100, Max Kellermann wrote:
> If multiple subrequests donate data to the same "next" request
> (depending on the subrequest completion order), each of them would
> overwrite the `prev_donated` field, causing data corruption and a
> BUG() crash ("Can't donate prior to front").
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/netfs/read_collect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index 8878b46589ff..cafadfe8e858 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -284,7 +284,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
>  				   netfs_trace_donate_to_deferred_next);
>  	} else {
>  		next = list_next_entry(subreq, rreq_link);
> -		WRITE_ONCE(next->prev_donated, excess);
> +		WRITE_ONCE(next->prev_donated, next->prev_donated + excess);
>  		trace_netfs_donate(rreq, subreq, next, excess,
>  				   netfs_trace_donate_to_next);
>  	}
> -- 
> 2.47.2

Unless I did some mistakes researching both the stable, netfs lists,
did this felt through the cracks and is still missing for to be picked
for the 6.12.y and 6.13.y series?

Regards,
Salvatore

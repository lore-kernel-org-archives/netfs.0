Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27C39847
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021017; cv=none; b=PMfFNK1jbNu3axwcWUUQU14kkhYSVdESwR3UTII3V62BNI/XamkrUJScn3i4BB/onHQIEJtcYTNp0AevIRcYN1PFgt7nbgyXk4WgO3jNr4J0IWKM1xbV5SWDr6tpQXdgpEfyJaHZ6cNF2xzNWxMTgoy3K3hPJe6GgaAhVwTexM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021017; c=relaxed/simple;
	bh=Pli5F8AnSKspK5aT0/lVVdtVxvdyhbgTwOdQGvsPv/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UR3fnjFn7CUgxwMbOyU+r2aGxtREZCEV62aBOg0zL+kPPQ3EjpJ3GiARNeb6vq6MFgRj4khOkCsRA5ofT8fqxXprpiREJCAcVGeZ1iUyn5Mz1kjdWRruNnD/IQtapYB8Q7lf8sPLzjrAWIIewB3JPnY9cYug/6D3TPO+g/iqHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PguOltQM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PguOltQM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecff9df447so618144b3a.1
        for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714021014; x=1714625814; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKeDMR/VAwY6KFTp7q+D4M4FMjxN7DS4mVLtRqQA6Ps=;
        b=PguOltQMRu9z/Tqw9diDfaIPJPkHhW4BJQRWJbZF5ThIDG9TvZZz0jpg70FtgKsJ4Q
         sEtI1GNdCFXxgJk3Ho9Vh2F0w0VPOvf1iLkUfcgsj9EDa5+ZshJQkfWzJkSqLm7mxJzk
         E1UDhtwMU+ZaRCpnuiXYZBnpvPQ0WdPTYVVVo8Ziw0OD/ycDFHqutL7BNUkpaxDQ5VOw
         y+pfOiGCh7uHYRd9QvGdf0AQmJ7X/AgeTjEe58gEuw4vhXGeKzC0xJP7IhmP0MgZvQWR
         2yDTHLcjPEKlfys8qc3gxC1k/KpIT0VLR3nB/R/zu7uofBcWpLhedf088UQKNSdOURg0
         ziZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714021014; x=1714625814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKeDMR/VAwY6KFTp7q+D4M4FMjxN7DS4mVLtRqQA6Ps=;
        b=O+8DHRiba8C26mz9pnPoIEvl1vrG5sJuykevv0Eyp2TY6V8mRfgSYwjJcFnPoMK+e8
         IZnwtpiqK5jA6A6MANIYFF9hVnx0anf5+F3QlJ5QUEUsxBueRzLtaiW/JF6EuKexrVUN
         QgMhiQXh2U0JGLOG7aKL/9HKG7SxFg9IGMWRImcMadO5UolGFGiFkJ1FrUEUQmz66TwH
         h1P89clJ7abA3+/Usl28BXVb6u7GvmY4VG9lEOtxpxYiOm/+HW6R6kcWTU9hvFGVLwiB
         Uxh3koyxdyxOlNuAmYyiTlnY2BezKlf3TN5dZFnz3oaPUZAxtk7J0BaQ2RaDYyu8R4+8
         2wzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU72A2N82I1Zhd7BAUToOBFahnnHv9KeOdaen1CwcTJ/eR6iWWge3562IE6pmm8sbmrvzmbRXYHeSoB4ZbU2HsG63+3PHs=
X-Gm-Message-State: AOJu0Yzl/mlSnpjzOV0hFHw2eCc5lwNjyM/mbQPnNv2beLtSXH3GD33O
	q3EMFRAlfxulE7766oH8BUB6LoVxR5/WEiQkEV3oOgsBZ9CArNblgLidQyhFwZE=
X-Google-Smtp-Source: AGHT+IFhv2H4/vzmguAbVa1ZZdUzUVWqiOvj6TC3VDCEFSUjKANEKZ1zNzViwGoIP2V0IpdAALwTxQ==
X-Received: by 2002:a05:6a20:840a:b0:1a7:7818:720e with SMTP id c10-20020a056a20840a00b001a77818720emr5781273pzd.21.1714021013910;
        Wed, 24 Apr 2024 21:56:53 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm6319376pji.22.2024.04.24.21.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 21:56:53 -0700 (PDT)
Message-ID: <32f04cea-1c41-4c16-98fb-86be6ecefc87@bytedance.com>
Date: Thu, 25 Apr 2024 12:56:47 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] cachefiles: Set object to close if ondemand_id < 0
 in copen
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zizhi Wo <wozizhi@huawei.com>,
 Baokun Li <libaokun1@huawei.com>, zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-11-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-11-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> If copen is maliciously called in the user mode, it may delete the request
> corresponding to the random id. And the request may have not been read yet.
> 
> Note that when the object is set to reopen, the open request will be done
> with the still reopen state in above case. As a result, the request
> corresponding to this object is always skipped in select_req function, so
> the read request is never completed and blocks other process.
> 
> Fix this issue by simply set object to close if its id < 0 in copen.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 7c2d43104120..673e7ad52041 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -182,6 +182,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   	xas_store(&xas, NULL);
>   	xa_unlock(&cache->reqs);
>   
> +	info = req->object->ondemand;
>   	/* fail OPEN request if copen format is invalid */
>   	ret = kstrtol(psize, 0, &size);
>   	if (ret) {
> @@ -201,7 +202,6 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   		goto out;
>   	}
>   
> -	info = req->object->ondemand;
>   	spin_lock(&info->lock);
>   	/* The anonymous fd was closed before copen ? */
>   	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
> @@ -222,6 +222,11 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   	wake_up_all(&cache->daemon_pollwq);
>   
>   out:
> +	spin_lock(&info->lock);
> +	/* Need to set object close to avoid reopen status continuing */
> +	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED)
> +		cachefiles_ondemand_set_object_close(req->object);
> +	spin_unlock(&info->lock);
>   	complete(&req->done);
>   	return ret;
>   }

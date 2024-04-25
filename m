Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6A1AACB
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015036; cv=none; b=ttc8enK1l5i7IkUBfcC9Ve1NUxsW31XHdDO9xCIwV+HHDbqGwbXBA/4LZQ8qQjaEJtLOwdN6fm6QN8PMFnHWjqH93v9IXKkZjZ/5mOPTkA02km2PHETr9pGgUTJRxYBbiRIZvNZxpmxFzAqINIJ7TRsTRKX4u98sc6EB1bWkgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015036; c=relaxed/simple;
	bh=pL8OHOWHZcsyFmPcEjc+fBoaOnXJeZNW3DcIFx6MFus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asjMZqGgir/TKpDaeRTkk70AcYskwbcAJemN153Fm3ryx0dd01XmFavANZm1WiD502upHWKqtCmI7nTtMOsUgw2AFsr9kbQfKVl2qykQeDO5OgwFRTK2xHE1DcAV9484FC7ELmgqWxp0RyuI4BNFB4NolREge/QR7gedl/geIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I49U2pvH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I49U2pvH"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so527479b3a.2
        for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714015034; x=1714619834; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDC6+MkZwtTiyGD4zhDwbs6EKw+Azk2OsJsJxDq9WIg=;
        b=I49U2pvHLs/J1eFvBwSDGhpAhcsWN5tL13ZO9j0eecFGlj6UPK2u15YFJ/beL/xx1l
         iM190rNzIq//V+DPJjNfr/DkQUroaV8h6iHk8yQ7R2FS6EqAbdSt8CyUYeYYpVWa5N3y
         f21KOQXRSI2FKwWIQzccFB27hPAbpNbK3KNp417tR5gxBN3+0c87O96yJwebnzTwF0KV
         Yr9ZRvVsf/d6Ya4mTh0PQM+cCs/2Ih5EvJH+iQga+5k7emgElUMvSHiZIQ0nbcHl4hBr
         EXzsBxa9C4JahWHIBygCpNCEVM7i+5Wo9tKOe1oGhb9PnPpuJD68FSxA7duFW9jb1jMA
         3Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015034; x=1714619834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rDC6+MkZwtTiyGD4zhDwbs6EKw+Azk2OsJsJxDq9WIg=;
        b=eUjMQ5+KwIXOzF6xb+VSVWaGcYccY7H7dhCk5fgo6YgihykZxY/Wt1hSQCapb0OBqT
         tnxmQHDNtqBbMlwRmb1/m28KaerjMefas/Gv4gyfH2TwLHEJZ0+45UTKiyBH5OC8rsx/
         Do8fMCCI02jZ5guMJYgRbGr6TfoxIoqmLTTae0ih5WjliTjRWSG5PwTEXLaKZvNQV+Al
         kC2mnylyeUWY7eNQFNoYepWzH95uUEbLJB8/V+W/euWPCVZc+CJvuatj3j24biLhsKHk
         J9gFPeCsNBzzARFdobvFFOu9p7paQAqXo2oTa6Q1P4ZxyMmYpRbPRHAdswGKyOb8uL7o
         DkeA==
X-Forwarded-Encrypted: i=1; AJvYcCXGSX2/teZ7tMlQyz3DTFvMDy1a04ZEbmzuLuDIY2zXBI6LmnRTDwxFACV6ZlkKIXZL3MDcsyyGO7TVTSdNd3vd/M9WklM=
X-Gm-Message-State: AOJu0YyRKXSMzASmcRZI0tTK84mhyeb1g1iAynx/JRQc+JBPN6MrWa7V
	9cpcRjTXtyIzxrqH0W9YLcKjnzvxjE6pZ22B2Iq6UktpwY+Oxb7/M4WrdaujebY=
X-Google-Smtp-Source: AGHT+IFsDUKcepwhTMfngbtOJkYdquZcdm/7+0FnSBhsRuUAiazYGUUz8MH7tc0XTEkAcFEoXbsTQw==
X-Received: by 2002:a05:6a21:3d89:b0:1ac:dead:1370 with SMTP id bj9-20020a056a213d8900b001acdead1370mr4849697pzc.21.1714015034157;
        Wed, 24 Apr 2024 20:17:14 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006edadf8058asm12160586pfh.23.2024.04.24.20.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:17:13 -0700 (PDT)
Message-ID: <9228a873-8250-4b63-bf75-473e9a87ab80@bytedance.com>
Date: Thu, 25 Apr 2024 11:17:08 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] cachefiles: remove err_put_fd tag in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-3-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-3-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The err_put_fd tag is only used once, so remove it to make the code more
> readable.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 4ba42f1fa3b4..fd49728d8bae 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	if (copy_to_user(_buffer, msg, n) != 0) {
>   		ret = -EFAULT;
> -		goto err_put_fd;
> +		if (msg->opcode == CACHEFILES_OP_OPEN)
> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
> +		goto error;
>   	}
>   
>   	/* CLOSE request has no reply */
> @@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	return n;
>   
> -err_put_fd:
> -	if (msg->opcode == CACHEFILES_OP_OPEN)
> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
>   error:
>   	xa_erase(&cache->reqs, id);
>   	req->error = ret;

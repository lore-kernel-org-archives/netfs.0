Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153B39FF2
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022146; cv=none; b=Ys8KMIKdYEvpekAn9gh+Yy80/sw/hsA2pyFg6kX/gepnPb2s+tMJ8vDZpTP2ZqbmHrcp58JcwveVAQa+xWVOn5aoPnzYLn+tBXYJlxMh1Yi9b9RQVxjVBrIfQAwGnSkYoMpLki/BDxz4ui7Uk0Ouo+i5AKS/R1qP13orZ8pyh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022146; c=relaxed/simple;
	bh=KMml6kOnTgP5A7N4cMeQuHkBnwThjTY+lkYFRv3m4lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kp9/SnWZITY8lDzunZEcCoIsPBJfq8he/7ichMxjPciscJwss4UdzZagyn26F+4pGJKSc4d4kpf04M9j6T+3Zpdr8Rv7fRWIUaVptgYC03lN3zzujExXskEKtaBKH7lJSCvT6MF8fYQep0mWwhrXcdDTRAIXWqtdlq6T5rWWoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OE0L5jes; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OE0L5jes"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eab16dcfd8so2897715ad.0
        for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714022143; x=1714626943; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
        b=OE0L5jesrU7G6qLCdfW7JaH6Xh0GL3UzFEGL/OTQ5O4B5xcbP4Xq6CAZSSeOZVtpy+
         V1tR3E5KMBxqa5cO6PO8WkZxA20rrJ1gzsQfcdrkQDXeMNd+9DBupLDXjEK0w7Ii//nj
         U+iqRfg8cp5kgV62MSi+M+eI1g8DzWxMbcVEhAgMsgeQ0Afi78ALjGaLDt1TsE4hwG4t
         Hrs+pSUe1akxdCARkMwhsTrl4/yXcAloMCOkEu3ZoY8Hry9HIWM90vzD+Fcm1LgL8C4X
         axYo5T7tZyHbJ7xYgwpRKTwrM+3BIw/Y5yfd+zJFbseicLYDgUCMOwLyO4c4wu6RL7sq
         9irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714022143; x=1714626943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
        b=iBVUAN5fFs0QztcFhOeGLsJJkRNGnRzrG6mQULPKOAOrZUZKfhvpsFSFFCCZZlcqbM
         r6YQMziFg/KTuiFswyFV4ZV5jT8cp/pFVr3eyxT0p84vHaUV+Mxs9IRy9sHJ7Pa4b8RC
         P5v6QK+INOp/oDXCVMHAcsq4/GVCTxmA8l5rFFlfjtKjTqRblzS79/Y6nhf5SIABfkx4
         WvRJH1SvAWuP63uvCcz85RwWY4cAHusXClaWTBV9ypt9+XASQqIVxNppukFmY5FXCYju
         rOSCFYuc6Uq6LRqbcgt6DC0ZJkwOlCJVTnALxrGb2YPbXTg4qmFGk+Q4caNwXAMC7dB0
         fT8g==
X-Forwarded-Encrypted: i=1; AJvYcCWoSsrA78+jKq24d68xLIGUx1MpRs1cBIahrOpyagiImq6tVqGYqQhUSeYktFpxo9n5xoABTCMPCDIMyalW4hkHlHYvTFA=
X-Gm-Message-State: AOJu0Yy1c5MSRgK2ej0m34dnINUTn4O5v9vZ1BogwKX1ia/996k51yBQ
	Ni2GBzVfZa7caR5+n1lLBeScuW3czNPbUXRZSaxVCVStc6lREy/j/A0HhPSKBvg=
X-Google-Smtp-Source: AGHT+IEQITLDZGcYmA+FjKYuiztsfCh0wLhqQI6Xcb/IceR3ZPd+qhouMoKXS2ZMMGdGKHN5UKg2Ig==
X-Received: by 2002:a17:903:41d0:b0:1e4:6243:8543 with SMTP id u16-20020a17090341d000b001e462438543mr5733230ple.5.1714022143006;
        Wed, 24 Apr 2024 22:15:43 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001e78d217fd9sm12826398plg.16.2024.04.24.22.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 22:15:42 -0700 (PDT)
Message-ID: <e1c97315-de7a-4222-9fd4-788e566b2eaa@bytedance.com>
Date: Thu, 25 Apr 2024 13:15:37 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] cachefiles: make on-demand read killable
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Hou Tao <houtao1@huawei.com>, zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-13-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-13-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Replacing wait_for_completion() with wait_for_completion_killable() in
> cachefiles_ondemand_send_req() allows us to kill processes that might
> trigger a hunk_task if the daemon is abnormal.
> 
> But now only CACHEFILES_OP_READ is killable, because OP_CLOSE and OP_OPEN
> is initiated from kworker context and the signal is prohibited in these
> kworker.
> 
> Note that when the req in xas changes, i.e. xas_load(&xas) != req, it
> means that a process will complete the current request soon, so wait
> again for the request to be completed.
> 
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 673e7ad52041..b766430f4abf 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -525,8 +525,25 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		goto out;
>   
>   	wake_up_all(&cache->daemon_pollwq);
> -	wait_for_completion(&req->done);
> -	ret = req->error;
> +wait:
> +	ret = wait_for_completion_killable(&req->done);
> +	if (!ret) {
> +		ret = req->error;
> +	} else {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			xas_store(&xas, NULL);
> +			ret = -EINTR;
> +		}
> +		xas_unlock(&xas);
> +
> +		/* Someone will complete it soon. */
> +		if (ret != -EINTR) {
> +			cpu_relax();
> +			goto wait;
> +		}
> +	}
>   	cachefiles_req_put(req);
>   	return ret;
>   out:

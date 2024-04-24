Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A672156877
	for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937618; cv=none; b=BoM+ebSuSJq6FjYMvCuu+4zunMHHWcqb0j5qxvKfxeDj17bU3Wi9W4/5BXnwg9qFAT7P5bm72vTwRNTaJhjFj5/p8v4vhP8ZNStXS7CjNriJaSLD9FruQwfXH4tjca/pkfcOFYs8B/rOLoiZZon9sRmZRgjaAnDD9ZS+Cpdce6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937618; c=relaxed/simple;
	bh=CF+ts3A4hUIMuGaFQFIzKuPMzImW0nVYFO6/BZ05kUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPmrShXjo+9l1eUhaRa660uyDg4og1mu2lyWOPM6XX2rI4Cj146TubHOTTMrZOhlm/GzvFVppD3bscvHiz2V9FWi4DNJW8EMTdgoW/j0mkCT47dGNI3EhihYaHqeGFxqLgvcL0gJ/7d9uIsibLHrb+2Zc4OhmtYOeDyCdRKAdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LvIODA/R; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LvIODA/R"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c70ef25e19so3323311b6e.3
        for <netfs@lists.linux.dev>; Tue, 23 Apr 2024 22:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713937615; x=1714542415; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oav/nBjbNQkJSHj491t5Rtmwwi8lc2zcpFduDWDdqHo=;
        b=LvIODA/RCQsfNHxfFVvq+7BNF/NXai9jZyITfKFfFKoQYP0PE9WZEKKdEj1hWqLTOO
         XJI36dteOmwxylkELsBlfS8rhknb1BryFNqXa6C1xOxK5WEeFKWoCnxS6RdfZ94zDmty
         PDoIcvAHoRn4PVFtCijJROOHFEhy48zQhloF/Gc34jFl0b9swqE5fbtqCKzikQHAIOIg
         RkNF2r1/eLQM767JlBsYQvLM6z0pd37cdD6UJxSXTBTdM98tnvDvvmr/GCThia5WN4RK
         DsVA5LP0MRxKA7EygqTqGzZyTxLHwOoyNLFD802fJUuOt5IomJceVQr+c9lClp8mxdJ0
         MprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937615; x=1714542415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oav/nBjbNQkJSHj491t5Rtmwwi8lc2zcpFduDWDdqHo=;
        b=AKzH3rF+K2MKE9FYLFGy20SOtrF3H3y/3QQT9QNEoFG/typv344RN3rRpoeNbOYZlb
         5vtufYT+B0t8GBHpf7EmSZG0tW3YtKntIv50XWQZz0grpr2MffrHO3k6upFm5bqsfqdr
         GyHUo3vdyLLAXlZmS8AVJg5hmDg7/rJfA+5Tt3Ri93rRWYmOGWj6k1h3f8NYarGzfkoV
         U/auUo414u22RnhE1u/RNyoIboYDR6knBMjPaXHZ//XgfpLoMsQsh8aWOVSCVUkvagI7
         e2mxCqkbzBbKPTqhRz/+U6/JoOC+zeFVpesmy9B2MoVuXNNP1SzOsYF6WwuzomBSeJIq
         OwKA==
X-Forwarded-Encrypted: i=1; AJvYcCUSjTuK5pmRHE+WMnQvzWqNa+cLjD1c2CJf49RelPVhvltYgWU4ILML7qfH9cJJ1lm4CyUL+vtK4/R8LFIGiEtcEDtOmwE=
X-Gm-Message-State: AOJu0YxsRR//C2JNh42Chi2K60lWxK91cZMRCcYpF2YU91zy3fQg/4U5
	uo+YfVJulxGzJ7EJIHY4br4XXEUfUjepSrl5s+2+ZTnyqhfJLfy3FxlZXceddWk=
X-Google-Smtp-Source: AGHT+IGXNptk+olxPRJcLAW0W9h984MMeb0Lybawe6fqDXiy7gt7eKH1E3YmxBnctdni7giQ3i6BUw==
X-Received: by 2002:a05:6808:170e:b0:3c6:6e1:b166 with SMTP id bc14-20020a056808170e00b003c606e1b166mr1792336oib.28.1713937615179;
        Tue, 23 Apr 2024 22:46:55 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b006eae2d9298esm10560634pfu.194.2024.04.23.22.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:46:54 -0700 (PDT)
Message-ID: <a2593b0a-1ddc-4f87-8b6d-68900fdcf612@bytedance.com>
Date: Wed, 24 Apr 2024 13:46:47 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cachefiles: add missing lock protection when polling
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Baokun Li <libaokun1@huawei.com>
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-6-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033409.2735257-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Add missing lock protection in poll routine when iterating xarray,
> otherwise:
> 
> Even with RCU read lock held, only the slot of the radix tree is
> ensured to be pinned there, while the data structure (e.g. struct
> cachefiles_req) stored in the slot has no such guarantee.  The poll
> routine will iterate the radix tree and dereference cachefiles_req
> accordingly.  Thus RCU read lock is not adequate in this case and
> spinlock is needed here.
> 
> Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for catching this.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/daemon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..73ed2323282a 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -365,14 +365,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
>   
>   	if (cachefiles_in_ondemand_mode(cache)) {
>   		if (!xa_empty(&cache->reqs)) {
> -			rcu_read_lock();
> +			xas_lock(&xas);
>   			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
>   				if (!cachefiles_ondemand_is_reopening_read(req)) {
>   					mask |= EPOLLIN;
>   					break;
>   				}
>   			}
> -			rcu_read_unlock();
> +			xas_unlock(&xas);
>   		}
>   	} else {
>   		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))

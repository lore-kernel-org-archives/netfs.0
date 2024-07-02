Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BC16B39C
	for <netfs@lists.linux.dev>; Tue,  2 Jul 2024 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923490; cv=none; b=rm4Wz0MR7a+m59vqS9GD5YnSUxkLwzgIZl2uiXGoqRM4OcpkNl0r1JzhNRSinZ/UCw4ZUNC/FrVpd19IZXrhII9rFaSy9IP9APzytI+EJ4omkbx0Sst5y7M6TM72hZS6cBaaDyWYtYW2rrKaWxTcg8kvBUDDEFkFUqA22i6vseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923490; c=relaxed/simple;
	bh=OMjHScwuQiZI5JvirqGlQaaKEsUp8flpn2XkS8V236E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTCac7+Oj0oiKUj/nRTP+GpvcCidmcg0GLXGBY0yUjjgWTuIGQ77Mt2i6zmS5l86QTSiYAO7p+GU4HcsEvU3YSe1LyljOIoNDXJfBq32zdLhfgw0F2Z6hiZrf2bxNGJmXedjC4A87WeAisSA0tpmYTobx5JifdHaTVnGc7H/I6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NWz99Xcj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NWz99Xcj"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso2595189a91.2
        for <netfs@lists.linux.dev>; Tue, 02 Jul 2024 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719923487; x=1720528287; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3bJl13ZaEh9srzSiGBUxKF7FnUSAqn8fdJDDL2oxlc=;
        b=NWz99XcjT458jrq5Z5TH+AGDa0W6zjXyi2u9j+b9OrMwG+b0RPuHFVuewUo2zGVrqi
         u2OirW3LcudfDtCqUvql9ZcFXOoO851tgEbr7amC2gzCB9vQoKmVMWymd6XM59vcipq/
         2iwfYpBtMUdbcCTDUqgBm0319HEZN1vGI8doLqjmVnmEqDJ96hq/8kLxvlOcfTnMIFyg
         lEuzQwnq7dNAdc4eXdYsbQX0wsRadgRpaBuRJft4AgeD+mk67gy9MhH8vUz48Ae0qluM
         HzGuPsr8pAw60GAMnIQkC/U0U5fVAKE/fmzBsayM+111kHboWNIhecaPaqK5mQxie9zS
         ygzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923487; x=1720528287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3bJl13ZaEh9srzSiGBUxKF7FnUSAqn8fdJDDL2oxlc=;
        b=DZ7r/95zYvIKUf5M4BGQYe5degNjJnUkKQMmN+TsmusRV2oHu0GmXVvX6RBMJo5aBX
         3eoShyTeJKsVbYkbiueZ+z2C5cST/RD++RJTyYmIEf44weBsXRhYhDEOMEbi/bwuFlRO
         IF89S6q/n9Hs9VyxWWkF+0Woa5mjgIOksKk9+FfEUmqn/w2sCMaGFRTXzAoKpdq6xtOR
         h8eBgQ5qhn6dLl8cW0SdEzhcPRMhyNAv+e2KVJHR6lPSoPWatqiqfWbSDsKecFcL6FVK
         g9yeqWV813d73L+9zHc5xfRg2Gj9jOrTvNFgIesibNlb2OW67UgBIh6NteIMGxzBXvSC
         8IXg==
X-Forwarded-Encrypted: i=1; AJvYcCXhOSJ9ZvwxHGLnx7V55yU/2pw1e7zrsNOs0dPsO5qTHhDz6hKNYppLm8rDHlsVi1zNcNqCoeMzpNmcf5MBjeAAJDrYMRc=
X-Gm-Message-State: AOJu0YyAgcv8Zu0gm5DLmgJjiQ/Hvq5SvxhOih237TusJpKo+9PGNr9v
	tY9Xuw2utptJkIlo67f/EhR4YAktVkBwDskBL33f3/UFWNyBT/69mmQdIg423/l8ODTCgJLm5XM
	m
X-Google-Smtp-Source: AGHT+IEQmgs/v36TUzW9XWoPCZpKUIq41uJJFgwIz5VYPSN0CR6cvSwMrpKZEhWHqcEZfDk9htY4FA==
X-Received: by 2002:a17:90b:2dca:b0:2c9:57a4:a8c4 with SMTP id 98e67ed59e1d1-2c957a4baa0mr1358052a91.42.1719923487273;
        Tue, 02 Jul 2024 05:31:27 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce432dasm8743605a91.17.2024.07.02.05.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:31:26 -0700 (PDT)
Message-ID: <a5c8edce-a314-4321-b2fb-4ed2dfeea481@bytedance.com>
Date: Tue, 2 Jul 2024 20:31:18 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 6/9] cachefiles: cancel all requests for the
 object that is being dropped
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>, zhujia.zj@bytedance.com
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-7-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240628062930.2467993-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/28 14:29, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Because after an object is dropped, requests for that object are useless,
> cancel them to avoid causing other problems.
> 
> This prepares for the later addition of cancel_work_sync(). After the
> reopen requests is generated, cancel it to avoid cancel_work_sync()
> blocking by waiting for daemon to complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 8a3b52c3ebba..36b97ded16b4 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -669,12 +669,31 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
>   
>   void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   {
> +	unsigned long index;
> +	struct cachefiles_req *req;
> +	struct cachefiles_cache *cache;
> +
>   	if (!object->ondemand)
>   		return;
>   
>   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>   			cachefiles_ondemand_init_close_req, NULL);
> +
> +	if (!object->ondemand->ondemand_id)
> +		return;
> +
> +	/* Cancel all requests for the object that is being dropped. */
> +	cache = object->volume->cache;
> +	xa_lock(&cache->reqs);
>   	cachefiles_ondemand_set_object_dropping(object);
> +	xa_for_each(&cache->reqs, index, req) {
> +		if (req->object == object) {
> +			req->error = -EIO;
> +			complete(&req->done);
> +			__xa_erase(&cache->reqs, index);
> +		}
> +	}
> +	xa_unlock(&cache->reqs);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,

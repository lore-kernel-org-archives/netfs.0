Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541931741DC
	for <netfs@lists.linux.dev>; Tue,  2 Jul 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923393; cv=none; b=b6yqSYibBLM459HCP6t1SMzhI+SzLELlJCPvs1ykpqJbPDt/qJb7XS7NopTNjs/vetwmbTXdnfN1lCMmpgxNDNfQGhg/ZErb5y2rsEOoZw0f1hbzTJ6pPip+9RutLnF/XYZjBJbUphTVCGchKNPgLbQt235HZmaE2co7RXuNL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923393; c=relaxed/simple;
	bh=r+MVQVyGKSk4SBH+Wd7DCDCPj5zC0ZFnMe5ASYCco8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8VublWDGs8DOO4NebxzH31mu3zmag55kzNJmakP4ncHOP4xINNBOlskjRyolGY+q+4xlr7G9vwvqtzf309zc7SI9zzVahGF06DkUqoRhBE6NgVgju4bm0lfTROkZ/FhDKhRJ6paGR6KDkzfbknozTN7wzMAOz5JANW3kvgax3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KDkYq1BZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KDkYq1BZ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70abb539f41so1928942b3a.2
        for <netfs@lists.linux.dev>; Tue, 02 Jul 2024 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719923390; x=1720528190; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qoWo7LK1MBUf7Ek/NbpXFpCCMF0xO5+B4OHWe9xZak=;
        b=KDkYq1BZKsTTW3iPA6dhSG2rU8ViqtAn/oA0XDG2Jgioa2dZZGvGEew1eA8tZctvis
         J0Z2QwRR9q+YAH74ycDwynsskyOde+Puv+Q72L5xHhm05NjsnKkZ3zSNfVat/Df5xL7W
         EMYzoMMnWxywDDfvyV89QkKl3CgjyQHAKMs0Zp6yPJjaXjxejvIWrUqPRdGPYpW9oKh2
         iqO1Rwt0GcDqRXb4lROx+iI37KLlfjKaYquoi0mx4ZR4U0qaz8zkC6jtLDdVzejCPq5w
         KnD6v0xfJ/kUaskeLTnc7SVrdBXkyvPP0lmcvGAZEO6PGHlgmQXnM99wJ7oI7Q8ru+FO
         uXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923390; x=1720528190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qoWo7LK1MBUf7Ek/NbpXFpCCMF0xO5+B4OHWe9xZak=;
        b=PFU9NoyySiRtE3/a56pSjG6q8ietzvOwUTzy26WCnZo1VGZfG1M2UHm9cU9OiMeLtb
         4HTLghYhkQ8crhQyHk+aZuWoxYlYaONA2kBO24xJxi29U9d0ZgZ5eBdaXBtPMMBG3P1d
         g0IEhKL8ZQCvXZgXT2PJAlBelHANr/SWMByRZNalZd6wUgOV18Cxo+mB+ZWk+xaZrpQp
         ZY+YmjwS7wlQicoNVOlSIw/VbLZUVr+RIyCzXfsgAZzZ6mBn/O+UPrJMBpKzkeIm5X3E
         IMr1kRmEuRcDQK1GbG2HTM2gjTPZYo91OU0JwzdOh8SXFXB8X6Qtl1oWQnK1BVJNz49l
         bmrw==
X-Forwarded-Encrypted: i=1; AJvYcCVc61lZWMnhB3lLJmU64nZ0vs4t5Sr6bfM+PYLDE+Y7ltL4XFzwMcqUlWaJDR/fjfXAMHtM1g5m9N2AYY5+ns/7pgYO9gU=
X-Gm-Message-State: AOJu0YxQXoEUaeQEng1H3B1My1lKbqr6dyJR20z6qEVffGkdl2pllnV3
	Y39F4rT1Mj8+//3YyCXQfuad2tnRVXgP/CLVAGJ1AsfKk/Tupc4f4ZSmfdpjvwczJea9ZEXrYQ0
	w
X-Google-Smtp-Source: AGHT+IHJjOmbGv3nMlY5xA5nReKwCC+9X/1gT2v0Ln7U8fmaF5LI6r20bPQGA8L6C0NsTtIhJ5COlQ==
X-Received: by 2002:a05:6a00:1944:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-70aaad2c0f3mr11867186b3a.5.1719923390615;
        Tue, 02 Jul 2024 05:29:50 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac1e1sm8374995b3a.163.2024.07.02.05.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:29:49 -0700 (PDT)
Message-ID: <20375364-9147-4079-9f25-8ed8d9ebc057@bytedance.com>
Date: Tue, 2 Jul 2024 20:29:42 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 5/9] cachefiles: stop sending new request
 when dropping object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>, zhujia.zj@bytedance.com
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-6-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240628062930.2467993-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/28 14:29, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Added CACHEFILES_ONDEMAND_OBJSTATE_DROPPING indicates that the cachefiles
> object is being dropped, and is set after the close request for the dropped
> object completes, and no new requests are allowed to be sent after this
> state.
> 
> This prepares for the later addition of cancel_work_sync(). It prevents
> leftover reopen requests from being sent, to avoid processing unnecessary
> requests and to avoid cancel_work_sync() blocking by waiting for daemon to
> complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/internal.h |  2 ++
>   fs/cachefiles/ondemand.c | 10 ++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 6845a90cdfcc..a1a1d25e9514 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -48,6 +48,7 @@ enum cachefiles_object_state {
>   	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
>   	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
>   	CACHEFILES_ONDEMAND_OBJSTATE_REOPENING, /* Object that was closed and is being reopened. */
> +	CACHEFILES_ONDEMAND_OBJSTATE_DROPPING, /* Object is being dropped. */
>   };
>   
>   struct cachefiles_ondemand_info {
> @@ -335,6 +336,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>   CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
>   CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
>   CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
> +CACHEFILES_OBJECT_STATE_FUNCS(dropping, DROPPING);
>   
>   static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
>   {
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index bce005f2b456..8a3b52c3ebba 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -517,7 +517,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		 */
>   		xas_lock(&xas);
>   
> -		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
> +		    cachefiles_ondemand_object_is_dropping(object)) {
>   			xas_unlock(&xas);
>   			ret = -EIO;
>   			goto out;
> @@ -568,7 +569,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   	 * If error occurs after creating the anonymous fd,
>   	 * cachefiles_ondemand_fd_release() will set object to close.
>   	 */
> -	if (opcode == CACHEFILES_OP_OPEN)
> +	if (opcode == CACHEFILES_OP_OPEN &&
> +	    !cachefiles_ondemand_object_is_dropping(object))
>   		cachefiles_ondemand_set_object_close(object);
>   	kfree(req);
>   	return ret;
> @@ -667,8 +669,12 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
>   
>   void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   {
> +	if (!object->ondemand)
> +		return;
> +
>   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>   			cachefiles_ondemand_init_close_req, NULL);
> +	cachefiles_ondemand_set_object_dropping(object);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,

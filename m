Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892816728B
	for <netfs@lists.linux.dev>; Tue,  2 Jul 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923706; cv=none; b=cn2gEf31e9G7jdIy9CuG2d35Z0fXIhBhHfeiiFR96vkgduFgbT/ycxK1TOEUoY1vhhPQxSELjbg/t2A5JhWqVZazH/5tNthk9KYAn/0+zD0uHxE8y447GdWIyIY/H8Cd1CGpZUsDZ2ZWajYsRXUPmr95LLlJgSJLyvJSzO+twt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923706; c=relaxed/simple;
	bh=CYAdJeB+CqncFSyqJi1YrjNIbpA52qv/O23+hWZWLAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6W/GAx2OZIXHC/9kJ7WKiVoU8dgAuvzmKFn2V75tO86VjU7PoKmlamjt5ikWMTxEeS/4y3Q4ckSlCrv08+hlpN/stRDWf2Ky2TONwbIOuQhuMu6qzoG2xQXPP5u0AE9AbNQjNgLBVSrZUxRqM3DQb1AJ4OPDwNLyV5M57+hHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TbyFU9cL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TbyFU9cL"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9ffd24262so23555675ad.0
        for <netfs@lists.linux.dev>; Tue, 02 Jul 2024 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719923704; x=1720528504; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2VzYQ+j8+6iQewLkeQCbIq09NlR4ehs8d7s9IHNlCc=;
        b=TbyFU9cLyg6ktvP6FIguWjrl1vrnced4x+VruHhIzWjeFXJB5cFsl4HFkCIpIbOlDo
         y7rUrmP3q0XF7TkLkTACan9hlWcI08abnWIMI8PATUtbpMNA4127AzknU3/6zD5uV3z6
         XoOk7kt3oGShdrWZv1CL2ntucNwxyxfCP/U3rqSAgG8T+w3Z5NiXXXUu4k/lEIuD0Efo
         zPWoG44gfFU6dcy+md4JuhEhsCFwC35uEyw8Vl/6456SLLN+papIj/4q8BUpZXrTzcGG
         KqOwx+lHS4pCSnKqOJUJnuBqh467GG15kf/CB3T/MVFAQF65bQZyVydbqdVRd2vd59jz
         lVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923704; x=1720528504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t2VzYQ+j8+6iQewLkeQCbIq09NlR4ehs8d7s9IHNlCc=;
        b=CYRIXyhvEncN7cv3LJU3nlqsIhPj075XIO0wdtlFXK91PRdfjcdKX9gSVymh07YA0j
         QbpO6R8H4awgV6zponCQE/OA8HNWRbCvMDOUCRAeZhWJcm+jBRYV1OaiJ/+DgtywMExh
         ceFIZRgBsQ/tA2BcNq/0S/PosAEw19hl7332ROvRChf1hiE8iHdAw9Xnu9FvXNoZ4Eiq
         MG6XeOSPxum7idWfQW38Vx0agrZkfnfTrfjPFyfZOlfgjn+zYgb8EsV1R15vSy6r4uM4
         ojZ3yOkdBJzAXPRaQocSC6/c9W8Wsyj7kewRjbP9Y6wyWSieNKO8aN8JLsp6bv/rkfy3
         rESA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOHx/q9CE1GVEszsiEoHK8/M4z5vMQcBoBEY/j7xPeXyPosY56IGmashVNeqyZDCpb0sp36ScyA67LOrQeruUpS8eCJ0=
X-Gm-Message-State: AOJu0Yz378qw22cgiJIHkEJaikM86vZTJm/1b3ZIb5hJFLz5y8l107j2
	oxTPHdqR1QO7uGU3DDElWh3sN3emW23UjnSwWgIdmMIqIcxvEbH1HQsWQXor2pE=
X-Google-Smtp-Source: AGHT+IHQnoogWURs/kZMnk2ajJRFjETen6Zlw109v1iQySDinr13mF+vbirF+SJ/r8hNYxe5uKUJlA==
X-Received: by 2002:a17:902:e80f:b0:1f9:ddb9:3ee5 with SMTP id d9443c01a7336-1fadbc85f8dmr67450555ad.26.1719923703933;
        Tue, 02 Jul 2024 05:35:03 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d9685sm83027985ad.111.2024.07.02.05.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:35:02 -0700 (PDT)
Message-ID: <616a1162-233e-46a9-98e8-cfac36426a2b@bytedance.com>
Date: Tue, 2 Jul 2024 20:34:56 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 8/9] cachefiles: cyclic allocation of msg_id
 to avoid reuse
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>, zhujia.zj@bytedance.com
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-9-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240628062930.2467993-9-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/28 14:29, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Reusing the msg_id after a maliciously completed reopen request may cause
> a read request to remain unprocessed and result in a hung, as shown below:
> 
>         t1       |      t2       |      t3
> -------------------------------------------------
> cachefiles_ondemand_select_req
>   cachefiles_ondemand_object_is_close(A)
>   cachefiles_ondemand_set_object_reopening(A)
>   queue_work(fscache_object_wq, &info->work)
>                  ondemand_object_worker
>                   cachefiles_ondemand_init_object(A)
>                    cachefiles_ondemand_send_req(OPEN)
>                      // get msg_id 6
>                      wait_for_completion(&req_A->done)
> cachefiles_ondemand_daemon_read
>   // read msg_id 6 req_A
>   cachefiles_ondemand_get_fd
>   copy_to_user
>                                  // Malicious completion msg_id 6
>                                  copen 6,-1
>                                  cachefiles_ondemand_copen
>                                   complete(&req_A->done)
>                                   // will not set the object to close
>                                   // because ondemand_id && fd is valid.
> 
>                  // ondemand_object_worker() is done
>                  // but the object is still reopening.
> 
>                                  // new open req_B
>                                  cachefiles_ondemand_init_object(B)
>                                   cachefiles_ondemand_send_req(OPEN)
>                                   // reuse msg_id 6
> process_open_req
>   copen 6,A.size
>   // The expected failed copen was executed successfully
> 
> Expect copen to fail, and when it does, it closes fd, which sets the
> object to close, and then close triggers reopen again. However, due to
> msg_id reuse resulting in a successful copen, the anonymous fd is not
> closed until the daemon exits. Therefore read requests waiting for reopen
> to complete may trigger hung task.
> 
> To avoid this issue, allocate the msg_id cyclically to avoid reusing the
> msg_id for a very short duration of time.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/internal.h |  1 +
>   fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
>   2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index a1a1d25e9514..7b99bd98de75 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -129,6 +129,7 @@ struct cachefiles_cache {
>   	unsigned long			req_id_next;
>   	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
>   	u32				ondemand_id_next;
> +	u32				msg_id_next;
>   };
>   
>   static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1d5b970206d0..470c96658385 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -528,20 +528,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		smp_mb();
>   
>   		if (opcode == CACHEFILES_OP_CLOSE &&
> -			!cachefiles_ondemand_object_is_open(object)) {
> +		    !cachefiles_ondemand_object_is_open(object)) {
>   			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
>   			xas_unlock(&xas);
>   			ret = -EIO;
>   			goto out;
>   		}
>   
> -		xas.xa_index = 0;
> +		/*
> +		 * Cyclically find a free xas to avoid msg_id reuse that would
> +		 * cause the daemon to successfully copen a stale msg_id.
> +		 */
> +		xas.xa_index = cache->msg_id_next;
>   		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
> +		if (xas.xa_node == XAS_RESTART) {
> +			xas.xa_index = 0;
> +			xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
> +		}
>   		if (xas.xa_node == XAS_RESTART)
>   			xas_set_err(&xas, -EBUSY);
> +
>   		xas_store(&xas, req);
> -		xas_clear_mark(&xas, XA_FREE_MARK);
> -		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> +		if (xas_valid(&xas)) {
> +			cache->msg_id_next = xas.xa_index + 1;
> +			xas_clear_mark(&xas, XA_FREE_MARK);
> +			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> +		}
>   		xas_unlock(&xas);
>   	} while (xas_nomem(&xas, GFP_KERNEL));
>   

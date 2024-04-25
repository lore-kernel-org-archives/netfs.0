Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576218E02
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016555; cv=none; b=WoKTJ5VrzOSWodfPtEp8tbkVUFzPFaYpadytbOfC+rg3QIlWaq5Mhnla/i9qDm2+zuaPfAie1ALICskLtZkd31TUNOwWB8VFSmKJac0F6Tc9pKGU/BUfe+qHmWZRYo17indfkBWqKfKNJvowc+cmKPY4aK98ReRosvs6ffalUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016555; c=relaxed/simple;
	bh=SZZ/RMEMGHASsfDcKZ20F0oiNNZaJ4DafWTiVLPLgVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/M6GlaV0pTPsHTkwOxihFB2CvEO0wNBv6jCLAzttrkCOZNjHoAGCaORVKVdNx0Z7JprZS2mE7NGnJGDWvqX6X1xHZuIwklbDQCH+lWiPJvAxw2fnLZ39vBqY8U7KG+dZequNNvqAU3vlYUKR2m3qp59L2Mxwey7DvbxLOypuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UlzRw0OY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UlzRw0OY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ece8991654so570519b3a.3
        for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714016554; x=1714621354; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFC/YaLZv7yQ0eyRd7w4YHDkBUmQZEf/nvPZ7CB9pC8=;
        b=UlzRw0OYBx29fDDTHYJ1uW085BW6FVm+F+PXEmwTVY+puy5dwDB/H70nDHTyFI++ea
         C64MtpNGJXTPQoQoCAkv/m5u66c8PofW4C7XWKQQFSubdSm8DGBNBurzbSPW8yBT8MVL
         mO6Woy+mwR8nIwOeFvXqMGcPJO/MFmOxFZEwSkP+if4/srWpRb69RDCdEfqVexzr7olp
         Nnbf8BaCiJ24KH73KwRjfFmSsFU81rBeJsKzZmmYn7Xie/OFQoqAElhKhDqimQw6327Q
         KwXWckw0yqWvzJxQYN26f8O14/gZjdN9fW1s1CXg/iNIZ5oO3my/XrL+JPFgszxcblOF
         Tllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714016554; x=1714621354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TFC/YaLZv7yQ0eyRd7w4YHDkBUmQZEf/nvPZ7CB9pC8=;
        b=V44B73klr8zl2NxoKRvbTlZysBb04DI9M9cGE+jd5G5BVmNyk5M2TkPLg5n+tJJrij
         WE8mRycipUgu247ptNMKODPbFkr3iTptegntcPySXP5N9J/WgN/wd8tY/f0LJIdC1d6L
         VXoTfLidQ5dAMOydJRVx0I7NYF3kZJ6s3tdXWTojzp+bLN9GJ/xjjC8a1wdze8Hw/fRD
         QOCEbFKneeAgn9tgjxiYL+obTPwjbtJu+pF7rq45xX1TLv+ZjwuLv/QAUcgIpRCXr/WU
         GM3AytosglLO4m8e1WUQ1jb8r/usZxe1bGwsrBOxNNZhRZ3EcZl3SKYkGgbcKsnyaLxI
         u6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT5YuCqZ+yHN7USaTmfZ5bbblOvV3kEP1wJmfhQhR/1HcMWTdHxF56nGZaQSzLdYmdjzMIERCmENI4YUjjhRzZBmBcNbg=
X-Gm-Message-State: AOJu0YwaliE9qvBaQNFRIfNqrZakY2mcxa0Mcs/vIxfWPonzOi9zK0w0
	qsR5PS6epQFovML/GQojBhAcQiRuUcdUbIaUzWHjm/Lec6fjvj1q+YOgaM6je1w=
X-Google-Smtp-Source: AGHT+IGDHeAbOWt5xjIMSRHX9LP133pX+NDtWq9rTdN4bteCp1aM+6ZXUcBnQZVGw2+uRdMca/c7UA==
X-Received: by 2002:a05:6a00:148d:b0:6ea:9252:435 with SMTP id v13-20020a056a00148d00b006ea92520435mr6295917pfu.30.1714016553835;
        Wed, 24 Apr 2024 20:42:33 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id i28-20020a63585c000000b005d5445349edsm11743801pgm.19.2024.04.24.20.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:42:33 -0700 (PDT)
Message-ID: <c359d4d3-5aff-4536-983d-87af3198724d@bytedance.com>
Date: Thu, 25 Apr 2024 11:42:28 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH 04/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-5-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-5-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We got the following issue in a fuzz test of randomly issuing the restore
> command:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0xb41/0xb60
> Read of size 8 at addr ffff888122e84088 by task ondemand-04-dae/963
> 
> CPU: 13 PID: 963 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #564
> Call Trace:
>   kasan_report+0x93/0xc0
>   cachefiles_ondemand_daemon_read+0xb41/0xb60
>   vfs_read+0x169/0xb50
>   ksys_read+0xf5/0x1e0
> 
> Allocated by task 116:
>   kmem_cache_alloc+0x140/0x3a0
>   cachefiles_lookup_cookie+0x140/0xcd0
>   fscache_cookie_state_machine+0x43c/0x1230
>   [...]
> 
> Freed by task 792:
>   kmem_cache_free+0xfe/0x390
>   cachefiles_put_object+0x241/0x480
>   fscache_cookie_state_machine+0x5c8/0x1230
>   [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>       mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
> cachefiles_withdraw_cookie
>   cachefiles_ondemand_clean_object(object)
>    cachefiles_ondemand_send_req
>     REQ_A = kzalloc(sizeof(*req) + data_len)
>     wait_for_completion(&REQ_A->done)
> 
>              cachefiles_daemon_read
>               cachefiles_ondemand_daemon_read
>                REQ_A = cachefiles_ondemand_select_req
>                msg->object_id = req->object->ondemand->ondemand_id
>                                    ------ restore ------
>                                    cachefiles_ondemand_restore
>                                    xas_for_each(&xas, req, ULONG_MAX)
>                                     xas_set_mark(&xas, CACHEFILES_REQ_NEW)
> 
>                                    cachefiles_daemon_read
>                                     cachefiles_ondemand_daemon_read
>                                      REQ_A = cachefiles_ondemand_select_req
>                copy_to_user(_buffer, msg, n)
>                 xa_erase(&cache->reqs, id)
>                 complete(&REQ_A->done)
>                ------ close(fd) ------
>                cachefiles_ondemand_fd_release
>                 cachefiles_put_object
>   cachefiles_put_object
>    kmem_cache_free(cachefiles_object_jar, object)
>                                      REQ_A->object->ondemand->ondemand_id
>                                       // object UAF !!!
> 
> When we see the request within xa_lock, req->object must not have been
> freed yet, so grab the reference count of object before xa_unlock to
> avoid the above issue.
> 
> Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c          | 2 ++
>   include/trace/events/cachefiles.h | 6 +++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 56d12fe4bf73..bb94ef6a6f61 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -336,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>   	cache->req_id_next = xas.xa_index + 1;
>   	refcount_inc(&req->ref);
> +	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
>   	xa_unlock(&cache->reqs);
>   
>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
> @@ -355,6 +356,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   			close_fd(((struct cachefiles_open *)msg->data)->fd);
>   	}
>   out:
> +	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
>   	/* Remove error request and CLOSE request has no reply */
>   	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>   		xas_reset(&xas);
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index cf4b98b9a9ed..119a823fb5a0 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
>   	cachefiles_obj_see_withdrawal,
>   	cachefiles_obj_get_ondemand_fd,
>   	cachefiles_obj_put_ondemand_fd,
> +	cachefiles_obj_get_read_req,
> +	cachefiles_obj_put_read_req,
>   };
>   
>   enum fscache_why_object_killed {
> @@ -127,7 +129,9 @@ enum cachefiles_error_trace {
>   	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
>   	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>   	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
> -	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
> +	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
> +	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
> +	E_(cachefiles_obj_put_read_req,		"PUT read_req")
>   
>   #define cachefiles_coherency_traces					\
>   	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\

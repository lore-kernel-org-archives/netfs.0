Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477A3BBD6
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023689; cv=none; b=USDAz4GzpkbRLIv4ZUzz2C2Ng9JQzqwEjOU/8ddDh+JoklSx6p4Wz67YCQk1uNLo6qnDoXG3TH3Stz4Eb3+4w/vJz40TmLvciB57YRCapXWL3BIr0H4JP4tiDj+OnflqdvqwvjdeRPQIhLL5Bsf4oelDI5EsC1rmlGx4ACPCJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023689; c=relaxed/simple;
	bh=EJTC3wowI1j2u2TKzcLePfke7haCbSp9UOfnO38aLsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr15xLxMrpFXf+UYgNpUipC0YM8ePnve5/pertBm7TI2Yw8w6fyJABpFUUKwcJdLEiCuO0/VmswnyDx5TYN3Rezk1Emws6QHnFFpPZcaOEvZGTlSUIqVVHOdLb4PHUpbpedlH/1OSd0h9bxwMXnSHQWyLUtMZcNV0/S/MtZOooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OHZOG3cO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OHZOG3cO"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso597185b3a.2
        for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714023687; x=1714628487; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiVVv+CXcN+CvM+zB+3igsIJaaE0zH8C5SDY181CcQk=;
        b=OHZOG3cOQ+J20dpBocRZLJ45uGdz8x4aNTf5EeteQQ/ZdPvLSLr+6uAPzJ/A93tXpL
         wKFqotM+2I9ucjH3nCJTuZOAQ3F9W7IEeOVlqfwUFHN+VGDrvjnc58hzpuSq+l2RMG5r
         btRaBcjcgcnrur1UK3Y4Upe+mMMRzVzn+VhBC+EUo0s/Jblc65MJByelUJbQa2qgT9/z
         owqCrQPMz1ghGcS5LZMbqPf6GrhZNbIaTnIT+waYX2PsaoACUCRZhmj+v6aygketD/Ox
         bABsSQc4EyY1a6VKtSxHA7BrjbDGeelE8PoIyq3dz2DI+O2zmuLdPf8TK3SXaA65Ea+C
         SylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023687; x=1714628487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiVVv+CXcN+CvM+zB+3igsIJaaE0zH8C5SDY181CcQk=;
        b=P3qnV6cVqkzYRKC1atMzfVdJOp2YQRnXeDOOs+VIz6bmnGJXjt4E2PoHyoKkKv+bXf
         Rv79lqCKB87XHzB9dKnjB9eO5iOVYY1zKiVV7Ik5ZQCFOBLH6ryO63GLPpw7kwjE3pvG
         hSMImFqf/n39RxH+tMjZvGDEo4uDZySP+SrZJ4k0CquM/nCKFzVxFTaNgdegZRYTIKPX
         1ocAWCG7HaEFHhc7o/aX+MtcZYV64nFGlobB0w431dyiDw1w5bVJEU8uJPG+j8rYNeoL
         uSKFXrYqYDqAxUT0DMTFkPiat2TXWomMcGijY4A1UCYiNx8ujGPujOXy/5pIKeRc4r8L
         tFaA==
X-Forwarded-Encrypted: i=1; AJvYcCWuCrvb4dpHitAot2b0WwTYKvJrEw+l7u3yi5uAQiDbrpx+d7JTlfqavdq4DkZwGdLcA/A50SGs1WBeJKbGILoC7OryuzI=
X-Gm-Message-State: AOJu0YyKRD/Yyr2JHfRQ1v7dIEQ629BHFqlG5YfuieoVlz8iFY47lgxL
	R4pyZwpL4LRlfjR8qnaw8WCfJdnFYe3JxP4Xl+xeZ8P1A9J7r5/ORwZwiBDn8/8=
X-Google-Smtp-Source: AGHT+IHNJBsklbaNtuhephdNcHI3SdblGcDt0X5IXkyJ+9Sg3RqlYnd4/Js8ZPm7qlkq9lbveXh7Sg==
X-Received: by 2002:a05:6a00:1492:b0:6ed:1c7:8c5d with SMTP id v18-20020a056a00149200b006ed01c78c5dmr5655256pfu.12.1714023687307;
        Wed, 24 Apr 2024 22:41:27 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm12333974pfr.38.2024.04.24.22.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 22:41:26 -0700 (PDT)
Message-ID: <8572a732-ca12-48d7-817c-d8218d536c0c@bytedance.com>
Date: Thu, 25 Apr 2024 13:41:20 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cachefiles: flush ondemand_object_worker during clean
 object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>, Baokun Li <libaokun1@huawei.com>,
 zhujia.zj@bytedance.com
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-4-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033409.2735257-4-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for catching this. How about adding a Fixes tag.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>


在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
> From: Hou Tao <houtao1@huawei.com>
> 
> When queuing ondemand_object_worker() to re-open the object,
> cachefiles_object is not pinned. The cachefiles_object may be freed when
> the pending read request is completed intentionally and the related
> erofs is umounted. If ondemand_object_worker() runs after the object is
> freed, it will incur use-after-free problem as shown below.
> 
> process A  processs B  process C  process D
> 
> cachefiles_ondemand_send_req()
> // send a read req X
> // wait for its completion
> 
>             // close ondemand fd
>             cachefiles_ondemand_fd_release()
>             // set object as CLOSE
> 
>                         cachefiles_ondemand_daemon_read()
>                         // set object as REOPENING
>                         queue_work(fscache_wq, &info->ondemand_work)
> 
>                                  // close /dev/cachefiles
>                                  cachefiles_daemon_release
>                                  cachefiles_flush_reqs
>                                  complete(&req->done)
> 
> // read req X is completed
> // umount the erofs fs
> cachefiles_put_object()
> // object will be freed
> cachefiles_ondemand_deinit_obj_info()
> kmem_cache_free(object)
>                         // both info and object are freed
>                         ondemand_object_worker()
> 
> When dropping an object, it is no longer necessary to reopen the object,
> so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
> to complete.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/cachefiles/ondemand.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index d24bff43499b..f6440b3e7368 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -589,6 +589,9 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   		}
>   	}
>   	xa_unlock(&cache->reqs);
> +
> +	/* Wait for ondemand_object_worker() to finish to avoid UAF. */
> +	cancel_work_sync(&object->ondemand->ondemand_work);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,

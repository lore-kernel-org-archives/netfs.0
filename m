Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC544315D
	for <netfs@lists.linux.dev>; Mon,  6 May 2024 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964124; cv=none; b=Ivrnim6dh/NytKCvOqWUs9b8WB0d1AhaCTpNqo7RduA6vPfAIJXv3IgbSNizTaFDYCKPyy0Md0bjByGw+XBJ09lUHmA93BqIMbhJnKEzE8DRJ9NP0BzJ5e+g70WK5JFKUVRNxjQNLsVhn3U8vfmel9bqnbxEdU/u34UudxDOaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964124; c=relaxed/simple;
	bh=r98WbCzUrGnt3BRZgXs7GZM08gFSR7Lrf/VwzO1OCxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXq3ZnDAfvtP+hA/9/RpKUxQeCVPzzrwf3PPisyL2f/FN6o/7huyRONTNCb/KZO2mLSrcY145QuYRfltH/vMTf1pBpvN1+ZN0r7KckDJWIyBQ/PQrU1OxK3FMqKR8ENtsDb2YipKUL/RDpUL+87voN4CdXPBsv+d88gmgwjPSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GHzmEqED; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GHzmEqED"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714964113; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CrGqcZcLJICyMvWF8rZt/qyUDBdQ3CBU+SFKDUkHkkY=;
	b=GHzmEqEDhYcUGO+e4iQIddjYRG4L0cbBvFJYVCMTj+3wiKZ86YzSbqLaxuwejHJy1AnkJB/hhzL7ErHYScmYRXIMXJdirECd2Ff2IrW0FZCSGVwPJ26eu4TGOhsMh8bSr/Vyio75Zjr/eQvIhQYSBLOq8R23hqJzxxz4kyOe9AA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5q-rOV_1714964110;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5q-rOV_1714964110)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 10:55:11 +0800
Message-ID: <1fef9ab5-ec33-4a14-beb3-ada41a8652b3@linux.alibaba.com>
Date: Mon, 6 May 2024 10:55:09 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] cachefiles: add spin_lock for
 cachefiles_ondemand_info
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-8-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-8-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The following concurrency may cause a read request to fail to be completed
> and result in a hung:
> 
>            t1             |             t2
> ---------------------------------------------------------
>                             cachefiles_ondemand_copen
>                               req = xa_erase(&cache->reqs, id)
> // Anon fd is maliciously closed.
> cachefiles_ondemand_fd_release
>   xa_lock(&cache->reqs)
>   cachefiles_ondemand_set_object_close(object)
>   xa_unlock(&cache->reqs)
>                               cachefiles_ondemand_set_object_open
>                               // No one will ever close it again.
> cachefiles_ondemand_daemon_read
>   cachefiles_ondemand_select_req
>   // Get a read req but its fd is already closed.
>   // The daemon can't issue a cread ioctl with an closed fd, then hung.
> 
> So add spin_lock for cachefiles_ondemand_info to protect ondemand_id and
> state, thus we can avoid the above problem in cachefiles_ondemand_copen()
> by using ondemand_id to determine if fd has been released.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

This indeed looks like a reasonable scenario where the kernel side
should fix, as a non-malicious daemon could also run into this.

How about reusing &cache->reqs spinlock rather than introducing a new
spinlock, as &cache->reqs spinlock is already held when setting object
to close state in cachefiles_ondemand_fd_release()?

> ---
>  fs/cachefiles/internal.h |  1 +
>  fs/cachefiles/ondemand.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 7745b8abc3aa..45c8bed60538 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -55,6 +55,7 @@ struct cachefiles_ondemand_info {
>  	int				ondemand_id;
>  	enum cachefiles_object_state	state;
>  	struct cachefiles_object	*object;
> +	spinlock_t			lock;
>  };
>  
>  /*
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 898fab68332b..b5e6a851ef04 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -16,13 +16,16 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>  	struct cachefiles_object *object = file->private_data;
>  	struct cachefiles_cache *cache = object->volume->cache;
>  	struct cachefiles_ondemand_info *info = object->ondemand;
> -	int object_id = info->ondemand_id;
> +	int object_id;
>  	struct cachefiles_req *req;
>  	XA_STATE(xas, &cache->reqs, 0);
>  
>  	xa_lock(&cache->reqs);
> +	spin_lock(&info->lock);
> +	object_id = info->ondemand_id;
>  	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
>  	cachefiles_ondemand_set_object_close(object);
> +	spin_unlock(&info->lock);
>  
>  	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
>  	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
> @@ -127,6 +130,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  {
>  	struct cachefiles_req *req;
>  	struct fscache_cookie *cookie;
> +	struct cachefiles_ondemand_info *info;
>  	char *pid, *psize;
>  	unsigned long id;
>  	long size;
> @@ -185,6 +189,14 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  		goto out;
>  	}
>  
> +	info = req->object->ondemand;
> +	spin_lock(&info->lock);

> +	/* The anonymous fd was closed before copen ? */

I would like describe more details in the comment, e.g. put the time
sequence described in the commit message here.

> +	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
> +		spin_unlock(&info->lock);
> +		req->error = -EBADFD;
> +		goto out;
> +	}
>  	cookie = req->object->cookie;
>  	cookie->object_size = size;
>  	if (size)
> @@ -194,6 +206,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	trace_cachefiles_ondemand_copen(req->object, id, size);
>  
>  	cachefiles_ondemand_set_object_open(req->object);
> +	spin_unlock(&info->lock);
>  	wake_up_all(&cache->daemon_pollwq);
>  
>  out:
> @@ -596,6 +609,7 @@ int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
>  		return -ENOMEM;
>  
>  	object->ondemand->object = object;
> +	spin_lock_init(&object->ondemand->lock);
>  	INIT_WORK(&object->ondemand->ondemand_work, ondemand_object_worker);
>  	return 0;
>  }

-- 
Thanks,
Jingbo

Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749313DBA0
	for <netfs@lists.linux.dev>; Thu, 23 May 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474529; cv=none; b=pcb35KPI+euOCK9lw6UKON6iYHrZjGWY2YDtDwY6tKfuge9TbDxJg0/wKZBYJX2TwQv9VxbwW5cMTvx24+s3WPW6lASjv4HSeHa1lVYe3jS0PrfIUsujb23wZyGmKw/Y9xRyJ9PoFUEm2XEXLfOvAvjKy4VaStLfZRQF4NewNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474529; c=relaxed/simple;
	bh=YRzIZV+8IYLn+F4nAiVNJuRhYPZ1yBzoJnVmLoTmfFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVQp178oxjI27vtPMKJL0g5A/EsFowBVNB/2VS0MtvVKJT5d+blMJS/PS/x9eB8+39tvOA05RoEBECUUOprm5pDPBgfpSBei5Y8GD3WrutEUL1QiHsAMmz3+YFTMvq01T/bRq5r+yEkht43U4xmLeYOlnSntyhJL0MMptND2R7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pqlvxgCI; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pqlvxgCI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716474523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9wPJMsA7uUhGJBy9UQb2/zbE2MRvDozVPDCHZoma3hs=;
	b=pqlvxgCIOI5o9dB3XK5gyt1UAyhflc3P2qlqzJRGsSBghtHe9YD/DfvD4Mmwk+0Q4uOj6dJ0SnxpzQ6ANrV6TrWYXHwpm2E7HFkNAwMi+DToyV3pZV/YGlHodpWmJh4Up3ManIdoarILHggZYdSvQOImrZKM6lOzsPGrT3YPBZQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W739OVi_1716474521;
Received: from 30.39.171.189(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W739OVi_1716474521)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 22:28:43 +0800
Message-ID: <11f10862-9149-49c7-bac4-f0c1e0601b23@linux.alibaba.com>
Date: Thu, 23 May 2024 22:28:41 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] cachefiles: add consistency check for
 copen/cread
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-7-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240522114308.2402121-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/24 7:43 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This prevents malicious processes from completing random copen/cread
> requests and crashing the system. Added checks are listed below:
> 
>   * Generic, copen can only complete open requests, and cread can only
>     complete read requests.
>   * For copen, ondemand_id must not be 0, because this indicates that the
>     request has not been read by the daemon.
>   * For cread, the object corresponding to fd and req should be the same.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index bb94ef6a6f61..898fab68332b 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -82,12 +82,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
>  }
>  
>  static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
> -					 unsigned long arg)
> +					 unsigned long id)
>  {
>  	struct cachefiles_object *object = filp->private_data;
>  	struct cachefiles_cache *cache = object->volume->cache;
>  	struct cachefiles_req *req;
> -	unsigned long id;
> +	XA_STATE(xas, &cache->reqs, id);
>  
>  	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
>  		return -EINVAL;
> @@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
>  
> -	id = arg;
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
> +	    req->object != object) {
> +		xa_unlock(&cache->reqs);
>  		return -EINVAL;
> +	}
> +	xas_store(&xas, NULL);
> +	xa_unlock(&cache->reqs);
>  
>  	trace_cachefiles_ondemand_cread(object, id);
>  	complete(&req->done);
> @@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	unsigned long id;
>  	long size;
>  	int ret;
> +	XA_STATE(xas, &cache->reqs, 0);
>  
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
> @@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	if (ret)
>  		return ret;
>  
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	xas.xa_index = id;
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
> +	    !req->object->ondemand->ondemand_id) {

For a valid opened object, I think ondemand_id shall > 0.  When the
copen is for the object which is in the reopening state, ondemand_id can
be CACHEFILES_ONDEMAND_ID_CLOSED (actually -1)?

Otherwise looks good to me.


-- 
Thanks,
Jingbo

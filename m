Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4461096F
	for <netfs@lists.linux.dev>; Mon,  6 May 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962995; cv=none; b=X8fZtwEU4hnSWZwJzYxvyfy1AO1FhvsFJtjk60J1vSA5UkIYXoe8Nus/NUoekFIIn05pbMccay9DP5qdGklCbW4BVMUnW4Q5/JiC7rHb/f8nBrXZzGcdynAyyd9OLr4UX1EW/+ec+IDVPoe5rddBKa07w18CjVnhVKiHPbnyU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962995; c=relaxed/simple;
	bh=2pFWK0MLTTo2t+NIWJC3RactBtGq7GIQL3dy2XWRsr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR1SGCdTRVZsjq+PF+sWETT1M8udqyhgGQ3QKY0JlVQpCyf3KyAaZXkF7a/0m3lTKTPofJr+AAgSeHlbUm8Sw+QxtqQiSy8yQqsjk2QubJt6TnNnsNqr6AK/mEWYcPK9amS3H/38XmhJ59qJxSDpRPFSZPEpmHMrVjkltsBslKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cOFmtrMZ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cOFmtrMZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714962984; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ob0YO4yjvcUQvEjXT5JdBhT5d+S7+Y7wcj+uRXLaRgQ=;
	b=cOFmtrMZ8ucmQxgTD0+uJT/fV4//o8P8v7hXjhpL7SQVcWFGmZUdf8fE9qgCLdz1cwYMTsfufWhjfJJHDIFm6TwZay8V/7Zhn9n9M512jdEmPrv1gvOTdnxwjk/Ev5DfVrDmTRXPEZLW2yvAvXobTfLwPWVirQt6Tg/NT4rxD+Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5pq6Lp_1714962665;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5pq6Lp_1714962665)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 10:31:06 +0800
Message-ID: <75566e68-bb5f-4458-8140-a59f263cc98a@linux.alibaba.com>
Date: Mon, 6 May 2024 10:31:04 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] cachefiles: add consistency check for copen/cread
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-7-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Baokun,

Thanks for improving on this!

On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
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
> +		xa_unlock(&cache->reqs);
>  		return -EINVAL;
> +	}
> +	xas_store(&xas, NULL);
> +	xa_unlock(&cache->reqs);
>  
>  	/* fail OPEN request if copen format is invalid */
>  	ret = kstrtol(psize, 0, &size);

The code looks good to me, but I still have some questions.

First, what's the worst consequence if the daemon misbehaves like
completing random copen/cread requests? I mean, does that affect other
processes on the system besides the direct users of the ondemand mode,
e.g. will the misbehavior cause system crash?

Besides, it seems that the above security improvement is only "best
effort".  It can not completely prevent a malicious misbehaved daemon
from completing random copen/cread requests, right?

-- 
Thanks,
Jingbo

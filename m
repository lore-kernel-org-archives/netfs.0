Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A23FBFC
	for <netfs@lists.linux.dev>; Mon, 20 May 2024 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171809; cv=none; b=K/fd9WKNQNA7H5LSl1hR5BYGvKIhHBzC54gEXbnWVA+bv/IChJyHQ/xxFdFfMUICvw/Uk21Dq2SAWxPRl/Sg/KsGPslDEngKQm4OCJM/8VJI/14j7fLBC8XDaQG7zkCCNQG6uj44gt+sDpXDX2C+lpKQFuxTDeQ3qKjhS1Coo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171809; c=relaxed/simple;
	bh=njWqcNmwlWZ3UnC83e7dXn6VIIIQZA+GOMTX4QtwrBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIZyeG53gXE6XRDFafhy04bHqsc6DerLWZf11MDcBtwqizCLHua1i5Aq6vssbDnEycBfOrtP6cuqfyMi/Z7BDK9rNDrx13IQKX2t66j3CT9s4gX8j3k33mH2ujv4Wu+0tq3lCvgne2DmS0V57plvbSvbHLvNXpxUH6luElbiNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eIaUpmR2; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eIaUpmR2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716171805; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ytlcCUx8NfcUiSo9PNtjhqXUj4OMWJVp78FGSlWTWKA=;
	b=eIaUpmR2IaRoK+euSg8uue/7AO/p0/wq0vzvoIi3qO5orokZcA64hQ9QEfe5j8hPNGESFYbbFd/ZsZHjOUkiIAPo5Lr1E5QVSN4Ua8Ppdye7bXw7q0HZj79PitqBt7v3IR6naYljEyFib0hDws/ezUx8XucpsDSbsXXpbWVyZ6I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6kn7oV_1716171803;
Received: from 30.97.48.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6kn7oV_1716171803)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 10:23:24 +0800
Message-ID: <38b601b0-6a6d-4465-9137-85a59c6c2c71@linux.alibaba.com>
Date: Mon, 20 May 2024 10:23:21 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] cachefiles: remove err_put_fd tag in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-3-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-3-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/15 16:45, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The err_put_fd tag is only used once, so remove it to make the code more

The err_put_fd label ..

Also the subject line needs to be updated too.  ("C goto label")

> readable.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/cachefiles/ondemand.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 4ba42f1fa3b4..fd49728d8bae 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	if (copy_to_user(_buffer, msg, n) != 0) {
>   		ret = -EFAULT;
> -		goto err_put_fd;
> +		if (msg->opcode == CACHEFILES_OP_OPEN)
> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
> +		goto error;
>   	}
>   
>   	/* CLOSE request has no reply */
> @@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	return n;
>   
> -err_put_fd:
> -	if (msg->opcode == CACHEFILES_OP_OPEN)
> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
>   error:
>   	xa_erase(&cache->reqs, id);
>   	req->error = ret;

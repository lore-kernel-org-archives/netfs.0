Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7E2D051
	for <netfs@lists.linux.dev>; Mon,  6 May 2024 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967728; cv=none; b=l466RRyWdbw8Mu3SYISFVlR8E8N/Tg75T/G/iTeEzD2ydS+Ly1KNz/ttjJav6KOFKaDze2t8s0BcKWMr95j0BXn3DsQme5JDXk0aFBav86dohCcfHuazAFpsroxlX4h0+riRKGY6bHtsUaV87/DWnzFFll84r1W6c8MQYlRXhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967728; c=relaxed/simple;
	bh=y2geqQG7esbioHge/Oua716DR+VeDMua5Od5GLNV/Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvyZLB9j4zPvF1/MO1XeN04RhWAxjFnfv3SZ7YXQ+4rKP/aG2fyuauzIQGuvGzgzyNvsIkz9nYimz0d4NwOR4by0JYHLvtwho8dl7Go15VX4xqWNOeFkrKnwtqhPWuWVWxskIr3T3VJCHuvGJHD2FZAiqfwu6WOt7yc7lAxz+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d/BVEp7q; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d/BVEp7q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714967718; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zXslB2LIBpz38Ehk6jluQligrVVUBz1/x6XUjpfeVMs=;
	b=d/BVEp7q9JT4mYgq+2kov6S5ndtBeoIqtlA4YbBf0waJAwzYrBcWuVdPBzdTnXc2FtrtqkkHOk00yHH1XLyS1fcMNlEvu/BsQUu1nG4igJN4DpIyAib4RlNGzjZeh6xW9PQRJ5X1ET3gWeDy6LkV88L6jFqk34X7i0JAxFnsMOo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5rxNPa_1714967716;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5rxNPa_1714967716)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 11:55:17 +0800
Message-ID: <795cd804-f7a1-44ba-99ac-01070edd5a9a@linux.alibaba.com>
Date: Mon, 6 May 2024 11:55:15 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] cachefiles: remove err_put_fd tag in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-3-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-3-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The err_put_fd tag is only used once, so remove it to make the code more
> readable.

I think it's a conventional style to put error handling in the bottom of
the function so that it could be reused.  Indeed currently err_put_fd
has only one caller but IMHO it's only styling issues.

By the way it seems that this is not needed anymore if patch 9 is applied.

> ---
>  fs/cachefiles/ondemand.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 4ba42f1fa3b4..fd49728d8bae 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  
>  	if (copy_to_user(_buffer, msg, n) != 0) {
>  		ret = -EFAULT;
> -		goto err_put_fd;
> +		if (msg->opcode == CACHEFILES_OP_OPEN)
> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
> +		goto error;
>  	}
>  
>  	/* CLOSE request has no reply */
> @@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  
>  	return n;
>  
> -err_put_fd:
> -	if (msg->opcode == CACHEFILES_OP_OPEN)
> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
>  error:
>  	xa_erase(&cache->reqs, id);
>  	req->error = ret;

-- 
Thanks,
Jingbo

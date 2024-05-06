Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5F4206C
	for <netfs@lists.linux.dev>; Mon,  6 May 2024 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965901; cv=none; b=u7LQgJ0Rln45cRZYNt5tYzGE2Mn6nEwfS1WUyzJxGwmlsy1WbxP7B6Ekrnd5bqBgt+sYRGIOkdwLMlGBB3IDH+nITWh7g+SuNL/dh/PW2oiu2h+ZjBuIYSea4ULGzDYfjFq9bvBax1JjMVk/BabH46UUsRHpCdS1zqwSQt9ut0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965901; c=relaxed/simple;
	bh=P1kq2c1CRRDOHcjDbU8AaDeUbjddlldj1FWo0XXY45Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4FqXXipr/yB3lqKfK/FTFPZUKrISdZ6836EokXl5zdkphsGDhRgK+F5z4ADlzPF1jAFh2b0DJXdmFD6X7oYxRIcmDB5Tb4UOIVaVJBbPSjZFUn+DsZ508MF480QxHOvtlgwLqURM98E8qULmErdV/yKFc1DqIUp4ENxro0358w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cMQ+O6bK; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cMQ+O6bK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714965896; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RbpIXs9H/Hma1wu6wHG4qOKSeBDxPsWHGvGGKe6YJWs=;
	b=cMQ+O6bKAiCEGTJQCetdPtBuRNQr8HGta48Ek7eUEkWDKKRSEMYTlsw7CyITT/61VES8Suf5CVvbDEJ3d6H7XiGY3OaCZA23fNNRvqyqogi2tu0MUmjq8Tp2zvHVcIXgVKSBTmek5gKsCAg1UmkR8BEBnqo30am3zkLXWNUdnvc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W5rS6Bn_1714965893;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5rS6Bn_1714965893)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 11:24:55 +0800
Message-ID: <e0fc24d5-49c5-4a75-86f9-43adc763066f@linux.alibaba.com>
Date: Mon, 6 May 2024 11:24:52 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] cachefiles: defer exposing anon_fd until after
 copy_to_user() succeeds
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Hou Tao <houtao1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-10-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-10-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> After installing the anonymous fd, we can now see it in userland and close
> it. However, at this point we may not have gotten the reference count of
> the cache, but we will put it during colse fd, so this may cause a cache
> UAF.

Good catch!

> 
> To avoid this, we will make the anonymous fd accessible to the userland by
> executing fd_install() after copy_to_user() has succeeded, and by this
> point we must have already grabbed the reference count of the cache.

Why we must execute fd_install() after copy_to_user() has succeeded?
Why not grab a reference to the cache before fd_install()?

> 
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 0cf63bfedc9e..7c2d43104120 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -4,6 +4,11 @@
>  #include <linux/uio.h>
>  #include "internal.h"
>  
> +struct anon_file {
> +	struct file *file;
> +	int fd;
> +};
> +
>  static inline void cachefiles_req_put(struct cachefiles_req *req)
>  {
>  	if (refcount_dec_and_test(&req->ref))
> @@ -244,14 +249,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>  	return 0;
>  }
>  
> -static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
> +static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
> +				      struct anon_file *anon_file)
>  {
>  	struct cachefiles_object *object;
>  	struct cachefiles_cache *cache;
>  	struct cachefiles_open *load;
> -	struct file *file;
>  	u32 object_id;
> -	int ret, fd;
> +	int ret;
>  
>  	object = cachefiles_grab_object(req->object,
>  			cachefiles_obj_get_ondemand_fd);
> @@ -263,16 +268,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  	if (ret < 0)
>  		goto err;
>  
> -	fd = get_unused_fd_flags(O_WRONLY);
> -	if (fd < 0) {
> -		ret = fd;
> +	anon_file->fd = get_unused_fd_flags(O_WRONLY);
> +	if (anon_file->fd < 0) {
> +		ret = anon_file->fd;
>  		goto err_free_id;
>  	}
>  
> -	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
> -				  object, O_WRONLY);
> -	if (IS_ERR(file)) {
> -		ret = PTR_ERR(file);
> +	anon_file->file = anon_inode_getfile("[cachefiles]",
> +				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
> +	if (IS_ERR(anon_file->file)) {
> +		ret = PTR_ERR(anon_file->file);
>  		goto err_put_fd;
>  	}
>  
> @@ -281,15 +286,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  		spin_unlock(&object->ondemand->lock);
>  		ret = -EEXIST;
>  		/* Avoid performing cachefiles_ondemand_fd_release(). */
> -		file->private_data = NULL;
> +		anon_file->file->private_data = NULL;
>  		goto err_put_file;
>  	}
>  
> -	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
> -	fd_install(fd, file);
> +	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>  
>  	load = (void *)req->msg.data;
> -	load->fd = fd;
> +	load->fd = anon_file->fd;
>  	object->ondemand->ondemand_id = object_id;
>  	spin_unlock(&object->ondemand->lock);
>  
> @@ -298,9 +302,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  	return 0;
>  
>  err_put_file:
> -	fput(file);
> +	fput(anon_file->file);
> +	anon_file->file = NULL;
>  err_put_fd:
> -	put_unused_fd(fd);
> +	put_unused_fd(anon_file->fd);
> +	anon_file->fd = ret;
>  err_free_id:
>  	xa_erase(&cache->ondemand_ids, object_id);
>  err:
> @@ -357,6 +363,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	struct cachefiles_msg *msg;
>  	size_t n;
>  	int ret = 0;
> +	struct anon_file anon_file;
>  	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>  
>  	xa_lock(&cache->reqs);
> @@ -390,7 +397,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xa_unlock(&cache->reqs);
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
> -		ret = cachefiles_ondemand_get_fd(req);
> +		ret = cachefiles_ondemand_get_fd(req, &anon_file);
>  		if (ret)
>  			goto out;
>  	}
> @@ -398,10 +405,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	msg->msg_id = xas.xa_index;
>  	msg->object_id = req->object->ondemand->ondemand_id;
>  
> -	if (copy_to_user(_buffer, msg, n) != 0) {
> +	if (copy_to_user(_buffer, msg, n) != 0)
>  		ret = -EFAULT;
> -		if (msg->opcode == CACHEFILES_OP_OPEN)
> -			close_fd(((struct cachefiles_open *)msg->data)->fd);
> +
> +	if (msg->opcode == CACHEFILES_OP_OPEN) {
> +		if (ret < 0) {
> +			fput(anon_file.file);
> +			put_unused_fd(anon_file.fd);
> +			goto out;
> +		}
> +		fd_install(anon_file.fd, anon_file.file);
>  	}
>  out:
>  	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);

-- 
Thanks,
Jingbo

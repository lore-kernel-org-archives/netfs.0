Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E516079B
	for <netfs@lists.linux.dev>; Mon, 27 May 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816801; cv=none; b=GApobrlJfBgl2vgGDYw4g9ALx3hxwfT9NXVKOa2BYgM+LR3TFMtVy9y2aV2e0Qcqew+FDLlzEOFOfIaP4GGP8j1S/1owrNRTx6JnBsbwO5k2cL7OvJqoCx5qKrVdLgFcOwMgWtKf/Un+8yxCMQBAFHL1xYDJPJNG/VTBIPV7i60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816801; c=relaxed/simple;
	bh=cTo2Uf0K6KP8lhnU5XUXW1n0oSOX7ONtpZqRd7nMajs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcER8ceDNKxt/1wFtARPeLhDzBsVbs9bc3xCJSnPehltEZbRBcVHLDf74QVnY3ZfG0pqfYIISd0zr7/EKnXCVhmImDCeuaTbDdElEyqLPKaLPof7UnSPxrcyaXWEHJv7a4WdqDuRaEc78jPoqgmBMvSW5AfOzm0RN4tK79n98lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bJbJG6PM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bJbJG6PM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716816796; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QidiVXUMnt6iKGOAcp6fa76mjoIKCzmR0QWL2hdQF5E=;
	b=bJbJG6PMtEdGEXIWaS2zOc+mcb5wts/H2GddMQMXl1fwMFVHBdcHSNis5Ie5si3ZR2WeJ7r9Vl6qInyDvtH8kbeqjZgj25CBocoJv3OEywsL1mUwBwojw7aMIx+NGmFKd/2actD0F9NZLIsB9tM3BErzUaxgkk7Ipr8jDuhEbmA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7LT3at_1716816793;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7LT3at_1716816793)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 21:33:15 +0800
Message-ID: <0fbf98a5-bcb9-4276-bf41-62cd0401afc6@linux.alibaba.com>
Date: Mon, 27 May 2024 21:33:11 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] cachefiles: add consistency check for
 copen/cread
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-7-libaokun@huaweicloud.com>
 <11f10862-9149-49c7-bac4-f0c1e0601b23@linux.alibaba.com>
 <c2e331a1-8293-0055-3314-738530db3822@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <c2e331a1-8293-0055-3314-738530db3822@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/24/24 10:28 AM, Baokun Li wrote:
> Hi Jingbo,
> 
> Thanks for the review!
> 
> On 2024/5/23 22:28, Jingbo Xu wrote:
>>
>> On 5/22/24 7:43 PM, libaokun@huaweicloud.com wrote:
>>> From: Baokun Li <libaokun1@huawei.com>
>>>
>>> This prevents malicious processes from completing random copen/cread
>>> requests and crashing the system. Added checks are listed below:
>>>
>>>    * Generic, copen can only complete open requests, and cread can only
>>>      complete read requests.
>>>    * For copen, ondemand_id must not be 0, because this indicates
>>> that the
>>>      request has not been read by the daemon.
>>>    * For cread, the object corresponding to fd and req should be the
>>> same.
>>>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> Acked-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>   fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
>>>   1 file changed, 20 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>>> index bb94ef6a6f61..898fab68332b 100644
>>> --- a/fs/cachefiles/ondemand.c
>>> +++ b/fs/cachefiles/ondemand.c
>>> @@ -82,12 +82,12 @@ static loff_t
>>> cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
>>>   }
>>>     static long cachefiles_ondemand_fd_ioctl(struct file *filp,
>>> unsigned int ioctl,
>>> -                     unsigned long arg)
>>> +                     unsigned long id)
>>>   {
>>>       struct cachefiles_object *object = filp->private_data;
>>>       struct cachefiles_cache *cache = object->volume->cache;
>>>       struct cachefiles_req *req;
>>> -    unsigned long id;
>>> +    XA_STATE(xas, &cache->reqs, id);
>>>         if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
>>>           return -EINVAL;
>>> @@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct
>>> file *filp, unsigned int ioctl,
>>>       if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>>>           return -EOPNOTSUPP;
>>>   -    id = arg;
>>> -    req = xa_erase(&cache->reqs, id);
>>> -    if (!req)
>>> +    xa_lock(&cache->reqs);
>>> +    req = xas_load(&xas);
>>> +    if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
>>> +        req->object != object) {
>>> +        xa_unlock(&cache->reqs);
>>>           return -EINVAL;
>>> +    }
>>> +    xas_store(&xas, NULL);
>>> +    xa_unlock(&cache->reqs);
>>>         trace_cachefiles_ondemand_cread(object, id);
>>>       complete(&req->done);
>>> @@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct
>>> cachefiles_cache *cache, char *args)
>>>       unsigned long id;
>>>       long size;
>>>       int ret;
>>> +    XA_STATE(xas, &cache->reqs, 0);
>>>         if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>>>           return -EOPNOTSUPP;
>>> @@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct
>>> cachefiles_cache *cache, char *args)
>>>       if (ret)
>>>           return ret;
>>>   -    req = xa_erase(&cache->reqs, id);
>>> -    if (!req)
>>> +    xa_lock(&cache->reqs);
>>> +    xas.xa_index = id;
>>> +    req = xas_load(&xas);
>>> +    if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
>>> +        !req->object->ondemand->ondemand_id) {
>> For a valid opened object, I think ondemand_id shall > 0.  When the
>> copen is for the object which is in the reopening state, ondemand_id can
>> be CACHEFILES_ONDEMAND_ID_CLOSED (actually -1)?
> If ondemand_id is -1, there are two scenarios:
>  * This could be a restore/reopen request that has not yet get_fd;
>  * The request is being processed by the daemon but its anonymous
>     fd has been closed.
> 
> In the first case, there is no argument for not allowing copen.
> In the latter case, however, the closing of an anonymous fd may
> not be malicious, so if a copen delete request fails, the OPEN
> request will not be processed until RESTORE lets it be processed
> by the daemon again. However, RESTORE is not a frequent operation,
> so if only one anonymous fd is accidentally closed, this may result
> in a hung.
> 
> So in later patches, we ensure that fd is valid (i.e. ondemand_id > 0)
> when setting the object to OPEN state and do not prevent it
> from removing the request here.
> 
> If ondemand_id is 0, then it can be confirmed that the req has not
> been initialised, so the copen must be malicious at this point, so it
> is not allowed to complete the request. This is an instantaneous
> state, and the request can be processed normally after the daemon
> has read it properly. So there won't be any side effects here.
> 

case 1 is literally illegal, while case 2 is permissible but has no way
to be distinguished from case 1.  As the patch itself is only
best-effort, so it LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo

Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF12BE48
	for <netfs@lists.linux.dev>; Fri, 24 May 2024 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517715; cv=none; b=p1e8umNMslFYTzl48mDFsWMCbcpCg7SeyRs6m9MASttbc8doWEb5Bc8Gbws9nPCdcsi2ccDPD6dQK22l1g57K1+WSMGA8icB3Drt25SOzaPTbItPVaJIoidk5fph89+NOx3yRUt6iff5tOdg0K0rPVZ+IS7GeDxmGsGh167sYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517715; c=relaxed/simple;
	bh=H8aLNm5MJOA+vX46VpUQmOIxGGBQ5aeql+ZVGLNntL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaBHEzLSsp3PhOPg0HtwkzfiTONaVvHB3XUUrq+xRivxdb3kE34uD3GbJ7vYFKaeb9D4Pc34I82rYe/p1rG2rK9G5qkrAUfrgbf/zPmM+9I/wVsRVb1kvThWlkYsJcExG5oNkfFdxcl1q4oltYvtsneC063Pq36mhWLSpgNrwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vlpqj49RBz4f3jHW
	for <netfs@lists.linux.dev>; Fri, 24 May 2024 10:28:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 989DB1A0181
	for <netfs@lists.linux.dev>; Fri, 24 May 2024 10:28:26 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5G+09mNr8LNg--.19950S3;
	Fri, 24 May 2024 10:28:26 +0800 (CST)
Message-ID: <c2e331a1-8293-0055-3314-738530db3822@huaweicloud.com>
Date: Fri, 24 May 2024 10:28:22 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 06/12] cachefiles: add consistency check for
 copen/cread
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 libaokun@huaweicloud.com
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-7-libaokun@huaweicloud.com>
 <11f10862-9149-49c7-bac4-f0c1e0601b23@linux.alibaba.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <11f10862-9149-49c7-bac4-f0c1e0601b23@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5G+09mNr8LNg--.19950S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rCr4fWr45tw1xZF4fZrb_yoWrAF4rpF
	WayayakFy8uF1xKr97JF95W34Fy3s3AFsxWr93ta4UArnxur1Fvryft34UZF1UZwsYgr4I
	qw42gF9rGr1jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi Jingbo,

Thanks for the review!

On 2024/5/23 22:28, Jingbo Xu wrote:
>
> On 5/22/24 7:43 PM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> This prevents malicious processes from completing random copen/cread
>> requests and crashing the system. Added checks are listed below:
>>
>>    * Generic, copen can only complete open requests, and cread can only
>>      complete read requests.
>>    * For copen, ondemand_id must not be 0, because this indicates that the
>>      request has not been read by the daemon.
>>    * For cread, the object corresponding to fd and req should be the same.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Acked-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
>>   1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index bb94ef6a6f61..898fab68332b 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -82,12 +82,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
>>   }
>>   
>>   static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>> -					 unsigned long arg)
>> +					 unsigned long id)
>>   {
>>   	struct cachefiles_object *object = filp->private_data;
>>   	struct cachefiles_cache *cache = object->volume->cache;
>>   	struct cachefiles_req *req;
>> -	unsigned long id;
>> +	XA_STATE(xas, &cache->reqs, id);
>>   
>>   	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
>>   		return -EINVAL;
>> @@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>>   	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>>   		return -EOPNOTSUPP;
>>   
>> -	id = arg;
>> -	req = xa_erase(&cache->reqs, id);
>> -	if (!req)
>> +	xa_lock(&cache->reqs);
>> +	req = xas_load(&xas);
>> +	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
>> +	    req->object != object) {
>> +		xa_unlock(&cache->reqs);
>>   		return -EINVAL;
>> +	}
>> +	xas_store(&xas, NULL);
>> +	xa_unlock(&cache->reqs);
>>   
>>   	trace_cachefiles_ondemand_cread(object, id);
>>   	complete(&req->done);
>> @@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	unsigned long id;
>>   	long size;
>>   	int ret;
>> +	XA_STATE(xas, &cache->reqs, 0);
>>   
>>   	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>>   		return -EOPNOTSUPP;
>> @@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	if (ret)
>>   		return ret;
>>   
>> -	req = xa_erase(&cache->reqs, id);
>> -	if (!req)
>> +	xa_lock(&cache->reqs);
>> +	xas.xa_index = id;
>> +	req = xas_load(&xas);
>> +	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
>> +	    !req->object->ondemand->ondemand_id) {
> For a valid opened object, I think ondemand_id shall > 0.  When the
> copen is for the object which is in the reopening state, ondemand_id can
> be CACHEFILES_ONDEMAND_ID_CLOSED (actually -1)?
If ondemand_id is -1, there are two scenarios:
  * This could be a restore/reopen request that has not yet get_fd;
  * The request is being processed by the daemon but its anonymous
     fd has been closed.

In the first case, there is no argument for not allowing copen.
In the latter case, however, the closing of an anonymous fd may
not be malicious, so if a copen delete request fails, the OPEN
request will not be processed until RESTORE lets it be processed
by the daemon again. However, RESTORE is not a frequent operation,
so if only one anonymous fd is accidentally closed, this may result
in a hung.

So in later patches, we ensure that fd is valid (i.e. ondemand_id > 0)
when setting the object to OPEN state and do not prevent it
from removing the request here.

If ondemand_id is 0, then it can be confirmed that the req has not
been initialised, so the copen must be malicious at this point, so it
is not allowed to complete the request. This is an instantaneous
state, and the request can be processed normally after the daemon
has read it properly. So there won't be any side effects here.

-- 
With Best Regards,
Baokun Li


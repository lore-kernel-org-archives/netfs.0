Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00B5A10A
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027992; cv=none; b=SQgaCIB0nZIALWIRFhq0BGd+2MRKff1kWpdlJz/8p3hF8WBCfvHuyT/w6jIkEi+h2HeNyXFUq+7w2K+U6TGbeha+qeEkgS4u1P7JbObYPN2DrUopjWevIbNjJ35ue8GCEo7pKI9d47zhOgBMCwXWHvj3knlKukoNuIXt9RpMFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027992; c=relaxed/simple;
	bh=WBi/ZrNtZu3GF8PJnVE0tW9xrC6aEsYu+Aq/InrHVEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZFkqyMJRoWogaM4Z3MSqeOhhS2pN/vTWXD9sLwWMLvA4xxQAZ0bCB6PBODh5DwfF6aNhiYF8s1qiM51cKETAgHDvmldcfc6q2liyL/JETU/N8OeXQiDQ4QFhhXmlTelb6cOq2HDDfWvUVADO0utDEHk2X4j9Ei64hjlXijY3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQ64S625Rz4f3l1b
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 14:52:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1A06B1A11DD
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 14:53:06 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7O_Slm4WOeKw--.49376S3;
	Thu, 25 Apr 2024 14:53:05 +0800 (CST)
Message-ID: <7f379fde-a34d-163c-d965-651563e98327@huaweicloud.com>
Date: Thu, 25 Apr 2024 14:53:02 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/5] cachefiles: flush ondemand_object_worker during clean
 object
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>, libaokun@huaweicloud.com
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-4-libaokun@huaweicloud.com>
 <8572a732-ca12-48d7-817c-d8218d536c0c@bytedance.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <8572a732-ca12-48d7-817c-d8218d536c0c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7O_Slm4WOeKw--.49376S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDtr4rWF1UGryDAw48Crg_yoW5Cw15pF
	WfAFyUGry8Wr1kGr1DXF1UJry8tryUJ3WDXF1YqFyUJrn8Jr1jqr1UXr1qgF1UJr48Jr47
	Jr4UCr9rZr1UJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
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

Hi Jia,

On 2024/4/25 13:41, Jia Zhu wrote:
> Thanks for catching this. How about adding a Fixes tag.
>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
>
>
Ok, I will add the Fixes tag in the next iteration.
Thank you very much for your review!

Cheers!
Baokun
> 在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When queuing ondemand_object_worker() to re-open the object,
>> cachefiles_object is not pinned. The cachefiles_object may be freed when
>> the pending read request is completed intentionally and the related
>> erofs is umounted. If ondemand_object_worker() runs after the object is
>> freed, it will incur use-after-free problem as shown below.
>>
>> process A  processs B  process C  process D
>>
>> cachefiles_ondemand_send_req()
>> // send a read req X
>> // wait for its completion
>>
>>             // close ondemand fd
>>             cachefiles_ondemand_fd_release()
>>             // set object as CLOSE
>>
>>                         cachefiles_ondemand_daemon_read()
>>                         // set object as REOPENING
>>                         queue_work(fscache_wq, &info->ondemand_work)
>>
>>                                  // close /dev/cachefiles
>>                                  cachefiles_daemon_release
>>                                  cachefiles_flush_reqs
>>                                  complete(&req->done)
>>
>> // read req X is completed
>> // umount the erofs fs
>> cachefiles_put_object()
>> // object will be freed
>> cachefiles_ondemand_deinit_obj_info()
>> kmem_cache_free(object)
>>                         // both info and object are freed
>>                         ondemand_object_worker()
>>
>> When dropping an object, it is no longer necessary to reopen the object,
>> so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
>> to complete.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index d24bff43499b..f6440b3e7368 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -589,6 +589,9 @@ void cachefiles_ondemand_clean_object(struct 
>> cachefiles_object *object)
>>           }
>>       }
>>       xa_unlock(&cache->reqs);
>> +
>> +    /* Wait for ondemand_object_worker() to finish to avoid UAF. */
>> + cancel_work_sync(&object->ondemand->ondemand_work);
>>   }
>>     int cachefiles_ondemand_init_obj_info(struct cachefiles_object 
>> *object,



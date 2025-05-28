Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632B27816B
	for <netfs@lists.linux.dev>; Wed, 28 May 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424336; cv=none; b=GcnzceRtHrZT6Dv4Y4HlZgYDSYZdS2QA2acBgkS0jSYmIbSNXjdfD/APDb6WUBk3TNyVGbi4ynx63ktDZdaz5eoBvotZN5By79FM62JcSLIWHMffv7KDRpvfSdhQiJclmcGQjXPERjgeE0md3C68Rqb20aRhgQ5cxj+hzxTAtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424336; c=relaxed/simple;
	bh=HCvYs3EACZejkxRL2rmH/4+LEh3Pb2GukpYgVteU7fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iln0+NLOvSFxVR82qzgPVnd9lwjdWSoHWCv8tZF2qVATMKVSgBB4lUEV0ohFOcV9Zq8Y0lssFPtxwo4SPpS/BwUcDRo4d5nNRM4EGz77sE6xNx9+XL+P4POeW+IAyON//H1vixysX9Mp9Q8I/NNfJHkvmAzagexjAYaAiIqtIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ENxCvuxo; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ENxCvuxo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748424326; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RqprY+g1l59D1pr1yuCrzP+m/b/mIv1Qp17gecL4d0w=;
	b=ENxCvuxoJxNMWXvJjPwOvQ9i8xaJZMxZ62MiSKZND65qeMcEKh57Njszyt1HauEsjrt/tfGAm6bOG78bKQWJ+ecKpCaF3btBSalk2qK3vQmmqI3GkfeVX46m+43cXKiSVXry5QSWIvoDdcTL8qNXyQR1BUPPLdbEUIqmZBV9vtg=
Received: from 30.221.130.248(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WcCsI6O_1748424324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 May 2025 17:25:25 +0800
Message-ID: <4b8a0273-92a5-4f56-bafa-719e73828788@linux.alibaba.com>
Date: Wed, 28 May 2025 17:25:24 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] cachefiles: Recovery concerns with on-demand loading
 after unexpected power loss
To: Zizhi Wo <wozizhi@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, brauner@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, libaokun1@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, yukuai3@huawei.com
References: <20250528080759.105178-1-wozizhi@huaweicloud.com>
 <d0e08cbf-c6e4-4ecd-bcaf-40c426279c4f@linux.alibaba.com>
 <f177a0e4-c2da-40b7-9d47-8968f3c2bc50@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f177a0e4-c2da-40b7-9d47-8968f3c2bc50@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/28 16:53, Zizhi Wo wrote:
> 
> 
> 在 2025/5/28 16:35, Gao Xiang 写道:
>> Hi Zizhi,
>>
>> On 2025/5/28 16:07, Zizhi Wo wrote:
>>> Currently, in on-demand loading mode, cachefiles first calls
>>> cachefiles_create_tmpfile() to generate a tmpfile, and only during the exit
>>> process does it call cachefiles_commit_object->cachefiles_commit_tmpfile to
>>> create the actual dentry and making it visible to users.
>>>
>>> If the cache write is interrupted unexpectedly (e.g., by system crash or
>>> power loss), during the next startup process, cachefiles_look_up_object()
>>> will determine that no corresponding dentry has been generated and will
>>> recreate the tmpfile and pull the complete data again!
>>>
>>> The current implementation mechanism appears to provide per-file atomicity.
>>> For scenarios involving large image files (where significant amount of
>>> cache data needs to be written), this re-pulling process after an
>>> interruption seems considerable overhead?
>>>
>>> In previous kernel versions, cache dentry were generated during the
>>> LOOK_UP_OBJECT process of the object state machine. Even if power was lost
>>> midway, the next startup process could continue pulling data based on the
>>> previously downloaded cache data on disk.
>>>
>>> What would be the recommended way to handle this situation? Or am I
>>> thinking about this incorrectly? Would appreciate any feedback and guidance
>>> from the community.
>>
>> As you can see, EROFS fscache feature was marked as deprecated
>> since per-content hooks already support the same use case.
>>
>> the EROFS fscache support will be removed after I make
>> per-content hooks work in erofs-utils, which needs some time
>> because currently I don't have enough time to work on the
>> community stuff.
>>
>> Thanks,
>> Gao Xiang
> 
> Thanks for your reply.
> 
> Indeed, the subsequent implementations have moved to using fanotify.
> Moreover, based on evaluation, this approach could indeed lead to
> performance improvements.
> 
> However, in our current use case, we are still working with a kernel
> version that only supports the fscache-based approach, so this issue
> still exists for us. :(

Since it's deprecated (because that fscache improvement will
take much long time to upstream and netfs dependency is
redundant in addition to new pre-content hooks), could you
improve it downstream directly?

Or if you have some simple proposal you could post, but no one
avoids you to use fscache downstream but it seems pre-content
hooks are more cleaner for this use case..

Thanks,
Gao Xiang


> 
> Thanks,
> Zizhi Wo
> 
>>
>>>
>>> Thanks,
>>> Zizhi Wo
>>


Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96422152786
	for <netfs@lists.linux.dev>; Thu, 27 Jun 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489743; cv=none; b=UXpfIYkVFEpc0wqv8Db+PnShbpoWqO4qnjc1/gakTq2XTv2RTezRH81gpp4HHgN5jiJvITjR+le33y7XwwpoY9RC4yHw9k9TUkjh9grwO5zjmE+DgJ5rkHXP9vdT8EQG1HZ4TqMgWzLDQSu32O77qnUIpT7EG7t3roVasrwh/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489743; c=relaxed/simple;
	bh=SNeZz4cOOVEgUD3dElV+jBXzDqpAHqnRtap4vhbSxrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hUP2BQqcZVCRj7tseFPrecFRYuICFgJpQemFS8oa/z4BZikVTGRGG5IcdomK1taBop/SaGrA/m4NbB6rGr7Srd5ivevQQ4dTor0cnml3SaHyjw8Z7vxlgH+yoXPnnXjrAL7a/wP6CRreoR1Dn/ezlAmfPVoyCgWoviours/UWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W8xsx4LSNzMrT3;
	Thu, 27 Jun 2024 19:58:29 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 35C8F180064;
	Thu, 27 Jun 2024 20:02:11 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 20:02:10 +0800
Message-ID: <ffc16802-0aac-401c-ac1a-ae50f527100e@huawei.com>
Date: Thu, 27 Jun 2024 20:02:10 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-3-lihongbo22@huawei.com>
 <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
 <1fe0f4e5-37b0-4bbd-bcd3-9764f65660e8@huawei.com>
 <f148e340-26c5-44ce-887f-076c2c76137c@linux.alibaba.com>
 <88888ec4-1e45-477a-8084-2c122c0bfda2@linux.alibaba.com>
 <3f542dc9-2686-43af-a915-2bfede803771@huawei.com>
 <c7b280a7-c7b6-473f-8c55-65d09548b3b6@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <c7b280a7-c7b6-473f-8c55-65d09548b3b6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/6/24 20:58, Gao Xiang wrote:
> 
> 
> On 2024/6/24 19:58, Hongbo Li wrote:
>>
>>
>> On 2024/6/21 18:42, Gao Xiang wrote:
>>> Hi,
>>>
>>> On 2024/6/21 18:06, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2024/6/21 17:37, Hongbo Li wrote:
>>>>>
>>>>>
>>>>> On 2024/6/21 17:14, Gao Xiang wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/6/21 14:18, Hongbo Li wrote:
>>>>>>> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
>>>>>>> module. We cannot know whether it is supported from userspace, so
>>>>>>> we export this feature to user by sysfs interface.
>>>>>>>
>>>>>>> [Before]
>>>>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>>>>> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such 
>>>>>>> file or directory
>>>>>>>
>>>>>>> [After]
>>>>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>>>>> supported
>>>>>>>
>>>>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>>>>
>>>>>> I don't think such sysfs is needed, you could just use
>>>>>> `bind ondemand` to check if it is supported:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780
>>>>>>
>>>>> Thanks for reply!
>>>>> `bind ondemand` can check if it is supported, but it requires a 
>>>>> more complicated procedure for user to implement. For example, a 
>>>>> serial of system call (open, ioctl, close) are need.The containerd 
>>>>> snapshotter daemon relies on these feature, only use a simple check 
>>>>> method is usable in product environment. The snapshotter developers 
>>>>> may know how cachefiles works, but for snapshotter users, a simple 
>>>>> way to check whether snapshotter can be launched is useful. Even 
>>>>> though they do not know how cachefiles works.
>>>>
>>>> I don't think it needs to be considered as long as userspace
>>>> has a way to check since you could wrap up these as a helper
>>>> (I will do in the official erofs-utils later or if you have
>>>> some interest you could help too) and even some erofs-utils
>>>> binary for this.
>>>>
>>>> sysfs maintainence just for some random feature doesn't
>>>> sound good to me (similar to ext4/xfs on-disk features) and
>>>> even if works, you cannot use this way for 5.19~6.10
>>>> upstream kernels.
>>>
>>> Anyway, I know userspace folks always would like to have a
>>> simple kernel way to check if a feature is supported for a
>>> kernel, but (many years later) my current thought is that
>>> the simplist way to check this is to introduce a simple
>>> helper to try.  You cannot list every kernel features you
>>> concerned as some sysfs file and in time properly, or you
>>> could cause some inconsistency.
>>>
>>> Anyway, that is my personal thought, having another detailed
>>> list for all features users care about along with the real
>>> implementaions seems unnecessary.
>> Thanks for explaining!
>> Maybe the way of showing the features in erofs now seems not
>> quite reasonable. It only output the "supported" string from
>> sysfs. What suggestions do you have for this?
> 
> As I said, just using "bind ondemand" and "mount fsid" to check
> if erofs over fscache is supported is enough.
> 
> If userspace folks don't like the internals, these logic could
> be wrapped up in erofs-utils or whatever libraries.
> 
ok, thank you!
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>>
>>> Thanks,
>>> Gao Xiang

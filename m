Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528C17167B
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966575; cv=none; b=cxEzih6+5Broz5/TzAtEEw+0OcP7j1owUlhWgcvVGrRVj/Fc5gKS2DCB2QyfLp2jXqMqOnBjbnhLhhZarOcWSiiXAQGGhvB5hinmnvzJniHLK5P22ienCeZTZ7b4RVgXmcsvXwm0ZeA8WlZ+FLX8DV4NWnljFzi0xxwoj2uX+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966575; c=relaxed/simple;
	bh=sI4Ex/OBxHSCVagVPcOQsxtJkfheVJCy8B99rm8fL0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rQSNhm2Er3W84eqMuV7moy3p1mXueMfEd7oUNrZfgYfNBYqK7IOXLyoKKOv7LXM0crJbDwkiCxtlWeAqe0Wt7M9SiL8U11rxG6kVG2n+Pp8+XxXw2UrOU1zQ7o+Ynl8kGG8OYv5SQxvuKlKCOs6Esd6f2YtccxQBLPm1S0o/d8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FvU6Eo/e; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FvU6Eo/e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718966569; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=fYlbPkruKzNFnntQmTAd6cagWf2Vv3jPxV3GJpD9zrA=;
	b=FvU6Eo/eatBPzgSD9LCjEVuamsXXbP/jCPMZAkcvUaUkX0DUi6oKtOjHzS+8QYf7Mz5jjdvOfbi8bbFfbUiWVVPjXSN0Ge/Dxv/1/9mfBNn+Wf2fnWbKtQRB5bQMCWKKVZsNH5AkjZRN7CIfEGYmGvBSTd3TuqiR0sfnjh1YfRs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8w51Dx_1718966566;
Received: from 30.244.70.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8w51Dx_1718966566)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 18:42:48 +0800
Message-ID: <88888ec4-1e45-477a-8084-2c122c0bfda2@linux.alibaba.com>
Date: Fri, 21 Jun 2024 18:42:46 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
Cc: linux-erofs@lists.ozlabs.org, netfs@lists.linux.dev
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-3-lihongbo22@huawei.com>
 <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
 <1fe0f4e5-37b0-4bbd-bcd3-9764f65660e8@huawei.com>
 <f148e340-26c5-44ce-887f-076c2c76137c@linux.alibaba.com>
In-Reply-To: <f148e340-26c5-44ce-887f-076c2c76137c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/6/21 18:06, Gao Xiang wrote:
> 
> 
> On 2024/6/21 17:37, Hongbo Li wrote:
>>
>>
>> On 2024/6/21 17:14, Gao Xiang wrote:
>>>
>>>
>>> On 2024/6/21 14:18, Hongbo Li wrote:
>>>> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
>>>> module. We cannot know whether it is supported from userspace, so
>>>> we export this feature to user by sysfs interface.
>>>>
>>>> [Before]
>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or directory
>>>>
>>>> [After]
>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>> supported
>>>>
>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>
>>> I don't think such sysfs is needed, you could just use
>>> `bind ondemand` to check if it is supported:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780
>>>
>> Thanks for reply!
>> `bind ondemand` can check if it is supported, but it requires a more complicated procedure for user to implement. For example, a serial of system call (open, ioctl, close) are need.The containerd snapshotter daemon relies on these feature, only use a simple check method is usable in product environment. The snapshotter developers may know how cachefiles works, but for snapshotter users, a simple way to check whether snapshotter can be launched is useful. Even though they do not know how cachefiles works.
> 
> I don't think it needs to be considered as long as userspace
> has a way to check since you could wrap up these as a helper
> (I will do in the official erofs-utils later or if you have
> some interest you could help too) and even some erofs-utils
> binary for this.
> 
> sysfs maintainence just for some random feature doesn't
> sound good to me (similar to ext4/xfs on-disk features) and
> even if works, you cannot use this way for 5.19~6.10
> upstream kernels.

Anyway, I know userspace folks always would like to have a
simple kernel way to check if a feature is supported for a
kernel, but (many years later) my current thought is that
the simplist way to check this is to introduce a simple
helper to try.  You cannot list every kernel features you
concerned as some sysfs file and in time properly, or you
could cause some inconsistency.

Anyway, that is my personal thought, having another detailed
list for all features users care about along with the real
implementaions seems unnecessary.

Thanks,
Gao Xiang

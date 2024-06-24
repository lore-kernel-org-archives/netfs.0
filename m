Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE1E2556F
	for <netfs@lists.linux.dev>; Mon, 24 Jun 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233933; cv=none; b=REPTSpVbopB5+NIw5B5s1wKBWY4/S7YVbB7KpkRHTBGZTei4RtmV5S8srMVXDDwMNynv54FgHTnA6FxETsttpztpyvZVlHS/IGiLfRRUkw57lTjAfTfPS/8ireiDaI0QmHWmRHbLhqHiLX76/vSgZg5Mn8j5HGioBt3Aqti5Nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233933; c=relaxed/simple;
	bh=rjSH12DVDCwYGol+/9snp+hsuuf01XOFQQP5fv6qrPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9lc0vM9yYiTuNG7Sp7aTNlRzm+s4FXmuckBv4x/3M/TtSb7juler1Vh2advIriwxOJbo/5RGWu8jtZj91idZ4WkL9lsUdsqv0Tf48xxjkE+XseiATw5tHXNcMCvyLKiWQD90sHt4W2dXkNIxh2nKfIQge5+8RETVRANRShNOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w4dGT0Gx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w4dGT0Gx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719233922; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lVIWYWEN2qIAku3JaojT66eoQjBhzdiz1tVDHkwyM3Q=;
	b=w4dGT0GxZY5gztjUUPan67nt8EfCF8hsmSIL4VnfEwY2HGEKAiUOCQHGP57IHuzeCHKN9WeGdfMko1RYdoji2iyThsscnGpMoM3dbwzvBIX+Ytw1FOg0F6gh4dbi0UZSPhmZ5Q7a7FK0um2/CwvLaKCanQB3vplF3nd4OBbPf7c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9AJGfV_1719233920;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9AJGfV_1719233920)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 20:58:41 +0800
Message-ID: <c7b280a7-c7b6-473f-8c55-65d09548b3b6@linux.alibaba.com>
Date: Mon, 24 Jun 2024 20:58:40 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
Cc: linux-erofs@lists.ozlabs.org, netfs@lists.linux.dev
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-3-lihongbo22@huawei.com>
 <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
 <1fe0f4e5-37b0-4bbd-bcd3-9764f65660e8@huawei.com>
 <f148e340-26c5-44ce-887f-076c2c76137c@linux.alibaba.com>
 <88888ec4-1e45-477a-8084-2c122c0bfda2@linux.alibaba.com>
 <3f542dc9-2686-43af-a915-2bfede803771@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3f542dc9-2686-43af-a915-2bfede803771@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/24 19:58, Hongbo Li wrote:
> 
> 
> On 2024/6/21 18:42, Gao Xiang wrote:
>> Hi,
>>
>> On 2024/6/21 18:06, Gao Xiang wrote:
>>>
>>>
>>> On 2024/6/21 17:37, Hongbo Li wrote:
>>>>
>>>>
>>>> On 2024/6/21 17:14, Gao Xiang wrote:
>>>>>
>>>>>
>>>>> On 2024/6/21 14:18, Hongbo Li wrote:
>>>>>> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
>>>>>> module. We cannot know whether it is supported from userspace, so
>>>>>> we export this feature to user by sysfs interface.
>>>>>>
>>>>>> [Before]
>>>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>>>> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or directory
>>>>>>
>>>>>> [After]
>>>>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>>>>> supported
>>>>>>
>>>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>>>
>>>>> I don't think such sysfs is needed, you could just use
>>>>> `bind ondemand` to check if it is supported:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780
>>>>>
>>>> Thanks for reply!
>>>> `bind ondemand` can check if it is supported, but it requires a more complicated procedure for user to implement. For example, a serial of system call (open, ioctl, close) are need.The containerd snapshotter daemon relies on these feature, only use a simple check method is usable in product environment. The snapshotter developers may know how cachefiles works, but for snapshotter users, a simple way to check whether snapshotter can be launched is useful. Even though they do not know how cachefiles works.
>>>
>>> I don't think it needs to be considered as long as userspace
>>> has a way to check since you could wrap up these as a helper
>>> (I will do in the official erofs-utils later or if you have
>>> some interest you could help too) and even some erofs-utils
>>> binary for this.
>>>
>>> sysfs maintainence just for some random feature doesn't
>>> sound good to me (similar to ext4/xfs on-disk features) and
>>> even if works, you cannot use this way for 5.19~6.10
>>> upstream kernels.
>>
>> Anyway, I know userspace folks always would like to have a
>> simple kernel way to check if a feature is supported for a
>> kernel, but (many years later) my current thought is that
>> the simplist way to check this is to introduce a simple
>> helper to try.  You cannot list every kernel features you
>> concerned as some sysfs file and in time properly, or you
>> could cause some inconsistency.
>>
>> Anyway, that is my personal thought, having another detailed
>> list for all features users care about along with the real
>> implementaions seems unnecessary.
> Thanks for explaining!
> Maybe the way of showing the features in erofs now seems not
> quite reasonable. It only output the "supported" string from
> sysfs. What suggestions do you have for this?

As I said, just using "bind ondemand" and "mount fsid" to check
if erofs over fscache is supported is enough.

If userspace folks don't like the internals, these logic could
be wrapped up in erofs-utils or whatever libraries.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
>>
>> Thanks,
>> Gao Xiang

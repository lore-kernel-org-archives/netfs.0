Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107E1C02
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962661; cv=none; b=T0L/FciH/drU/y/TmkgGbYlO0NADOBeuQ7taNTTDrCNVT9oPaXtvpKx2wlmR52lfookVrD2jpMexr0XmfEGyLnSRXXgcrNUc3/zCtrLSLFai+QTs/BfY0X+/CuzOmJxdSQwNeNTS6AQHAzHltrj1qvgBtSokJORVpkJyUcXubPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962661; c=relaxed/simple;
	bh=7uzUwoWrl8JcwWzkKq1wba8nJrSZj9HZK5ZwrzMukeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQ9+NRbFH+wlpGCCJd971FfjoL+rGcQy5x5PKhx+DA5nJaRdVZXrDRFMR3AiuoFpR6yCLEHC0J60H1YyDHXfjk9yV1iFJXUTY/tmO8hhec9Q/teLc9gY4eJUgr6s/BMEDN0xfQ/rU52vjQXNh8XkkHQjtqCZ3jeryBEkzyw/m88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W5BxW1TYkz1j5WY;
	Fri, 21 Jun 2024 17:33:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 87599140109;
	Fri, 21 Jun 2024 17:37:30 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 17:37:30 +0800
Message-ID: <1fe0f4e5-37b0-4bbd-bcd3-9764f65660e8@huawei.com>
Date: Fri, 21 Jun 2024 17:37:29 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-3-lihongbo22@huawei.com>
 <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/6/21 17:14, Gao Xiang wrote:
> 
> 
> On 2024/6/21 14:18, Hongbo Li wrote:
>> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
>> module. We cannot know whether it is supported from userspace, so
>> we export this feature to user by sysfs interface.
>>
>> [Before]
>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or 
>> directory
>>
>> [After]
>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>> supported
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> I don't think such sysfs is needed, you could just use
> `bind ondemand` to check if it is supported:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780
> 
Thanks for reply!
`bind ondemand` can check if it is supported, but it requires a more 
complicated procedure for user to implement. For example, a serial of 
system call (open, ioctl, close) are need.The containerd snapshotter 
daemon relies on these feature, only use a simple check method is usable 
in product environment. The snapshotter developers may know how 
cachefiles works, but for snapshotter users, a simple way to check 
whether snapshotter can be launched is useful. Even though they do not 
know how cachefiles works.

Thanks,
Hongbo
> 
> Thanks,
> Gao Xiang

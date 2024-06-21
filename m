Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108C17106D
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964400; cv=none; b=uTknbYOun9NkWR1K9acxFW+WKhVJmqZ3wEgmfND87X1RzlsyP3MT6R6q74KfjHdECrN311VRmRKzrNBh1If4donY8BSvfWXqfT/59/bQfVXzQ/RjNGAVR58tt7or0YDTWxtfkhduiMt+z1LbJQhTTmlm7ngV14acOtbfExlA2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964400; c=relaxed/simple;
	bh=p/D/x1ZpU0Uo6+XzbPF+E/ejbNlLuaa4NF1EI474NrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5hbjt9/Vj/HTz2EhHZOQBS1rpdeVxOM+fJ9zodmMNYXOC8REzPxqAzKYul+G07DNusy++GS4D4cyfgzCqLdKSJIuGNOJfH7mGs/lKQh7iRACTTNgH8Z9SR8ClHMDMk3oCmUHUoEgf0WIExYc15zTkl4B1IYgSnL+hctnzgQN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SUbGka5n; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SUbGka5n"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718964389; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9PPcaOsX48CVP9zShpkQ9j0vLOF3cdLOUbYFqFGw/So=;
	b=SUbGka5nTsd1DdTiOO+Ir06By/3OEfg4rlXlYBAKAl82xiik7FVdL3bnJO8TQLqGojdFcMwXUT21DSZo7fmr0DgAffTvcE2Wq4xhgehTyf/90GTl3do3hA+drwS46Ua0Gox2RrQ0J7/INgSmtE0GeuZxXsfcwPlKrgCpOkS6avE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8w4pAG_1718964387;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8w4pAG_1718964387)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 18:06:28 +0800
Message-ID: <f148e340-26c5-44ce-887f-076c2c76137c@linux.alibaba.com>
Date: Fri, 21 Jun 2024 18:06:27 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1fe0f4e5-37b0-4bbd-bcd3-9764f65660e8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/21 17:37, Hongbo Li wrote:
> 
> 
> On 2024/6/21 17:14, Gao Xiang wrote:
>>
>>
>> On 2024/6/21 14:18, Hongbo Li wrote:
>>> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
>>> module. We cannot know whether it is supported from userspace, so
>>> we export this feature to user by sysfs interface.
>>>
>>> [Before]
>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or directory
>>>
>>> [After]
>>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>>> supported
>>>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>
>> I don't think such sysfs is needed, you could just use
>> `bind ondemand` to check if it is supported:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780
>>
> Thanks for reply!
> `bind ondemand` can check if it is supported, but it requires a more complicated procedure for user to implement. For example, a serial of system call (open, ioctl, close) are need.The containerd snapshotter daemon relies on these feature, only use a simple check method is usable in product environment. The snapshotter developers may know how cachefiles works, but for snapshotter users, a simple way to check whether snapshotter can be launched is useful. Even though they do not know how cachefiles works.

I don't think it needs to be considered as long as userspace
has a way to check since you could wrap up these as a helper
(I will do in the official erofs-utils later or if you have
some interest you could help too) and even some erofs-utils
binary for this.

sysfs maintainence just for some random feature doesn't
sound good to me (similar to ext4/xfs on-disk features) and
even if works, you cannot use this way for 5.19~6.10
upstream kernels.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
>>
>> Thanks,
>> Gao Xiang

Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EE316E884
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962125; cv=none; b=H7y4UZTjzUPCQpqDCHN8p/D3lHqX912aUjNN8IVz1IyQwXN0zWKHpZ07xtd/QwDtWAUNrZMAdcoOG1lHrF1ztNPPqxATnMvarphiMzPP12w+Lj+yc0AHcFpMLQGQ1y6YfKKlackjST1+QUNpZJmAmlj2SHdaL6486eA/DCr+T+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962125; c=relaxed/simple;
	bh=5bqf5pcNOmsD1/yRyBqJOu6GFdImbP6qp2drJkQal4Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=krvTqlA3sPGrm7fTkeZcoh+zt/DAhqODzZjUuPcxm2tGz86mJ2i3DsqisuahuSYncHJqqCRpYNC1U/p+Mwb16T303kBKlgAfVaSUX4gbLL7VYoxXsgw2JR8+hQH8DtWB1k/KgLvoIJMDjOK7h5PDZifMQlKnMiPyxtxJ9UE5CtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rvtt4cC5; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rvtt4cC5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718962114; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=wLn5rkckqWhe7tXkm9med+6pp5efGiA4evLhK1wSsiQ=;
	b=Rvtt4cC5RdyiOIprOpqZ6nhpAUeNVqgNvnrbBvtNEMjOnroD4/blnfG/ClnfwIgHbBTSsn9D76YFeZRloB3rst/R+g2+EiCQG8JEgQTdlPfyXCMs/w51HQL/wdMrYk4WpJfpIcuIeg7IXmc6BDxTPx+VK1XufuZdFdzkz/dujAs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8vwGOu_1718962111;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8vwGOu_1718962111)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 17:28:32 +0800
Message-ID: <cba6e2f5-7dc7-4a8b-8509-a476faa304fd@linux.alibaba.com>
Date: Fri, 21 Jun 2024 17:28:31 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: support query erofs ondemand feature by sysfs
 interface
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
Cc: linux-erofs@lists.ozlabs.org, netfs@lists.linux.dev
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-2-lihongbo22@huawei.com>
 <2a3fa2a6-8a34-456a-b471-9eec83a4ba74@linux.alibaba.com>
In-Reply-To: <2a3fa2a6-8a34-456a-b471-9eec83a4ba74@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/21 17:16, Gao Xiang wrote:
> 
> 
> On 2024/6/21 14:18, Hongbo Li wrote:
>> Erofs over fscache depands on the config CONFIG_EROFS_FS_ONDEMAND
>> in erofs. There is no way to check whether this feature is supported
>> or not in userspace. We introduce sysfs file `erofs_ondemand` for
>> user checking current features. Here is the example:
>>
>> [Before]
>> $ cat /sys/fs/erofs/features/erofs_ondemand
>> cat: /sys/fs/erofs/features/erofs_ondemand: No such file or directory
>>
>> [After]
>> $ cat /sys/fs/erofs/features/erofs_ondemand
>> supported
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Similar here, I guess you could pass in any `fsid` mount
> option and check the return value instead.

Add some words, currently I don't tend to add any sysfs for
new feautures since you could always use golden test images
or test programs to test if any on-disk/runtime feature is
really supported.

Maintaining sysfs files for these causes unnecessary burden
(and could cause unexpected inconsistency). Maybe in the
future I will deprecate all these sysfs files.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang

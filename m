Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8383CDA
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962202; cv=none; b=MaukesZYVqAEwaAJe4I9p3hvNrjlispU8VPQxg3SJSxlQDq76yPPuUfgG2fyRrodotQduoA79JCIFGw70iazw01NWnEhAKNWfVSwtIf1gjHO6jKQU7oCxE0p182QblFhfSwBmUo7UxNDYjRyEqs6ZjyLI1ixS+iH/EZqsM7iWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962202; c=relaxed/simple;
	bh=oVGg6oUjIZIbag7OjQ/RVsuBy86u77J5WOCNJ7fBl9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgJG4Hp4r/S+jleTj0VEO4xPcta6+hJSm1dEcN5qFJA/EeFbzkxn5f71pv/xJX9nRhuhsWQA89B7vGoB9LSkGEmk6VbQ3kziBhvoBqTsPqS+p7fcLVPOn+XdqVYChoP8BdoOIji5YM7JpXlpWQWDPylp41eEmwVl2fLioDxBsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=euPDIJt3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="euPDIJt3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718962197; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O9mP/08aAQ9dyg28He1RiA58IjqYB58NI0tJ1WKuAY0=;
	b=euPDIJt3Jqw53Lctm0R58UgxlBk6MtYBVc+MHjZJJjAnBqf3WvAfYSXYPvq2kT1SShJf9VESBCRB7L54oMVniqrRa+gCCKqffflLY9tiWOsTpw3jGC7S1DlB3pEfmY603aReqv+Z/l+ZMHyEgbQA5+Xley5gpDDWTOcyzyKuCg8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8vr-NK_1718961260;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8vr-NK_1718961260)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 17:14:21 +0800
Message-ID: <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
Date: Fri, 21 Jun 2024 17:14:20 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240621061808.1585253-3-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/21 14:18, Hongbo Li wrote:
> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
> module. We cannot know whether it is supported from userspace, so
> we export this feature to user by sysfs interface.
> 
> [Before]
> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or directory
> 
> [After]
> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
> supported
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

I don't think such sysfs is needed, you could just use
`bind ondemand` to check if it is supported:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780


Thanks,
Gao Xiang

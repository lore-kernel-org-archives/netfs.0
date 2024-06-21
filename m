Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17652168C32
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961423; cv=none; b=CvjaTVh7Ntwd//XWt+P7jVRZFrzUk5CUVl5dFgovwyk1+QTMWSFPVunQivJrkGBYzNpNOn/N8xN0nH5iUKZYVElMnNut+TW5K9EMdY1/boarEqEk12aWcPmW4QzMEIZ8R/ZGECdPSGLgJWG4PXu7sF2ntelxMLxfUgX2uXtvFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961423; c=relaxed/simple;
	bh=WIRVK2b8ejdjtDRqtXo9XXt7qbIinPqvlHnd8TVjRn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6+NY+p+chx5aAef3GQKeb62xp97iWF+HoxF9OTGhfBDUiKcP/ycMtCHfC02Mbnj8EM8mrNSgf7yZMsU/5PLf49V2QLw1pgFgTHb9jqi3jw5PJegMy0ae6VuVWYz0P08R1UGrQrEfaapbxg4CYe9IWvG8uRMEUloIjZRuXGgwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GGFidwe8; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GGFidwe8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718961417; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wiiUV5lFg3P81nGdqXa0NIdIwHVNHSBPtJsi4JxnXYo=;
	b=GGFidwe8T7iYgGClWY6OOoO8UiqzgD/hYYCh/WNKcEdVxcA6gPxGCd9eSeNYk26v/bt3e6T4GcwLaxS23KCYkvu23jBtBujXynVNuISnVaEIN1f0jIDWRTVoHcS8uvuCEdlfOOdl0WxvrReXYrK/ZzRXf0OuGTfw6RYr5gzqOQ4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8vqdoJ_1718961414;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8vqdoJ_1718961414)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 17:16:55 +0800
Message-ID: <2a3fa2a6-8a34-456a-b471-9eec83a4ba74@linux.alibaba.com>
Date: Fri, 21 Jun 2024 17:16:54 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: support query erofs ondemand feature by sysfs
 interface
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
Cc: linux-erofs@lists.ozlabs.org, netfs@lists.linux.dev
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240621061808.1585253-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/21 14:18, Hongbo Li wrote:
> Erofs over fscache depands on the config CONFIG_EROFS_FS_ONDEMAND
> in erofs. There is no way to check whether this feature is supported
> or not in userspace. We introduce sysfs file `erofs_ondemand` for
> user checking current features. Here is the example:
> 
> [Before]
> $ cat /sys/fs/erofs/features/erofs_ondemand
> cat: /sys/fs/erofs/features/erofs_ondemand: No such file or directory
> 
> [After]
> $ cat /sys/fs/erofs/features/erofs_ondemand
> supported
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Similar here, I guess you could pass in any `fsid` mount
option and check the return value instead.

Thanks,
Gao Xiang

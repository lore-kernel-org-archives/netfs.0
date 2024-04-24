Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C7142E62
	for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957444; cv=none; b=gKt5TZX+C6SHh52pNVxvApQ1MJEWHfIZWl+P9AAsOtgOB+evGtVMWt3k39ABfjP4nb66eX946tAg+J9LrAcO7V1ofqv1JBhar/vpN2p87/Zc5odLZivcs97I3IfCpC3wAlmQphOecnnzFWYvzVOP8n1Pf6sBGS4k/xctRxurQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957444; c=relaxed/simple;
	bh=BwoCCpZnTjOq+58Y2wfa1LJ9/ue/n3X+p6IdwTDXePs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GyKWocMrDHjPM0V4PEhr54d0aosINxsigL8fKSROv6Se8ub/0yiUz7VGDVUmA9qcU+fH5XRwXJ36dfif4SM4zKY7Stf70J+riGliGgWTQmbVpI7mXdGlMmUEy2gXmjpi/KbdEcjR2vjpn3teOnOtcp65nMIz+u9F5WBHgz4m8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPbwH6tnfzwTCy;
	Wed, 24 Apr 2024 19:14:07 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id B246C180080;
	Wed, 24 Apr 2024 19:17:18 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 19:17:18 +0800
Message-ID: <b40da52b-e3de-a23e-ef1c-7e3b07af27c3@huawei.com>
Date: Wed, 24 Apr 2024 19:17:17 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
To: <dhowells@redhat.com>, <jlayton@kernel.org>,
	<hsiangkao@linux.alibaba.com>, <netfs@lists.linux.dev>
References: <20240323092312.1643320-1-yangerkun@huawei.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20240323092312.1643320-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Ping...

在 2024/3/23 17:23, yangerkun 写道:
> The name of debug config used in fs/netfs/internal.h has a mismatch
> compared to the define in fs/netfs/Kconfig, which lead to that debug for
> netfs won't work.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/netfs/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index ec7045d24400..53d61ead35fd 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -349,7 +349,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
>   #define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
>   #define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
>   
> -#elif defined(CONFIG_NETFS_DEBUG)
> +#elif defined(CONFIG_FSCACHE_DEBUG)
>   #define _enter(FMT, ...)			\
>   do {						\
>   	if (netfs_debug)			\

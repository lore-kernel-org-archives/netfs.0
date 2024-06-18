Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6F15747A
	for <netfs@lists.linux.dev>; Tue, 18 Jun 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717869; cv=none; b=mlu79dmsU1vQjIaMOUGBIppecOTUJ2yrX7tofN1XII9GVPsg+HPctSvS2Yk/4LpgYvff2xMdlyuknQ5l6JztQjDfuFL66mhyIrmRpVR+BRoP0ktFz7uZ0SgmvWowlMDDwSeyYNo5E3u+VhqAPb/jSgWaSiEi9L6g9ja1Y3vz0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717869; c=relaxed/simple;
	bh=KssnqUamADmWVBsMeaGkbmuidtbL8xmrw+FgZlCyEus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oTg4ReqTSjfLFARIczldU/zTeio3B5jIqIapFRjbumRGGAY7IBOA9ho8CCgwpwEmNnN8pCSv8hFzkRPbZQsg063GqYvxyqKZPZSTmWKsR4U6/w7sCx43X9K/H3hqOg4wGeHrJOeKEpEfujGmhgNrqNiaQr+5HPRUyH/zg/Q6wqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W3SQR0pw8zPrGw;
	Tue, 18 Jun 2024 21:34:07 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id DBB2818007A;
	Tue, 18 Jun 2024 21:37:38 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Jun 2024 21:37:37 +0800
Message-ID: <6ffcbc02-b059-4e56-8900-53820d2d3caa@huawei.com>
Date: Tue, 18 Jun 2024 21:37:37 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: modify inappropriate error return value in
 cachefiles_daemon_secctx
To: <dhowells@redhat.com>, <steved@redhat.com>, <Trond.Myklebust@netapp.com>,
	<viro@zeniv.linux.org.uk>
CC: <netfs@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
	<jefflexu@linux.alibaba>, <zhujia.zj@bytedance.com>, <libaokun1@huawei.com>,
	<houtao1@huawei.com>, Yu Kuai <yukuai3@huawei.com>
References: <20240604071334.3982185-1-wozizhi@huawei.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20240604071334.3982185-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

friendly ping

在 2024/6/4 15:13, Zizhi Wo 写道:
> In cachefiles_daemon_secctx(), if it is detected that secctx has been
> written to the cache, the error code returned is -EINVAL, which is
> inappropriate and does not distinguish the situation well.
> 
> Like cachefiles_daemon_dir(), fix this issue by return -EEXIST to the user
> if it has already been defined once.
> 
> Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   fs/cachefiles/daemon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..1b14849804f3 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -586,7 +586,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
>   
>   	if (cache->secctx) {
>   		pr_err("Second security context specified\n");
> -		return -EINVAL;
> +		return -EEXIST;
>   	}
>   
>   	secctx = kstrdup(args, GFP_KERNEL);


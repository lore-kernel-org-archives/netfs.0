Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114EA17F8
	for <netfs@lists.linux.dev>; Sun, 18 Feb 2024 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226127; cv=none; b=umzXyl2R1H1eMeSkMVcrmbNzD0lsMu6iXsyKZbZL6aP6RwMuArPFF90BnoQRHMvTeAqAa/MHW0Z72iI1B5olA1mxxVdpGa1CQbLBrrriNbOYqBilqjJM9zzKdKZAM8Hi1XcnCuyS7d7u74IQQH2zHBHlQJmsOh9GLDb8zqJS/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226127; c=relaxed/simple;
	bh=XfZHq5PLl/gGIAJY4T+e1XbJYYy90SoHG1cHEE8y4og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1WbX1ohtGMGDOOdiT+4L9B8USzeL0UYdWDQ96GofhKra5hIKZ/XLXkPuLPQ6yGt4h+ACD0lSbaPmPeb4x2LbdeAMtevtXxf7Y+anhKB15pIOu49lwILpNFkt1xxMrmcJI53tXrz4i29keCP7g79SA/PqfEGR5k6uvMXVBVUSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YWX6wbkd; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YWX6wbkd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708226114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cqOsry37fOCW6Y3ou1nZ7EHlwm2eSJbNTtcAmfAvy8w=;
	b=YWX6wbkdvMXK8OtQnaUar+HWLk8JcV7aFVQEaOLLkWvij1WFrenSkOr4+VW4b7vfHxigs1ZydsfaxA7Zx/xgqcM4WXPyD2TnUAa9I1C4j2assWCnLekXGOHRMvJ0v2IlsbWJnfX/Oyqcos58U5N/FXs3yilCdaNC3oit8/ktCy0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W0kSJnS_1708226113;
Received: from 30.221.145.138(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W0kSJnS_1708226113)
          by smtp.aliyun-inc.com;
          Sun, 18 Feb 2024 11:15:13 +0800
Message-ID: <cee45d07-b885-4b4b-b9b5-d7aeedc2b2e7@linux.alibaba.com>
Date: Sun, 18 Feb 2024 11:15:12 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] cachefiles: fix memory leak in
 cachefiles_add_cache()
To: Baokun Li <libaokun1@huawei.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240217081431.796809-1-libaokun1@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240217081431.796809-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/24 4:14 PM, Baokun Li wrote:
> The following memory leak was reported after unbinding /dev/cachefiles:
> 
> ==================================================================
> unreferenced object 0xffff9b674176e3c0 (size 192):
>   comm "cachefilesd2", pid 680, jiffies 4294881224
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ea38a44b):
>     [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
>     [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
>     [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
>     [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
>     [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
>     [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
>     [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
>     [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
>     [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> ==================================================================
> 
> Put the reference count of cache_cred in cachefiles_daemon_unbind() to
> fix the problem. And also put cache_cred in cachefiles_add_cache() error
> branch to avoid memory leaks.
> 
> Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/cachefiles/cache.c  | 2 ++
>  fs/cachefiles/daemon.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
> index 7077f72e6f47..f449f7340aad 100644
> --- a/fs/cachefiles/cache.c
> +++ b/fs/cachefiles/cache.c
> @@ -168,6 +168,8 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
>  	dput(root);
>  error_open_root:
>  	cachefiles_end_secure(cache, saved_cred);
> +	put_cred(cache->cache_cred);
> +	cache->cache_cred = NULL;
>  error_getsec:
>  	fscache_relinquish_cache(cache_cookie);
>  	cache->cache = NULL;
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 3f24905f4066..6465e2574230 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -816,6 +816,7 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
>  	cachefiles_put_directory(cache->graveyard);
>  	cachefiles_put_directory(cache->store);
>  	mntput(cache->mnt);
> +	put_cred(cache->cache_cred);
>  
>  	kfree(cache->rootdirname);
>  	kfree(cache->secctx);

-- 
Thanks,
Jingbo

Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733213DDC9
	for <netfs@lists.linux.dev>; Fri, 28 Jun 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559335; cv=none; b=K45HNaBy2P9oknYfH5usYSZhVs1FynRIBrbLXGOn7RA/+uLq96utPW8YMr9tntBc/BN1yUpnLnRuSketh/PXqhy/kxL3M7KVRFBR5d5zePWuLaN9YqUFFoqJeBGYWsOQhnsITvzRSZJtPdqQIqMoPT5jpTXI26r80EU8d7QD0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559335; c=relaxed/simple;
	bh=+wsQjZY5cjH6Gyaiayr2bHQGY8kxalxUhV+ML6iDptY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2/jSWoh2pjy4gEwTeH77VQ/2kTuUvljjYLlL1DlumXQgeerql/V5QOibe0+5YLKZLHcGDbQiAJkSx8g1j6ggTLkOJUXgF+ibPa6lZ5popbYoCHp4J0GQrX90GnGGFsAGeu8BZsujXiF+B53bvgLwoM9+TWVIq72tyN7E/inrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KpbeYZuB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KpbeYZuB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719559331; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IrbTsirtrY43rd7JDwwCb+Vavj288uGg3kYA56aBvE8=;
	b=KpbeYZuBrJRW1EPPRPv2PWmUbCpiL1kiKmariL1cYN60zNWNqZ4EemVYWNKtATQkaP+Betzk1ZDXgO5tWzm7YqabLyWEImeaGrlcYZS0+rsW3au6tj94qAwN9bVhqxuBYf2UswMpfACPc6Qqi7BlOYbz2koxM6WIlA0dULn0aQI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PYbzE_1719559330;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PYbzE_1719559330)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 15:22:11 +0800
Message-ID: <d5a1aed6-cb93-4562-b8ae-90c688f17f07@linux.alibaba.com>
Date: Fri, 28 Jun 2024 15:22:09 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] cachefiles: wait for ondemand_object_worker to
 finish when dropping object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-8-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-8-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When queuing ondemand_object_worker() to re-open the object,
> cachefiles_object is not pinned. The cachefiles_object may be freed when
> the pending read request is completed intentionally and the related
> erofs is umounted. If ondemand_object_worker() runs after the object is
> freed, it will incur use-after-free problem as shown below.
> 
> process A  processs B  process C  process D
> 
> cachefiles_ondemand_send_req()
> // send a read req X
> // wait for its completion
> 
>             // close ondemand fd
>             cachefiles_ondemand_fd_release()
>             // set object as CLOSE
> 
>                         cachefiles_ondemand_daemon_read()
>                         // set object as REOPENING
>                         queue_work(fscache_wq, &info->ondemand_work)
> 
>                                  // close /dev/cachefiles
>                                  cachefiles_daemon_release
>                                  cachefiles_flush_reqs
>                                  complete(&req->done)
> 
> // read req X is completed
> // umount the erofs fs
> cachefiles_put_object()
> // object will be freed
> cachefiles_ondemand_deinit_obj_info()
> kmem_cache_free(object)
>                         // both info and object are freed
>                         ondemand_object_worker()
> 
> When dropping an object, it is no longer necessary to reopen the object,
> so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
> to finish.
> 
> Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

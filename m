Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14013E032
	for <netfs@lists.linux.dev>; Fri, 28 Jun 2024 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557504; cv=none; b=ESU1BtU0e2srj/v4of1wB0XUq8zjjeWnkwiBadu4cv/2PZug0GIQdX+mjVHSdiWVBmW2KJsXQqnikAsYUw0TQNzR8Bl2RU4VBTKdRSxio+6pNjsfacqZLSlRJnSNkLIye0z4a4L/5WLyaFro+kIqa2twovlIpsyOyQ0bOQGhLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557504; c=relaxed/simple;
	bh=yohMcnmAeIqrMAbaKAIXnTyXPyRPbrvvguRyr/N4g/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIxe6XflRS93uElsCv5WS6he7guKzfnMNNx8LsukcbC8jmZnuaLrkyurshsxYGyRRzxy15GIjPFshZ5bXW8xVnco2MJJ8kbbyQxLy2usgZIZDEDZi+U41N13B1j3hTSR8yejhDt9vnJCC/uUOWG4tm4U3sN3EEuGDzeZ8/L04Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UktuqAe4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UktuqAe4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719557494; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G2GS0ttnxk96DYFmlPzDna2bpcep+8CvGlmW7aCi9WQ=;
	b=UktuqAe4gbhLPLNvqlefcTxs6yw1wkx47j/vuN4pVKwC1ozY6sYD/Y5Ti2F8rxdC/N4El2UA6fIL+6OO/j4o7GNbuKUJWcRMS3QZZxVsvnpBderZBqbxTwcWizigK8peyDWD/bgPD89Ta8bLEMKo5AtMuTq4fMSMEJVNd6vw530=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PPCZf_1719557492;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PPCZf_1719557492)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 14:51:33 +0800
Message-ID: <cd550919-a900-4de8-9bd3-f9041f6baeb9@linux.alibaba.com>
Date: Fri, 28 Jun 2024 14:51:32 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] cachefiles: stop sending new request when dropping
 object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-6-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Added CACHEFILES_ONDEMAND_OBJSTATE_DROPPING indicates that the cachefiles
> object is being dropped, and is set after the close request for the dropped
> object completes, and no new requests are allowed to be sent after this
> state.
> 
> This prepares for the later addition of cancel_work_sync(). It prevents
> leftover reopen requests from being sent, to avoid processing unnecessary
> requests and to avoid cancel_work_sync() blocking by waiting for daemon to
> complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

LGTM,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

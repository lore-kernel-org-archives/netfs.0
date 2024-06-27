Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF358814
	for <netfs@lists.linux.dev>; Thu, 27 Jun 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454128; cv=none; b=DvVF8QCEEjzZ9AzkmmmiM2Ly/eZNP2Z2VRwbJsUCCM5kdq+FCVaddNda6dZfO0E6cxOXUpmCLs83XWgsR9gksTw5wWsypgg+jB+zY5lg2UBvftb+GzCf7lYB/bQZteu9TTyItI2bBCVrgQewsbNidxd0BKJy0ybaP3H4GmuNuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454128; c=relaxed/simple;
	bh=dAqmXPYuYZURr6lFVWrgQKZT5EGJrDh8dph/LMsXHk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU0i5s9nINupTkmXnWyfNAR+p8X0H6yaLGogG97CR7VKlMcfDxZJTazRKDxcu0re4I8UxvcyvuNqKwsa2pmPNJRJAXs1FO0PopNbzVzMAyAbkcHCa+ilIIJMbOwGXaFk1ZamYBvjzezYzstqXyY3YlDMqyn3HFKW9quDM1zsnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SxMSejH1; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SxMSejH1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719454123; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CMxvaX6g7HGFwrCzrjHt2gTPICeAo4dsZn/PpwJIyuc=;
	b=SxMSejH1jaKDOKLrQDGL7K/IFQ13NxeuCTZAE4FqlDBpCnHq5ZDbV4p9RYXgFN/Q/M8LaCjPqt2AdH8YQmbk7gpTTFBj4aluOsrpzWppNjz7aZd5EPGSxCeGmpsPYI5U7fTnYc7NdJ6l8mF30sQN0Bthz6p6dTkCFNHEyT7w3Qo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9L3mkX_1719454121;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9L3mkX_1719454121)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 10:08:42 +0800
Message-ID: <d97a1e87-9571-453e-909c-4de17d1d67db@linux.alibaba.com>
Date: Thu, 27 Jun 2024 10:08:41 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: Baokun Li <libaokun@huaweicloud.com>
Cc: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
 <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
 <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/27 09:49, Baokun Li wrote:
> On 2024/6/26 11:28, Gao Xiang wrote:
>>
>>
>> On 2024/6/26 11:04, Baokun Li wrote:
>>> A gentle ping.
>>
>> Since it's been long time, I guess you could just resend
>> a new patchset with collected new tags instead of just
>> ping for the next round review?
>>
>> Thanks,
>> Gao Xiang
> 
> Okay, if there's still no feedback this week, I'll resend this patch series.
> 
> Since both patch sets under review are now 5 patches and have similar
> titles, it would be more confusing if they both had RESEND. So when I
> resend it I will merge the two patch sets into one patch series.

Sounds fine, I think you could rearrange the RESEND patchset with
the following order
cachefiles: some bugfixes for withdraw and xattr
cachefiles: some bugfixes for clean object/send req/poll

Jingbo currently is working on the internal stuff, I will try to
review myself for this work too.

Thanks,
Gao Xiaang

> 

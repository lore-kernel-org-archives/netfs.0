Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605B1C01
	for <netfs@lists.linux.dev>; Thu, 27 Jun 2024 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719452997; cv=none; b=RcEf7Yy9jXkCd55yJkC2lOEMrafksTf3OJ/OH+l/pRK7t7b7RS6KEKE9VFgJncoT9pJRJIfHYpFS0igXFOmpXNKCMZQTZfug1ofrixw+CYiSDEuo2SUUeJKmakS5QgsujuPdJTzr/V37lk9KJ0ygN5Dena99sOUxfKlWp709R/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719452997; c=relaxed/simple;
	bh=CKD9J1oabUDJCgqoDae9sSPcR0MjL/zhz+eW2ayhyZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tllCQxULOdheQ2fXscqAP6oMFBLwphsOeKDgOMglQAfHOuBwejSh08Q7PLs51uoFa+SrtHnVeQnBizmbgndumgWPMobeCalWNPPiY+RnpordHllkgNW6Q3t553BV5n1Y/eAxkC/hQVKTw6PFuxpmWS8mp6XlbQYLPQgDoOLtBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W8hMS61Mhz4f3jsN
	for <netfs@lists.linux.dev>; Thu, 27 Jun 2024 09:49:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ADDA61A0572
	for <netfs@lists.linux.dev>; Thu, 27 Jun 2024 09:49:51 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHcX07xXxmqsa_AQ--.27477S3;
	Thu, 27 Jun 2024 09:49:51 +0800 (CST)
Message-ID: <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
Date: Thu, 27 Jun 2024 09:49:47 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
 <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHcX07xXxmqsa_AQ--.27477S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAHBV1jkH99LwAAsA

On 2024/6/26 11:28, Gao Xiang wrote:
>
>
> On 2024/6/26 11:04, Baokun Li wrote:
>> A gentle ping.
>
> Since it's been long time, I guess you could just resend
> a new patchset with collected new tags instead of just
> ping for the next round review?
>
> Thanks,
> Gao Xiang

Okay, if there's still no feedback this week, I'll resend this patch series.

Since both patch sets under review are now 5 patches and have similar
titles, it would be more confusing if they both had RESEND. So when I
resend it I will merge the two patch sets into one patch series.

-- 
With Best Regards,
Baokun Li


Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F01F934
	for <netfs@lists.linux.dev>; Fri, 28 Jun 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559305; cv=none; b=jgsARVvmuvELQDiQDfvVAkc7d9iOT343b/LhYIXKB/oZfkWO6ulm1KiMR4Asr4k/4ooQmArN5DKY5WnNCFE/+cGyC7/v0BmgCBm1RAq2+m08WwsfSUlc+aOi6HyhE47NtF+NhxQcY195ltABep4Kp3sAatTC2rYusTCaDmVWAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559305; c=relaxed/simple;
	bh=jstsD5F1mmwI3IOn9+JB22BT5GB52pFJXcbAWZgx4oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA7iEbk/HDXr9+nPKJ/U9u4HpsfiW+I8aZDXdTfNcdncuXWwo+tPCOzQQC+PwfIl+SWO4SxQ/V8sd2NDbLFw37mmatoV3wySfdAl5cuOSHN50yBFHlD/esigLSiMQWIRF0BDfKnv1GXC1Qyp9S+5Ifn358Qag++PtLJoUPbkeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K7Lk1RkA; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K7Lk1RkA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719559301; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AGBFJbCTt8aNt0KeD+i2UNzEgqWHOy1kpHd3ZOzb0Vs=;
	b=K7Lk1RkAWefcOcxcFo9LbVTusfdQGA3JxL++v1epjKlMMTFCEoCiAIhtI9LvhCYRrlP1reiEKvZtqvWiNPRwtJ/uolbCwKIm79qettFr2OGOwUBANJAqZXcVFFDntEYSw/77BMXK8SGOMd92EP5skSo58/zFncZr73GefrV3atk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PYzHJ_1719559299;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PYzHJ_1719559299)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 15:21:40 +0800
Message-ID: <860fd191-eecf-4044-8057-18fca747cceb@linux.alibaba.com>
Date: Fri, 28 Jun 2024 15:21:39 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] cachefiles: cancel all requests for the object
 that is being dropped
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-7-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Because after an object is dropped, requests for that object are useless,
> cancel them to avoid causing other problems.
> 
> This prepares for the later addition of cancel_work_sync(). After the
> reopen requests is generated, cancel it to avoid cancel_work_sync()
> blocking by waiting for daemon to complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433817BAE
	for <netfs@lists.linux.dev>; Sun, 24 Mar 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296832; cv=none; b=VVzYPRK7Rr/gU5CMZ08BSjb6pXQ8rF8MQORmON6jriY1qiI1aRI914IImvI+mkQbzgCrLW06M2aZB4YNhfy2MNCMlH26q3VmGmS8J3ghp3Du0iCykAbmPzzmPTyCifluxdZQvo9D+MR5HIQF36AsymiYIsv20z5dgIWt8UHlUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296832; c=relaxed/simple;
	bh=vhqt9ZinjbjoBKqGicEXCKpEb8FZbc99L1mo2JHNURs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M1QzeU/M4fzBWJmWQT1cw4T3DK9vNRK4Yw000azii5NAN3UaLVcE51mRetUreWK9DptosAJHiE62KSmhH9S7m+EbpIvSkHEHeAIVQtmOyyTLQEOuthGMI9DVDQh6adIqiRLLpzDeYO1n1at0hEZVCJ/uzz/rqca5jFL1REkbVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SGVDhCzO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SGVDhCzO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711296827; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YD2qF/pueOujQn1z/cs9uzD/XykzKvPN4vHrtfRNW4o=;
	b=SGVDhCzOeHndOhxnNyj1WNusvzphvgyab5+FxtHk0n0kPnjIs8HdQUAjcyI6NF+Bgxn3PBkS8PipjrHyA3bUuiLbWVyEtONRGjUj+Hg7yzSDtcjD0UpNTgEZSdM/hrPMQK1yyBFDXO+/Z1Ovj9rjEkt0FNgQ0YCLNMoB6mR1uTo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W37CXFj_1711296824;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W37CXFj_1711296824)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 00:13:46 +0800
Message-ID: <31f52bf0-9f74-4ee4-9139-7a8ff6d0de65@linux.alibaba.com>
Date: Mon, 25 Mar 2024 00:13:44 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
To: yangerkun <yangerkun@huawei.com>, dhowells@redhat.com,
 jlayton@kernel.org, netfs@lists.linux.dev
References: <20240323092312.1643320-1-yangerkun@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240323092312.1643320-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/23 17:23, yangerkun wrote:
> The name of debug config used in fs/netfs/internal.h has a mismatch
> compared to the define in fs/netfs/Kconfig, which lead to that debug for
> netfs won't work.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

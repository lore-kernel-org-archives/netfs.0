Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8B3236
	for <netfs@lists.linux.dev>; Mon,  3 Jun 2024 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717379613; cv=none; b=iC02itjTNiefkwmv/a20owXckEJoKOJ+4EyJzwuMJzwECaHjX4pWS09bkGk4hxlSOkNzbXkMVAJ7v3AGx3gukfJSYhiD726YtXWF2m3nXx9UtzXfHf/CXQ40/aPZspR26i9csuPsyM/o7gfhFeC1EsuKQAAxF0NoxJtI7n+f5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717379613; c=relaxed/simple;
	bh=nOG2xsPbOAqsmamziG+KXb4KAAjIbfN3FjSX4ldHGB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQfh9gERDXSMDLW8EapkX6lpLj4Z926nMURjXKozN3HDteG00ucF3y39xDezUTvYPa353swTQzmVU2qg+iXE4h8l1nePH4JDTdZqpk02DOdklF5iZciu2sFfMvTKh1bCs1LGXjSG+4NjVRSoTS/fZJzpvnnty0p2At8+mEd8D3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vUk+8ysU; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vUk+8ysU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717379608; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pjhhZYwivkjRu8TtHAyTGg6htPAN2KoUorXNi9/3dPI=;
	b=vUk+8ysU96VU4S4jgBlxzyts8k2eotetRzyGrdLchpWWJ8BaK7DdoBCMwi3DR7pP22Ku9KZUK8IPZB2l0k3/DVBCzGrk42/NzJ+UvVwgTLPovKXGCIqliRR6BlmivpexfP4LsAFLOYDrb/uAHYh778dSNE7+lhQrI3JzAw6y/VY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7fmLHU_1717379606;
Received: from 30.97.48.113(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7fmLHU_1717379606)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 09:53:27 +0800
Message-ID: <80e3f7fd-6a1c-4d88-84de-7c34984a5836@linux.alibaba.com>
Date: Mon, 3 Jun 2024 09:53:26 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] get rid of close_fd() misuse in cachefiles
To: Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>,
 Baokun Li <libaokun1@huawei.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <20240603001128.GG1629371@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240603001128.GG1629371@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/6/3 08:11, Al Viro wrote:
> 	fd_install() can't be undone by close_fd().  Just delay it
> until the last failure exit - have cachefiles_ondemand_get_fd()
> return the file on success (and ERR_PTR() on error) and let the
> caller do fd_install() after successful copy_to_user()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

It's a straight-forward fix to me, yet it will have a conflict with
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/fs/cachefiles?h=vfs.fixes&id=4b4391e77a6bf24cba2ef1590e113d9b73b11039
https://lore.kernel.org/all/20240522114308.2402121-10-libaokun@huaweicloud.com/

It also moves fd_install() to the end of the daemon_read() and tends
to fix it for months, does it look good to you?

Thanks,
Ga Xiang

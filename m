Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61742166F24
	for <netfs@lists.linux.dev>; Wed, 21 Aug 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208470; cv=none; b=ILv/0aeUHoKZjz7B1wAi88EUx6XmzHlX0m0Ru0SG07BD9CfA+pm85tCAJw5+MQbJ32ECa3A+WGFGbo2YG+rqi7r1FiHOF6Sgk1L+hPJy03ltQJL6JuF4U4CLIvP3R7bYrUbsqaDsOjI6s8xNk82PAme3adgpcx/uVghiLLr5PzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208470; c=relaxed/simple;
	bh=tVveER0WYmKJopDytIISrqD/UJRAUusARo2DVEQ9CxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkQnW4JPYv2+PvC0G7wCrW8RI6rkd3/g7wcYYaHNg6LiJJhYjuah3Hbd1xSOxUE3YIIqgdc/solGIbihZxdz1QR1ILL4ca0NBpMkMcI2zUG+yQA0tilEs6Q+a3pz0QNewCtmodBxzsB/Ykxo7atMYaeME1s9TFmtOkl96bOi2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WpW333xTCz1j6hF;
	Wed, 21 Aug 2024 10:47:43 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B80C180019;
	Wed, 21 Aug 2024 10:47:45 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:44 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 6/8] cachefiles: Modify inappropriate error return value in cachefiles_daemon_secctx()
Date: Wed, 21 Aug 2024 10:42:59 +0800
Message-ID: <20240821024301.1058918-7-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821024301.1058918-1-wozizhi@huawei.com>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)

In cachefiles_daemon_secctx(), if it is detected that secctx has been
written to the cache, the error code returned is -EINVAL, which is
inappropriate and does not distinguish the situation well.

Like cachefiles_daemon_dir(), fix this issue by return -EEXIST to the user
if it has already been defined once.

Fixes: 8667d434b2a9 ("cachefiles: Register a miscdev and parse commands over it")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a836..59e576951c68 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -587,7 +587,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 
 	if (cache->secctx) {
 		pr_err("Second security context specified\n");
-		return -EINVAL;
+		return -EEXIST;
 	}
 
 	secctx = kstrdup(args, GFP_KERNEL);
-- 
2.39.2


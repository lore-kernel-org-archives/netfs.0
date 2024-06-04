Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98086140E2F
	for <netfs@lists.linux.dev>; Tue,  4 Jun 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485307; cv=none; b=mXywPlbGgKYj7a+T1dI/aUgJP5mAIosM+iPVlTNpeMKGiQTbCsunRlmaw/3GVHszwq7LAirnN/DznPooXu0ZCp6H16lC28nBltACeyOsF/q36rMj4uiwpt876Kb0liCfeo3jD99MEGUY+tHM63h38MGkIcyREQmlPSNeJ8O6PYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485307; c=relaxed/simple;
	bh=BjJkIKcRhJcMNwuFbWpxRrGm5KJOyUquFeQv4/eVuSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s1tX5sT1morldRGRMJeYcVORE2L9rGiiX1tArYQffEVT/Ubp8Ry3izCXvK9vSYPUUPynXvaEVDrSV4wCSNQNHL9UYzQRMOfUn+U8wSohfrnNInMWg5dubc5Zzf6NrMnH4j/BSI0L8SwXw5Zm158pwRqdzem0zT1VeQa/pXCylYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VthZy5HZBzxRV8;
	Tue,  4 Jun 2024 15:11:06 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E031180AA7;
	Tue,  4 Jun 2024 15:15:02 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 15:13:31 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <dhowells@redhat.com>, <steved@redhat.com>, <Trond.Myklebust@netapp.com>,
	<viro@zeniv.linux.org.uk>
CC: <netfs@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] cachefiles: modify inappropriate error return value in cachefiles_daemon_secctx
Date: Tue, 4 Jun 2024 15:13:34 +0800
Message-ID: <20240604071334.3982185-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

In cachefiles_daemon_secctx(), if it is detected that secctx has been
written to the cache, the error code returned is -EINVAL, which is
inappropriate and does not distinguish the situation well.

Like cachefiles_daemon_dir(), fix this issue by return -EEXIST to the user
if it has already been defined once.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 6465e2574230..1b14849804f3 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -586,7 +586,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 
 	if (cache->secctx) {
 		pr_err("Second security context specified\n");
-		return -EINVAL;
+		return -EEXIST;
 	}
 
 	secctx = kstrdup(args, GFP_KERNEL);
-- 
2.39.2


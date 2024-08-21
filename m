Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05491CA81
	for <netfs@lists.linux.dev>; Wed, 21 Aug 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208467; cv=none; b=RP5IlkrOWkI+eNSHDz91tNJEXtMsjv+V/E2hcUl6O0+cypCren4IXvJLejT6wZIGUWano2lkLCffsRj9K26fe/5TbkLPaBdq9Swr0DxXpTo2cC1rHRm6Zi6zPbbny0QqQRVYczfRDyMeofKFP7j+bQ7NkFId/8UZ44B7awvNIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208467; c=relaxed/simple;
	bh=zTLILwH9+sCPY3CmLrlqDHHP8wHNJs53W50thIqSaYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR5KdPjDvALPBI6EPIoCgypq397/5Oc+TkYs6q2XMn5pfMfFPB+Dd/vANR/7T+1MNP+eLYiCp6z2B86TZ4msJGVmg41NHV9+czKCpwtycIv9y/P266CAgTzftl96euBbKAxJKstrkBLGrFB4hEN2CHZH8WXgKNaIsuTTa88Hq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpW0g5B3kzhXs4;
	Wed, 21 Aug 2024 10:45:39 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 219B61401E0;
	Wed, 21 Aug 2024 10:47:40 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:38 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 1/8] cachefiles: Fix incorrect block calculations in __cachefiles_prepare_write()
Date: Wed, 21 Aug 2024 10:42:54 +0800
Message-ID: <20240821024301.1058918-2-wozizhi@huawei.com>
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

In the __cachefiles_prepare_write function, DIO aligns blocks using
PAGE_SIZE as the unit. And currently cachefiles_add_cache() binds
cache->bsize with the requirement that it must not exceed PAGE_SIZE.
However, if cache->bsize is smaller than PAGE_SIZE, the calculated block
count will be incorrect in __cachefiles_prepare_write().

Set the block size to cache->bsize to resolve this issue.

Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index a91acd03ee12..59c5c08f921a 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -524,10 +524,10 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	struct cachefiles_cache *cache = object->volume->cache;
 	loff_t start = *_start, pos;
 	size_t len = *_len;
-	int ret;
+	int ret, block_size = cache->bsize;
 
 	/* Round to DIO size */
-	start = round_down(*_start, PAGE_SIZE);
+	start = round_down(*_start, block_size);
 	if (start != *_start || *_len > upper_len) {
 		/* Probably asked to cache a streaming write written into the
 		 * pagecache when the cookie was temporarily out of service to
@@ -537,7 +537,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 		return -ENOBUFS;
 	}
 
-	*_len = round_up(len, PAGE_SIZE);
+	*_len = round_up(len, block_size);
 
 	/* We need to work out whether there's sufficient disk space to perform
 	 * the write - but we can skip that check if we have space already
@@ -563,7 +563,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	 * space, we need to see if it's fully allocated.  If it's not, we may
 	 * want to cull it.
 	 */
-	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	if (cachefiles_has_space(cache, 0, *_len / block_size,
 				 cachefiles_has_space_check) == 0)
 		return 0; /* Enough space to simply overwrite the whole block */
 
@@ -595,7 +595,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	return ret;
 
 check_space:
-	return cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	return cachefiles_has_space(cache, 0, *_len / block_size,
 				    cachefiles_has_space_for_write);
 }
 
-- 
2.39.2


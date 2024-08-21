Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384A15445E
	for <netfs@lists.linux.dev>; Wed, 21 Aug 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208467; cv=none; b=tvsARZKIgiN+S0aWKRxlHP9MsPJbiPBHhQQEnPXDnH9E8pODB759wB8iEoX94bxO2CuzQb/k1rPgKCkrdKdYsjSGpyUniP7f18WLZd9jsknRXpcF7FrifukOKzSsDDjl4o630gv5RPhFimQkX+JkQbc/WSV42qn2Vek88fSY/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208467; c=relaxed/simple;
	bh=cBQs7GAprml/9QGERSnA/aBz9jiB2O4GPRaHBdajv3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baHGgC1Nh2dsWwtbuTKXCBcyeODiI4JFLmUOu7uR9r+nK/Hu+K9RvBYAZh57ioexUij7nf4bh09is5eBxt/M5UvM4Acbg5aHFaSjQNl2M4cJCWyQh5n6CkbHwp7ry8hlcyfsgu3MdjcnJRwph067hvVJhyK4WYCbjwLnbF5mOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpW2z226tz2CmxZ;
	Wed, 21 Aug 2024 10:47:39 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 285F31A0188;
	Wed, 21 Aug 2024 10:47:41 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:39 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 2/8] cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
Date: Wed, 21 Aug 2024 10:42:55 +0800
Message-ID: <20240821024301.1058918-3-wozizhi@huawei.com>
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

In the current on-demand loading mode, cachefiles_ondemand_fd_write_iter()
function first aligns "pos" and "len" to block boundaries. When calling
__cachefiles_write(), the aligned "pos" is passed in, but "len" is the
original unaligned value(iter->count). Additionally, the returned length of
the write operation is the modified "len" aligned by block size, which is
unreasonable.

The alignment of "pos" and "len" is intended only to check whether the
cache has enough space in erofs ondemand mode. But the modified len should
not be used as the return value of cachefiles_ondemand_fd_write_iter().
Doing so would result in a mismatch in the data written on-demand. For
example, if the length of the user state passed in is not aligned to the
block size (the preread scene / DIO writes only need 512 alignment), the
length of the write will differ from the actual length of the return.

To solve this issue, since the __cachefiles_prepare_write() modifies the
size of "len", we pass "aligned_len" to __cachefiles_prepare_write() to
calculate the free blocks and use the original "len" as the return value of
cachefiles_ondemand_fd_write_iter().

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/ondemand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 470c96658385..bdd321017f1c 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -61,7 +61,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 	struct cachefiles_object *object = kiocb->ki_filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file = object->file;
-	size_t len = iter->count;
+	size_t len = iter->count, aligned_len = len;
 	loff_t pos = kiocb->ki_pos;
 	const struct cred *saved_cred;
 	int ret;
@@ -70,7 +70,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 		return -ENOBUFS;
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(object, file, &pos, &len, len, true);
+	ret = __cachefiles_prepare_write(object, file, &pos, &aligned_len, len, true);
 	cachefiles_end_secure(cache, saved_cred);
 	if (ret < 0)
 		return ret;
-- 
2.39.2


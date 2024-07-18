Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D986F30E
	for <netfs@lists.linux.dev>; Thu, 18 Jul 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284390; cv=none; b=PUtfR6oHTIBx+RgF4NW5rKLr82O4sZRQt18eMt4SDIKTDrflxgu1GblXZEfiVNYou4Lx/1lFPKMURA5Yqbc4wwGqQsjQLUFlt8/8N4n+2nv1NpEoTmWLMVALljKGpdk14Si5sXyB+PlkGdfSO/UIsGPnl/OuiElyHPUEWidmzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284390; c=relaxed/simple;
	bh=YMnDd6zOCULS6n9VFCKsahuJpYnnM8+csu++1zLmR24=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=afl9b7ds61ecgwS7bbZP+3SwGlMS26nU9+5w1PK90S48iAFDIMsPehEvB8FAWMUO2/H01iGUo7ibL80mIFwtVJgGpP4lU7csaWn+6WqBKF3gPwkmp5Q6lx6pvXoux+8QJ/qzImn2JebbX6MQCc+K7qNKOnJdIy01t2wWv8kYcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WPjYn2W7Sz2ClL0;
	Thu, 18 Jul 2024 14:28:45 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E4F1A016C;
	Thu, 18 Jul 2024 14:33:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 14:33:04 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH v2] erofs: support STATX_DIOALIGN
Date: Thu, 18 Jul 2024 14:37:56 +0800
Message-ID: <20240718063756.2982763-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add support for STATX_DIOALIGN to erofs, so that direct I/O
alignment restrictions are exposed to userspace in a generic
way.

[Before]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:0
dio offset align:0
```

[After]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:512
dio offset align:512
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

---
v2:
  - Removing the non-bdev case for obtaining the bsize.

v1: https://lore.kernel.org/all/afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com/T/
---
 fs/erofs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..7c1163e47cb7 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -342,6 +342,23 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
+	/*
+	 * Return the DIO alignment restrictions if requested.
+	 *
+	 * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
+	 * the compressed file, so in these cases we report no DIO support.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		stat->result_mask |= STATX_DIOALIGN;
+		if (!erofs_is_fscache_mode(inode->i_sb) &&
+			!erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
+			struct block_device *bdev = inode->i_sb->s_bdev;
+
+			stat->dio_mem_align = bdev_logical_block_size(bdev);
+			stat->dio_offset_align = stat->dio_mem_align;
+		}
+	}
+
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
-- 
2.34.1


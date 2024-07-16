Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585E4D8A3
	for <netfs@lists.linux.dev>; Tue, 16 Jul 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133664; cv=none; b=XmYQG+yIR0ghZgMbV4ygw8yIDknLrRCWyqPsDOIP/qdowiGKOjap6Pt+5DiwI6eDeF6kz43zL4sl6xD6ltPek0s3xUkMl98m3Hb9iJZbDCIhoH14sgyPY5T4FBOyyL8muY6jodvMFQ1SUpBdLSFs+HXX2cTd242qybA6WUnIr/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133664; c=relaxed/simple;
	bh=50UIaMI/YZaGDR4KLnQ3LwKRz53ZGEn7p893qyn691s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jeH71xhx0rMb2FPNfKrTejXA7oFPGEz3/qomUUCIl/XRSAKkZSB7b+p0WU2eVW//W2+bz1+tRySOGGbr6hPyeS6bXrj2Tz0R39ru52LYlaMbSAtMYnOmmLSDLjzbk6TAH6KPDOkJ0ZCZAZEocM3jg46TRDzaP6j7OGY7zdnzv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WNdpW0Nc1zxSgK;
	Tue, 16 Jul 2024 20:36:03 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C0ABE14041A;
	Tue, 16 Jul 2024 20:40:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Jul
 2024 20:40:53 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH] erofs: support STATX_DIOALIGN
Date: Tue, 16 Jul 2024 20:45:34 +0800
Message-ID: <20240716124534.2358151-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 fs/erofs/inode.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..9325a6f0058a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
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
+			unsigned int bsize = (bdev) ? bdev_logical_block_size(bdev) :
+						i_blocksize(inode);
+
+			stat->dio_mem_align = bsize;
+			stat->dio_offset_align = bsize;
+		}
+	}
+
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
-- 
2.34.1


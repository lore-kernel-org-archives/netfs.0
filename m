Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57D3C6A6
	for <netfs@lists.linux.dev>; Thu, 18 Jul 2024 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264461; cv=none; b=K44hdFYYmJF4xIgY9p9d5dae1WEUvfhaszaYl4X7ctVXuDJSC5nX3g9QjOdGd3Pe2tGOPbW7932kauq63afdn/sDzL9gxsVA7gqj3HxEHbc+LIqWB80sL4dEz15DwChLvhBeozeX8RzAxbteTbUcJEhCUwa6PVCH4cSxrzsMIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264461; c=relaxed/simple;
	bh=Tq+J8mdEGsRDKbacvfAv5+dnTia2oBqwFn5pvashuYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bIZGnCpHE2VoxOgl8pQRuBlr6Ej8WrJuHxI8kMmE+K6TZHmBConYP4q5gppFzYON+XpBOVXmD5QkzBazuqjBVfGJ/Ui7ByukIvHmp8aoSQEe/FqEk4uMzqOfsjx3YDyNsoODbd2tV0meJqHx5t1FStqzHxhlaV1U68atF8n9xaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WPZFW05w1zdhH7;
	Thu, 18 Jul 2024 08:59:11 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 10AF9140416;
	Thu, 18 Jul 2024 09:00:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 09:00:54 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH] erofs: support direct IO for ondemand mode
Date: Thu, 18 Jul 2024 09:05:45 +0800
Message-ID: <20240718010545.2869515-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

erofs over fscache cannot handle the direct read io. When the file
is opened with O_DIRECT flag, -EINVAL will reback. We support the
DIO in erofs over fscache by bypassing the erofs page cache and
reading target data into ubuf from fscache's file directly.

The alignment for buffer memory, offset and size now is restricted
by erofs, since `i_blocksize` is enough for the under filesystems.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/data.c    |  3 ++
 fs/erofs/fscache.c | 95 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8be60797ea2f..dbfafe358de4 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -391,6 +391,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		     iov_iter_alignment(to)) & blksize_mask)
 			return -EINVAL;
 
+		if (erofs_is_fscache_mode(inode->i_sb))
+			return generic_file_read_iter(iocb, to);
+
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
 				    NULL, 0, NULL, 0);
 	}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..f5a09b168539 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -35,6 +35,8 @@ struct erofs_fscache_io {
 
 struct erofs_fscache_rq {
 	struct address_space	*mapping;	/* The mapping being accessed */
+	struct iov_iter		*iter;		/* dst buf for direct io */
+	struct completion	done;		/* for synced direct io */
 	loff_t			start;		/* Start position */
 	size_t			len;		/* Length of the request */
 	size_t			submitted;	/* Length of submitted */
@@ -76,7 +78,11 @@ static void erofs_fscache_req_put(struct erofs_fscache_rq *req)
 {
 	if (!refcount_dec_and_test(&req->ref))
 		return;
-	erofs_fscache_req_complete(req);
+
+	if (req->iter)
+		complete(&req->done);
+	else
+		erofs_fscache_req_complete(req);
 	kfree(req);
 }
 
@@ -88,6 +94,7 @@ static struct erofs_fscache_rq *erofs_fscache_req_alloc(struct address_space *ma
 	if (!req)
 		return NULL;
 	req->mapping = mapping;
+	req->iter = NULL;
 	req->start = start;
 	req->len = len;
 	refcount_set(&req->ref, 1);
@@ -253,6 +260,55 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 	return ret;
 }
 
+static int erofs_fscache_data_dio_read(struct erofs_fscache_rq *req)
+{
+	struct address_space *mapping = req->mapping;
+	struct inode *inode = mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct iov_iter *iter = req->iter;
+	struct erofs_fscache_io *io;
+	struct erofs_map_blocks map;
+	struct erofs_map_dev mdev;
+	loff_t pos = req->start + req->submitted;
+	size_t count;
+	int ret;
+
+	map.m_la = pos;
+	ret = erofs_map_blocks(inode, &map);
+	if (ret)
+		return ret;
+
+	count = req->len - req->submitted;
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		iov_iter_zero(count, iter);
+		req->submitted += count;
+		return 0;
+	}
+
+	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
+	DBG_BUGON(!count || count % PAGE_SIZE);
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map.m_deviceid,
+		.m_pa = map.m_pa,
+	};
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		return ret;
+
+	io = erofs_fscache_req_io_alloc(req);
+	if (!io)
+		return -ENOMEM;
+
+	iov_iter_ubuf(&io->iter, ITER_DEST, iter->ubuf + iter->iov_offset, count);
+	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie, mdev.m_pa + (pos - map.m_la), io);
+	iov_iter_advance(iter, io->iter.iov_offset);
+	erofs_fscache_req_io_put(io);
+
+	req->submitted += count;
+	return ret;
+}
+
 static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 {
 	struct address_space *mapping = req->mapping;
@@ -324,12 +380,13 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	return ret;
 }
 
-static int erofs_fscache_data_read(struct erofs_fscache_rq *req)
+static int erofs_fscache_data_read(struct erofs_fscache_rq *req, bool direct)
 {
 	int ret;
 
 	do {
-		ret = erofs_fscache_data_read_slice(req);
+		ret = (direct) ? erofs_fscache_data_dio_read(req)
+				: erofs_fscache_data_read_slice(req);
 		if (ret)
 			req->error = ret;
 	} while (!ret && req->submitted < req->len);
@@ -348,7 +405,7 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 		return -ENOMEM;
 	}
 
-	ret = erofs_fscache_data_read(req);
+	ret = erofs_fscache_data_read(req, false);
 	erofs_fscache_req_put(req);
 	return ret;
 }
@@ -369,8 +426,35 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 	while (readahead_folio(rac))
 		;
 
-	erofs_fscache_data_read(req);
+	erofs_fscache_data_read(req, false);
+	erofs_fscache_req_put(req);
+}
+
+static ssize_t erofs_fscache_directIO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	size_t count = iov_iter_count(iter);
+	struct erofs_fscache_rq *req;
+	struct completion *ctr;
+	ssize_t rsize;
+	int ret;
+
+	if (unlikely(iov_iter_rw(iter) == WRITE))
+		return -EROFS;
+
+	req = erofs_fscache_req_alloc(file->f_mapping, iocb->ki_pos, count);
+	if (!req)
+		return -ENOMEM;
+
+	req->iter = iter;
+	init_completion(&req->done);
+	ctr = &req->done;
+	ret = erofs_fscache_data_read(req, true);
+	rsize = (ret == 0) ? (ssize_t)req->submitted : ret;
 	erofs_fscache_req_put(req);
+	wait_for_completion(ctr);
+
+	return rsize;
 }
 
 static const struct address_space_operations erofs_fscache_meta_aops = {
@@ -380,6 +464,7 @@ static const struct address_space_operations erofs_fscache_meta_aops = {
 const struct address_space_operations erofs_fscache_access_aops = {
 	.read_folio = erofs_fscache_read_folio,
 	.readahead = erofs_fscache_readahead,
+	.direct_IO = erofs_fscache_directIO,
 };
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
-- 
2.34.1


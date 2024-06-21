Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7012F37F
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950534; cv=none; b=toNCMghx65Te96fDBGHA9aNmQBwa3YViwHNdES8wkBZzpHKladKIP/j/LNZK+YaoH7nsWY56snod7AOMFd+7f4apGa13Rt+WMzN/O1NpxQ9Pxgz20nvRReo0rRAAoQnFKN6eaeCP88o+Loo72p5LrF/qxBjEP0nn9z4NMjQg0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950534; c=relaxed/simple;
	bh=bWQsSOHl7FmW2soC2aFOM4bmQc7hOmKEkuPy2LIiNoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cdg9YAbE4czDmZk6pGakN9urV4oVIccLtSKD2B4N1LsegBr8u+ioWYKQD/ZIf2OGiB4hNJYfAhFa6mNxwyzzo6VqdJdAMwC3scQK0fWBvmUC/CxpoVkKy13WrjiMLFE3sRZAToiXvtfz+DytWGzXY93wtmfuo09GLXCAJ2ZAhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W56Sn5hhgzPpbC;
	Fri, 21 Jun 2024 14:11:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AA7F1400C8;
	Fri, 21 Jun 2024 14:15:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 14:15:28 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH 1/2] erofs: support query erofs ondemand feature by sysfs interface
Date: Fri, 21 Jun 2024 14:18:07 +0800
Message-ID: <20240621061808.1585253-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621061808.1585253-1-lihongbo22@huawei.com>
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Erofs over fscache depands on the config CONFIG_EROFS_FS_ONDEMAND
in erofs. There is no way to check whether this feature is supported
or not in userspace. We introduce sysfs file `erofs_ondemand` for
user checking current features. Here is the example:

[Before]
$ cat /sys/fs/erofs/features/erofs_ondemand
cat: /sys/fs/erofs/features/erofs_ondemand: No such file or directory

[After]
$ cat /sys/fs/erofs/features/erofs_ondemand
supported

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..1b3d77583f76 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -78,6 +78,9 @@ EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
+#if IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)
+EROFS_ATTR_FEATURE(erofs_ondemand);
+#endif
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -90,6 +93,9 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
+#if IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)
+	ATTR_LIST(erofs_ondemand),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
-- 
2.34.1


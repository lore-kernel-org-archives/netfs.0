Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF214E2ED
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950539; cv=none; b=CCm1FnoMKVnwEcXCyXsWHu1OT50TXxlz/t7g1Mp2FGJPo8S9pp+Br3wYymDgu23PtrNslQi20tozVnM07aND4o/YGUiKmi9S0Oz4t+haVuwiFEjts6ARHR8G035HlDQd7PTyP0bCYWGCqgrnvmBBGZvBtqJvrXIar7C88wKbyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950539; c=relaxed/simple;
	bh=fbuZDZXA5ohP9YsaQrRyZ6A3VUU9IlExZVfmcWsdbpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPBYUxSA7GPtDD5K3BXgNqvn3FwC6ujIuXF1vptI+zfC4Zq7gnGikOg4qewB67yrZxSxW9vfjkoObzsWcQhy7OuPnghL4CnedgzbdbxK1fl3Je9A2VSD/Kp19FXetKI+I2KOACa4nrkmvgZhxfO5pONlyDpW6UlFXEFQBXoVMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W56S34yMTzxSbV;
	Fri, 21 Jun 2024 14:11:15 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C4783180088;
	Fri, 21 Jun 2024 14:15:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 14:15:29 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
Date: Fri, 21 Jun 2024 14:18:08 +0800
Message-ID: <20240621061808.1585253-3-lihongbo22@huawei.com>
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

Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
module. We cannot know whether it is supported from userspace, so
we export this feature to user by sysfs interface.

[Before]
$ cat /sys/fs/cachefiles/features/cachefiles_ondemand
cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or directory

[After]
$ cat /sys/fs/cachefiles/features/cachefiles_ondemand
supported

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/cachefiles/Makefile   |   3 +-
 fs/cachefiles/internal.h |   7 +++
 fs/cachefiles/main.c     |   7 +++
 fs/cachefiles/sysfs.c    | 101 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 fs/cachefiles/sysfs.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index c37a7a9af10b..e5d9dd27f94f 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -13,7 +13,8 @@ cachefiles-y := \
 	namei.o \
 	security.o \
 	volume.o \
-	xattr.o
+	xattr.o \
+	sysfs.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
 cachefiles-$(CONFIG_CACHEFILES_ONDEMAND) += ondemand.o
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6845a90cdfcc..4926684b3044 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -419,6 +419,13 @@ extern void cachefiles_prepare_to_write(struct fscache_cookie *cookie);
 extern bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume);
 extern int cachefiles_check_volume_xattr(struct cachefiles_volume *volume);
 
+/*
+ * sysfs.c
+ */
+
+int __init cachefiles_init_sysfs(void);
+void cachefiles_exit_sysfs(void);
+
 /*
  * Error handling
  */
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 3f369c6f816d..0dcad6bb4b1f 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -64,9 +64,15 @@ static int __init cachefiles_init(void)
 		goto error_object_jar;
 	}
 
+	ret = cachefiles_init_sysfs();
+	if (ret)
+		goto sysfs_err;
+
 	pr_info("Loaded\n");
 	return 0;
 
+sysfs_err:
+	kmem_cache_destroy(cachefiles_object_jar);
 error_object_jar:
 	misc_deregister(&cachefiles_dev);
 error_dev:
@@ -85,6 +91,7 @@ static void __exit cachefiles_exit(void)
 {
 	pr_info("Unloading\n");
 
+	cachefiles_exit_sysfs();
 	kmem_cache_destroy(cachefiles_object_jar);
 	misc_deregister(&cachefiles_dev);
 	cachefiles_unregister_error_injection();
diff --git a/fs/cachefiles/sysfs.c b/fs/cachefiles/sysfs.c
new file mode 100644
index 000000000000..adfb260df59c
--- /dev/null
+++ b/fs/cachefiles/sysfs.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+
+#include "internal.h"
+
+enum {
+	attr_feature,
+};
+
+struct cachefiles_attr {
+	struct attribute attr;
+	short attr_id;
+};
+
+#define CACHEFILES_ATTR(_name, _mode, _id)				\
+static struct cachefiles_attr cachefiles_attr_##_name = {		\
+	.attr = {.name = __stringify(_name), .mode = _mode },		\
+	.attr_id = attr_##_id,						\
+}
+
+#define CACHEFILES_ATTR_FEATURE(_name) CACHEFILES_ATTR(_name, 0444, feature)
+
+#define ATTR_LIST(name) (&cachefiles_attr_##name.attr)
+
+/* supported features of cachefiles */
+#if IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND)
+CACHEFILES_ATTR_FEATURE(cachefiles_ondemand);
+#endif
+
+static struct attribute *cachefiles_feat_attrs[] = {
+#if IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND)
+	ATTR_LIST(cachefiles_ondemand),
+	NULL,
+#endif
+};
+
+ATTRIBUTE_GROUPS(cachefiles_feat);
+
+static ssize_t cachefiles_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct cachefiles_attr *a = container_of(attr, struct cachefiles_attr, attr);
+
+	switch (a->attr_id) {
+	case attr_feature:
+		return sysfs_emit(buf, "supported\n");
+	}
+
+	return 0;
+};
+
+static const struct sysfs_ops cachefiles_attr_ops = {
+	.show = cachefiles_attr_show,
+};
+
+static const struct kobj_type cachefiles_ktype = {
+	.sysfs_ops	= &cachefiles_attr_ops,
+};
+
+static struct kset cachefiles_root = {
+	.kobj	= {.ktype = &cachefiles_ktype},
+};
+
+static const struct kobj_type cachefiles_feat_ktype = {
+	.default_groups = cachefiles_feat_groups,
+	.sysfs_ops	= &cachefiles_attr_ops,
+};
+
+static struct kobject cachefiles_feat = {
+	.kset	= &cachefiles_root,
+};
+
+int __init cachefiles_init_sysfs(void)
+{
+	int ret;
+
+	kobject_set_name(&cachefiles_root.kobj, "cachefiles");
+	cachefiles_root.kobj.parent = fs_kobj;
+	ret = kset_register(&cachefiles_root);
+	if (ret)
+		goto root_err;
+
+	ret = kobject_init_and_add(&cachefiles_feat, &cachefiles_feat_ktype,
+				   NULL, "features");
+	if (ret)
+		goto feat_err;
+	return ret;
+
+feat_err:
+	kobject_put(&cachefiles_feat);
+	kset_unregister(&cachefiles_root);
+root_err:
+	return ret;
+}
+
+void cachefiles_exit_sysfs(void)
+{
+	kobject_put(&cachefiles_feat);
+	kset_unregister(&cachefiles_root);
+}
-- 
2.34.1


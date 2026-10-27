Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101094;
	b=ZDImmi+uNRxXv80N4E7ciaYfiypaG+myhytTfC+2n0u1lA1Q8oWjRjFVAFL78kHd1RVL
	 RABzER853AgiYwvtBTcwI2jfq0LC0wbXlMVpiiZ9Az5Tt4CUqxXseeik+EpR0+XUOE8Np
	 JHOMAreRo1nMMl2ZVNrUjY1Q/y8Iuv4+yVrdOBtyTjdni8FG/0Ko2+JbZcKhSlafTxkJk
	 W/sOxNiih6CQJH1D29/LoJwnzFVlLq3Ca+jaaAXd7Eg8ku+swc2GfDv1k8UmJnYxeXllZ
	 6iZuuZHiVSetd3Dqy3M/O66qgBNT1x6Jr+nOdThov9WtP20+FxfnmQ5qsoKubrnGjcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101094;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=JfpVKuD2c8m+x8YnNo1YT+TLS2gp2d1+wadhplkCwn8=;
	b=BEIOncKB2MvVwS0aNdhbbLSt/LX4LNW7mg6fEOKk+YqhjReS7omHU1O7byMyYiKqOFGI
	 JspzK//cyivFJtkxYxdT6VBVWlgZaH5DLxmLH1GydlGiUzy49j6XKXtMUp7VadlTyC2r6
	 K51T7P76Y2tH6WDjoFqgzWj09Nebi8/KqbT895s00jCJkbq9ih3nkGDAdPjaP9PYwVhxf
	 WfTRXKikShbyo+0B+9hO5IuY+DhlYeqratBcTt12SoxAe11H3F25ORoRjotpRszqj3mHc
	 K1qNo0mwfXFNdG9pdmLI9Hu3nf3LO3ujkjUSlt4VW7lMD/L0hByBAdNEKTDROEhOpJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UlrU2kN8;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965F606A33A;
	Tue, 27 Oct 2026 11:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4965F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UlrU2kN8
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JfpVKuD2c8m+x8YnNo1YT+TLS2gp2d1+wadhplkCwn8=;
	b=UlrU2kN8vopSF5YEuzVRwXgOVqYodeFRpXuROtLPyXjVbxaXo/Pwj1GqU15nzIo1c+1/N1/l+
	rfKJ5hjNQOSsDbl3ZSxpBVECQhC2Qmva8qGl0kOC/TJYqKALQQeHzG/iM25lSyO+JYf0dz357Qe
	rvUOoqMJfDTSll+4EtlchsM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jDT574Kmvz1prLP;
	Tue, 27 Oct 2026 19:38:03 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 24F414057D;
	Tue, 27 Oct 2026 19:38:11 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 27 Oct 2026 19:38:05 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <mic@digikod.net>, <gnoack@google.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <utilityemal77@gmail.com>,
	<caixinchen1@huawei.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <rdunlap@infradead.org>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<johan@kernel.org>, <dlemoal@kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<dhowells@redhat.com>, <code@tyhicks.com>, <linkinjeon@kernel.org>,
	<sj1557.seo@samsung.com>, <yuezhang.mo@sony.com>,
	<hirofumi@mail.parknet.co.jp>, <cel@kernel.org>, <jlayton@kernel.org>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <hyc.lee@gmail.com>, <miklos@szeredi.hu>,
	<amir73il@gmail.com>, <senozhatsky@chromium.org>,
	<chenxiaosong@chenxiaosong.com>, <dsterba@suse.com>, <mason@kernel.org>,
	<kpsingh@kernel.org>, <matt@bobrowski.net>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<john.johansen@canonical.com>, <georgia.garcia@canonical.com>,
	<zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<stephen.smalley.work@gmail.com>, <omosnacek@gmail.com>,
	<casey@schaufler-ca.com>, <takedakn@nttdata.co.jp>,
	<penguin-kernel@I-love.SAKURA.ne.jp>, <xiujianfeng@huawei.com>,
	<nanx95726@gmail.com>, <djwong@kernel.org>, <lujialin4@huawei.com>,
	<bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-block@vger.kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netfs@lists.linux.dev>, <ecryptfs@vger.kernel.org>, <exfat@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <ntfs@lists.linux.dev>,
	<linux-unionfs@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<linux-integrity@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 -next 02/18] LSM: pass struct path to the inode_setsecctx hook
Date: Tue, 27 Oct 2026 20:11:35 +0800
Message-ID: <20261027121151.1887650-3-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261027121151.1887650-1-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100010.china.huawei.com (7.152.184.41)

The inode_setsecctx hook and its security_inode_setsecctx() caller
in fs/nfsd operate on a dentry even though both have a struct path
available.  The SELinux and Smack implementations write the label
through __vfs_setxattr_locked(), whose idmap argument they hardcode
to &nop_mnt_idmap.

Switch the hook to take a const struct path so that the upcoming
conversion of the xattr helpers to struct path can be reflected
directly in the implementations.  For now the implementations keep
passing &nop_mnt_idmap together with path->dentry to
__vfs_setxattr_locked(), preserving the current behavior; they will
be switched to pass the path itself once the xattr helpers take one.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 fs/nfsd/vfs.c                 | 2 +-
 include/linux/lsm_hook_defs.h | 7 ++++++-
 include/linux/security.h      | 4 ++--
 security/security.c           | 6 +++---
 security/selinux/hooks.c      | 6 +++---
 security/smack/smack_lsm.c    | 6 +++---
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 54440029c235..8d5abfbc71aa 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -626,7 +626,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			break;
 	}
 	if (attr->na_seclabel && attr->na_seclabel->len)
-		attr->na_labelerr = security_inode_setsecctx(dentry,
+		attr->na_labelerr = security_inode_setsecctx(&path,
 			attr->na_seclabel->data, attr->na_seclabel->len);
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_dpacl) {
 		if (!S_ISDIR(inode->i_mode))
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 87d9d06710cb..539525648b30 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -313,7 +313,12 @@ LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
+/*
+ * The @path argument is only sanctioned to be passed to VFS helpers
+ * taking a struct path; the VFS makes no guarantees with regard to
+ * @path->mnt.
+ */
+LSM_HOOK(int, 0, inode_setsecctx, const struct path *path, void *ctx, u32 ctxlen)
 LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode,
 	 struct lsm_context *cp)
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab5470..225f822470e2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -588,7 +588,7 @@ int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_setsecctx(const struct path *path, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
@@ -1630,7 +1630,7 @@ static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u3
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static inline int security_inode_setsecctx(const struct path *path, void *ctx, u32 ctxlen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index f6583d507395..49cd3393c207 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4109,7 +4109,7 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
 
 /**
  * security_inode_setsecctx() - Change the security label of an inode
- * @dentry: inode
+ * @path: inode (the VFS makes no guarantees with regard to @path->mnt)
  * @ctx: secctx
  * @ctxlen: length of secctx
  *
@@ -4123,9 +4123,9 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+int security_inode_setsecctx(const struct path *path, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_setsecctx, dentry, ctx, ctxlen);
+	return call_int_hook(inode_setsecctx, path, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 50ed4d6b4607..9d7467fe73c5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7143,10 +7143,10 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int selinux_inode_setsecctx(const struct path *path, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
-				     ctx, ctxlen, 0, NULL);
+	return __vfs_setxattr_locked(&nop_mnt_idmap, path->dentry,
+				     XATTR_NAME_SELINUX, ctx, ctxlen, 0, NULL);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3524649f402d..953461571026 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4978,10 +4978,10 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 				       ctxlen, 0);
 }
 
-static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int smack_inode_setsecctx(const struct path *path, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
-				     ctx, ctxlen, 0, NULL);
+	return __vfs_setxattr_locked(&nop_mnt_idmap, path->dentry,
+				     XATTR_NAME_SMACK, ctx, ctxlen, 0, NULL);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
-- 
2.18.0.huawei.25


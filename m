Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31C39A05F
	for <netfs@lists.linux.dev>; Wed, 13 May 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668459; cv=none; b=h3Hl+s2eEesB+d+slHHqG05iVwVGIkWjA7m9qeauERsIeFJ9B1n2Tvb48jALxz7qHAGqTpNDlD5PI3w8tfsA1mJNaZh/f0SW53v5h3/SO/jzV43NlgofewmV7uAuW5C68oKvAmJI+AMUrQeAhReg518BVHExN0fVHY1hy8bRWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668459; c=relaxed/simple;
	bh=HmFPZ2EVv0EItKfgN89az3jPZSHn2KDQOeh3Ijet1NA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e5fg17PgxsYGe/vN+OKNv9qYZx2CIxRCaS9TQ2M1C41HZO4T4RCwoMAjyp5Zq9VGdGCsOsRWnwJ7v2AGBlcwK34zU9whIu4VZzdkMSLsBdogzj8kqXyHcbw2ytfW9m+WknjaAiYIYef9VuAqgA2xvhRoXudD91xJKlfphDG2onU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 479ab16e4eb711f1aa26b74ffac11d73-20260513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:962cf164-dea6-4f66-aaa8-3e339579799e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:82a2b07a98307929fa8c400cd12525c8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 479ab16e4eb711f1aa26b74ffac11d73-20260513
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1691215516; Wed, 13 May 2026 18:34:11 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	brauner@kernel.org
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] cachefiles: Fix error return when vfs_mkdir() fails
Date: Wed, 13 May 2026 18:34:06 +0800
Message-Id: <20260513103406.202320-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vfs_mkdir() fails, the error code is not extracted from the
returned error pointer. This causes mkdir_error to be reached with
ret=0, which leads to returning ERR_PTR(0) (NULL) instead of a
proper error pointer.

Fix this by extracting the error code from the error pointer when
vfs_mkdir() fails.

Fixes: 406fad7698f5 ("cachefiles: Fix oops in vfs_mkdir from cachefiles_get_directory")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/cachefiles/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 1b83ed0e0a63..2937db690b40 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -130,6 +130,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = cachefiles_inject_write_error();
 		if (ret == 0) {
 			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700, NULL);
+			if (IS_ERR(subdir))
+				ret = PTR_ERR(subdir);
 		} else {
 			end_creating(subdir);
 			subdir = ERR_PTR(ret);
-- 
2.25.1


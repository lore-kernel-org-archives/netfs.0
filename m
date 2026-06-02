Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08378EEBB
	for <netfs@lists.linux.dev>; Tue,  2 Jun 2026 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380984; cv=none; b=qc2CLLd10bdzy2IgkoKYGZbir1GWDARqm8IrMby0GWSm+sKUQHstXRgNy+rj7JeUl2t/SzmjarcJRhEynFsrohHkXKTvAhFv5vpfTFV0dNzQh9IlCahbmZLfLUNs9dlGT2ZVu2l91Rro+YKbLsP9ZDajIGVIJgJor84LPswGbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380984; c=relaxed/simple;
	bh=VRJu0OVmfKACr1WDsCsSLwqbG7GvPbEyL7QBHbLqjuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XkA/IL+WkQYzJUn8NGO+g4DR64LP2MXAhStBLoR1jcl1Xl1adV3jXGbAI+2a+nbLZCwbkudTMtt4d+a1pBxh60hcSIGMlHd28p30grSvXfiss0622wSA3zKHkWWcZvIF/DVTnGlytapegFcyn6CaxIGCY3xZCkUIOWR3eJCg2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8d9559605e4a11f1aa26b74ffac11d73-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:561e01a4-bd4c-4b00-bd75-8b6875fab248,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:bb73024059eeb8108bfaa37c258aafba,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8d9559605e4a11f1aa26b74ffac11d73-20260602
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1437053500; Tue, 02 Jun 2026 14:16:12 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: dhowells@redhat.com,
	neil@brown.name,
	brauner@kernel.org,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] cachefiles: Fix double unlock in nomem_d_alloc error path
Date: Tue,  2 Jun 2026 14:16:07 +0800
Message-Id: <20260602061607.126024-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When start_creating() fails and returns -ENOMEM, it has already
released the parent directory lock in __start_dirop():

    static struct dentry *__start_dirop(...)
    {
        ...
        inode_lock_nested(dir, I_MUTEX_PARENT);
        dentry = lookup_one_qstr_excl(name, parent, lookup_flags);
        if (IS_ERR(dentry))
            inode_unlock(dir);  <-- Lock released on error
        return dentry;
    }

However, the nomem_d_alloc error path in cachefiles_get_directory()
unconditionally calls inode_unlock(d_inode(dir)) again, causing a
double unlock that corrupts the rwsem state.

This is a leftover from commit 7ab96df840e60 which replaced manual
locking with start_creating() but failed to update the nomem_d_alloc
path (while correctly updating mkdir_error and lookup_error paths).

Fixes: 7ab96df840e6 ("VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/cachefiles/namei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2937db690b40..2c46f0decb02 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -209,7 +209,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	return ERR_PTR(ret);
 
 nomem_d_alloc:
-	inode_unlock(d_inode(dir));
 	_leave(" = -ENOMEM");
 	return ERR_PTR(-ENOMEM);
 }
-- 
2.25.1


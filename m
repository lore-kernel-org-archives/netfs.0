Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76354903
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763395; cv=none; b=uMEh33YGv+Z1RJuwzsh1JPuLuYoWtl/oWS200u7S0v3plcJd7EAeI4d5u1UOHaa/8nbA+8XExIeCghFezR1bbWxq8KykL1VRcI4jgeD5mbbpsp/4kzxGu36fUV0lAysIvLlWodpqD6x6g/PmjAFkxbesV/U1FJslpjmIpCXFQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763395; c=relaxed/simple;
	bh=AH/TZSjcyKVJB0HH2M9N0FapggpI4cVYyr6DcjUGzWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGBiNK+6PpWEV3MAMcnsQwBaSgKie86qzFoiJ34CKifd8Wjylz7bfIKgrCKjtQbvwLH/AXwdQEZFWdVbefv3ZvE9NUZoOk9typ67yt47Fl+6K0VQfl1AlBgaCiJhiEQlPsvdDESci+S6DkmCrVRRtFeeWRWUXDfye+4CNRHIE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfRsd0gmCz4f3lgB
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 16:56:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 451D71A0E1B
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 16:56:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxC7eERm68LgMg--.42328S6;
	Wed, 15 May 2024 16:56:31 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 02/12] cachefiles: remove err_put_fd tag in cachefiles_ondemand_daemon_read()
Date: Wed, 15 May 2024 16:45:51 +0800
Message-Id: <20240515084601.3240503-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515084601.3240503-1-libaokun@huaweicloud.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxC7eERm68LgMg--.42328S6
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy7WryUAr1DtFyxKr17ZFb_yoWkArb_uF
	92vr1kZr4fCF1fXw42vr90qFWqg3y8A3WFqws8GFy2ya98JrW3Jr4Dtry7Ary3W3y8GF1q
	yr4kZ3WjqrnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUby8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0JUBmhrUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

The err_put_fd tag is only used once, so remove it to make the code more
readable.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/ondemand.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 4ba42f1fa3b4..fd49728d8bae 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
-		goto err_put_fd;
+		if (msg->opcode == CACHEFILES_OP_OPEN)
+			close_fd(((struct cachefiles_open *)msg->data)->fd);
+		goto error;
 	}
 
 	/* CLOSE request has no reply */
@@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	return n;
 
-err_put_fd:
-	if (msg->opcode == CACHEFILES_OP_OPEN)
-		close_fd(((struct cachefiles_open *)msg->data)->fd);
 error:
 	xa_erase(&cache->reqs, id);
 	req->error = ret;
-- 
2.39.2


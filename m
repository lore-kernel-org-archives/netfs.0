Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831579B96
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349807; cv=none; b=WRfUwFQ61C0taoFECS8F+c2kHq8zJk1dmRYd2N747AVQU7rlyrPdVnOvT1y+faXsc7YXx+MvJZsSennGWF0nOyFyyMuK704z8Dp08KQprsHGuzpAEohMp5w3+sai2z3dIdcJCtf8lfKvloBY9Xb4eX7amBFYC4UsX10LvCA95EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349807; c=relaxed/simple;
	bh=1VesqAjR/ithgpkYnQ975NMfRqNMygcAMQValyCxEOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1w6MD8PSkK84xGYuoM4gbU2iTz/uKzmfTWpnnySpCyExx+/zA3OLf0sCMFKUnhUJjcqISsUTrI3aQGTyI0OEPPhEWZbZnqzB26gUfWddnCO0WhKICty9bTKDxJmUxR92UJjn654f4sky5DT1ck5n+1ZGSfsQ3oo2c+x7TntQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckg0m2Fz4f3lfx
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 11:49:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 923841A0199
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 11:49:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S9;
	Wed, 22 May 2024 11:49:57 +0800 (CST)
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
Subject: [PATCH v3 05/12] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
Date: Wed, 22 May 2024 19:43:01 +0800
Message-Id: <20240522114308.2402121-6-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFea01mxlBXNQ--.57627S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3ArWDtw1kKF18Jr1kKrg_yoW5Wr43pF
	WSyay7Kry8WF48Crn7A3W5X34rt3y8Z3ZrW3y0qw1fArnIqr15Zr18tF15ZFy5ArWvgrsx
	tw18CFZrGryjq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
	wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
	IErcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREMKZDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

The err_put_fd label is only used once, so remove it to make the code
more readable. In addition, the logic for deleting error request and
CLOSE request is merged to simplify the code.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/cachefiles/ondemand.c | 45 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 3dd002108a87..bb94ef6a6f61 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -305,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 {
 	struct cachefiles_req *req;
 	struct cachefiles_msg *msg;
-	unsigned long id = 0;
 	size_t n;
 	int ret = 0;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
@@ -340,49 +339,37 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
-	id = xas.xa_index;
-
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
 		if (ret) {
 			cachefiles_ondemand_set_object_close(req->object);
-			goto error;
+			goto out;
 		}
 	}
 
-	msg->msg_id = id;
+	msg->msg_id = xas.xa_index;
 	msg->object_id = req->object->ondemand->ondemand_id;
 
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
-		goto err_put_fd;
-	}
-
-	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-	/* CLOSE request has no reply */
-	if (msg->opcode == CACHEFILES_OP_CLOSE) {
-		xa_erase(&cache->reqs, id);
-		complete(&req->done);
+		if (msg->opcode == CACHEFILES_OP_OPEN)
+			close_fd(((struct cachefiles_open *)msg->data)->fd);
 	}
-
-	cachefiles_req_put(req);
-	return n;
-
-err_put_fd:
-	if (msg->opcode == CACHEFILES_OP_OPEN)
-		close_fd(((struct cachefiles_open *)msg->data)->fd);
-error:
+out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-	xas_reset(&xas);
-	xas_lock(&xas);
-	if (xas_load(&xas) == req) {
-		req->error = ret;
-		complete(&req->done);
-		xas_store(&xas, NULL);
+	/* Remove error request and CLOSE request has no reply */
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
+		xas_reset(&xas);
+		xas_lock(&xas);
+		if (xas_load(&xas) == req) {
+			req->error = ret;
+			complete(&req->done);
+			xas_store(&xas, NULL);
+		}
+		xas_unlock(&xas);
 	}
-	xas_unlock(&xas);
 	cachefiles_req_put(req);
-	return ret;
+	return ret ? ret : n;
 }
 
 typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
-- 
2.39.2


Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332C5916B
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763399; cv=none; b=Q3szDV8QFuCAYf9fV6JpYs9HgLT+tv4QRQ66jgUaAwbapEvc3mMhfirq0uc2sTk+pu+4+4rFzaVryhBWHyzUN6O8ofuY5jvdUZaFaOHCH7OIB6pEWz0HYMLY+FAgukmtvf0IwT8UV15k1rjTUtdXLIJrOS9TV5OS7scREUMmckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763399; c=relaxed/simple;
	bh=doprlurZCVxodtCB5/PcPWtNhz5jTsoTX8MXqG4Vpck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7KmtJ67WMQp6zGLF/juyxjXf6Nr6Ar/QVFKfJKrAEoANI2RIx3wyKkVDG4BnHYR+36Kx007tz2cMvjkRwOImK4NONfMdCcv9b7whYBdc/TSGzGguWl7IbeYieRywV/i3QLAA+a6IBAlGr490c8RW4FraIyV8ML0+00Tm4Qg4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfRsn1gY3z4f3k6h
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 16:56:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C34431A0E1B
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 16:56:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxC7eERm68LgMg--.42328S12;
	Wed, 15 May 2024 16:56:34 +0800 (CST)
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
Subject: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if ondemand_id is valid
Date: Wed, 15 May 2024 16:45:57 +0800
Message-Id: <20240515084601.3240503-9-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHlxC7eERm68LgMg--.42328S12
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47CrWUZw1xtr4fArW8JFb_yoW7XrWfpF
	WayFy3KryxWF4xGrZ7AFs5XryrC3ykZFnrWw1aga48Arn8Zr1rZr1Utr1SvFy5A3sagrsr
	tw4Uuasxt34qk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUYGYpUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Now every time the daemon reads an open request, it gets a new anonymous fd
and ondemand_id. With the introduction of "restore", it is possible to read
the same open request more than once, and therefore an object can have more
than one anonymous fd.

If the anonymous fd is not unique, the following concurrencies will result
in an fd leak:

     t1     |         t2         |          t3
------------------------------------------------------------
 cachefiles_ondemand_init_object
  cachefiles_ondemand_send_req
   REQ_A = kzalloc(sizeof(*req) + data_len)
   wait_for_completion(&REQ_A->done)
            cachefiles_daemon_read
             cachefiles_ondemand_daemon_read
              REQ_A = cachefiles_ondemand_select_req
              cachefiles_ondemand_get_fd
                load->fd = fd0
                ondemand_id = object_id0
                                  ------ restore ------
                                  cachefiles_ondemand_restore
                                   // restore REQ_A
                                  cachefiles_daemon_read
                                   cachefiles_ondemand_daemon_read
                                    REQ_A = cachefiles_ondemand_select_req
                                      cachefiles_ondemand_get_fd
                                        load->fd = fd1
                                        ondemand_id = object_id1
             process_open_req(REQ_A)
             write(devfd, ("copen %u,%llu", msg->msg_id, size))
             cachefiles_ondemand_copen
              xa_erase(&cache->reqs, id)
              complete(&REQ_A->done)
   kfree(REQ_A)
                                  process_open_req(REQ_A)
                                  // copen fails due to no req
                                  // daemon close(fd1)
                                  cachefiles_ondemand_fd_release
                                   // set object closed
 -- umount --
 cachefiles_withdraw_cookie
  cachefiles_ondemand_clean_object
   cachefiles_ondemand_init_close_req
    if (!cachefiles_ondemand_object_is_open(object))
      return -ENOENT;
    // The fd0 is not closed until the daemon exits.

However, the anonymous fd holds the reference count of the object and the
object holds the reference count of the cookie. So even though the cookie
has been relinquished, it will not be unhashed and freed until the daemon
exits.

In fscache_hash_cookie(), when the same cookie is found in the hash list,
if the cookie is set with the FSCACHE_COOKIE_RELINQUISHED bit, then the new
cookie waits for the old cookie to be unhashed, while the old cookie is
waiting for the leaked fd to be closed, if the daemon does not exit in time
it will trigger a hung task.

To avoid this, allocate a new anonymous fd only if no anonymous fd has
been allocated (ondemand_id == 0) or if the previously allocated anonymous
fd has been closed (ondemand_id == -1). Moreover, returns an error if
ondemand_id is valid, letting the daemon know that the current userland
restore logic is abnormal and needs to be checked.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d04ddc6576e3..d2d4e27fca6f 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -14,11 +14,18 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 					  struct file *file)
 {
 	struct cachefiles_object *object = file->private_data;
-	struct cachefiles_cache *cache = object->volume->cache;
-	struct cachefiles_ondemand_info *info = object->ondemand;
+	struct cachefiles_cache *cache;
+	struct cachefiles_ondemand_info *info;
 	int object_id;
 	struct cachefiles_req *req;
-	XA_STATE(xas, &cache->reqs, 0);
+	XA_STATE(xas, NULL, 0);
+
+	if (!object)
+		return 0;
+
+	info = object->ondemand;
+	cache = object->volume->cache;
+	xas.xa = &cache->reqs;
 
 	xa_lock(&cache->reqs);
 	spin_lock(&info->lock);
@@ -288,22 +295,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 		goto err_put_fd;
 	}
 
+	spin_lock(&object->ondemand->lock);
+	if (object->ondemand->ondemand_id > 0) {
+		spin_unlock(&object->ondemand->lock);
+		/* Pair with check in cachefiles_ondemand_fd_release(). */
+		file->private_data = NULL;
+		ret = -EEXIST;
+		goto err_put_file;
+	}
+
 	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
 	fd_install(fd, file);
 
 	load = (void *)req->msg.data;
 	load->fd = fd;
 	object->ondemand->ondemand_id = object_id;
+	spin_unlock(&object->ondemand->lock);
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
 	return 0;
 
+err_put_file:
+	fput(file);
 err_put_fd:
 	put_unused_fd(fd);
 err_free_id:
 	xa_erase(&cache->ondemand_ids, object_id);
 err:
+	spin_lock(&object->ondemand->lock);
+	/* Avoid marking an opened object as closed. */
+	if (object->ondemand->ondemand_id <= 0)
+		cachefiles_ondemand_set_object_close(object);
+	spin_unlock(&object->ondemand->lock);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	return ret;
 }
@@ -386,10 +410,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
-		if (ret) {
-			cachefiles_ondemand_set_object_close(req->object);
+		if (ret)
 			goto out;
-		}
 	}
 
 	msg->msg_id = xas.xa_index;
-- 
2.39.2


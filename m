Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D6374A10
	for <netfs@lists.linux.dev>; Sun, 28 Jun 2026 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646123; cv=none; b=Tz9DowvH3eygD8Bhpq6ykm0q9Sc/tQLk6HeLCTm67Ryy09laFyj5qZ9xLFI7Cddx2lRI0wj+jG/MtSSCzwdZDbOov0Lps+g8/7BU2qwyUu+oQ/znWzRbQNJvTJWjZo7G8sE3CzIdpovIWQmAO/jG/53vetzdgekxalIu9msWocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646123; c=relaxed/simple;
	bh=mBhSjl+wsg+TRCvuEDdaiAqjgOOgkw+0MyFfxLMN7Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuAlCPOhSsVOZaHFLaAEbx9LQx0E/cwRS9FxJFxLc8JJjl9eW5OogsqYn6AfkEaiE4Xeo/27y31JTJl5913GXrIRR7RQ6EXE82+toTpmf68AoCcQO53Biln90ksdroZZAQZHzFJRUvs1XTnT4/8TqEB62w8e3kB+apBg2DakMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAAXOsRbBUFqh_e+AA--.35973S3;
	Sun, 28 Jun 2026 19:28:31 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	brauner@kernel.org,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	xizh2024@lzu.edu.cn,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] cachefiles: avoid slab out-of-bounds read when tracing short aux data
Date: Sun, 28 Jun 2026 19:28:16 +0800
Message-ID: <82edfddccd38dc1ba67bc614f24e8248bab447a1.1782637741.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782637741.git.xizh2024@lzu.edu.cn>
References: <cover.1782637741.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAAXOsRbBUFqh_e+AA--.35973S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF47tr4UXF48JrWDJw15CFg_yoW5AF15pF
	Wav3WjyFy8Wr48Cr4kAFs0kw1rG345GFnFg39rWwn5AF95XryrXFy7tr9YvF1Yyry8KrZI
	yw1jkFy7Xr98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE-syl
	42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsMCWpA2VUB1AAAs8

From: Zihan Xi <xizh2024@lzu.edu.cn>

trace_cachefiles_coherency() logs disk-side auxiliary data passed from
cachefiles_set_object_xattr() and cachefiles_check_auxdata(). Both call
sites always used be64_to_cpup(buf->data), reading eight bytes even when
the xattr tail only contains cookie->aux_len bytes.

9p registers FS-Cache cookies with a four-byte qid.version aux payload.
When the cachefiles coherency tracepoint is enabled, the extra read past
the kmalloc() allocation triggers KASAN slab-out-of-bounds reports in
fscache_cookie_worker.

Read at most aux_len bytes into a u64 before passing the value to the
tracepoint.

Fixes: 229105e5cfd9 ("cachefiles: Add auxiliary data trace")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Cc: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 fs/cachefiles/xattr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index f8ae78b3f7b6..a11ea858c046 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -28,6 +28,18 @@ struct cachefiles_xattr {
 static const char cachefiles_xattr_cache[] =
 	XATTR_USER_PREFIX "CacheFiles.cache";
 
+static u64 cachefiles_disk_aux_for_trace(const void *data, unsigned int len)
+{
+	u64 aux = 0;
+
+	if (len == 0)
+		return 0;
+	if (len >= sizeof(u64))
+		return be64_to_cpup(data);
+	memcpy(&aux, data, len);
+	return aux;
+}
+
 struct cachefiles_vol_xattr {
 	__be32	reserved;	/* Reserved, should be 0 */
 	__u8	data[];		/* netfs volume coherency data */
@@ -77,7 +89,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-					   be64_to_cpup((__be64 *)buf->data),
+					   cachefiles_disk_aux_for_trace(buf->data, len),
 					   buf->content,
 					   cachefiles_coherency_set_fail);
 		if (ret != -ENOMEM)
@@ -86,7 +98,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 				"Failed to set xattr with error %d", ret);
 	} else {
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-					   be64_to_cpup((__be64 *)buf->data),
+					   cachefiles_disk_aux_for_trace(buf->data, len),
 					   buf->content,
 					   cachefiles_coherency_set_ok);
 	}
@@ -148,7 +160,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 
 out:
 	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-				   be64_to_cpup((__be64 *)buf->data),
+				   cachefiles_disk_aux_for_trace(buf->data, len),
 				   buf->content, why);
 	kfree(buf);
 	return ret;
-- 
2.43.0


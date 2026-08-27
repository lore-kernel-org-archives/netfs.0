Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3933CEA7
	for <netfs@lists.linux.dev>; Thu, 27 Aug 2026 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811301; cv=none; b=sktUy3FPXtB3cHFqxEsrUAABtzH6MRJWNceHyzETUjR8UnukJWfQp3qtWN+xERpQDWd8tlC0P3MO6MYKG36/1yzV1IsASNxD5N+hxmAGvM/HVzMNEI3nKuFVQFavBHuzLGXTMf17JYoVqpQjYuRc2N8wi0klWPbWhX8IXXM3S34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811301; c=relaxed/simple;
	bh=Vr+ifSkddLNDpPhV+L+RvZEIQyNI9JYGK5E1zcaEvJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltvWth4+jQ2qFe1UKqZOoNnjZD6yOx1SNkShYnQwb2dZ9Akt1BAL1ctjd7WL7d0ripRyUwwYTeIXbr+lfImZllDoacFJCmO1o6F5k0EQsmF506qJW8/dF9aAqrjJYohOkhWP9oeCEToC/nwqRzU1PVV4VZj2Q+oCBq1236+Cx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TojY1/HZ; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TojY1/HZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787811292;
	bh=UlgYSJd/xcW4+hCbQ3uouGgjyZy182Ko3L9ALTzfoDg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TojY1/HZSHHg6mOHK3TBVzC8RrgbZDzcvdmCs3UO2fZs4dUtesNLJmEmyqyJKqcsQ
	 RBTqbUA8GiOO/Bwqau4nw7gu5FhpJl3EK1Ntn1YM3z1mJrsi+S8Qopvx+5lOjUccHC
	 abf8CVfQDLS61B8qLJyvPUR/BmpetW8wTfmcRX1g=
X-QQ-mid: zesmtpsz2t1787811287t512c8b0f
X-QQ-Originating-IP: 6fiioAjwYK904nrzfdtEv0Z+Ux3oU01XA4aCIqKt4oA=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 14:14:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8092243094390795113
EX-QQ-RecipientCnt: 4
From: Yichong Chen <chenyichong@uniontech.com>
To: dhowells@redhat.com
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] cachefiles: fix out-of-bounds read in coherency trace
Date: Thu, 27 Aug 2026 14:14:44 +0800
Message-Id: <20260827061444.2404961-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NnHSgyOaHlCIauvGsnwfNwgn2NqTzUAfAO86OrTihRBN79zl8PBo3wHE
	+HdXUEANdjWPETFh1wyeRZFdVIVw7YA/2rgXZ9bJaAcWVDjH/MOiiK5wtmfPFF85HHgEV+U
	uSclNogzYKmpwF0Nqk58u1G3LyktsD9TjN+3QQ5yl6im9VAtM31UeJp4FjRloP7lCNFB+A3
	hnyW6g0oqRxakToz3hYpzdYc+FU0tZ7Wo5SLXRBFpfPUaNva/FHj4/2pJymKQ5oRLUO+VtH
	kZPfBOdNBz90x+Kuc/qQcWlcvzWHgGRf7Cclx468+uftX+3SkFwhADSiyE5Bn6VZTLriIHT
	aN9p+1w5aeevzBHNkHeC3k5leSulUH46FhORCYKO82d6WOlkKWtvS/id+rT7+EnLt/nWSF9
	1R8eIVx+/2o4RKS0fIO6FAkIEp8D6IINGe7DGwnpc5EfOze0yup+0p0UlfjTasV7BUhG9/q
	ACoeKsOEGjQ/Wv5v1APSisSc1ofOjgHByNZoDMS/niXN5e9VJCOsE6OoZ9ze2bsdogpSfDL
	u/mULFXfjN9t8u2Y/bF9tH9pjg3NimkgL+r3yktvaDkcuUu5Unrn8t9ApM1NXhGgmiq8SfH
	U0iEeKJzT2YdTQQQLrfsuaCJyruAWS+wjeZacSVU9LAG4lbXDs+ANvyERBReoGos5Iyklvp
	5srbFmgrxG0gYmt9Ml61jqthB5rS4wTe7GleQzcHM5KAQVemogZvA2hu1nkMd1Z5Z3tMuju
	LHj2qBQmRMAl2Sq3sn04cHBeeTNyNeOC6wNSsXfj9d1GJLU55DqrbNw4gh2083TCLPhl37d
	2rK+jO5my7PwZB5YFfODyeKJFdQdAbuYvdiAitfLfBjpOtpDeSAJyabf9F4iZzINt93AuSj
	OM24zz9FY5sk1CO1LwFyXCPvD4gVPzG0pTI9pPumI063Ycno89NmHhVkfz3I5zSlpRGLkNg
	EKYPsuMjZN2uN4vsUtoEXnrAJeJe4kWxyi4YUG0lb2kX42G7/QXQ7FKsrvObv6x3sR1M0TE
	3AinjV7OPCgbWZgDAXXHKISvS+ZpbkS9rhBvl8d7NU0SLk1cp1doR2Tzc/JERJ7e5/TA7Bk
	A==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

cachefiles traces the netfs coherency data stored in the object xattr by
reading the xattr data field as a 64-bit big-endian value.  The coherency
data length is controlled by the netfs cookie and may be shorter than 8
bytes.

For example, 9p uses a 4-byte qid version as the cookie aux data.  When the
cachefiles_coherency tracepoint is enabled, cachefiles_set_object_xattr()
then reads past the end of the allocated xattr buffer, which KASAN reports
as a slab-out-of-bounds read.

Copy at most the available aux bytes into a zero-padded 64-bit value before
tracing it.  Also avoid reading xattr buffer fields on the getxattr failure
path, where the buffer contents are not valid.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/cachefiles/xattr.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index f8ae78b3f7b6..2e21abedc83a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -33,6 +33,15 @@ struct cachefiles_vol_xattr {
 	__u8	data[];		/* netfs volume coherency data */
 } __packed;
 
+static u64 cachefiles_xattr_get_aux(const struct cachefiles_xattr *buf,
+				    unsigned int len)
+{
+	__be64 aux = 0;
+
+	memcpy(&aux, buf->data, min_t(unsigned int, len, sizeof(aux)));
+	return be64_to_cpu(aux);
+}
+
 /*
  * set the state xattr on a cache file
  */
@@ -77,7 +86,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-					   be64_to_cpup((__be64 *)buf->data),
+					   cachefiles_xattr_get_aux(buf, len),
 					   buf->content,
 					   cachefiles_coherency_set_fail);
 		if (ret != -ENOMEM)
@@ -86,7 +95,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 				"Failed to set xattr with error %d", ret);
 	} else {
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-					   be64_to_cpup((__be64 *)buf->data),
+					   cachefiles_xattr_get_aux(buf, len),
 					   buf->content,
 					   cachefiles_coherency_set_ok);
 	}
@@ -106,6 +115,8 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	unsigned int len = object->cookie->aux_len, tlen;
 	const void *p = fscache_get_aux(object->cookie);
 	enum cachefiles_coherency_trace why;
+	enum cachefiles_content content = CACHEFILES_CONTENT_NO_DATA;
+	u64 disk_aux = 0;
 	ssize_t xlen;
 	int ret = -ESTALE;
 
@@ -131,6 +142,9 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 		goto out;
 	}
 
+	content = buf->content;
+	disk_aux = cachefiles_xattr_get_aux(buf, len);
+
 	if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
 		why = cachefiles_coherency_check_type;
 	} else if (memcmp(buf->data, p, len) != 0) {
@@ -148,8 +162,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 
 out:
 	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-				   be64_to_cpup((__be64 *)buf->data),
-				   buf->content, why);
+				   disk_aux, content, why);
 	kfree(buf);
 	return ret;
 }
-- 
2.51.0


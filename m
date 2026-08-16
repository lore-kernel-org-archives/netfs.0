Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDEB224B13
	for <netfs@lists.linux.dev>; Sun, 16 Aug 2026 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786906576; cv=none; b=o8N2LAV3fYdwD477Cn+qqHZcD/lX4wzAMB0Gb1z74wZf4Y9WTBYD/LKo7OrWiYsoCTIXTLAceQXqm0SILhW/A0dq+oOOT6sl5763wzFaYKI6RFfd0At2GHQkyuoQTQHaUdnVbEL7k+HJc3kAUW3iZc3UGpJKQwNyrzWIBIta4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786906576; c=relaxed/simple;
	bh=JhR3ZbpmEIywHrsoA/QmMC8SIS3iKQvW+S7Ny1/sc+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2dlJmE0w+kJbPz3jXoRnURzDt+5w1X0fqnPSq6L1/nrHHhV7rjRVNwWAPwDRwEwtwtROPmaLJUmYT9c3etIRK1PaJPOjWmpeUG5Z42PdBtJwjXCRphOHpE7+rFni2PKtp/EgK0tAReFpGeNHWYa4z0JbXNzlyfVm7O9+ZFF6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBV3RUIf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBV3RUIf"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38f620399a0so2312607a91.2
        for <netfs@lists.linux.dev>; Sun, 16 Aug 2026 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786906574; x=1787511374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VuS/DqE2UGzw4FHSA/C0NTBqN5cg+qGl//IXGZlO2Hc=;
        b=KBV3RUIfuvm1ji3/pCdcuEE+h1VNuF8kePIqDlaRPu3MhKcCuy0uvye0+jNzJL6jlY
         pJ84IicPNmniGVNn+4Fje7fMQcdC7/0PXfh54W7xb7Hz2bYdGSf2g01h95eZWaI/hbRV
         pdwmZqs145eG7psOb2xcg6SUN+yh+b3QXYpKZjkfn9FZC2e/1Xb44SUqEMQlQSmrDt7R
         MkUEkL6fxgDXDIZrEe5jsqofQ0S2WG1kZE3w8RfG1N+71AnZu4qeu5LWazgHcynnj+d9
         kTGnpgTLNEcxWz9HFFJe/RzpBqX8bqCPRUGxN4+x2Hj3UJ5A7k0zaEcDTH5FaK/WWEJD
         bJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786906574; x=1787511374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VuS/DqE2UGzw4FHSA/C0NTBqN5cg+qGl//IXGZlO2Hc=;
        b=j0FcbCQ+Zp55QFwoPXSItgoVtk75Lwr2Q+UzUiplVNYAon6EZCnVr9xMiS0O09RNYl
         DEq/U9yaVaCsLsEYrZi6fujWFCVxfIgMhf603Bn+SThaahry2OYPvfVy3dJLVH/nlSco
         25XKmOlXkHhk3UdjwAt39Kx96jJVrC4niG0/Xs1GvfrHrYYLUOBdPhYJ23v6QJr3Y1Im
         4RM/+nn5YSPIV0nRBUS09IMYxb3zEZlkOG+bScWQavN4gqmcjocgzxTCfuTfb1DpB/6W
         VoGa5SJU/iPnuNhBNcjeEBAexp8p3tzLQZad6m4loxjDZNzNYr4k3WJ6wNh3YWPeilA4
         Q4Gg==
X-Gm-Message-State: AOJu0YywFaqu1x3U2dbKJ6Zgo2l+nkkVWLfzxVhZfF9Kw0W24mhRM3Mv
	Lrh22JANXnupYVX4WfHbjk175hgQDr63JD3AviQT5jAfvRhyDI7DdbzS
X-Gm-Gg: AR+sD11LdF6R7LGOJo11Hbo7r0Stt3DfjaJJQZr3bu2pDuaLxUtIcIQ5O5B3hMO1KpD
	eivZ+amhKQ34OuuCfEzqqysLyMGPJJico1/5gwFRak7chffoSjhC5YHb52pB0BTWypTQ9lg1ZhC
	xOXWGX6mwmFyFIPkyj0FTCVg7VYtDzIuXdEXJcwn1TS4ApnNnvQxhpI+7j85ltNGENgbiDFNJ25
	D5I/q/PrpIH57ZLIv+8LLdWguE9S+bLE3HJpQGAuhAvgRBEfnPyWQIh6EFgAPoPtv9slhi4HpYl
	i6DFBr6GV1eoNq9ZsJ1HysiSaEYP/Dkz4kwmpmGfScBadbW32cuoFhthUuRtHHzaxW73A0LitRO
	AeUSpWm1t5Kv4qdY9XOxSPy/rMx2ZSss8UyDsBbJHoEnkRxpqehAkgKRGq377TWzVrf9qtkefD8
	M94f6IsKdxGrYikBOOJ4yDw/wamVqLcODhO2VP9ZrVCSleHTSZbOzs1GFyPCYwk7NwyJr3wSE=
X-Received: by 2002:a17:90b:264d:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-3933b93e1aamr21861954a91.14.1786906573951;
        Sun, 16 Aug 2026 11:56:13 -0700 (PDT)
Received: from TheRealOne ([2409:40e1:45f:d5b0:d158:6a04:1e7e:a9b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03ecsm29934885eec.18.2026.08.16.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 11:56:13 -0700 (PDT)
From: Chandradhar Kumar <chandradhar.2003@gmail.com>
To: dhowells@redhat.com
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chandradhar Kumar <chandradhar.2003@gmail.com>,
	syzbot+62b392c7348147ad767d@syzkaller.appspotmail.com
Subject: [PATCH] cachefiles: Fix OOB access in coherency trace
Date: Mon, 17 Aug 2026 00:25:48 +0530
Message-ID: <20260816185548.292045-1-chandradhar.2003@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coherency trace read the first 8 bytes of the auxiliary data with
be64_to_cpup(). However the auxiliary data stored in a cachefiles
xattr is variable length.

9P uses the 4-byte QID version as auxiliary data. Thus buf->data
contains only those 4 bytes, but the coherency trace unconditionally
reads 8 bytes from it, causing KASAN slab-out-of-bounds report.

Copy up to the first 8 bytes of the auxiliary data into an 8-byte
buffer before reading it as a big-endian value.

Fixes: 229105e5cfd9 ("cachefiles: Add auxiliary data trace")
Reported-by: syzbot+62b392c7348147ad767d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=62b392c7348147ad767d
Signed-off-by: Chandradhar Kumar <chandradhar.2003@gmail.com>
---
 fs/cachefiles/xattr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index f8ae78b3f7b6..e4cd635e8abe 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -25,6 +25,14 @@ struct cachefiles_xattr {
 	__u8	data[];		/* netfs coherency data */
 } __packed;
 
+static u64 cachefiles_get_aux_u64(const void *data, unsigned int len)
+{
+	__be64 aux = 0;
+
+	memcpy(&aux, data, min_t(unsigned int, len, sizeof(aux)));
+	return be64_to_cpup(&aux);
+}
+
 static const char cachefiles_xattr_cache[] =
 	XATTR_USER_PREFIX "CacheFiles.cache";
 
@@ -77,7 +85,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-					   be64_to_cpup((__be64 *)buf->data),
+					   cachefiles_get_aux_u64(buf->data, len),
 					   buf->content,
 					   cachefiles_coherency_set_fail);
 		if (ret != -ENOMEM)
@@ -86,7 +94,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 				"Failed to set xattr with error %d", ret);
 	} else {
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-					   be64_to_cpup((__be64 *)buf->data),
+					   cachefiles_get_aux_u64(buf->data, len),
 					   buf->content,
 					   cachefiles_coherency_set_ok);
 	}
@@ -148,7 +156,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 
 out:
 	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
-				   be64_to_cpup((__be64 *)buf->data),
+				   cachefiles_get_aux_u64(buf->data, len),
 				   buf->content, why);
 	kfree(buf);
 	return ret;
-- 
2.55.0


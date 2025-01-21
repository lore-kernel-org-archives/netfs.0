Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA88145A18
	for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446520; cv=none; b=HJ+c2hp2Rbml28wIISM2+CTwaDVMy4aU7NduzZ65Eoiq2cvBAArro52kyVPOLf4KAwpAZKCqSV40QAvVPhEIj+0ToE/+b1IxPP8Mbk4nWX7WEgbONVYWNOREGaeAuKHiYWId6qnY+R+JlQhhULsq5ZHTTrqFuovrkwqAVS/RKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446520; c=relaxed/simple;
	bh=DOUXDV6OwL89Dt5hOpDPur1plqIU+DUGKoD2Xo2eMvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOyxaCYYCS7tI22c7IHQVPIOM1glQpjZrbhHVgyC/fMq+rz+0zKpXIkMsw691qPAT2WlMap5iWYF3ilf2KNmjvU6ekKIgt/iCVpiSbgrALFSc5vlu4vLpJXziO+Nm6kHUFkgOFR5dFf+Tjr49ByfaYUd3FRZ5KkPDj3oYK3l6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBJhbY6s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBJhbY6s"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso54290165e9.0
        for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737446516; x=1738051316; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpdjkeJqFcz+kwDllwF4R9sc7E23pdl17BNJlzMM6X4=;
        b=cBJhbY6sHt9NSWyNw4kFmqbaKwTdbUZ0ur7bAcLvESQhjyeQLbYz7+UJHUnJV/zLEX
         RWabrXHylTHkRQX1uBtBv2+taWKPHaPkDRZSHBysUm56xlvNUbR3bgy6RWTArN+8OJIC
         OvneEwUExpQtgl0pLjBsZg2ueaGC2ekgyXdWjft00mMFcCHBlGT4yYoDGPyehvEcl1xb
         IXcxubyf3cM0B0j8Nu5/rKaTDX3Adf4FkTVq1bYpjFlft8i+/9/zdKlkzOZZf6XZhad7
         JGtioxhWnzA3LFuIMs18j42MkQ4rye/k2b9IRsM5CBZ0HPKIRTlxeyp4CyDe8vLorolj
         IowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737446516; x=1738051316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpdjkeJqFcz+kwDllwF4R9sc7E23pdl17BNJlzMM6X4=;
        b=v7TOr4VcquuDV6G5Dw2Xp6j8dWDKROJs58YDoPZvIhWsAKYuajEklpFqSIOVNaisYo
         ObBOVGLuzsYYNntKGoiVW+yJG301Qsyv4gmcc7HRHTajg/YGilfhGnTjzDgYBzEErIFk
         Hm0xLVa/ObKPFmK1QZL2JtnzXzku/emtY6FMM8iiNrrVomUl4RwmOxmnFL/3U9eJjA2j
         B4IczSNMLCGZneflbPzPqWWFpX7rnJWKO6Pt6C0we2MGXHS4I5WL2HLr8XrA9ueXpVUA
         S8AK4cz85/Yp4j7Ndi3UuBJhmEYMSHWjqWzebl3xvZrwKSPNnUx2Y3i0Liq0pgnFjDlZ
         /KMA==
X-Gm-Message-State: AOJu0YwdS/przoKtyB9sTqRXgxR3QCIAe3T6jfod1AFkG+jBLbpDOVl+
	QIXvl01FxAyEc59Z7dhHsKVw0wsx1LYyHj7nWis+noVXwy7s9Cxh
X-Gm-Gg: ASbGncvwNZMZe9OdtboB3DKRRfja/klJUvTZcHJqLSylfVkK53P7FiWuxr8nuzWIdK5
	sU/RQKiAGDKHpblzgtq8ebYr1Y3xf3JJEW7o3a6bCV+M00737FtOix/sbClML0KKckl62GI8Qzz
	ehlfCNumIL9adEniY78O1yxHRchY0jUhVNPv02Lmq3ZzhMu1cMtZuTjq6G53mhHvqJ7Syywj5Nr
	CItKwWPNkbEJ4QGTzI53QuNbmAIXXHQPVPSDO7qURlSaVyv3yw1+VDyNTmb+CF8M8wVjl+Bf3+i
	yw5znw==
X-Google-Smtp-Source: AGHT+IGWImeFh7Xvqiwm1w+tdWiE4eDFx4LauwY/Z8WVS9DlM5IHiEqhlc+4mifffBxpGCS1pxV6pw==
X-Received: by 2002:a05:600c:c0f:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-4389141c0a9mr137461495e9.23.1737446516184;
        Tue, 21 Jan 2025 00:01:56 -0800 (PST)
Received: from azathoth.suse.cz ([45.250.247.184])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4389046b0f5sm170700475e9.39.2025.01.21.00.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:01:55 -0800 (PST)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: dhowells@redhat.com,
	djwong@kernel.org
Cc: netfs@lists.linux.dev,
	inux-kernel@vger.kernel.org
Subject: [PATCH 1/1] netfs: fix building with GCC 15
Date: Tue, 21 Jan 2025 13:31:35 +0530
Message-ID: <20250121080135.1273011-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While building with GCC 15 I noticed these build error

fs/netfs/fscache_cache.c:375:67: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
cc1: all warnings being treated as errors

fs/netfs/fscache_cookie.c:32:69: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

This due to GCC 15 having enabled -Wunterminated-string-initialization
by default[0].
Idea for this solution came from similar bug before where the
developer agreed to just increasing the array size by one[1].

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a500f3751d3c861be7e4463c933cf467240cca5d

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 fs/netfs/fscache_cache.c  | 2 +-
 fs/netfs/fscache_cookie.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..2b554e1602a6 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,7 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE + 1] = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..bc0735c40ee7 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,7 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR + 1] = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-- 
2.48.1


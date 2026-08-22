Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035937206F
	for <netfs@lists.linux.dev>; Sat, 22 Aug 2026 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385012; cv=none; b=lmEh33hwhXxDgOjRTLBfq3SLNDIPApFLXdc0pyUbqpzFzGIFLyGCVDa/PVpjYqEKdUO4qKziOxqobIRyB67iXzx9RwD1MZSInV6eIKKCFr0cza1hUy4lpX+svq210niW6NITKm2Cz64AJSEFTbv1rbhbA5S5J6weUU4PsMGBduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385012; c=relaxed/simple;
	bh=7f19bSxHMhX+LuiFjS6VvxUe49Pr29HaJjcI9JYl5LY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJWJkC2y1DgSi+wPjuVPOn5LP5C2djvlMAN+To/ecP6eWDrKn2Ylm8sTXfwHV0Zu53S37dwlH55lcgNXGr9rp37B14sTF3f3Re//e9N7kp/WBNuaGlm1XmKaAgfZAPMOJWWbNq0rApycKlGq/+o574QD2qaD3qs033Haom3REuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEClOWtg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEClOWtg"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1712a04ddaso293714866b.2
        for <netfs@lists.linux.dev>; Sat, 22 Aug 2026 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385009; x=1787989809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xARhET+mAIwT/8hRpzx4cWP9xkzvmEp4D4gjAtxnLvs=;
        b=sEClOWtgXwuds3sbcbYP6bXd78K42ONRVVs/dctHcN1KRYSVl5EwDwyaudg6MM9h5r
         TQ/Lf6yTe+lEi7P/kteX+i6tzpC3uNDk6iwa8sncloxjDM2yhi7iS55WYKmaRzoHbfHH
         ZLF+62mI0RM9DYRGe6bsfr/5cjfaMUQudf86q9zVfC8OLcJg2p+VwWI0BDLBYGRgZB2D
         y7/zxcv6qPP0nyM437UuvvZFJaU1VjA6NJNZfL0yccrmpfkQxp/QtjbCmC8iA74EheHL
         cb1oBL6bvvNTb4kZ7m/i+OvcjHU+c10mxWdrxEh35B6xT2ENty8RmABDw4a26pgTlfVq
         B/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385009; x=1787989809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xARhET+mAIwT/8hRpzx4cWP9xkzvmEp4D4gjAtxnLvs=;
        b=TDEYIJSAFoGoEOBIX6CQBbkgvOnD/UqlpmkKeT0iduCv5PvxBSRYmEipM0u118PrYM
         HOlFQofXjSa/A8V8fvPhRSzGaZwIpJe2Mk+h3gnFtrtW+8yvGNj+cd98wP2+5WpPL8c0
         Xo4LQWskrXXwdg/gP+rgTKPnIW8+zHnB1NWum4y1Vah1g5IOiIl/76bSAgjjwim+rJ7k
         fbLZ91ICBES6wnpFcCGetD3583cZ48VOMfPSJ+rMdMC1FOkZ2hiqa84/tN0meMmRDSUh
         TdeJWJA8yHXHWwyptkHN5WZYmVNfkouTSCvDEtg00ZJFGF35KiDSMGWj3yYCf9lferLx
         rLjg==
X-Forwarded-Encrypted: i=1; AHgh+Rpw9Ha+Wn2U27tORNSaDJBQ1kBNAhriXj5t2gIh7yiHO9qNRwUEs7+MF7DARYFuOFMjh4rwoQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k/vutEw1TpaoVi4Xunpv9a7BfHkMD2H5gWZGlaqagIy94U3EWc
	S9oNsW1RMu2NUoXsPsOe5M5bkt7HwbQU/aYtd0yPHl06NSKtkDsZku61
X-Gm-Gg: AR+sD11avqFSzSvwy4nwSj72eMhKr8HP0G0LBddoaJDBZqEftXDF9iEuupwlV0rPT0M
	vKVEqtwom4x3AJ+mxnAzMrhqZmjC6iH5gbvYNihTOHdhN26GDbrq//Xk/3gjtq0jma6sh29YBd+
	LmDvp8RqxF3YjWIrHX2sO6p1HZ/N1siciVmRoTqUGl54moTZ5HczMzYMgeyl2OYq8Le1sO2na4f
	n8+xKINMC7SMcsJbQVI0werLri//H0WFvAAhqCoVmkURzuFsU+B0oaUpj+2MPOHGOARRx68M775
	oSY6eewtR9pHVBrAx9ws7Uj9LKclNUHJBSllcY+5xyKAieCi//2js7C7uaPMXiVjam0lj85prdt
	VLsRgiBlSXX0iaRfeHBK4rTwWDEyEvumQP0XrhF6/ACUY+4vO2LZvxSCjtscrolGUTo+Ib6t0sU
	DGjzm+vIAT+VQst5N9c9mda2ee0TMVC8YaQPCHnQogzdOQDyeG3ijHORm69X4TfXy8ftDQG9qMk
	S38laaHO3FTVUem5OEV9GC8efuEna7x96QEsGZ3IU6bC0hPKjQ/krFyF8xG8/t6Qq0eLf+RDqRV
	YAx/kNepu/DyZw2cqBBLROvum4y0Fr5fJAOfjcykkH2PA5ToS7MX0hBwS9Bsll9ELjcFm2DiGml
	FyhO1cKtGRw==
X-Received: by 2002:a17:907:930e:b0:c1c:4e36:eec6 with SMTP id a640c23a62f3a-c2492099898mr367065266b.18.1787385008783;
        Sat, 22 Aug 2026 00:50:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm210519466b.43.2026.08.22.00.50.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 00:50:08 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: Fix debug parameter sysfs path
Date: Sat, 22 Aug 2026 09:50:05 +0200
Message-Id: <20260822075005.74963-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module parameter is exposed below /sys/module/cachefiles/parameters,
not /sys/modules/cachefiles/parameter.

Fixes: 77443f6171f3 ("cachefiles: Introduce rewritten driver")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/cachefiles/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index afb25b6af5aa1..c9c168c7e0726 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -17,7 +17,7 @@ config CACHEFILES_DEBUG
 	help
 	  This permits debugging to be dynamically enabled in the filesystem
 	  caching on files module.  If this is set, the debugging output may be
-	  enabled by setting bits in /sys/modules/cachefiles/parameter/debug or
+	  enabled by setting bits in /sys/module/cachefiles/parameters/debug or
 	  by including a debugging specifier in /etc/cachefilesd.conf.
 
 config CACHEFILES_ERROR_INJECTION
-- 
2.53.0


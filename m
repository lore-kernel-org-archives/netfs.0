Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4F3195FE
	for <netfs@lists.linux.dev>; Sun,  6 Sep 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714869; cv=none; b=atDcGfhSj1wkiycL2IP07QDudGHAmo5ZsroTzusadj9fI1pN/3LWe8vpz+F1Yuv8ITZqAmvK4GRFISZ/PZ8q9hjQKq4hszf/E37W7ff6Rpop+buWl6wbp50IjmMSnLw6lqig2XK/awT+7gqKPnM6QZzfNwkiY1hT55ptgjUYCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714869; c=relaxed/simple;
	bh=ZQNtzfC9B+roKNdtrorDCmQDK73t+iGfoB4AjB4+T40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tzf/4N7SFu0ofdFlGJ9Zc0FQObCUSCUWxrQLwpuWWpSowl/VbUpfWMe8l/CJCHj03vbollGx5D8/R3y98XUmt7Zds1hJn+pUoUuejKZu3lnlWixC48gjD6Z/w2ap2yjqWZCgDv+BK19Ne+emCvg/l1m15tZzl/gmOYHCgCvUqjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAMj1lAM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAMj1lAM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so20522605e9.3
        for <netfs@lists.linux.dev>; Sun, 06 Sep 2026 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714867; x=1789319667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQvYSmZJXRVJ8lTmmPque95vqlJ9rHDbYOvEqCjj6Qc=;
        b=oAMj1lAMg/ylblXBdwGtKg43E0gBqKOrAlHjzmwIFjHIDQYLhhHag7uAny8OjwhDN0
         9FIEgsIQ/ZZAFpKTaA/RLrIBryCML+Sk6NR/6/EuqqD3XBQCwpb8HGmA8QrzsbjB0c5T
         MYB4BDsigw3b4QPUGedbhRK9YChA9cA3PmVG5SYT1kkbJpnoAcHAkJbHoG6hJfUDzpCd
         iryU+5MSrAAeufbaocbvN7FAn2kmi5M7QdJVniO24nCwwAaaWxO1qKnO/vM4XC2CuZ/L
         6ezj1E1nuUFe4lztDdgVN9nGAKqjeSclgjeUC9GST3/iy0GElaYIrWpXbDUKP9DaQYr1
         tsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714867; x=1789319667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQvYSmZJXRVJ8lTmmPque95vqlJ9rHDbYOvEqCjj6Qc=;
        b=aWV3r2e/St7R4GSz7BmBD+ZDz3VSGZbQUULN2oWbLNmM0jryVTrOCNezzUbF67gkSl
         ncHgv22NB4ZZvqeVNBA7gIEKzbPdVTcK1RjXlBilr5xrnazLyk+DU1IPj8WUnMoIR1F9
         +Mp/hvQay+aKF0p5SGAFWFOQHoOyKm4jTTw2ZV7xhFCqzs8iU15DFufwy7rwx2Jsxwzd
         SqRjAOYJrQgfXjoWifKhBwXqDUd6jTEAsFatxphYirLXPyFDdM28wNttcIgNPrjkg23x
         GmjaJ2S/8zZcSE+5At7PZ/o9ElzCLZF/kHB2Nz/cr143s/yjeRN44yIXSwPwxw7flz66
         uyLA==
X-Forwarded-Encrypted: i=1; AKwUvBzEW3LTXJSy48qoKz+hTroSx5mVfwhRCUBLjtLjzQ6Vuauy00GYGnANxhNPEXU6b3VRxCrsPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mWR1lFALpdyKCu0XJQaT1zqRLIHS1/E3kOI8FAciDJmuNLI/Mw
	BfxeuyUJImixnNuImgpdlbMt6H/k32gOmAm5iJYZNujPrjznLoLcfnd7FRJ88sMy
X-Gm-Gg: AYBFou3eL3kBpVXQqrDaDWVpTIlr6N4U6KIf6C49wvH1hI//iLvpaAWDBmzSk/4kKSg
	DvHYaQTPYeY7n0caJlNp4yw7T0HyCL9Vxf/UznBPpUS7t5ijNBSXYX4gvRToECvMA0A+8s3uaaJ
	Wk4KO2lECNVUk51eW35giV2PcS8vgpAauf4HDyTjp5+qMcNjIj2UkP8NERcSMW/M5Ql4v+LaLlj
	40NfQYax/1Y9S26wHL1GpCLOaPq/Ni6i23VT9kzwHF6582P/+x4DzCbnn0kmfpxJoLv9GmgxfDb
	pbxgeQXAGrYRGyGlxenISJpH/OnJU2x23uFqyKhhvTNsk/1HxDc04K6UFJK//dvwbbJVJI3K8pC
	PN4XGcRUX+s3n38xVS6s7GzcXcCLQlzobhxI4zw9CA13C+h9N3B0ARMZf7WzUQY7w+/ACZi+eS1
	T38VcfZamdhsBVYyBUt5XXxE/ahmcMK901woX9DqjCBKwEejddxljE3P6EkCMK9Z1IpLe9/e32b
	rmztRDqKWaseZ+16kt3oQfMJBFuAvFKFYguCkfM91chpen+oGO7MrxKt2kPEoUSKUh3Z+IcjOqM
	Z6/oKBjMJ36N0vXYxywoTPO4SKWe2LFM96fRKHMTh+ZdHLMc8mekq6ueEHbW4YgXmmvKij2F
X-Received: by 2002:a05:600c:1549:b0:499:a5fc:2087 with SMTP id 5b1f17b1804b1-49cf81f47e6mr196679165e9.6.1788714866368;
        Sun, 06 Sep 2026 10:14:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75cd8d0sm227749155e9.2.2026.09.06.10.14.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 10:14:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netfs@lists.linux.dev
Subject: [PATCH] cachefiles: Fix the debug parameter description
Date: Sun,  6 Sep 2026 19:14:24 +0200
Message-Id: <20260906171424.2971-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module parameter is debug, but its MODULE_PARM_DESC() names the
variable behind it, cachefiles_debug, so modinfo describes a parameter
that does not exist and shows no description for the real one.

Use the parameter name in the description.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/cachefiles/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 3f369c6f816d..d91f06355127 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -25,7 +25,7 @@
 
 unsigned cachefiles_debug;
 module_param_named(debug, cachefiles_debug, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(cachefiles_debug, "CacheFiles debugging mask");
+MODULE_PARM_DESC(debug, "CacheFiles debugging mask");
 
 MODULE_DESCRIPTION("Mounted-filesystem based cache");
 MODULE_AUTHOR("Red Hat, Inc.");

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0


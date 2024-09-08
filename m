Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC4339A8
	for <netfs@lists.linux.dev>; Sun,  8 Sep 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823436; cv=none; b=fs1euphGmcTO5NClmW30SKv8PxwbRGhgn+cIumxr35OtVory+EOlVL2sgnLLWK6RVbcRlK72D68u/lUiMJbU+3Rk5suDKqLkEJ7wx0Mjp+5FcOyhQ0UzcKjD6ww2421K2stfR313wi/dzeCgV/JDxRZEs/vnxaMWzEQpKqtobuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823436; c=relaxed/simple;
	bh=m/W0s303G6CAVDATz7o5LzmdnZ3kzZdIQCH0Cbz1fgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mv75iY3ABj1JsWlWhXfp36/eN6Sz+mPBAph8Z0v4/rsO/fGlZ3+xpO79x5P7CwXImwmZRcj8NvlYhI2Ou9w9QfMwA5NriyU5GF4WSGsNjp7ClXRIwOPU61z3n9JcWTi7DnPvpa5V9PV0KlZTB8hWcKLTfmFF7grZCfq2jP3256k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+B3hbpb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+B3hbpb"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9aec89347so39744585a.0
        for <netfs@lists.linux.dev>; Sun, 08 Sep 2024 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725823434; x=1726428234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXrFgzwbiTSr4Ylz2mlW0T8OOl+bUrZIiSty64NIZsA=;
        b=e+B3hbpbQGaWa93K9tPJiuV28Z2+go3ZeNrEibsnZBnEO/pBUPo6QJTmmEp8dGeAz7
         n1f7tNFyYcFaW0RGAyMqUsSr7ClWqmpJJ2x/o/3w8LzGBbN5Po9Q9+2tKehkXf6YjQZQ
         E5M9O0K1FaV4EbCT0vIhO3JblastQWmabjprZyKoddztSvFHdvA1ZJl6wx1HUkAJkVUO
         I24aCWvxluE+g61Q5epeoZL71yws0Tql0qGBz7J0Bp4lfsqOvLzbpIaGlGf3+j6jv07Y
         a/e77q7Sa0HOh3jr4w55BMNvrjvl2sNDZ3OOLlX6KjpoCentBsVkn+MK8YjpUEpn+UaV
         EKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823434; x=1726428234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXrFgzwbiTSr4Ylz2mlW0T8OOl+bUrZIiSty64NIZsA=;
        b=VDPtuuBlkUBJiB7wujS11+d+cX3vM74DHLscsov3etaqJ3i7F9EfRxYzbXn+0LgXl7
         8mafJN+V0HRl+uK/pkXBTHx+GnFYRs+KKYiyNqpWeWTw6B6Vz8h/RnJb+65oPTmP6V8y
         fha0dwhveleixiQXfEsFUPf7mxyMYUD25wRLCYWD9OX1xJdPWN46Pts4inEVf8/B17Gr
         dWErdHNnTDo5zFYKhB7AvR2Lbtr/oNqY9uUUv2xEDGN23yL0+JxYgsnkUZqm3UBC6yfj
         yHbyknarcdh3sJLurMkqnw/KG5JC1OfcP3tGtHxa3W2jOnFRv9dIxvSCEGblmNbJ23u2
         5aPQ==
X-Gm-Message-State: AOJu0Yy9CeLGswmVjfQFz1w/6BHYo3e+Cfxca+fZPJVibPOsKl7HiGf8
	UnhZkJa00gRvXDxsJSiKHJUvLuEGbPmvGPLVK3NYkUdvCZ9mARwi
X-Google-Smtp-Source: AGHT+IGgKnSGL4uaFiJd97SurDl/WRYL/3PCh4JiAicvu+wT8MBh5XrPuZh99WHUqGS9aW7p6JSFXg==
X-Received: by 2002:a05:620a:40cf:b0:79f:793:9a63 with SMTP id af79cd13be357-7a99737a8ffmr1464157785a.44.1725823434041;
        Sun, 08 Sep 2024 12:23:54 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a9a7969043sm151309485a.44.2024.09.08.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:23:53 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	corbet@lwn.net
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs:filesystems: fix spelling and grammar mistakes on netfs library page
Date: Sun,  8 Sep 2024 15:23:09 -0400
Message-ID: <20240908192307.20733-3-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/netfs_library.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4cc657d743f7..cc8e7a249de5 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -111,12 +111,12 @@ The following services are provided:
  * Allow the netfs to expand a readahead request in both directions to meet its
    needs.
 
- * Allow the netfs to partially fulfil a read, which will then be resubmitted.
+ * Allow the netfs to partially fulfill a read, which will then be resubmitted.
 
  * Handle local caching, allowing cached data and server-read data to be
    interleaved for a single request.
 
- * Handle clearing of bufferage that aren't on the server.
+ * Handle clearing of bufferages that aren't on the server.
 
  * Handle retrying of reads that failed, switching reads from the cache to the
    server as necessary.
-- 
2.46.0


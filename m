Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE4370D4D
	for <netfs@lists.linux.dev>; Sat,  5 Sep 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585470; cv=none; b=DWzMZsdeGoQx0Gv14ltyQgm5Rkl3563yLbYbZkfw2U+r56BH/0v9g28gJi/72970dR53PR9Sow62100FdMFukoSSErciqHDCGXbun3oWNpwgrV8qU0Sxc58jdJSwUAW1fqi2WV8r5+XKO2vuocjlZeOvTvruTR62JUhN/9U0vG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585470; c=relaxed/simple;
	bh=9cESAQnKS1GvNLQYlN2dyJ8BiT0g66cuhPX4uVynMRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J7sSwDbIHJJv3LUOTEmAhiREMXCf99KMPos+2DZkjbEp3x2qNwFPrGYaFM2508L3ti/Vc+0ikTV/4viHUcNNd/Eb2thIfKFzKnjjHuUMGtYpeA9y/OJRYgWikZzLPRSE0iWVsPZPn/bmZlpEaPW1wTgy3zcGwFu0RGNU2JUNJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5jJ5Cx2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5jJ5Cx2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47fe89fb333so1088412f8f.3
        for <netfs@lists.linux.dev>; Fri, 04 Sep 2026 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788585466; x=1789190266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCaSkOIbas1sDw8YO8X3FHEghul9wX61PC7BjPNNw68=;
        b=X5jJ5Cx2Mo/Ls7u8H78UypdIYOrENpR6fvbq5AdzmCK6hzfLR3emX7fO2R64eSW5Dm
         kR6+StbTwdl+Qn6vV/zvccxySvW+cjD2lVCzscc7MT1btuApqZql0CBlVyNODURE/1J7
         vTA6y4oTEM7OqNKMARtXxNX+cYxbceQzNTYDZhhhk5f2qMtpCBUH8fJaGZayfhbusJc2
         bqtrwk9h+3RRZwh9G9xh0DLBpRVO/x8Z927bw5z2f0BdbbJyryT0WsY/D/R7KVNGOmNY
         DKe5DRcyBhVKJvC6kgpWiefCRiR5fhGNuLxHvC7txz16IHEl4Y8DdlwYWQTVOlvPn5tY
         ugmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585466; x=1789190266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCaSkOIbas1sDw8YO8X3FHEghul9wX61PC7BjPNNw68=;
        b=himnekARePDs4jIEZcsJZGkyY137wzvMmo+fgdaEQFyhIRdFKrj4Gg/3GktLhmhYC8
         POMdcorLDCGcvn4yDl/SE5c6EIHpBg9JCXStHd5EAUoRJyFpdpYg6u/Y914GzrPMNXGW
         Vq4cBNZwB5u7LXsGvvhmWpkorKDHlpOq9/d0SSBKgevE9+XZaj0TxfFr27AGzphGoc5o
         i3Z47Xk/rrWODZYzCRtIhTHhZxKmi6tLrd68R7TNdj7Zh7IcIYVdxeODORdqSQ/LCxB7
         WLuWKLm2sGy7yq+DXxcWaCTNRvP0+Ww0+hnOxKtfnOLe1mo0RNv1ljame5frkmuSjkdH
         T2vg==
X-Forwarded-Encrypted: i=1; AKwUvBy637Sq2iy7qxa9ErEcdxTVX6MfkA7X84S0kQ2IxfuAvmV/l3FsfZ+ngp+BynVj5ygURxnvAQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mTwMDOZjioNXxHPikoW3OWtbTxIriGGMp3i49571MVsvPaUQMf
	m36cVILtTMxgRBLu2XL4lyziIq8KA/ycJ+FffaJlMlGCJ+e22HTP7zQp
X-Gm-Gg: AYBFou2eUoswzrHbSf7Ri/Klsgc/HQC1wG5/7c8Amo0mVLafDTo1By7PT+9oQEZC3OS
	86hWb853QP3z2s6+QPz0g4XM7c1sdfcwMTVkfuh5uGv6HGEEfpVfeTM87+//YyKTv8YbTDNFZwO
	KjuV3+yQGXmke3jsfuaEmYmmktHkx6FuGaCyoaXikHhSy6AkswvwlHzB7S0PkDS+xl4LNwF8Uyy
	WIRKW3rx5xJ5QGwGErhRN5ms4A96ku5JdUOweWPR5wfg0GT5CyP+Wp5kGB3hRixTLg2u/CQcBL0
	1/GGGj/xsTz1f3XV3LWExvcTyQnKNCaIc8ctiEIdMKmKG6PsuxwCljV1YJICefnJM8l4c8RtRfS
	Gs76I1MpN+cboS7Wtmy3ClxtXZEYiLn74Knaq1+ot4HK2Q8kU545UySdDuU8Wi3V0sRbi7hsdf1
	GcsllhCas5YvvMcpMO675lqO3gT7jALwJsw1cqPdhd0NRu4iht74eIUIRE1PXOEz4DJanc7brzt
	2ZnXTqtNYlGzu3rUX5jLbHewwA/Zyy+wQMSlRS5Zp26XHl0+EALayuh6KURttkbIyBVLOT/wZVM
	Tgw/YXLLGpkF++gC3fYKJrJtW4KvraxkiaGlkY1XJEdJb/qYvtRHMR6pqUkeCzKW0Gs=
X-Received: by 2002:a05:6000:4604:b0:485:8f9c:2875 with SMTP id ffacd0b85a97d-4858f9c28fdmr2642911f8f.12.1788585465881;
        Fri, 04 Sep 2026 22:17:45 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm9329547f8f.2.2026.09.04.22.17.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 22:17:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Restore selective debug mask handling
Date: Sat,  5 Sep 2026 07:17:38 +0200
Message-Id: <20260905051738.11317-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netfs debug macros test only whether netfs_debug is nonzero.
Consequently, selecting one debug point enables every entry, exit and
general debug message.

Documentation/filesystems/caching/fscache.rst and the NETFS_DEBUG
Kconfig help still describe /sys/module/netfs/parameters/debug as a
bitmask of per-stream function entry, exit and general debugging
points, and the fscache_*.c files still define FSCACHE_DEBUG_LEVEL,
but nothing has decoded either since the mask handling was dropped
when FS-Cache was folded into netfs.

Restore the per-level and per-point mask decoding.  Files that do not
define FSCACHE_DEBUG_LEVEL, which includes the netfs core, fall under
the cache management stream, the same default the FS-Cache macros had.

Fixes: 915cd30cdea8 ("netfs, fscache: Combine fscache with netfs")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/netfs/internal.h | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 420ee7b26580f..425c73b7e77b4 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -468,6 +468,32 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
 #define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
 #define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
 
+#define FSCACHE_DEBUG_CACHE	0
+#define FSCACHE_DEBUG_COOKIE	1
+#define FSCACHE_DEBUG_OBJECT	2
+#define FSCACHE_DEBUG_OPERATION	3
+
+#define FSCACHE_POINT_ENTER	1
+#define FSCACHE_POINT_LEAVE	2
+#define FSCACHE_POINT_DEBUG	4
+
+#ifndef FSCACHE_DEBUG_LEVEL
+#define FSCACHE_DEBUG_LEVEL CACHE
+#endif
+
+/*
+ * Determine whether a particular optional debugging point should be logged.
+ * Three levels of indirection are needed to expand FSCACHE_DEBUG_LEVEL before
+ * joining it with its prefix.
+ */
+#define ____do_kdebug(LEVEL, POINT) \
+	unlikely(netfs_debug & \
+		 (FSCACHE_POINT_##POINT << (FSCACHE_DEBUG_ ## LEVEL * 3)))
+#define ___do_kdebug(LEVEL, POINT) \
+	____do_kdebug(LEVEL, POINT)
+#define __do_kdebug(POINT) \
+	___do_kdebug(FSCACHE_DEBUG_LEVEL, POINT)
+
 #ifdef __KDEBUG
 #define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
 #define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
@@ -476,19 +502,19 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
 #elif defined(CONFIG_NETFS_DEBUG)
 #define _enter(FMT, ...)			\
 do {						\
-	if (netfs_debug)			\
+	if (__do_kdebug(ENTER))			\
 		kenter(FMT, ##__VA_ARGS__);	\
 } while (0)
 
 #define _leave(FMT, ...)			\
 do {						\
-	if (netfs_debug)			\
+	if (__do_kdebug(LEAVE))			\
 		kleave(FMT, ##__VA_ARGS__);	\
 } while (0)
 
 #define _debug(FMT, ...)			\
 do {						\
-	if (netfs_debug)			\
+	if (__do_kdebug(DEBUG))			\
 		kdebug(FMT, ##__VA_ARGS__);	\
 } while (0)
 
-- 
2.53.0


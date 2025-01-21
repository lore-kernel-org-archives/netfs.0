Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68762F5B
	for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450946; cv=none; b=KddFilNhAWqt5jxI4G0Jul3EEMQmeHuAKCiyS3kyOZs9ADR69ONnJK/Osewrsm/XbCV6zmIkn2QVgSp1pkTSOb5C655hySAKPKxk/0raCVNgJM08qiLD6NjqFxu47SEb2NUpk8FdOcElyNRAK6NQWI2QTAInpYUOCXto6IljTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450946; c=relaxed/simple;
	bh=RuaT4xPijv44lUK1hbsotQqEH8CiQkMR8xW9uc1Q69s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l30tOr1XeRLB/kxYOqr5gznn61Uvwkq26omu3jmU5P6IeWRDi6ZcxaMxgVXKKRQtvfJsDKRptJeTjpqYr1e34eqoXbC6EJNSJ96ttNpzb5V25HmKpfBjlG627Jtqc6oe9f587Ea1sMrh4Z8FL+n9HO7Yiwhw1Q0KJSt52vRy0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhdxS+7I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhdxS+7I"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38637614567so2606026f8f.3
        for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737450943; x=1738055743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev8a20hhFB0PtqA6Uck4JlPKU7F6frnJcxqcXRltDqo=;
        b=FhdxS+7I52SKaCp0IsJ6UsdtRFPuQN+y8EriFuhkPGUVmyAkg8o1rWMth6mz9CDvOO
         anKVDTC7K5NXyWI57aMna54EC8/hzqf7KjNZXMQ3AezXQ/hxUSQRIU3mnk/LEh8umfyu
         9BUAYvj5M6xESD6UISRkcfkiCu9CXv5WhhMjqAog5PqedzZFkqE4qYpYo5EkHQ+DA2pP
         wUjKXkYIQSjEqtuJ1RlV23SDI+9Xl577B3c30lgl1TXkXz+b6SfAbQ/Q0IW37Oy+PAs4
         yrDjci6j619rq2P0Nx026STl95B5vkLFShYUn86taDoMFdot2Zz8WSgRw3Xqegc6Yege
         SogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737450943; x=1738055743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev8a20hhFB0PtqA6Uck4JlPKU7F6frnJcxqcXRltDqo=;
        b=npH5ZxlH6x/xt48hpk5s+d0hCgrvKw1HeHZS6/W8bcajiEOoomeNP63+6y+fuX9AFh
         lPdXRr301RjEVwmion4z8spGhlU2nE0P5FqUcxuctsGzZHlLEHHNPXDInnrYOjAHNP2t
         tEplAAM2gxQb2TiWgmNqAdp76cHt23t5MproMPFcUwHKvDHCmKPkoej7dFC0baeiQTmJ
         RBm43BZ+j1O173cbobgHIM52jjUhPjj0c5WdZYd6/8qL3RAe1j4YiB8pHKiWPLs3V/zt
         BQ0l2y3lJS5nPgLi6f4hsDDVnh7s/aTxfv3aO2YhFuSbyAE/jI76xsFVHtZ8t6+tICjN
         oFig==
X-Gm-Message-State: AOJu0YxjlbqBcUOeBv2Xfh65rgORYrvc3G/U7uHFhxmKPrlIId9Bo4vF
	w264of/sAPP1f77+AW6Od83GbJrwNgm0cW7bnwzE55wAAWuh5/knq1SxYA==
X-Gm-Gg: ASbGnctfv2OPMEflEmTBEZbsvwIpow8T808akgYWW91NzAm+rZKCKoJk02jvKCwI8c9
	rhXEwX5WAPMK4p2jDOQeYpN6B+1IJLTx5tvqCFI19Vo5HvUnekIwQguUYE1BJIwHV/a2LnCJ7BT
	OUEVtrwNQr/NmB3Vcn5M36VNytJzjjTDvo/vuTUg17N9aU5Gj23Tv0bjiEQ6O+nyoTakuCkLQyz
	0/fRQyRf4gsZOhBPBcmrlcTKAdBanGfT+h9MQoD1uEGhCmv8a00g9GPl15nf8WXOuqHRLBJVLn+
	q87soQ==
X-Google-Smtp-Source: AGHT+IFfkS7GLMGQniMxrvsBolTsDpFXS791LkGuG3/0lFoy91fl4l7W/xWnsq64miGrYQ0pVf7qvQ==
X-Received: by 2002:a05:6000:1561:b0:38c:1270:f96d with SMTP id ffacd0b85a97d-38c1270fb9fmr3605519f8f.50.1737450942684;
        Tue, 21 Jan 2025 01:15:42 -0800 (PST)
Received: from azathoth.suse.cz ([45.250.247.107])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf3221b70sm12571505f8f.26.2025.01.21.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 01:15:42 -0800 (PST)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: dhowells@redhat.com
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cachefiles: fix build with GCC 15
Date: Tue, 21 Jan 2025 14:45:30 +0530
Message-ID: <20250121091530.1316673-1-brahmajit.xyz@gmail.com>
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

fs/cachefiles/key.c:12:9: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   12 |         "0123456789"                    /* 0 - 9 */
      |         ^~~~~~~~~~~~
cc1: all warnings being treated as errors

This due to GCC 15 having enabled -Wunterminated-string-initialization
by default[0]. Separating each characters to ensure NUL termination of
char array.

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 fs/cachefiles/key.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index bf935e25bdbe..555a0ec9eff4 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -8,12 +8,14 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-static const char cachefiles_charmap[64] =
-	"0123456789"			/* 0 - 9 */
-	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
-	"_-"				/* 62 - 63 */
-	;
+static const char cachefiles_charmap[64] = {
+	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', /* 0 - 9 */
+	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', /* 10 - 35 */
+	'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', /* 10 - 35 */
+	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', /* 36 - 61 */
+	'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', /* 36 - 61 */
+	'_', '-' /* 62 - 63 */
+}; 
 
 static const char cachefiles_filecharmap[256] = {
 	/* we skip space and tab and control chars */
-- 
2.48.1


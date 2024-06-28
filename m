Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649A55C29
	for <netfs@lists.linux.dev>; Fri, 28 Jun 2024 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555855; cv=none; b=u82Y+zPNnoZr9e0YOvate7uO06SiGNhAxRs+dRdJyVWOkiIGTI29KVlbC66MDiY8wmO1qTbcZJaOGgtBH9edKLgrjZq+NRU76S27hF+kOUiPD+38cBnI9xLXCkeN7EQpmWsJuohHw93JqQDElN/wnBeB23jr1t6EwzR2iwvOwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555855; c=relaxed/simple;
	bh=2OhVz+CWLAqwx1TZwOjll/zRHYZJKy6m4OT1DSiFqzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWKR0JWuGEUNpmHuAcSZegp9xXIE/dvn74g4utD47fe+qBQx7Xenuy809BOCxoRhzPWkTJgsZ3JdbdQFU8uWLrHt+DjhyUki+Nfx7r/g0Asm5h9OlcmPdsgiJ7xPmRggBWbVpCZqvyqOzv4+lNMfVNtfnY0E0SUs/uDv5kry+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=QWTIkFpp; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="QWTIkFpp"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36dd6110186so1278325ab.0
        for <netfs@lists.linux.dev>; Thu, 27 Jun 2024 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719555853; x=1720160653; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzLoPiZE4JE6+DixEf0MtA8WCsiSCC+1JUW9jnXAdIU=;
        b=QWTIkFppzNj58XgLYXCAVCWgkmPFPbO+H+qCf2SqY9Wr77reY22Q8l34KH21DL5jT1
         VlAQKIpGm1Eb2c3waCU239cOWCR6RYAB661859JU3nX0ss8cJbvp4mhVhfSoJDINp3bq
         3di7qCk7HKu+yuMvn/KZ9idAy4Vp1pbUakkfAzBngg++RDDFEaOCWr//4K9gGZrjkVyd
         wqv6mWr5pNyBiWp7jEVQRN5zzcq2d1d/a/tS2v+doiWtRcYXlhBWvGk4H5PVwN4bxlyq
         rwU+44be81yU2m6kWB7AywcImqGwuH0LZyUsHP95b/FTg/l7HPIDun2IVX6m2eU/hgFo
         QAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719555853; x=1720160653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzLoPiZE4JE6+DixEf0MtA8WCsiSCC+1JUW9jnXAdIU=;
        b=RMSUroTXeeYIakpXbXD6eLawR0XUt1ANiKJOUjh1VhXalejc9NuFLx/APfdIbexH7x
         UAbaZIFi9aC574zkQQQ637mf+PcYAdN7N5bmWkwL73CW3pWZu4BNvrV9Szt6Z6cg3Lnk
         3zevEIXtBGpYcwvPHDXi2vkHjvb3rMfYakJxqc4ESVWX0cOJP7+orrpEN4E1Z/6Y7AOv
         AgINAlCHj1DFO4hl8pDDZpCZ12PjMXWOFu4oq7OM7t36HhdZ+lezz4xC61R8M2xHoFgq
         JtpTTEPWqfFfbWfYR9IEufgDJDeQp4/cwRNV0pG7tt5NjD+sB2Id22PINZWKEHyXFVg8
         EwCA==
X-Gm-Message-State: AOJu0Ywq0rJ/Z5VZicMdbgqw27kLN7F0l8+/uoXkLdlRuYM6SmQreTTR
	X7Ly26QQjYo6XqXL2y2u8ejZEIUAABOl8aSb8J++j7sgCaARFCVl6meKzoZJyaU=
X-Google-Smtp-Source: AGHT+IFsWTRPrleNV9WCHgmOyv7LoUsWG9TeEWqDKOF3BkaC6BtC1QHIn26XExOxqaLkUv77OaSsOQ==
X-Received: by 2002:a05:6e02:1c0c:b0:375:c443:9883 with SMTP id e9e14a558f8ab-3763f6ce08dmr180676155ab.21.1719555853457;
        Thu, 27 Jun 2024 23:24:13 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53ba0sm671358a12.7.2024.06.27.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:24:12 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dhowells@redhat.com,
	jlayton@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Simon Horman <horms@kernel.org>
Subject: [RESEND PATCH] fscache: Remove duplicate included header
Date: Fri, 28 Jun 2024 08:23:30 +0200
Message-ID: <20240628062329.321162-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 38637e5c9b57..b1722a82c03d 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.45.2


Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F92AE7A
	for <netfs@lists.linux.dev>; Sat, 20 Jun 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961318; cv=none; b=HDzOCVnfsg2TMczCIhTbERHchQ0OiPu0TRVDJ9ZFtqiTtRyevt0uG65kVE6U7MI1qnP/rQpM85KWBkSbXBaa41+JtQlW5zGFtGKSynnz5xHhL7XYTxbBQZq62ujDZbapM7li7pjgxawR/t/LC8jikTfvLTrcF8oL76uaOlc+Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961318; c=relaxed/simple;
	bh=23NyWvTUJsPdw9hB8ASyEdH6BurRVqV2tLiJMtfr5KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfhUPbex82shRQGV/ihtmToEyJY2LUgbwQGhulm8Z+R5I3EM3pMzSfNFkRJHd/jn6KK/DzgOHPteWXAF23Hp7HCC8DCN09d+jMHNJD/IbQr2fnKFaHyqLISenwyFcg274He0e9PwXCIKZ00SS2SQvOon8/owyGH7cSDwVZIqOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WPZh2kMt; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WPZh2kMt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781961312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5BxJOsqX9RhTR8lBnfr8QiNZRKDdPAO3x10iscx2Lw=;
	b=WPZh2kMt8RvFAApkLaMP4P5pwnglq6WycMEyx7xDwLtELnt97dIxM6R31AL+X0pSIwjQ05
	EH0fbT/k3wGJpbakH1Z+dZe/PXo5VbZ/f6fsSDuFk+k+j4UhzfTcVJmD2o0fvONYFrjwBD
	rNZ5jnowBpTqdBdp4lilpdMTBQisXkU=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] cachefiles: Fix path of the "debug" module parameter in help paragraph
Date: Sat, 20 Jun 2026 21:14:25 +0800
Message-ID: <20260620131425.8210-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The correct path of the "debug" module parameter should be
/sys/module/cachefiles/parameters/debug. Fix it.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 fs/cachefiles/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index c5a070550ee3..1f0ec7d287b9 100644
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


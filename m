Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486958;
	b=q18vsoqU9DJpsqnQ1TGqPklZoNuwQryqrQBUyPJL0LXnNdZ2P/EwruYtJ2kMdIpnePhK
	 5B6cgsYs0+YVvtD8C31rIVASGFq8bsqX6D+CLwYCQdCnhupjwrRIG8EWopsg6jW/yNZxx
	 oKnsNTv62wtw7uK2tnWJbikECRpVFntjdEqNy8s6jFeNYuKfe0bo0na3cVdlD0oLbPWs4
	 dTd2mZRMl9xfuDnl3a2eZ5aJBxkxN99FBRmJrzvdEvVd7lydLZhgZE/VO9IzJJ2BDKMat
	 VdPFUawZZK4tucU0qvtbtkTJVgFMi7dW4mhSEkqDE8QDwF7VRgV2st7mneOkd7/a9Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
	b=ms31gtae2vNhkXusF4DPdkaALvofT+D1oVLgkrdExzZRjCgIzzkRnhvphWNTesueIka0
	 ymnXUczqLLK959Kfp85zCyvb74Fp897PEh0Q0m1mSgvten4kaiLiHc46zYYzQ0s9oGsl0
	 1VzFcUoFRgQufEJXSHQiIkSd1svTsP+eKaOPg4cWEZ/Qh19eAgQ/NymKjo6BcqJIchYpY
	 Vz3IM3Kr6DZ6EXQ+YyUpo4JRZpHC8DKsld44Xoilvt2EcBMypzWFywd3hPc1M/BSai9RF
	 H5jLPXOTX3HObovBan4T4a9GluQA7WhAzWq1jQNl1abILpTC+v4jDHJnvES51LpyXsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="EHD/8Xgj";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924E606A332
	for <netfs@lists.linux.dev>; Tue, 20 Oct 2026 09:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3924E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EHD/8Xgj
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so3900975e9.3
        for <netfs@lists.linux.dev>; Tue, 20 Oct 2026 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792486956; x=1793091756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=EHD/8XgjYJinuB/7rIXD9/vpK6EuDvk3OmdV2f6lizxfu5BqWCFIDMfCAAO1ponTyh
         iDsTLbq1dJbwx3w2HbHhcFttJiCcCq6c0zAS1iZ7qNL1zCiia08R/M3oTYeVlj59KUZT
         WuxrujIbj4zknintStBAtw40aNpu+CWtM54GgVh0GQ+sTH0bwhQLUBJHeYLb8Oum6O1T
         cItlvugih11xvr5TjrKGNkPJg2ccsnCZEeb7TfGXEmXWIOZWtkWnEAWHVxR+PVeST1bm
         4zGlISywKWChJC7rE7dqmp3P43nAPUC1dC3rH3imBPDKOrPGkZlSQuECxnE6a5DAkD7l
         rdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792486956; x=1793091756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=VIATpdnWcFgMf2NgqUSIvRADhTsZtTXA6l8pwWZclTplRbhlFjKivFGJyPQNhU0m7O
         ujaE0XHEPOUTkRBA4ViXMV3wQq+yLrj6AcgGQpJmvk7JqSCanqpXOxfWq6FU7kRXpO5F
         PXN8RZ09UWCcUtrYcmLuF5//V4XSL8Q7BoBYliAjg0MENli6JGp80eFNs+Su44/ghzOe
         cdiQ+a4JXwSaZeBCqaAD5HkneTNnfmfHkhdUlF1eZpy3HoCwcjt81Vt+wJ9ACrnxwMZZ
         /mH3yMi5+kHrWpxGFvvk6WtKcjp3d8xF1bkBqubuLyunLJlEGnU05kIO9rsVWhPxqPNo
         xT1g==
X-Gm-Message-State: AFq9FYIv6XPAyFCIsJ2aoGMRIScaaU3Ae3T4abylL8uFIu+/KsEz4yjL
	2DQvJBGscyie3wH6HxOmvbKyfZ3Yk5IyfIC2yoNfk1dtb7j3bUol8nMR
X-Gm-Gg: AYBFou2cFv0ry/P0ULhcNUv3baS5uT0+xVjOYUthXqsav+wNSG2MgYed++TgRrJo1AP
	AR5oUsDKkbCfNcFam4g8l9q6Ummki4FUXqLsPU/BSrPLfYcxOJycVDbSulhmB5qz2V1vaO7zUmK
	it0Xa5b0icrF75tqFrQzUNBdy1l2vehL4DXzBPGqGc7PvzCwDoKYABNos4rYrDIvjCeXqpkYp8D
	YQLEHMq+ADQXi3npQQ6hy/C9YVC0tV0y+uHIj8Ub8x1tFmhQLAYQwiipQgrUPYtSbccBd8C8k8M
	4iZnM6QbuQglmZFz6jD5l0BtClSkGu1EdWNxw/romNazU1OZn2DsfbtDKaSAx3ZpnDpXHfz5RW7
	R650NQjju14qsZH+mVcuLp/a6xJuwWy1gBAiHT8XRVZFEaxwSRlObDiUZevdrimCq6Y66U0vad1
	ReaxPs0eaFpQr9j8Ktz/IYMkceEKHYC6xeGgTBGVLtyB65sW1pzveAv8c0o4pZjndP8ZjHF9hq8
	Ah+AWd3LoJ4Ong4dMW4nixGBaQM88ARzGBsP3q0k18QhwU=
X-Received: by 2002:a05:600c:1f8d:b0:4a0:1b14:d00c with SMTP id 5b1f17b1804b1-4a1d75ab306mr239129235e9.3.1792486951816;
        Tue, 20 Oct 2026 02:02:31 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([129.45.77.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf04ffe9sm243295495e9.0.2026.10.20.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:02:31 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: dhowells@redhat.com,
	brauner@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] cachefiles: convert deprecated simple_strtoul() to kstrtoul() in percentage command handlers
Date: Tue, 20 Oct 2026 10:02:26 +0100
Message-ID: <20261020090226.271-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the six <N>% percentage command handlers -
cachefiles_daemon_frun(), _fcull(), _fstop(), _brun(), _bcull(), and
_bstop() - from the deprecated simple_strtoul() to kstrtoul(). These
are the only handlers in this file that take a trailing '%' after
the number; other nearby commands take plain values and are
unaffected.

Since kstrtoul() requires the whole input to be a valid number, each
handler now walks the digit run itself, checks it's followed by '%'
and NUL, and temporarily null-terminates at the '%' to isolate the
number for kstrtoul(), restoring it afterwards.

Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 fs/cachefiles/daemon.c | 78 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 1a66e0af2837..12c38b366881 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -331,16 +331,25 @@ static int cachefiles_daemon_range_error(struct cachefiles_cache *cache,
 static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long frun;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	frun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &frun);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (frun <= cache->fcull_percent || frun >= 100)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -355,16 +364,25 @@ static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long fcull;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	fcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &fcull);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (fcull <= cache->fstop_percent || fcull >= cache->frun_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -379,16 +397,25 @@ static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long fstop;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	fstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &fstop);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (fstop >= cache->fcull_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -403,16 +430,25 @@ static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long brun;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	brun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &brun);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (brun <= cache->bcull_percent || brun >= 100)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -427,16 +463,25 @@ static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long bcull;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	bcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &bcull);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (bcull <= cache->bstop_percent || bcull >= cache->brun_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -451,16 +496,25 @@ static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_bstop(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long bstop;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	bstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &bstop);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (bstop >= cache->bcull_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
-- 
2.43.0


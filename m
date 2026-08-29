Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83842A785
	for <netfs@lists.linux.dev>; Sat, 29 Aug 2026 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788043506; cv=none; b=LMcBVRNHAwHj+jhXFSe5jYZ4VFi4sI/povV96bzRctTntACdfUefx9MCHHnJweqol4CKbREJ+0B+M/vV30SZ3V47WwO4hx+iXHNcp5idPKZCh0IB9vGoVWAbe6cdkU/zN8EtIDUGq2ibxTU1Y3vRkQh5pwXs49Xcpl4giYsPH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788043506; c=relaxed/simple;
	bh=gneipLsgqKEAyVQAZll6RiNG8vO7ec73+30d+3Gw2Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfonCG0ApINEJoCEzUIu6KtT5iqUwRGItA6mZkMqMOwOK+qhmdDTm0tbPRzObIUA6108aw2yfhbAPbMadt3+xw2Ejsyu1LAAKoZVgjBG8kBaXDIiuZMQCJwiCb1ucnqPFhTLhQy70FABeqH2bl4PfurHLE8tjwUpXTOzjkULNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9NX+Xwf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9NX+Xwf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso28712575e9.2
        for <netfs@lists.linux.dev>; Sat, 29 Aug 2026 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788043503; x=1788648303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=l9NX+XwfPU8Qii9Rn6blOdLMYbvW25Kfr+gSBQX0miiQWwxN6mUqCqkNpBcnKjC/yT
         9s0evPNA9IgPvfe6YcID5CdxHKXJwJQLiltIuSL28H4E3zjLJyyqNfosynzxCczxpIEl
         aeMiFwTlBGXkILKvJW+YCYFZoYwQRChblhWUP28tYTDuud3j8WWzr/H7Y4wxvXXA2oBk
         fhteWrTZeKK3sXWjrD63ozYdYfHSHF/KnBLT54i5aV4h4CNqIT9yRpoz2gtXjdMW96Bp
         TZ1o7PlisW3cXGls8+oPWvMT86//DJwQhnJbXBWs1NoEQzmbLTPo9VU+guZaMa0hL95d
         +H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788043503; x=1788648303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=CXqh3BfWSqsJmdBJQImZZd4ebNacLuZJ4goXhIUsMw+JbZPpRnnZnieGBhxlMm+wS9
         g+lA5GW3PyROWivRdHyAt+5F5/H9TdoRjTzxMRWKBmwqigxwhx/kvCqwlTKznFr1d4d9
         VRX4TKwpOuwLHyRZTn62doWNvY37CB+kE0mmErDEL2GR+bKqlTtUmRz/e+OaH4fJGit3
         V0ayKcO0auUiqZbnsnqDFh2HBrAM1wwyF788u+m3xZ17BPDjkiYlMAOTarjLIJx2+9yG
         KInG/2k8f9YCbz9tm5Iy3njO6LHwFwzFEaAVAjwts/EN/llR6izNXBK/GkHZ1p/0HXE2
         p1OA==
X-Gm-Message-State: AFuF++kTt6Wmi94rBrj1ArvTjLqfPJ5HYIPnwxqLstfHW1Z60ovCzrIb
	jMetBYsPmm4PKzw0dmY2ZdFSjnKGDj/8KJhkUUPnfVVMItO7js09Y/qG
X-Gm-Gg: AR+sD110GZHepKEqznP5/KdG1XPDEfziEk6t3X7Rkig7cLGNG9by+VA6GT0TS0qCtQk
	O8l0i9MQgBTjKm68SeoklaGBc++wFNswatdR4X3DrnQXS8s9/wG3feH/X1mX5P/2uYpTXFSOSWI
	bfATbCunelt9BnK78XocmGKhwMPiqZxSQFLCBAQXQzz14i4vL58fupduInVcDKMT9HrCE64970b
	rF4TIBlsHj7WSmebB7r6u4t4qOgpMwnhVKz7LRPEJ/8U/ABW/WTO//bxI9uNBh144Gn2kdSpjTy
	75lYC7nIytvSgtRGt+X62i0reGGsE8OX+j8nMlrHIIMo/fk2AJqBdoR6AhveAIxQadPGn/87Hgb
	MKARgeD96wkTJdYDu/M0mUx1cO5jIrcp6FvWt1SvZjLV5ay6Dwkc4Bm6+siWdlzERD0zVcGPeL6
	7Dbxyph/tIlPldq9+r+EZZnnkCWsxr+Z83apsMWxD+37w7DKCHNX2Z4aQknJQrU7SSYbdMsucE3
	UHAdPy7/lJNQ6FCSiIAEAYp58dMajYsv7PxBA==
X-Received: by 2002:a05:600c:3f10:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-49cd01972c9mr43946365e9.0.1788043503066;
        Sat, 29 Aug 2026 15:45:03 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.30.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccae954f9sm97527475e9.13.2026.08.29.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 15:45:02 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] cachefiles: convert deprecated simple_strtoul() to kstrtoul() in percentage command handlers
Date: Sat, 29 Aug 2026 23:44:59 +0100
Message-ID: <20260829224500.14278-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
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


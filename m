Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F233424D7C
	for <netfs@lists.linux.dev>; Thu, 24 Sep 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240738; cv=none; b=tD+FX+Kc110KPNI1gnF9XCFc7PgeImhTeOsSzHh8mgHvJdMobRhJMkZULer0ViWdoiCOKYjaWcDpKmMLmmAPZXsylz1bAoRCgZ2CJpCiYYpfkahOuZP9AwzfswyX2iPYe4vzkGV1FnQsOTb6R72sv6im3EwOA6/JvmQqxRmaJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240738; c=relaxed/simple;
	bh=gneipLsgqKEAyVQAZll6RiNG8vO7ec73+30d+3Gw2Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaIlahy5Q3OL8OsPywuVJHEoK+YCKX4S9GjQQ8xdd5ziGUVdCkpNI/9QrJHOn4JF0g8O7rwBEqQz2yJ3nxzhdBpGIxs1JSM8KHrK+GGdcqXoVq48XGljN8iLiaxYznTKfCJj6zPoxaSieDuUIOU9JWudnIOloUPRRGNrPCwujx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctHhx50A; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctHhx50A"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so12595255e9.2
        for <netfs@lists.linux.dev>; Thu, 24 Sep 2026 02:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790240734; x=1790845534; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=ctHhx50A1m1J6f7R9PB6QnTU8K9QHwZleXcMjoQPmabsUFHMfeS7v3skKf5iZ1RJgc
         3wCVStdEchQyuveDsJSvsawiLrK2Jo1BmWGnv75vECC+plqua1wlbw1kyJrY82MqK+HK
         PFP1MArGB7hsIQbpK12RU4eoC2ujTuite9rnWyYlTS3ScRXWmmQyUZIZ15zWhiJJCblJ
         k60fC0ha+KyhxrHMwxG00S/+YKnUJUupxyxTTnex5+wxzjJbZxCtxFBcTb1TOt3dNkHc
         s/nDtPDgbaM8qfaXJwyfIJFaypqm5+zKKzC0mV6y8RQUhLQk4cmTelZUQ026M0PH14oY
         5BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240734; x=1790845534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=gIU8vgL14NfmK40rEwYaWczVlcBu45L8zqtqqOpK0kcgnVjwu9EgPkrgR4Kocn312W
         C27C5304ZPTKqheG/pY6Px6KXcdzadno8hK0H7Cm2rBbd/5/N9lztmC2NvKn3JX1H6UT
         YQ2JvPDT+O8i8WW8vTnNMpF7ZTV40XKyKD/wl12wYkp+Ai5TxBGVRmn/hJTogB1s7Jl1
         n0YzE9OcNmwyvk8ODsQYEbgofDvlLUU4wCqeMFGjxRVVxL9G2Stt1i2r0kC0TMF21oMg
         x1wnuntENJN05CFaWfzkOlK5QLNL1lDZHlycAb4yHWuAh2X/JGbkiJiAd3E14/kp6qm7
         P3wg==
X-Gm-Message-State: AFuF++n7LWHvFL677dcktI6+C/9wR6Itqmwf1e/vME+FmJ3ZlyNoG6+4
	LePbj+tGW6UaADZWym6q7OMLiv0Q5eRnFiu4E3J77xlXoPi811w6MTkI
X-Gm-Gg: AYBFou3kWca47qYyGs632VnrqQkHogprAguZ4eNrFV/CWvyVdQIucdaiKBOOBI/PiCZ
	xVYoljenD67Ol4nTIAI4TvAnb1Ds5lBNTC6bSbCoaYLRfoV3aACmxABzeJIFMOXExnj4LFahaNl
	1u/l/nrtkRMTnLa6bOQlQGW8bFl/23xkWxziNHBul5eE0SZSt5qCBVlPwl+q0SuDsT5KHv78Jmx
	2NB5HqLlNz83fOrhP8jt7aGfR79C6OE/8ZZrvB9fAuadt5UsUafoEMlfNGgIaK3VXjUeXUjzScC
	i3LfNYlejlsgopzjE9Sja3EZ8tQJNyI0oaCXQ3BwUvfig3kmIY5HILjtpadSZz8LVlOzbeCN9J8
	I1hqcPPGsMVWP5nx6zYXNpiPEk9jABq9VjtHTKxqFDRLl9+zT2swGBJp3wvSTpXLulfssfxEDyt
	L0iP4HKM2RTu1oIeEft3pnzCvRUBVD/eBlA06tkgHb6n5qvDDkgTVrWuBuwp5TpZkpca1Vhudyz
	gmVlCwv1s46qq3s1YaPDazSTaBxhCQWCQTloixBc4vjHIJB
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49fe66f9fe3mr28311825e9.31.1790240734292;
        Thu, 24 Sep 2026 02:05:34 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([129.45.65.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dff204sm80100715e9.14.2026.09.24.02.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:05:33 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH RESEND] cachefiles: convert deprecated simple_strtoul() to kstrtoul() in percentage command handlers
Date: Thu, 24 Sep 2026 10:05:30 +0100
Message-ID: <20260924090530.134-1-drifabdelmalekmohamedsaid@gmail.com>
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


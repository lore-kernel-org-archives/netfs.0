Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4D35946
	for <netfs@lists.linux.dev>; Mon,  9 Dec 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753765; cv=none; b=Vkl3tI0dG/U70EKxPoEVSGqEfUACXPWAFAGiQGZn01v7XEIemkukfvp/GYQrhvbn18ZeEGWNcTj7TxRD8wLjY/Nk8bPb6OFCOSOSeKqTshFP1kD2CPlS5SzIQ2yfG9ksHbcvy7ys8DgJTtGn+C60mzGwU9MWX3r2X0pR7h+GnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753765; c=relaxed/simple;
	bh=VzcSKHy18NLLXf21RkjF1FqrTcUOAH8NoqpvDorSaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHTR2CSCCk1/+hiqIwwI+iREfD7+pPivDH97nZadaRIcimHXfj9OpVB0if/Y8EY06+nQpJeuWyloUlST80EIUmCvqrWqdyC4k4kecjyE9ZmmO+26X3TlBVgkgOUZ2SLnQp1uFRIS2nlnVfRtEZf4UV9W7TJWBTSsoQTBVED5Jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZeW9ntt1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZeW9ntt1"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa670ffe302so244447466b.2
        for <netfs@lists.linux.dev>; Mon, 09 Dec 2024 06:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733753760; x=1734358560; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdmax77IGEEwisTCnHEna2vDXeBlXeblGP0C74f9/Ic=;
        b=ZeW9ntt1EITRW55YiRB+KC4jVUDsWro+E7oYxDmD6bzMAEZ2RjP2pea4e4I0LAwewh
         /2srUf00P1E+G/hMwpMmNeGUtLG/7hQPORl7x+hCE76UiQl8NmGgXkGYEV8GkEdWM9zh
         vvOEea++bF2jrzXTEga5hFD7wuUlC7N6lpTqyNhSEhYuJE3PBFhEpgrZnCcwAVIY1Yu4
         T6WMz2v22LAa2/YBbgyeStMrEyOwXWivcrDkFNf6OFxbJD52rHVvswUxZ3B9iQr6jIuP
         xDhxzd6SXgd2SAywshiOuM59eFgGOZJErdTaOk7qnQX4B+UQmWjm9mgMpQBvvoPNMGpK
         xzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753760; x=1734358560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vdmax77IGEEwisTCnHEna2vDXeBlXeblGP0C74f9/Ic=;
        b=u/Uui7+XRfLUGehzjNxzHgHS7Hd+G8RdO/tjonIpVeUGz318u5pcfnz1sVG8StjMio
         r22U8X0s6QvqRPPr58w5r0/nVKRhz1Wov9XaYjpHSDmXgUs5ox3rsacig3cu0m0CPpHA
         hce1In6Fh4ZNfoYz0Oidmb1eVLEzRWXfI05A/GWL5rwPeeQ9AcvixtTRg2A5YeWSL8iE
         HErD8Avx+k4ycIpaABdApG/OiuIby2u4kr+JRzH8Y4nQ7lkeLuI82qSz/fIUCFvX0bxA
         m8v4HArY0as+EyTePB0gQVMAUN1cE4oKlrC6n/N6t/eGnTbI9JQi6tvcbO/Q9mHGPOqL
         Ywsw==
X-Forwarded-Encrypted: i=1; AJvYcCWK9AxJht6WhuaNIpY9Zl1m0lxHi+T7v9G3/6HCOual3nhboVorL2Yr99mwKhv4Q4vPBZcijw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzVXxFT5wBprQciCIemjF/bXZRCrtmVUuz42GIKo5EuV8uqcil
	yijkWHpyr/TBkfkJ3vUXxQPnUZ3asvwMnje4ppDBe9AukcpyeDTHfVBJEDhCqqE=
X-Gm-Gg: ASbGncuJg4mgeTL3GVWu55vpjHG+P5QIm+s2Xe0DroFDhDjqfD27ppmsVq5qygDPbGc
	aUi6Qm6V3q2bbS/4uIvdS8GEukbpjh5FtxcRMwI/tlTXWcBdMpLPp9hPsLyaTIy8ZGv+TNGaAk9
	mWPQSLDDUxniq4oaQP3z1oXYZ87HXjLC0fGR4aMiSHYIjmjLXm+mAjA8wR51i09IqZ+00wxp08a
	J4UKTrVlrNhPeE5zpZiKfaBoWGDeGYvRSg/eBcmjinm7ZGMexUEHCDWKKZUOWMpVMJH99MzQtoN
	gCPJ8Fr1B1PNNZrILm6F8feEo5Tdqi3ynsdQ4BaecfALZQMyBQ==
X-Google-Smtp-Source: AGHT+IFLBp2fdCsJQMa/TJPMRoMaNu3fmS9Q17TcQ19MhzzXMeczTB44DwPwQ6to38t0U4YkQwbl1A==
X-Received: by 2002:a17:906:30cb:b0:aa5:3782:53af with SMTP id a640c23a62f3a-aa63a07edfcmr1132170766b.27.1733753759856;
        Mon, 09 Dec 2024 06:15:59 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f2c8700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2c:8700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa689b6e7d8sm147359666b.78.2024.12.09.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:15:59 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/cachefiles/daemon: parse the "secctx" immediately
Date: Mon,  9 Dec 2024 15:15:54 +0100
Message-ID: <20241209141554.638708-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of storing an opaque string, call security_secctx_to_secid()
right in the "secctx" command handler and store only the numeric
"secid".  This eliminates an unnecessary string allocation and allows
the daemon to receive errors when writing the "secctx" command instead
of postponing the error to the "bind" command handler.  For example,
if the kernel was built without `CONFIG_SECURITY`, "bind" will return
`EOPNOTSUPP`, but the daemon doesn't know why.  With this patch, the
"secctx" will instead return `EOPNOTSUPP` which is the right context
for this error.

This patch adds a boolean flag `have_secid` because I'm not sure if we
can safely assume that zero is the special secid value for "not set".
This appears to be true for SELinux, Smack and AppArmor, but since
this attribute is not documented, I'm unable to derive a stable
guarantee for that.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/cachefiles/daemon.c   | 14 +++++++-------
 fs/cachefiles/internal.h |  3 ++-
 fs/cachefiles/security.c |  6 +++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a836..169e8709e4ad 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/poll.h>
 #include <linux/mount.h>
+#include <linux/security.h> // for security_secctx_to_secid()
 #include <linux/statfs.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -576,7 +577,7 @@ static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 {
-	char *secctx;
+	int err;
 
 	_enter(",%s", args);
 
@@ -585,16 +586,16 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 		return -EINVAL;
 	}
 
-	if (cache->secctx) {
+	if (cache->have_secid) {
 		pr_err("Second security context specified\n");
 		return -EINVAL;
 	}
 
-	secctx = kstrdup(args, GFP_KERNEL);
-	if (!secctx)
-		return -ENOMEM;
+	err = security_secctx_to_secid(args, strlen(args), &cache->secid);
+	if (err)
+		return err;
 
-	cache->secctx = secctx;
+	cache->have_secid = true;
 	return 0;
 }
 
@@ -820,7 +821,6 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
-	kfree(cache->secctx);
 	kfree(cache->tag);
 
 	_leave("");
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 7b99bd98de75..38c236e38cef 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -122,7 +122,6 @@ struct cachefiles_cache {
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
 #define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
-	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
 	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
@@ -130,6 +129,8 @@ struct cachefiles_cache {
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
 	u32				msg_id_next;
+	u32				secid;		/* LSM security id */
+	bool				have_secid;	/* whether "secid" was set */
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
index fe777164f1d8..fc6611886b3b 100644
--- a/fs/cachefiles/security.c
+++ b/fs/cachefiles/security.c
@@ -18,7 +18,7 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 	struct cred *new;
 	int ret;
 
-	_enter("{%s}", cache->secctx);
+	_enter("{%u}", cache->have_secid ? cache->secid : 0);
 
 	new = prepare_kernel_cred(current);
 	if (!new) {
@@ -26,8 +26,8 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 		goto error;
 	}
 
-	if (cache->secctx) {
-		ret = set_security_override_from_ctx(new, cache->secctx);
+	if (cache->have_secid) {
+		ret = set_security_override(new, cache->secid);
 		if (ret < 0) {
 			put_cred(new);
 			pr_err("Security denies permission to nominate security context: error %d\n",
-- 
2.45.2


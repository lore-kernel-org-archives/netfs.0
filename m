Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411910;
	b=3Knnhvs//23/i6gYo6TSDTwpNb+FYKdrZFJGgW79h2I8Il2uTRMHGZWbhu5PJYabostR
	 gqNQIMfMVYFAIT2CyoaMz5RnfvelxlV4g1/DSD4tsCSQI8zSs1P82+ISWa1ZrPTROatWl
	 EeUoDhyCv2PIZej0DQuflaUiDE40veIqkE2CuVgAm39QmJ8wneQJxhLfenJ1U/mN87onU
	 Czi58RRf/5T5ew+mZnw4Ba9qm8JCKcYQCgDFx3nh1tTqmtqVR2AVtfk92mQztNQU+z5eP
	 J38tuPBkNgi+mJPsq4s+qA8F3/MkGRRxcqmmuP54zTpCb+lSS1apG9KpW+M9ZZbaOZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sJv/vQe3wv4xM1igYaOZea7+QqPV13IlBCEtGrk80JI=;
	b=vzpNHPob0CgkPo4+MUVctRK2/yaXatDO3CUL8fy8VZv9GHKW8uo+wCTkHQrbzDZbSeU7
	 gck0HbrCfGH2DteIN4Twx7i6Ft5GRmGQFo3AiwwjNHvKtoETO2rsNJFk4T4Eta+FjxyMU
	 ITeH367+ShFtY7ySVAPMkHxOxuk0PAeixFrNjYLP317YOHvwVUOFuwUY3NbrgXcKmGQ03
	 OP52sCq52DiTdduu1FZfa93zceEHKxj72RkQqCbYBTPbDSWkj52xoe5BmeszTXKRyIZGv
	 4Y4ZHvMc5qu+LYHY7bKOF7U6+Cs66ECyc58exzioABJ1AJFlJgRuj6pzWOn0e0yzXrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MzfWBmvd;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CA606A32A
	for <netfs@lists.linux.dev>; Wed, 11 Nov 2026 15:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491CA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MzfWBmvd
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1931993f8f.2
        for <netfs@lists.linux.dev>; Wed, 11 Nov 2026 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794411907; x=1795016707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJv/vQe3wv4xM1igYaOZea7+QqPV13IlBCEtGrk80JI=;
        b=MzfWBmvdKWYBcKX3UJwfQX1gR0FPiM2Ts55N/WPo1tZruQvnRWHnWZ8v9mOflxVu10
         aHgzyZzTyT+1WmqVcMTkdAuUytNxsS0cwO2692NMLJJ728HqymWC/hj7IXyXL+1IQVwU
         Q9ilLKMYQh2dCqhQa8N0hlJD/d51z9KDtIzznYuVtOcfU+Lk346oE7cyh04DCGLUzM4N
         5btJPo6vSlxJAP7CWNNkXVcJ6WFt9GVfrdnyKgp2Nm22siKnQibu/4Or8TcnqiJb+u+7
         xddWNQAVwbhQSdazmo8ud+Lsou6ooE7a5er8c37x/fno84nmOqVbWzQXH6YfuCSyorrs
         hrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411907; x=1795016707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJv/vQe3wv4xM1igYaOZea7+QqPV13IlBCEtGrk80JI=;
        b=l12U0Bl/WzCrqome4eQ6c3yPDvk3XcZBPwOQxcDxfBPquaKW5U7cqUs9keA6QtdMN+
         eq58fTXN7hMk7xxcHdXfToLIJNVx5NCXj5Pmjj1ttbuKEQJks0FAS0imOM0gLvHTdRET
         T00KTFBW+O4LdPwBti4pHeUd1C4A88aOc9RlIcE5vOSNdftVk5duUkaQ+5iZbBwrSFKV
         01gNaBsNJbuykFd0uNJS5aa6sNsULCK+3Expwj+FDbl8lFluefuR3pvibMbARcypE781
         jYHMI6ROY7N8V+QsHor5KdZD+xeWhyzsZzYXMUx/F1GmqimmAjT2K/Sy6/LkJHQYbf6n
         twZw==
X-Forwarded-Encrypted: i=1; AL+hErHd0os0xekuDl2HQe8nH4m5eeyVToQFj8j7kgEOG0sxJklwBTnSKp98+12BAQViVQzXfxY9fQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9iyvAdLWzNQBP0PiE+BKl5gifLfQWJCaX1q+CF5m9kt2hrnB1V
	40Yo9cQmCLsWINYWEy3K1MWD1adJi6aVTzYiGEEQ4dv9uP+7Ee/C4fJ+abn1VyR8u98=
X-Gm-Gg: AYBFou3fNeOU0NFDBrHvtBqNTYFKtpv/rXMrrC1RLzAPUcfa0RtLF3uMbDOOx1Rno8+
	Zti6xK55UwHSi5ecemb5CcrK579VIzFbeXri/Bodh0CWUOkaANuwj7GqxWPQq/MTtSnr1UFeSJl
	HhQ/BsHc2dvh+4XkbsWuL1nOoe8ATMSdWt58ZXZyjmVMU9JvAoSsxrqnFgky1qgmJxME//R3s2j
	Aeo31o7UdPI4kwT3Oi+I2mH0LW6xnU9zil3fqGebUwdoYPHHWgdnV/OhOFe9sKzaDD9V2LD+W9c
	xEaCAaBH6+X+XORFcSWgLtU7iwGV7ounPxvHbYlJKzKEMXecDBpY3djuIK8feqqaaNZ8swygJxD
	c1JNpO6mTyIOIIFB1LSSbsPcoipkjDYNlldnCymjpIVibRoCvUWZyhbtLhVch3wD/tV8WL2f2x5
	FTTYxASUcHcRMWMoV6lHkLNX+JHqmoZSmGZ1On7uGRRoLjM5uvO8+UDUeMAmTwcxU60rLGKjFwb
	YM5HMfgYAGTX5qqVG4uFuPv8boge3QWvtt6S/dJ4WiqjstEZ5QKxbH1q5EYUZmdbxakOP2A8nZ+
	whn6TpneOGCW1TvkHMcaOZb1JcJ9iD4hMM2+zY71M10TqnJcxKwBSYIoVPoaGUpfZmtCdvI1c0n
	HRtg/0k64ISrtlQhxK6KRv4ZqGK1KMzI=
X-Received: by 2002:a05:6000:3ca:b0:498:1a65:50ce with SMTP id ffacd0b85a97d-499c7a24ac2mr4382494f8f.22.1794411907466;
        Wed, 11 Nov 2026 07:45:07 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbfc6sm12392832f8f.41.2026.11.11.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:45:06 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: make the procfs cookie listing optional
Date: Wed, 11 Nov 2026 16:45:00 +0100
Message-ID: <20261111154504.1314170-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
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

Add FSCACHE_COOKIE_PROC, enabled by default, to omit the diagnostic
cookie list and its maintenance when not needed.  Caching and counters
are unaffected.  Disabling it reduces the size of the struct by 16
bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/Kconfig          | 10 ++++++++++
 fs/netfs/fscache_cookie.c |  8 +++++++-
 fs/netfs/fscache_proc.c   |  2 ++
 fs/netfs/internal.h       |  2 ++
 include/linux/fscache.h   |  2 ++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index d0e7b0971fa3..881b081e3a52 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -44,6 +44,16 @@ config FSCACHE
 
 	  See Documentation/filesystems/caching/fscache.rst for more information.
 
+config FSCACHE_COOKIE_PROC
+	bool "List FS-Cache cookies in procfs"
+	depends on FSCACHE && PROC_FS
+	default y
+	help
+	  Provide the diagnostic /proc/fs/netfs/cookies listing (also
+	  available through /proc/fs/fscache/cookies). Disabling this saves
+	  two pointers per cookie and avoids maintaining the global list.
+	  Caching and statistics remain available.
+
 config FSCACHE_STATS
 	bool "Gather statistical information on local caching"
 	depends on FSCACHE && PROC_FS
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index 5a226f9cbdea..fe0832ec2056 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -23,8 +23,10 @@ static void fscache_perform_invalidation(struct fscache_cookie *cookie);
 
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
+#ifdef CONFIG_FSCACHE_COOKIE_PROC
 static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
+#endif
 static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
@@ -68,9 +70,11 @@ static void fscache_free_cookie(struct fscache_cookie *cookie)
 		return;
 	}
 
+#ifdef CONFIG_FSCACHE_COOKIE_PROC
 	write_lock(&fscache_cookies_lock);
 	list_del(&cookie->proc_link);
 	write_unlock(&fscache_cookies_lock);
+#endif
 	if (cookie->aux_len > sizeof(cookie->inline_aux))
 		kfree(cookie->aux);
 	if (cookie->key_len > sizeof(cookie->inline_key))
@@ -363,9 +367,11 @@ static struct fscache_cookie *fscache_alloc_cookie(
 	INIT_WORK(&cookie->work, fscache_cookie_worker);
 	__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
 
+#ifdef CONFIG_FSCACHE_COOKIE_PROC
 	write_lock(&fscache_cookies_lock);
 	list_add_tail(&cookie->proc_link, &fscache_cookies);
 	write_unlock(&fscache_cookies_lock);
+#endif
 	fscache_see_cookie(cookie, fscache_cookie_new_acquire);
 	return cookie;
 
@@ -1104,7 +1110,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 }
 EXPORT_SYMBOL(__fscache_invalidate);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_FSCACHE_COOKIE_PROC
 /*
  * Generate a list of extant cookies in /proc/fs/fscache/cookies
  */
diff --git a/fs/netfs/fscache_proc.c b/fs/netfs/fscache_proc.c
index 874d951bc390..6ab23083cf01 100644
--- a/fs/netfs/fscache_proc.c
+++ b/fs/netfs/fscache_proc.c
@@ -27,9 +27,11 @@ int __init fscache_proc_init(void)
 			     &fscache_volumes_seq_ops))
 		goto error;
 
+#ifdef CONFIG_FSCACHE_COOKIE_PROC
 	if (!proc_create_seq("fs/netfs/cookies", S_IFREG | 0444, NULL,
 			     &fscache_cookies_seq_ops))
 		goto error;
+#endif
 	return 0;
 
 error:
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 6b583152132f..855fc47fbe6d 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -406,8 +406,10 @@ static inline bool fscache_set_cache_state_maybe(struct fscache_cache *cache,
  */
 extern struct kmem_cache *fscache_cookie_jar;
 #ifdef CONFIG_PROC_FS
+#ifdef CONFIG_FSCACHE_COOKIE_PROC
 extern const struct seq_operations fscache_cookies_seq_ops;
 #endif
+#endif
 extern struct timer_list fscache_cookie_lru_timer;
 
 extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index ecd14d645690..b4aedcfb5945 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -109,7 +109,9 @@ struct fscache_cookie {
 	struct fscache_volume		*volume;	/* Parent volume of this file. */
 	void				*cache_priv;	/* Cache-side representation */
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
+#ifdef CONFIG_FSCACHE_COOKIE_PROC
 	struct list_head		proc_link;	/* Link in proc list */
+#endif
 	struct list_head		commit_link;	/* Link in commit queue */
 	struct work_struct		work;		/* Commit/relinq/withdraw work */
 	uoff_t				object_size;	/* Size of the netfs object */
-- 
2.53.0


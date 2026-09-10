Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A457268E
	for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064530; cv=none; b=buYWq0miaTfoWot1k7UFwMbGHkLw1QlmdOWZ/skBp4PDnrzq2AxtsViH0BCaYGPRBYcqrxSC0KsxnPNBHy4OeHQjGl7M8E5zy57aXT40UYjEMwh7uB88AXybSNdzXHXujFnTPtQivYXMm3g1Gpa5Q78lHR/XO+Gk7f343BQBg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064530; c=relaxed/simple;
	bh=xeBaVq34Fvm+F/zQVDvqjxr/qQQkcNW+NLJKAnQ0Gzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWLWJ9j6JgXDki08+abJE8lQR47Yr1W5IxywwcOkY1go6Kx6H3uOtpaD9pgts7HwwKC+UFa0qbg0MmPW4uWmYEDasoHSue7NJVpxnexau7zcrDSDbs6DaaSDJs/o3HjQDDzFBp8ctReBFHEt6KOsbR5f0xQXjcdwWaKwHwCCcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Hc+S/zgT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Hc+S/zgT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so1205535e9.2
        for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1789064526; x=1789669326; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqDHIUprFGhLpfjoTtzfh0mDO50nuGrZXReIflYDQ28=;
        b=Hc+S/zgTj38xHlv2jmiEUhxvvF56DTZ6aXt91Ym3M9wc9QjtJiSI/NMSp+Q0nVJywN
         O55hEnBlCQIhD7FBeA1V61wVQBrm7BXTshD+YkTSbkPGaKpq9JJ5ng1S1GcnLptB9SgU
         TWq+7ei8wiWbowSwxMNcD0vBtlGB5kRL44LoigbSOf2kB2WEO8OiFHBPsDJbOuWaTEMb
         TfR9EvzlquUB4tuQQgfptz5j6WJTExfK2+SkOjmWG5rsBttR5bfPJ8bpnyOikNqDnz1B
         ZAv6XOBWLgTsJoyu0YU6Vw9vtHEEM1uygZSoh5XoRelXTOC67fab146Se5qBHzXeENuC
         UvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064526; x=1789669326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqDHIUprFGhLpfjoTtzfh0mDO50nuGrZXReIflYDQ28=;
        b=OqSWD+JKB92bYJLs2nfNUVaGeNC8y9dkOnG0zqsxaSiWVTVmChK1MEw5Bl2efrL0pH
         8dRHKFU2ycdVtK3sXk329PJ1bvqPtM2rv8TKJkAyQc5zDVuYVK1zCsMi9elfHXoF5ekL
         thz7b6R6jKtwjLB6XeO7d495nuzxfZ2lHx3HRKr7FR3msNVp+kvPvWJ/rYOaIiUMwwOv
         7+At0le9xvQm7iOMlGGHz8kfDJPdDbllft0eanH7emT9PkmNT98KlcA91TQLfIHTtMzR
         2x3TEcmztutupLv54wMJ0wEkf5Dm3O/B03Gh560PZ78qO0t5B+QV89yzBlFJm/1bdwS+
         bsIg==
X-Forwarded-Encrypted: i=1; AKwUvBwpW4sAdQ5GGOUfXNTk3vs6llXhFEYxVJkMOFcXzsY+b634LiASTZbnaX63nGWHCpXk4LnswA==@lists.linux.dev
X-Gm-Message-State: AFuF++kR1iQ75l3fiyKAYRWkdnefUj3BgV+kWs4D8nVAYp9FaejLaUKA
	s+NLnX+R9dzttehqX6zg4T0QLI3R1N+Bw/0AUUl08QaszhSltvmM/FO6icJt51bkESE=
X-Gm-Gg: AYBFou3lN47iFN9lM5G2iuHfzrmbYxl0BXnmMwMIMVHVmGgGLb32uMwy/vN9mFN8gPM
	6nRwJQAxXi7uROxEukRSp+eDStMhrK3qerFKmBQ/ItpfPq3xd5ByDylqTvqwc/BsJ2oCq/QTlOK
	5oq4bgjE6GvANGlPQ4QsqAOVGHtX2yMFQsM7MUrxUHy+1dfnba6LFRIzQkFPG4TLERfZqMVGNnC
	GaDTpthjzcZKVMJJV9DqaonxcgujOs41LYyT+zlhPIkAmhDhskFRft7Lz+Xw+oSZDiL/hrUxL44
	6MT7pH+tZHzwCnHUB+FF3DiINbh3RiogRqwfEoXXON8i1jhlmNqtF8jYPj4oEMHn3tXGA5L85CF
	wfDVUnqJVNTtgtZb2u5YPLKI2aJSpIS9iJjYGcqtGiLMujPa3E1fppd2R5U0G22jvoUFJdRtBUp
	nCoPfvDHakllqvHG5XhpwdHvUbBsNK6BnzfJALfZi+2CC+9VCsQaaWai5A/F8AwcnuLDgBNUMz/
	X5jE77dc4BUwv3gIkPSDakGYLaZPESnfFnmpCyH+WXnoBfxt8Z1JAuf9lvkRLtTp9YRCusKTvo=
X-Received: by 2002:a05:600d:6501:10b0:49c:fa21:e73b with SMTP id 5b1f17b1804b1-49e619c0bc0mr2423325e9.17.1789064526542;
        Thu, 10 Sep 2026 11:22:06 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm40025455e9.11.2026.09.10.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:22:06 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	steved@redhat.com,
	viro@zeniv.linux.org.uk,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] cachefiles: pass a poll key when waking the daemon
Date: Thu, 10 Sep 2026 20:22:00 +0200
Message-ID: <20260910182200.1272489-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keyless wakeups bypass epoll's event-mask filtering.  With only
`EPOLLOUT` registered, any cachefiles_state_changed() call will wake
up the epoll_wait() system call, but will not return any events,
causing a busy loop.

Pass the relevant poll events with each wakeup so `epoll` can filter
out unwanted notifications.

Fixes: a5b3a80b899b ("CacheFiles: Provide read-and-reset release counters for cachefilesd")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note: backports to older branches need to adjust ondemand.c as well
like this:
-       wake_up_all(&cache->daemon_pollwq);
+       cachefiles_wake_poll(cache, EPOLLIN);
---
 fs/cachefiles/cache.c    |  4 ++--
 fs/cachefiles/internal.h | 15 +++++++++++++--
 fs/cachefiles/namei.c    |  2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 9fb06dc16520..08ca598618ac 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -255,7 +255,7 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 	    test_and_clear_bit(CACHEFILES_CULLING, &cache->flags)
 	    ) {
 		_debug("cease culling");
-		cachefiles_state_changed(cache);
+		cachefiles_state_changed(cache, EPOLLIN);
 	}
 
 	//_leave(" = 0");
@@ -275,7 +275,7 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 begin_cull:
 	if (!test_and_set_bit(CACHEFILES_CULLING, &cache->flags)) {
 		_debug("### CULL CACHE ###");
-		cachefiles_state_changed(cache);
+		cachefiles_state_changed(cache, EPOLLIN | EPOLLOUT);
 	}
 
 	_leave(" = %d", ret);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c93324e0f98c..b8a5ea4a5ced 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,7 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/poll.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -117,13 +118,23 @@ struct cachefiles_object *cachefiles_cres_object(struct netfs_cache_resources *c
 	return fscache_cres_cookie(cres)->cache_priv;
 }
 
+/*
+ * Wake up the daemon polling on /dev/cachefiles.
+ */
+static inline void cachefiles_wake_poll(struct cachefiles_cache *cache,
+					__poll_t mask)
+{
+	__wake_up(&cache->daemon_pollwq, TASK_NORMAL, 0, poll_to_key(mask));
+}
+
 /*
  * note change of state for daemon
  */
-static inline void cachefiles_state_changed(struct cachefiles_cache *cache)
+static inline void cachefiles_state_changed(struct cachefiles_cache *cache,
+					    __poll_t mask)
 {
 	set_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
-	wake_up_all(&cache->daemon_pollwq);
+	cachefiles_wake_poll(cache, mask);
 }
 
 /*
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 88955249a1a6..52eb227f07e8 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -74,7 +74,7 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 		atomic_long_add(inode->i_blocks, &cache->b_released);
 		if (atomic_inc_return(&cache->f_released))
-			cachefiles_state_changed(cache);
+			cachefiles_state_changed(cache, EPOLLIN);
 	}
 }
 
-- 
2.47.3


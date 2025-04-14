Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06428466A
	for <netfs@lists.linux.dev>; Mon, 14 Apr 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641922; cv=none; b=OSQUFzBWb5grDcrQNSoAAxQ2mbEJqvb0ci7yxv7aEAOfgmsv5P8YIfzdxHFqXqjyvHZwgTE42b/DYD3UkhQOGVuyiPsjoHpPj7PUvFUFN+5Q6ZF4VCiSL9T7SxoLc71sovTwa91TBci7titnvjNLgLM/EhEBMwlXKXSRLLt3vGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641922; c=relaxed/simple;
	bh=2DpxWFB8GfjCpGlzdPOjDPzw7KOI6edLbKfo8ihKDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7PqG4hh4RZp3FGXKvrGlTz5g0p2gfDbEuzGdrlxOO5rk9ZESm1Kozf1GQbD2XHWLNDCaJes+rAwgt2JkHsgBlcx5Vk6yxoWJGDkRWOyB/GiydZpbjxw9geUgFOFm5hoNIyQs0jw+R/DD3swzWR9wXeCrZ/crZlUaYnzLPUBxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itiYhwYX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itiYhwYX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fb0f619dso46906775ad.1
        for <netfs@lists.linux.dev>; Mon, 14 Apr 2025 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744641920; x=1745246720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+orTHrsoG/ME8bhkDWeas24eb9SABWKneSlnhlLedmM=;
        b=itiYhwYXTgR424F0tRXJP6ANxrp4ukAxCBgXqQCZ3Gk6GXCU8KeIJGpMaqZWLL6fxM
         y6OWwKKFlVUVjlP7c1gMOfKHb/Ep+hjpZCMms4UKjR/NvFHhY4N1Qg2NzHz/BO5EX/+M
         EvnyepCz43JKE2fMTP+qFe9Dy8UJCDcfGRu9gjZc/w/pPWptCLHt6f57llYmLSckrpP6
         1l7rGAGrj0EYgscHeF6NEd9Hi1lUk+04x3++5ngji75DnGr90EaPKiwySugUD/vKcWWI
         nc2qCi5ILYSXhk+OTBMJFR3/B1DJu7/7ln7+b4kmUHQilu/0icPOB+GOOA2YT61jHbrD
         fiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744641920; x=1745246720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+orTHrsoG/ME8bhkDWeas24eb9SABWKneSlnhlLedmM=;
        b=jLZvLfq/MYwJFuMHk0nk6othCUm+kpASZMprOZ5UlsmY3suhmnG6vbB1SMuQ7bCzbj
         RZ3N+aI5hXeqmSd0bsp+e0WbJEQ7SAEX963NmZ7S5QhEBbqZfz2k+WqEz+Q+ULI0Pp6X
         k5tdQyQvTnYt3e3tG29ckYtOC51ZNjRKBc3aO/Wcw6/IMUAbMWCasZMt5AmNlnZwyLRh
         bZ3RP/o1kj99timMlO+gw8nl2+FLZj1OgKYWCcj3WTwSxGkjRRteC61HoRQWqgOmjlkb
         iMmi6ptw+73rs3l0hJQzPILMXPJyp88Xpyo9OZPj0FUuuQXudjktC6G5qZtHv2INZyvK
         f1OA==
X-Forwarded-Encrypted: i=1; AJvYcCVJQrwrzcnId5TKZjV5vUDxRs098dL5HesFuRsFNHHcwUBp/ylPshwuXcXExZFEsNUWNE3xOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzklXRhucKoBlQIpX5WaowtyKu9sIIePXTtsXA1NsXDkmNQtp4T
	Yq6cDJvYlwmmmLRjLYekYRqmnaNYPgsVa9wNEvccGx1WlDBhCtXg
X-Gm-Gg: ASbGnctEy9VDAwxAGjfKPXbKVY8vSmoPurzxsL7M2P1WgF6lcf59UC+13bMQ/2i0p8i
	0RvQC3mtuMNe4NDY4BrsDGQufaaDevzkakZMaUvi6k5t1AB9gatt6JJxg0M3ffpi/0Hy+H4cqok
	/cfnv0FHybAB0Ttc+c+wGVOHc4FjAlheQ1yRaJdHYwVgBLKZeMdjFJMahgQTyLSlFcaaqvdX7v4
	S5xnT5ckSphV1cdGZ/tQ/oj7vaai5PBz2VzX39wQTU4b0fdXxXvX4OXroezDwxg6E+0hKzzDlaL
	LXBOSDJNpOHHx5tPdRVQ3IQ5XalI1RSBKG7sY2gVJgfYRQ4=
X-Google-Smtp-Source: AGHT+IEMgRpQYfoBA1S0n/al1fUAyAoCcCwKAz83jLvqKd8Jlsw51W5KzaB+ji8UoJnK9Zaf7WJETQ==
X-Received: by 2002:a17:902:cec9:b0:227:e980:9190 with SMTP id d9443c01a7336-22bea4fcad1mr187715005ad.44.1744641916935;
        Mon, 14 Apr 2025 07:45:16 -0700 (PDT)
Received: from noctura.suse.cz ([103.210.134.105])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7b8b2ccsm99959365ad.70.2025.04.14.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:45:16 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
X-Google-Original-From: Brahmajit Das <listout@listout.xyz>
To: 
Cc: jlayton@kernel.org,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/1] netfs: fix building with GCC 15
Date: Mon, 14 Apr 2025 20:14:57 +0530
Message-ID: <20250414144500.20934-1-listout@listout.xyz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414141945.11044-1-listout@listout.xyz>
References: <20250414141945.11044-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the Linux kernel initializes many non-C-string char arrays with
literals. While it would be possible to convert initializers from:
   { "BOOP", ... }
to:
   { { 'B', 'O', 'O', 'P' }, ... }
that is annoying.
Making -Wunterminated-string-initialization stay silent about char
arrays marked with nonstring would be much better.

Without the __attribute__((nonstring)) we would get the following build
error:
fs/netfs/fscache_cache.c:375:67: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
...
fs/netfs/fscache_cookie.c:32:69: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Upstream GCC has added this commit
622968990beee7499e951590258363545b4a3b57[0][1] which silences warning
about truncating NUL char when initializing nonstring arrays.

[0]: https://gcc.gnu.org/cgit/gcc/commit/?id=622968990beee7499e951590258363545b4a3b57
[1]: https://gcc.gnu.org/cgit/gcc/commit/?id=afb46540d3921e96c4cd7ba8fa2c8b0901759455

Thanks to Jakub Jelinek <jakub@gcc.gnu.org> for the gcc patch.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 fs/cachefiles/key.c       | 2 +-
 fs/netfs/fscache_cache.c  | 3 ++-
 fs/netfs/fscache_cookie.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index bf935e25bdbe..1d5685edd1c9 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -8,7 +8,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-static const char cachefiles_charmap[64] =
+static const char cachefiles_charmap[64] __attribute((nonstring)) =
 	"0123456789"			/* 0 - 9 */
 	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..ccfe52056ed3 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,8 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE]
+	__attribute__((nonstring)) = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..c455d1b0f440 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,8 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR]
+	__attribute__((nonstring)) = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-- 
2.49.0


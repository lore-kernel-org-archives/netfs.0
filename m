Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA92750E8
	for <netfs@lists.linux.dev>; Mon, 14 Apr 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640403; cv=none; b=t1134Ks0sXf+w1G9d9IkaAKZD8weIZv04XwYex5oz4UXl1zx97v+bIvCbffOH9CRQZHODdgWz0qfjODBv6NK5gcs6FclntJInW6v8NdDt/snL1XBoEt2u3KxMpqoAwixpwOsgyBAD7DqoRVMnYToDaTitrjMumK4rAnlhIp2heQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640403; c=relaxed/simple;
	bh=4HluSwNWTBR8eHRrEF+w8ybc5StWcpkyjDrH6+uQSwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gvsso3YYcPEq/gVeKIu7OWg5V+y7a9Nc6c296Yay0JmwuXMD8arp0/xBLOD64KGpm0AKorV7tUKK3X1qUeQpkpyqy5DQMSZIg3cyxX67mtxus0jCFl2QC4xUvkiSu8N5dVa6gMv0YwTxWMMJjUtITyhVzmviIKe1ZVJ9L1wA7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPXtafR/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPXtafR/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso29352735e9.3
        for <netfs@lists.linux.dev>; Mon, 14 Apr 2025 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640399; x=1745245199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glJjEQgGBLhG4Ninmzh++t+Xe4BZvesnJ6GFYu9vl6g=;
        b=IPXtafR/xnQjxr+sfXSLP5/xrd1x0HYq5h0jHYOu4Fn0T2jv+7HnTdo7nRNA3V9mQc
         kXAkZN0DaYWSqXCMmqsiF7hoBn9O4OddoU3fobLX03MyKMe0GHm/0TsBCQ0s5lRl7ne/
         CUqV6NwyLlwakO9CXVpL9WGQm6HQHJIetR2nXmwkfE3ozNDShTH5D7Jy3TY9TC07r73A
         KsfVPwrxEoDcGSpO47Y0QYllW9weFMFitO9w6kHhOs2m0e8Ff9EMFgv8pXuy8vAQ7a54
         /E6KW75LW/krZcvIeU4y3XOG7BP3m9ZeTjKkmcJD3qm5kse40uyJQFON7+d2csCxNhdG
         ydxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640399; x=1745245199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glJjEQgGBLhG4Ninmzh++t+Xe4BZvesnJ6GFYu9vl6g=;
        b=FFEQd8dO6nWVIhDTAyo4Egvj9Dsxc8OOOYGSbOHFTvUb/jxbBO3dml7tOaOgM24WgU
         yvmU7nZGAE5VT2DoYbw6t6rZpN1y5FjwFG47XlRcITjkxkApSHctbgYB/frnDiPMTeSk
         dwaYyqMKxPSl7yg9dZ9iOkCY7MVbaQ/QEhz3uKCPPoN6oAj9VLmZX6PF+iaQTRAoXadX
         oDh2ebHZfuL0aNSVmKsB0OjebyEk0RmKiHyEY+JHuVT0UQ28o1urlAdTci8bHeigsW05
         6qbx+t4h4B/xv5kWFUsBm/YBCUfgurDQ1Q+u2IOy5seZI3rJ0QeaHyfb3pub6bP2it8e
         PS/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/JqPsPeGoywAj0ywi//qdvo/mw/dzizGttlpx9C9m6iVIut3qtVn7psfGwUlnrUegyJtQ9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRLoPxzPMk4wERWyTZHTlzDNWB09ZKcHeXNIbfgHb/RmzIkd2s
	jw1ptnqG8tqNiSPdtF3ec3KCD/Xu/ctomxJHbx9kdtPsBuQjSKmq
X-Gm-Gg: ASbGncth+oJlpwv+IKDvSi8HWLoPAwqoRro3UivFCV1iFHuxI93gW0Lkv1bNccvDqTE
	qdxWncb+R+aLc/Xk0GSKY6B0cSP2r6yDVQbSHNOhG/QQ2gG352BUkSSoOGhcAoADgXgVduvID7h
	JbfnS08wZHe0KTcyHhuvxPEo/B8e5h9cNlRHZ9DomxNcajwg8gOK6hn2JBaJT8mSbfaOB0aVeQb
	+XSX0AFFlTGIbJG6yPYvMO5MUwHUT3AStYeh6REuBYD3Z+9uKbVNtBbmaVpfvaUgqDqUIXlKRY2
	fHtUcL1Ea2DlAP3kS+15GYmd2n/QwsFimCbWlX9gUfuV7LI=
X-Google-Smtp-Source: AGHT+IEzS7RuQM+JXTxQhuUASOr5aQ5FuO0AY24LlH9uKFE9DugCkzr8JbnEOiJvoEsrDVG0ljh0UA==
X-Received: by 2002:a05:600c:6a16:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43f415d29a7mr72789265e9.14.1744640398599;
        Mon, 14 Apr 2025 07:19:58 -0700 (PDT)
Received: from noctura.suse.cz ([103.210.134.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f23572bb2sm178143515e9.29.2025.04.14.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:19:58 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
X-Google-Original-From: Brahmajit Das <listout@listout.xyz>
To: 
Cc: jlayton@kernel.org,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] netfs: fix building with GCC 15
Date: Mon, 14 Apr 2025 19:49:43 +0530
Message-ID: <20250414141945.11044-1-listout@listout.xyz>
X-Mailer: git-send-email 2.49.0
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
 fs/netfs/fscache_cache.c  | 3 ++-
 fs/netfs/fscache_cookie.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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


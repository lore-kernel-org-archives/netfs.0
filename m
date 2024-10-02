Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3A1D0BB4
	for <netfs@lists.linux.dev>; Wed,  2 Oct 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878114; cv=none; b=Rhi7BUb0TF45CrUa9yJa7WcjR8MoJiaVoqJnkVGlffG1ZzYpXBLa2FUxXip+yZNu4T0HfpbZxi0YhOGqg0v1ejFpm9nZ853k6Cy/e6NWqh45xHlfqoRZEPMkR1LfzYbxHejDFOhRlmZYIsJaALktasSSXx0y8LT3n1G90bwT6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878114; c=relaxed/simple;
	bh=16aV19EwS9kgC76HEIx4YCD0z+8yewNhUW2bXs7cxkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8/bkHwx9fX/M6P7Q11PepHYxwETdU7vSHheTem01zxWRhtqs6l2Wgczv1n+j3oy7ZDQT4xbqrc8rdGFGCwifLQtCoxjs7D7kYDDwV50Jn5C0sVzFfoJlBPMRZYP+MOx7VtxT8fXDO9t1kAww/crRGV+fXPA5v1hUmWYWSlry7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljDmP79o; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljDmP79o"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c8784e3bc8so8137058a12.1
        for <netfs@lists.linux.dev>; Wed, 02 Oct 2024 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727878110; x=1728482910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ceLFK/YtDaZV5eWLt6NTAt8wu5+9Jm8vw5LdLvf/bgU=;
        b=ljDmP79o8qI7/Sc7OI9OhXdCMPX405l6ug7k71eqILBJvIC4PAf7czT9FGpjm+T+Hv
         LQuPEfRQuGnzOiCO7Xr5heRCNeGeDa871ikF52V0NdKByQmSn0/Aa1kOhBs8Q0+8FUxv
         +ZrkyPQ+g9/kbZ3LBarkJzT6bXi+AzhKvVqOouP7TqObdfmsYDlQEFCisVYuHI8NAG+w
         ida2SCPFGD2turOefl1ZZxj65Yed+QdJUt5ZAx3vd3xRso/u+LQJd98IKZIqRPkLLgIu
         JJAcNnj5F/bqLCSn3CVvdQD2+dOw7iKBLLEuAZxt7/+qWwPKNo2hbs1W1KHXO/8Zd7ed
         5jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878110; x=1728482910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceLFK/YtDaZV5eWLt6NTAt8wu5+9Jm8vw5LdLvf/bgU=;
        b=o7hLk0bSrAD7b2j/m/6jW9RetMGVKuxeIGadPr9IPf9Jo0Aot9rHBJOYEnodM+ooCW
         t28RLynXKACYOXegBZz8NYdau8Az33ceILqnn/AKxyYESfSjKtQ84llIWDAaujPeSIhA
         ymJGh5lXe3kvRBKQiZtqHze5ShrGkFS4mQpcJhNm6xbaxAmzRmHImTm+RS9HyuI1nF8X
         +pBau308s6uPxVdzsA0HiKUB4K3gKrRACjf0rXrC8yHZN29Nmom+bRZqQS3ooBnASvo5
         4aoOgn7jW8qQwI8s1OPqlw4hEhNH49wsgP1gqVZLKQN9LLyylo/ItFoRhaWiRoYyoAMz
         bFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsBsdNEJPl4Obr1XFerjymi/TzFavfsYQQ8BgiGLLZ7YRhN59jSOekIFcFcPPNb6yc3ibS6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxDQEFQFAz+/HulE7klttVv9qpk31yA9YBg/3PRA5AtF5oq502
	Vuv1Rt6EDnyHvcPsba6J5cn6omrVQmMPxDM2YXjfj5YAGF/Gg8mR
X-Google-Smtp-Source: AGHT+IF/f6Wwy89rid/kh4LLgAiP701gN+IFDRm7SCzaoKXY7IUH8vc83h8uLR3G77Yco+caekkW8g==
X-Received: by 2002:a05:6402:1d55:b0:5c4:4e2b:7553 with SMTP id 4fb4d7f45d1cf-5c8b191d271mr2628923a12.10.1727878110239;
        Wed, 02 Oct 2024 07:08:30 -0700 (PDT)
Received: from azathoth.prg2.suse.org ([45.250.247.85])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245e763sm7653284a12.50.2024.10.02.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:08:28 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH 1/1] fs: netfs: making arrays non-null terminated and fixing build with GCC 15
Date: Wed,  2 Oct 2024 19:38:10 +0530
Message-ID: <20241002140810.1333092-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 15 introduces -Wunterminated-string-initialization by default, this
results in the following build error/s

fs/netfs/fscache_cache.c:375:67: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
...
fs/netfs/fscache_cookie.c:32:69: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

This due to fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] =
"-LCAIFUWRD" or fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW"
which pads a \0 or a NUL at the end. This leads to the number of
characters being increased by one, which is more than
NR__FSCACHE_CACHE_STATE or FSCACHE_COOKIE_STATE__NR, thus GCC
complaining about the array of char being too long.

My patch fixes the issue by separating the contents of the array into
each character, this excludes the NUL character thus the string (-PAEW
or -LCAIFUWRD) being able to fit into thir respective arrays.

I'm open to better indeas, such as increasing the size of the array by
one and others.

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 fs/netfs/fscache_cache.c  | 8 +++++++-
 fs/netfs/fscache_cookie.c | 5 ++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..f96e08c59417 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,13 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+/*
+ * Prevent warning about character array unterminated character sequences
+ * with a string literal
+ */
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = { '-', 'P',
+								    'A', 'E',
+								    'W' };
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..8656b6840c1f 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,10 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+/* Prevent warning about character array unterminated character sequences with a string literal */
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = {
+	'-', 'L', 'C', 'A', 'I', 'F', 'U', 'W', 'R', 'D'
+};
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-- 
2.46.2


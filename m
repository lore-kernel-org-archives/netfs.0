Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDC19F131
	for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446613; cv=none; b=q59lzG2/4EwEEoX14sCq0HzTKL2wqUM3Wr+UUGNOTPtnDA/6M4wyA+MPkagh/V1wKtLeKnWdA88VY8dZqCBKOLRfdjL0RQuwRIyaKBY7JTsfFEPxg/7Bb/o8k2A670yM3GlTg+6YopDOsf9eoZCJ47ivDgmqZnC15MgAj2WMV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446613; c=relaxed/simple;
	bh=DOUXDV6OwL89Dt5hOpDPur1plqIU+DUGKoD2Xo2eMvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUSU1B594Dhs24EWgu9kryu8JaHZg7aSAvtVi/N4C8acUWB44q9aKOUFQ+Y3edqLDu5hySD5DiBjlVYrLszVc0X3kf0gbeFaCBaYxSrmGS0Gny7Poz8hwrurhBHcuQNHBaN/1fPNs6FiYgcLVg9JsTIuWOyaDsx07B+pYNBE64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aINi8FIf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aINi8FIf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43624b2d453so57729255e9.2
        for <netfs@lists.linux.dev>; Tue, 21 Jan 2025 00:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737446608; x=1738051408; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpdjkeJqFcz+kwDllwF4R9sc7E23pdl17BNJlzMM6X4=;
        b=aINi8FIfxGbljms0MtI03/VAOOE9w+u1CQ7boodlgfy77CAEJfZ60b9tPOKSGtO9Fp
         FCr4n5xCSraDMkAEcX1oq6z3mgmMjTd1DrRwvyDagYWPCe1Di7y8uX1Jl/IDwpkT/SDM
         Z6q0TBfnFUyImwp4+QkXFckJQcwM5iPrvPzvJxpmkgFmZZS8AUWj8ut3VbwftkHVFw4z
         ZMFp+pE9Vco8JfHQE7g4jrCCxHgfcgn8NGmh74lvacFT/r1KGhLUTzzit7aT6lR4x923
         tQhMn3Pb4IO3y5l13UgDTb9DDfI8LtHKk60ceiM24ioRF/oqUYn0yoOY0G/EnKJrfjb+
         KO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737446608; x=1738051408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpdjkeJqFcz+kwDllwF4R9sc7E23pdl17BNJlzMM6X4=;
        b=TU6cuDFOzj3DWIOS4b34WLMQi6imLOCdHIsqrVL9Adt4YSKBDx2HsshcZ0t4kErikY
         M3Wdbbm9bZp7edYCA1wO+eq9h6i/VKgnGF+jSxGkKgMDDdSZTn3s++PalbYzRs9Ky43W
         n/jucxuIgl4t4WtjRioBgPwdqX1dm1zfqbb8s9o/UYuxPPmvXlm26BiaPWwx/qWwmWX0
         401F8FxdkV1VpSEVSsxofhoEEmqzixutkqDjMzUmmcVzroHewTG7NN/qXfk2nb3wWDps
         umWU1hQtFkY8pITaFg13XZ/tp2Dip9WZ87xSPgonb2NHXT67URtcI4xYGiN78eP69IYU
         FYfQ==
X-Gm-Message-State: AOJu0YypFW7f+Fi8SPIHyc30PIKagx3uqU754Bo/Se8nKCmUqQUyMMC0
	euVSE3xojRHXM+0bu8/d/KN43lI72k2L2woY+zGS+NR4bmNJhhO9
X-Gm-Gg: ASbGncsTg/VvOiYK9hV/CrbFPA/eZAjaW2l8YkxX0GyS0Y51i5WWh14r34lMKxxAnfj
	hd/9qQIgIf5OfIPQeaMSTJ92Xk6aVpzVaL8WlKADeY4BGt0iI2hIDrHWK7q0MVssV+RjuzND1C+
	Htys6zbFK2nOq69IyWsX5Hknq7sHY4JcdWUxmiKfFiRseqefkZDeGrkcBPYwC7aQ5qQUqoSNdyO
	4xcwiSBkIZzvgChyk/ydeeWkqYcAMcjyoJ9NHm1E3xcu6yQ806do+klixtawUHmrIleSGf/wYyo
	frE/xg==
X-Google-Smtp-Source: AGHT+IGIKGYKjc1RxhXJ+l76fdksBKkNwKkcnjTzHwv2gjFP+qncRxfIkKkGRtWjYmF91gTtzYG7zQ==
X-Received: by 2002:a05:600c:4ecb:b0:434:ff45:cbbe with SMTP id 5b1f17b1804b1-438913f5c63mr153137425e9.18.1737446608332;
        Tue, 21 Jan 2025 00:03:28 -0800 (PST)
Received: from azathoth.suse.cz ([45.250.247.184])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf327556dsm12577817f8f.71.2025.01.21.00.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:03:28 -0800 (PST)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: dhowells@redhat.com,
	djwong@kernel.org
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] netfs: fix building with GCC 15
Date: Tue, 21 Jan 2025 13:33:16 +0530
Message-ID: <20250121080316.1273544-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While building with GCC 15 I noticed these build error

fs/netfs/fscache_cache.c:375:67: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
cc1: all warnings being treated as errors

fs/netfs/fscache_cookie.c:32:69: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

This due to GCC 15 having enabled -Wunterminated-string-initialization
by default[0].
Idea for this solution came from similar bug before where the
developer agreed to just increasing the array size by one[1].

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a500f3751d3c861be7e4463c933cf467240cca5d

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 fs/netfs/fscache_cache.c  | 2 +-
 fs/netfs/fscache_cookie.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..2b554e1602a6 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,7 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE + 1] = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..bc0735c40ee7 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,7 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR + 1] = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-- 
2.48.1


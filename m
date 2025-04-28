Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9F78F54
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855350; cv=none; b=ea6DdUg6ONRiM1EueQHtls6Z0sDvw4FKUuPtZ2P91WTF83i8wKEoaXl17hat5cYQ9ZRC9weABOhboF/FvGT4jf3gcZj7tIQtcJKtzFY5oO8AIPAhXO9XYy8/i2a4ahKHXEVpxUmt5Kw4mF1mxeJ6Cv00tzk4YXE7+LxD+X2Gvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855350; c=relaxed/simple;
	bh=gFx38JwXwqiMy2Se5UXxM6fsFRHClk/f0StmadBMl0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FI9Axziyr7K1zLk4yulnsm05YoPWmASjalf2jp70WezL9kBUnuBWsLRr/YuvvbWcOsMJO0Z8cJVHdoNqVHwQk9ejr3yALwwr/5D0iVcgaiV8QoPYTXDW3iZtCTQa+yb/bf9C5eaRYT+5FlYKh960n/Kz7CPz4WNQcZftBm06DD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M5szlco1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M5szlco1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso39624485e9.0
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745855346; x=1746460146; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLEi7P+6egUB8ui1Q5+fpf99XflaYLV/582Eat25fLI=;
        b=M5szlco1yjmXELrlh4KiJx5f/3Iz7edBXJIHFUpSjpW3iEQHmFQDUSiSpVe57xGu3W
         +/OPCHzV99mGXyjErsvsxEQ4dqCNYNpJ2FEbxI+haoLL+OgdXxhS5KWYO6STr+5Qzi5i
         M3wHPhVrhTBR8I+Mbb4a5RaMDIPfM2Witqb+8Y73szfgXgyFaJKKPr8OK3n2VOXTL3iF
         lTtUgUZO1+e1DEjP+KnCLt+A1gzFbU6VoUQaIScHB+r0Llifcox9sxUSzHem/8jO5OUt
         CAHHqU+72Zg4ALED7sAafbqQj0XqLpID/ymzlJyRP6CXhRtEL5LcTDXHABZTPQvbPtfy
         YZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855346; x=1746460146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLEi7P+6egUB8ui1Q5+fpf99XflaYLV/582Eat25fLI=;
        b=kSLEUenfD9SbSznnsaEOiiyBdsNgiCqj2qUsoLsyzaKv/CQkLfpA8dMqHsbdU5McKS
         dRAjis+F1A6lo5vrz/bdFRlECYQC2SY6iUvmB9DWc/v9sb2mVQS+3QMvDB8dWFAsI174
         anUgbUke4evD7+dkUygJQsEC8cg49C0xe/Qw53heJb6AoDcxdtAGs8yZLOLgPquTUudf
         a2tKZdOWI0GcANF1XXA+MEn29rRNMk7A0PLFOcoXausQrtB79YUteAj8jUaJFSU5Db3z
         8YzJ1tTUmAmPTDZUcSnfS8PV0CA2OiqEkpM6uMUvC88mBzmJyIdJpcG5ecbRiDtxdp6R
         XrNA==
X-Forwarded-Encrypted: i=1; AJvYcCWUjuhVL36CnKmmQyoW5NbCtiJGIYfOXVWIAMstJcPmCzgZGMlsYoR9yeZ41rNz/KEhZETRCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRVGCT0SkPEoHnFX3aotpQbGWQddgli6oaylEhcVhqdsgwyiOG
	VVWtr3mZPJKmDkQjkIKDQwmJYQ06G/SWxZDdGMSgQbsw0WWC24pqjdTPALZFsZJGk8/tboOOFyy
	r
X-Gm-Gg: ASbGnctWDTj5Gxz23ec+WdDC7B/dBJP6sdE0+az+54HiXf5y0w4C+Ig7per+mzxAsOr
	Q6r96bPCnFA/IjtSqVx7z7/t7uKdnM/mupAhRj/coKO+9hT6yX7sAAXKK9/j4Ul/FQvmXfRr3rr
	G5muxRp5qnwrefvo3VitV9aO4nUdCP5WuKZGxcyqs8s752lS7r6rYSI2st6TrqUYwIdACGJjYNa
	k1D+O15IYh5ky8ZznlPGIpQKVbRQB4Y2nGOhflanhGVbfkBm8FdAJ71cVI1hjSPmcGTUCNfbkN6
	LI5wQQq1uKEk6qzwPtgYp6x6VgcOfeYsxLpuBG05PA4UwXacL98lBs6/ymBmAhb+FhGHKfFFclW
	+jxwRrzUhvJaaHvZxDIKvU8yjmt0GWZx+NKYCWq3z
X-Google-Smtp-Source: AGHT+IF+oU6dtbhSTUp35Erp4pFu9BKlgUGv7gC32SbNGmA7e0FBwp4PCzmoBwoLF5sqkEf92WCnAg==
X-Received: by 2002:a05:600c:3491:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-440a66b6fb1mr108980655e9.29.1745855345747;
        Mon, 28 Apr 2025 08:49:05 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29ba29sm162134575e9.7.2025.04.28.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:49:05 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/4] fs/netfs: convert `netfs_io_request.error` to a `short
Date: Mon, 28 Apr 2025 17:48:56 +0200
Message-ID: <20250428154859.3228933-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `error` field only needs to be able to hold an errno integer, and
a `short` is enough for that - just like in `struct
netfs_io_subrequest`.

This shrinks the struct from 608 to 600 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/main.c          | 2 +-
 fs/netfs/write_collect.c | 2 +-
 include/linux/netfs.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 70ecc8f5f210..fbb605ee0b28 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -65,7 +65,7 @@ static int netfs_requests_seq_show(struct seq_file *m, void *v)
 
 	rreq = list_entry(v, struct netfs_io_request, proc_link);
 	seq_printf(m,
-		   "%08x %s %3d %2lx %4ld %3d @%04llx %llx/%llx",
+		   "%08x %s %3d %2lx %4d %3d @%04llx %llx/%llx",
 		   rreq->debug_id,
 		   netfs_origins[rreq->origin],
 		   refcount_read(&rreq->ref),
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 3fca59e6475d..b405229de787 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -23,7 +23,7 @@
 
 static void netfs_dump_request(const struct netfs_io_request *rreq)
 {
-	pr_err("Request R=%08x r=%d fl=%lx or=%x e=%ld\n",
+	pr_err("Request R=%08x r=%d fl=%lx or=%x e=%d\n",
 	       rreq->debug_id, refcount_read(&rreq->ref), rreq->flags,
 	       rreq->origin, rreq->error);
 	pr_err("  st=%llx tsl=%zx/%llx/%llx\n",
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..da0d36615bef 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -253,7 +253,7 @@ struct netfs_io_request {
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
-	long			error;		/* 0 or error that occurred */
+	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	unsigned long long	i_size;		/* Size of the file */
-- 
2.47.2


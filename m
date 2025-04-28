Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B956267B07
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851146; cv=none; b=rI2KQZOWBgnWEwXNbiAUoC6pQOEmqvilU64xxXqfQZAoSy02FLkCY5WybDwoTByEGEr4elu6XK+Cl0D49cvMJIuYtdQ8RBSfyEZyMl93XUxbQWphBp91D9RG6UOHznSPF0x+sRTQl6QDmz8BoMxN8ekSmORhN07vP+z1VYPKykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851146; c=relaxed/simple;
	bh=0NkDHACqleW6reI4Vv7RYU8PfSu6tmBLb35jFPL2ZjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UD4SPiOxTiEMbvXkrv51S+iODATM0nxTPRXJHjKv0gVdJhqqMO4atZKfILUSpzu2FSrfpAj+b5mPLdcibhWOMM4RBDF2jYRYCYHy2VIe6Rs8gYDkjlfxas8LCLWLLjPiq82h9nKUe/WCXXOCzRCLjFdKpuE4VNu3ztQpoe/cvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DbwC0JDw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DbwC0JDw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso30868005e9.0
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745851141; x=1746455941; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBCzcr8ajh54REQAx5tYqo576zUyQ0mpJURQTfjVOMk=;
        b=DbwC0JDwB+7oa54gHbjpah+iYx/sxJX/wPYZIWcDIJ1wn0j9hh9I2I/deYaCEoBnQZ
         SvhGeYrNnuT1GV7cqTd9d0pKSC5Bnvh1V2x+gVqBnPK7/xIYCyeIljVZzg6HQkAP3FXh
         PdnMGYKu60RrJft9pg+P2caf4x/GvyIew1EQvev3ox6E9ev9gM6iUI2HNb5N3zBY+B/z
         pSOlzY4ExNUWZvn+dlyuVKhRqrbB7jx6Ls3MYa09nibtma2/l4klOj4kCE2o2nJnqP06
         kbPwHD3xnu0+W18czXI4TdyF7HrW8Jyk+m+Wh4kpGQKMjhFDoI0cz57MZjFM+0/uvE/H
         RCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851141; x=1746455941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBCzcr8ajh54REQAx5tYqo576zUyQ0mpJURQTfjVOMk=;
        b=UHO0CEtmFAq4mKhJ9iD7u1zZPeToqZM8te67/d2eHosQf8TMS09rIl4U4BWklBetVW
         e7+uq+A89ptDFFJC4eeeCXyu/aSc6AxdugddUQu0ebFPSl5e8pUSP/57enLeFrEDNUl+
         JZ38ta+NG0FmM1MmL0G1tdwh+RGlm52IfNzjQmnp8/M3zKxyZrcxZZU93yRAzQlobUFD
         lBmpf9EUU92ndVG77M1bPf5C7n124lQ5qJDsyege/z2JqYCZqllombqWcjNVudVYPn00
         8qW+COoPypvzP+RzNSw+pwHEDoJVrUcx/pi4Vq6y5oHHCrzAq2xXq7PQzPgHlOMxxnQL
         2gjA==
X-Forwarded-Encrypted: i=1; AJvYcCXCCEB/fTXfRIV3+H3klmUaA9cPdDZNXHCBeLtmzJ15NhBp0lN53fBkZNZ5DQo0cMCL9pNS7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcZE64F4zELpK3fLK1c7QWr3MNr5pT81HqA+osnJgfv7LgTmgm
	/sb8oiK1kA8SRvhTnLaCQ5v8q4pY3lNVKA1Mm6RA6rgQ8LN+yKZYbBWWykm17evp4thQ/O7Bynl
	A
X-Gm-Gg: ASbGncsO/gZ8/On4kq8RbPPbh0VVsZKEyKtfImYan4NeD9YZQM12+OBcrsSVhNyee5a
	E60v1fhJSm4HPhdWHkW4YcjCnBgtkEuq8Eu/N6mVDJXET0Ut/VcNE/6bF7J9CfPrkzf2/RIJ1sJ
	Aj5ZIBbI0XWegCFgM8QVr/JNUIkGcCKzwmxn8+AF3GhggyaROOYGENzL2B48Jk4HvzgwAorowpE
	XcyWwow19PizyauTwp80Ogjm0Z/GcrHGiuIOSwzkYoFKuy+GSu1W6mm/1zYlvsWgm1vFebfLiKX
	rJ8gKO7opEAMj+9/jK/mDojIok4Ma0nJ+bF1QcZ1qgr3yYsRsPe/WtlgPqDNHiiQ6XGqsuNI9Dq
	0KuZnU0mLTV/OglYfmC9s0NBZzIqDC998NNn4F+HB
X-Google-Smtp-Source: AGHT+IEsI2tKNcN8RrWxjF8JifLNV7R3TyH9+atKe855qmLQ6QAhvksJgkeh136stStXy9yNo0rwmQ==
X-Received: by 2002:a05:600c:2203:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-4409c512d58mr134362435e9.15.1745851141454;
        Mon, 28 Apr 2025 07:39:01 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a07a5ed2e0sm8793118f8f.39.2025.04.28.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:39:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs: remove unused flag NETFS_ICTX_WRITETHROUGH
Date: Mon, 28 Apr 2025 16:38:59 +0200
Message-ID: <20250428143859.3210257-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag was added by commit 41d8e7673a77 ("netfs: Implement a
write-through caching option") but it was never used.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/buffered_write.c | 3 +--
 include/linux/netfs.h     | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b4826360a411..26a789c8ce18 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -115,8 +115,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	size_t max_chunk = mapping_max_folio_size(mapping);
 	bool maybe_trouble = false;
 
-	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
-		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
+	if (unlikely(iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
 	    ) {
 		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..e1c224d50894 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -71,7 +71,6 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
-#define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
 #define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
 #define NETFS_ICTX_SINGLE_NO_UPLOAD 4		/* Monolithic payload, cache but no upload */
 };
-- 
2.47.2


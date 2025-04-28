Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC01DF73C
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873272; cv=none; b=pGHWc1RiDHUCRjda4THRGmqgQSU88E67nsHLyJlkr1ZSwnP/dGk8yVhNeUcQxFpZlmmL6jzCojxMEGURQvXwqRWZE06UGZZnLgnKh2bxVdupzVF2mudUKeOgSPB9YmJVkx+2gZKcPj+fzagSugaNCZ1dyv77w7OGc5mltji1/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873272; c=relaxed/simple;
	bh=f0A7Pv4mUmek+mS/LEx5Ttoi2xlGO1ZlQEuhN91pDOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHsALyIiDK/enngncZw96TfSe0rcdmntcYuJvNJTh31k8xcB9q9E2WLAr69hO5T2LgaDZZ9+CgrsZsOIgzp57bglxvOWoXolHvTj6ZCFSg1V9AR26ozCdIYnRCpkBwnSUcJTRMgxtv5BjfcSTgAPDZarxEbgwYFkY2LtuFv0Jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Yw67I6dI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Yw67I6dI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso35927825e9.3
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745873269; x=1746478069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhRzZPkotlQhfGJ0VfQNAgHBp9wCgKx0I/9SO7HTcOI=;
        b=Yw67I6dI+BMjh+HmM0Y19zcdmDxt+polWXlxvsqq/n2YY6I6dQfdsuMcrHA47gaVYK
         a2/TrffIJOsN+WshIBYCcjyYuNAiFn/7n7qFNJjF2whha9Qc38l/mMWysBozTfdVk15V
         raFpYufLr/siFZ+LzXr+S4meQiHw88noP2itT1Gb/bvA3X3hDV2/sEimmZfH7DWrOJb6
         qYmBTT+rwn7iwOCM0yjRKAg0RLc0UljmqWjk6nbKY3blyC72/cLkYYu2bKkZ9NV0oei5
         J+Hr1Wa0tCLn/w57yvfVDTLOT44dE6Tw1dfAsYlvJmPf8BX4GfFirNCNTZjB3S+9Ka/i
         +pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873269; x=1746478069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhRzZPkotlQhfGJ0VfQNAgHBp9wCgKx0I/9SO7HTcOI=;
        b=fi7cvDoEjmrkiA/KZg34YW/EZyY5semfbcydGVX36VfgdRLStfUflk4M1U4bNDzYYY
         EXsty9DMtY+KogdcEMduNUGPYiYeGsMPdfKFCTuXnOHZyUDVENtUWFx69OUXF6Jvra92
         4tBjGuSpksIE99B/1OGgCnvdTC7+yF9DotQpDiTeKupv/EUB3tgBz3JqyoQ923oBxDYD
         dSaSpj4VlIk0JkUmQKR/+kW91qhPct6zMucuS28uBApyKdFaqzbqeOuhJYdLrdEOp/D3
         80DtW0Jj60rmTh5vFKvIsLJ+7U8vzwQjIloHMsdxFI+WHTm2RX/vUrrHQV3wcMpr30+v
         vmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqa3rZtZaIvdHTQTrljFFe4lLOriSL+sfvlxa2PhsZMGj+Sdj+U/Bsh/96K2VFYoeaTE7h7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHCzU9G74qt4ep1oWzKfRpQw5hnLmcBa6gDSXzOcsfo+XjAOZ5
	oefntSNVaBTUZZ80Good5hcfMMl3F72toySCGcjmbZgUWnDhNx3EgxjUobSTIaI=
X-Gm-Gg: ASbGncsqIQKKnK069lDF539/+LCc+HgdLuBqaZj91kJIF3z7aHsSYF9qM14IzoCEc3P
	1EiDZ8Q1HI9xbuDYw59l7d+4pug9x9F9XL/gO4fxY7STlzSYc51+HpPxhWaPVpzUbq9CvrEHSsc
	pRg02XdpsT619oEITYzgRaanae3mJ3G1vjbsaa+qf6rf3qm2K98RLqUF8KvF+Sd4SdGADawoEXq
	nfSYWqHJc6brVu5hNbdQ9furqFFjwOgdxgZf43+4ISc6rMMRtyX9Ss5TRyxT2Hm7fVFSoKRNNIF
	u24ShFEJVUpEE6Xk0pr9CEaGHzF8Szt9I8Ukrwv1dB0zQytCt9s5Lvnb53Q+BN6akm+2FFKTaG+
	srF9LD4sR5ztU4ywE3We3I7EPWfKLX3xDJ5drhcGm
X-Google-Smtp-Source: AGHT+IGDcQ1DOtPDev5XDzOw6El4Y5dmKj6k+SP8aP+b4hCmYsuphl2n6OAtORooXHR0Cj3D9Z18yA==
X-Received: by 2002:a05:600c:4f8f:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-440ab7b5f6emr96114365e9.10.1745873268779;
        Mon, 28 Apr 2025 13:47:48 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29ba29sm168590675e9.7.2025.04.28.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:47:48 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 2/2] fs/netfs: remove unused flag NETFS_RREQ_BLOCKED
Date: Mon, 28 Apr 2025 22:47:39 +0200
Message-ID: <20250428204739.3405489-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428204739.3405489-1-max.kellermann@ionos.com>
References: <20250428204739.3405489-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETFS_RREQ_BLOCKED was added by commit 016dc8516aec ("netfs: Implement
unbuffered/DIO read support") but has never been used either.  Without
NETFS_RREQ_BLOCKED, NETFS_RREQ_NONBLOCK makes no sense, and thus can
be removed as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1 -> v2: split into two patches, see
  https://lore.kernel.org/netfs/88831.1745855591@warthog.procyon.org.uk/
---
 fs/netfs/direct_read.c | 3 ---
 fs/netfs/objects.c     | 2 --
 include/linux/netfs.h  | 2 --
 3 files changed, 7 deletions(-)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 5e3f0aeb51f3..f11a89f2fdd9 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -106,9 +106,6 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 			netfs_wait_for_pause(rreq);
 		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
 			break;
-		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
-		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
-			break;
 		cond_resched();
 	} while (size > 0);
 
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index dc6b41ef18b0..d6f8984f9f5b 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -64,8 +64,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	}
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	if (file && file->f_flags & O_NONBLOCK)
-		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ab6f5e0c38c7..e0c3a63f4f86 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -272,8 +272,6 @@ struct netfs_io_request {
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache from read */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
-#define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
-#define NETFS_RREQ_BLOCKED		10	/* We blocked */
 #define NETFS_RREQ_PAUSE		11	/* Pause subrequest generation */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are now queued */
-- 
2.47.2


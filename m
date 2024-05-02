Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1E53373
	for <netfs@lists.linux.dev>; Thu,  2 May 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639668; cv=none; b=MTsA5Jif7OkNQmeGM7vb2ge9mE37sDXtg2I5rMIIDOP+M4lMTbtNSDnirPAr8dSGEWs9JeVQsnnuTtd2cFPrkFREAbO3GK7LXQzIlfZbivnMN7pnkt3AIFxTnaZ1zVnqygORSVV/NQnnLtG4UC5hmtT1eLUsItV8jaRbF1liJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639668; c=relaxed/simple;
	bh=7wUERS10zASkjeML5DECo0InMoy+pGZDK8UElMVW8H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve4LagS/4AdjDI5L48hEa5GAI0+widojdPTiYH9Qd5KyzTz0Hjskev+gOlP4p9T7q5iE1UiU05bLHGuG/uVQrk69895jmFMqu6lnSAXJ8fswFOhUJpk7s+8xwIjEyPIs19K9Ap9tY/tP4irIV9ahJdwox9LJifh2DYGxFV+k5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQnoR+PW; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQnoR+PW"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2b2769f017aso2133135a91.3
        for <netfs@lists.linux.dev>; Thu, 02 May 2024 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639666; x=1715244466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UP9GO2qb86H7nq2iI26LPAW8N+Z2bRcTv9KbrkM7mY8=;
        b=EQnoR+PWhUQHLX7533U1ankeg5f8dPQWCUfRXT7cmy3Md1mIUuvjgDCy0vqFH+7/H3
         j2N6ujg1HZuUGLNakp4cXC8tuJYpOeQcuD6Fueb8yrGXWDJuWfFdNva0pxNXwe7a/MXm
         Wub/mpjaMYL1MqrxHSfRCNGI1zvvZ6ilf6EzXdYr7wCkEEO7j1yFywB3PAbQewDqWu2h
         cZ9dWO65rAeR/hBZw5DC5v1LSmke9fgV9n4R+rVi7lhvgKWkYGqSTqKUN8pIYclmDEYH
         WC2xaTHXfHjLTVKVMASxH5ySl5ez1facTsLi4sNJc3RtCDqatGoiB6MNwco8BH02a2Jd
         GJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639666; x=1715244466;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UP9GO2qb86H7nq2iI26LPAW8N+Z2bRcTv9KbrkM7mY8=;
        b=mJ1DuMyUWTKiOjy/RUSQHu3cWBfyAFH8u7vVzjmgzjfl0O3CSqgcdVNJlCzHVPCHxZ
         F7CRhocJz12cvWeo52mwPxKZeAnn4C8frOv/8G/1ob7htuwmu0yqQbLbjexdVIl09O7v
         STxRtCPdcILyoyLbLNbKmy7bAcoD9/spgJTfm8xXnVYBNAb8aoyxaW6KoXb6U/9R5XLh
         MjxgJzOE2jCFbw7TT9092YvwkjuKV2Hyj9Sa2SK+AVkvsEehOBtO5dTLzLXmygDofscE
         A4If/E8MrVINKVgycm93WJGjfTZLx0fAx39/NkqRI+ddBEJDO2RVovqk4KiKtHpomwrr
         Tqxw==
X-Forwarded-Encrypted: i=1; AJvYcCXRCIL6405qVRcKPBeNrOB36zpQGfKVOBXFtmtvdKP0UoVw2m6HDtWgCtCUAyCQTAXe49WmTJpcd1FVF+SggKCd5M8YGUA=
X-Gm-Message-State: AOJu0Ywpzo//G/G8aGQpzQ+bvM4eckHSrZVmUGFMikxRM+UFBf6lp8sY
	DQG8TjCq8Pr1tJDSBKXhGKonFTTMWi3QzU8udZW2EAQl1r09aKhU
X-Google-Smtp-Source: AGHT+IGyyg1F0OUABpcZNF++9ikGsOK3Q2kFtyAm+9ixtgSVwbvUEaYTKBIULHXdrWlHyTAR46Kcsw==
X-Received: by 2002:a17:90b:2303:b0:2ab:f9af:cdce with SMTP id mt3-20020a17090b230300b002abf9afcdcemr4828016pjb.36.1714639666422;
        Thu, 02 May 2024 01:47:46 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:45 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev
Subject: [PATCH v4 07/12] netfs: drop usage of folio_file_pos
Date: Thu,  2 May 2024 16:46:04 +0800
Message-ID: <20240502084609.28376-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502084609.28376-1-ryncsn@gmail.com>
References: <20240502084609.28376-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_file_pos is only needed for mixed usage of page cache and
swap cache, for pure page cache usage, the caller can just use
folio_pos instead.

It can't be a swap cache page here. Swap mapping may only call into
fs through swap_rw and that is not supported for netfs. So just drop
it and use folio_pos instead.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: netfs@lists.linux.dev
---
 fs/netfs/buffered_read.c  | 4 ++--
 fs/netfs/buffered_write.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3298c29b5548..d3687d81229f 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -255,7 +255,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	_enter("%lx", folio->index);
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READPAGE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
@@ -454,7 +454,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	}
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 9a0d32e4b422..859a22a740c3 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -63,7 +63,7 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 						    bool maybe_trouble)
 {
 	struct netfs_folio *finfo = netfs_folio_info(folio);
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = folio_pos(folio);
 
 	_enter("");
 
-- 
2.44.0


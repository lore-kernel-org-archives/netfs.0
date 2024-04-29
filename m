Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414B13C9D4
	for <netfs@lists.linux.dev>; Mon, 29 Apr 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417641; cv=none; b=Z1RQ5No0Z0AzqMS+iI0fqWcFoRp99LF8gA99U61XTNiK9MNBgcPEu2567/HrTePv6NDNaSVsinpBgqn549kM42QVIozJPnEyXwOO4yzKoEjahEHgwML1Yqu3Q/UMpeLDBA7UhRuw6FVp5OYQ0cXK4MAPFmGcN7mLOnuwrbBM0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417641; c=relaxed/simple;
	bh=qqZmyySN3ttr0mL8w3csYiQ6Lq6o3ZnWQDeTR//44Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaDYKtEdNgVTw+Lq2Au92YsVbX0ItmXe1RXf1GUvM2S3eIeUEotcGGgqpUzBnf7aCyLiojjipIZL21te7EMdQaTuLxRGdd2qhGQsj4sMl/GQp8rkN1noetwLlbbn05E/q+fsEAf1tmKzfz9pordQ31//iYlWKXTnNqihVQdnfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5dMvRTS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5dMvRTS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2c725e234so45460465ad.1
        for <netfs@lists.linux.dev>; Mon, 29 Apr 2024 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417639; x=1715022439; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ZAdz4nacsjUfg+kmWc7WaK5L40TR/d1vDMSfySNIi0=;
        b=I5dMvRTS0xPHbK0zKpu/NL4kKFuj1ScDuJAmgwBW4W+mB65/G0P15LEe1PWv90UMuP
         0XNR7Jktscg2Db/i+5WiTKzVB7MKCG4AosivhzxekEBVJFTrkDWFHMJtq8YRgc7cdbex
         mUAnHBglbuPxf/qfPKkdKb83uwQBZnnL9+NIUe5Hc+i0CZG0Uzy9heQxDH+s/AkcU0qS
         njmt6DiZDXFCzeGDwy4M+1yrgGf6jfpByiWAx+oEH8lMEfn39WsEr6+gE2XkpsDmt8La
         6zNL6GAW6hf2eqTNb8cVB/QNgLa8Xpz81qrW3ndk3fVwyZHjkMmgSRuX5MG6Qy9hhjwP
         XPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417639; x=1715022439;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZAdz4nacsjUfg+kmWc7WaK5L40TR/d1vDMSfySNIi0=;
        b=tpuNvx8QqL9yNMMrHWtJqj6E0gHBPEUjT+Gwsa0NEK+6UoWBsWznv7GugaEQD7uzrm
         d3rshJ2imwgpSsFQhlH1gOenCva9eWUx/G/9po0IEQ7weoDiQewSGYV8hOHp5frv/T2G
         lGVymAoyfIZbYCE/8lmnXQZYh5W1el6vReAFrflP2rIRukApKGDfZrt+7E5QNwm67/jj
         hFK9+1+6lAwMt5Be7ix6BFgW4UhWlD7guXqWHkN4wlTOgcNrB3g90YpvogJVVqlQ4012
         3V3mV9DKjbn5asNvoAjmp3XYzPwqv9QqDI61dSvpMIRlhBVPqOzXDyuHtd3WKV4fExnA
         5IMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbctaoBzzJZLAJZuIpMOHevzU0xPQ34cXnd4k1/dupSDRAuC01IlYpduIjJ3TTYUr4j+sQEltqyPicZQcGvwykZloCscE=
X-Gm-Message-State: AOJu0YymgnFiro2MiiQLxz0TNPfW9WJb3/F6PzpgbffAq7gh9bPW48Sx
	s23ZR4Ml864F3bTPL0Vb9JFmUyickMPiIdYhh6iozn4uIPNnG5Uc
X-Google-Smtp-Source: AGHT+IEmVRDgcLWQ+6tPsCb7ZBjy6NSNZhmYZz0nvDiJO9htXZ6R1aiOcZHSzS635P8dLMc8xNX3jg==
X-Received: by 2002:a17:902:d489:b0:1ea:964f:9b0b with SMTP id c9-20020a170902d48900b001ea964f9b0bmr870204plg.5.1714417638707;
        Mon, 29 Apr 2024 12:07:18 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.07.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:07:17 -0700 (PDT)
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
Subject: [PATCH v3 07/12] netfs: drop usage of folio_file_pos
Date: Tue, 30 Apr 2024 03:04:55 +0800
Message-ID: <20240429190500.30979-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
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

It can't be a swap cache page here, swap cache is never exposed
to netfs, so just drop it and use folio_pos instead.

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


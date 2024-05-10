Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537A16F26B
	for <netfs@lists.linux.dev>; Fri, 10 May 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341825; cv=none; b=K7BquaZK7oINqLfKV68DD7T3TQH2YLfx2KfTCu2ZtImPmUvGjbySPxSgM0uK1jetngBmoEEVHdue11jj7m8OQ/QrXxF7KIUvTI80GMgFVkJOaTZyb9gh7PICJX9pYLYTNV1vjCz5xrJzpGfmwXBrOVO3G5GSydnfAwvNGgxzSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341825; c=relaxed/simple;
	bh=F3EKclujHSSuxRJLJjZWka9tbvl2y2InP9dBBoHDt2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+IOewQObUp8Jt7qUbz85dlbUQYjwM9GgoAt7ncQmBADibS7xLyhW997WIae2Fy23VVljdQsGeCNtP2MSZftglM/2FQGYm0rRYHt814fl+MXvz0InqQqxPrDafWUxcdXNng+7IHQPXAhcIQwnhjWuyhyhQdveeTKIdSxWsKLajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep6yjGKE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep6yjGKE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1edfc57ac0cso15524125ad.3
        for <netfs@lists.linux.dev>; Fri, 10 May 2024 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341822; x=1715946622; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r4pI/dLra8+Fx5rO5TUtIiOfN5ranfVQtnPo5N4NowI=;
        b=Ep6yjGKEYs0OQA4kuY9TNMQpouMST7ZgQxbvvArM8JbKopqymw2DEkMsMfuE4roA/n
         wsDx2R6aqf+0F/hrOuYO41d2TF6O0kVAwUwyWoF1XmV1GjZBj07J5DPd/CZ6Nuks6kp9
         ihrMNaGpZwu0UIKg6z/um4t3mJbZ8x9YQBBXfMKlG7YZitQgdinCqDmrLzXStYXenn5X
         6Rk3bWs6ZMdKw/0O1iVdD+CLi5kWUVyt4hwD//JOmkEOII8qY8BCUx17p/7k//4MovEy
         1ryZdXT5xy8uEcWJxiY7aMRKFDzvrLxqIsbqK5kNqK+LOvfpZmSNAnXKSO/Y9PMbIbFy
         vc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341822; x=1715946622;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4pI/dLra8+Fx5rO5TUtIiOfN5ranfVQtnPo5N4NowI=;
        b=DqQfi+gRSh8LFs8LddtGYYmPs7p1nEC2YgApfbRf2mE6YF5KvZzo+Q7KnhHrRiRUhR
         vazJgmUXkqFEUOKA7sJrli07VK4J3L9NUF+RpmCFxssM/lvOUIpx/T/i7czTv3Sg38Ma
         YWLbJRjM6ehiOEfFA2FVetouIe1CEHp5gx4DLdJ8Bzqrcv45fzaT6nQI9akGvdbQF00r
         aSLfJDHEJghAcXauRetl+hk+ohto7pGTK3kb6q9O/LegYpucSrM65mRmbP6KphGyW2lW
         DOB7qvA2Vsv0WNgs6xGAySl+Q+PQ5Al/5pKPZaqGuv4XBKhfxH6IPHS0+V35GHAf6kcw
         pP+w==
X-Forwarded-Encrypted: i=1; AJvYcCWks/d+kZFbWT/S1zZy8Id+/KyEaog/sJrfnoH/JEH+d8mAfmWQ4BtVuF9B41ELM7MQWWP6Ek6VYZH7xuW4PlWVWxh1Z9A=
X-Gm-Message-State: AOJu0YxeqTQ3LlRcAwYU+TP1YwPMdd7VjbmCkQv5xwihk68h0ojLUv9n
	dRChe06a3CYQKhefFm4a3pSFYTYlpiO2jGsw/jtskaxzcr4GQQKp
X-Google-Smtp-Source: AGHT+IHSu4vf1uCLF5qFTJHXuHSvWwDd6wRy4AQCNalBLaHz4N+8wZRkLwQ24nQsMv4SDXunk7nJRA==
X-Received: by 2002:a17:902:dacd:b0:1e5:62:7aaa with SMTP id d9443c01a7336-1ef43d185e9mr29151095ad.20.1715341821906;
        Fri, 10 May 2024 04:50:21 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:21 -0700 (PDT)
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
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev
Subject: [PATCH v5 07/12] netfs: drop usage of folio_file_pos
Date: Fri, 10 May 2024 19:47:42 +0800
Message-ID: <20240510114747.21548-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510114747.21548-1-ryncsn@gmail.com>
References: <20240510114747.21548-1-ryncsn@gmail.com>
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
2.45.0


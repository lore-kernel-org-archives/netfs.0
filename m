Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1C149C7E
	for <netfs@lists.linux.dev>; Tue, 21 May 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314371; cv=none; b=RBozYRQukS8mJrvqgZA/bh/qi+RLJPW0TMVFTR9lsp9jnJNc4v3klWtH86fmH4Dx9wORR1OxPtnTmAcX1/p6hE5/tEZl9tNZaAvwoZdmbnEuy/WmgnStE0+vAn6A51WjcquFBYz8X/xCv9mS6/P4AfS5avOH9HKqHhitP5Oq9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314371; c=relaxed/simple;
	bh=8KtNWQs4oLqQnrcIx6ZN5romD3/jWxvpvKP8KnV42Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeW8hKsYvlYwbF/AeCiMgZV99W59IYpt9dv8Z1zaNe/zYBzBBH9Eef0qodkEazvEsxuvrY095Aqb1KVl4vv0mI8gEgxFrX9TfXeMGECkwO4J7/SPjIoHHUOGt5t9mkEAgG+QzBQVdZOiOcXjcSW9vZcixwrH6JC6084Z2BKXX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql5Bps9I; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql5Bps9I"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so709836b3a.3
        for <netfs@lists.linux.dev>; Tue, 21 May 2024 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314370; x=1716919170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xg2lyZdavS/xqDWMBFosXrNzMBl51D2SBqOTVmsbmqo=;
        b=Ql5Bps9I9iQsMWH+pRyJrXlnggizzodSwMlz7vIDvYnORRFzFDw4Uoivp/lqvRFnuv
         OWLmTT3mzmqrIGU1PqUtJ9q/Z2zw83k9/mjiGV6FYrF6kCIHmfukAUIRYhLYYCl92gA+
         A+U+nZ95f7coJgg5el+bkrHbdZ2nV0JawYfZO8j7yGKmVllL7KoA+CYZuH+rKU3yDqUU
         fp3jzYvYsVb4VBek3rj5XWadmSEb1FmBMMNcTp732+fqGDs1RwdhLk2o4kofbr51MC+S
         nUWeLX6iYxrtpPrS3gKOJg1uyDhqIh3CHBWuLc8T7TS4yP91EtmZ/MEL7Em/l1fq3MSg
         27tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314370; x=1716919170;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xg2lyZdavS/xqDWMBFosXrNzMBl51D2SBqOTVmsbmqo=;
        b=rUBS70rU0KgoK24GNb7wOXa1f0ErLf1KXoih6DVDVCVHWqxuDh4aNe6KuyqvV3WEka
         E1RJC3cHmbWjZyFP/jBD4g5ey/7vtBuQ5FntkSjjeWL4Rdh9NifOilS10128Ydb1uMrn
         SDtO64y4ETgbScpjclnqBVQlLp1SNNlNszo+5p3wG3Mz0ywhjM7XP8hULNOSOYJNA5kT
         /QS5u6oeD9Ojdeamuu6nLTWBGgTJxPR9/Mq96sYdchETSV6nyaNb97DAAwHp7s3ulTsa
         3+f6RyvbG2k+0f77Sgp6a3XXT4V9l72AXArYpeWhp6K34OqmnyL7O29t052PwnhZYYR4
         H5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtRktpHP8UMMUgOyyNUIJ2FGd/oOSqnNyTNsDPZ3GwFg+lJgfkC5deXqP/zXAS6UsvULCT1Q6gPdCSk+B7AqoZvSM1gco=
X-Gm-Message-State: AOJu0YymKZpxY4KxKogDfiWX39t48YfyFc9ce2nMUNztbphBgMLmY5mB
	s3oymJzN7PCMwwHc+98F0f28FLcwCxIzZcu04nvt9Q7Cjcusc8+c
X-Google-Smtp-Source: AGHT+IFJcbaL2RYoor2pNfsZrFdmKgf74KAMgNVGow1v7hTBzhmhyuQsxHRR2tBe0moomC0BGjEz7g==
X-Received: by 2002:a17:902:d4c4:b0:1f2:eff9:cd4 with SMTP id d9443c01a7336-1f2eff910a4mr117995375ad.0.1716314369672;
        Tue, 21 May 2024 10:59:29 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:29 -0700 (PDT)
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
Subject: [PATCH v6 06/11] netfs: drop usage of folio_file_pos
Date: Wed, 22 May 2024 01:58:48 +0800
Message-ID: <20240521175854.96038-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
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
index a6bb03bea920..a688d4c75d99 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -271,7 +271,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	_enter("%lx", folio->index);
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READPAGE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
@@ -470,7 +470,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	}
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1121601536d1..b3a6b7b41192 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -54,7 +54,7 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 {
 	struct netfs_folio *finfo = netfs_folio_info(folio);
 	struct netfs_group *group = netfs_folio_group(folio);
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = folio_pos(folio);
 
 	_enter("");
 
-- 
2.45.0


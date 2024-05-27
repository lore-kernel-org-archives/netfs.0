Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957C1F93E;
	Mon, 27 May 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841063; cv=none; b=eYjUVfhs5ykllxXOCt3cIcC6Dt0Ty7qa7ATvpgJSWBB0FpZOwO0D95I8LTcYYE0NS1fuUEZi0qfXEmrT6pnS2NaBqHhXdGRZwWRFeU6NvgrP2eRXKdgXDM1eG1O8nZhjZd4x8le/bfhu3Zg+HxIG2CSZ09icGO8DljLgTM8qJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841063; c=relaxed/simple;
	bh=/9kUq5EMxCqTjmTkOzTNl6oIfCxnjJBJ5Xsg8p3q1c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMI8TPwAYajJzdquhS21T2vDF4+IWnai00cDh5ejX9Gk6Oz2QB13Usb1f+vLNjO/+kVE5AtGKMr/lIvPTx5qGriGYGkdsdrAqelJgAOfKsLvFy0Xo57SY4TWNXVRByvFT0Vgf5Sd/ykrcbfr2RgUXR5Ejci3YNLLrE5kutKatgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qS6AX82e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qS6AX82e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=WglzafCQ32Oh9fRpxZ2M7keEtteiFvz8W328NU+RXvY=; b=qS6AX82e+UVA9l3bloIlXyEHh3
	HefYPtGajiArHrlzGcjEOms53whTl0ubR49KAkcNr3rU80m4Y2kfbc+4wTvfBdZozAubRX7/b9KHx
	V5FJb0BKwCqh95iv78IE+24fmLdimFHp+TT1ep42SZVeFO50JpW4j2QXNHksueJ/zYn4dVKDmqha6
	4f/5y6DS4Of3JbGljIuqTFNjKi/IbbOZCo4oA9PCvBZD+rWUB+rj3Isytmavx2p77rZOeUpqzAsib
	xDUmHDrTibhxz7Oe9gIaZPGrcr3cxIzB6AsE28ZXmwIaH7pDbUrw+uTY4BWLEBjCvl52+Ni76wNKa
	1MTfXodA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBgmn-00000007xrG-1sBi;
	Mon, 27 May 2024 20:17:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH] netfs: Fault in smaller chunks for non-large folio mappings
Date: Mon, 27 May 2024 21:17:32 +0100
Message-ID: <20240527201735.1898381-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As in commit 4e527d5841e2 ("iomap: fault in smaller chunks for non-large
folio mappings"), we can see a performance loss for filesystems
which have not yet been converted to large folios.

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 07bc1fd43530..3288561e98dd 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -184,7 +184,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
 	ssize_t written = 0, ret, ret2;
 	loff_t i_size, pos = iocb->ki_pos, from, to;
-	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
+	size_t max_chunk = mapping_max_folio_size(mapping);
 	bool maybe_trouble = false;
 
 	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
-- 
2.43.0


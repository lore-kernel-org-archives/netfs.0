Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D111F17B
	for <netfs@lists.linux.dev>; Thu, 25 Jul 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944968; cv=none; b=Rbm7hAIjQQ7AoUyZSMNLc4Jbnd/rk8ldPpF/GDqkSNLfeMdwXY835zPera3ecHOxKq70yJw4UzFFWesUBG2NP5A+Bhr8BUrFCgsirzs1BUZrkfYiJO26eriPOcHqxQxlWIXq4xyJx6Bt2aOVPwABypfO2omLNOrZwtj8CAiJ/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944968; c=relaxed/simple;
	bh=WeYaRAM7IVObsPEOnInvvmRNdPRPLmOkGxERJROyOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj2rp1KNjL5Yvx+3dKvxiREayN9UpbqtsyerLRc0jnR9FezpYRDnWt1BDSiO1O6QYrhLEylNzYa67IWEvuegyicT1/dPFZQbz+akis6Kparx6Ve37QwBheTI+fH8KWjRbHVaiyVnNQ0Yzif+zLu7T/mjqjsryldua48Zvv6SKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQeOR0cs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQeOR0cs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IP3CLecV8AwDf9AfaJmz1Uxqrl1hjacNx8SsGBhckIc=; b=nQeOR0csTWN9pzylhcpE7W2hj7
	pGlrYDKlsNjJ1P0kAXiAxzH9qRpS/InkjDe2qgQMpqzKObvoE+JpBAojd1dA3qv0ZTMxCRuXGCQc7
	qeHbKeLUyRwlmpas2yq3qN+DIqCC3dW7uBnoXYRl2YgachBqNZcWnrbdAVmUxBePpzR3VIyD2bJuX
	yf8+sfwNRtU8fzUE3gKUKyKOfghLcGOco6qIuWeAITfa3X34Izvgtsf4VPa2j21FHWCNFn19/RaL+
	6wyHNXaCItGUpsvbmwr4ggpT8hO1OVmAx0diWDpLMBEMc1R32wgNYivxsgpiWaywfWsZpJHTOAPP6
	hVfI9q3A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX6Xp-00000009Qc5-0AaY;
	Thu, 25 Jul 2024 22:02:41 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netfs@lists.linux.dev
Subject: [PATCH 2/2] netfs: Remove unnecessary references to pages
Date: Thu, 25 Jul 2024 23:02:37 +0100
Message-ID: <20240725220239.2247246-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725220239.2247246-1-willy@infradead.org>
References: <20240725220239.2247246-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These places should all use folios instead of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/netfs/buffered_read.c  | 10 +++++-----
 fs/netfs/buffered_write.c | 18 +++++++++---------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a6d5d07cd436..6f3e1f685e1f 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -38,7 +38,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 	/* Walk through the pagecache and the I/O request lists simultaneously.
 	 * We may have a mixture of cached and uncached sections and we only
 	 * really want to write out the uncached sections.  This is slightly
-	 * complicated by the possibility that we might have huge pages with a
+	 * complicated by the possibility that we might have large folios with a
 	 * mixture inside.
 	 */
 	subreq = list_first_entry(&rreq->subrequests,
@@ -371,7 +371,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 	if (unlikely(always_fill)) {
 		if (pos - offset + len <= i_size)
 			return false; /* Page entirely before EOF */
-		zero_user_segment(&folio->page, 0, plen);
+		folio_zero_segment(folio, 0, plen);
 		folio_mark_uptodate(folio);
 		return true;
 	}
@@ -390,7 +390,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 
 	return false;
 zero_out:
-	zero_user_segments(&folio->page, 0, offset, offset + len, plen);
+	folio_zero_segments(folio, 0, offset, offset + len, plen);
 	return true;
 }
 
@@ -459,7 +459,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (folio_test_uptodate(folio))
 		goto have_folio;
 
-	/* If the page is beyond the EOF, we want to clear it - unless it's
+	/* If the folio is beyond the EOF, we want to clear it - unless it's
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
@@ -524,7 +524,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 EXPORT_SYMBOL(netfs_write_begin);
 
 /*
- * Preload the data into a page we're proposing to write into.
+ * Preload the data into a folio we're proposing to write into.
  */
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len)
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 42d49abd4579..e770bc0e4e4a 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -21,7 +21,7 @@ enum netfs_how_to_modify {
 	NETFS_JUST_PREFETCH,		/* We have to read the folio anyway */
 	NETFS_WHOLE_FOLIO_MODIFY,	/* We're going to overwrite the whole folio */
 	NETFS_MODIFY_AND_CLEAR,		/* We can assume there is no data to be downloaded. */
-	NETFS_STREAMING_WRITE,		/* Store incomplete data in non-uptodate page. */
+	NETFS_STREAMING_WRITE,		/* Store incomplete data in non-uptodate folio. */
 	NETFS_STREAMING_WRITE_CONT,	/* Continue streaming write. */
 	NETFS_FLUSH_CONTENT,		/* Flush incompatible content. */
 };
@@ -152,13 +152,13 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
  * netfs_perform_write - Copy data into the pagecache.
  * @iocb: The operation parameters
  * @iter: The source buffer
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
- * Copy data into pagecache pages attached to the inode specified by @iocb.
+ * Copy data into pagecache folios attached to the inode specified by @iocb.
  * The caller must hold appropriate inode locks.
  *
- * Dirty pages are tagged with a netfs_folio struct if they're not up to date
- * to indicate the range modified.  Dirty pages may also be tagged with a
+ * Dirty folios are tagged with a netfs_folio struct if they're not up to date
+ * to indicate the range modified.  Dirty folios may also be tagged with a
  * netfs-specific grouping such that data from an old group gets flushed before
  * a new one is started.
  */
@@ -286,7 +286,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		case NETFS_STREAMING_WRITE_CONT:
 			break;
 		case NETFS_MODIFY_AND_CLEAR:
-			zero_user_segment(&folio->page, 0, offset);
+			folio_zero_segment(folio, 0, offset);
 			break;
 		case NETFS_STREAMING_WRITE:
 			ret = -EIO;
@@ -325,7 +325,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			netfs_set_group(folio, netfs_group);
 			break;
 		case NETFS_MODIFY_AND_CLEAR:
-			zero_user_segment(&folio->page, offset + copied, flen);
+			folio_zero_segment(folio, offset + copied, flen);
 			netfs_set_group(folio, netfs_group);
 			folio_mark_uptodate(folio);
 			break;
@@ -432,7 +432,7 @@ EXPORT_SYMBOL(netfs_perform_write);
  * netfs_buffered_write_iter_locked - write data to a file
  * @iocb:	IO state structure (file, offset, etc.)
  * @from:	iov_iter with data to write
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates
@@ -516,7 +516,7 @@ EXPORT_SYMBOL(netfs_file_write_iter);
 
 /*
  * Notification that a previously read-only page is about to become writable.
- * Note that the caller indicates a single page of a multipage folio.
+ * Note that the caller indicates a single page of a folio.
  */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
 {
-- 
2.43.0


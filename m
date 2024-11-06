Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722A1EE016
	for <netfs@lists.linux.dev>; Wed,  6 Nov 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896612; cv=none; b=Np7PeMHBN0VKaOqtLIhBjhfj+0M0m6QbRXb2HyrLSsNwfLNy5cMa7oenJU0lMKC5qNjP9wZYxz6qEPNvPy/gd4FZomaxMOqUzxz9tWjMXZbXlEI5LD0oGUrtBaafc1d6oRQQOslbHgMxGqPVzJxc3EcUB4XEGeeRIuGVqJql5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896612; c=relaxed/simple;
	bh=2vC/IfGilItl9YoYzSLfac5oxJJtNnQtCMzGrNI6xUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSY48/XOTkAJMSetPhC4pvGUOV74WQCwPu+zGemT0rEIiF74zJguAAqza9ZnU4RBVvi3DI/D7fz8DZT7QI3CRvoTn9k0uqU0OcIJxgr4cZ4FJ3KB6/ULNFc9kitztZuDBCzj7JjQCYiqx2DHN2RANeNDk4Ox6IhD+48BnGFFGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsgVFWmb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsgVFWmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WJ3IwRH8RLBNIi0Kxo/o1E5+hUSf0Z9V2WPyhSRrlg=;
	b=FsgVFWmbtdmzetdTwr3AUTLgdeuIaCk2zV6LWiCbK9WB42JQZAc85Q83ljllYs+HKMCGP2
	LUHkCJpGRXAGb6fMPnfE8LsbIX39i0tegf4BK0OhmCoNvINnEfgWz+VcHRjpZvQltbuRV7
	pZyBHf1JJ8z+HPpUoeBuiVNyZE6O8H8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-2SBMoXwxP4ix2-2-WMeamg-1; Wed,
 06 Nov 2024 07:36:48 -0500
X-MC-Unique: 2SBMoXwxP4ix2-2-WMeamg-1
X-Mimecast-MFC-AGG-ID: 2SBMoXwxP4ix2-2-WMeamg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9970A1955F42;
	Wed,  6 Nov 2024 12:36:44 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A94419560AD;
	Wed,  6 Nov 2024 12:36:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 04/33] netfs: Remove unnecessary references to pages
Date: Wed,  6 Nov 2024 12:35:28 +0000
Message-ID: <20241106123559.724888-5-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These places should all use folios instead of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-4-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/netfs/buffered_read.c  |  8 ++++----
 fs/netfs/buffered_write.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index af46a598f4d7..7ac34550c403 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -627,7 +627,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 	if (unlikely(always_fill)) {
 		if (pos - offset + len <= i_size)
 			return false; /* Page entirely before EOF */
-		zero_user_segment(&folio->page, 0, plen);
+		folio_zero_segment(folio, 0, plen);
 		folio_mark_uptodate(folio);
 		return true;
 	}
@@ -646,7 +646,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 
 	return false;
 zero_out:
-	zero_user_segments(&folio->page, 0, offset, offset + len, plen);
+	folio_zero_segments(folio, 0, offset, offset + len, plen);
 	return true;
 }
 
@@ -713,7 +713,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (folio_test_uptodate(folio))
 		goto have_folio;
 
-	/* If the page is beyond the EOF, we want to clear it - unless it's
+	/* If the folio is beyond the EOF, we want to clear it - unless it's
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
@@ -773,7 +773,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 EXPORT_SYMBOL(netfs_write_begin);
 
 /*
- * Preload the data into a page we're proposing to write into.
+ * Preload the data into a folio we're proposing to write into.
  */
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len)
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ff2814da88b1..b4826360a411 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -83,13 +83,13 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
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
@@ -223,11 +223,11 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * we try to read it.
 		 */
 		if (fpos >= ctx->zero_point) {
-			zero_user_segment(&folio->page, 0, offset);
+			folio_zero_segment(folio, 0, offset);
 			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
 			if (unlikely(copied == 0))
 				goto copy_failed;
-			zero_user_segment(&folio->page, offset + copied, flen);
+			folio_zero_segment(folio, offset + copied, flen);
 			__netfs_set_group(folio, netfs_group);
 			folio_mark_uptodate(folio);
 			trace_netfs_folio(folio, netfs_modify_and_clear);
@@ -407,7 +407,7 @@ EXPORT_SYMBOL(netfs_perform_write);
  * netfs_buffered_write_iter_locked - write data to a file
  * @iocb:	IO state structure (file, offset, etc.)
  * @from:	iov_iter with data to write
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates


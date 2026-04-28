Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFF481237
	for <netfs@lists.linux.dev>; Tue, 28 Apr 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382399; cv=none; b=pXNjd8vosftgNfZLoizX3+YkR3Fb8Z4E5fF6MOiIjaVdIswfXFC7zpyToR/IT56yQaCs7P6ZfHAcluDWsztYz2p3lrhB0jzlc/djLxSLl/stKoI39M0ZSqgbSYOeN2IAxZW7fYyGDrhLs9SKHsknqh7f89jm01J/DbL8UiZmOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382399; c=relaxed/simple;
	bh=hhlZHzVkZGgNw65TAqSXoZn8aY9+h0Opjd6qveHBrl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rhN3G1LZNE0RH1gNXqaGf4Sg716vBtpzpSJRMefv94jOFOFtniVdwx4a66i67hq99qGb1PujFe/r9eRc+boWngurB8vx4gGxWma8/ZdLjvlt15lr+rIFf48Npi91foHDwHhrUnF7Chz1+9xlF3TSSz+VnbmAJB3023pBAEznw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPuQu+Dl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPuQu+Dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mt629XDWKB+tZOOSAJE2LdFWKC9Q9poIqsffgDORXAw=;
	b=RPuQu+DlmEGOcpiI6k0mmVL4tzOWH7Pi3AxBjMaEJyy2lnCWUaT0To1YxxFnJtmjPJ9UNi
	U0Mknm7giclIFrmNvv4n9+xxzKfq1EJ+/9p/LZB6ejsOANe6sWGA4md28Ys5n5W8+30Ezg
	XAJuCDvMKNqSQf0vPIWXyrRmXXPTlHc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-3o6WZebRMVq1RarP7C2BZg-1; Tue,
 28 Apr 2026 09:19:54 -0400
X-MC-Unique: 3o6WZebRMVq1RarP7C2BZg-1
X-Mimecast-MFC-AGG-ID: 3o6WZebRMVq1RarP7C2BZg_1777382393
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03053195605B;
	Tue, 28 Apr 2026 13:19:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1473F180047F;
	Tue, 28 Apr 2026 13:19:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH v5 23/24] netfs, afs: Fix write skipping in dir/link writepages
Date: Tue, 28 Apr 2026 14:17:53 +0100
Message-ID: <20260428131756.922303-24-dhowells@redhat.com>
In-Reply-To: <20260428131756.922303-1-dhowells@redhat.com>
References: <20260428131756.922303-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: jWozIFE_sWmkecVbYIYWZtX4e3F3w5ov0s7OEU2WW4A_1777382393
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix netfs_write_single() and afs_single_writepages() to better handle a
write that would be skipped due to lock contention and WB_SYNC_NONE by
returning 1 from netfs_write_single() if it skipped and making
afs_single_writepages() skip also.  If a skip occurs, the inode must be
re-marked as the VFS may have cleared the mark.

This is really only theoretical for directories in netfs_write_single() as
the only path to that is through afs_single_writepages() that takes the
->validate_lock around it, thereby serialising it.

Fixes: 6dd80936618c ("afs: Use netfslib for directories")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dir.c           | 11 ++++++++++-
 fs/netfs/write_issue.c |  7 ++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index aaaa55878ffd..d1542a1a50bf 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2206,7 +2206,14 @@ int afs_single_writepages(struct address_space *mapping,
 	/* Need to lock to prevent the folio queue and folios from being thrown
 	 * away.
 	 */
-	down_read(&dvnode->validate_lock);
+	if (!down_read_trylock(&dvnode->validate_lock)) {
+		if (wbc->sync_mode == WB_SYNC_NONE) {
+			/* The VFS will have undirtied the inode. */
+			netfs_single_mark_inode_dirty(&dvnode->netfs.inode);
+			return 0;
+		}
+		down_read(&dvnode->validate_lock);
+	}
 
 	if (is_dir ?
 	    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) :
@@ -2214,6 +2221,8 @@ int afs_single_writepages(struct address_space *mapping,
 		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
 				     i_size_read(&dvnode->netfs.inode));
 		ret = netfs_writeback_single(mapping, wbc, &iter);
+		if (ret == 1)
+			ret = 0; /* Skipped write due to lock conflict. */
 	}
 
 	up_read(&dvnode->validate_lock);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 0b07ebecb157..a85ec300b79a 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -823,6 +823,9 @@ static int netfs_write_folio_single(struct netfs_io_request *wreq,
  *
  * Write a monolithic, non-pagecache object back to the server and/or
  * the cache.
+ *
+ * Return: 0 if successful; 1 if skipped due to lock conflict and WB_SYNC_NONE;
+ * or a negative error code.
  */
 int netfs_writeback_single(struct address_space *mapping,
 			   struct writeback_control *wbc,
@@ -839,8 +842,10 @@ int netfs_writeback_single(struct address_space *mapping,
 
 	if (!mutex_trylock(&ictx->wb_lock)) {
 		if (wbc->sync_mode == WB_SYNC_NONE) {
+			/* The VFS will have undirtied the inode. */
+			netfs_single_mark_inode_dirty(&ictx->inode);
 			netfs_stat(&netfs_n_wb_lock_skip);
-			return 0;
+			return 1;
 		}
 		netfs_stat(&netfs_n_wb_lock_wait);
 		mutex_lock(&ictx->wb_lock);


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393626A0CA
	for <netfs@lists.linux.dev>; Mon, 19 May 2025 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662539; cv=none; b=rMXTxaguPMri/GTiSpPgJDmhoyrVHbL74y3wxip6YJPQR17bDDLwbFZnJO0wXVq+4c1yTvqSKL5oNM47pgMoY4Xa1wXVj0Av3cRtkZQEOatBID0VeLa8hOpDQG6zu2BWfWYAV1JrwGMcJMWuKAyYbATZnOWx0OLyM9FW8h8xbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662539; c=relaxed/simple;
	bh=PqzRtgC4yLZW6u6+8UasqZdvTAZCYjwKRfgNaZVf4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BULIX4MrOvX+hp6sKY5flWMdFg05l+7YKuDOTeVEOnjyJBjh1UOpRgl2Y7mu+CV6AMff1DgZot+ohhvf3hb4y0Rr+8kpSNzIN2HlBnYRKsb5MCfM6h8vy0zL8Vm2abEMgvckk7w0mN5mf+LWfoE73bjmcsiI1h0ixOO3sISE6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWkx6gjq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWkx6gjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0S73aJAtnnKxC2CSvCyevWiHECBuIdU+O/XU9zgy84=;
	b=XWkx6gjqw3Y4aKol+R9II+qEKXyQ2Q8v1lgephYFlaGviFq+LzMeBd3uSVX3bD8/9XQFqb
	8knoafkfDvfrMNrxk21GwPQ66Ueqb9MkriH37AwbA9igYSv9IsIaN10CTQjWV9rNkZYknb
	ciP3oCXBqo8KbortOrfRBjetnWaKqRY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-S5qaN7_xNKqre078m54fag-1; Mon,
 19 May 2025 09:48:50 -0400
X-MC-Unique: S5qaN7_xNKqre078m54fag-1
X-Mimecast-MFC-AGG-ID: S5qaN7_xNKqre078m54fag_1747662528
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A65D180034E;
	Mon, 19 May 2025 13:48:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F54919560AB;
	Mon, 19 May 2025 13:48:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] fs/netfs: remove unused flag NETFS_ICTX_WRITETHROUGH
Date: Mon, 19 May 2025 14:48:00 +0100
Message-ID: <20250519134813.2975312-5-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Max Kellermann <max.kellermann@ionos.com>

This flag was added by commit 41d8e7673a77 ("netfs: Implement a
write-through caching option") but it was never used.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
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
index 5a76bea51d24..242daec8c837 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -70,7 +70,6 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
-#define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
 #define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
 #define NETFS_ICTX_SINGLE_NO_UPLOAD 4		/* Monolithic payload, cache but no upload */
 };


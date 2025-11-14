Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744032936D
	for <netfs@lists.linux.dev>; Fri, 14 Nov 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131421; cv=none; b=RS4LJhK2B3u+VTWLz466FG/0wSlJXSIDKVutMkvCguy9RLFSl10h87Pj6bcnivqwJbutbc8yp4M/2t4lNkG342piTszi2NQSKyh3erp/Dh7WiiWnZ1ZEyAieP5OyD+iLNAH7qWldkuFPv27mYOFFwK9Wi6vZFTktU+gC/v2dE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131421; c=relaxed/simple;
	bh=GdxFT7AwwIMr6i3M7scT34pz0ZgVYmagShKBJcwmrYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEOhOBLCykh6x9ELaaqF9RVf+SbxeO8MwHbu/Vocl1DUQmuhQ7qOwTmWKxuaAq/+N+RLeGMFj2RTFYLdtfcqtdXYLo53XDl1PttomkI0OMr5x1Wf9IhLFxnNvWrm0u9NAzyLzmThPhE/7XZ2XoyDzlIX10prlDFBaROdOF0co1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzjzhDcU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzjzhDcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763131418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0QlHSfARw7ekY94h6YgQ6dvVPReMrBP+8Btz7QkzSI=;
	b=AzjzhDcUeNpoYqh7pnhiQS0WUtbHwgskqA6/vLQvuPQA7bQnaK0vIok/SRhwCRBQKvH7UT
	37SAqYlSbbncbPeA6UO8voijKBqrwpPmtDfNCZJ10+pE3lhKKeaJwTHz/7T2vgxJE7qQxa
	mtTgd8f+AlcJlOER3sbJh9bh4Qcj2e8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-ByfO6w-NPmmTLWidUH7RGg-1; Fri,
 14 Nov 2025 09:43:35 -0500
X-MC-Unique: ByfO6w-NPmmTLWidUH7RGg-1
X-Mimecast-MFC-AGG-ID: ByfO6w-NPmmTLWidUH7RGg_1763131413
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E812C19560B5;
	Fri, 14 Nov 2025 14:43:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.87])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F288300018D;
	Fri, 14 Nov 2025 14:43:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 8/9] cifs: Use netfs_alloc/free_folioq_buffer()
Date: Fri, 14 Nov 2025 14:42:50 +0000
Message-ID: <20251114144253.1853312-9-dhowells@redhat.com>
In-Reply-To: <20251114144253.1853312-1-dhowells@redhat.com>
References: <20251114144253.1853312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Use netfs_alloc/free_folioq_buffer() rather than doing its own version.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com> (RDMA, smbdirect)
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2ops.c | 73 ++++++-----------------------------------
 1 file changed, 10 insertions(+), 63 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index acd2d9688fb9..c30583c0bb63 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4484,61 +4484,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	return rc;
 }
 
-/*
- * Clear a read buffer, discarding the folios which have the 1st mark set.
- */
-static void cifs_clear_folioq_buffer(struct folio_queue *buffer)
-{
-	struct folio_queue *folioq;
-
-	while ((folioq = buffer)) {
-		for (int s = 0; s < folioq_count(folioq); s++)
-			if (folioq_is_marked(folioq, s))
-				folio_put(folioq_folio(folioq, s));
-		buffer = folioq->next;
-		kfree(folioq);
-	}
-}
-
-/*
- * Allocate buffer space into a folio queue.
- */
-static struct folio_queue *cifs_alloc_folioq_buffer(ssize_t size)
-{
-	struct folio_queue *buffer = NULL, *tail = NULL, *p;
-	struct folio *folio;
-	unsigned int slot;
-
-	do {
-		if (!tail || folioq_full(tail)) {
-			p = kmalloc(sizeof(*p), GFP_NOFS);
-			if (!p)
-				goto nomem;
-			folioq_init(p, 0);
-			if (tail) {
-				tail->next = p;
-				p->prev = tail;
-			} else {
-				buffer = p;
-			}
-			tail = p;
-		}
-
-		folio = folio_alloc(GFP_KERNEL|__GFP_HIGHMEM, 0);
-		if (!folio)
-			goto nomem;
-
-		slot = folioq_append_mark(tail, folio);
-		size -= folioq_folio_size(tail, slot);
-	} while (size > 0);
-
-	return buffer;
-
-nomem:
-	cifs_clear_folioq_buffer(buffer);
-	return NULL;
-}
-
 /*
  * Copy data from an iterator to the folios in a folio queue buffer.
  */
@@ -4564,7 +4509,7 @@ void
 smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
 {
 	for (int i = 0; i < num_rqst; i++)
-		cifs_clear_folioq_buffer(rqst[i].rq_buffer);
+		netfs_free_folioq_buffer(rqst[i].rq_buffer);
 }
 
 /*
@@ -4599,8 +4544,10 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 		new->rq_nvec = old->rq_nvec;
 
 		if (size > 0) {
-			buffer = cifs_alloc_folioq_buffer(size);
-			if (!buffer)
+			size_t cur_size = 0;
+			rc = netfs_alloc_folioq_buffer(NULL, &buffer, &cur_size,
+						       size, GFP_NOFS);
+			if (rc < 0)
 				goto err_free;
 
 			new->rq_buffer = buffer;
@@ -4932,7 +4879,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 free_pages:
-	cifs_clear_folioq_buffer(dw->buffer);
+	netfs_free_folioq_buffer(dw->buffer);
 	cifs_small_buf_release(dw->buf);
 	kfree(dw);
 }
@@ -4970,9 +4917,9 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
 	dw->len = len;
 	len = round_up(dw->len, PAGE_SIZE);
 
-	rc = -ENOMEM;
-	dw->buffer = cifs_alloc_folioq_buffer(len);
-	if (!dw->buffer)
+	size_t cur_size = 0;
+	rc = netfs_alloc_folioq_buffer(NULL, &dw->buffer, &cur_size, len, GFP_NOFS);
+	if (rc < 0)
 		goto discard_data;
 
 	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, len);
@@ -5033,7 +4980,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
 	}
 
 free_pages:
-	cifs_clear_folioq_buffer(dw->buffer);
+	netfs_free_folioq_buffer(dw->buffer);
 free_dw:
 	kfree(dw);
 	return rc;


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992674AAC5F
	for <netfs@lists.linux.dev>; Tue,  6 Oct 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320428; cv=none; b=cbPdXPjxjZd0HXUaY9AU9gmGRRvJ1tXjmZUxpVt0Wrv/pioS+yn++7j+YmKFplmpBjlTg80qBdIsBn13ecKSh1JgUmVtUi8ts2DpCa9xYbUVh8FVKqXWi9qVnbkcVBwjGHbhzEpBatw2t39WAakkZ0icBpF59AHaKFhg12dIFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320428; c=relaxed/simple;
	bh=cptvd5mabcxyti5oUBaHwz/S+uNtiEIBIDk9E73NSlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Xrm1fBfQ80wWaXmitQC0klWYWdxXf+2Aefrw7pto6f5Hm40II54KYxP48sAKfZnd6DsMvsH09LxLbCz4c/8ra+jS5Mrn1hzWdrgftlwXpYzwZW+0kjK83D0ec+zqeASPFUqxUe4OVDQTR7RTNQVaNfsofw+REI0cKcAzmYruWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7s2kEeq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7s2kEeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791320423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeSKuOFEYwWRCiDuJmkjSu6vaW5sFmjPYYH6PVTYfG8=;
	b=L7s2kEeqlA2a7AH7azEzojzfOk6G+vce0iQjTCZBmLG1avO34luerdVnG5QLBD01wNVHbt
	305O0gFQaOmFhQ6/kArpA0gLt+8H37o9S/yb8klJHc3V1x5BGWseL59q+/sTeFnWv2/u1J
	JLRq7L6YmwXJVOWogFzEY2fprFajZwQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-CSEyqgbsOZiAv_3cTzs8yA-1; Tue,
 06 Oct 2026 17:00:17 -0400
X-MC-Unique: CSEyqgbsOZiAv_3cTzs8yA-1
X-Mimecast-MFC-AGG-ID: CSEyqgbsOZiAv_3cTzs8yA_1791320415
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BB6E1865FDE;
	Tue,  6 Oct 2026 21:00:14 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DA971800586;
	Tue,  6 Oct 2026 21:00:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 2/8] netfs: Add a function to extract from an iter into a bvecq
Date: Tue,  6 Oct 2026 21:59:38 +0100
Message-ID: <20261006205947.608356-3-dhowells@redhat.com>
In-Reply-To: <20261006205947.608356-1-dhowells@redhat.com>
References: <20261006205947.608356-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: n0x8KYtKd_yzfUHWTUvKxz9LjybL6l2vdXsTTUkyBWA_1791320415
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a function to extract a slice of data from an iterator of any type into
a bvec queue chain.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c   | 143 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   3 +
 2 files changed, 146 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 31748526d568..55fd2d3b3b29 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -13,6 +13,149 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+/**
+ * netfs_extract_iter - Extract virtually contiguous pages from an iterator into a bvecq
+ * @orig: The original iterator
+ * @max_len: Maximum number of bytes to extract
+ * @max_pages: Maximum number of pages to extract
+ * @_bvecq_head: Where to cache the bvec queue
+ * @extraction_flags: Flags to qualify the request
+ * @gfp: Allocation mode for bvecq structs.
+ *
+ * Extract virtually contiguous page fragments from the source iterator up to
+ * the given maxima and build bvec queue that refers to all of those bits.
+ * This allows the original iterator to disposed of.
+ *
+ * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA
+ * be allowed on the pages extracted.
+ *
+ * On success or partial success, the amount of data in the bvec is returned,
+ * the original iterator will have been advanced by the amount extracted.
+ *
+ * If an error occurs and no pages are extracted, an error will be returned and
+ * any allocated bvecq will be freed.  If there is no data to be extracted (or
+ * @max_len or @max_pages are zero), a single empty bvecq will be returned.
+ *
+ * The bvecq segments are marked with indications on how to get clean up the
+ * extracted fragments.
+ */
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
+			   struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags, gfp_t gfp)
+{
+	struct bvecq *bq_tail = NULL, *bq;
+	ssize_t ret = 0;
+	size_t extracted = 0;
+
+	_enter("{%u,%zx},%zx", orig->iter_type, orig->count, max_len);
+
+	*_bvecq_head = NULL;
+	if (max_len > orig->count)
+		max_len = orig->count;
+	if (!max_len || !max_pages)
+		goto alloc_empty;
+	if (WARN_ON_ONCE(max_pages > INT_MAX))
+		max_pages = INT_MAX; /* Protect iov_iter_npages(). */
+
+	max_pages = iov_iter_npages(orig, max_pages);
+	if (!max_pages)
+		goto alloc_empty;
+
+	do {
+		bq = bvecq_alloc_one(max_pages, gfp, false);
+		if (!bq) {
+			ret = -ENOMEM;
+			break;
+		}
+		if (user_backed_iter(orig))
+			bq->mem_type = iov_iter_extract_will_pin(orig) ?
+				BVECQ_MEM_GUP : BVECQ_MEM_PAGECACHE;
+
+		if (bq_tail)
+			bvecq_append(bq_tail, bq);
+		else
+			*_bvecq_head = bq;
+		bq_tail = bq;
+
+		if (max_len == 0)
+			break;
+
+		struct bio_vec *bv = bq->bv;
+		unsigned int slot = 0;
+		do {
+			struct page **pages;
+			ssize_t got;
+			size_t offset;
+			size_t space = bq->max_slots - slot;
+			size_t bv_size = array_size(bq->max_slots, sizeof(*bv));
+			size_t pg_size = array_size(space, sizeof(*pages));
+
+			/* Put the page list at the end of the bvec list
+			 * storage.  bvec elements are larger than page
+			 * pointers, so as long as we work 0->last, we should
+			 * be fine.
+			 */
+			pages = (void *)bv + bv_size - pg_size;
+
+			got = iov_iter_extract_pages(orig, &pages, max_len,
+						     min(space, max_pages),
+						     extraction_flags, &offset);
+			if (got < 0) {
+				ret = got;
+				goto out;
+			}
+
+			if (got == 0) {
+				pr_err("extract_pages gave nothing from %zx, %zx\n",
+				       extracted, max_len);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (WARN(got > max_len,
+				 "%s: extract_pages overrun %zx > %zx bytes\n",
+				 __func__, got, max_len)) {
+				ret = -EIO;
+				goto out;
+			}
+
+			extracted += got;
+			max_len -= got;
+
+			do {
+				size_t len = umin(got, PAGE_SIZE - offset);
+
+				BUG_ON(slot >= bq->max_slots);
+
+				bvec_set_page(&bq->bv[slot], *pages++, len, offset);
+				slot++;
+				max_pages--;
+				got -= len;
+				offset = 0;
+			} while (got > 0);
+
+			bvecq_filled_to(bq, slot);
+		} while (max_len > 0 && max_pages > 0 && !bvecq_is_full(bq));
+
+	} while (max_len > 0 && max_pages > 0);
+
+out:
+	if (extracted || ret == 0)
+		return extracted;
+	bvecq_put(*_bvecq_head);
+	*_bvecq_head = NULL;
+	return ret;
+
+alloc_empty:
+	bq = bvecq_alloc_one(1, gfp, false);
+	if (!bq)
+		return -ENOMEM;
+	*_bvecq_head = bq;
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(netfs_extract_iter);
+
 /**
  * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
  * @orig: The original iterator
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b0dd92d12a97..aca192bc5675 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -454,6 +454,9 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
+			   struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags, gfp_t gfp);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C13E51D9
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522097; cv=none; b=OchVYt2KV/ZxPrH7jCZXZy9EwjobeZdl2Jsw0fAs7wppE9OSCgsZx2d18mMFnrd6dSYUbUhpO8fj1nMG6oQFxW9Q962yVvG2185WShXu+bdO/x7oKujgAEo0Ezusi7QYO3/rOFcik+5ELCZwnR6HcY9AawEH5PXN/MGSN5eqXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522097; c=relaxed/simple;
	bh=MTxqkqINhnmFwsYY0I5RGkHMRfSTiKvm3IE0AehnxE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aCoeWkLiZRCc0MyZobutl6RNDbaULpSjn0aXwzpBIeXpYeX88a1M5lCOuvsrg3Fd2GChAPbTraM+iuCxMN8g8rJ8KKSo1amNI/uyMPjvgcdgAXaW5ZjwFA0b4Oidocp+HB3GjMUCiHzVI7tnhko8AZP8btfSnyAz2V6BI0muENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex0928cP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex0928cP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q3CSNpbXi5lOGrcvXbX8mvLw/thJvXIjpsnNa/bq6w=;
	b=ex0928cPC6VH7oOzJE0iH+6xHectkRofs0uO5XbrScCMxUTYbfEjzAZftvw9ZaD/YSYLFQ
	7DFTzwXpD0ytD/QtAPVxAsHyt7Vstv/1UsersKbas0lFCIWO0aeneA9WR6wsqiQ3wgKAjf
	+mAT9GZUg2dywUtgfr21D2K8fTzC2oI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-H2PjY8ChMyuS7rT40AhezQ-1; Thu,
 26 Mar 2026 06:48:11 -0400
X-MC-Unique: H2PjY8ChMyuS7rT40AhezQ-1
X-Mimecast-MFC-AGG-ID: H2PjY8ChMyuS7rT40AhezQ_1774522089
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D89180034E;
	Thu, 26 Mar 2026 10:48:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 783F11955F25;
	Thu, 26 Mar 2026 10:48:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 14/26] netfs: Add a function to extract from an iter into a bvecq
Date: Thu, 26 Mar 2026 10:45:29 +0000
Message-ID: <20260326104544.509518-15-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: pZbhyvn1ZGU6TBvf8HkMXqlcAeq4FUux-tYIISSct7w_1774522089
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a function to extract a slice of data from an iterator of any type into
a bvec queue chain.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c   | 123 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   3 ++
 2 files changed, 126 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index adca78747f23..e77fd39327c2 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -13,6 +13,129 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+/**
+ * netfs_extract_iter - Extract the pages from an iterator into a bvecq
+ * @orig: The original iterator
+ * @orig_len: The amount of iterator to copy
+ * @max_segs: Maximum number of contiguous segments
+ * @fpos: Starting file position to label the bvecq with
+ * @_bvecq_head: Where to cache the bvec queue
+ * @extraction_flags: Flags to qualify the request
+ *
+ * Extract the page fragments from the given amount of the source iterator and
+ * build bvec queue that refers to all of those bits.  This allows the original
+ * iterator to disposed of.
+ *
+ * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
+ * allowed on the pages extracted.
+ *
+ * On success, the amount of data in the bvec is returned, the original
+ * iterator will have been advanced by the amount extracted.
+ *
+ * The bvecq segments are marked with indications on how to get clean up the
+ * extracted fragments.
+ */
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags)
+{
+	struct bvecq *bq_tail = NULL;
+	ssize_t ret = 0;
+	size_t extracted = 0, nr_pages;
+
+	_enter("{%u,%zx},%zx", orig->iter_type, orig->count, orig_len);
+
+	WARN_ON_ONCE(orig_len > orig->count);
+
+	nr_pages = iov_iter_npages(orig, max_segs ?: INT_MAX);
+	if (WARN_ON(nr_pages == 0) ||
+	    WARN_ON(nr_pages > max_segs))
+		nr_pages = max_segs;
+	max_segs = nr_pages;
+
+	do {
+		struct bvecq *bq;
+
+		if (WARN_ON(max_segs == 0))
+			break;
+
+		bq = bvecq_alloc_one(max_segs, GFP_NOFS);
+		if (!bq) {
+			ret = -ENOMEM;
+			break;
+		}
+		bq->free	= user_backed_iter(orig);
+		bq->unpin	= iov_iter_extract_will_pin(orig);
+		bq->prev	= bq_tail;
+		bq->fpos	= fpos + extracted;
+
+		if (bq_tail)
+			bq_tail->next = bq;
+		else
+			*_bvecq_head = bq;
+		bq_tail = bq;
+
+		if (orig_len == 0)
+			break;
+
+		struct bio_vec *bv = bq->bv;
+		do {
+			struct page **pages;
+			ssize_t got;
+			size_t offset;
+			size_t space = bq->max_slots - bq->nr_slots;
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
+			got = iov_iter_extract_pages(orig, &pages, orig_len,
+						     space, extraction_flags, &offset);
+			if (got < 0) {
+				ret = got;
+				goto out;
+			}
+
+			if (got == 0) {
+				pr_err("extract_pages gave nothing from %zu, %zu\n",
+				       extracted, orig_len);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (got > orig_len - extracted) {
+				pr_err("extract_pages rc=%zd more than %zu\n",
+				       got, orig_len);
+				goto out;
+			}
+
+			extracted += got;
+			orig_len -= got;
+
+			do {
+				size_t len = umin(got, PAGE_SIZE - offset);
+
+				BUG_ON(bq->nr_slots >= bq->max_slots);
+
+				bvec_set_page(&bq->bv[bq->nr_slots],
+					      *pages++, len, offset);
+				bq->nr_slots++;
+				got -= len;
+				offset = 0;
+			} while (got > 0);
+		} while (orig_len > 0 && !bvecq_is_full(bq));
+	} while (orig_len > 0 && max_segs > 0);
+
+out:
+	return extracted ?: ret;
+}
+EXPORT_SYMBOL_GPL(netfs_extract_iter);
+
 /**
  * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
  * @orig: The original iterator
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5bc48aacf7f6..b4602f7b6431 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -445,6 +445,9 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);


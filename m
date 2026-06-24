Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3502DBF75
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302296; cv=none; b=cupxQd9nlj8gY9hMTOJDL68zwCaZCH1fQhab/BT/7s7lxLAZSiG7CN4yRle4G6lKXwc7MR8PtJkD04AiizkE0Yz/qhEOlmjLAHN396jZiT6JOdto+ydO8BU0LW2/3Jt2n6k9I4qz70G/a3jyNHtbqN6p1UWGYY1cO4VDH4PFE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302296; c=relaxed/simple;
	bh=TkR3U9MBG4uQjx6fjGoDl2fjGjJJGgR5Cumzr1yedxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DSwtUOr0plyqHioqglwMEXguPEuU/+va9PJvuXrrewvVjEayBYMe0dpte39bfYu9X9BNq01nh1hb9iBE4t2SZoFWaAVMk8NP+icCnaNj2kCV5pOf2/zi7Mo5ZlCcu4AEDOJbtTZz/FxBBpz8bmiXI7rsnaTgqeGSuQuZdGq3RYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GX08jZhg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GX08jZhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782302294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr1GtzsrCWNPBr/vFOn5YZqpXbdYY2IBSvhsLoG3IHw=;
	b=GX08jZhgX30zQmo0YGUhs4FUpLLyOaOozFr3qpIs6hM3JCzuFcC6wo0ObNLYdDKx+JyfuM
	4lbzxq28RB/AY6c0YS1ltCqIExAO5P1DJvygXgR+8Ybq6qIeXN4LjZjVuLLkgPCmE4wE27
	eysYvw5LDShpEZgY57biZT1r6T7Ohgo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-iyJLl-RBOd2ZUZGmpnSjQw-1; Wed,
 24 Jun 2026 07:58:10 -0400
X-MC-Unique: iyJLl-RBOd2ZUZGmpnSjQw-1
X-Mimecast-MFC-AGG-ID: iyJLl-RBOd2ZUZGmpnSjQw_1782302288
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B5221955EBA;
	Wed, 24 Jun 2026 11:58:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F3361956049;
	Wed, 24 Jun 2026 11:58:02 +0000 (UTC)
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
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 04/14] iov_iter: Fix potential underflow in iov_iter_extract_xarray_pages()
Date: Wed, 24 Jun 2026 12:57:25 +0100
Message-ID: <20260624115737.2964520-5-dhowells@redhat.com>
In-Reply-To: <20260624115737.2964520-1-dhowells@redhat.com>
References: <20260624115737.2964520-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: -MMPAs9izPKOJLfQvDWeXkEo1ld7gvCs-XT6JTUdHQs_1782302288
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In iov_iter_extract_xarray_pages(), if no pages are extracted because
there's a hole (or something otherwise unextractable) in the xarray, then
the calculation of maxsize at the end can go wrong if the starting offset
is not zero.

Fix this by returning 0 in such a case and freeing the page array if
allocated here rather than being passed in.

Note that in the near future, ITER_XARRAY should be removed.

Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list from an iterator")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
Link: https://sashiko.dev/#/patchset/20260616100821.2062304-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Mike Marshall <hubcap@omnibond.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/iov_iter.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..5f60733f3280 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1568,6 +1568,7 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 	struct folio *folio;
 	unsigned int nr = 0, offset;
 	loff_t pos = i->xarray_start + i->iov_offset;
+	bool will_alloc = !*pages;
 	XA_STATE(xas, i->xarray, pos >> PAGE_SHIFT);
 
 	offset = pos & ~PAGE_MASK;
@@ -1595,6 +1596,14 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 	}
 	rcu_read_unlock();
 
+	if (!nr) {
+		if (will_alloc) {
+			kvfree(*pages);
+			*pages = NULL;
+		}
+		return 0;
+	}
+
 	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 	iov_iter_advance(i, maxsize);
 	return maxsize;


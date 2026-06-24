Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250A3890E8
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302317; cv=none; b=bZcWFIa6rsA68NTPhXRlxk38KKR3mePtQT6/vZFo2l0//QWOXhXD4Zp8t/ClHGF/jQRXxdshpCJFAsFPOsP2wKWYg43Z+k8LGD1YgHydUo2hjMDA5mxr6AEPQxiQA09RhvChIiZYAZBflMZpCi9b22zkCVzPUXlP97ahVRHaXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302317; c=relaxed/simple;
	bh=LlyerzgyX+5L/7rCJl1ktSyZ72E37ZcqdGfNCyxOLPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NB7hnvWqcCty9u6wCRTDIMef9LAgrjfdVBTbxPeGfW33Sz+0o9vb9W5weXRqEIqxa7vW5Vy8nsLlD9h8A4xsGu1mic7VTK0270R7v4EXq0XBgh9VOzWbLXdQmWzfF4GaLwpZYFHUyTbo1R7uNrLuNMLZwa09+JDHZJPoBD5OOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEXBJfSv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEXBJfSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782302310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBSa5TnPIcX9KUvKuQ/n5zPtisGuhCJFsXdMJvHXniA=;
	b=HEXBJfSvVR5U8S0Trn4hcRVhbXL8414L5J69zrXFvFk54hFifYEM0LF6w3DhL7gwWE7zy7
	uaewmzbSUCI5MxoOnzxHeI/WDdTIgPr9/lWYDKvOVHk5o/e2A5GfycvP9uSlTuv5azCJPS
	7ebr+bifV2HyvbA8biCdCGqXuHqsBws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-poPVJ-HgPZOaPfYlliQBjg-1; Wed,
 24 Jun 2026 07:58:26 -0400
X-MC-Unique: poPVJ-HgPZOaPfYlliQBjg-1
X-Mimecast-MFC-AGG-ID: poPVJ-HgPZOaPfYlliQBjg_1782302304
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D04F018009D8;
	Wed, 24 Jun 2026 11:58:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9DB51800361;
	Wed, 24 Jun 2026 11:58:20 +0000 (UTC)
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
	Ming Lei <ming.lei@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 07/14] iov_iter: Remove unused variable in kunit_iov_iter.c
Date: Wed, 24 Jun 2026 12:57:28 +0100
Message-ID: <20260624115737.2964520-8-dhowells@redhat.com>
In-Reply-To: <20260624115737.2964520-1-dhowells@redhat.com>
References: <20260624115737.2964520-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: EkINkmr1BM56AHyuttgc5V0eZpZmIZGfY_5DQ2_1RHg_1782302304
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Remove the no longer used variable 'b' from iov_kunit_copy_to_bvec().  The
variable is initialised and incremented, but nothing now makes use of the
value.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ming Lei <ming.lei@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/tests/kunit_iov_iter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index f02f7b7aa796..e7e154f94f66 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -275,7 +275,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, b, patt;
+	int i, patt;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -298,10 +298,9 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
 	/* Build the expected image in the scratch buffer. */
-	b = 0;
 	patt = 0;
 	memset(scratch, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->from >= 0; pr++, b++) {
+	for (pr = bvec_test_ranges; pr->from >= 0; pr++) {
 		u8 *p = scratch + pr->page * PAGE_SIZE;
 
 		for (i = pr->from; i < pr->to; i++)


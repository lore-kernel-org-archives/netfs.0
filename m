Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BD38A739
	for <netfs@lists.linux.dev>; Fri, 19 Jun 2026 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878058; cv=none; b=iqgt+DJzmFe/ca2Trgn0zDz41/HqIgujTOnnDExpJoLVKkvojH/XK19DtOJ1+VeRah/thZaX/DaKTabk6/Vd6f/RNB0uCGoE7Lk+plnTycAfLyq3kLJ8XpebqizOfh1YiwaO+mnXXtuxWK+JlHAvHNG2hKQ9jw1tOxWjMQRr7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878058; c=relaxed/simple;
	bh=LlyerzgyX+5L/7rCJl1ktSyZ72E37ZcqdGfNCyxOLPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NZPxVVNAAldDTBdO9+ShCSUQVlpYG3S1ALqRZ1odAp8lOAyBltjEmg387r3JLddRDUmbVu8AjKEb1f3KE2e5O+mQyq+YKArqq2FGUTYsAXPUitCx0PfFDzb3dTUh7MvE9eEMuLvDIzsjzCm1C6VsWadzaMvkCo7wXlnp+L6hgWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ap1V2RXJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ap1V2RXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781878056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBSa5TnPIcX9KUvKuQ/n5zPtisGuhCJFsXdMJvHXniA=;
	b=Ap1V2RXJLBV7Vggd/a0iDc4iG27L9TNx7QC0Ks+Vw0TeXMKGyL5AkT2UFFi14mQICVVfYd
	l9qWrQB1QF+SPEmMDQ6hFzWICXV+Phxnqq0zvw/Vv2MFQNJV8prvorpcN3FUwK3c1Nt3fM
	gQyUfF44XwMBaPPIXpsktSAzOLfzVhQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-zP7cPN2UP6qDIGdXyoo3Nw-1; Fri,
 19 Jun 2026 10:07:32 -0400
X-MC-Unique: zP7cPN2UP6qDIGdXyoo3Nw-1
X-Mimecast-MFC-AGG-ID: zP7cPN2UP6qDIGdXyoo3Nw_1781878051
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BB351955DA6;
	Fri, 19 Jun 2026 14:07:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE10736916;
	Fri, 19 Jun 2026 14:07:26 +0000 (UTC)
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
Subject: [PATCH 07/11] iov_iter: Remove unused variable in kunit_iov_iter.c
Date: Fri, 19 Jun 2026 15:06:11 +0100
Message-ID: <20260619140646.2633762-8-dhowells@redhat.com>
In-Reply-To: <20260619140646.2633762-1-dhowells@redhat.com>
References: <20260619140646.2633762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: GuLFd0A8MRMegnya2fel3884NwZhOr4QB6wFimp_0R4_1781878051
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


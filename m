Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936036;
	b=WDY2zp4/HM8fb8KMDcQEfT8u8u+HOerVrEwe3VlfDEdSh4wONkMSAUPfWPDhhndP0e4f
	 FR1V9k0yZuh7H2j0ANX3fWdkC4LqNGK1T6kZVqVU3IvrCAV/yWsu6qeSLh5GmyhgBhmb5
	 wg/gfoO8cTefYrhRuxV0Ls5dt+qZRSjxpCFUbc7Yx5bgvU9CRKQ8YumvPMterFxYt1HvL
	 dQCKl2AL0TOGnGAYanE/b3o+ABM/roR0um+rf/SShclFN6nKvUYpky/hIoNxmsfq4bA4b
	 RI/4+r7GjPzBqTcvrALS4Jsh/dNEEtdDx+Fr5rWaQ19a07A1RXwcWfgr+T7/G9FohCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936036;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=y3TtDW1WKRbGF0ZusHGDdMsHnXiCQqqrodTZSz3UVtw=;
	b=z/Z4QCghJ+r+Hoe5b6q2TDWoWeLeyQRM9V0CMUv2hE6Q8gK6z/r1/s83EWBdtUUGS141
	 G7mqIBZYlZwy41IV9AO3MtQPsGWUH2bcOSJvyFNwUhTdCFIvKICzuo+IOix1iOply3buw
	 qiy0BdI2HiqCV2uRZmYRci6vXEqWamXyKu9Dwv8vvgV5jHZmBJBLVSt7hGEu47MsT/WFm
	 IXPO1MBSzhxNvM66xDBrQhzVNJP26Bgkoy2UPH3cyiF/3Yt5Tvl0osnQLuqEu4mjiJoLE
	 rdZBnJu7rkDiXjYUH+4/CfwAjOCSw1n42Bhbp+iGqzM5inATeQaAdtyWmnB8QOqvZ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AtDBCCVD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D09606A334
	for <netfs@lists.linux.dev>; Tue, 17 Nov 2026 17:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95D09606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AtDBCCVD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794936034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3TtDW1WKRbGF0ZusHGDdMsHnXiCQqqrodTZSz3UVtw=;
	b=AtDBCCVDFqCJHs8SD2Gt+ZG0tYIBnADz7xN8yPxJMGu5Bcu3A8gIvbs9K0dzR4cxk+VUEO
	OlfMCPdE85jwMx9ntRNiXyDls/nlGxcpnl+FHXSOpaHB+QVNisgnenGCPvS1HcLi4PwR2B
	MaHl4X9ElP15PfbctYhOdpl4URF8ZKc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-bMXgNB1jNMSuluI7lgEj5g-1; Tue,
 17 Nov 2026 12:20:30 -0500
X-MC-Unique: bMXgNB1jNMSuluI7lgEj5g-1
X-Mimecast-MFC-AGG-ID: bMXgNB1jNMSuluI7lgEj5g_1794936028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C6F818002AD;
	Tue, 17 Nov 2026 17:20:26 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A551B1956059;
	Tue, 17 Nov 2026 17:20:20 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH v18 01/17] iov_iter: Fix kunit test to remove __init and __refdata marks
Date: Tue, 17 Nov 2026 17:18:59 +0000
Message-ID: <20261117171958.2982801-2-dhowells@redhat.com>
In-Reply-To: <20261117171958.2982801-1-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: C5soRrZabuV1EkE1IKZmWplpYYEuQvbyjKysaf5k4_Y_1794936028
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Remove the __init marks from the functions in the iov_iter kunit test so
that they don't get removed after the module is loaded or if the test is
built in as the tests can be triggered through debugfs too.

Also remove the __refdata mark which is unnecessary if the table so marked
doesn't point at any __init funcs.

This was found by claude-opus-5-5 run locally.

Fixes: 2d71340ff1d4 ("iov_iter: Kunit tests for copying to/from an iterator")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/tests/kunit_iov_iter.c | 96 +++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index 32e42d8c7ca1..b4ad38d1a4bd 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -48,9 +48,9 @@ static void iov_kunit_unmap(void *data)
 	vfree(data);
 }
 
-static void *__init iov_kunit_create_buffer(struct kunit *test,
-					    struct page ***ppages,
-					    size_t npages)
+static void *iov_kunit_create_buffer(struct kunit *test,
+				     struct page ***ppages,
+				     size_t npages)
 {
 	struct page **pages;
 	unsigned long got, last;
@@ -90,11 +90,11 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	return buffer;
 }
 
-static void __init iov_kunit_load_kvec(struct kunit *test,
-				       struct iov_iter *iter, int dir,
-				       struct kvec *kvec, unsigned int kvmax,
-				       void *buffer, size_t bufsize,
-				       const struct kvec_test_range *pr)
+static void iov_kunit_load_kvec(struct kunit *test,
+				struct iov_iter *iter, int dir,
+				struct kvec *kvec, unsigned int kvmax,
+				void *buffer, size_t bufsize,
+				const struct kvec_test_range *pr)
 {
 	size_t size = 0;
 	int i;
@@ -116,7 +116,7 @@ static void __init iov_kunit_load_kvec(struct kunit *test,
 /*
  * Test copying to a ITER_KVEC-type iterator.
  */
-static void __init iov_kunit_copy_to_kvec(struct kunit *test)
+static void iov_kunit_copy_to_kvec(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -166,7 +166,7 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 /*
  * Test copying from a ITER_KVEC-type iterator.
  */
-static void __init iov_kunit_copy_from_kvec(struct kunit *test)
+static void iov_kunit_copy_from_kvec(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -234,12 +234,12 @@ static const struct bvec_test_range bvec_test_ranges[] = {
 	{ -1, -1, -1 }
 };
 
-static void __init iov_kunit_load_bvec(struct kunit *test,
-				       struct iov_iter *iter, int dir,
-				       struct bio_vec *bvec, unsigned int bvmax,
-				       struct page **pages, size_t npages,
-				       size_t bufsize,
-				       const struct bvec_test_range *pr)
+static void iov_kunit_load_bvec(struct kunit *test,
+				struct iov_iter *iter, int dir,
+				struct bio_vec *bvec, unsigned int bvmax,
+				struct page **pages, size_t npages,
+				size_t bufsize,
+				const struct bvec_test_range *pr)
 {
 	struct page *can_merge = NULL, *page;
 	size_t size = 0;
@@ -275,7 +275,7 @@ static void __init iov_kunit_load_bvec(struct kunit *test,
 /*
  * Test copying to a ITER_BVEC-type iterator.
  */
-static void __init iov_kunit_copy_to_bvec(struct kunit *test)
+static void iov_kunit_copy_to_bvec(struct kunit *test)
 {
 	const struct bvec_test_range *pr;
 	struct iov_iter iter;
@@ -328,7 +328,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 /*
  * Test copying from a ITER_BVEC-type iterator.
  */
-static void __init iov_kunit_copy_from_bvec(struct kunit *test)
+static void iov_kunit_copy_from_bvec(struct kunit *test)
 {
 	const struct bvec_test_range *pr;
 	struct iov_iter iter;
@@ -392,10 +392,10 @@ static void iov_kunit_destroy_folioq(void *data)
 	}
 }
 
-static void __init iov_kunit_load_folioq(struct kunit *test,
-					struct iov_iter *iter, int dir,
-					struct folio_queue *folioq,
-					struct page **pages, size_t npages)
+static void iov_kunit_load_folioq(struct kunit *test,
+				  struct iov_iter *iter, int dir,
+				  struct folio_queue *folioq,
+				  struct page **pages, size_t npages)
 {
 	struct folio_queue *p = folioq;
 	size_t size = 0;
@@ -429,7 +429,7 @@ static struct folio_queue *iov_kunit_create_folioq(struct kunit *test)
 /*
  * Test copying to a ITER_FOLIOQ-type iterator.
  */
-static void __init iov_kunit_copy_to_folioq(struct kunit *test)
+static void iov_kunit_copy_to_folioq(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -491,7 +491,7 @@ static void __init iov_kunit_copy_to_folioq(struct kunit *test)
 /*
  * Test copying from a ITER_FOLIOQ-type iterator.
  */
-static void __init iov_kunit_copy_from_folioq(struct kunit *test)
+static void iov_kunit_copy_from_folioq(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -560,10 +560,10 @@ static void iov_kunit_destroy_xarray(void *data)
 	kfree(xarray);
 }
 
-static void __init iov_kunit_load_xarray(struct kunit *test,
-					 struct iov_iter *iter, int dir,
-					 struct xarray *xarray,
-					 struct page **pages, size_t npages)
+static void iov_kunit_load_xarray(struct kunit *test,
+				  struct iov_iter *iter, int dir,
+				  struct xarray *xarray,
+				  struct page **pages, size_t npages)
 {
 	size_t size = 0;
 	int i;
@@ -591,7 +591,7 @@ static struct xarray *iov_kunit_create_xarray(struct kunit *test)
 /*
  * Test copying to a ITER_XARRAY-type iterator.
  */
-static void __init iov_kunit_copy_to_xarray(struct kunit *test)
+static void iov_kunit_copy_to_xarray(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -649,7 +649,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 /*
  * Test copying from a ITER_XARRAY-type iterator.
  */
-static void __init iov_kunit_copy_from_xarray(struct kunit *test)
+static void iov_kunit_copy_from_xarray(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -712,7 +712,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 /*
  * Test the extraction of ITER_KVEC-type iterators.
  */
-static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
+static void iov_kunit_extract_pages_kvec(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -792,7 +792,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 /*
  * Test the extraction of ITER_BVEC-type iterators.
  */
-static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
+static void iov_kunit_extract_pages_bvec(struct kunit *test)
 {
 	const struct bvec_test_range *pr;
 	struct iov_iter iter;
@@ -870,7 +870,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 /*
  * Test the extraction of ITER_FOLIOQ-type iterators.
  */
-static void __init iov_kunit_extract_pages_folioq(struct kunit *test)
+static void iov_kunit_extract_pages_folioq(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct folio_queue *folioq;
@@ -949,7 +949,7 @@ static void __init iov_kunit_extract_pages_folioq(struct kunit *test)
 /*
  * Test the extraction of ITER_XARRAY-type iterators.
  */
-static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
+static void iov_kunit_extract_pages_xarray(struct kunit *test)
 {
 	const struct kvec_test_range *pr;
 	struct iov_iter iter;
@@ -1033,8 +1033,7 @@ struct iov_kunit_iter_to_sg_data {
 	size_t npages;
 };
 
-static void __init
-iov_kunit_iter_unpin_sgt(void *data)
+static void iov_kunit_iter_unpin_sgt(void *data)
 {
 	struct sg_table *sgt = data;
 
@@ -1042,9 +1041,9 @@ iov_kunit_iter_unpin_sgt(void *data)
 		unpin_user_page(sg_page(&sgt->sgl[i]));
 }
 
-static void __init
-iov_kunit_iter_to_sg_init(struct kunit *test, size_t bufsize, bool user,
-			  struct iov_kunit_iter_to_sg_data *data)
+static void iov_kunit_iter_to_sg_init(struct kunit *test, size_t bufsize,
+				      bool user,
+				      struct iov_kunit_iter_to_sg_data *data)
 {
 	struct page **spages;
 	struct scatterlist *sg;
@@ -1080,10 +1079,9 @@ iov_kunit_iter_to_sg_init(struct kunit *test, size_t bufsize, bool user,
 	memset(data->scratch, 0, bufsize);
 }
 
-static void __init
-iov_kunit_iter_to_sg_check(struct kunit *test, struct iov_iter *iter,
-			   size_t bufsize,
-			   struct iov_kunit_iter_to_sg_data *data)
+static void iov_kunit_iter_to_sg_check(struct kunit *test, struct iov_iter *iter,
+				       size_t bufsize,
+				       struct iov_kunit_iter_to_sg_data *data)
 {
 	static const size_t tail = 16 * PAGE_SIZE;
 	size_t i;
@@ -1128,7 +1126,7 @@ iov_kunit_iter_to_sg_check(struct kunit *test, struct iov_iter *iter,
 	KUNIT_EXPECT_EQ(test, i, bufsize);
 }
 
-static void __init iov_kunit_iter_to_sg_kvec(struct kunit *test)
+static void iov_kunit_iter_to_sg_kvec(struct kunit *test)
 {
 	struct iov_kunit_iter_to_sg_data data;
 	struct iov_iter iter;
@@ -1145,7 +1143,7 @@ static void __init iov_kunit_iter_to_sg_kvec(struct kunit *test)
 	iov_kunit_iter_to_sg_check(test, &iter, bufsize, &data);
 }
 
-static void __init iov_kunit_iter_to_sg_bvec(struct kunit *test)
+static void iov_kunit_iter_to_sg_bvec(struct kunit *test)
 {
 	struct iov_kunit_iter_to_sg_data data;
 	struct page *p, *can_merge = NULL;
@@ -1173,7 +1171,7 @@ static void __init iov_kunit_iter_to_sg_bvec(struct kunit *test)
 	iov_kunit_iter_to_sg_check(test, &iter, bufsize, &data);
 }
 
-static void __init iov_kunit_iter_to_sg_folioq(struct kunit *test)
+static void iov_kunit_iter_to_sg_folioq(struct kunit *test)
 {
 	struct iov_kunit_iter_to_sg_data data;
 	struct folio_queue *folioq;
@@ -1190,7 +1188,7 @@ static void __init iov_kunit_iter_to_sg_folioq(struct kunit *test)
 	iov_kunit_iter_to_sg_check(test, &iter, bufsize, &data);
 }
 
-static void __init iov_kunit_iter_to_sg_xarray(struct kunit *test)
+static void iov_kunit_iter_to_sg_xarray(struct kunit *test)
 {
 	struct iov_kunit_iter_to_sg_data data;
 	struct xarray *xarray;
@@ -1207,7 +1205,7 @@ static void __init iov_kunit_iter_to_sg_xarray(struct kunit *test)
 	iov_kunit_iter_to_sg_check(test, &iter, bufsize, &data);
 }
 
-static void __init iov_kunit_iter_to_sg_ubuf(struct kunit *test)
+static void iov_kunit_iter_to_sg_ubuf(struct kunit *test)
 {
 	struct iov_kunit_iter_to_sg_data data;
 	struct iov_iter iter;
@@ -1221,7 +1219,7 @@ static void __init iov_kunit_iter_to_sg_ubuf(struct kunit *test)
 	iov_kunit_iter_to_sg_check(test, &iter, bufsize, &data);
 }
 
-static struct kunit_case __refdata iov_kunit_cases[] = {
+static struct kunit_case iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_to_kvec),
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
 	KUNIT_CASE(iov_kunit_copy_to_bvec),


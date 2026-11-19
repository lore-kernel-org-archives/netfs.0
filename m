Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077599;
	b=Omu6rzDOb2/RjUWgSmwJRdat4JHHTDRdoV6CgMIAuGnjOgaraibfFQMQO/AoxAUB8W5a
	 XVOfEQYzIq7o4wy0KwkTC2ZlOABD1gwQZsByqrNodhefnmXdi5sOoilTSLsGvlka6axVX
	 +ogDcWgaCkm5sHTm4lF6JH664R1p06SOjkroxeuANpaSC2VDOQCWkjbrZXd+SY+2GIvpN
	 bisQAM1h/9AqDPih+t6atEP6rAOzmZlBkiKF6dvlxzHvdhy3ubxfl1+Nwih2w90upkz7x
	 nJLtjNxcMgZxcvrfToXIc4aR94wxkKfgbc02Ric4GLKnTeRPEwnViCVXmjTstkdA8Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077599;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=+2954zM8XCuzHXARl8C2M1W3XwPc8Gv34Sem+FKL8Mg=;
	b=4PFvWAJsDtnJZla5jcnW5A/lryHshl6B3WNjw09zJhfNs1GwwAuLJuNtHaf7rqYyTHLF
	 WtPtubflIUcVEejIFFIZWI0Z7U64dgrP05pCiXjkG85t4fGQLaYwUD8/wZ4e+69/Fx/IX
	 bNnT8MrcOG89ac4zZqkWc/yH0kbI6D9i29BUuSU/d3kIhoHWhhqyTyahJW0Kx9ebPtDmZ
	 4gT5GDy+8Uhsn568DGqTtjUczROTZ0cOgR7/8garHgTN9pVgPVo3xSDHxCmAkqfz1IzOF
	 xtvIjGBqgNyoc7Yj68lneO0ljT+ccnvkfKAQSRRJSl4V5ofmWAbNnPNIHSplZEKCkog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f0rsh+OI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB3606AF16
	for <netfs@lists.linux.dev>; Thu, 19 Nov 2026 08:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54AB3606AF16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f0rsh+OI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795077597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2954zM8XCuzHXARl8C2M1W3XwPc8Gv34Sem+FKL8Mg=;
	b=f0rsh+OImXf/N1mZdy5i74740I17pgHw/2OIUO/joNIe3OlNy0OnQUudqvARN8uDSLma/q
	Hb4XKI14F8jmY4a7dpfon9oo3v87z2UyukakgSpOodYqw02RIZRRjpEfOmG72mXIBwwe7M
	bXG0obhPc16FuKEjDRkfLJ5CQM4WCkc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-6z5NSwzOOPG7NrU40Akuig-1; Thu,
 19 Nov 2026 03:39:53 -0500
X-MC-Unique: 6z5NSwzOOPG7NrU40Akuig-1
X-Mimecast-MFC-AGG-ID: 6z5NSwzOOPG7NrU40Akuig_1795077591
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0730B195607A;
	Thu, 19 Nov 2026 08:39:51 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3497A30000E8;
	Thu, 19 Nov 2026 08:39:47 +0000 (UTC)
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
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v19 09/17] netfs: Change netfs_writeback_single() to not look inside the iterator
Date: Thu, 19 Nov 2026 08:38:40 +0000
Message-ID: <20261119083851.3306418-10-dhowells@redhat.com>
In-Reply-To: <20261119083851.3306418-1-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: LMmgPRiFsy3WR9vX_iNx-fd3CWGbcUASKvG0OU4sjVo_1795077591
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Change netfs_writeback_single() so that it doesn't look around inside the
data buffer iterator it is given and doesn't try to submit the folios from
the list individually.  Instead, it treats it as a DIO write and pushes the
iterator directly, unsliced, to the cache (or the filesystem) to write
from.

There are also some changes of behaviour:

 (1) netfs_writeback_single() will make a single unbounded monolithic write
     to the cache.

 (2) When writing, sreq_max_len/segs are ignored as the "single" type
     mandates all the data be transferred in a single op.  Whilst this is
     not strictly necessary for the cache as the contract is really with
     the server, it simplifies things for now.

 (3) An explicit wait is added to the function to make sure that the write
     is concluded before returning as there's currently no mechanism to
     check if the write is completed as page flags aren't used.  This can
     be fixed later, but may require AFS's dir and symlink handling to
     check for write completion before allowing further changes be made.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 172 +++++++----------------------------------
 1 file changed, 28 insertions(+), 144 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 63b0e2599c3c..0fcfb5ab49bd 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -627,133 +627,15 @@ int netfs_writepages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(netfs_writepages);
 
-/*
- * Write some of a pending folio data back to the server and/or the cache.
- */
-static int netfs_write_folio_single(struct netfs_io_request *wreq,
-				    struct folio *folio)
-{
-	struct netfs_io_stream *upload = &wreq->io_streams[0];
-	struct netfs_io_stream *cache  = &wreq->io_streams[1];
-	struct netfs_io_stream *stream;
-	size_t iter_off = 0;
-	size_t fsize = folio_size(folio), flen;
-	uoff_t fpos = folio_pos(folio);
-	ssize_t ret;
-	bool to_eof = false;
-	bool no_debug = false;
-
-	_enter("");
-
-	flen = folio_size(folio);
-	if (flen > wreq->i_size - fpos) {
-		flen = wreq->i_size - fpos;
-		folio_zero_segment(folio, flen, fsize);
-		to_eof = true;
-	} else if (flen == wreq->i_size - fpos) {
-		to_eof = true;
-	}
-
-	_debug("folio %zx/%zx", flen, fsize);
-
-	if (!upload->avail && !cache->avail) {
-		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
-		return 0;
-	}
-
-	if (!upload->construct)
-		trace_netfs_folio(folio, netfs_folio_trace_store);
-	else
-		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
-
-	/* Attach the folio to the rolling buffer. */
-	folio_get(folio);
-	ret = rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_MARK, wreq->gfp);
-	if (ret < 0) {
-		folio_put(folio);
-		return ret;
-	}
-
-	/* Move the submission point forward to allow for write-streaming data
-	 * not starting at the front of the page.  We don't do write-streaming
-	 * with the cache as the cache requires DIO alignment.
-	 *
-	 * Also skip uploading for data that's been read and just needs copying
-	 * to the cache.
-	 */
-	for (int s = 0; s < NR_IO_STREAMS; s++) {
-		stream = &wreq->io_streams[s];
-		stream->submit_off = 0;
-		stream->submit_len = flen;
-		if (!stream->avail) {
-			stream->submit_off = UINT_MAX;
-			stream->submit_len = 0;
-		}
-	}
-
-	/* Attach the folio to one or more subrequests.  For a big folio, we
-	 * could end up with thousands of subrequests if the wsize is small -
-	 * but we might need to wait during the creation of subrequests for
-	 * network resources (eg. SMB credits).
-	 */
-	for (;;) {
-		ssize_t part;
-		size_t lowest_off = ULONG_MAX;
-		int choose_s = -1;
-
-		/* Always add to the lowest-submitted stream first. */
-		for (int s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->submit_len > 0 &&
-			    stream->submit_off < lowest_off) {
-				lowest_off = stream->submit_off;
-				choose_s = s;
-			}
-		}
-
-		if (choose_s < 0)
-			break;
-		stream = &wreq->io_streams[choose_s];
-
-		/* Advance the iterator(s). */
-		if (stream->submit_off > iter_off) {
-			rolling_buffer_advance(&wreq->buffer, stream->submit_off - iter_off);
-			iter_off = stream->submit_off;
-		}
-
-		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
-		stream->submit_extendable_to = fsize - stream->submit_off;
-		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
-					   stream->submit_len, to_eof);
-		stream->submit_off += part;
-		if (part > stream->submit_len)
-			stream->submit_len = 0;
-		else
-			stream->submit_len -= part;
-		if (part > 0)
-			no_debug = true;
-	}
-
-	wreq->buffer.iter.iov_offset = 0;
-	if (fsize > iter_off)
-		rolling_buffer_advance(&wreq->buffer, fsize - iter_off);
-	atomic64_set(&wreq->issued_to, fpos + fsize);
-
-	if (!no_debug)
-		kdebug("R=%x: No submit", wreq->debug_id);
-	_leave(" = 0");
-	return 0;
-}
-
 /**
- * netfs_writeback_single - Write back a monolithic payload
+ * netfs_writeback_single - Write back a monolithic payload to cache
  * @mapping: The mapping to write from
  * @wbc: Hints from the VM
- * @iter: Data buffer to write from, must be ITER_FOLIOQ.
+ * @iter: Data buffer to write from.
  * @len: Amount of data to write.
  *
- * Write a monolithic, non-pagecache object back to the server and/or
- * the cache.
+ * Write a monolithic, non-pagecache object back to the cache only.  The data
+ * is not written to the server.
  *
  * The data buffer may be bigger than @len (as set in @iter's count), and if
  * so, this function will use the extra as needed to provide padding into the
@@ -768,12 +650,8 @@ int netfs_writeback_single(struct address_space *mapping,
 {
 	struct netfs_io_request *wreq;
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
-	struct folio_queue *fq;
-	size_t size = len;
 	int ret;
 
-	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
-		return -EIO;
 	if (WARN_ON_ONCE(iov_iter_count(iter) < len))
 		return -EIO;
 
@@ -789,36 +667,42 @@ int netfs_writeback_single(struct address_space *mapping,
 		goto couldnt_start;
 	}
 
+	wreq->buffer.iter = *iter;
+	wreq->len = len;
+	wreq->submitted = wreq->len;
+
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback_single);
 	netfs_stat(&netfs_n_wh_writepages);
 
-	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
-		wreq->netfs_ops->begin_writeback(wreq);
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_io_subrequest *subreq;
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
+
+		if (!stream->avail)
+			continue;
 
-	for (fq = (struct folio_queue *)iter->folioq; fq; fq = fq->next) {
-		for (int slot = 0; slot < folioq_count(fq); slot++) {
-			struct folio *folio = folioq_folio(fq, slot);
-			size_t part = umin(folioq_folio_size(fq, slot), size);
+		netfs_prepare_write(wreq, stream, 0);
+		/* Allocation not allowed to fail in writeback. */
 
-			_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_to));
+		subreq = stream->construct;
+		subreq->len = wreq->len;
+		stream->submit_len = subreq->len;
+		stream->submit_extendable_to = iov_iter_count(iter) - len;
 
-			ret = netfs_write_folio_single(wreq, folio);
-			if (ret < 0)
-				goto stop;
-			size -= part;
-			if (size <= 0)
-				goto stop;
-		}
+		netfs_issue_write(wreq, stream);
 	}
 
-stop:
-	for (int s = 0; s < NR_IO_STREAMS; s++)
-		netfs_issue_write(wreq, &wreq->io_streams[s]);
 	netfs_all_subreqs_queued(wreq);
-
 	netfs_wake_collector(wreq);
 
+	/* TODO: Might want to be async here if WB_SYNC_NONE, but then need to
+	 * wait before modifying.
+	 */
+	ret = netfs_wait_for_write(wreq);
+	if (ret > 0)
+		ret = 0;
+
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	_leave(" = %d", ret);
 	return ret;


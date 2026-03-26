Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F123F8DF5
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522190; cv=none; b=HpJqqnileNcs38EcuoPsK77xFRPkMwKuBCUaxzCoZuTkBSB1KKihRq8kLkP89Ww8PE9ZO/9sKfVI7bEQUhDeophUcGwjzadtDiP26OUGee4xiWpyql94p4U/jpTC0hLhzROlMGFGDHl2eyfhFpNg7F9wL5XXiqYzYazdW/nNxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522190; c=relaxed/simple;
	bh=sU2zUgwIPPM1gWJtEBg6k7zAgJC6dwFXJciLsxo98xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iTwlxZI2kwRCB+YqjlJZxOlCSFziE2LyEYq4vpPvfJsQ8EVNSISIs4GlIyX2HjCz1u6XU3mfDuHsh3C7ZhKOJQ3rI8JRO5K67ChVqoYZaLifn1y2hFqECCSbVNFbew3X2AKU/H5xiFlyeHY9nGumkVWzsfdcai6u/XwomaRVD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcxTPF0u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcxTPF0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dua10S0xY5PQQMwCx5ef5lVGVsxRJy1bcsfs1R39zY=;
	b=TcxTPF0uZcmERAI9BmKcGgYoRW0pregXwmfjWaYOsUkOSUjjBk6Dj+Nf1NbrfU4Eu3+NfW
	pKZlkAWUJfimMgG4ewu3t02M5VjlEJST6/zxFSSDo2gX1c1TetHXQfUgr/FSG+l3cqaoec
	7gWtPhKscRDJbqFWkUyi6LuwBMBIeS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-R25vA0AZMP6MQs6h0YVvDg-1; Thu,
 26 Mar 2026 06:49:45 -0400
X-MC-Unique: R25vA0AZMP6MQs6h0YVvDg-1
X-Mimecast-MFC-AGG-ID: R25vA0AZMP6MQs6h0YVvDg_1774522182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D85219560A6;
	Thu, 26 Mar 2026 10:49:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 022BA1800576;
	Thu, 26 Mar 2026 10:49:35 +0000 (UTC)
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
Subject: [PATCH 25/26] netfs: Limit the the minimum trigger for progress reporting
Date: Thu, 26 Mar 2026 10:45:40 +0000
Message-ID: <20260326104544.509518-26-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: BRcsy4R0xBtyN92z9Z6ZqHLT5LFZwUr7950eJD5leMk_1774522182
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

For really big read RPC ops that span multiple folios, netfslib allows the
filesystem to give progress notifications to wake up the collector thread
to do a collection of folios that have now been fetched, even if the RPC is
still ongoing, thereby allowing the application to make progress.

The trigger for this is that at least one folio has been downloaded since
the clean point.  If, however, the folios are small, this means the
collector thread is constantly being woken up - which has a negative
performance impact on the system.

Set a minimum trigger of 256KiB or the size of the folio at the front of
the queue, whichever is larger.

Also, fix the base to be the stream collection point, not the point at
which the collector has cleaned up to (which is currently 0 until something
has been collected).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index bacf047029fa..6d49f9a6b1f0 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -494,15 +494,15 @@ void netfs_read_collection_worker(struct work_struct *work)
 void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
-	size_t fsize = PAGE_SIZE << rreq->front_folio_order;
+	struct netfs_io_stream *stream = &rreq->io_streams[subreq->stream_nr];
+	size_t fsize = umax(PAGE_SIZE << rreq->front_folio_order, 256 * 1024);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_progress);
 
 	/* If we are at the head of the queue, wake up the collector,
 	 * getting a ref to it if we were the ones to do so.
 	 */
-	if (subreq->start + subreq->transferred > rreq->cleaned_to + fsize &&
+	if (subreq->start + subreq->transferred >= stream->collected_to + fsize &&
 	    (rreq->origin == NETFS_READAHEAD ||
 	     rreq->origin == NETFS_READPAGE ||
 	     rreq->origin == NETFS_READ_FOR_WRITE) &&


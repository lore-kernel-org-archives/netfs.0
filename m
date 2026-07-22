Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A4314A86
	for <netfs@lists.linux.dev>; Wed, 22 Jul 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725383; cv=none; b=tSkSbOSYyu4ZGWJoEpU/wKlG05bmbGc+f/jlaM3wHsASgLcAgpKSd9k7jZsQvcAfIef2SoMgnupKFnrid66eWc28Q1CmQGwmyxnHSQItBStNjv0qNTXET7lX006ey8oxzcVh19uU7ms3GWLKdCoskOHskJXgNhljJuyGI7pi2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725383; c=relaxed/simple;
	bh=oAFLvzAvCvqH+74ACE1LGBYASqPJJ/gZkoEYbTMwexk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cnTXibXJMyAPfTxOeZdXl5HnwrtfLFEVCOh5w/qcKpcRVjOzxXp3lkvlwaNkAFGFHFY74pZZuCyV9sX7Q4/gTPqE5mTbMz5IdaQf5MKq5Pb4RudZz3AKGZlbnzEKmAWXInUJqqMlD61vgmpFV8LU1S8WBvY2XIPzaGufvurfNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7KAMdn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7KAMdn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784725380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8C6bJJEtQmiVwAw0nsngdl6zXvM4+8rNe514omrJIfM=;
	b=O7KAMdn909qINJHJUi4VrNc0KDcrq4ye4g9ltFc13TcpwHLqvnH5YoPlpLWWczUIyQnOfW
	efK6BQxWP9KCesO4tRxmGoxGsHJX/GBB9OcSqGMrSgrFOcbm+3Ssumw+a4NlumN2vrg5ld
	8zIw9rtyMDiCtDnqhBnHqwckBD/QfLk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-IvztPQHUN2qWiHQvpP2qpA-1; Wed,
 22 Jul 2026 09:02:57 -0400
X-MC-Unique: IvztPQHUN2qWiHQvpP2qpA-1
X-Mimecast-MFC-AGG-ID: IvztPQHUN2qWiHQvpP2qpA_1784725372
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00F3F1977537;
	Wed, 22 Jul 2026 13:02:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 638B31956042;
	Wed, 22 Jul 2026 13:02:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
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
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH v7 02/29] netfs: handle single writeback rolling buffer allocation failure
Date: Wed, 22 Jul 2026 14:01:49 +0100
Message-ID: <20260722130218.78958-3-dhowells@redhat.com>
In-Reply-To: <20260722130218.78958-1-dhowells@redhat.com>
References: <20260722130218.78958-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ZrtUO-mzFFcrFpMeIEDSF6xQTLgLtLojk_ti6u5Hx98_1784725372
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Yichong Chen <chenyichong@uniontech.com>

netfs_write_folio_single() takes an extra folio reference before
appending the folio to the rolling buffer.

rolling_buffer_append() can fail if it cannot allocate another
folio_queue. Check the return value and drop the extra folio reference
before returning the error.

Fixes: 49866ce7ea8d ("netfs: Add support for caching single monolithic objects such as AFS dirs")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index f2761c99795a..14efe4cb9393 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -720,6 +720,7 @@ static int netfs_write_folio_single(struct netfs_io_request *wreq,
 	size_t iter_off = 0;
 	size_t fsize = folio_size(folio), flen;
 	loff_t fpos = folio_pos(folio);
+	ssize_t ret;
 	bool to_eof = false;
 	bool no_debug = false;
 
@@ -748,7 +749,11 @@ static int netfs_write_folio_single(struct netfs_io_request *wreq,
 
 	/* Attach the folio to the rolling buffer. */
 	folio_get(folio);
-	rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_MARK);
+	ret = rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_MARK);
+	if (ret < 0) {
+		folio_put(folio);
+		return ret;
+	}
 
 	/* Move the submission point forward to allow for write-streaming data
 	 * not starting at the front of the page.  We don't do write-streaming


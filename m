Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1473E5581
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522023; cv=none; b=EqeDM1U7H2JsWc0WtlbqtTm7+oDiePw9fuFd/N/JPxf/cC3osSMwrzlpMpkAX8TFQr5ckfWWFfFmwz696IlZt7pQTDPg0QKHUIsaKD8oWZUrwajxyxJOEUTnmI6Q3LqPLoQtJstGrV+h/BCcNZXthocB/BtVUa6SqQJhQy5aRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522023; c=relaxed/simple;
	bh=szclke4JIsBjvbhewBgvgDMxYA3sk65zpYLRMFX9C2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IW5hr16Rg5vcbW2hN3iWtu4TNK2u/Bt8LpMOlqbTeE7CPOy+9zUIBHgaXxg4zTbJ9P6TdR+aqrBXgj0eJ3fpwV6gA6YakCUUx+jSBaCqcU0OTc2Xmf2l2bK7RhLbznO1Na8PXNDmEXao5mOZcAwtfRPVl/kU9kwh/ekJRjCMyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DloiwA8l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DloiwA8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JBhkshmo9wp53/7HssoafiGynGAcR+6aULQINPD5UQ=;
	b=DloiwA8lAUtURUf6jK8oCCxluyiSInkEvirjdnbYYiIgsbGau3AHoi9hdABOKwSHbCtzDp
	kS6tyAIEPH0H2VxJaWFMYnXrnA/x4Qn1UDBAzu+xSX5AUGpAXSdFrdmZLq8fZpqihFsarJ
	CH0QeKVZ5hSzLbLGIvqYQ//DzDCBlYc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-lIkaQfXkP4W9euIGMAGh9A-1; Thu,
 26 Mar 2026 06:46:54 -0400
X-MC-Unique: lIkaQfXkP4W9euIGMAGh9A-1
X-Mimecast-MFC-AGG-ID: lIkaQfXkP4W9euIGMAGh9A_1774522012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88EF519560A2;
	Thu, 26 Mar 2026 10:46:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B082C1955D84;
	Thu, 26 Mar 2026 10:46:44 +0000 (UTC)
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
Subject: [PATCH 05/26] netfs: Fix read abandonment during retry
Date: Thu, 26 Mar 2026 10:45:20 +0000
Message-ID: <20260326104544.509518-6-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: KG2T4gCNnFYLKqj0mibQcVQ-9WD4fPq4DOC5KtQd950_1774522012
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Under certain circumstances, all the remaining subrequests from a read
request will get abandoned during retry.  The abandonment process expects
the 'subreq' variable to be set to the place to start abandonment from, but
it doesn't always have a useful value (it will be uninitialised on the
first pass through the loop and it may point to a deleted subrequest on
later passes).

Fix the first jump to "abandon:" to set subreq to the start of the first
subrequest expected to need retry (which, in this abandonment case, turned
out unexpectedly to no longer have NEED_RETRY set).

Also clear the subreq pointer after discarding superfluous retryable
subrequests to cause an oops if we do try to access it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
---
 fs/netfs/read_retry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 71a0c7ed163a..68fc869513ef 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -93,8 +93,10 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		       from->start, from->transferred, from->len);
 
 		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
-		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
+		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags)) {
+			subreq = from;
 			goto abandon;
+		}
 
 		list_for_each_continue(next, &stream->subrequests) {
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
@@ -178,6 +180,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				if (subreq == to)
 					break;
 			}
+			subreq = NULL;
 			continue;
 		}
 


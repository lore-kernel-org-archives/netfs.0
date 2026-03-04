Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7503C3C06
	for <netfs@lists.linux.dev>; Wed,  4 Mar 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633138; cv=none; b=KwDDaRIKF9YIHrDqtS53hE0t2kEItWE0c/9Y3JLGcsGPMiazdbVY0z8plnp4bg0p5KP0FrHcsPmVyFyOPzROsTs/RyBufEqaMHCGAwjeuLT1AsAzp2jaTZxY6soSQzLzny9kICvAnjElPJZua8v3CYDUelBCT6UPxt5A52Zp/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633138; c=relaxed/simple;
	bh=QxdQukoNegxt7cys2Ne0RaX+CMcxVII0TxVF64PClMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Tlhu2sp/GD6iEFAk/6tSNTSEefYLT8radBEhV/9nTNOZaSFGVb3y23nG2g7AJ1acTVFa9WWOVg5Wlbfk8h5rHP5QyCIxG//9HR4aeSoIUmP1gIwpzXat0ZyFVM+5iX3uJNH8PTs9i8XaPW0R96EPni9ZM5GO9w0GIFa7EPHmpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFmfwWdc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFmfwWdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8d8J22DaSQuOQSD54Wg05WTtU42gahs7pGBkEdp1IFY=;
	b=OFmfwWdcDdSuhvswHMNZwOGaqLJcIL4Z1lSsm8cQuG6r6anV7mFhdv7QLwU48trEUIprkc
	E59+ARUdVL/XQtUEdYUf23YjX7hUAZF8r6GclDDH7+0P8Cn62JVVjhgVdEuDMxaz6ffaH/
	E+MD7JO1DFX1jargsJsjmLeUM/vDpa0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-XleRjEHKMWuPDQMBbTTDJg-1; Wed,
 04 Mar 2026 09:05:31 -0500
X-MC-Unique: XleRjEHKMWuPDQMBbTTDJg-1
X-Mimecast-MFC-AGG-ID: XleRjEHKMWuPDQMBbTTDJg_1772633129
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3526195606C;
	Wed,  4 Mar 2026 14:05:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 206DF180049D;
	Wed,  4 Mar 2026 14:05:24 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 16/17] netfs: Check for too much data being read
Date: Wed,  4 Mar 2026 14:03:23 +0000
Message-ID: <20260304140328.112636-17-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: IYHRtwrAt9oRucKFH8WybxqC89lby2PzSraNfQdzMEQ_1772633129
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Put in a check in read subreq termination to detect more data being read
for a subrequest than was requested.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c      | 8 ++++++++
 include/trace/events/netfs.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 3b5978832369..20c80df8914f 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -545,6 +545,14 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		break;
 	}
 
+	if (subreq->transferred > subreq->len) {
+		subreq->transferred = 0;
+		__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_too_much);
+		subreq->error = -EIO;
+	}
+
 	/* Deal with retry requests, short reads and errors.  If we retry
 	 * but don't make progress, we abandon the attempt.
 	 */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 861dc7849067..899b85d7ef92 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -124,6 +124,7 @@
 	EM(netfs_sreq_trace_submit,		"SUBMT")	\
 	EM(netfs_sreq_trace_superfluous,	"SPRFL")	\
 	EM(netfs_sreq_trace_terminated,		"TERM ")	\
+	EM(netfs_sreq_trace_too_much,		"!TOOM")	\
 	EM(netfs_sreq_trace_wait_for,		"_WAIT")	\
 	EM(netfs_sreq_trace_write,		"WRITE")	\
 	EM(netfs_sreq_trace_write_skip,		"SKIP ")	\


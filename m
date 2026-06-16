Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498444105C
	for <netfs@lists.linux.dev>; Tue, 16 Jun 2026 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604750; cv=none; b=I75JfLWk/We14P63+SWtBRgMlYHL+TJ2YHFY86Ss2oEuqne61llPAWAv3yMIn+R8mz9tmv5WF/A/YKHvTEV7SH9NkkXFpo5zYr8K2lR3ZQbGBbT4HEAiIHPZ1ANxF4Zmw3+/4m6QFUMF64iUrjswn6OuXfPA8+dg1/HHgI7JesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604750; c=relaxed/simple;
	bh=HLoxeFhghYgcnPTyOszlBWDi3KZJSiCbsQEjzraQKRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=f7RNXaD6s6gG56uOZ4dX5Ixb6E2ToYJ9LQcaAZ3nNYy/OayzsUCWsuffy0kiobm1nRcIsAqTaBYyHkr64BRq6qj0dZHylGLT38/Uuz9CJNN3j0BkTnxMPcMGtbgxt6cNjB/2UUXbkm44PT3RUyInbma3G3Xo1dxeiZYoUokpECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMDiK1dI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMDiK1dI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfX4hKOxHGk+bf7dAxE3qPG38R5aFPeh/NdzY9CtdfI=;
	b=fMDiK1dIiK2ngOrrtojhW9v+bvGs1SRd3JDXTfVdfrNKqWpXX7hVmNk9W6cYo4pekuE00G
	zbw0z0nI9Ow55Uzap3J+dgyroG7rMybo/Mw9xudXn1RnTyV9hYy+NjAhRNM+Z2ZD0bPzUv
	PCylh2h8ZZcLPEq9ynVMxkZnwxWn4ug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-jgW8GiYSNzSI7PbtLwwkgg-1; Tue,
 16 Jun 2026 06:12:21 -0400
X-MC-Unique: jgW8GiYSNzSI7PbtLwwkgg-1
X-Mimecast-MFC-AGG-ID: jgW8GiYSNzSI7PbtLwwkgg_1781604736
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A4EB180ACE5;
	Tue, 16 Jun 2026 10:12:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A773180034F;
	Tue, 16 Jun 2026 10:12:07 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 27/30] netfs: Check for too much data being read
Date: Tue, 16 Jun 2026 11:08:16 +0100
Message-ID: <20260616100821.2062304-28-dhowells@redhat.com>
In-Reply-To: <20260616100821.2062304-1-dhowells@redhat.com>
References: <20260616100821.2062304-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: JPgQX7-MspMEoiW_zsbctoCyeM3_fqq92Tn6qn6fio0_1781604736
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
index 802d1c40cce5..9efcc0e63a96 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -543,6 +543,14 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
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
index 59f330003d02..cc29582f6245 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -134,6 +134,7 @@
 	EM(netfs_sreq_trace_submit,		"SUBMT")	\
 	EM(netfs_sreq_trace_superfluous,	"SPRFL")	\
 	EM(netfs_sreq_trace_terminated,		"TERM ")	\
+	EM(netfs_sreq_trace_too_much,		"!TOOM")	\
 	EM(netfs_sreq_trace_wait_for,		"_WAIT")	\
 	EM(netfs_sreq_trace_write,		"WRITE")	\
 	EM(netfs_sreq_trace_write_skip,		"SKIP ")	\


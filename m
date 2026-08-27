Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8A477995
	for <netfs@lists.linux.dev>; Thu, 27 Aug 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838230; cv=none; b=EgWTcB+BTG+6Gn0Nf7g6/G3uIZEg43E2+TYH51X7lDwEzvi9y9Fn353rnl2wWmZDrCaO1jdmaGt0PopWxRYdgMsQY7tjwRpxvNelDgM3nVmFWwIxiD0cQVP5yN5NCy0nHBK93Go/J2kXt9ZF+UQbq4DrJu1gnWkFz9XGcLqAiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838230; c=relaxed/simple;
	bh=QrdzqNcCR9iFFgQpRU6lHGZ+NgG7PoA+HmJTAzSrA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bX+egwkRitc92cqf2x5quSnIatLJCP91JTOZ9KGkFxrlWzHHaAbscOuME+I78n4MWV+AucN5BCjV0Kukq5xUD6ixtZCX2vtpre5WIsYNMbIPmbCY1CfZ3PrNDmqByUP0Qkcu7svLsC4j5hMv8uXXo+9OsjDm2upLIByQVO6tgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI3Z4GaC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI3Z4GaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787838218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2pt6wnBqtVDYBV6sOHnn+X/jyNpYuj5XG1JqmENcwc=;
	b=gI3Z4GaCrc88MbuEspPsXylY5B1ZHzSd3JOWynJJ4JnXpJBnPPAv/oFSlcdm9l1fQj6y5H
	eEWrf4upqG1cNP0AB0ojfxHgH2Mjtel1DGHqDqwmxw66JWCvtdtli6ohwaLVZiDIw3IDJx
	zc0RLb9NUOAXyySK0qZM5VV+hUFe7dQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-FTJ01tnfM8KUUf-3Qc-ZNA-1; Thu,
 27 Aug 2026 09:43:35 -0400
X-MC-Unique: FTJ01tnfM8KUUf-3Qc-ZNA-1
X-Mimecast-MFC-AGG-ID: FTJ01tnfM8KUUf-3Qc-ZNA_1787838213
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90B83185CEA2;
	Thu, 27 Aug 2026 13:43:33 +0000 (UTC)
Received: from warthog.com (unknown [10.22.88.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 489F018005AD;
	Thu, 27 Aug 2026 13:43:31 +0000 (UTC)
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
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Subject: [PATCH v4 06/10] netfs: break unbuffered write when netfs_alloc_subrequest() fails
Date: Thu, 27 Aug 2026 14:42:59 +0100
Message-ID: <20260827134304.2075713-7-dhowells@redhat.com>
In-Reply-To: <20260827134304.2075713-1-dhowells@redhat.com>
References: <20260827134304.2075713-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: -XkJ-Ldwr3yB83x4zf3CLXQBCD0J-yQMdj439hxqRfQ_1787838213
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Edward Adam Davis <eadavis@qq.com>

syzbot reported a null-ptr-deref below [1] following a fault injection in
netfs_alloc_subrequest(). [0]

When netfs_alloc_subrequest() fails, subreq is NULL.
Later, netfs_prepare_write() tries to initialize members of
subreq(e.g., source), the issue in [1] is triggered.

Let's handle the error of netfs_prepare_write() properly.

[0]
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
Call Trace:
 netfs_alloc_subrequest+0x116/0x3f0
 netfs_prepare_write+0x76/0x7b0
 netfs_unbuffered_write+0x75c/0x2020
 netfs_unbuffered_write_iter_locked+0x7d6/0xa80
 netfs_unbuffered_write_iter+0x442/0x720
 v9fs_file_write_iter+0xbf/0x100
 vfs_write+0x6ac/0x1050

[1]
KASAN: null-ptr-deref in range [0x00000000000000a8-0x00000000000000af]
RIP: 0010:netfs_prepare_write+0xbc/0x7b0 fs/netfs/write_issue.c:173
Call Trace:
 netfs_unbuffered_write+0x75c/0x2020 fs/netfs/direct_write.c:111
 netfs_unbuffered_write_iter_locked+0x7d6/0xa80 fs/netfs/direct_write.c:290
 netfs_unbuffered_write_iter+0x442/0x720 fs/netfs/direct_write.c:382
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Reported-by: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a13fc77eb6f0802be2d
Tested-by: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/direct_write.c | 5 +++++
 fs/netfs/write_issue.c  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index fbcfadb232ee..2361277416c7 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -110,6 +110,11 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		if (!subreq) {
 			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
 			subreq = stream->construct;
+			if (!subreq) {
+				wreq->error = -ENOMEM;
+				ret = -ENOMEM;
+				break;
+			}
 			stream->construct = NULL;
 		}
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2d9cfcd43658..851f6f93ad45 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -170,6 +170,8 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 		rolling_buffer_make_space(&wreq->buffer, wreq->gfp);
 
 	subreq = netfs_alloc_subrequest(wreq);
+	if (!subreq)
+		return;
 	subreq->source		= stream->source;
 	subreq->start		= start;
 	subreq->stream_nr	= stream->stream_nr;


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFC33DEC8
	for <netfs@lists.linux.dev>; Wed,  9 Sep 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938524; cv=none; b=iaQXFlwGJT3mCBb6fr+vV4V+GTGkKd9jf+a57t1wmnqKcS0vHpB9SCBDGwE6LzLVzMGzZh7EEhTe3JmmaMEE+nK8X1YnootW/DMSJhYPfwwJdQUlRTT0bKsHI8TJMq9njrR5VTFZ/kjg/C8hSjDjd0Ns9UxGRE+yK3/8kXKY88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938524; c=relaxed/simple;
	bh=cLsyGwNpMweEOeUhK/2nbHpVf8o+5CUfpU7U3AkBht0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OE2IBMA4rGj/yhO8jJ3x8G5Pap1PFuEpRI+SnprhF+Tak+Ii3vlJ/wzfn60kvNyrnqg1++Gi5WMNG8GTuiOSL+heHGFkWfEjB8FXnG29YmwLK1My7DSrS6vj87ni1GSxDIXnRc/yTmYxSjWA3tDUXcGfi+3QB5SzxGVP4d5bTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXHcqpj4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXHcqpj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788938513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DslwRdsu/8tTWOlVJvkd0gqMqXh0L3cVibDrCzgiQjo=;
	b=iXHcqpj4++E38xNKGdDsl19YAsQB8ItFE8rCzdrz4GKp0adZzSECvk5fqX7eqZvvOKMHCW
	ig19mAgAwgX4oo310xp41omIWF1rzfKB1A4JTsTFw2ESFNFXLVVdiAjB+9wPvvCshgxBZ0
	eFVUX+zmDggG8UpqwcJZATVdGpRw2ME=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-jHMUPDL8N86yNt1Dx89D-w-1; Wed,
 09 Sep 2026 03:21:50 -0400
X-MC-Unique: jHMUPDL8N86yNt1Dx89D-w-1
X-Mimecast-MFC-AGG-ID: jHMUPDL8N86yNt1Dx89D-w_1788938508
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B326E1954AC5;
	Wed,  9 Sep 2026 07:21:47 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 382C51956049;
	Wed,  9 Sep 2026 07:21:41 +0000 (UTC)
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
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 3/8] netfs: trace: Change the "clear" folio traces to "endwb"
Date: Wed,  9 Sep 2026 08:20:57 +0100
Message-ID: <20260909072105.1663687-4-dhowells@redhat.com>
In-Reply-To: <20260909072105.1663687-1-dhowells@redhat.com>
References: <20260909072105.1663687-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 127.0.0.2
X-Mimecast-MFC-PROC-ID: cwsPfiwjOcqLK5_nqpALo1pLmhQqjKd8sl1yR21ylAA_1788938508
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Change the "clear" folio traces to "endwb" as it's more obvious what it
means.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c     | 8 ++++----
 include/trace/events/netfs.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 244a68e04624..6114bdf27ce0 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -56,7 +56,7 @@ static void netfs_dump_request(const struct netfs_io_request *rreq)
  */
 int netfs_folio_written_back(struct folio *folio)
 {
-	enum netfs_folio_trace why = netfs_folio_trace_clear;
+	enum netfs_folio_trace why = netfs_folio_trace_endwb;
 	struct inode *inode = folio_inode(folio);
 	struct netfs_inode *ictx = netfs_inode(inode);
 	struct netfs_folio *finfo;
@@ -79,13 +79,13 @@ int netfs_folio_written_back(struct folio *folio)
 		group = finfo->netfs_group;
 		gcount++;
 		kfree(finfo);
-		why = netfs_folio_trace_clear_s;
+		why = netfs_folio_trace_endwb_s;
 		goto end_wb;
 	}
 
 	if ((group = netfs_folio_group(folio))) {
 		if (group == NETFS_FOLIO_COPY_TO_CACHE) {
-			why = netfs_folio_trace_clear_cc;
+			why = netfs_folio_trace_endwb_cc;
 			folio_detach_private(folio);
 			goto end_wb;
 		}
@@ -98,7 +98,7 @@ int netfs_folio_written_back(struct folio *folio)
 		if (!folio_test_dirty(folio)) {
 			folio_detach_private(folio);
 			gcount++;
-			why = netfs_folio_trace_clear_g;
+			why = netfs_folio_trace_endwb_g;
 		}
 	}
 
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index ef1185993ba4..2491a0bc4179 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -192,11 +192,11 @@
 	EM(netfs_folio_trace_alloc_buffer,	"alloc-buf")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
-	EM(netfs_folio_trace_clear,		"clear")	\
-	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
-	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_end_copy,		"end-copy")	\
+	EM(netfs_folio_trace_endwb,		"endwb")	\
+	EM(netfs_folio_trace_endwb_cc,		"endwb-cc")	\
+	EM(netfs_folio_trace_endwb_g,		"endwb-g")	\
+	EM(netfs_folio_trace_endwb_s,		"endwb-s")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_invalidate_all,	"inval-all")	\
 	EM(netfs_folio_trace_invalidate_front,	"inval-front")	\


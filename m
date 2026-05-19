Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1A4C0418
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186254; cv=none; b=BvWJcODhOCWsH4EoyuBA0oM+Bki/4RNQihtU0H6i0ocpjjNbfeNDvvrzGalF02PIcPlLtoMlMkpPuUP6zVWxDHU5Yl3ZvblwgTiNo6qcbqbGDkmSeeyFUU8jToGVeIrdd8mr0eAbYe8aw5jF9IL/vC8R6yKV0HyklT0PSQDFbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186254; c=relaxed/simple;
	bh=FdgNKyW6lzbKD2kPjjyXosRj5wLQFDlas3Z4+GXEdqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=L9owB0j+4F7/1l8A2ibO/AmGlcjFkVb3NDLDVQVvbvkcu6H4cTxbeKLp7nvRGAYFk2jEroVJZndfUe0sIghAFiUL46FSnbnnmi6CfZ81YcTQ0ToWOQqwZEQyQcg/VgedSXH3M858ktBSm1I5fviIx6SCeJG66IAyRg+BxlDLdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0OK5FgY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0OK5FgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vW+QQqFnZMgqNlEPMjFKe16EaUDVQZXcnVGSR2eEmE=;
	b=g0OK5FgYtLV5yh+h2BenYOvpzMnlFYNLGjT/3OVKuJpppU7HwFfhYueFRabzvqDGmocKtI
	1YuI43EZsq8rMLmbyoquTJmlUZTtE/otEcZrl6gV/jNtwVnSzg0VjgUPlhQ/JoCU+jrGnq
	NrzbphM+ew1LmEpkcw5NkaqtbIsGnx0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-97T95onpNLaO5p_Wu1xHzQ-1; Tue,
 19 May 2026 06:24:05 -0400
X-MC-Unique: 97T95onpNLaO5p_Wu1xHzQ-1
X-Mimecast-MFC-AGG-ID: 97T95onpNLaO5p_Wu1xHzQ_1779186244
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 308E41956060;
	Tue, 19 May 2026 10:24:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A12B1956053;
	Tue, 19 May 2026 10:24:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 24/36] cifs: Add netmem allocation functions
Date: Tue, 19 May 2026 11:21:42 +0100
Message-ID: <20260519102158.592165-25-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: mAX7S9okv0iMSj-QMTsg4J1w1vN8RWWGdrPhir3sP_A_1779186244
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add (stub) functions for doing netmem allocations.  We want to allocate
memory from the netmem buffering as that does bulk DMA and IOMMU
management.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsproto.h |  2 ++
 fs/smb/client/transport.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 72ee5c5fd8b7..3067056f8ef9 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -508,5 +508,7 @@ int smb_rxqueue_refill(struct TCP_Server_Info *server, struct netfs_rxqueue *rxq
 		       size_t min_size);
 int smb_rxqueue_consume(struct TCP_Server_Info *server, struct netfs_rxqueue *rxq,
 			size_t amount);
+void *cifs_allocate_tx_buf(struct TCP_Server_Info *server, size_t size);
+void cifs_free_tx_buf(void *p);
 
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 68536de2c1a0..1599afb9e5cf 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -33,6 +33,26 @@
 #include "smbdirect.h"
 #include "compress.h"
 
+/*
+ * Allocate transmission buffers for a socket.  This memory will be allocated
+ * from the netmem buffers.  It comes with a page ref that we need to drop.
+ * The networking layer can pin it by getting its own ref.
+ */
+void *cifs_allocate_tx_buf(struct TCP_Server_Info *server, size_t size)
+{
+	void *p;
+
+	mutex_lock(&server->tx_alloc_lock);
+	p = page_frag_alloc_align(&server->tx_alloc, size, GFP_NOFS, 8);
+	mutex_unlock(&server->tx_alloc_lock);
+	return p;
+}
+
+void cifs_free_tx_buf(void *p)
+{
+	page_frag_free(p);
+}
+
 struct smb_message *smb_message_alloc(enum smb_command_trace cmd, gfp_t gfp)
 {
 	static atomic_t debug_ids;


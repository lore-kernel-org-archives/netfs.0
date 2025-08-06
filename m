Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515D2BE648
	for <netfs@lists.linux.dev>; Wed,  6 Aug 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512750; cv=none; b=koqBJDRvsCjBVFf/w911ZwgLUbAOmAdwkEjzEle4vo0FgoJYw7QBdep2xExxnXVyUVq+wGlf4HWVfYeESgcQygpvfq/1+2HDnLE3ZlaTOr64I+fA+3T7XPi9WrymwLcDk5UzT0XbVBbLdaEL6UTmvylKWi5o5lWcmvDZ+U2APOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512750; c=relaxed/simple;
	bh=AJLngiDp+3TtTnh1fTCD7p/AYJk2JTeigIpEMuDSEhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3sSQ+B85IK/4zBVO+qzk+Yd6QTtOf/E6tYCsgh+RJL/djj+aUCj6MDgvtFh+V/IrbiBR3qwJxcHFIbr5FoBfZdzBfFy5WPaJKIMlbePAWUiLUvBOoomK9m270UFl2kuWUY/tgumo42LXMYh/yQgmYKcZUm1zf5iWcTAX5t1mEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zs5t7mFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs5t7mFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgbTabH9yiA1Rp25sUyMqeAC4tSFlKtGr5byFk5yf4o=;
	b=Zs5t7mFbba39ldolq4KDwcAWpWFe69GcfHC8EGMRknqiOGF7XSdCUFaJZ6O/d1xoPwypsK
	RyWawa9ZLCELjSdQFIaizVSmTBVDU3yI+TAdSScEtkhqpJkqszCZmVTdObjhXFW/nFCDF8
	Bbi7cNp9RQOFc09Plj32KKCc8L8ilBA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-UdAZH3cFPrOCSlnjHNSJeA-1; Wed,
 06 Aug 2025 16:39:03 -0400
X-MC-Unique: UdAZH3cFPrOCSlnjHNSJeA-1
X-Mimecast-MFC-AGG-ID: UdAZH3cFPrOCSlnjHNSJeA_1754512741
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71A371800352;
	Wed,  6 Aug 2025 20:39:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63E8F1956086;
	Wed,  6 Aug 2025 20:38:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 22/31] cifs: Add netmem allocation functions
Date: Wed,  6 Aug 2025 21:36:43 +0100
Message-ID: <20250806203705.2560493-23-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 fs/smb/client/cifsproto.h |  3 +++
 fs/smb/client/transport.c | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 074b65bb57a5..ccd70a402567 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -766,4 +766,7 @@ void smb_get_message(struct smb_message *smb, enum smb_message_trace trace);
 void smb_put_message(struct smb_message *smb, enum smb_message_trace trace);
 void smb_put_messages(struct smb_message *smb);
 
+void *cifs_allocate_tx_buf(struct TCP_Server_Info *server, size_t size);
+void cifs_free_tx_buf(void *p);
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 2ccfdd6b958b..b497bf319a7e 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -32,6 +32,21 @@
 #include "smbdirect.h"
 #include "compress.h"
 
+/*
+ * Allocate transmission buffers for a socket.  This memory will be allocated
+ * from the netmem buffers.  It comes with a page ref that we need to drop.
+ * The networking layer can pin it by getting its own ref.
+ */
+void *cifs_allocate_tx_buf(struct TCP_Server_Info *server, size_t size)
+{
+	return NULL; /* TODO */
+}
+
+void cifs_free_tx_buf(void *p)
+{
+	/* TODO */
+}
+
 struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp)
 {
 	static atomic_t debug_ids;


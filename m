Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DE466B76
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186185; cv=none; b=Wy6fxEdbmzsxTTgBTw4EKkYkPhB4tGKGzBFzcrGTTyPgrkWRk4gVbFUJNb2oyfzpDtK/f1EGVT2GED1EVD+WKKCSaQHPM1iHOtzZnQLxT201RKWNKx4dbweokHcE6sAqbjKPeS3CZQXUJ+2atXunVOXzPbd/WgW9XjSvtnvU2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186185; c=relaxed/simple;
	bh=9YxXtvgJSvdCslocEAs4652Pqh9Vf6UnqI00hCiqxxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TjHrI7gFJKlF6YQ5z0B3/MVl+0w6l1nQKzm/4WaLJiSEbBTJr28o7Pt/Z3/GniAthmKIWBm89pwX9CHofhSXTtjeF45F7Hnq+enTjmeGhn+Ve+sQ65RFcvRi2514G0N35T6drRdAqnWShy3EyNi8qTRLhfB2Ls3+6xFYXuUcwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjdVPBob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjdVPBob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nBDRAQ3XzH+HF+bEEOesEricXOP8KyYW6ngtqFP4G0=;
	b=WjdVPBob8Xl49T9S3jKn7Oe7wRHsgugd3sKNlTPOOQQbHZwEdMIndIb8C9uF5bH+dcJXJ+
	wG+b3wazWxshjMkmTFo/M/H8hhebwa6+3QRZcRylE72p2QVHi10tGMAa5v2r3tgZHq6sgC
	idDXAvRwJMbKoxtIkgEfcXGruJ5f4ag=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-HMG1UIXwPSGNWata3TI6dg-1; Tue,
 19 May 2026 06:23:01 -0400
X-MC-Unique: HMG1UIXwPSGNWata3TI6dg-1
X-Mimecast-MFC-AGG-ID: HMG1UIXwPSGNWata3TI6dg_1779186180
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C62A8195608E;
	Tue, 19 May 2026 10:22:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DFAB18004A3;
	Tue, 19 May 2026 10:22:56 +0000 (UTC)
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
Subject: [RFC PATCH 11/36] cifs: Add new AEAD alloc and setup routines that draw from an iterator
Date: Tue, 19 May 2026 11:21:29 +0100
Message-ID: <20260519102158.592165-12-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: hZw9mG5Wqv8QG_g-YQxEtstlWQn78uIrqZtkyo7cSBk_1779186180
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add new AEAD alloc and setup routines that solely use an iterator to supply
the buffers rather than disassembling an smb_rqst struct.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2transport.c | 69 +++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index f5b676802ce7..9df3a0b530e2 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -812,3 +812,72 @@ smb3_crypto_aead_allocate(struct TCP_Server_Info *server)
 
 	return 0;
 }
+
+/*
+ * Allocate the context info needed for the encryption operation, along with a
+ * scatterlist to point to the buffer.
+ */
+static void *smb2_aead_req_alloc_new(struct crypto_aead *tfm, const struct iov_iter *iter,
+				 u8 **iv,
+				 struct aead_request **req, struct sg_table *sgt,
+				 unsigned int *num_sgs, size_t *sensitive_size)
+{
+	unsigned int req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
+	unsigned int iv_size = crypto_aead_ivsize(tfm);
+	unsigned int len;
+	u8 *p;
+
+	*num_sgs = iov_iter_npages(iter, INT_MAX);
+
+	len = iv_size;
+	len += crypto_aead_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
+	len = ALIGN(len, crypto_tfm_ctx_alignment());
+	len += req_size;
+	len = ALIGN(len, __alignof__(struct scatterlist));
+	len += array_size(*num_sgs + 2, sizeof(struct scatterlist));
+	*sensitive_size = len;
+
+	p = kvzalloc(len, GFP_NOFS);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	*iv = (u8 *)PTR_ALIGN(p, crypto_aead_alignmask(tfm) + 1);
+	*req = (struct aead_request *)PTR_ALIGN(*iv + iv_size,
+						crypto_tfm_ctx_alignment());
+	sgt->sgl = (struct scatterlist *)PTR_ALIGN((u8 *)*req + req_size,
+						   __alignof__(struct scatterlist));
+	return p;
+}
+
+/*
+ * Set up for doing a crypto operation, building a scatterlist from the
+ * supplied iterator.
+ */
+static void *smb2_get_aead_req_new(struct crypto_aead *tfm, const struct iov_iter *iter,
+				   const u8 *sig, u8 **iv,
+				   struct aead_request **req, struct scatterlist **sgl,
+				   size_t *sensitive_size)
+{
+	struct sg_table sgtable = {};
+	struct iov_iter tmp = *iter;
+	unsigned int num_sgs;
+	ssize_t rc;
+	void *p;
+
+	p = smb2_aead_req_alloc_new(tfm, iter, iv, req, &sgtable,
+				    &num_sgs, sensitive_size);
+	if (IS_ERR(p))
+		return ERR_CAST(p);
+
+	sg_init_marker(sgtable.sgl, num_sgs + 2);
+
+	rc = extract_iter_to_sg(&tmp, iov_iter_count(iter), &sgtable, num_sgs, 0);
+	sgtable.orig_nents = sgtable.nents + 1;
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	cifs_sg_set_buf(&sgtable, sig, SMB2_SIGNATURE_SIZE);
+	sg_mark_end(&sgtable.sgl[sgtable.nents - 1]);
+	*sgl = sgtable.sgl;
+	return p;
+}


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AB4E3797
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186274; cv=none; b=Glh/79QLEMnlWh4DfrK90427jFCc6+gehRohpirksW9lW9winqgHMMBDfeWLujVAvTFu7Owb68MsHMefvrMQieacFXaEntqSpGUr1p30Ee1GqFkoBMjb7Ptn7b5w4W3AXiE6vcJIO1pyLiZ8p0hr3c7pOKtEZFHwnYwEnGPSXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186274; c=relaxed/simple;
	bh=gfaJzP289xQ4kVltCiQEPXCysPdOpM4vpGCDTkaZPTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Gvkw781UXD2LGOKEBic9n81uxdOwzE5ujy/fB3FwcRg43th+rAEuttl4foe+SXM716V62OcVUm7TRcVNdFCKXPrCgNjFvHK1gtfA8hhT8yMgbhG9CV+MFvdNDot8+XNza2MGoL5G1IGCsjkOVonAHu5nSCez6+HdBCEiBmD6J/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rez7vJ2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rez7vJ2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REhYKVbaqGbxNcyNXrV0J0+0n1UmD1ysJbs6hLY9zMU=;
	b=Rez7vJ2fSwn8C4S7qXDyX0qWRQu//jTwOLEqvKJIZncJnHZmReKuCvQSEupbzAwnEEITgT
	CCtys3BzZc2WK9vq8fXLru3Hnr6ma6YkV2VEAGGJrx+w8xUPcO/Ucihv5E8UY+QRXP/wrr
	w0mb3BBk5ohLZitrAm7fGiFmyhREXEA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-jOkhW4KOOyiXzBGFFZBWHg-1; Tue,
 19 May 2026 06:24:31 -0400
X-MC-Unique: jOkhW4KOOyiXzBGFFZBWHg-1
X-Mimecast-MFC-AGG-ID: jOkhW4KOOyiXzBGFFZBWHg_1779186269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4333019560A2;
	Tue, 19 May 2026 10:24:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CA9C18001E9;
	Tue, 19 May 2026 10:24:25 +0000 (UTC)
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
Subject: [RFC PATCH 29/36] cifs: Convert SMB2 Tree Connect request
Date: Tue, 19 May 2026 11:21:47 +0100
Message-ID: <20260519102158.592165-30-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: D37_lnnbJV62KQwIL14uJuBcn42nUaPrlLE8YDIugFU_1779186269
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 76 ++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 082838e9c9b5..ea4108669e6c 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2365,57 +2365,44 @@ int
 SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	  struct cifs_tcon *tcon, const struct nls_table *cp)
 {
-	struct smb_rqst rqst;
+	struct TCP_Server_Info *server = cifs_pick_channel(ses);
 	struct smb2_tree_connect_req *req;
 	struct smb2_tree_connect_rsp *rsp = NULL;
-	struct kvec iov[2];
-	struct kvec rsp_iov = { NULL, 0 };
-	int rc = 0;
-	int resp_buftype;
-	int unc_path_len;
-	__le16 *unc_path = NULL;
+	struct smb_message *smb = NULL;
+	int unc_path_size;
 	int flags = 0;
-	unsigned int total_len;
-	struct TCP_Server_Info *server = cifs_pick_channel(ses);
+	int rc = 0;
 
 	cifs_dbg(FYI, "TCON\n");
 
 	if (!server || !tree)
 		return smb_EIO(smb_eio_trace_null_pointers);
 
-	unc_path = kmalloc(MAX_SHARENAME_LENGTH * 2, GFP_KERNEL);
-	if (unc_path == NULL)
-		return -ENOMEM;
-
-	unc_path_len = cifs_strtoUTF16(unc_path, tree, strlen(tree), cp);
-	if (unc_path_len <= 0) {
-		kfree(unc_path);
-		return -EINVAL;
-	}
-	unc_path_len *= 2;
+	unc_path_size = cifs_size_strtoUTF16(tree, INT_MAX, cp);
 
 	/* SMB2 TREE_CONNECT request must be called with TreeId == 0 */
 	tcon->tid = 0;
 	atomic_set(&tcon->num_remote_opens, 0);
-	rc = smb2_plain_req_init(SMB2_TREE_CONNECT, tcon, server,
-				 (void **) &req, &total_len);
-	if (rc) {
-		kfree(unc_path);
-		return rc;
-	}
+
+	smb = smb2_create_request(SMB2_TREE_CONNECT, server, tcon,
+				  sizeof(*req), sizeof(*req) + unc_path_size, 0,
+				  SMB2_REQ_DYNAMIC);
+	if (!smb)
+		return -ENOMEM;
+	req = smb->request;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	iov[0].iov_base = (char *)req;
-	/* 1 for pad */
-	iov[0].iov_len = total_len;
-
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req));
-	req->PathLength = cpu_to_le16(unc_path_len);
-	iov[1].iov_base = unc_path;
-	iov[1].iov_len = unc_path_len;
+	req->PathOffset = cpu_to_le16(smb->ext_offset);
+	req->PathLength = cpu_to_le16(unc_path_size);
+
+	rc = cifs_strtoUTF16(smb->request + smb->ext_offset, tree, strlen(tree), cp);
+	if (rc <= 0) {
+		rc = -EINVAL;
+		goto tcon_exit;
+	}
 
 	/*
 	 * 3.11 tcon req must be signed if not encrypted. See MS-SMB2 3.2.4.1.1
@@ -2429,22 +2416,21 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	    ((ses->user_name != NULL) || (ses->sectype == Kerberos)))
 		req->hdr.Flags |= SMB2_FLAGS_SIGNED;
 
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 2;
-
 	/* Need 64 for max size write so ask for more in case not there yet */
 	if (server->credits >= server->max_credits)
 		req->hdr.CreditRequest = cpu_to_le16(0);
 	else
 		req->hdr.CreditRequest = cpu_to_le16(
-			min_t(int, server->max_credits -
-			      server->credits, 64));
+			min_t(int, server->max_credits - server->credits, 64));
 
-	rc = cifs_send_recv(xid, ses, server,
-			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(req);
-	rsp = (struct smb2_tree_connect_rsp *)rsp_iov.iov_base;
+	iov_iter_bvec_queue(&smb->req_iter, ITER_SOURCE, &smb->bvecq, 0, 0,
+			    smb->data_offset);
+
+	smb->sr_flags = flags;
+	rc = smb_send_recv_messages(xid, ses, server, smb, flags);
+	smb_clear_request(smb);
+
+	rsp = (struct smb2_tree_connect_rsp *)smb->response;
 	trace_smb3_tcon(xid, tcon->tid, ses->Suid, tree, rc);
 	if ((rc != 0) || (rsp == NULL)) {
 		cifs_stats_fail_inc(tcon, SMB2_TREE_CONNECT_HE);
@@ -2491,9 +2477,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 		if (tcon->share_flags & SMB2_SHAREFLAG_ISOLATED_TRANSPORT)
 			server->nosharesock = true;
 tcon_exit:
-
-	free_rsp_buf(resp_buftype, rsp);
-	kfree(unc_path);
+	smb_put_messages(smb);
 	return rc;
 
 tcon_error_exit:


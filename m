Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A24EA379
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186283; cv=none; b=c6xMzAwolnrCUdH3Q+0jTkbmIiBhgsA9BEJ0n3z0pGDLx6n1djTs6A5Yi4MoEMiIa+eqyI2FvAXGn9EsFM0iwzAxgvV4fOeAiw/k8H8veW0KzIYsgiI9QdoklEGTWEztqPStGaDr6ixbFeOzpPz2fJAQWugSU0LP7iqd3yp+QHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186283; c=relaxed/simple;
	bh=6JHO7zGoYUv42IdTqmkY851r6tP6oZ8F9UnTfS+t70g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lo2KXAZqFvO8HPG73RyXnTXKrl3+C2HpZ15WvN6nIr3WBz4h21Mh0D4IJNFax5lwIpJoVpayySESsE4zICAMrdgpBWDrFLh8fVfnUVdW3Y2Bj6wfr9n4URKlqIpPSzOw8+YfKoRw89BpiqjZFaqpik4SQ+TtjlZUoSqBjK7YQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFd0Tvqb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFd0Tvqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1YgjwJ80TNUQ6YOR+omfLsLBjy7Grl2VNzSblRzWrw=;
	b=YFd0Tvqb1Z3fePKAFHVzFopxh/NcNpllbDsMNM/VVNZoskvWyHK3TuRIZPO3Q8rA41wWC+
	mTzEoFe+V+Bf5Wgf3YKgs1IWT5jUt1qGC3S8jXSxKmTRi0FYaXbVbcXD94r46QsaDnQSQe
	P5mqOvALh+hbL2Sde4DPiFbWjymk/3k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-LocKuVccNHyw2eqB6ifX0Q-1; Tue,
 19 May 2026 06:24:35 -0400
X-MC-Unique: LocKuVccNHyw2eqB6ifX0Q-1
X-Mimecast-MFC-AGG-ID: LocKuVccNHyw2eqB6ifX0Q_1779186274
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BAB8195609D;
	Tue, 19 May 2026 10:24:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8CF71800357;
	Tue, 19 May 2026 10:24:30 +0000 (UTC)
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
Subject: [RFC PATCH 30/36] cifs: Convert SMB2 Tree Disconnect request
Date: Tue, 19 May 2026 11:21:48 +0100
Message-ID: <20260519102158.592165-31-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: LAp-xmb4UgHJIErSA6gQR-xxxtPvwcLa5TdwH5FzTQk_1779186274
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
 fs/smb/client/smb2pdu.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ea4108669e6c..f0b39c77f8ae 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2489,16 +2489,12 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 int
 SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 {
-	struct smb_rqst rqst;
 	struct smb2_tree_disconnect_req *req; /* response is trivial */
-	int rc = 0;
+	struct smb_message *smb = NULL;
 	struct cifs_ses *ses = tcon->ses;
 	struct TCP_Server_Info *server = cifs_pick_channel(ses);
 	int flags = 0;
-	unsigned int total_len;
-	struct kvec iov[1];
-	struct kvec rsp_iov;
-	int resp_buf_type;
+	int rc = 0;
 
 	cifs_dbg(FYI, "Tree Disconnect\n");
 
@@ -2516,33 +2512,29 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 
 	invalidate_all_cached_dirs(tcon, true);
 
-	rc = smb2_plain_req_init(SMB2_TREE_DISCONNECT, tcon, server,
-				 (void **) &req,
-				 &total_len);
-	if (rc)
-		return rc;
+	smb = smb2_create_request(SMB2_TREE_DISCONNECT, server, tcon,
+				  sizeof(*req), sizeof(*req), 0,
+				  SMB2_REQ_DYNAMIC);
+	if (!smb)
+		return -ENOMEM;
+	req = smb->request;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	flags |= CIFS_NO_RSP_BUF;
-
-	iov[0].iov_base = (char *)req;
-	iov[0].iov_len = total_len;
-
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 1;
+	iov_iter_bvec_queue(&smb->req_iter, ITER_SOURCE, &smb->bvecq, 0, 0,
+			    smb->data_offset);
 
-	rc = cifs_send_recv(xid, ses, server,
-			    &rqst, &resp_buf_type, flags, &rsp_iov);
-	cifs_small_buf_release(req);
+	smb->sr_flags = flags;
+	rc = smb_send_recv_messages(xid, ses, server, smb, flags);
+	smb_clear_request(smb);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_TREE_DISCONNECT_HE);
 		trace_smb3_tdis_err(xid, tcon->tid, ses->Suid, rc);
 	}
 	trace_smb3_tdis_done(xid, tcon->tid, ses->Suid);
 
+	smb_put_messages(smb);
 	return rc;
 }
 


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFB4E3796
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186272; cv=none; b=sAQQjlFEoXD9bpAyosHF5O5CjapAKv4wCMHelpoKl+G2lhJ04XFpLYpg1GuCuRqE4vDZcryDVZyJynaLGUjxlyg29tRH/KkoWtQgoweu4kMKYVPUndMQlXMZRNl1pVcgPV8Lxjq3gLQUCz0hqAl02Rez4j61Z6gQwLj6rYbTpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186272; c=relaxed/simple;
	bh=3FEUUFTwoFMyfy/lg9qZ/s0+P0PCw5O4toikTojGW5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Oxu685ADXlWyobg2F6Ialk7bdhttzgVTHPoeFTBwY2NES7+dt6+3BaDHGQIwSWgXnvi60wridduOuBE3FWGDLWAMt3QseAqEtgGM9tJmE003wL6yjrAypWM47ymjAx2naCifSbgSzjDlGtgXqjmuaQXH42mW7EtvBaggKp/bIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A22HRL7l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A22HRL7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCeork960z2+9owO0TXHybI/uw7l2vxljckiO5ink50=;
	b=A22HRL7lzZVX7/7E7yimhRxBhMp9sOVVUJj2BzDcQWat+qtpoLwslx7URXR/s95OWhqruw
	PPrEjLii475j7uSSKIn0pRnTauc7HuA3KyeB+NRd+3oKc0oMg0xICCsgq5kf1A6SG1fUEn
	H2yM/hBTi2423fkJO+O2ZfefwGMfdsk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-05oFebFIPf6Qu26JNQ56_Q-1; Tue,
 19 May 2026 06:24:26 -0400
X-MC-Unique: 05oFebFIPf6Qu26JNQ56_Q-1
X-Mimecast-MFC-AGG-ID: 05oFebFIPf6Qu26JNQ56_Q_1779186264
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B682195609F;
	Tue, 19 May 2026 10:24:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 410AF1956053;
	Tue, 19 May 2026 10:24:21 +0000 (UTC)
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
Subject: [RFC PATCH 28/36] cifs: Convert SMB2 Logoff request
Date: Tue, 19 May 2026 11:21:46 +0100
Message-ID: <20260519102158.592165-29-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: TZusb2Vor98ucwSHTn8JQk-_Elfx3pch1--tZ5HIy60_1779186264
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
 fs/smb/client/smb2pdu.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4dd4f2de39f4..082838e9c9b5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2298,15 +2298,10 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
 int
 SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
 {
-	struct smb_rqst rqst;
-	struct smb2_logoff_req *req; /* response is also trivial struct */
-	int rc = 0;
 	struct TCP_Server_Info *server;
-	int flags = 0;
-	unsigned int total_len;
-	struct kvec iov[1];
-	struct kvec rsp_iov;
-	int resp_buf_type;
+	struct smb2_logoff_req *req; /* response is also trivial struct */
+	struct smb_message *smb = NULL;
+	int rc = 0, flags = 0;
 
 	cifs_dbg(FYI, "disconnect session %p\n", ses);
 
@@ -2322,10 +2317,11 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
 	}
 	spin_unlock(&ses->chan_lock);
 
-	rc = smb2_plain_req_init(SMB2_LOGOFF, NULL, ses->server,
-				 (void **) &req, &total_len);
-	if (rc)
-		return rc;
+	smb = smb2_create_request(SMB2_LOGOFF, server, NULL,
+				  sizeof(*req), sizeof(*req), 0, 0);
+	if (!smb)
+		return -ENOMEM;
+	req = smb->request;
 
 	 /* since no tcon, smb2_init can not do this, so do here */
 	req->hdr.SessionId = cpu_to_le64(ses->Suid);
@@ -2335,23 +2331,17 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
 	else if (server->sign)
 		req->hdr.Flags |= SMB2_FLAGS_SIGNED;
 
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
 
-	rc = cifs_send_recv(xid, ses, ses->server,
-			    &rqst, &resp_buf_type, flags, &rsp_iov);
-	cifs_small_buf_release(req);
+	smb->sr_flags = flags;
+	rc = smb_send_recv_messages(xid, ses, ses->server, smb, flags);
 	/*
 	 * No tcon so can't do
 	 * cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_fail[SMB2...]);
 	 */
 
+	smb_put_messages(smb);
 smb2_session_already_dead:
 	return rc;
 }


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B42D3A60
	for <netfs@lists.linux.dev>; Wed,  6 Aug 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512767; cv=none; b=cOdp+n2yi4UH794NqjJxOHlUtd2E6xtLUucbGZngC7pO8idAn5p2v9LL5lIG9ckhil2iFMSIvXQZIrpZ54VJZoVEvLsFt0cabaLyC/OkPBQ3V0RQpGoH5QwbtxG7dD8GeRCSuthbZ2+7CPjwC76UstVz4/wmnZf3BCDn9FRz+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512767; c=relaxed/simple;
	bh=vdI+9J76+Cl2+uKmq0mv/gnrM8i3Q2sgMJ9yHiTjJLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2DVmNI/dp5RlYaQghlo1QFir31APjCteP8r1w6BQDTIupPN/SUYNoMwk//iKiDS6lqluq2MvfewXWhA7sr/0seYsq92zohwPWPNwPW5vMiAIer5D8Qos9L/h4JRVoX9vRXlvApUR1IhlaSoRBzDko0UoouanacQ3+VbCnF0XIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Awlt7PqS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Awlt7PqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TviJ0wsdbXIbz3z58i/ZtA4k4O1wXNxFsbxV+K9WGqo=;
	b=Awlt7PqSIw3XglvgkQ8kzRidnJYWD+gafQhL9B+Uh+0rtx0UVu/IXvsLRz8mcbVfhkiSvl
	VsBi5JaraxUu/7xyhPT2OPO/lN8rKCjTrGj14QVh6qvY2Tc02CZybZxAYex3XmH7fp++wq
	zM8Xr7YF3oeFraT3dRTkzJ4KkdHy1+w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-MtxQM8lUNAW7Tfx7OKc4Zw-1; Wed,
 06 Aug 2025 16:39:23 -0400
X-MC-Unique: MtxQM8lUNAW7Tfx7OKc4Zw-1
X-Mimecast-MFC-AGG-ID: MtxQM8lUNAW7Tfx7OKc4Zw_1754512760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49B6C1800446;
	Wed,  6 Aug 2025 20:39:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 449053000198;
	Wed,  6 Aug 2025 20:39:17 +0000 (UTC)
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
Subject: [RFC PATCH 26/31] cifs: Convert SMB2 Logoff request
Date: Wed,  6 Aug 2025 21:36:47 +0100
Message-ID: <20250806203705.2560493-27-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 685af9c0cdcb..c63c62cd6638 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2212,15 +2212,10 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
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
 
@@ -2237,10 +2232,10 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
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
 
 	 /* since no tcon, smb2_init can not do this, so do here */
 	req->hdr.SessionId = cpu_to_le64(ses->Suid);
@@ -2252,21 +2247,13 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
 
 	flags |= CIFS_NO_RSP_BUF;
 
-	iov[0].iov_base = (char *)req;
-	iov[0].iov_len = total_len;
-
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 1;
-
-	rc = cifs_send_recv(xid, ses, ses->server,
-			    &rqst, &resp_buf_type, flags, &rsp_iov);
-	cifs_small_buf_release(req);
+	rc = smb_send_recv_messages(xid, ses, ses->server, smb, flags);
 	/*
 	 * No tcon so can't do
 	 * cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_fail[SMB2...]);
 	 */
 
+	smb_put_messages(smb);
 smb2_session_already_dead:
 	return rc;
 }


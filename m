Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19402D1901
	for <netfs@lists.linux.dev>; Wed,  6 Aug 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512738; cv=none; b=AShYrS8MK3q9MxM6Zs7znbhZLYW73y72ZtQiL1iT44oToMupeY6SNO38nWDKIeKon1N4B4aVEfgd7kLn7nawcHW+Pqo6UHG+wGF0Jj/1xf3GuCvv1tv22aTEcDPo9aCiDJuAxYuA+99KG7RPKKjmzhI6WZ0qYGDI+iUS3JFhnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512738; c=relaxed/simple;
	bh=sGkIqwI4kKVf31IFHCvik9vYPq7stY3n3/q2f/ete+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWe5jkBLP921axj7gKXwVirBXqtyIqfu1CZzcrjAccHba6yl2uiJTpC3Ms9/QIOumjTuh5oOOD6qRE+E2cyowX67gBfwUePzLR5jXzNRs3oiB+xVPMMukOSk5Vx0ytFP1IoD+Xkt9JzZRTF4Hn0upKGiDaKzvpSbipqk2+IetpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNZgumiz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNZgumiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWFEygVcswswekGUvxP15RMRYsPo7UmyYBIY6DSNdhI=;
	b=KNZgumizAZ6tkwlmtawrvdtapforvMBV3cW5rIE33ao8HGPTAvPxsinqcuH1cV/jg+/gMh
	B/4bOYcdvXGfu8ZI1GBgrARtGO+ZPBvw4lVzllw84eItNZlEKSrb+SysL0Wk0uurHLEjpb
	6YVH2ER3xWoVHpxb6U/O/DJEbwQKUfI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-qk4wtJRiN2m4hgjIOSmZxw-1; Wed,
 06 Aug 2025 16:38:54 -0400
X-MC-Unique: qk4wtJRiN2m4hgjIOSmZxw-1
X-Mimecast-MFC-AGG-ID: qk4wtJRiN2m4hgjIOSmZxw_1754512732
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24DA2195608C;
	Wed,  6 Aug 2025 20:38:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 130C91800447;
	Wed,  6 Aug 2025 20:38:48 +0000 (UTC)
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
Subject: [RFC PATCH 20/31] cifs: Don't need state locking in smb2_get_mid_entry()
Date: Wed,  6 Aug 2025 21:36:41 +0100
Message-ID: <20250806203705.2560493-21-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There's no need to get ->srv_lock or ->ses_lock in smb2_get_mid_entry() as
all that happens of relevance (to the lock) inside the locked sections is
the reading of one status value in each.

Replace the locking with READ_ONCE() and use a switch instead of a chain of
if-statements.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2transport.c | 46 +++++++++++++++--------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 7c60584a8544..7194082bb5ac 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -769,43 +769,35 @@ static int
 smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb_message *smb)
 {
-	spin_lock(&server->srv_lock);
-	if (server->tcpStatus == CifsExiting) {
-		spin_unlock(&server->srv_lock);
+	switch (READ_ONCE(server->tcpStatus)) {
+	case CifsExiting:
 		return -ENOENT;
-	}
-
-	if (server->tcpStatus == CifsNeedReconnect) {
-		spin_unlock(&server->srv_lock);
+	case CifsNeedReconnect:
 		cifs_dbg(FYI, "tcp session dead - return to caller to retry\n");
 		return -EAGAIN;
+	case CifsNeedNegotiate:
+		if (smb->command_id != SMB2_NEGOTIATE)
+			return -EAGAIN;
+		break;
+	default:
+		break;
 	}
 
-	if (server->tcpStatus == CifsNeedNegotiate &&
-	    smb->command_id != SMB2_NEGOTIATE) {
-		spin_unlock(&server->srv_lock);
-		return -EAGAIN;
-	}
-	spin_unlock(&server->srv_lock);
-
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_NEW) {
+	switch (READ_ONCE(ses->ses_status)) {
+	case SES_NEW:
 		if (smb->command_id != SMB2_SESSION_SETUP &&
-		    smb->command_id != SMB2_NEGOTIATE) {
-			spin_unlock(&ses->ses_lock);
+		    smb->command_id != SMB2_NEGOTIATE)
 			return -EAGAIN;
-		}
-		/* else ok - we are setting up session */
-	}
-
-	if (ses->ses_status == SES_EXITING) {
-		if (smb->command_id != SMB2_LOGOFF) {
-			spin_unlock(&ses->ses_lock);
+			/* else ok - we are setting up session */
+		break;
+	case SES_EXITING:
+		if (smb->command_id != SMB2_LOGOFF)
 			return -EAGAIN;
-		}
 		/* else ok - we are shutting down the session */
+		break;
+	default:
+		break;
 	}
-	spin_unlock(&ses->ses_lock);
 
 	smb2_init_mid(smb, server);
 


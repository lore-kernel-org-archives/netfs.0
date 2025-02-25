Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FB19CD16
	for <netfs@lists.linux.dev>; Tue, 25 Feb 2025 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522311; cv=none; b=Iuft8f3vigVSRPmiTp0oX5makaXEze3bk0/R+EkKTpPuDhOIPF341f3x4j1rLJeeq48hu0hrp5ZHNgu2WcVAC5FBZsTH/7W2Gq73tP7poiWk1NZfReji3YOVkOlSoDaAnHzpUPiEciSNFwV0Y1iHbxkMwRc+cGAZRGxZuJQThX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522311; c=relaxed/simple;
	bh=KXlYWUh3jzPsB3e6Jub6qaBP9V1vHUn0C3CMX0MeeIA=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=PS5s9TEhKRi+uEl+MqK4UUBu/XZHnGt+67lNsFE2h1GkFi8+xg82sOtCF3C5/PMbgwH5HePd5n3hneJ+8vlrwMrIjxCW9b7l+tDeOrjvKPdNNQieq3k5RVhppscuYtfuTgjK1jhAy7cP4FqufXLA5UWorsmOCYikDQ5K1ZwgGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw5iBDY8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw5iBDY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UdIY4LA/abxDdip0z8MCHMGQUxuNsPZqkPtoJHXgADk=;
	b=dw5iBDY8rN0W27ivwV+7Uo7rllAtMYy1ZEj4EC78BLttG6MoB+WdaqH42EpmaxGoS9Jy6N
	bBkYy5e6y2vvdJs7T2A1QZA6Rh7bKM24JMHeDAcBkT8CLDcKvebLRpKkfQpbfgveV4kz8c
	vxLlXeIK01alo8rKr4SZeEz4anQcBgU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-KCqN38PhMoK0Y7O-N8DGsw-1; Tue,
 25 Feb 2025 17:25:06 -0500
X-MC-Unique: KCqN38PhMoK0Y7O-N8DGsw-1
X-Mimecast-MFC-AGG-ID: KCqN38PhMoK0Y7O-N8DGsw_1740522304
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6868319560B5;
	Tue, 25 Feb 2025 22:25:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8663E19560AE;
	Tue, 25 Feb 2025 22:25:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>,
    Jean-Christophe Guillain <jean-christophe@guillain.net>
cc: dhowells@redhat.com, Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix the smb1 readv callback to correctly call netfs
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Feb 2025 22:25:00 +0000
Message-ID: <2433838.1740522300@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

=20=20=20=20
Fix cifs_readv_callback() to call netfs_read_subreq_terminated() rather
than queuing the subrequest work item (which is unset).  Also call the
I/O progress tracepoint.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use o=
ne work item")
Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219793
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Pali Roh=C3=A1r <pali@kernel.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifssmb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6a3e287eabfa..bf9acea53ccb 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1338,7 +1338,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	rdata->credits.value =3D 0;
 	rdata->subreq.error =3D rdata->result;
 	rdata->subreq.transferred +=3D rdata->got_bytes;
-	queue_work(cifsiod_wq, &rdata->subreq.work);
+	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
+	netfs_read_subreq_terminated(&rdata->subreq);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }


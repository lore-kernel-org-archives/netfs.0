Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A82DFF0D
	for <netfs@lists.linux.dev>; Thu, 26 Jun 2025 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941191; cv=none; b=rTbne7I6cECN7KU2kGkwGqUE0iNHXUi8JPxXyxHoy+B2tI0AbPpjJZyYjsNh6o39K94KhCPRDpR8y1TsMm+vM5Aaw93FzpQh+VsS/fIAZJmm3zNfQSoEwabbciY6lI96orEJ99duQUO25Du/mLX2lHxPuGWoJJCTAf4+IM2NE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941191; c=relaxed/simple;
	bh=TNxO08g3nGwcINU9tC8Du4+HJDugCYMa+TBRO+/qubk=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=VjlKtLNfU/JOX7vI7eLywb/W/zGnJHAWHgBdJBD9gxo1yztZ/KFuNrBP7gtQDZv6Bc6OljkZrHaw7grGuekN7mhextc8X1jP5p+furW+MQtCE98pe8Pvu6S1txc1CypvqY1Y3BQw5jvf5xxxmD/Eaz/0rQvnVsjrrtKFayMiGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfVrmXJ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfVrmXJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SaxeI8dVFbdPy7Oeogr3X1YKrvcFfXCXft8XqWAi0yw=;
	b=AfVrmXJ/wI8urfktQsv3U8URlePf1oNd2HjIucKzKUCmZZllSS/wGVy2g0826uRdhB2WxU
	aFtcc9QqI2INxoRe2BAU1EaR0o9komQvYEJHY19kPFdbMzrk4Zc/0WTAYe1URhMG0pJg7M
	w/cuUa+9bjTk6o5qfJoFMvfP9Az/sZE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-nK4cVNAkNcGnKhsvtdkpOw-1; Thu,
 26 Jun 2025 08:33:07 -0400
X-MC-Unique: nK4cVNAkNcGnKhsvtdkpOw-1
X-Mimecast-MFC-AGG-ID: nK4cVNAkNcGnKhsvtdkpOw_1750941185
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D0CC191DB6F;
	Thu, 26 Jun 2025 12:33:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36AAC30002ED;
	Thu, 26 Jun 2025 12:32:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
    Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix i_size updating
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1576469.1750941177.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jun 2025 13:32:57 +0100
Message-ID: <1576470.1750941177@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix the updating of i_size, particularly in regard to the completion of DI=
O
writes and especially async DIO writes by using a lock.

The bug is triggered occasionally by the generic/207 xfstest as it chucks =
a
bunch of AIO DIO writes at the filesystem and then checks that fstat()
returns a reasonable st_size as each completes.

The problem is that netfs is trying to do "if new_size > inode->i_size,
update inode->i_size" sort of thing but without a lock around it.

This can be seen with cifs, but shouldn't be seen with kafs because kafs
serialises modification ops on the client whereas cifs sends the requests
to the server as they're generated and lets the server order them.

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c |    2 ++
 fs/netfs/direct_write.c   |    8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 72a3e6db2524..b87ef3fe4ea4 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -64,6 +64,7 @@ static void netfs_update_i_size(struct netfs_inode *ctx,=
 struct inode *inode,
 		return;
 	}
 =

+	spin_lock(&inode->i_lock);
 	i_size_write(inode, pos);
 #if IS_ENABLED(CONFIG_FSCACHE)
 	fscache_update_cookie(ctx->cache, NULL, &pos);
@@ -77,6 +78,7 @@ static void netfs_update_i_size(struct netfs_inode *ctx,=
 struct inode *inode,
 					DIV_ROUND_UP(pos, SECTOR_SIZE),
 					inode->i_blocks + add);
 	}
+	spin_unlock(&inode->i_lock);
 }
 =

 /**
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c0797d6c72c9..9df297a555f1 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -14,13 +14,17 @@ static void netfs_cleanup_dio_write(struct netfs_io_re=
quest *wreq)
 	struct inode *inode =3D wreq->inode;
 	unsigned long long end =3D wreq->start + wreq->transferred;
 =

-	if (!wreq->error &&
-	    i_size_read(inode) < end) {
+	if (wreq->error || end <=3D i_size_read(inode))
+		return;
+
+	spin_lock(&inode->i_lock);
+	if (end > i_size_read(inode)) {
 		if (wreq->netfs_ops->update_i_size)
 			wreq->netfs_ops->update_i_size(inode, end);
 		else
 			i_size_write(inode, end);
 	}
+	spin_unlock(&inode->i_lock);
 }
 =

 /*


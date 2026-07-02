Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1642642F
	for <netfs@lists.linux.dev>; Thu,  2 Jul 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980713; cv=none; b=sobey/xEMLTSwFE6KEOqXPmnG/DYkbPVIuB4IVxzwMMvgc8zKVTsHpMEg8VK2b/yAm8l9HKKRj4b4LxhqC8tApN0hCeDsVaaX0/uH0qGl/4m2cWpuAosl6MzgqRQD6HU2PqEh3V1foyOh7KL/hDMc5cvC3/c0xJzKy2LkDnU/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980713; c=relaxed/simple;
	bh=rmB5IbYmMaIDRAVGJyWKAHqzIbsCZYxcyGrV2/B6Xjk=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=bthf5CzEgF7042ZI5RJS7+872swGUHzNK9hLedMPBiWmAlbbgJuX+MtCPiW+7U4Fgykylo+Q6k7LgurlyAU6asaHu6toFT+tU9Qn7m6F2Hs7uAiHZhRKUOnwG191RwsVBWSaVpap3L5+fbGA3/+ofkJk4PR5s1usEZgc6Niv2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STGR+wzn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STGR+wzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782980709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=borYit/DyP6U+x/zzyQDvm4N165avEr3gF7FZODU+/Y=;
	b=STGR+wznKBTeXJBKXOAbgZ58nXKJuKNziab1kplpNI7DIE0MhTp57MjcBYTnO/ncpVD/zF
	eJqdmiq2dPiFIfMzzona7zWhlW6Ai/ATyUF96PxTee39GeB+KOW0/rsTwfloF3sHeptxbn
	HxoROTsmkA+YqbgnaIPGetZtAlb0psg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-GvQoMCS9OW2t6w5xa65nAA-1; Thu,
 02 Jul 2026 04:25:06 -0400
X-MC-Unique: GvQoMCS9OW2t6w5xa65nAA-1
X-Mimecast-MFC-AGG-ID: GvQoMCS9OW2t6w5xa65nAA_1782980704
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 814A719541A5;
	Thu,  2 Jul 2026 08:25:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BA2F3001D87;
	Thu,  2 Jul 2026 08:25:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix missing credit release on failure in cifs_issue_read()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 09:25:00 +0100
Message-ID: <138902.1782980700@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: QBJQi8xtyVeo9HfSwtI_yrJRRk3HHBtaPPPXkMFZcrE_1782980704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <138901.1782980700.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Fix missing release of credits in the failure path in cifs_issue_read()
lest retrying the subreq just overwrites the credits value.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40red=
hat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/file.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 8b25d6c9ec5e..5a25635bc62a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -241,6 +241,7 @@ static void cifs_issue_read(struct netfs_io_subrequest =
*subreq)
 =09return;
=20
 failed:
+=09add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
 =09subreq->error =3D rc;
 =09netfs_read_subreq_terminated(subreq);
 }


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF4388E43
	for <netfs@lists.linux.dev>; Sat, 25 Apr 2026 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777102348; cv=none; b=tgFZkAt+cUF2vSEefPV95vWuzAP0U6+7jpcsuMrPl1vmGEOTadLRJTMvORcDpUdAwkJ+hdQD0HQvnM19U1Xx5AYX37hW8etPufgacNYG1wjmddExTwq/3nyCIeITgoQcc3VYXl/AbXWH3JmnSacRGB4zdb5bIV5zRt0m5zShhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777102348; c=relaxed/simple;
	bh=y32nYLTk0UfM44gNYYnWDQb7s5+ig3q3E6F5/3ZZLBo=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=KwVyf6aGeygtS1ya5eRFY4fon8i2bZjagRvvnkkVutB2wdgPCVHgabSDtjFdcKj2W/7Jpg0Y/MRwiflMQJy2tAAF7vbk+RUR/KgGEEH7JyZErnc7VUURxH4lEeMFg+vCT/aLdjw+0XvxhTQRP4llBl+2nMtUBVrXC6DY4wyxp40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhWP3AeD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhWP3AeD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777102345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kCPzgxNONlk0wGV1iInk9bbC6BXgWWpBNwud2RQfBVM=;
	b=LhWP3AeD1xYRoHt+uIrELtm1+Mf0qrsJTOVNbN3Pw9Z5m2BJKGY6d5NHb35EV0vhnCOADT
	km3BSgccrJ+2QVd6PaF2zHjDCDXF+5PnOw0ySU8oymy1SaZ0Twf597qPoZUNYwQhKDbDm9
	WtAU8ybE1LD1k6TM1TyAH1zvhqS1vuc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Y-xCKVZrPAimNIw5vkrq9Q-1; Sat,
 25 Apr 2026 03:32:21 -0400
X-MC-Unique: Y-xCKVZrPAimNIw5vkrq9Q-1
X-Mimecast-MFC-AGG-ID: Y-xCKVZrPAimNIw5vkrq9Q_1777102340
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB57B1800451;
	Sat, 25 Apr 2026 07:32:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90AEE180047F;
	Sat, 25 Apr 2026 07:32:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix wrong sort of request put in error handling
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 25 Apr 2026 08:32:15 +0100
Message-ID: <3643632.1777102335@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: oHWx48UbOZMPsyHk78py1wba2ltQsImECjIqxagmH5I_1777102340
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3643631.1777102335.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

   =20
Fix netfs_write_begin() to call netfs_put_request(), not
netfs_put_failed_request(), if it has already tried to dispatch the
request.

Fixes: 453f1cc34a8f ("netfs: Fix leak of request in netfs_write_begin() err=
or handling")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 5c78ec14e46b..7e7dacded8f7 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -693,9 +693,9 @@ int netfs_write_begin(struct netfs_inode *ctx,
=20
 =09netfs_read_to_pagecache(rreq, NULL);
 =09ret =3D netfs_wait_for_read(rreq);
-=09if (ret < 0)
-=09=09goto error_put;
 =09netfs_put_request(rreq, netfs_rreq_trace_put_return);
+=09if (ret < 0)
+=09=09goto error;
=20
 have_folio:
 =09ret =3D folio_wait_private_2_killable(folio);


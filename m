Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2F3093B5
	for <netfs@lists.linux.dev>; Tue, 24 Mar 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391747; cv=none; b=R7ueGy0WDDn6ae+wRh8FxCVEEY29v3Fvm5YOgMAOLro+V30KkgmiJbgZdWgYlqnV2VlAsbdZlGHOBSDD6QB5i4HuwsWQEUZbeUu1apcvKu5c1in51PLkErox8VVaU70yKDwh1JvayfahehUBKQ0Jo0/OdbMEzW09Xo0pAWRtvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391747; c=relaxed/simple;
	bh=gjC0wpGdJzJJtpXbbR+A6E8VNsLEQdhYs5fvmSyZkwA=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=UZX7Cvh/d1fjxmFfW7R93Pi7AqFqjaG/0V49G6MIWoH7I+Zm9R6L8VjxOKLhgwqxc4tSb4KS5iuk1vZ+q+2sU+6BXDQAfsCPp1N1KDWRLVR9AXtYVdroqcz2i8P66YCkw5Qyl5neTfavZXACyU1A6MBVZuaHxNxDUEs2JygquTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icopLC+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icopLC+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774391744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g6tF+FubtVeJtkCphmtYJp22Q80q/vz5mfrtNJ499B4=;
	b=icopLC+mlGDV7WCW385F0zKeHVepZ7xX9lknwIhz4lKb3QQ2jY+MuWPtwrIM2NsejTLHBD
	45XXNSyOugAQ0f8xvVDs5Wn/Bv8loVc2yk22k4wIMx+JiHeTMvfk8gMk4oUxPHzUMjB+EK
	9hs9CQx2eIEgTc1+GIewsCy0xZbS8OI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-ag2Lx6GnPvqaE9ND_lyU9A-1; Tue,
 24 Mar 2026 18:35:41 -0400
X-MC-Unique: ag2Lx6GnPvqaE9ND_lyU9A-1
X-Mimecast-MFC-AGG-ID: ag2Lx6GnPvqaE9ND_lyU9A_1774391740
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8C619560AF;
	Tue, 24 Mar 2026 22:35:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3DF51955D71;
	Tue, 24 Mar 2026 22:35:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: NeilBrown <neil@brown.name>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 24 Mar 2026 22:35:29 +0000
Message-ID: <4001609.1774391729@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: gK99vn9S8xWxqrC7FSlZMLOr_Tb_meRldOoF85XtCS0_1774391740
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4001607.1774391727.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

When cachefiles_cull() calls cachefiles_bury_object(), the latter eats the
former's ref on the victim dentry that it obtained from
cachefiles_lookup_for_cull().  However, commit 7bb1eb45e43c left the dput
of the victim in place, resulting in occasional:

  WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7: cachefilesd/11=
831
  cachefiles_cull+0x8c/0xe0 [cachefiles]
  cachefiles_daemon_cull+0xcd/0x120 [cachefiles]
  cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]
  vfs_write+0xc3/0x480
  ...

reports.

Fix this by removing the dput().

Fixes: 7bb1eb45e43c ("VFS: introduce start_removing_dentry()")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: NeilBrown <neil@brown.name>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index bdac2f33edf3..e2023e78e4df 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -795,7 +795,6 @@ int cachefiles_cull(struct cachefiles_cache *cache, str=
uct dentry *dir,
=20
 =09ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
 =09=09=09=09     FSCACHE_OBJECT_WAS_CULLED);
-=09dput(victim);
 =09if (ret < 0)
 =09=09goto error;
 


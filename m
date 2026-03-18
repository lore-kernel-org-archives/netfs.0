Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A008318121
	for <netfs@lists.linux.dev>; Wed, 18 Mar 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848348; cv=none; b=tT272qsuWAYBGJ9PGAjSMBJnpoql0Qm7oUiPFICtPk4GNZU76U+a2K02x+LIP3U3n9lt5lQdelu8h+X/ymA5p257EM0lVCqYOZ5ilstXol14w/XtTkGlLGxisyOGKaxjU4wrCYgcciWbh1yQgSmxmFDno4K2mFf2h07tuJ7lKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848348; c=relaxed/simple;
	bh=zBc7VlqUnSQ7Q6Jvh9Wuv5em/qzDLr+kdHPHMcJN+Kk=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=CINrZHAn3AoCrMCoVX6vu2t26mZzZym4EMvTWtLFq9X7ZEuiEP/etV0r0VJGChT3Eg7U8sNYkKPaJ6gvpWShXQcBOYcG72zsAzK2/9/RjgGcnTWJJ+w6OnNatdNgNFKBeehN7xcq7GUyUeFR8o3Q8YmTF3T7bRe6kpgzpVCjZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJCs2kfQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJCs2kfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773848344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQKZWrT7kB/E56xO60M3li10QvByyYTA7luf7jz47no=;
	b=CJCs2kfQaKCWMVJEy+xdELYu+OiMJqt04P4t8/HjaUeC/eFXQexJBmLyAYnAak9onAxZ7e
	xcCyDzrZRRzDCAdr4yCVwcie4CZ8fzksz4iq+5fEfCrWEYI/1H56s8tWcDehUc1lbjMCfA
	7OTohcT0jnPtnilG6CZs+UCbjGJtAqI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-NU3tWpoQNM-MqZ28sFRZvQ-1; Wed,
 18 Mar 2026 11:39:02 -0400
X-MC-Unique: NU3tWpoQNM-MqZ28sFRZvQ-1
X-Mimecast-MFC-AGG-ID: NU3tWpoQNM-MqZ28sFRZvQ_1773848341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EF1F195609F;
	Wed, 18 Mar 2026 15:39:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 810161800107;
	Wed, 18 Mar 2026 15:38:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix read abandonment during retry
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 18 Mar 2026 15:38:58 +0000
Message-ID: <3775287.1773848338@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: lAuE9UjJ4JMJT0robHWaqpbPmSSdrghY-Dh6ke5Lxek_1773848341
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3775285.1773848338.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Under certain circumstances, all the remaining subrequests from a read
request will get abandoned during retry.  The abandonment process expects
the 'subreq' variable to be set to the place to start abandonment from, but
it doesn't always have a useful value (it will be uninitialised on the
first pass through the loop and it may point to a deleted subrequest on
later passes).

Fix the first jump to "abandon:" to set subreq to the start of the first
subrequest expected to need retry (which, in this abandonment case, turned
out unexpectedly to no longer have NEED_RETRY set).

Also clear the subreq pointer after discarding superfluous retryable
subrequests to cause an oops if we do try to access it.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 71a0c7ed163a..68fc869513ef 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -93,8 +93,10 @@ static void netfs_retry_read_subrequests(struct netfs_io=
_request *rreq)
 =09=09       from->start, from->transferred, from->len);
=20
 =09=09if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
-=09=09    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
+=09=09    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags)) {
+=09=09=09subreq =3D from;
 =09=09=09goto abandon;
+=09=09}
=20
 =09=09list_for_each_continue(next, &stream->subrequests) {
 =09=09=09subreq =3D list_entry(next, struct netfs_io_subrequest, rreq_link=
);
@@ -178,6 +180,7 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
 =09=09=09=09if (subreq =3D=3D to)
 =09=09=09=09=09break;
 =09=09=09}
+=09=09=09subreq =3D NULL;
 =09=09=09continue;
 =09=09}
 


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38A314D26
	for <netfs@lists.linux.dev>; Wed, 15 Apr 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251784; cv=none; b=f+r6j6a+hqD+yTq97XsnLv94ZAd4m4Bnr2YlO7wLpI727Xb7Ivkks62lTLr0VwkAcZhjYSJco/PJ7DySIVIFiU9GuzzGaOQ9Yk8JnCXq6lX+jUoQudJxrwbDpj1I/jjtcsXXHwXTQaYBb7/afeKp57XfGmoRKDskMXWuY5PuG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251784; c=relaxed/simple;
	bh=utVgaiTm/E19ew6y814MfR5Y5WEw0B4PK6RDGOm+Bhw=;
	h=From:To:Cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=Pe4br61s855EmBergjIA5Qm5QTnUZ30lX9TJZPyjaG9mQVj/UCIRUuxB9ajpbKGdfEUqZx6p3+PJBPe5PAYOkFagTLEhr4JSYjR7tlT+iEFLL71F/AZ/ZHEuM78v6uBL7e5Y5PWhaLGro5bSFQntd2n0RoDJR3oLcjlHVBlZEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWieU7tz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWieU7tz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776251782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7gu69aV3hMPlVmLl5likq9reNbuoiEnwZdDEscxzMaU=;
	b=LWieU7tzvYank3wbuXEq3eI2KVPRL2kaDtTCO3EvRQs0h0kfEvFUbieNF5Uldjv0d8mHsR
	mpC68paO06yhE6n3jm69yUW/HUJydf36yCAb/o8068cWBDv6COsyqg7nbFjhFptR3Xz0TY
	8w191Z/G6mvVnGcqPk8NDS0KOnNiIOw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-N87LYPymM8CIPtI7ZtY8Gw-1; Wed,
 15 Apr 2026 07:16:19 -0400
X-MC-Unique: N87LYPymM8CIPtI7ZtY8Gw-1
X-Mimecast-MFC-AGG-ID: N87LYPymM8CIPtI7ZtY8Gw_1776251777
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4C8B180057D;
	Wed, 15 Apr 2026 11:16:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.34.160])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62656180047F;
	Wed, 15 Apr 2026 11:16:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] netfs: Fix early put of sink folio in netfs_read_gaps()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 15 Apr 2026 12:16:10 +0100
Message-ID: <261128.1776251770@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 7rGSpBjsy_K49FfhoiGtct1TWGvG-XyJHVKKU4oP-Kc_1776251777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <261127.1776251770.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Fix netfs_read_gaps() to release the sink page it uses after waiting for
the request to complete.  The way the sink page is used is that an
ITER_BVEC-class iterator is created that has the gaps from the target folio
at either end, but has the sink page tiled over the middle so that a single
read op can fill in both gaps.

The bug was found by KASAN detecting a UAF on the generic/075 xfstest in
the cifsd kernel thread that handles reception of data from the TCP socket:

 BUG: KASAN: use-after-free in _copy_to_iter+0x48a/0xa20
 Write of size 885 at addr ffff888107f92000 by task cifsd/1285
 CPU: 2 UID: 0 PID: 1285 Comm: cifsd Not tainted 7.0.0 #6 PREEMPT(lazy)
 Call Trace:
  dump_stack_lvl+0x5d/0x80
  print_report+0x17f/0x4f1
  kasan_report+0x100/0x1e0
  kasan_check_range+0x10f/0x1e0
  __asan_memcpy+0x3c/0x60
  _copy_to_iter+0x48a/0xa20
  __skb_datagram_iter+0x2c9/0x430
  skb_copy_datagram_iter+0x6e/0x160
  tcp_recvmsg_locked+0xce0/0x1130
  tcp_recvmsg+0xeb/0x300
  inet_recvmsg+0xcf/0x3a0
  sock_recvmsg+0xea/0x100
  cifs_readv_from_socket+0x3a6/0x4d0 [cifs]
  cifs_read_iter_from_socket+0xdd/0x130 [cifs]
  cifs_readv_receive+0xaad/0xb10 [cifs]
  cifs_demultiplex_thread+0x1148/0x1740 [cifs]
  kthread+0x1cf/0x210

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Steve French <sfrench@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c23173a061e8..dc50690fdd44 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -459,9 +459,6 @@ static int netfs_read_gaps(struct file *file, struct fo=
lio *folio)
=20
 =09netfs_read_to_pagecache(rreq, NULL);
=20
-=09if (sink)
-=09=09folio_put(sink);
-
 =09ret =3D netfs_wait_for_read(rreq);
 =09if (ret >=3D 0) {
 =09=09folio_detach_private(folio);
@@ -471,6 +468,9 @@ static int netfs_read_gaps(struct file *file, struct fo=
lio *folio)
 =09=09flush_dcache_folio(folio);
 =09=09folio_mark_uptodate(folio);
 =09}
+
+=09if (sink)
+=09=09folio_put(sink);
 =09folio_unlock(folio);
 =09netfs_put_request(rreq, netfs_rreq_trace_put_return);
 =09return ret < 0 ? ret : 0;


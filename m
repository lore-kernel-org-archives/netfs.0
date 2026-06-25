Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5D1862A
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391867; cv=none; b=T4adtxlzd0Or20OQDjDq7RMYzvkrR8SUg/TyTMAwsEZCw9brrdWRe0WIuNmg9wUJtOdHwZofZuZNfJ5HzRIPuYo/iLjwx/kiUZBx2zEHrehDCg25UNYDwMUlGGPqxEKpJau+gquBK4jkFX6X/jb1WYIVMTfCiJr2VFCHvJoK+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391867; c=relaxed/simple;
	bh=SLe6ITWkSKggy2pJnGTLo+fMLFIZ9tcBt8yhO1F8vP0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=R808nfPaSS1lnrGCvetDzJkOk2mdNaUx1GkjVysh7GPe+TOQknZU6B1sIfHrUpog5CAO0Yqj/ppS5LDCblL9fjfN3dR4GCzclL0nJA/ogC1jbBrEA8i9KCdoosAjEIAufEdXEqk0Bguxum1e5HdBaULSn1OVfiIVJijpgAGt0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mi05vTZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mi05vTZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782391865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRb6dNCyRNoOHzPlpU+yg1ty+63V/bnvuyT4bjQNu7o=;
	b=Mi05vTZYupz26d/3cBnxwHW2wCe5BV6wZGR9MMAsiypcteg7yatw2ZaYuuMRFg/hWjPVtR
	DWANPRiXsGslexI2T/H0YcmeRrDpdBgoj9nNrF0wEo9Gpran9L0JZ8ddzOlNOljGx89Mh0
	stFrPkTxJ8Nl4D2D9ijTeFzIHv+QaBs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-5XCf2NW8MF-owCZnTcNd3A-1; Thu,
 25 Jun 2026 08:51:01 -0400
X-MC-Unique: 5XCf2NW8MF-owCZnTcNd3A-1
X-Mimecast-MFC-AGG-ID: 5XCf2NW8MF-owCZnTcNd3A_1782391860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4367A1977316;
	Thu, 25 Jun 2026 12:51:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.49.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FFCD1956088;
	Thu, 25 Jun 2026 12:50:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6a19f098.abb04025.19af7b.0003.GAE@google.com>
References: <6a19f098.abb04025.19af7b.0003.GAE@google.com>
To: syzbot <syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in netfs_unbuffered_write
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 25 Jun 2026 13:50:57 +0100
Message-ID: <3106406.1782391857@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: jJh_Vf29cEhMmt1Vow-NczHC7J1akdK26ldklpbM4pc_1782391860
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3106405.1782391857.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 8fde5d1d47f6

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 25f8ceb15fad..c16fbad286a1 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -166,13 +166,16 @@ static int netfs_unbuffered_write(struct netfs_io_req=
uest *wreq)
 =09=09 */
 =09=09subreq->error =3D -EAGAIN;
 =09=09trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-=09=09if (subreq->transferred > 0)
+=09=09if (subreq->transferred > 0) {
 =09=09=09iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+=09=09=09wreq->transferred +=3D subreq->transferred;
+=09=09}
=20
 =09=09if (stream->source =3D=3D NETFS_UPLOAD_TO_SERVER &&
 =09=09    wreq->netfs_ops->retry_request)
 =09=09=09wreq->netfs_ops->retry_request(wreq, stream);
=20
+=09=09__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 =09=09__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 =09=09__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
 =09=09__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
@@ -186,17 +189,10 @@ static int netfs_unbuffered_write(struct netfs_io_req=
uest *wreq)
=20
 =09=09netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
=20
-=09=09if (stream->prepare_write) {
+=09=09if (stream->prepare_write)
 =09=09=09stream->prepare_write(subreq);
-=09=09=09__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-=09=09=09netfs_stat(&netfs_n_wh_retry_write_subreq);
-=09=09} else {
-=09=09=09struct iov_iter source;
-
-=09=09=09netfs_reset_iter(subreq);
-=09=09=09source =3D subreq->io_iter;
-=09=09=09netfs_reissue_write(stream, subreq, &source);
-=09=09}
+=09=09__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+=09=09netfs_stat(&netfs_n_wh_retry_write_subreq);
 =09}
=20
 =09netfs_unbuffered_write_done(wreq);


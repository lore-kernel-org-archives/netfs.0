Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0042901E
	for <netfs@lists.linux.dev>; Tue, 15 Sep 2026 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489334; cv=none; b=fqbBjI5lvObe1JyHoqGSS/n1fQM3Eop7PBmyHPYUDB2QUZj5T1F9Ozbneunur5puy7QB21AvmaiuugqoqRIURNApD8bGo2bJxTpopqetNLLZ4yKIZ5JpZLTKvIVJ4tyTuywVCYiblSesfCVCHQsxhaI75Y+yc+I1hJ9CvWt8dbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489334; c=relaxed/simple;
	bh=qs7r3c4qG8QZ7uspMTVvik46QVMO5gWuV8LTPPYyA/8=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=jKhDCVoeapmMcaXLX9ApyUL3DqKeuW3D3CsRbLLyG8cv0/N6c8Kkm77lTMFmF1dPWxkOrC4N+HdnJLxoBPs3Xo3D+ZvtbeGhZ61mxyJ2k8e99rUhicNMqq94CkwbhdcUtAf+yCHa+Q+ODnhccmWT3UnqDvyJ4z1vX7Qm+bpfGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARnyHdu8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARnyHdu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789489331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2vRkeuwBNCLZr/EQqg2vm2jkY2929hMQeFDq8eV2UEo=;
	b=ARnyHdu83BwJ41XT0v0ekoMEfqVJsvEMC0eEbG85GMg+239sY7VALCxt3DANeHKt37Mi0A
	GMh2wDzM1OjtxgFyCiQz9gFjDxmwUCQgwh+r7QBA0TGzBif/v/uPEOZ6ACI8+1WCWgl9eI
	Tg/O/USuiIHNrEab36fEzJs26EIjZ5g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-u3xgUX1QNwmOEvKVb1IIaQ-1; Tue,
 15 Sep 2026 12:22:05 -0400
X-MC-Unique: u3xgUX1QNwmOEvKVb1IIaQ-1
X-Mimecast-MFC-AGG-ID: u3xgUX1QNwmOEvKVb1IIaQ_1789489324
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 282DB195605E;
	Tue, 15 Sep 2026 16:22:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E1263003EFB;
	Tue, 15 Sep 2026 16:22:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs, afs: Fix symlink reading
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 17:21:59 +0100
Message-ID: <3912795.1789489319@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: MvVI3tgIbLzjEPnRN0tEVt4f9Aap0cQlhHhz514olHo_1789489324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3912794.1789489319.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Fix the reading of symlinks from the cache in afs by making netfslib trim
the amount read down to i_size.  The problem is that afs sets the size of
the iterator to the size of the buffer (PAGE_SIZE) so that the cache can
round the read size up to the cache's DIO size.

Note that this also impacts the reading of AFS mountpoints as they're just
stored as symlinks with an odd file mode.

Fixes: c0410adf3da6 ("afs: Fix the locking used by afs_get_link()")
cc: Paulo Alcantara <pc@manguebit.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 5cf22087d243..a94197ef0181 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -435,6 +435,11 @@ static void netfs_rreq_assess_single(struct netfs_io_r=
equest *rreq)
 =09=09netfs_single_mark_inode_dirty(rreq->inode);
 =09}
=20
+=09/* To do DIO, the cache has to round the size up, so we need to undo
+=09 * the rounding.
+=09 */
+=09rreq->transferred =3D min(rreq->transferred, rreq->i_size);
+
 =09if (rreq->iocb) {
 =09=09rreq->iocb->ki_pos +=3D rreq->transferred;
 =09=09if (rreq->iocb->ki_complete) {


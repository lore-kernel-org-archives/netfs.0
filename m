Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69945426410
	for <netfs@lists.linux.dev>; Thu,  2 Jul 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980592; cv=none; b=J1EhqvLMtMqDMGjfLdfq9wlOhHCUlzPBf34j33fYjQmWez2kTrH2Qx6MeFI7eL1FSRrUqHSmpEio1VDJAQnr3jL8fb8izGbg4M+tr3zRCyfXlsQ3Rr0JKWbUu1PdA3C2LFNmcdA/Ek7wAAWpLb61CkTOb8/Y1iZnrI5N/ZAKLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980592; c=relaxed/simple;
	bh=NKCI1UqXMAwJi+0x0PStUNIAhEaUz19pwkI2LAYMGQU=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=nkc+dVOWNpT/6VmJdgNc64NaMbUrg43BaIH/eBFHgfOFb3U01BR6DEpL6m+vFC6cKFGaCwLBxzh26jJAGT8BkycZsExkfRYFmDY7Vf42IOMtLT6Ou3/71bPoljzzJcz0zntEbV5y0IWlF3BEYYuzKD5jwNtuLNj7BBVCDhtl5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuADUkeR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuADUkeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782980590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ndsjDpEQEfuXlbs4t0WFCCO1AZ2gSEQTgbkViFoVd4=;
	b=YuADUkeREele7TrbajxKLDMIDFITi1eBP+rjqlofR6d/6At9EpRMbHFTqIG+hsOhw1kmb3
	q52e+j6HD7Dco/ZqKQVkG1mXr2H3bx7g5JOk9wmsLMq8RBOmY2t+40XI52YP0OyMqvs1t4
	c7Mb8LGthICqyl25GQKnJd2uZWAYS3E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-5KyXlEVEMMixFGHRK1eZAg-1; Thu,
 02 Jul 2026 04:23:07 -0400
X-MC-Unique: 5KyXlEVEMMixFGHRK1eZAg-1
X-Mimecast-MFC-AGG-ID: 5KyXlEVEMMixFGHRK1eZAg_1782980586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20EA71833388;
	Thu,  2 Jul 2026 08:23:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E7811971E67;
	Thu,  2 Jul 2026 08:23:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix barriering when walking subrequest list
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 09:23:02 +0100
Message-ID: <138807.1782980582@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: tVZI0s7EtFwsBtw5p_uF3V3Yqu6qf-XBc9gITJ2GLN8_1782980586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <138806.1782980582.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Fix the barriering used when walking the subrequest list in retry as
there's a possibility of seeing a subreq that's just been added by the
application thread.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40red=
hat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c  |    7 ++++++-
 fs/netfs/write_retry.c |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index f59a70f3a086..2b42758e01ec 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -98,7 +98,12 @@ static void netfs_retry_read_subrequests(struct netfs_io=
_request *rreq)
 =09=09=09goto abandon;
 =09=09}
=20
-=09=09list_for_each_continue(next, &stream->subrequests) {
+=09=09for (;;) {
+=09=09=09/* Read pointer to subreq before reading subreq state. */
+=09=09=09next =3D smp_load_acquire(&next->next);
+=09=09=09if (next =3D=3D &stream->subrequests)
+=09=09=09=09break;
+
 =09=09=09subreq =3D list_entry(next, struct netfs_io_subrequest, rreq_link=
);
 =09=09=09if (subreq->start + subreq->transferred !=3D start + len ||
 =09=09=09    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 32735abfa03f..058bc7a166a5 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -72,7 +72,12 @@ static void netfs_retry_write_stream(struct netfs_io_req=
uest *wreq,
 =09=09    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
 =09=09=09return;
=20
-=09=09list_for_each_continue(next, &stream->subrequests) {
+=09=09for (;;) {
+=09=09=09/* Read pointer to subreq before reading subreq state. */
+=09=09=09next =3D smp_load_acquire(&next->next);
+=09=09=09if (next =3D=3D &stream->subrequests)
+=09=09=09=09break;
+
 =09=09=09subreq =3D list_entry(next, struct netfs_io_subrequest, rreq_link=
);
 =09=09=09if (subreq->start + subreq->transferred !=3D start + len ||
 =09=09=09    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||


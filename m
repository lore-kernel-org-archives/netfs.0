Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55249E5E6
	for <netfs@lists.linux.dev>; Mon, 14 Sep 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399240; cv=none; b=kRU/EbzRLZqnxnIeq41EmA1mGBaz5yBRoGoxdtYSV/SvEzpXpa762o3vt+9+7Bp2XS0Ci52I6J4CgSE1H0+f//gdSnL9IDKWlzGeczJtMBSbizZqs/Fyo0FfVBb5mRMVkpYI8fUv7IRS2sRfgDRoJK5wlmI1BhDZ5nEjWjedYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399240; c=relaxed/simple;
	bh=nVnmzwSFai8EYxY80JZe3TsMDW35vzNCbURo55rz6YQ=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=uR76KF7kNXokgFaErLSG85gnf0gaHQCQUJOFbBBcgdX2z9jSom0fTaMHSddOGOJNzs3Lafl2Q1xjCtx72gvMeZCjUsLINJUDCMKfd4XpR3zIhSmt8ynbPPEiSJXCgy3mehEY8U0l7FON4f3L4JGXINHdYfVltDQZmTirvwPXJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzwMxkdl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzwMxkdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789399237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jcdckveO+od1HQqqQYEBRlxZWzar/o1DqjSJJ8yIAMM=;
	b=TzwMxkdlXOjbllZpn5Ky0drlr3pwHwJ62OrZB7vi3zAkOyvBVcWaGkJFRJxBfD2K1LEfMx
	MHiLMuX9aa/10+BKFLgoye7OJB7Mr5NF8RCGwirKrOH5wM4gEVv8y+uBLrBs4F/4tDZmXh
	oeM0z+7EeYBe0SbfwF7m8J7sCQ5wMRM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-2hvwp7MEMrK3cNaxMzw_7w-1; Mon,
 14 Sep 2026 11:20:33 -0400
X-MC-Unique: 2hvwp7MEMrK3cNaxMzw_7w-1
X-Mimecast-MFC-AGG-ID: 2hvwp7MEMrK3cNaxMzw_7w_1789399232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29E89189F3A3;
	Mon, 14 Sep 2026 15:20:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33C97180056E;
	Mon, 14 Sep 2026 15:20:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Frank Sorenson <sorenson@redhat.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Namjae Jeon <linkinjeon@kernel.org>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix netfs_read_gaps() to use separate sink folios
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:20:27 +0100
Message-ID: <3228134.1789399227@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: xFRkYyUGS3340v_yJqomn_JfvvX11E9KbushqsjOq7E_1789399232
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3228133.1789399227.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

   =20
Fix netfs_read_gaps() to use separate folios rather than re-using a single
sink folio to discard the unwanted data so that cifs checksum checking sees
all the data that was fetched.

Fixes: 7f84a7b9892d ("netfs: Make netfs_read_folio() handle streaming-write=
 pages")
Reported-by: Frank Sorenson <sorenson@redhat.com>
Closes: https://lore.kernel.org/r/a385053c-1c4a-4060-a3bb-befa007ddb33@redh=
at.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Frank Sorenson <sorenson@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Namjae Jeon <linkinjeon@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 424df70a5c30..105194de6e13 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -482,15 +482,14 @@ static int netfs_read_gaps(struct file *file, struct =
folio *folio)
 =09struct netfs_group *group =3D netfs_folio_group(folio);
 =09struct netfs_folio *finfo =3D netfs_folio_info(folio);
 =09struct netfs_inode *ctx =3D netfs_inode(mapping->host);
-=09struct folio *sink =3D NULL;
-=09struct bio_vec *bvec;
+=09struct bio_vec *bvec =3D NULL;
 =09unsigned int from =3D finfo->dirty_offset;
 =09unsigned int to =3D from + finfo->dirty_len;
-=09unsigned int off =3D 0, i =3D 0;
+=09unsigned int off =3D 0;
 =09size_t flen =3D folio_size(folio);
 =09size_t nr_bvec =3D flen / PAGE_SIZE + 2;
 =09size_t part;
-=09int ret;
+=09int ret, i =3D 0, sink_from =3D -1, sink_to =3D -1;
=20
 =09_enter("%lx", folio->index);
=20
@@ -515,24 +514,23 @@ static int netfs_read_gaps(struct file *file, struct =
folio *folio)
 =09if (!bvec)
 =09=09goto discard;
=20
-=09sink =3D folio_alloc(GFP_KERNEL, 0);
-=09if (!sink) {
-=09=09kfree(bvec);
-=09=09goto discard;
-=09}
-
 =09trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
=20
-=09rreq->direct_bv =3D bvec;
-=09rreq->direct_bv_count =3D nr_bvec;
 =09if (from > 0) {
 =09=09bvec_set_folio(&bvec[i++], folio, from, 0);
 =09=09off =3D from;
 =09}
+=09sink_from =3D i;
 =09while (off < to) {
+=09=09struct folio *sink =3D folio_alloc(GFP_KERNEL, 0);
+
+=09=09if (!sink)
+=09=09=09goto discard;
 =09=09part =3D min_t(size_t, to - off, PAGE_SIZE);
-=09=09bvec_set_folio(&bvec[i++], sink, part, 0);
+=09=09bvec_set_folio(&bvec[i], sink, part, 0);
 =09=09off +=3D part;
+=09=09sink_to =3D i;
+=09=09i++;
 =09}
 =09if (to < flen)
 =09=09bvec_set_folio(&bvec[i++], folio, flen - to, to);
@@ -553,8 +551,10 @@ static int netfs_read_gaps(struct file *file, struct f=
olio *folio)
 =09=09folio_mark_uptodate(folio);
 =09}
=20
-=09if (sink)
-=09=09folio_put(sink);
+=09if (sink_to >=3D 0)
+=09=09for (; sink_from <=3D sink_to; sink_from++)
+=09=09=09folio_put(bvec_folio(&bvec[sink_from]));
+=09kfree(bvec);
 =09folio_unlock(folio);
 =09netfs_put_request(rreq, netfs_rreq_trace_put_return);
 =09return ret < 0 ? ret : 0;
@@ -563,6 +563,10 @@ static int netfs_read_gaps(struct file *file, struct f=
olio *folio)
 =09netfs_put_failed_request(rreq);
 alloc_error:
 =09folio_unlock(folio);
+=09if (sink_to >=3D 0)
+=09=09for (; sink_from <=3D sink_to; sink_from++)
+=09=09=09folio_put(bvec_folio(&bvec[sink_from]));
+=09kfree(bvec);
 =09return ret;
 }
=20


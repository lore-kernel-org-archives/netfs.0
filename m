Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A700530E11
	for <netfs@lists.linux.dev>; Wed,  9 Sep 2026 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952521; cv=none; b=IDh15JkqFAMGg4a9McmfEipWgeYDqylY6dv7spEmbhLeEXhNf8Hq9HoHNstBu+EQQcSE83rx36y42BQvXZKCp+65fmMbLu1z0YIvNj+MsKduUsnKoNPFYX2gg89Q7J0pFV7HaJ+HgCslfYLerjxh9kotlTKVwdk7Bd51dowya80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952521; c=relaxed/simple;
	bh=OmVITpzVEm42TRpM858ydSX5OU6HoaJRJoo6Yvs3jyE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=uqfzphd4hE9CG++kXZSP3VTMLevsREvpWDwHKlCiUek7nydRBv/4WqSNHHARWokT9tfNqe/y9WKhx0MdN/M3inCUP5M2En0jVYwgVWEf9fx/1/hdIkPg6viJjw0G/Y598eUC2jtYIhw2ckl9OFKGek7aSQAjJAbV52hWso2LI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avdXFKgF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avdXFKgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788952518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHGR7voYyYS+3o600ysi1zUmn4AKaqypK9BX9x55xIs=;
	b=avdXFKgFd1ax1ZBiUSbVPUX2PqUQ9QSbGeJYycwihuGbM38u6pUIgAsAyCpvROWdo0hnru
	q9MWbHi9dAT2fAYokjv8UUt9fdSjv9DIMdiLA+pgDzr/CV6U45173nXFa8z8xllFnFIeyu
	q+zq1I5Qe7L6rv4QOy08B1S+JRvr2S8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-DcC2FFztMwSxkFoe42I7vA-1; Wed,
 09 Sep 2026 07:15:15 -0400
X-MC-Unique: DcC2FFztMwSxkFoe42I7vA-1
X-Mimecast-MFC-AGG-ID: DcC2FFztMwSxkFoe42I7vA_1788952514
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB1BF19540CF;
	Wed,  9 Sep 2026 11:15:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39E7041D;
	Wed,  9 Sep 2026 11:15:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com>
References: <a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com>
To: sorenson@redhat.com
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
    netfs@lists.linux.dev, CIFS <linux-cifs@vger.kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: netfs_read_gaps(): aliased sink folio makes the read destination unreadable, SIGBUS on cifs with signing
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 09 Sep 2026 12:15:09 +0100
Message-ID: <1714046.1788952509@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: kpQlGxLYbqGLc_toOOLNDjEbt17dJJicOcgSGJaRSt4_1788952514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1714045.1788952509.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Can you try this?  It can be triggered manually with something like:

   xfs_io -c "w 100 100" -c "r 0 4096" /xfstest.test/foo

David
---
commit 60314c47d9ccce8e7da23e1754e7defb70a234ee
Author: David Howells <dhowells@redhat.com>
Date:   Wed Sep 9 11:36:30 2026 +0100

    netfs: Fix netfs_read_gaps() to use separate sink folios
   =20
    Fix netfs_read_gaps() to use separate folios rather than re-using a sin=
gle
    sink folio to discard the unwanted data so that cifs checksum checking =
sees
    all the data that was fetched.
   =20
    Reported-by: Frank Sorenson <sorenson@redhat.com>
    Closes: https://lore.kernel.org/r/a385053c-1c4a-4060-a3bb-befa007ddb33@=
redhat.com/
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Paulo Alcantara <pc@manguebit.org>
    cc: Namjae Jeon <linkinjeon@kernel.org>
    cc: netfs@lists.linux.dev
    cc: linux-cifs@vger.kernel.org
    cc: linux-fsdevel@vger.kernel.org
    Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 424df70a5c30..64eb64c475a9 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -482,15 +482,14 @@ static int netfs_read_gaps(struct file *file, struct =
folio *folio)
 =09struct netfs_group *group =3D netfs_folio_group(folio);
 =09struct netfs_folio *finfo =3D netfs_folio_info(folio);
 =09struct netfs_inode *ctx =3D netfs_inode(mapping->host);
-=09struct folio *sink =3D NULL;
 =09struct bio_vec *bvec;
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
+=09=09=09folio_unlock(bvec_folio(&bvec[sink_from]));
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
+=09=09=09folio_unlock(bvec_folio(&bvec[sink_from]));
+=09kfree(bvec);
 =09return ret;
 }
=20


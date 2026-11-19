Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088992;
	b=j/bYhybN201KJVQc1L8Fn/71Fdta+6JjU1kiNADML2o/Zie7NuXdRi2SnbCYm7GbaxzY
	 fMCtnNIfUM/xeRujaCvKKwfhGXvabYRO9V9VrGeLHs1WrtizTR1+Ld0XR3aEtCshiJ+tj
	 lTeWdYnCde2ztGASCZZ1KDdbiE4FqswvgOH1nWnBzVgtXa/kysFHEVWOj7cjpe5nVgIHL
	 hiwH+J63UHQatxka21d2yb2T5nGNmfQ0BUhFztJiBzPBVjkX2iHCR1fzs1u8rve6tDHa9
	 cFVPDDd1dtBs4+vf9ZDQczlGBIDWkN0wXIgADcwY6IuutxcK2RGO+U44nhk3pzh4SCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088992;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:From:Date:Message-ID:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-ID:Content-Transfer-Encoding;
	bh=P1uN/SEgbAkVV9dKO+jCKjxyD1xLzFCMYsGORPFd330=;
	b=nj5XzLMA+WhGL+kHLgaK46iensg2k0QzgACUTX7g+Lr+nIo2uNFyS4bHpBz6/6fcMa8C
	 aM09iDBQDi1bs0PqRYBStIJoJmE9pKMi2xTJX9FHaQXimIS/91iLNiRB3ASKsotBNqn81
	 lw9bQiijnTVQ1H7eDYd84Nt2bG43LFEfEkAe6LfQIke8kt7c/f4oODt5D8SEr9QgbahQ9
	 8wc5WLKRpVt4mqiHFj4d6me8DU2e+oQPli3n4uA4pnPzepUe0jtd4dmuZGEK8t4E7b45I
	 aL/PFdED6o1WiIHL/Dv5NKsHV7e8g2zqwxiSM3dpwKdlwv7fqIdIgXHBimOuT0RiYPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJAkxi06;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22338606A33A
	for <netfs@lists.linux.dev>; Thu, 19 Nov 2026 11:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22338606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJAkxi06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795088990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1uN/SEgbAkVV9dKO+jCKjxyD1xLzFCMYsGORPFd330=;
	b=aJAkxi06PdC6I5v2hNe9hNa1EO6kZUvt9hCy9KQZjwXTegdOa9ITbaSidQ+GTehlLSdX9t
	BKavEDHMrMbi7lgmjzKdo5sQr+7ppl2CgrR0kR53Wg18JscwMQm8YyC2AAuwgsbc+D88ks
	bL4G1aptbZZSiIao7VHknCa7V3Ta3B0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-tJa0fbcpOc2FEqPbTXJloQ-1; Thu,
 19 Nov 2026 06:49:47 -0500
X-MC-Unique: tJa0fbcpOc2FEqPbTXJloQ-1
X-Mimecast-MFC-AGG-ID: tJa0fbcpOc2FEqPbTXJloQ_1795088984
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5DBA19560AA;
	Thu, 19 Nov 2026 11:49:43 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C098195B3C6;
	Thu, 19 Nov 2026 11:49:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20261119083851.3306418-15-dhowells@redhat.com>
References: <20261119083851.3306418-15-dhowells@redhat.com> <20261119083851.3306418-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Shyam Prasad N <sprasad@microsoft.com>,
    Tom Talpey <tom@talpey.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v19 14/17] netfs: Switch folioq to bvecq
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: David Howells <dhowells@redhat.com>
Date: Thu, 19 Nov 2026 11:49:38 +0000
Message-ID: <3331469.1795088978@dhowells-thinkpadp1gen8.rmtgb.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Q4UkL_NGqOAKI2YFxkzmXCAhK400_4KQ-Wd6iDGL3is_1795088984
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3330894.1795088857.1@dhowells-thinkpadp1gen8.rmtgb.csb>
Content-Transfer-Encoding: quoted-printable

Hi Christian,

If you apply this patch, can you apply the attached change to it to fix a
potential NULL deref spotted by Sashiko[1]?

Thanks,
David
   =20
[1] https://sashiko.dev/#/patchset/20261119083851.3306418-1-dhowells%40redh=
at.com
---
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 852b2cb73435..d229e797ef23 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -277,14 +277,15 @@ static void netfs_read_to_pagecache(struct netfs_io_r=
equest *rreq)
 =09=09.cached_to[1]=09=3D ULLONG_MAX,
 =09};
 =09struct fscache_occupancy *occ =3D &_occ;
-=09struct bvecq *mark_bq =3D rreq->buffer.tail, *mark_pin;
+=09struct bvecq *mark_bq =3D rreq->buffer.tail, *mark_pin =3D NULL;
 =09unsigned int mark_offset =3D 0;
 =09ssize_t size =3D rreq->len;
 =09uoff_t start =3D rreq->start;
 =09int ret =3D 0, mark_slot =3D 0;
=20
 =09/* Pin the bvecq whilst we mark folios for copying to the cache. */
-=09mark_pin =3D bvecq_get(mark_bq);
+=09if (mark_bq)
+=09=09mark_pin =3D bvecq_get(mark_bq);
=20
 =09do {
 =09=09int (*prepare_read)(struct netfs_io_subrequest *subreq) =3D NULL;


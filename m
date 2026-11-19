Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088974;
	b=5J0nMmFw6VSaABuJWijoMxZNvY7sngJX10kftKxOj8R7dflqJySKA9Up1sbdcGfzMVNo
	 MuAJ3MtYspiZmscaTLDAdkd6Xe1eDl9sJfZNJfQfCJDy7dnZoozwtNzkY4no+/DCJFyPg
	 aUYHsANPuXBDUtLlscakapZLVIE2aLmXyjAhJo7Vg+354sp/447lDGDVBRPjvuDAiYVKS
	 KlVSBrfpunhJeB/jMjcVzFOf8Ukrg/9ayGkt7MI0b9ovl9EWAAX0wetW+mgrpnZErKKKk
	 KVIEviL4E6QAQ0wHsUYjExTu0j4asj2IU7nQMxihkTAsx2ZJwPX9vk/or7ca1sDuvNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088974;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:From:Date:Message-ID:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-ID:Content-Transfer-Encoding;
	bh=JaZEpwOL44RdJZQqfUjMFowgTZ5QMhG1R6ZLXGBR/tw=;
	b=gZvgFlxa8BJ7MrLxoEwDcdPzfYkHn1Pjg1vk+mFsomvh4LFVcgyGnZ+bWoU2Gh2tnJJg
	 2D5M0/ZrFO/xRcDvx18pCYdFse6JVA9WcEVASlLbXIZf3mv2pE+Q1QUSBoSHhLupchEiZ
	 4KpafMdLhMy9KraCEV9ePp7C8cFWMm4Ri81NbAC+Jilhpr4svmz4CKBphImpa5frrq9j8
	 yKRKrKWb8M3fLoHi9s5oNfXX75tPSwtlfypFmFJw1c7rwfFwv2ZSOTvNQLEAYa+DXieUI
	 rapM7MwRh8FGBQ84h9vlf8gei1LXMKJZK2PcF1dt8DSoPOQAWgt8Q8XIG87piluBw7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z3bBSO1q;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2B606A330
	for <netfs@lists.linux.dev>; Thu, 19 Nov 2026 11:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A2B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z3bBSO1q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795088972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaZEpwOL44RdJZQqfUjMFowgTZ5QMhG1R6ZLXGBR/tw=;
	b=Z3bBSO1q5/Sf7p+/zhAQHWi7VcjzX9j5K+H2WhvqfJyInhdM6Dt5QeILuFQ3XaINdrFicW
	UwmutfLOq3t2BA0Ek2fcTVocKLxHuD2/JTmofqLqpt0SjVtQ7xH+6sfLIs/GCuITo5l6r0
	qD1BjQMLk73YakUsSp2a4cjHvtfAe0s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-stBv0V2IPZSPIYz6hREm5Q-1; Thu,
 19 Nov 2026 06:49:28 -0500
X-MC-Unique: stBv0V2IPZSPIYz6hREm5Q-1
X-Mimecast-MFC-AGG-ID: stBv0V2IPZSPIYz6hREm5Q_1795088966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4FCC1955DCC;
	Thu, 19 Nov 2026 11:49:25 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D70A21801971;
	Thu, 19 Nov 2026 11:49:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20261119083851.3306418-5-dhowells@redhat.com>
References: <20261119083851.3306418-5-dhowells@redhat.com> <20261119083851.3306418-1-dhowells@redhat.com>
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
    linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v19 04/17] netfs: Add some tools for managing bvecq chains
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
Date: Thu, 19 Nov 2026 11:49:19 +0000
Message-ID: <3331436.1795088959@dhowells-thinkpadp1gen8.rmtgb.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: OrPXdxHJSfdFPHJi-y9-zFgJAW3c0GZgupGA_oEDSnQ_1795088966
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3330734.1795088718.1@dhowells-thinkpadp1gen8.rmtgb.csb>
Content-Transfer-Encoding: quoted-printable

Hi Christian,

If you pull this patch, can you apply the attached diff to it to fix some
issues that Sashiko brought up[1]?

- In bvecq_alloc_buffer2(), fix OOM discard where the requested number of
  pre-slots fills up a entire bvecq.

- In bvecq_alloc_buffer2(), add comment on why we want to exit the buffer
  alloc loop immediately.

- In bvecq_put(), clear the prev pointer of the next bvecq if it points
  back to the one being released.

- Fix bvecq_append() kdoc.

- Change %flags to @flags in function kdoc when referring to func arg.

Thanks,
David

[1] https://sashiko.dev/#/patchset/20261119083851.3306418-1-dhowells%40redh=
at.com
---
diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
index b140cd47a1fa..1b2ad42e6d50 100644
--- a/fs/netfs/bvecq.c
+++ b/fs/netfs/bvecq.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL(bvecq_dump);
  * that at least some progress can be made.
  *
  * Return: The node pointer or NULL on allocation failure.  BVECQ_HIT_OOM =
is
- * set in *flags if an allocation failure occurs.
+ * set in *@flags if an allocation failure occurs.
  */
 struct bvecq *bvecq_alloc_one(size_t nr_slots, gfp_t gfp, unsigned int *fl=
ags)
 {
@@ -136,10 +136,10 @@ EXPORT_SYMBOL(bvecq_alloc_one);
  *
  * Allocate a chain of bvecq nodes providing at least the requested cumula=
tive
  * number of slots.  Each node is a maximum of 4KiB in size.  If
- * %BVECQ_SHORT_OKAY is set in *%flags, then the chain may be shortened on=
 OOM.
+ * %BVECQ_SHORT_OKAY is set in *@flags, then the chain may be shortened on=
 OOM.
  *
  * Return: The first node pointer or NULL on allocation failure.  BVECQ_HI=
T_OOM
- * is set in *flags if an allocation failure occurs.
+ * is set in *@flags if an allocation failure occurs.
  */
 struct bvecq *bvecq_alloc_chain(size_t nr_slots, gfp_t gfp, unsigned int *=
flags)
 {
@@ -191,7 +191,7 @@ EXPORT_SYMBOL(bvecq_alloc_chain);
  * refcounts set to 1 and can be passed to MSG_SPLICE_PAGES.
  *
  * Return: The first node pointer or NULL on allocation failure.  BVECQ_HI=
T_OOM
- * is set in *flags if a bvecq chain allocation failure occurs (though if
+ * is set in *@flags if a bvecq chain allocation failure occurs (though if
  * %BVECQ_SHORT_OKAY is set, the func may return early but will have at le=
ast
  * one bvecq in the allocation).
  */
@@ -200,6 +200,7 @@ struct bvecq *bvecq_alloc_buffer2(size_t size, unsigned=
 int pre_slots, gfp_t gfp
 {
 =09struct bvecq *head =3D NULL, *tail =3D NULL;
 =09size_t count =3D pre_slots + DIV_ROUND_UP(size, PAGE_SIZE);
+=09bool got_page =3D false;
=20
 =09_enter("%zx,%zx,%u", size, count, pre_slots);
=20
@@ -258,7 +259,12 @@ struct bvecq *bvecq_alloc_buffer2(size_t size, unsigne=
d int pre_slots, gfp_t gfp
=20
 =09=09bvecq_filled_to(tail, slot);
 =09=09count -=3D got;
+=09=09got_page =3D true;
=20
+=09=09/* TODO: If we got an OOM trying to allocate a bvecq, we should
+=09=09 * probably stop allocating pages unless/until we have an
+=09=09 * emergency pool of those also.
+=09=09 */
 =09=09if (unlikely(*flags & BVECQ_HIT_OOM) && (*flags & BVECQ_SHORT_OKAY))
 =09=09=09break;
 =09} while (count > 0);
@@ -273,7 +279,9 @@ struct bvecq *bvecq_alloc_buffer2(size_t size, unsigned=
 int pre_slots, gfp_t gfp
 =09=09bvecq_put(tail);
 =09}
 oom:
-=09if (!head || (tail =3D=3D head && head->nr_slots =3D=3D pre_slots))
+=09if (!head)
+=09=09goto out;
+=09if (!got_page && size > 0)
 =09=09goto discard; /* Allocated no pages */
 =09if (*flags & BVECQ_SHORT_OKAY)
 =09=09goto out;
@@ -328,6 +336,8 @@ void bvecq_put(struct bvecq *bq)
 =09=09for (int slot =3D 0; slot < bq->nr_slots; slot++)
 =09=09=09bvecq_free_slot(bq, slot);
 =09=09next =3D bq->next;
+=09=09if (next && next->prev =3D=3D bq)
+=09=09=09next->prev =3D NULL;
 =09=09netfs_stat_d(&netfs_n_bvecq);
=20
 =09=09if (bq->from_pool !=3D BVECQ_USE_NO_POOL)
diff --git a/include/linux/bvecq.h b/include/linux/bvecq.h
index f670a031ac44..da2385c91e9a 100644
--- a/include/linux/bvecq.h
+++ b/include/linux/bvecq.h
@@ -162,7 +162,7 @@ static inline bool bvecq_acquire_slot(const struct bvec=
q *bvecq, unsigned int sl
 }
=20
 /**
- * bvecq_append - Get the next bvecq with appropriate barrier
+ * bvecq_append - Attach new bvecq to chain with appropriate barrier
  * @to: The bvecq to append to
  * @add: The bvecq to append
  *


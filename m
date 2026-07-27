Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511E3F12C2
	for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146623; cv=none; b=EibIldmu2p4rlek3t/l+pFZCU7KaJSf4WNTilUNGbJL1SeEAeoCd3YQ0DQhphD+zfyw/Lo/czILdj6ap7knicPHtM3+kXV5fAmpxPYbIm4YjYG/JC6hc/xXnjithKy9fJZT2iwV43rv0v4QutJ3E5tbBU4rbrWZHzCDRONw+BRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146623; c=relaxed/simple;
	bh=a1kgZpIGZzlbZ+0IjeE+C/CrSdc0Iq4q2c79+uLPRPk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=Wmn91f9nN4i4IJtUz3de7BOZFo6KDvT+kduKRwSJeALm2LmuOTGST+l1OfcV0G40kEzr+HnMzBzMxKkHHw+zUxZdXipr6FfrCYIaUZz2bxAi+e5nxkJ/LFIvz9EDrEs352GNT+Ae+PNaxM5DwZ1CSWJoBVCX643D4rw3EipXZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OedPh3oH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OedPh3oH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785146621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVEpFghLVnAwONyDx3WoqP9OTLsWKi/fPJoUih/VoiM=;
	b=OedPh3oHfKsqhMmztJMeV+Ee58AXzzOW1+vtOUCT+7/ITnou+HgMBcBQFR2wcKJwlADVF2
	QWVoCf3odzeAUOhrW8ZcNpu6uVSnZX4JG7BGl1PUYM5LiAEpy+5EX0b6/F85bRHDECMUUF
	bsrumSm0gkMJaScKmIrjj7+s02Ek5GY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ExsrUMMLOF-x-nHkKmOaDQ-1; Mon,
 27 Jul 2026 06:03:38 -0400
X-MC-Unique: ExsrUMMLOF-x-nHkKmOaDQ-1
X-Mimecast-MFC-AGG-ID: ExsrUMMLOF-x-nHkKmOaDQ_1785146617
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E6921800745;
	Mon, 27 Jul 2026 10:03:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B93B71955F74;
	Mon, 27 Jul 2026 10:03:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260724073044.3400217-1-yun.zhou@windriver.com>
References: <20260724073044.3400217-1-yun.zhou@windriver.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    hch@infradead.org
Subject: Re: [PATCH v2] netfs: fix writeback ENOMEM by using __GFP_NOFAIL for rolling buffer
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 11:03:32 +0100
Message-ID: <974342.1785146612@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: _H1nGRiXl-r8sAEiTGttfc7ne0O3JVQcT2_fL883jrU_1785146617
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <974341.1785146612.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Yun Zhou <yun.zhou@windriver.com> wrote:

> rolling_buffer_init() uses plain GFP_NOFS for its folio_queue allocation.
> In the writeback path this can fail and trigger WARN_ON_ONCE(folio !=3D N=
ULL)
> in netfs_writepages() when writeback_iter() returns additional dirty foli=
os
> left unhandled.
>=20
> Writeback must not fail with -ENOMEM. Fix this by adding a gfp_t paramete=
r
> to rolling_buffer_init() and passing GFP_NOFS | __GFP_NOFAIL from the
> writeback path, ensuring the allocation always succeeds. Read paths
> continue to use plain GFP_NOFS.

I don't think this is the correct solution.  I think you're right that a gf=
p_t
needs to be passed into rolling_buffer*(), but I think we need a mempool as
well.

I have most of the patch for that, but I think I need adjust things so that
the read path uses GFP_KERNEL, not GFP_NOFS.

David
---
commit 3cc9160c12645c38c860e748845cb63b15115078
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jul 24 10:24:30 2026 +0100

    netfs: Fix folio_queue ENOMEM in writeback by adding a mempool
   =20
    Fix the handling of folio_queue allocation failure in writeback by addi=
ng a
    mempool.  The failure caused:
   =20
        folio !=3D NULL
        WARNING: fs/netfs/write_issue.c:603 at netfs_writepages+0x883/0xa10=
 fs/netfs/write_issue.c:603, CPU#3: syz.0.17/5919
   =20
    Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator=
 instead of xarray iter")
    Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D0da43efa72f88bd3a8af
    Signed-off-by: David Howells <dhowells@redhat.com>
    Tested-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
    cc: Paulo Alcantara <pc@manguebit.org>
    cc: Yun Zhou <yun.zhou@windriver.com>
    cc: Matthew Wilcox <willy@infradead.org>
    cc: Christoph Hellwig <hch@infradead.org>
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d889caa401dc..420ee7b26580 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -43,6 +43,7 @@ extern struct list_head netfs_io_requests;
 extern spinlock_t netfs_proc_lock;
 extern mempool_t netfs_request_pool;
 extern mempool_t netfs_subrequest_pool;
+extern mempool_t netfs_folioq_pool;
=20
 #ifdef CONFIG_PROC_FS
 static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 73da6c9f5777..927badf3989d 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -28,6 +28,7 @@ static struct kmem_cache *netfs_request_slab;
 static struct kmem_cache *netfs_subrequest_slab;
 mempool_t netfs_request_pool;
 mempool_t netfs_subrequest_pool;
+mempool_t netfs_folioq_pool;
=20
 #ifdef CONFIG_PROC_FS
 LIST_HEAD(netfs_io_requests);
@@ -108,6 +109,9 @@ static int __init netfs_init(void)
 {
 =09int ret =3D -ENOMEM;
=20
+=09if (mempool_init_kmalloc_pool(&netfs_folioq_pool, 100, sizeof(struct fo=
lio_queue)) < 0)
+=09=09goto error_folioq_pool;
+
 =09netfs_request_slab =3D kmem_cache_create("netfs_request",
 =09=09=09=09=09       sizeof(struct netfs_io_request), 0,
 =09=09=09=09=09       SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
@@ -160,6 +164,8 @@ static int __init netfs_init(void)
 error_reqpool:
 =09kmem_cache_destroy(netfs_request_slab);
 error_req:
+=09mempool_exit(&netfs_folioq_pool);
+error_folioq_pool:
 =09return ret;
 }
 fs_initcall(netfs_init);
@@ -172,5 +178,6 @@ static void __exit netfs_exit(void)
 =09kmem_cache_destroy(netfs_subrequest_slab);
 =09mempool_exit(&netfs_request_pool);
 =09kmem_cache_destroy(netfs_request_slab);
+=09mempool_exit(&netfs_folioq_pool);
 }
 module_exit(netfs_exit);
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
index a17fbf9853a4..48052d77567b 100644
--- a/fs/netfs/rolling_buffer.c
+++ b/fs/netfs/rolling_buffer.c
@@ -27,7 +27,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq_=
id, gfp_t gfp,
 {
 =09struct folio_queue *fq;
=20
-=09fq =3D kmalloc_obj(*fq, gfp);
+=09fq =3D mempool_alloc(&netfs_folioq_pool, gfp);
 =09if (fq) {
 =09=09netfs_stat(&netfs_n_folioq);
 =09=09folioq_init(fq, rreq_id);
@@ -50,7 +50,7 @@ void netfs_folioq_free(struct folio_queue *folioq,
 {
 =09trace_netfs_folioq(folioq, trace);
 =09netfs_stat_d(&netfs_n_folioq);
-=09kfree(folioq);
+=09mempool_free(folioq, &netfs_folioq_pool);
 }
 EXPORT_SYMBOL(netfs_folioq_free);
=20


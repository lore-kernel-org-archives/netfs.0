Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E250421228
	for <netfs@lists.linux.dev>; Fri, 24 Jul 2026 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889113; cv=none; b=bQuCRIwyys86IHx0NjbRM1dUu1rZqw+zj8pwhCjzAb6h606vVxR73KSG52zgHAeYGXj3ivcqgypXmGJccqs3swTj4OXFiTCsOaH0E8ZH4OchTvlpgdhmBacIjQgFMmD4W7wQt9UAAaBM/vD/x231/G71WPI4uDYMi7WzRpXAS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889113; c=relaxed/simple;
	bh=IVOnHozJybCTC+/IRF0MN9VW/rFho9ecPH/NkorU7Q4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=AFHY/6OEFw0xUMYrhjBtkI0UQfuZhQWjroM3XLNUOT7SuGpERqYB+ZyUwGcFB0BcAPzTTp+pPPLI987GMqJ+oaYpAiQIV6d14xjv892jCCw3fFJ4MDAnNdCcNARnf9iRQqrVZR8+P4JNrrhKp5J7F6uZ2CVTQxfO0LMPg8+G8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKEC8Jro; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKEC8Jro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784889110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kMYA5OEbs/lRBd/TR/jJS3dnFU6cgUXmzKvNbdefAY=;
	b=eKEC8JroX8loRCoYOAxrMqjE9oNvDWS42MbzcxnoTZKmNZ3kdPMm3ekGd7hEkWs9iTtFM/
	wrHaYcylqZ+VmRp3RXMAX6srO4sehpHQAhmsuaVjT/xe2u6lmZUSizKMyM1V7Er/ZHU6LQ
	rp6gRx15aCjMyk441uCgn3J1GENuEG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-u6t9AAAmNNSSSFGeoiYWxg-1; Fri,
 24 Jul 2026 06:31:49 -0400
X-MC-Unique: u6t9AAAmNNSSSFGeoiYWxg-1
X-Mimecast-MFC-AGG-ID: u6t9AAAmNNSSSFGeoiYWxg_1784889107
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 422C6195DBA2;
	Fri, 24 Jul 2026 10:31:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14435158A;
	Fri, 24 Jul 2026 10:31:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
References: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
To: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 11:31:43 +0100
Message-ID: <831911.1784889103@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: rs2FVq8-M8ILywnur46au8Tj0WVJ1-kXRuhtEDBr4kc_1784889107
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <831910.1784889103.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

    netfs: Fix folio_queue ENOMEM in writeback by adding a mempool

    Fix the handling of folio_queue allocation failure in writeback by addi=
ng a
    mempool.  The failure caused:

        folio !=3D NULL
        WARNING: fs/netfs/write_issue.c:603 at netfs_writepages+0x883/0xa10=
 fs/netfs/write_issue.c:603, CPU#3: syz.0.17/5919
   =20
    Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator=
 instead of xarray iter")
    Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D0da43efa72f88bd3a8af
    Signed-off-by: David Howells <dhowells@redhat.com>
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


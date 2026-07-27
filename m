Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F3D392836
	for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154843; cv=none; b=KIIVN8de1xlKsgBn81r+uxnq8sLBy/+NzNM/djtzVzQw9RuJ4WAPtMk+Fe4ixNRaKbcsS157KtPovFFGNaK1Zp2Lw8pQVCYXhXddbITsHkBbEqVNn9GWhAcOkDCUxv6LzI38/3bkIggmZuAzhBiumvOAzah+bbg18rq1x/sUaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154843; c=relaxed/simple;
	bh=z8f+GCUfHFGKfbpumV96UWfhBxUsEyyAeN8o6P+wwuI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=XEjRgb1GiAMWBYj+fVTuOYPZDT9haAWASOqi7Hgrz+OKqyWN6nOORGx3InL2qQ+trs/zlyjb4HUCz3XVoVuyV/TmwKl7Ev4BMGKmf+vtViyyD1D+Ziaskb9aYo2Sz4M7FGOqXHrgyQUk80o38+a5IZP3jlpn1wCnSH43cYv6dX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLFUcbSp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLFUcbSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785154838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=914qO+BPxhrn205Rnp+9mzXYs+Adk/Q5qcG6i1WElLA=;
	b=cLFUcbSpAFOUbKZuD52/9mxe4165PwEJU+EsajSf8fZj9ts+sYRM5anmA+/D+5LEVng44e
	moMKr5wJDqJTl/rSHONRatgYv0WUGgjZTxGs7QoIIeC9jfCiR+tpq7IthvjfsW2grm2e19
	s7ppOJYeYrMnXLLkOH7Egm/7Zc3ZBKw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-kiHuR0EZOPy6LrzPjT3xiA-1; Mon,
 27 Jul 2026 08:20:27 -0400
X-MC-Unique: kiHuR0EZOPy6LrzPjT3xiA-1
X-Mimecast-MFC-AGG-ID: kiHuR0EZOPy6LrzPjT3xiA_1785154826
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E051E1955F3D;
	Mon, 27 Jul 2026 12:20:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52FCF1955F22;
	Mon, 27 Jul 2026 12:20:23 +0000 (UTC)
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
    pc@manguebit.org, Yun Zhou <yun.zhou@windriver.com>,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 13:20:21 +0100
Message-ID: <1097630.1785154821@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: hd8WioDeT1HUoGklPSGKnsnmiHz8_RbwPLujN2Zr4Uk_1785154826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1097629.1785154821.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

commit 6836db8d3babf7ae82597d516f89848e5652b957
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jul 24 10:24:30 2026 +0100

    netfs: Fix folio_queue ENOMEM in writeback by adding a mempool
   =20
    Fix the handling of folio_queue allocation failure in writeback by addi=
ng a
    mempool and passing in gfp_t flags to the rolling buffer functions that
    allocate memory, using the mempool if gfp !=3D GFP_KERNEL.
   =20
    This is then extended upwards and the gfp to be used for a request is s=
tored
    in the netfs_io_request struct and is then used for both requests and
    subrequests, eliminating the sleeping loops there.
   =20
    The failure caused:
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

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3d86414ee40f..7fdfa4f27e34 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -361,7 +361,7 @@ void netfs_readahead(struct readahead_control *ractl)
 =09netfs_rreq_expand(rreq, ractl);
=20
 =09rreq->submitted =3D rreq->start;
-=09if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
+=09if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST, rreq-=
>gfp) < 0)
 =09=09goto cleanup_free;
 =09netfs_read_to_pagecache(rreq, ractl);
=20
@@ -380,10 +380,10 @@ static int netfs_create_singular_buffer(struct netfs_=
io_request *rreq, struct fo
 {
 =09ssize_t added;
=20
-=09if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
+=09if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST, rreq-=
>gfp) < 0)
 =09=09return -ENOMEM;
=20
-=09added =3D rolling_buffer_append(&rreq->buffer, folio, rollbuf_flags);
+=09added =3D rolling_buffer_append(&rreq->buffer, folio, rollbuf_flags, rr=
eq->gfp);
 =09if (added < 0)
 =09=09return added;
 =09rreq->submitted =3D rreq->start + added;
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
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index b8c4918d3dcd..29d8eab06dec 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -7,7 +7,6 @@
=20
 #include <linux/slab.h>
 #include <linux/mempool.h>
-#include <linux/delay.h>
 #include "internal.h"
=20
 static void netfs_free_request(struct work_struct *work);
@@ -26,17 +25,23 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
 =09struct netfs_io_request *rreq;
 =09mempool_t *mempool =3D ctx->ops->request_pool ?: &netfs_request_pool;
 =09struct kmem_cache *cache =3D mempool->pool_data;
+=09gfp_t gfp =3D GFP_KERNEL;
 =09int ret;
=20
-=09for (;;) {
-=09=09rreq =3D mempool_alloc(mempool, GFP_KERNEL);
-=09=09if (rreq)
-=09=09=09break;
-=09=09msleep(10);
+=09/* Writeback is part of memory reclaim and must not fail due to ENOMEM.=
 */
+=09if (origin =3D=3D NETFS_WRITEBACK || origin =3D=3D NETFS_WRITEBACK_SING=
LE) {
+=09=09gfp =3D GFP_NOFS; /* Allows use of mempools. */
+
+=09=09rreq =3D mempool_alloc(mempool, gfp);
+=09} else {
+=09=09rreq =3D mempool->alloc(gfp, mempool->pool_data);
+=09=09if (!rreq)
+=09=09=09return ERR_PTR(-ENOMEM);
 =09}
=20
 =09memset(rreq, 0, kmem_cache_size(cache));
 =09INIT_WORK(&rreq->cleanup_work, netfs_free_request);
+=09rreq->gfp=09=3D gfp;
 =09rreq->start=09=3D start;
 =09rreq->len=09=3D len;
 =09rreq->origin=09=3D origin;
@@ -200,12 +205,14 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(st=
ruct netfs_io_request *rreq
 =09mempool_t *mempool =3D rreq->netfs_ops->subrequest_pool ?: &netfs_subre=
quest_pool;
 =09struct kmem_cache *cache =3D mempool->pool_data;
=20
-=09for (;;) {
-=09=09subreq =3D mempool_alloc(rreq->netfs_ops->subrequest_pool ?: &netfs_=
subrequest_pool,
-=09=09=09=09       GFP_KERNEL);
-=09=09if (subreq)
-=09=09=09break;
-=09=09msleep(10);
+=09if (rreq->gfp =3D=3D GFP_KERNEL) {
+=09=09subreq =3D mempool->alloc(rreq->gfp, mempool->pool_data);
+=09=09if (!subreq)
+=09=09=09return ERR_PTR(-ENOMEM);
+=09} else {
+=09=09subreq =3D mempool_alloc(mempool, rreq->gfp);
+=09=09if (!subreq)
+=09=09=09return NULL;
 =09}
=20
 =09memset(subreq, 0, kmem_cache_size(cache));
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 7eacc58abadb..c31190993b76 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -53,7 +53,7 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_requ=
est *creq, struct folio
 =09trace_netfs_folio(folio, netfs_folio_trace_store_copy);
=20
 =09/* Attach the folio to the rolling buffer. */
-=09if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
+=09if (rolling_buffer_append(&creq->buffer, folio, 0, creq->gfp) < 0) {
 =09=09folio_end_private_2(folio);
 =09=09clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
 =09=09return;
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
index a17fbf9853a4..c7f107764bda 100644
--- a/fs/netfs/rolling_buffer.c
+++ b/fs/netfs/rolling_buffer.c
@@ -27,7 +27,10 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq=
_id, gfp_t gfp,
 {
 =09struct folio_queue *fq;
=20
-=09fq =3D kmalloc_obj(*fq, gfp);
+=09if (gfp =3D=3D GFP_KERNEL)
+=09=09fq =3D netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.pool_data);
+=09else
+=09=09fq =3D mempool_alloc(&netfs_folioq_pool, gfp);
 =09if (fq) {
 =09=09netfs_stat(&netfs_n_folioq);
 =09=09folioq_init(fq, rreq_id);
@@ -50,7 +53,7 @@ void netfs_folioq_free(struct folio_queue *folioq,
 {
 =09trace_netfs_folioq(folioq, trace);
 =09netfs_stat_d(&netfs_n_folioq);
-=09kfree(folioq);
+=09mempool_free(folioq, &netfs_folioq_pool);
 }
 EXPORT_SYMBOL(netfs_folioq_free);
=20
@@ -60,11 +63,11 @@ EXPORT_SYMBOL(netfs_folioq_free);
  * consumer.
  */
 int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
-=09=09=09unsigned int direction)
+=09=09=09unsigned int direction, gfp_t gfp)
 {
 =09struct folio_queue *fq;
=20
-=09fq =3D netfs_folioq_alloc(rreq_id, GFP_NOFS, netfs_trace_folioq_rollbuf=
_init);
+=09fq =3D netfs_folioq_alloc(rreq_id, gfp, netfs_trace_folioq_rollbuf_init=
);
 =09if (!fq)
 =09=09return -ENOMEM;
=20
@@ -77,14 +80,14 @@ int rolling_buffer_init(struct rolling_buffer *roll, un=
signed int rreq_id,
 /*
  * Add another folio_queue to a rolling buffer if there's no space left.
  */
-int rolling_buffer_make_space(struct rolling_buffer *roll)
+int rolling_buffer_make_space(struct rolling_buffer *roll, gfp_t gfp)
 {
 =09struct folio_queue *fq, *head =3D roll->head;
=20
 =09if (!folioq_full(head))
 =09=09return 0;
=20
-=09fq =3D netfs_folioq_alloc(head->rreq_id, GFP_NOFS, netfs_trace_folioq_m=
ake_space);
+=09fq =3D netfs_folioq_alloc(head->rreq_id, gfp, netfs_trace_folioq_make_s=
pace);
 =09if (!fq)
 =09=09return -ENOMEM;
 =09fq->prev =3D head;
@@ -122,7 +125,7 @@ ssize_t rolling_buffer_load_from_ra(struct rolling_buff=
er *roll,
 =09int nr, ix, to;
 =09ssize_t size =3D 0;
=20
-=09if (rolling_buffer_make_space(roll) < 0)
+=09if (rolling_buffer_make_space(roll, GFP_KERNEL) < 0)
 =09=09return -ENOMEM;
=20
 =09fq =3D roll->head;
@@ -153,12 +156,12 @@ ssize_t rolling_buffer_load_from_ra(struct rolling_bu=
ffer *roll,
  * Append a folio to the rolling buffer.
  */
 ssize_t rolling_buffer_append(struct rolling_buffer *roll, struct folio *f=
olio,
-=09=09=09      unsigned int flags)
+=09=09=09      unsigned int flags, gfp_t gfp)
 {
 =09ssize_t size =3D folio_size(folio);
 =09int slot;
=20
-=09if (rolling_buffer_make_space(roll) < 0)
+=09if (rolling_buffer_make_space(roll, gfp) < 0)
 =09=09return -ENOMEM;
=20
 =09slot =3D folioq_append(roll->head, folio);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 14efe4cb9393..2d9cfcd43658 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -108,7 +108,7 @@ struct netfs_io_request *netfs_create_write_req(struct =
address_space *mapping,
 =09ictx =3D netfs_inode(wreq->inode);
 =09if (is_cacheable)
 =09=09fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie=
(ictx));
-=09if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE) < 0=
)
+=09if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE, wre=
q->gfp) < 0)
 =09=09goto nomem;
=20
 =09wreq->cleaned_to =3D wreq->start;
@@ -167,7 +167,7 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 =09 */
 =09if (iov_iter_is_folioq(wreq_iter) &&
 =09    wreq_iter->folioq_slot >=3D folioq_nr_slots(wreq_iter->folioq))
-=09=09rolling_buffer_make_space(&wreq->buffer);
+=09=09rolling_buffer_make_space(&wreq->buffer, wreq->gfp);
=20
 =09subreq =3D netfs_alloc_subrequest(wreq);
 =09subreq->source=09=09=3D stream->source;
@@ -334,7 +334,7 @@ static int netfs_write_folio(struct netfs_io_request *w=
req,
=20
 =09_enter("");
=20
-=09if (rolling_buffer_make_space(&wreq->buffer) < 0)
+=09if (rolling_buffer_make_space(&wreq->buffer, wreq->gfp) < 0)
 =09=09return -ENOMEM;
=20
 =09/* netfs_perform_write() may shift i_size around the page or from out
@@ -436,7 +436,7 @@ static int netfs_write_folio(struct netfs_io_request *w=
req,
 =09}
=20
 =09/* Attach the folio to the rolling buffer. */
-=09rolling_buffer_append(&wreq->buffer, folio, 0);
+=09rolling_buffer_append(&wreq->buffer, folio, 0, wreq->gfp);
=20
 =09/* Move the submission point forward to allow for write-streaming data
 =09 * not starting at the front of the page.  We don't do write-streaming
@@ -749,7 +749,7 @@ static int netfs_write_folio_single(struct netfs_io_req=
uest *wreq,
=20
 =09/* Attach the folio to the rolling buffer. */
 =09folio_get(folio);
-=09ret =3D rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_M=
ARK);
+=09ret =3D rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_M=
ARK, wreq->gfp);
 =09if (ret < 0) {
 =09=09folio_put(folio);
 =09=09return ret;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 1bc120d61c5b..d0b62d53eea9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -255,6 +255,7 @@ struct netfs_io_request {
 =09unsigned long long=09cleaned_to;=09/* Position we've cleaned folios to =
*/
 =09unsigned long long=09abandon_to;=09/* Position to abandon folios to */
 =09const struct folio=09*no_unlock_folio; /* Don't unlock this folio after=
 read */
+=09gfp_t=09=09=09gfp;=09=09/* GFP flags to use */
 =09unsigned int=09=09direct_bv_count; /* Number of elements in direct_bv[]=
 */
 =09unsigned int=09=09debug_id;
 =09unsigned int=09=09rsize;=09=09/* Maximum read size (0 for none) */
diff --git a/include/linux/rolling_buffer.h b/include/linux/rolling_buffer.=
h
index ac15b1ffdd83..9e5dad29669c 100644
--- a/include/linux/rolling_buffer.h
+++ b/include/linux/rolling_buffer.h
@@ -43,13 +43,13 @@ struct rolling_buffer_snapshot {
 #define ROLLBUF_MARK_2=09BIT(1)
=20
 int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
-=09=09=09unsigned int direction);
-int rolling_buffer_make_space(struct rolling_buffer *roll);
+=09=09=09unsigned int direction, gfp_t gfp);
+int rolling_buffer_make_space(struct rolling_buffer *roll, gfp_t gfp);
 ssize_t rolling_buffer_load_from_ra(struct rolling_buffer *roll,
 =09=09=09=09    struct readahead_control *ractl,
 =09=09=09=09    struct folio_batch *put_batch);
 ssize_t rolling_buffer_append(struct rolling_buffer *roll, struct folio *f=
olio,
-=09=09=09      unsigned int flags);
+=09=09=09      unsigned int flags, gfp_t gfp);
 struct folio_queue *rolling_buffer_delete_spent(struct rolling_buffer *rol=
l);
 void rolling_buffer_clear(struct rolling_buffer *roll);
=20


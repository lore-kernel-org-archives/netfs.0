Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5B35C183
	for <netfs@lists.linux.dev>; Thu, 26 Feb 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112773; cv=none; b=sCSEVGFJTwNAjRoTEwZQdX+LjnWcYO8KWFMzADKtvaRRcocYanrkq9YSWvQoIvnvubWKJUj2fREXxpYObVbMv3b0/DJOCyAIdTKkZGios6e/i6Dq6sfCyu7SyNo1EKc/L9TrNCPmf3qgLszs9QUW6JLoZmylZg5jZSHtkBmeumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112773; c=relaxed/simple;
	bh=BV83E09a6/oM4GP80hv8YKqcQtdI0JNMsDa0kbYIyY0=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=EGE9xj7qz/Dq1E/58LzgfA5Ijlu7bgGoLwRzOuuZJXkfHJk3ayfUmLpnGgghrn3YKeAMVegSLr8cE/eJkkouHvyUmrJecjy36C8ndhS0BoZRmjjCheuwp8NBCi+u9OGPqZF8Wbc8UCbXUM7iNCfU8yRzQ3y+ab92lyDnKJWFjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoPkPMfW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoPkPMfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772112765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmIMV0qKl5UibmlhEvScdFbtNMMRgkqdrDyhCZkRTVY=;
	b=LoPkPMfWninoYMn0Xijpc5LBTvy2XfR7pdhP5eGLeMgE4lR+UBo+OLRZ9El0v8bLgdfbkO
	LkUqmkZWTHyJmJQpo9fm2HMKu5CLBon1Wry+a1GCLc9bb+HaFHQIP+FEwOCe19K4NMkL36
	5RUf+CBUsmPJm2xQc5ydfv0SU8U6Hwk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-uRKau_f2MvmYT-pd6mBt0Q-1; Thu,
 26 Feb 2026 08:32:42 -0500
X-MC-Unique: uRKau_f2MvmYT-pd6mBt0Q-1
X-Mimecast-MFC-AGG-ID: uRKau_f2MvmYT-pd6mBt0Q_1772112760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4D6818003FC;
	Thu, 26 Feb 2026 13:32:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6400630001A5;
	Thu, 26 Feb 2026 13:32:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Steve French <sfrench@samba.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 26 Feb 2026 13:32:33 +0000
Message-ID: <58526.1772112753@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Pa-E_G_3X9ftYe01WhqOcj054bOlMtViGNd8wH1yT3I_1772112760
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58525.1772112753.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

   =20
Fix netfslib such that when it's making an unbuffered or DIO write, to make
sure that it sends each subrequest strictly sequentially, waiting till the
previous one is 'committed' before sending the next so that we don't have
pieces landing out of order and potentially leaving a hole if an error
occurs (ENOSPC for example).

This is done by copying in just those bits of issuing, collecting and
retrying subrequests that are necessary to do one subrequest at a time.
Retrying, in particular, is simpler because if the current subrequest needs
retrying, the source iterator can just be copied again and the subrequest
prepped and issued again without needing to be concerned about whether it
needs merging with the previous or next in the sequence.

Note that the issuing loop waits for a subrequest to complete right after
issuing it, but this wait could be moved elsewhere allowing preparatory
steps to be performed whilst the subrequest is in progress.  In particular,
once content encryption is available in netfslib, that could be done whilst
waiting, as could cleanup of buffers that have been completed.

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Tested-by: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c      |  228 ++++++++++++++++++++++++++++++++++++++=
+----
 fs/netfs/internal.h          |    4=20
 fs/netfs/write_collect.c     |   21 ---
 fs/netfs/write_issue.c       |   41 -------
 include/trace/events/netfs.h |    4=20
 5 files changed, 221 insertions(+), 77 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a9d1c3b2c084..dd1451bf7543 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -9,6 +9,202 @@
 #include <linux/uio.h>
 #include "internal.h"
=20
+/*
+ * Perform the cleanup rituals after an unbuffered write is complete.
+ */
+static void netfs_unbuffered_write_done(struct netfs_io_request *wreq)
+{
+=09struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
+
+=09_enter("R=3D%x", wreq->debug_id);
+
+=09/* Okay, declare that all I/O is complete. */
+=09trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
+
+=09if (!wreq->error)
+=09=09netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferr=
ed);
+
+=09if (wreq->origin =3D=3D NETFS_DIO_WRITE &&
+=09    wreq->mapping->nrpages) {
+=09=09/* mmap may have got underfoot and we may now have folios
+=09=09 * locally covering the region we just wrote.  Attempt to
+=09=09 * discard the folios, but leave in place any modified locally.
+=09=09 * ->write_iter() is prevented from interfering by the DIO
+=09=09 * counter.
+=09=09 */
+=09=09pgoff_t first =3D wreq->start >> PAGE_SHIFT;
+=09=09pgoff_t last =3D (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT=
;
+
+=09=09invalidate_inode_pages2_range(wreq->mapping, first, last);
+=09}
+
+=09if (wreq->origin =3D=3D NETFS_DIO_WRITE)
+=09=09inode_dio_end(wreq->inode);
+
+=09_debug("finished");
+=09netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wak=
e_ip);
+=09/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
+
+=09if (wreq->iocb) {
+=09=09size_t written =3D umin(wreq->transferred, wreq->len);
+
+=09=09wreq->iocb->ki_pos +=3D written;
+=09=09if (wreq->iocb->ki_complete) {
+=09=09=09trace_netfs_rreq(wreq, netfs_rreq_trace_ki_complete);
+=09=09=09wreq->iocb->ki_complete(wreq->iocb, wreq->error ?: written);
+=09=09}
+=09=09wreq->iocb =3D VFS_PTR_POISON;
+=09}
+
+=09netfs_clear_subrequests(wreq);
+}
+
+/*
+ * Collect the subrequest results of unbuffered write subrequests.
+ */
+static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
+=09=09=09=09=09   struct netfs_io_stream *stream,
+=09=09=09=09=09   struct netfs_io_subrequest *subreq)
+{
+=09trace_netfs_collect_sreq(wreq, subreq);
+
+=09spin_lock(&wreq->lock);
+=09list_del_init(&subreq->rreq_link);
+=09spin_unlock(&wreq->lock);
+
+=09wreq->transferred +=3D subreq->transferred;
+=09iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+
+=09stream->collected_to =3D subreq->start + subreq->transferred;
+=09wreq->collected_to =3D stream->collected_to;
+=09netfs_put_subrequest(subreq, netfs_sreq_trace_put_done);
+
+=09trace_netfs_collect_stream(wreq, stream);
+=09trace_netfs_collect_state(wreq, wreq->collected_to, 0);
+}
+
+/*
+ * Write data to the server without going through the pagecache and withou=
t
+ * writing it to the local cache.  We dispatch the subrequests serially an=
d
+ * wait for each to complete before dispatching the next, lest we leave a =
gap
+ * in the data written due to a failure such as ENOSPC.  We could, however
+ * attempt to do preparation such as content encryption for the next subre=
q
+ * whilst the current is in progress.
+ */
+static int netfs_unbuffered_write(struct netfs_io_request *wreq)
+{
+=09struct netfs_io_subrequest *subreq =3D NULL;
+=09struct netfs_io_stream *stream =3D &wreq->io_streams[0];
+=09int ret;
+
+=09_enter("%llx", wreq->len);
+
+=09if (wreq->origin =3D=3D NETFS_DIO_WRITE)
+=09=09inode_dio_begin(wreq->inode);
+
+=09stream->collected_to =3D wreq->start;
+
+=09for (;;) {
+=09=09bool retry =3D false;
+
+=09=09if (!subreq) {
+=09=09=09netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred=
);
+=09=09=09subreq =3D stream->construct;
+=09=09=09stream->construct =3D NULL;
+=09=09=09stream->front =3D NULL;
+=09=09}
+
+=09=09/* Check if (re-)preparation failed. */
+=09=09if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
+=09=09=09netfs_write_subrequest_terminated(subreq, subreq->error);
+=09=09=09wreq->error =3D subreq->error;
+=09=09=09break;
+=09=09}
+
+=09=09iov_iter_truncate(&subreq->io_iter, wreq->len - wreq->transferred);
+=09=09if (!iov_iter_count(&subreq->io_iter))
+=09=09=09break;
+
+=09=09subreq->len =3D netfs_limit_iter(&subreq->io_iter, 0,
+=09=09=09=09=09       stream->sreq_max_len,
+=09=09=09=09=09       stream->sreq_max_segs);
+=09=09iov_iter_truncate(&subreq->io_iter, subreq->len);
+=09=09stream->submit_extendable_to =3D subreq->len;
+
+=09=09trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+=09=09stream->issue_write(subreq);
+
+=09=09/* Async, need to wait. */
+=09=09netfs_wait_for_in_progress_stream(wreq, stream);
+
+=09=09if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+=09=09=09retry =3D true;
+=09=09} else if (test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
+=09=09=09ret =3D subreq->error;
+=09=09=09wreq->error =3D ret;
+=09=09=09netfs_see_subrequest(subreq, netfs_sreq_trace_see_failed);
+=09=09=09subreq =3D NULL;
+=09=09=09break;
+=09=09}
+=09=09ret =3D 0;
+
+=09=09if (!retry) {
+=09=09=09netfs_unbuffered_write_collect(wreq, stream, subreq);
+=09=09=09subreq =3D NULL;
+=09=09=09if (wreq->transferred >=3D wreq->len)
+=09=09=09=09break;
+=09=09=09if (!wreq->iocb && signal_pending(current)) {
+=09=09=09=09ret =3D wreq->transferred ? -EINTR : -ERESTARTSYS;
+=09=09=09=09trace_netfs_rreq(wreq, netfs_rreq_trace_intr);
+=09=09=09=09break;
+=09=09=09}
+=09=09=09continue;
+=09=09}
+
+=09=09/* We need to retry the last subrequest, so first reset the
+=09=09 * iterator, taking into account what, if anything, we managed
+=09=09 * to transfer.
+=09=09 */
+=09=09subreq->error =3D -EAGAIN;
+=09=09trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+=09=09if (subreq->transferred > 0)
+=09=09=09iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+
+=09=09if (stream->source =3D=3D NETFS_UPLOAD_TO_SERVER &&
+=09=09    wreq->netfs_ops->retry_request)
+=09=09=09wreq->netfs_ops->retry_request(wreq, stream);
+
+=09=09__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+=09=09__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
+=09=09__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
+=09=09subreq->io_iter=09=09=3D wreq->buffer.iter;
+=09=09subreq->start=09=09=3D wreq->start + wreq->transferred;
+=09=09subreq->len=09=09=3D wreq->len   - wreq->transferred;
+=09=09subreq->transferred=09=3D 0;
+=09=09subreq->retry_count=09+=3D 1;
+=09=09stream->sreq_max_len=09=3D UINT_MAX;
+=09=09stream->sreq_max_segs=09=3D INT_MAX;
+
+=09=09netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+=09=09stream->prepare_write(subreq);
+
+=09=09__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+=09=09netfs_stat(&netfs_n_wh_retry_write_subreq);
+=09}
+
+=09netfs_unbuffered_write_done(wreq);
+=09_leave(" =3D %d", ret);
+=09return ret;
+}
+
+static void netfs_unbuffered_write_async(struct work_struct *work)
+{
+=09struct netfs_io_request *wreq =3D container_of(work, struct netfs_io_re=
quest, work);
+
+=09netfs_unbuffered_write(wreq);
+=09netfs_put_request(wreq, netfs_rreq_trace_put_complete);
+}
+
 /*
  * Perform an unbuffered write where we may have to do an RMW operation on=
 an
  * encrypted file.  This can also be used for direct I/O writes.
@@ -70,35 +266,35 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kioc=
b *iocb, struct iov_iter *
 =09=09=09 */
 =09=09=09wreq->buffer.iter =3D *iter;
 =09=09}
+
+=09=09wreq->len =3D iov_iter_count(&wreq->buffer.iter);
 =09}
=20
 =09__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
-=09if (async)
-=09=09__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
=20
 =09/* Copy the data into the bounce buffer and encrypt it. */
 =09// TODO
=20
 =09/* Dispatch the write. */
 =09__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-=09if (async)
-=09=09wreq->iocb =3D iocb;
-=09wreq->len =3D iov_iter_count(&wreq->buffer.iter);
-=09ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
-=09if (ret < 0) {
-=09=09_debug("begin =3D %zd", ret);
-=09=09goto out;
-=09}
=20
-=09if (!async) {
-=09=09ret =3D netfs_wait_for_write(wreq);
-=09=09if (ret > 0)
-=09=09=09iocb->ki_pos +=3D ret;
-=09} else {
+=09if (async) {
+=09=09INIT_WORK(&wreq->work, netfs_unbuffered_write_async);
+=09=09wreq->iocb =3D iocb;
+=09=09queue_work(system_dfl_wq, &wreq->work);
 =09=09ret =3D -EIOCBQUEUED;
+=09} else {
+=09=09ret =3D netfs_unbuffered_write(wreq);
+=09=09if (ret < 0) {
+=09=09=09_debug("begin =3D %zd", ret);
+=09=09} else {
+=09=09=09iocb->ki_pos +=3D wreq->transferred;
+=09=09=09ret =3D wreq->transferred ?: wreq->error;
+=09=09}
+
+=09=09netfs_put_request(wreq, netfs_rreq_trace_put_complete);
 =09}
=20
-out:
 =09netfs_put_request(wreq, netfs_rreq_trace_put_return);
 =09return ret;
=20
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 4319611f5354..d436e20d3418 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -198,6 +198,9 @@ struct netfs_io_request *netfs_create_write_req(struct =
address_space *mapping,
 =09=09=09=09=09=09struct file *file,
 =09=09=09=09=09=09loff_t start,
 =09=09=09=09=09=09enum netfs_io_origin origin);
+void netfs_prepare_write(struct netfs_io_request *wreq,
+=09=09=09 struct netfs_io_stream *stream,
+=09=09=09 loff_t start);
 void netfs_reissue_write(struct netfs_io_stream *stream,
 =09=09=09 struct netfs_io_subrequest *subreq,
 =09=09=09 struct iov_iter *source);
@@ -212,7 +215,6 @@ int netfs_advance_writethrough(struct netfs_io_request =
*wreq, struct writeback_c
 =09=09=09       struct folio **writethrough_cache);
 ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct write=
back_control *wbc,
 =09=09=09       struct folio *writethrough_cache);
-int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, s=
ize_t len);
=20
 /*
  * write_retry.c
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 61eab34ea67e..83eb3dc1adf8 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -399,27 +399,6 @@ bool netfs_write_collection(struct netfs_io_request *w=
req)
 =09=09ictx->ops->invalidate_cache(wreq);
 =09}
=20
-=09if ((wreq->origin =3D=3D NETFS_UNBUFFERED_WRITE ||
-=09     wreq->origin =3D=3D NETFS_DIO_WRITE) &&
-=09    !wreq->error)
-=09=09netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferr=
ed);
-
-=09if (wreq->origin =3D=3D NETFS_DIO_WRITE &&
-=09    wreq->mapping->nrpages) {
-=09=09/* mmap may have got underfoot and we may now have folios
-=09=09 * locally covering the region we just wrote.  Attempt to
-=09=09 * discard the folios, but leave in place any modified locally.
-=09=09 * ->write_iter() is prevented from interfering by the DIO
-=09=09 * counter.
-=09=09 */
-=09=09pgoff_t first =3D wreq->start >> PAGE_SHIFT;
-=09=09pgoff_t last =3D (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT=
;
-=09=09invalidate_inode_pages2_range(wreq->mapping, first, last);
-=09}
-
-=09if (wreq->origin =3D=3D NETFS_DIO_WRITE)
-=09=09inode_dio_end(wreq->inode);
-
 =09_debug("finished");
 =09netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wak=
e_ip);
 =09/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 34894da5a23e..437268f65640 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -154,9 +154,9 @@ EXPORT_SYMBOL(netfs_prepare_write_failed);
  * Prepare a write subrequest.  We need to allocate a new subrequest
  * if we don't have one.
  */
-static void netfs_prepare_write(struct netfs_io_request *wreq,
-=09=09=09=09struct netfs_io_stream *stream,
-=09=09=09=09loff_t start)
+void netfs_prepare_write(struct netfs_io_request *wreq,
+=09=09=09 struct netfs_io_stream *stream,
+=09=09=09 loff_t start)
 {
 =09struct netfs_io_subrequest *subreq;
 =09struct iov_iter *wreq_iter =3D &wreq->buffer.iter;
@@ -698,41 +698,6 @@ ssize_t netfs_end_writethrough(struct netfs_io_request=
 *wreq, struct writeback_c
 =09return ret;
 }
=20
-/*
- * Write data to the server without going through the pagecache and withou=
t
- * writing it to the local cache.
- */
-int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, s=
ize_t len)
-{
-=09struct netfs_io_stream *upload =3D &wreq->io_streams[0];
-=09ssize_t part;
-=09loff_t start =3D wreq->start;
-=09int error =3D 0;
-
-=09_enter("%zx", len);
-
-=09if (wreq->origin =3D=3D NETFS_DIO_WRITE)
-=09=09inode_dio_begin(wreq->inode);
-
-=09while (len) {
-=09=09// TODO: Prepare content encryption
-
-=09=09_debug("unbuffered %zx", len);
-=09=09part =3D netfs_advance_write(wreq, upload, start, len, false);
-=09=09start +=3D part;
-=09=09len -=3D part;
-=09=09rolling_buffer_advance(&wreq->buffer, part);
-=09=09if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags))
-=09=09=09netfs_wait_for_paused_write(wreq);
-=09=09if (test_bit(NETFS_RREQ_FAILED, &wreq->flags))
-=09=09=09break;
-=09}
-
-=09netfs_end_issue_write(wreq);
-=09_leave(" =3D %d", error);
-=09return error;
-}
-
 /*
  * Write some of a pending folio data back to the server and/or the cache.
  */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 64a382fbc31a..2d366be46a1c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -57,6 +57,7 @@
 =09EM(netfs_rreq_trace_done,=09=09"DONE   ")=09\
 =09EM(netfs_rreq_trace_end_copy_to_cache,=09"END-C2C")=09\
 =09EM(netfs_rreq_trace_free,=09=09"FREE   ")=09\
+=09EM(netfs_rreq_trace_intr,=09=09"INTR   ")=09\
 =09EM(netfs_rreq_trace_ki_complete,=09"KI-CMPL")=09\
 =09EM(netfs_rreq_trace_recollect,=09=09"RECLLCT")=09\
 =09EM(netfs_rreq_trace_redirty,=09=09"REDIRTY")=09\
@@ -169,7 +170,8 @@
 =09EM(netfs_sreq_trace_put_oom,=09=09"PUT OOM    ")=09\
 =09EM(netfs_sreq_trace_put_wip,=09=09"PUT WIP    ")=09\
 =09EM(netfs_sreq_trace_put_work,=09=09"PUT WORK   ")=09\
-=09E_(netfs_sreq_trace_put_terminated,=09"PUT TERM   ")
+=09EM(netfs_sreq_trace_put_terminated,=09"PUT TERM   ")=09\
+=09E_(netfs_sreq_trace_see_failed,=09=09"SEE FAILED ")
=20
 #define netfs_folio_traces=09=09=09=09=09\
 =09EM(netfs_folio_is_uptodate,=09=09"mod-uptodate")=09\


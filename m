Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA03A3838
	for <netfs@lists.linux.dev>; Wed, 25 Mar 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426829; cv=none; b=tPmsxf1ofjqjoq6i9D93rGA7DN1mcpcxpezxlfD8s5drtdQZk6YVQJsCcVub7kRbIVGR7w2yPW6dLoCkxMN5dLhXUp4Z2NxCKh+28/MIKrlnHQ61GMliTNV55hMWmYKpWrUj21I7VyHJdiQHPG6n/ZUkYCRY8/rE/kWB79B5BS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426829; c=relaxed/simple;
	bh=pExODiNfKzVmgMNBUt6wk2TSsyw1IPy0527+xjf/rHc=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=H0NoynDPKix46y04aIDVtJDJ1l+4/shQgard/BpFFEuO1DxQ8ZHuNhAfZ+6ww630bcV61fQO1PMpoWPu+mpNu9ea6OqPlPDal/7iM9fz3pDXpfnGn/NWyBRmyZ248J+xFvVIseb0ynaqjDQ0FzJxRDGYPFmz6qA3fS238W0zJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHHurqzp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHHurqzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774426827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HtTnOWrlUe8bnPVa1us7WpSlgCgUpxSqgIw/xOXcChA=;
	b=LHHurqzpFVP6cwmBrPMovMwcrwNXtPWmL5JK4O3tAMd/rX8UKJZa7sv3tamPdobKrEMJpS
	ih39sw0cjtiQ27+SBuGLq7WU4LqyjazqmyvFZNxIZwMe+93d/ASgaGEl+GU2vWPCkbGoL+
	IflTWHPkR+FpP/Fcnjfd0vWKgGEuTDw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-JAXTgc5dPWOrVNwpyb0Kww-1; Wed,
 25 Mar 2026 04:20:22 -0400
X-MC-Unique: JAXTgc5dPWOrVNwpyb0Kww-1
X-Mimecast-MFC-AGG-ID: JAXTgc5dPWOrVNwpyb0Kww_1774426821
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4996B195608A;
	Wed, 25 Mar 2026 08:20:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4417E300019F;
	Wed, 25 Mar 2026 08:20:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix the handling of stream->front by removing it
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 25 Mar 2026 08:20:17 +0000
Message-ID: <4158599.1774426817@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Tc9FSewi38RKSB48ewPl7bWbBf5veMiahIszbFZG-Fk_1774426821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4158598.1774426817.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

The netfs_io_stream::front member is meant to point to the subrequest
currently being collected on a stream, but it isn't actually used this way
by direct write (which mostly ignores it).  However, there's a tracepoint
which looks at it.  Further, stream->front is actually redundant with
stream->subrequests.next.

Fix the potential problem in the direct code by just removing the member
and using stream->subrequests.next instead, thereby also simplifying the
code.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subreque=
sts in strict sequence")
Reported-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c     |    3 +--
 fs/netfs/direct_read.c       |    3 +--
 fs/netfs/direct_write.c      |    1 -
 fs/netfs/read_collect.c      |    4 ++--
 fs/netfs/read_single.c       |    1 -
 fs/netfs/write_collect.c     |    4 ++--
 fs/netfs/write_issue.c       |    3 +--
 include/linux/netfs.h        |    1 -
 include/trace/events/netfs.h |    8 ++++----
 9 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 88a0d801525f..a8c0d86118c5 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -171,9 +171,8 @@ static void netfs_queue_read(struct netfs_io_request *r=
req,
 =09spin_lock(&rreq->lock);
 =09list_add_tail(&subreq->rreq_link, &stream->subrequests);
 =09if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-=09=09stream->front =3D subreq;
 =09=09if (!stream->active) {
-=09=09=09stream->collected_to =3D stream->front->start;
+=09=09=09stream->collected_to =3D subreq->start;
 =09=09=09/* Store list pointers before active flag */
 =09=09=09smp_store_release(&stream->active, true);
 =09=09}
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a498ee8d6674..f72e6da88cca 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -71,9 +71,8 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_i=
o_request *rreq)
 =09=09spin_lock(&rreq->lock);
 =09=09list_add_tail(&subreq->rreq_link, &stream->subrequests);
 =09=09if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-=09=09=09stream->front =3D subreq;
 =09=09=09if (!stream->active) {
-=09=09=09=09stream->collected_to =3D stream->front->start;
+=09=09=09=09stream->collected_to =3D subreq->start;
 =09=09=09=09/* Store list pointers before active flag */
 =09=09=09=09smp_store_release(&stream->active, true);
 =09=09=09}
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 4d9760e36c11..f9ab69de3e29 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -111,7 +111,6 @@ static int netfs_unbuffered_write(struct netfs_io_reque=
st *wreq)
 =09=09=09netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred=
);
 =09=09=09subreq =3D stream->construct;
 =09=09=09stream->construct =3D NULL;
-=09=09=09stream->front =3D NULL;
 =09=09}
=20
 =09=09/* Check if (re-)preparation failed. */
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 137f0e28a44c..e5f6665b3341 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -205,7 +205,8 @@ static void netfs_collect_read_results(struct netfs_io_=
request *rreq)
 =09 * in progress.  The issuer thread may be adding stuff to the tail
 =09 * whilst we're doing this.
 =09 */
-=09front =3D READ_ONCE(stream->front);
+=09front =3D list_first_entry_or_null(&stream->subrequests,
+=09=09=09=09=09 struct netfs_io_subrequest, rreq_link);
 =09while (front) {
 =09=09size_t transferred;
=20
@@ -301,7 +302,6 @@ static void netfs_collect_read_results(struct netfs_io_=
request *rreq)
 =09=09list_del_init(&front->rreq_link);
 =09=09front =3D list_first_entry_or_null(&stream->subrequests,
 =09=09=09=09=09=09 struct netfs_io_subrequest, rreq_link);
-=09=09stream->front =3D front;
 =09=09spin_unlock(&rreq->lock);
 =09=09netfs_put_subrequest(remove,
 =09=09=09=09     notes & ABANDON_SREQ ?
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 8e6264f62a8f..d0e23bc42445 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -107,7 +107,6 @@ static int netfs_single_dispatch_read(struct netfs_io_r=
equest *rreq)
 =09spin_lock(&rreq->lock);
 =09list_add_tail(&subreq->rreq_link, &stream->subrequests);
 =09trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-=09stream->front =3D subreq;
 =09/* Store list pointers before active flag */
 =09smp_store_release(&stream->active, true);
 =09spin_unlock(&rreq->lock);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 83eb3dc1adf8..b194447f4b11 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -228,7 +228,8 @@ static void netfs_collect_write_results(struct netfs_io=
_request *wreq)
 =09=09if (!smp_load_acquire(&stream->active))
 =09=09=09continue;
=20
-=09=09front =3D stream->front;
+=09=09front =3D list_first_entry_or_null(&stream->subrequests,
+=09=09=09=09=09=09 struct netfs_io_subrequest, rreq_link);
 =09=09while (front) {
 =09=09=09trace_netfs_collect_sreq(wreq, front);
 =09=09=09//_debug("sreq [%x] %llx %zx/%zx",
@@ -279,7 +280,6 @@ static void netfs_collect_write_results(struct netfs_io=
_request *wreq)
 =09=09=09list_del_init(&front->rreq_link);
 =09=09=09front =3D list_first_entry_or_null(&stream->subrequests,
 =09=09=09=09=09=09=09 struct netfs_io_subrequest, rreq_link);
-=09=09=09stream->front =3D front;
 =09=09=09spin_unlock(&wreq->lock);
 =09=09=09netfs_put_subrequest(remove,
 =09=09=09=09=09     notes & SAW_FAILURE ?
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 437268f65640..2db688f94125 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -206,9 +206,8 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 =09spin_lock(&wreq->lock);
 =09list_add_tail(&subreq->rreq_link, &stream->subrequests);
 =09if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-=09=09stream->front =3D subreq;
 =09=09if (!stream->active) {
-=09=09=09stream->collected_to =3D stream->front->start;
+=09=09=09stream->collected_to =3D subreq->start;
 =09=09=09/* Write list pointers before active flag */
 =09=09=09smp_store_release(&stream->active, true);
 =09=09}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 72ee7d210a74..ba17ac5bf356 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -140,7 +140,6 @@ struct netfs_io_stream {
 =09void (*issue_write)(struct netfs_io_subrequest *subreq);
 =09/* Collection tracking */
 =09struct list_head=09subrequests;=09/* Contributory I/O operations */
-=09struct netfs_io_subrequest *front;=09/* Op being collected */
 =09unsigned long long=09collected_to;=09/* Position we've collected result=
s to */
 =09size_t=09=09=09transferred;=09/* The amount transferred from this strea=
m */
 =09unsigned short=09=09error;=09=09/* Aggregate error for the stream */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 2d366be46a1c..cbe28211106c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -740,19 +740,19 @@ TRACE_EVENT(netfs_collect_stream,
 =09=09    __field(unsigned int,=09wreq)
 =09=09    __field(unsigned char,=09stream)
 =09=09    __field(unsigned long long,=09collected_to)
-=09=09    __field(unsigned long long,=09front)
+=09=09    __field(unsigned long long,=09issued_to)
 =09=09=09     ),
=20
 =09    TP_fast_assign(
 =09=09    __entry->wreq=09=3D wreq->debug_id;
 =09=09    __entry->stream=09=3D stream->stream_nr;
 =09=09    __entry->collected_to =3D stream->collected_to;
-=09=09    __entry->front=09=3D stream->front ? stream->front->start : UINT=
_MAX;
+=09=09    __entry->issued_to=09=3D atomic64_read(&wreq->issued_to);
 =09=09=09   ),
=20
-=09    TP_printk("R=3D%08x[%x:] cto=3D%llx frn=3D%llx",
+=09    TP_printk("R=3D%08x[%x:] cto=3D%llx ito=3D%llx",
 =09=09      __entry->wreq, __entry->stream,
-=09=09      __entry->collected_to, __entry->front)
+=09=09      __entry->collected_to, __entry->issued_to)
 =09    );
=20
 TRACE_EVENT(netfs_folioq,


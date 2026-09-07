Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB948C41C
	for <netfs@lists.linux.dev>; Mon,  7 Sep 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783707; cv=none; b=rwodQ8lelVJqrCHTlCo2DCVGKz/XakOFEnsaiDzrKAJAEsPac0j1J/YEy79jUB58On1H8uq/5TXA6In/0AJN5bdm0sR4hgEvprEdFHP/KiVxIWZccpuWA2McpTxLv+2iiTOTv3hFXKxuxHSU+3jPz4V5pZF2e3mjyudSEMRbV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783707; c=relaxed/simple;
	bh=68tLkWKHL08reJpoI6NdD7dee5H1BtmaXZyMPdjy9d4=;
	h=From:To:Cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=rVuvAnCcXZBs6tQD0H7UDC+h91h9NnxMnNZx2z2HJCgJX7OJTXBBBG8agFijvQdd0qMmoWmeMZPg1mSGEZN2M3QLQ8ZY4S4yONTug+R791eyvi88U380xn90oAg+rdiUS5du78aj3BRdvA8ATkMnnZIZh/yugUQndX/5xDl5U4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1rrIzcF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1rrIzcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788783705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tS+/WiM6eBWy5z5ACKy565cUIMpFCERPv8bc+Oigirk=;
	b=P1rrIzcF6iXqVu9trFQiAF82mQZWBJmeeI2mDAXrQCnumfGRmkd2eYXVzmz6WEZwZ5sYQu
	ZZSrgYwTRSCS8o6OxYoEhLLlovL1ag1N5BkyaA6kckw75xZTKe+xrINpIvCX6gK/RTYRWR
	quNo4ljvHdgYNgoS8z3jZSS7cRXgmbs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-hSxBCpqxN1K3cjr3LmQsPA-1; Mon,
 07 Sep 2026 08:21:41 -0400
X-MC-Unique: hSxBCpqxN1K3cjr3LmQsPA-1
X-Mimecast-MFC-AGG-ID: hSxBCpqxN1K3cjr3LmQsPA_1788783700
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97FFE180AE2D;
	Mon,  7 Sep 2026 12:21:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E664830002F0;
	Mon,  7 Sep 2026 12:21:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: dhowells@redhat.com, Keith Busch <kbusch@kernel.org>,
    Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v3] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 07 Sep 2026 13:21:34 +0100
Message-ID: <1456602.1788783694@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: sb1nlZPWH_OF0Q5RwaZ1v3784aVKp07Lfb7hNwa54cI_1788783700
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1456601.1788783694.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

   =20
Commit 14b007e17881 added an address check using iter_iov_addr() and a
length check using iter_iov_len() to iov_iter_extract_bvecs(), but these
cannot be used so and are unsafe in this circumstance as the functions have
hardwired assumptions about the iterator type.  They should only be used
with ITER_UBUF or ITER_IOVEC-type iterators; they shouldn't be used with
ITER_BVEC, ITER_KVEC, ITER_FOLIOQ, ITER_XARRAY or ITER_DISCARD iterators.

This proves to be a problem for cachefiles as an iterator of type
ITER_FOLIOQ is passed and iter_iov_addr() and iter_iov_len() both
malfunction because iter->__iov in iter_iov() is not pointing to an iovec
array.

Fix this by using iov_iter_alignment() instead.

Fixes: 14b007e17881 ("block: validate user space vectors during extraction"=
)
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
cc: Hannes Reinecke <hare@kernel.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/iov_iter.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6665372ecf71..5e9f9e2c30b1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1921,15 +1921,29 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *ite=
r, struct bio_vec *bv,
 =09=09unsigned short max_vecs, unsigned mem_align_mask,
 =09=09iov_iter_extraction_t extraction_flags)
 {
-=09unsigned long start =3D (unsigned long)iter_iov_addr(iter);
 =09unsigned short entries_left =3D max_vecs - *nr_vecs;
 =09unsigned short nr_pages, i =3D 0;
 =09size_t left, offset, len;
 =09struct page **pages;
 =09ssize_t size;
=20
-=09if ((start | iter_iov_len(iter)) & mem_align_mask)
+=09/*
+=09 * DMA engines typically have both memory address and length alignment
+=09 * requirements, so check these against the alignment mask.  For UBUF,
+=09 * IOVEC and KVEC, only the current segment will be drawn from; for
+=09 * everything else we might draw from multiple segments, so we need to
+=09 * check those too.
+=09 */
+=09if (likely(iter_is_ubuf(iter) ||
+=09=09   iter_is_iovec(iter) ||
+=09=09   iov_iter_is_kvec(iter))) {
+=09=09unsigned long start =3D (unsigned long)iter_iov_addr(iter);
+
+=09=09if ((start | iter_iov_len(iter)) & mem_align_mask)
+=09=09=09return -EINVAL;
+=09} else if (iov_iter_alignment(iter) & mem_align_mask) {
 =09=09return -EINVAL;
+=09}
=20
 =09/*
 =09 * Move page array up in the allocated memory for the bio vecs as far a=
s


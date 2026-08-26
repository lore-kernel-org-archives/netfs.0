Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0D399342
	for <netfs@lists.linux.dev>; Wed, 26 Aug 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768348; cv=none; b=gFIpJMRpheL4LV9VkrxIMqtB3tbuZpBWEd0418wOpFKY8ZCgpSsVjZ/gTQYDLC5z7CUX8i65OWCwy9D9a0bcO6JYoJZGC6cOmtUQzbtYm6KpcvCcOIxsFgq9vns5fXubCSCbK7UVLJdTXLtxQxbx8UUaRs1aRfyxxuyzdYmVJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768348; c=relaxed/simple;
	bh=dyCNTsbr+3zHrvausn0SltBKG/4t7Sicrg0gVtZLVMo=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=GeJgMMhcw4X6egb/9gu0Eldxnv9UvATwYtRXondxHl7Khcg9DRwgVhvov4bwdxN9khCS4PrTrAnBcFjpAvSszUkAbVNx7OdnvjV5p0pq0IKVlIsfoOfUwiHiVtOTORo4gvSWALqTaZNL5GGKsjkHKMQSFi1X1o6RhoO0Km8rABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dC9nxLFp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC9nxLFp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787768330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MrjAM3Ub0GRusrNoNmZPjX4fsQ5Bn2FsvWOzOeJjTKE=;
	b=dC9nxLFpxI4no7Z+9VtUwCdfM1XEokTTWAnLluBr1uthWYR9ZjOAjLyvxhjdZLR0cgkTzX
	J8L1JiZFzn21IY+SLJEAc4WpBKUMSjlAYsVRKiyB2IPv0p0mUB2Sl8asjuY7kxDg3iSPMC
	GcgLvi/ImqtkFR5cIFhlvCnJKHYTGRQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-MU81NohkMrC9ScSVlfdo7A-1; Wed,
 26 Aug 2026 14:18:44 -0400
X-MC-Unique: MU81NohkMrC9ScSVlfdo7A-1
X-Mimecast-MFC-AGG-ID: MU81NohkMrC9ScSVlfdo7A_1787768322
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AB521955E97;
	Wed, 26 Aug 2026 18:18:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 330271955F0B;
	Wed, 26 Aug 2026 18:18:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: dhowells@redhat.com, Keith Busch <kbusch@kernel.org>,
    Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 19:18:37 +0100
Message-ID: <1819786.1787768317@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: Ux30-VBhQKktzxNB_jAEv0IZBXLlYtFTenl-gzZ1vaw_1787768322
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1819785.1787768317.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Commit 14b007e17881 added an address check using iter_iov_addr() and a
length check using iter_iov_len() to iov_iter_extract_bvecs(), but these
cannot be used so and are unsafe in this circumstance as the functions have
hardwired assumptions about the iterator type.  They should only be used
with ITER_UBUF or ITER_IOVEC-type iterators; they should not be used with
ITER_BVEC, ITER_KVEC, ITER_FOLIOQ, ITER_XARRAY or ITER_DISCARD iterators.

This change proved to be a problem for cachefiles as an iterator of type
ITER_FOLIOQ is passed and iter_iov_addr() and iter_iov_len() both
malfunction because iter->__iov in iter_iov() is not pointing to an iovec
array.

Fix this by using iov_iter_alignment() instead.

Fixes: 14b007e17881 ("block: validate user space vectors during extraction"=
)
cc: Keith Busch <kbusch@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Hannes Reinecke <hare@kernel.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6665372ecf71..6df716e19247 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1921,15 +1921,19 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *ite=
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
+=09if (iov_iter_alignment(iter) & mem_align_mask) {
+=09=09pr_warn("%u %zx %x\n",
+=09=09=09iter->iter_type,
+=09=09=09iov_iter_alignment(iter),
+=09=09=09mem_align_mask);
 =09=09return -EINVAL;
+=09}
=20
 =09/*
 =09 * Move page array up in the allocated memory for the bio vecs as far a=
s


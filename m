Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84942D592E
	for <netfs@lists.linux.dev>; Sat,  7 Mar 2026 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772891482; cv=none; b=LCY/hT9a0ONEVDpy68EzXzvtkyWZin3Z4Imc0GhoI9TykhhzKiRXc7qizoTg9Do6D252cne4QR750LbPzVRdxLIz0Y4Zk0UVHkb+mZQAzYlbtgd1nYEBRr+zkxJzoUGGtxv2s9Rw6qCR7aSa7EKPvwoAIyAc5k94oVGdkD4CLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772891482; c=relaxed/simple;
	bh=chtNgnf5SugJbkxtvLkkSQtqri4+X7enpaiXnhtj91A=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=NBQcuLQn5jdzmqXy7Vz3iSrPPU8HYbo5hAi4gix+QeAbUk6ehdOKkhK15h7EfTx2bPXjs4PD8UpwxsEthBJzWoBDhL8pZTiPKpJ4HkfcVDFpN5COWtx/Pemu8psWQG7Mqv6/lWIaJGJDK+lla4xHtFYyWk6a0kGLMQnO9LKeauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1GUFo8O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1GUFo8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772891480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPji3cHy1Fp5srQQejt6cgRP8RXARUi/CYqsnslgyjM=;
	b=D1GUFo8OWwywf8WrFy3OScqL+SoQEAjmv606SEm2UNdLkbWqn5pMwyoFyPUoa+1Gmp/UM7
	KHweVQZg5owDDtX/HHBq3TsUUp0bQJ74O2z2vEzJ+22t0BWiOES+U2aEI/g9Fjkt846pcg
	p/4sf/C3hyZ70IT6S+K0/QDOnzN3IuQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-umFDJX_VMk2IyFMRY3ayaQ-1; Sat,
 07 Mar 2026 08:51:14 -0500
X-MC-Unique: umFDJX_VMk2IyFMRY3ayaQ-1
X-Mimecast-MFC-AGG-ID: umFDJX_VMk2IyFMRY3ayaQ_1772891473
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2090119560B2;
	Sat,  7 Mar 2026 13:51:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8410E1956095;
	Sat,  7 Mar 2026 13:51:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <69aa75e2.050a0220.13f275.000f.GAE@google.com>
References: <69aa75e2.050a0220.13f275.000f.GAE@google.com>
To: syzbot <syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, Deepanshu Kartikey <kartikey406@gmail.com>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, pc@manguebit.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in netfs_limit_iter
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 07 Mar 2026 13:51:09 +0000
Message-ID: <683930.1772891469@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: PhsD5huxw-O0aWWby8Vw68TbJ8ekktTUKx2K3WAIn5Y_1772891473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <683929.1772891469.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 c107785c7e8d

commit c4449647436e654c150cf5fdb70a64a9d02283a1
Author: Deepanshu Kartikey <kartikey406@gmail.com>
Date:   Sat Mar 7 14:30:41 2026 +0530

    netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
   =20
    When a process crashes and the kernel writes a core dump to a 9P
    filesystem, __kernel_write() creates an ITER_KVEC iterator. This
    iterator reaches netfs_limit_iter() via netfs_unbuffered_write(), which
    only handles ITER_FOLIOQ, ITER_BVEC and ITER_XARRAY iterator types,
    hitting the BUG() for any other type.
   =20
    Fix this by adding netfs_limit_kvec() following the same pattern as
    netfs_limit_bvec(), since both kvec and bvec are simple segment arrays
    with pointer and length fields. Dispatch it from netfs_limit_iter() whe=
n
    the iterator type is ITER_KVEC.
   =20
    Fixes: cae932d3aee5 ("netfs: Add func to calculate pagecount/size-limit=
ed span of an iterator")
    Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D9c058f0d63475adc97fd
    Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
    Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 72a435e5fc6d..154a14bb2d7f 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -142,6 +142,47 @@ static size_t netfs_limit_bvec(const struct iov_iter *=
iter, size_t start_offset,
 =09return min(span, max_size);
 }
=20
+/*
+ * Select the span of a kvec iterator we're going to use.  Limit it by bot=
h
+ * maximum size and maximum number of segments.  Returns the size of the s=
pan
+ * in bytes.
+ */
+static size_t netfs_limit_kvec(const struct iov_iter *iter, size_t start_o=
ffset,
+=09=09=09       size_t max_size, size_t max_segs)
+{
+=09const struct kvec *kvecs =3D iter->kvec;
+=09unsigned int nkv =3D iter->nr_segs, ix =3D 0, nsegs =3D 0;
+=09size_t len, span =3D 0, n =3D iter->count;
+=09size_t skip =3D iter->iov_offset + start_offset;
+
+=09if (WARN_ON(!iov_iter_is_kvec(iter)) ||
+=09    WARN_ON(start_offset > n) ||
+=09    n =3D=3D 0)
+=09=09return 0;
+
+=09while (n && ix < nkv && skip) {
+=09=09len =3D kvecs[ix].iov_len;
+=09=09if (skip < len)
+=09=09=09break;
+=09=09skip -=3D len;
+=09=09n -=3D len;
+=09=09ix++;
+=09}
+
+=09while (n && ix < nkv) {
+=09=09len =3D min3(n, kvecs[ix].iov_len - skip, max_size);
+=09=09span +=3D len;
+=09=09nsegs++;
+=09=09ix++;
+=09=09if (span >=3D max_size || nsegs >=3D max_segs)
+=09=09=09break;
+=09=09skip =3D 0;
+=09=09n -=3D len;
+=09}
+
+=09return min(span, max_size);
+}
+
 /*
  * Select the span of an xarray iterator we're going to use.  Limit it by =
both
  * maximum size and maximum number of segments.  It is assumed that segmen=
ts
@@ -245,6 +286,8 @@ size_t netfs_limit_iter(const struct iov_iter *iter, si=
ze_t start_offset,
 =09=09return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
 =09if (iov_iter_is_xarray(iter))
 =09=09return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
+=09if (iov_iter_is_kvec(iter))
+=09=09return netfs_limit_kvec(iter, start_offset, max_size, max_segs);
 =09BUG();
 }
 EXPORT_SYMBOL(netfs_limit_iter);


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AB46D572
	for <netfs@lists.linux.dev>; Fri, 11 Sep 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118721; cv=none; b=HheriZN1Xe2UHpNICv3yZ8WmTt6uD5rjscapfMlw3VRotTmIUsGZsRidPkEguwOp56BvJBbUhfavpC4jUKN+TeZ3fCgKHgme7r0mdqrGRCv4PCtW93OkmvNoMJ3mZUMF6BFGActPhvmGJ5/ASLUytJVVpkGEIBN15f7MpxmOPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118721; c=relaxed/simple;
	bh=rkoI+1Cb2EhxXeM4XpNL5rePkKHHSu9QZGigcHdaI2E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=ca+d2+fn/df8VltE00ep/uRb0Vhlc0Bhfun9EQRLq/H4kYium29+0q29EaXFzcT1dkxqUSGE/rFniodfz34B3BShl85eiMoPrdATB/ipBNzVP3P34HV4m86KmGbMSgGdyVdVdUApvW6reXoq7WNEBOMzcedFkmX6kA1HLV21T+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMZvg+US; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMZvg+US"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789118718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CH61iaxpsfa39dF51IILqv9VRomg97Tn5nydKyidOwQ=;
	b=FMZvg+UST7M8wuOu7HeO7S0QATy8rCdzCEgnxTF1qwdhHeg2MTN5n9F9XU1vCGxnZFI/Dn
	aousLYveKeapweeA8SjIs8WervXk7SF4WAHZ/A+Ut6GpTdrlKJGzCgYC90pIzqOOhnVBOe
	r98U6fYuqenyBiNV4VlHLsaS2/K+DXE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-eaZIOypPOCSIN8c2G4TKwg-1; Fri,
 11 Sep 2026 05:25:13 -0400
X-MC-Unique: eaZIOypPOCSIN8c2G4TKwg-1
X-Mimecast-MFC-AGG-ID: eaZIOypPOCSIN8c2G4TKwg_1789118711
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99CB6195422D;
	Fri, 11 Sep 2026 09:25:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31EAD180057F;
	Fri, 11 Sep 2026 09:25:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
To: Michael Mulqueen <mike@method-b.uk>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, pc@manguebit.org, linux_oss@crudebyte.com,
    v9fs@lists.linux.dev, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL corruption of file data on cache modes with CACHE_WRITEBACK
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 10:25:04 +0100
Message-ID: <2226525.1789118704@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: sdkDitV1QXVZQzqzO4LtcG96jwzloqAnqDXKIHOAsiU_1789118711
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2226524.1789118704.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Does the attached work for you?  With it I see:

  cache=3Dnone       read   0/20  write   0/20  [cache=3D0x0]
  cache=3Dreadahead  read   0/20  write   0/20  [cache=3D0x1]
  cache=3Dmmap       read   0/20  write   0/20  [cache=3D0x5]
  cache=3Dloose      read   0/20  write   0/20  [cache=3D0xf]
  cache=3Dfscache    read   0/20  write   0/20  [cache=3D0x8f]

David
---
commit a7f0af2e23c3ab191c08c1041dc67afd971a8c49
Author: David Howells <dhowells@redhat.com>
Date:   Fri Sep 11 10:15:43 2026 +0100

    9p: Fix v9fs_issue_write() to update i_size and remote_i_size
   =20
    Fix v9fs_issue_write() to update i_size and remote_i_size to the new si=
ze
    of the server file if we made it larger, using the start fpos and the c=
ount
    returned by p9_client_write() to calculate the new minimum file size.
   =20
    This assumes that if the 9P server makes a short write (say it hits
    ENOSPC), a reduced count is returned.
   =20
    Fixes: 5fb70e7275a6 ("netfs, 9p: Implement helpers for new write code")
    Reported-by: Michael Mulqueen <mike@method-b.uk>
    Closes: https://lore.kernel.org/r/fbb9e395-1e07-4212-8f70-23f3cd498074@=
method-b.uk/
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Eric Van Hensbergen <ericvh@kernel.org>
    cc: Latchesar Ionkov <lucho@ionkov.net>
    cc: Dominique Martinet <asmadeus@codewreck.org>
    cc: Christian Schoenebeck <linux_oss@crudebyte.com>
    cc: Paulo Alcantara <pc@manguebit.org>
    cc: v9fs@lists.linux.dev
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 1ac0b3dcc077..13cf87a5f90c 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -54,11 +54,37 @@ static void v9fs_begin_writeback(struct netfs_io_reques=
t *wreq)
 static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 {
 =09struct p9_fid *fid =3D subreq->rreq->netfs_priv;
+=09struct inode *inode =3D subreq->rreq->inode;
+=09struct netfs_inode *ictx =3D netfs_inode(inode);
 =09int err, len;
=20
 =09len =3D p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
-=09if (len > 0)
+=09if (len > 0) {
+=09=09uoff_t end =3D subreq->start + len, i_size, remote, zp;
+=09=09bool set =3D false;
+
+=09=09spin_lock(&inode->i_lock);
+
+=09=09/* We can read the sizes directly as we hold i_lock. */
+=09=09i_size =3D inode->i_size;
+=09=09remote =3D ictx->_remote_i_size;
+=09=09zp =3D ictx->_zero_point;
+
+=09=09if (end > i_size) {
+=09=09=09i_size =3D end;
+=09=09=09set =3D true;
+=09=09}
+=09=09if (end > remote) {
+=09=09=09remote =3D end;
+=09=09=09set =3D true;
+=09=09}
+
+=09=09if (set)
+=09=09=09netfs_write_sizes(inode, i_size, remote, zp);
+=09=09spin_unlock(&inode->i_lock);
+
 =09=09__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+=09}
 =09netfs_write_subrequest_terminated(subreq, len ?: err);
 }
=20


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291442472AE
	for <netfs@lists.linux.dev>; Sat,  7 Mar 2026 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868432; cv=none; b=ms6w3caHLCZ4Dsgr22Oi3IEbDgw+M49x7CLLWo3pyj0LEFjyPcpEjbXSAA0mFwJXvngpa+egbI//AiMoMUfjWxfDjYC4e9TNxH2cHToZzQNcwe8/p8JuuJv+uix9P1Sdr5VCFNB+A9r7p8tfC0Ch7Y8b7buswdnPPrR1NzBrfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868432; c=relaxed/simple;
	bh=1QMAAgZY48Yqw+WyxXnTyPe9TZ78bLVfyssf1fdjCSs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=F9XQqUzkNvhcBfXxXIU9d6XbSm/BHo5nMrFevq0bCegbEbIFIVto0z3w2g1KRkq3ApGPQF9sHen/jcGHUTEI4BT9cDyw9MlgNkuuajPtWLCNpqznVce/2zgDQrNgXt4y3ythKuS/Nvw9nCdf215owOselpFxb7XZO8bd+rnGfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcw1MJA0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcw1MJA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772868429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSyukFyK0VO7CYgQ3ffHcnodQl8eA54nJ8YJgzyGTOA=;
	b=fcw1MJA02Vu7kelI0MDqjKoyCNgTknFczJg37dYZ92xTyQhVULv+ED28V34ZuA1n0D+mhQ
	O7Y5Kr9Eq16ld0RiRwPT/IE7MqE4uWcWcEnnH5hdpFlwDdrWCIb62bhFGNbS+Ly1Gx/thh
	r6pRircPka20kHi6tN1VnkM2r39s/Uo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-RyG6nwQ7MOGbrQvZ0iXstA-1; Sat,
 07 Mar 2026 02:27:05 -0500
X-MC-Unique: RyG6nwQ7MOGbrQvZ0iXstA-1
X-Mimecast-MFC-AGG-ID: RyG6nwQ7MOGbrQvZ0iXstA_1772868424
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DC1A180049D;
	Sat,  7 Mar 2026 07:27:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5B9418001FE;
	Sat,  7 Mar 2026 07:27:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <69aa75e2.050a0220.13f275.0010.GAE@google.com>
References: <69aa75e2.050a0220.13f275.0010.GAE@google.com>
To: syzbot <syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, Deepanshu Kartikey <kartikey406@gmail.com>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, pc@manguebit.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] BUG: unable to handle kernel NULL pointer dereference in netfs_unbuffered_write
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 07 Mar 2026 07:27:00 +0000
Message-ID: <675785.1772868420@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: nxdCdPhDRwcKV1fJfyCBcTfGzaE3hQZGcXlVDcYsUX0_1772868424
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <675784.1772868420.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 c107785c7e8d

commit eb8299de8f603a6d7acf50e534c87ac1adeb3060
Author: Deepanshu Kartikey <kartikey406@gmail.com>
Date:   Sat Mar 7 10:09:47 2026 +0530

    netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on retr=
y
   =20
    When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry path
    in netfs_unbuffered_write() unconditionally calls stream->prepare_write=
()
    without checking if it is NULL.
   =20
    Filesystems such as 9P do not set the prepare_write operation, so
    stream->prepare_write remains NULL. When get_user_pages() fails with
    -EFAULT and the subrequest is flagged for retry, this results in a NULL
    pointer dereference at fs/netfs/direct_write.c:189.
   =20
    Fix this by mirroring the pattern already used in write_retry.c: if
    stream->prepare_write is NULL, skip renegotiation and directly reissue
    the subrequest via netfs_reissue_write(), which handles iterator reset,
    IN_PROGRESS flag, stats update and reissue internally.
   =20
    Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subr=
equests in strict sequence")
    Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D7227db0fbac9f348dba0
    Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index dd1451bf7543..4d9760e36c11 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -186,10 +186,18 @@ static int netfs_unbuffered_write(struct netfs_io_req=
uest *wreq)
 =09=09stream->sreq_max_segs=09=3D INT_MAX;
=20
 =09=09netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-=09=09stream->prepare_write(subreq);
=20
-=09=09__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-=09=09netfs_stat(&netfs_n_wh_retry_write_subreq);
+=09=09if (stream->prepare_write) {
+=09=09=09stream->prepare_write(subreq);
+=09=09=09__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+=09=09=09netfs_stat(&netfs_n_wh_retry_write_subreq);
+=09=09} else {
+=09=09=09struct iov_iter source;
+
+=09=09=09netfs_reset_iter(subreq);
+=09=09=09source =3D subreq->io_iter;
+=09=09=09netfs_reissue_write(stream, subreq, &source);
+=09=09}
 =09}
=20
 =09netfs_unbuffered_write_done(wreq);


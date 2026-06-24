Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D55314A8E
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298990; cv=none; b=pqTXsPj/Pj0xi7O57I7N2Vv6Mji4+712jmM8OfAmcDi2+tKtHr7R5dcZLskKkBFw4Ii+4uPYFh3dk6UgPew4nd+mXU30CH3znH4UlSMK7cC64bhSsXbaryZcIB0tUtQ3cpFm5wWimCqNMbsHCmUyq+pytE2DbGvwTUibzg8lLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298990; c=relaxed/simple;
	bh=Y9VQan+woIj/I8OvDNDutX/MnG/raLfS7s+zDJ/I3q0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=EG74PncJ9b8NOqK3FPWZl0+jTv7Kx1YwYJ43eV3GGoJykfcJfDQSGWiLyVxCcMEJVvxL6uFjW3/i9jL/C9E0zTNcpx6GxCBOl6kdeGcQb8TD8o3CzvFnGLCZ6wwxZkOkmdNRHpHEuIBmRIrYz2t16yN9P2/9p27aKJXMY9zDVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6TC2Wgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6TC2Wgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782298988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMVLrRzHnH/nmyQ1Yxfvc7nj1Cz5POLuoujb9cxPpok=;
	b=V6TC2WgmmQuibsIBCiD4HQJfYhQ6MKb3Hu503jgRVekMy4O0KksFaD1IIGnLguyYPynbov
	JisGF8Zuac3SivLUoDef8JCpChVHWvTO46+iXHBqFY47gbKvtlag9KherIm1l/ldUUMQZv
	yFby93kcdFX4Tjo/aMaALQCO6V9Jv2s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-wsPcFl0KNxSnxpT9V6VKJA-1; Wed,
 24 Jun 2026 07:03:02 -0400
X-MC-Unique: wsPcFl0KNxSnxpT9V6VKJA-1
X-Mimecast-MFC-AGG-ID: wsPcFl0KNxSnxpT9V6VKJA_1782298981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C55E81801BEA;
	Wed, 24 Jun 2026 11:03:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.49.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65E491955F6F;
	Wed, 24 Jun 2026 11:02:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <498534d3-e82e-40ce-bc7d-230580b2fcae@chenxiaosong.com>
References: <498534d3-e82e-40ce-bc7d-230580b2fcae@chenxiaosong.com> <33cc8eb4-8831-49b0-80d6-b06544a37920@chenxiaosong.com> <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com> <2912807.1782231053@warthog.procyon.org.uk>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: dhowells@redhat.com, hongao <hongao@uniontech.com>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com,
    Steve French <smfrench@gmail.com>,
    Namjae Jeon <linkinjeon@kernel.org>,
    "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed preparation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 12:02:56 +0100
Message-ID: <2961399.1782298976@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: tFA-owmYwGP4y0mPM_b9xjpAKuPEEipTUv93WoGWdxM_1782298981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2961398.1782298976.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

I suspect the issue is this bit in netfs_unbuffered_write():

=09for (;;) {
=09=09...
=09=09netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);

=09=09if (stream->prepare_write) {
=09=09=09stream->prepare_write(subreq);
=09=09=09__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
=09=09=09netfs_stat(&netfs_n_wh_retry_write_subreq);
=09=09} else {
=09=09=09struct iov_iter source;

=09=09=09netfs_reset_iter(subreq);
=09=09=09source =3D subreq->io_iter;
=09=09=09netfs_reissue_write(stream, subreq, &source); <----
=09=09}
=09}

This doesn't happen with AFS because it has a ->prepare_write() method.  Do=
es
this change fix the problem for you?

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 25f8ceb15fad..9f6258da45d6 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -190,12 +190,6 @@ static int netfs_unbuffered_write(struct netfs_io_requ=
est *wreq)
 =09=09=09stream->prepare_write(subreq);
 =09=09=09__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 =09=09=09netfs_stat(&netfs_n_wh_retry_write_subreq);
-=09=09} else {
-=09=09=09struct iov_iter source;
-
-=09=09=09netfs_reset_iter(subreq);
-=09=09=09source =3D subreq->io_iter;
-=09=09=09netfs_reissue_write(stream, subreq, &source);
 =09=09}
 =09}
=20

David


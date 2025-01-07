Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37651F3D4B
	for <netfs@lists.linux.dev>; Tue,  7 Jan 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261025; cv=none; b=c8Q0WB6qMQCkieIRzrZ3DhzyNQZYgod0cFH8UCc7Dj+z2fQTNbMCBAgQpzP66zbgLDJTrp3Pn6/zPRALgZhvtxV1J3mRz50eLo0ox0Wicv95hgGMv5bmeBekqV1InudW1m+nAQh8Tg7QZX0cD9TmjkgM6Ubw7CB3gZBPM6DBjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261025; c=relaxed/simple;
	bh=sntHQIVesXD5yZEwojjjAR3H66+NwGTt5n50NGAHieE=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=L+aVC4K931FsCdsWhwYpOTh0X2elzuh9iIPUanZNunJq3t5GRpJWnmUBzt10RZl9Ex1FWc4aUzo3lPtXq9kspRCOY4Mt5LekCb91Ob1Pa5GEYkZM+XU6jbRewywU78Sp9w2VNep7SuW32gUkcvPCi2IkwuxQ4Mfm82AHfxUnv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLmTN3Tm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLmTN3Tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736261020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/UVIzz5vWxd3je9CAuSh2DO18s44N+6cEi2+ThdjS5A=;
	b=bLmTN3TmC26FWRz5nZL14W/Z7NiEL+5SI8F8N0SVGzL1QkUqqeAafjbLCHQrLi+KoxOqbh
	/oi44k++vOoWyZbpPy3nrevSlZQgYG/vX7NYgETOdHUYQ9VJfDX08fiG0IzBSBu1tyksz2
	6VHC+5aOPvjd9RQFSRyaxQomXv/nX+E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-fcV7vOimOVCYUNdHzRlwrg-1; Tue,
 07 Jan 2025 09:43:35 -0500
X-MC-Unique: fcV7vOimOVCYUNdHzRlwrg-1
X-Mimecast-MFC-AGG-ID: fcV7vOimOVCYUNdHzRlwrg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA2DE1955F2F;
	Tue,  7 Jan 2025 14:43:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03CDE1955F43;
	Tue,  7 Jan 2025 14:43:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix read-retry for fs with no ->prepare_read()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <529328.1736261010.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2025 14:43:30 +0000
Message-ID: <529329.1736261010@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix netfslib's read-retry to only call ->prepare_read() in the backing
filesystem such a function is provided.  We can get to this point if a
there's an active cache as failed reads from the cache need negotiating
with the server instead.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 21b4a54e545e..16b676c68dcd 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -152,7 +152,8 @@ static void netfs_retry_read_subrequests(struct netfs_=
io_request *rreq)
 			BUG_ON(!len);
 =

 			/* Renegotiate max_len (rsize) */
-			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
+			if (rreq->netfs_ops->prepare_read &&
+			    rreq->netfs_ops->prepare_read(subreq) < 0) {
 				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 			}


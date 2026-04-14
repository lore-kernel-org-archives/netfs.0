Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CF3AE185
	for <netfs@lists.linux.dev>; Tue, 14 Apr 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154856; cv=none; b=f9ouKVojMZk3nh7ooZ1cKzjXthk/g+mC0yu8CwaJhIM4YRpetuTVhu97YUl7mqzlZG8T4pDPqR/Y/cBu0k2GkQAEwz23dUOp7aX+RYn160Rjkfbl/xjHb7yAKxaeq8zmACTkQbqCwMTHKb23VLYHeJbeHM8IV1GNHuTNlR2KUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154856; c=relaxed/simple;
	bh=0RD9WK7Z8b1cfNWJfuywH/XVdQi+DID7QaHnobdiupA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RPk7CkuGKUXDr4jLQHvKQbiVCsq6oOMT9GNO6FYPIRN63VeBIjl8E/5QrPUzJughpcAv1gwhu+sE1XBwY3c7FgbPUBe9FkFGShJVWg3/3y50ZeWoU3Yc/mOQwd7pBoeSXoc1upezrQN6AaHGsUwqENYmvESmAJKUDkTql9T9DWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnsIgRTE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnsIgRTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776154852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwkDzJJVkIB8QUWldBqXDsmI02iLpH9t4nRKDWmeUI0=;
	b=AnsIgRTEJQOPpEw6Xm/klfKMO/HIxOTjyAi9ttlyQWXNTHx6K9t2hsExg47qtZrrMEtJbr
	g6EqAptKGSGW88QrEbo43GUw0SS3F1akAWrQUBGaHSA2UMmcXMy0fDwi4XxwxzyD2ezZZn
	/NWc9Of9Glb8s2ctkpuod8yJM8HA7/I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-m_grForOOaqNqNBiknMCGQ-1; Tue,
 14 Apr 2026 04:20:45 -0400
X-MC-Unique: m_grForOOaqNqNBiknMCGQ-1
X-Mimecast-MFC-AGG-ID: m_grForOOaqNqNBiknMCGQ_1776154844
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 235601956066;
	Tue, 14 Apr 2026 08:20:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.34.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7451C19560AB;
	Tue, 14 Apr 2026 08:20:40 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 6/7] netfs: Fix zeropoint update where i_size > remote_i_size
Date: Tue, 14 Apr 2026 09:20:02 +0100
Message-ID: <20260414082004.3756080-7-dhowells@redhat.com>
In-Reply-To: <20260414082004.3756080-1-dhowells@redhat.com>
References: <20260414082004.3756080-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: d3Ye0RY_o1b-O35Xo7TX3gU_7qW_t2-S3mD5jJnIErA_1776154844
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix the update of the zero point[*] by netfs_release_folio() when there is
uncommitted data in the pagecache beyond the folio being released but the
on-server EOF is in this folio (ie. i_size > remote_i_size).  The update
needs to limit zero_point to remote_i_size, not i_size as i_size is a local
phenomenon reflecting updates made locally to the pagecache, not stuff
written to the server.  remote_i_size tracks the server's i_size.

[*] The zero point is the file position from which we can assume that the
    server will just return zeros, so we can avoid generating reads.

Note that netfs_invalidate_folio() probably doesn't need fixing as
zero_point should be updated by setattr after truncation.

Found with:

    fsx -q -N 1000000 -p 10000 -o 128000 -l 600000 \
        /xfstest.test/junk --replay-ops=junk.fsxops

using the following as junk.fsxops:

    truncate 0x0 0x1bbae 0x82864
    write 0x3ef2e 0xf9c8 0x1bbae
    write 0x67e05 0xcb5a 0x4e8f6
    mapread 0x57781 0x85b6 0x7495f
    copy_range 0x5d3d 0x10329 0x54fac 0x7495f
    write 0x64710 0x1c2b 0x7495f
    mapread 0x64000 0x1000 0x7495f

on cifs with the default cache option.

It shows read-gaps on folio 0x64 failing with a short read (ie. it hits
EOF) if the FMODE_READ check is commented out in netfs_perform_write():

                if (//(file->f_mode & FMODE_READ) ||
                    netfs_is_cache_enabled(ctx)) {

and no fscache.  This was initially found with the generic/522 xfstest.

Fixes: cce6bfa6ca0e ("netfs: Fix trimming of streaming-write folios in netfs_inval_folio()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index d8e8a4b59768..e386cf31eb1e 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -302,7 +302,7 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	if (folio_test_dirty(folio))
 		return false;
 
-	end = umin(folio_next_pos(folio), i_size_read(&ctx->inode));
+	end = umin(folio_next_pos(folio), ctx->remote_i_size);
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;
 


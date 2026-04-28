Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FE47CC8D
	for <netfs@lists.linux.dev>; Tue, 28 Apr 2026 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382356; cv=none; b=CcrjhdlDWjZ5To/KUbISpSefje8qP7cq3t02TwvIhgdk2colyr7MICRW95zPeBYYYKbGDOPA9FJCGJ8S0O+0DALhTPev4HipUx/6yX0xwdlF+GpfWMeji4+M59C8wrolBdaFcgauarBleAayhk/kn5DaxF70nCdG9Zaxga/VGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382356; c=relaxed/simple;
	bh=kelRfB9HLCimHVHp5EACjpTSW1lun3yfZPdF/i143mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CuAwHOQY5P0IAzzWRchFul2keywTLV+LU93rnmxxsy6t8KWon1C4uAgKQbCzP8+vT/GwUnuQiILQOVz+wETRd4vceETZDRKvcDZLbym7ZKfF5l0CPQQtu1CIZBnc8iNFYzWzKd+AmIgHdZp60IBMcuiTdx4tEqmfNhd7iOsK1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRCjvEr7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRCjvEr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbFPc1DQP2QESNGAiyNusbxIP1Nhk9Foj9DJsGPjIqg=;
	b=fRCjvEr7xQQWjTb+ySr3Z7RedhoZRAonR+cbJ/nzEysF8B2/w/79dJ9sU2u4dr3x4Jw9YT
	lwvRNjQxzKyaf2JdgJ6XM+KBPUHHaY0VPXfVtSqs/MoqabsmbmEcfSAKOo/6DJrxdpgbQ4
	YDk0HYiCe9vlU+QiYXBCQn6ve+og1OA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-7R7GzpzrMAKkf9XMaH2Oig-1; Tue,
 28 Apr 2026 09:19:09 -0400
X-MC-Unique: 7R7GzpzrMAKkf9XMaH2Oig-1
X-Mimecast-MFC-AGG-ID: 7R7GzpzrMAKkf9XMaH2Oig_1777382347
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A5B11869195;
	Tue, 28 Apr 2026 13:18:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75DF9195608E;
	Tue, 28 Apr 2026 13:18:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 06/24] netfs: Fix zeropoint update where i_size > remote_i_size
Date: Tue, 28 Apr 2026 14:17:36 +0100
Message-ID: <20260428131756.922303-7-dhowells@redhat.com>
In-Reply-To: <20260428131756.922303-1-dhowells@redhat.com>
References: <20260428131756.922303-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: hGI6P5DnPskMYIk33sDRr7WdlGmkqjPwUek68J6gUJU_1777382347
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
zero_point should be updated by setattr after truncation or fallocate.

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
 fs/netfs/misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 67e089fa0b0b..35f570e13e4a 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -299,9 +299,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 		return false;
 
 	netfs_read_sizes(ctx, &i_size, &remote_i_size, &zero_point);
-	end = umin(folio_next_pos(folio), i_size);
+	end = folio_next_pos(folio);
 	if (end > zero_point)
-		netfs_write_zero_point(ctx, end);
+		netfs_push_back_zero_point(ctx, umin(end, remote_i_size));
 
 	if (folio_test_private(folio))
 		return false;


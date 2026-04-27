Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A8355F57
	for <netfs@lists.linux.dev>; Mon, 27 Apr 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304896; cv=none; b=A84KXxABn0MHSIYla7ZG+GgMVqKy7VpywpUHdLbkfYCDE/g0ohA9gGfSC/e7ksKUztyXB+IgVH9iyBe5vpKcLvKUXByzGHAM2PxUhO2pGqhLPr+sd05AmYqAWDlnreS+9m6KQ7tvs6QJO8BcYrYJvS3jcXWngV+SgthcQWG4Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304896; c=relaxed/simple;
	bh=NWuEILu4xE6q9Mk9vp9plJM/HCqF87+ioNPLfDaVBUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mv/vq0EURB4+NvQZVuxh0p9ps8A7+jvSogL4ongLTlak50cA11q1Ii7vClhu7VlybwqFPJafJgZ2jiHZ/brKZwkbtqC3bZEFWZ++DpItQEfd2SyfnNiNK6qABc/9nBeEk0IjMeG03zFs96tLIatcMNMbv1ftJZzCEH+CXDu7sGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li3mVti5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li3mVti5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777304894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vdxi9UOZOtHgo5imTm/mIQ6/cjgNJUqbuly6giNT79Q=;
	b=Li3mVti5PfW2Elx2ixFBhfUxjQqxcSGiCS1Yx5ebF6jnGdUtOWdMfWmpHxbW9aaT356E51
	VXDunmooAHLls7MYwRblsbTq7miMN3XD8It54ABzjvoJBMLI7fd2FsAyfhBioaDo5qcjwh
	cv4lbVaFNnoXg5Ff7tblNM3rDjCHDCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-YVQkWbXNNeipfCuB7hO6uw-1; Mon,
 27 Apr 2026 11:48:11 -0400
X-MC-Unique: YVQkWbXNNeipfCuB7hO6uw-1
X-Mimecast-MFC-AGG-ID: YVQkWbXNNeipfCuB7hO6uw_1777304889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 807B71800473;
	Mon, 27 Apr 2026 15:48:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E57A19560AB;
	Mon, 27 Apr 2026 15:48:06 +0000 (UTC)
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
Subject: [PATCH v4 18/22] netfs: Fix partial invalidation of streaming-write folio
Date: Mon, 27 Apr 2026 16:46:33 +0100
Message-ID: <20260427154639.180684-19-dhowells@redhat.com>
In-Reply-To: <20260427154639.180684-1-dhowells@redhat.com>
References: <20260427154639.180684-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: A_thzGWcG6cA-KRsR9Zxwx8WD16SHhCeNUXxCBGCGbM_1777304889
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In netfs_invalidate_folio(), if the region of a partial invalidation
overlaps the front (but not all) of a dirty write cached in a streaming
write page (dirty, but not uptodate, with the dirty region tracked by a
netfs_folio struct), the function modifies the dirty region - but
incorrectly as it moves the region forward by setting the start to the
start, not the end, of the invalidation region.

Fix this by setting finfo->dirty_offset to the end of the invalidation
region (iend).

Fixes: cce6bfa6ca0e ("netfs: Fix trimming of streaming-write folios in netfs_inval_folio()")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 4e91a8d75bce..094d5e8aad1a 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -255,7 +255,7 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 				goto erase_completely;
 			/* Move the start of the data. */
 			finfo->dirty_len = fend - iend;
-			finfo->dirty_offset = offset;
+			finfo->dirty_offset = iend;
 			trace_netfs_folio(folio, netfs_folio_trace_invalidate_front);
 			return;
 		}


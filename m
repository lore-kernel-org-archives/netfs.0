Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898303446A3
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396435; cv=none; b=Ub8EnCJGbloev+9Eqk9uJrglmKNjBuBC9IjTUe8ZDZAIT+t4BSJ+JvxIQF0tddIf3SQabB5GLp0FC+yyUkRVhPL2AZx3Amll+dYr1F7RI7iunP0bu4qmkR7DIOhTD5FGLYEi7A4sCIGoF43THDBNJ8tRsp5U503scFKlHdO59jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396435; c=relaxed/simple;
	bh=/eMp+WImKJH9LzmD/3lNc54QT+Yi3S0Sw6GyYiwY1Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=coy3iZOpOLc4cJEVX/EIJqF90xYWPG2SHShpiKZ53DRKZmDp7ersqVmwtHTu1S3RwttaiuvVqEJHK+4BuAGlvybyn8sAKsXkXd8X50cVhTVULf/0PsevXMaYefkG9OagvxihVM1HxJBznXOIpt7Jr3OtKpIQOZFzY1A6z8kmC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRrM6t3x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRrM6t3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782396433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m325Nx+i8DIrEF7y0AraLoEtm5viE2NtVsSnCJNNQA=;
	b=IRrM6t3xigZ3izHFaF/ER62poYGzDq9kCEpLr+EjAxYXRZ4xHU9umel4gGawFp31BQhyGJ
	IkTC5+eomTSkB57K8fKYKDUGWCxeAjKxfnfEJAic+u75Gao66irf1pTVfGFgWt3U/L2DK7
	ldf5bNPo299dw9wegnhk0Y+YYfmw6KM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-zCJMXNQDNpWQhZEmFmPgFg-1; Thu,
 25 Jun 2026 10:07:09 -0400
X-MC-Unique: zCJMXNQDNpWQhZEmFmPgFg-1
X-Mimecast-MFC-AGG-ID: zCJMXNQDNpWQhZEmFmPgFg_1782396426
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFDC4180AC7E;
	Thu, 25 Jun 2026 14:07:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF9661800370;
	Thu, 25 Jun 2026 14:07:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Christoph Hellwig <hch@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] netfs: Fix netfs_create_write_req() to handle async cache object creation
Date: Thu, 25 Jun 2026 15:06:20 +0100
Message-ID: <20260625140640.3116900-3-dhowells@redhat.com>
In-Reply-To: <20260625140640.3116900-1-dhowells@redhat.com>
References: <20260625140640.3116900-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: RoEelNJhNMhHV1aEpB1fHGQRpSOwrqFLpzDlHjlvUYk_1782396426
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

netfs_create_write_req() will skip caching if the fscache cookie is
disabled, but this is a problem because async cache object creation might
not have got far enough yet that has been enabled - thereby causing the
call to fscache_begin_write_operation() to be skipped.

Fix this by removing the checks on the cookie and delegating this to
fscache_begin_write_operation().

Fixes: 7b589a9b45ae ("netfs: Fix handling of USE_PGPRIV2 and WRITE_TO_CACHE flags")
Closes: https://sashiko.dev/#/patchset/20260624115737.2964520-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index c03c7cc45e47..4f55228f0fd4 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -106,7 +106,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	_enter("R=%x", wreq->debug_id);
 
 	ictx = netfs_inode(wreq->inode);
-	if (is_cacheable && netfs_is_cache_enabled(ictx))
+	if (is_cacheable)
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ictx));
 	if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE) < 0)
 		goto nomem;


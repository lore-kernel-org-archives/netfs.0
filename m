Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587B478E50
	for <netfs@lists.linux.dev>; Tue, 28 Apr 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382418; cv=none; b=TE5Q5lUbtqpB0gvMq31h1qPw+QTFQHtRRkg917e8Bw1jTuiH7UUoVon0sMXQxphu5ezoDpBHjXnr3pNEP6HSyvtzAiJJ8nuFObBjQDOLEMBx1wqAI0ylaCLTuBQHnJQYPRD6ZQ1KAe+tahJuUmnSEGSqDH69bv1zPlUchUsIckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382418; c=relaxed/simple;
	bh=ew53F1uP88FPC5BpDNF4Nw8Efi7JfTtT1jRQAGT1loI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QuzPIieDJ6QCHRLup8nIQxTgQnhuHG17GgtVtw3B//XxqNLOJw+IkVRUXHKERaf74rGwSkEZId9RtECmLsJSIbYymWNHm35dMo55gUQBBi0fQolp5R6zcaq7k6VmfuXnwXuhJZVT7DePwTAhP60lZr9jTT1JYRxR9yjMgAmdxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZkSIT5a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZkSIT5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip+PNQg7TgqHbl0SFCzUvei4CjuFE2MM4RySvRK0koo=;
	b=PZkSIT5aRaffXO8SlmTeHbiLQumONkM9hIt+TY4OnRPjpA6hS7QyhzD8LTZ+SdF2Jtsn+X
	MEQsupL5HG4f9WW0tHs1ay9PjjxEgp8v/9bI8wuhVYYRZYz2CfAE61eYLCCY2XY+7AId6k
	XKtWrB1c4CdrTYa8m/7rpEqUsFjs9vU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-6sj-aSdDPhW1sbsvXgcBtg-1; Tue,
 28 Apr 2026 09:20:13 -0400
X-MC-Unique: 6sj-aSdDPhW1sbsvXgcBtg-1
X-Mimecast-MFC-AGG-ID: 6sj-aSdDPhW1sbsvXgcBtg_1777382411
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62684187D1AA;
	Tue, 28 Apr 2026 13:19:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A327196B8FC;
	Tue, 28 Apr 2026 13:19:45 +0000 (UTC)
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
Subject: [PATCH v5 22/24] netfs: Fix netfs_read_folio() to wait on writeback
Date: Tue, 28 Apr 2026 14:17:52 +0100
Message-ID: <20260428131756.922303-23-dhowells@redhat.com>
In-Reply-To: <20260428131756.922303-1-dhowells@redhat.com>
References: <20260428131756.922303-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: DEObOuFgOYAiXNaFM629RSDgDY3y5TteEyExwFsfGcU_1777382411
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix netfs_read_folio() to wait for an ongoing writeback to complete so that
it can trust the dirty flag and whatever is attached to folio->private
(folio->private may get cleaned up by the collector before it clears the
writeback flag).

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 89ae5241c49c..1333f0b71985 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -503,6 +503,8 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	int ret;
 
+	folio_wait_writeback(folio);
+
 	if (folio_test_dirty(folio))
 		return netfs_read_gaps(file, folio);
 


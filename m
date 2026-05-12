Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2B3812D1
	for <netfs@lists.linux.dev>; Tue, 12 May 2026 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589309; cv=none; b=rfb0RLxCQ96pQ6kKvj8xjtEnabHKyHDYj73ZkD9bT9RR7elni713Z0UOTBaUnZPxunbNHCtYUhhwG4bkpc3fVaddZRNwlw8F2JYB6IS6GrQUlIJkzDu568EdHuFCxSYhgwKDbMw5befuuMA80FlkPWjXN7JKOYA7SARYWFo3DiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589309; c=relaxed/simple;
	bh=sxih3BTDZzJ2bsUF2D6f64sfz9xkArtTKlvgnT0LUh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BrTsOaAs9k4AQGCsOasV1wQZXEueBeS8lDR8mvLPYQhz/65QjVS7Ve7HUtkwCf9jnIqUh7xXAU8wSJhW2MH2s/3w3USmrfJbsfkhl5RJTmDQI1AEPsYlhF6PHdb6GcuXnZhqUxiGf1/rHLKIziFC9IINYDyu/VOA3hLqRQgTs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7pjbxtQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7pjbxtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778589297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAmZUPUCJuuZNr89UZiegqkhZYwnj4y64aSMrWWXqcs=;
	b=O7pjbxtQVS1LFXv/ZioMJqZBaHy8GFlFgoDQQAiapGb+HIlVYcrmrgPkJ8D9wcH61s1DZ8
	XAuQ0ICCdILC4LEPtqhOaCwUzYx3ccKLmRKZIR434GlDEWid1hYye6wlMTTUg0WkQ+0PjH
	+n0EdeXgjp/BmlzUBAhS9yuHTNtuq9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-piGjhrQqNFu2y0lHo3mczQ-1; Tue,
 12 May 2026 08:34:51 -0400
X-MC-Unique: piGjhrQqNFu2y0lHo3mczQ-1
X-Mimecast-MFC-AGG-ID: piGjhrQqNFu2y0lHo3mczQ_1778589290
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08ACC19560A1;
	Tue, 12 May 2026 12:34:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7509319560A6;
	Tue, 12 May 2026 12:34:46 +0000 (UTC)
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
Subject: [PATCH v6 08/24] netfs: Fix potential uninitialised var in netfs_extract_user_iter()
Date: Tue, 12 May 2026 13:33:45 +0100
Message-ID: <20260512123404.719402-9-dhowells@redhat.com>
In-Reply-To: <20260512123404.719402-1-dhowells@redhat.com>
References: <20260512123404.719402-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ACslzdaPIJYAi_zp-uVYmOYsEYsLEl2Hfb_1hf4aCs4_1778589290
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In netfs_extract_user_iter(), if it's given a zero-length iterator, it will
fall through the loop without setting ret, and so the error handling
behaviour will be undefined, depending on whether ret happens to be
negative.  The value of ret then propagates back up the callstack.

Fix this by presetting ret to 0.

Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 154a14bb2d7f..6903028b7162 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -43,7 +43,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 	unsigned int max_pages;
 	unsigned int npages = 0;
 	unsigned int i;
-	ssize_t ret;
+	ssize_t ret = 0;
 	size_t count = orig_len, offset, len;
 	size_t bv_size, pg_size;
 


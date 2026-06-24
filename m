Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873535F8C5
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302302; cv=none; b=gNq4yTQ5qWjvzjt1rL9qO6p9gv5OJ+0U1U2r+CSoMtWLinv/xZVprmj+ZCF+pgQ/pIOeABT6LLMlWgQnfFGOB3c7B6CL7Ro195PsIX4NlHWXZ3qJznWCfnQcpShQr9Ot8TSMb7apxJk9FTugHBgGNtgM1BEtztgFW1CB5PI4R2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302302; c=relaxed/simple;
	bh=4YO0schpHrytBbCwQ3FkwrvdrFR4G2LcBxtQ244E8Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LAYxUrKOe3p7y6Z7oD+N/q24Kbiu+3aTzrMIcfF/iW+F3X2PnwWfC1rpPoHpFw8yXRSFhs17FNYXD+NHyi8RZdtedPzOflCQeqodm8ZTvlwnJvPZzJSxW+GZO7sLeVascapXdfukFMB7AoQP/gdot6KPBVSPoq3BGHTdVR5Hbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/sHMIXi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/sHMIXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782302300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci/Uz32uQ+cQbDj0d+4HQoRx3PoMzfw96v2ECR7IWxY=;
	b=O/sHMIXigtSBQAJt1WZb8tqSSuLzRAkfTpdTCy4+88rW+vIB1WGuOiZgC76tnckQN8GMHD
	pPaZ65zplViFTDTY44wWaF3LjquB9Orb6o4XSGJbGCsLCpUyCZ1IhpLrGlrJiKYzFFz1Um
	xx7lvgZ6RQfT9LYqMprggQBNA4Hzckc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-i9nMxlj2NGaVaaS5I8GB9g-1; Wed,
 24 Jun 2026 07:58:16 -0400
X-MC-Unique: i9nMxlj2NGaVaaS5I8GB9g-1
X-Mimecast-MFC-AGG-ID: i9nMxlj2NGaVaaS5I8GB9g_1782302295
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE1161956063;
	Wed, 24 Jun 2026 11:58:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6C1E1772;
	Wed, 24 Jun 2026 11:58:09 +0000 (UTC)
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
	Ming Lei <ming.lei@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 05/14] iov_iter: Fix missing alloc fail check in iov_iter_extract_bvec_pages()
Date: Wed, 24 Jun 2026 12:57:26 +0100
Message-ID: <20260624115737.2964520-6-dhowells@redhat.com>
In-Reply-To: <20260624115737.2964520-1-dhowells@redhat.com>
References: <20260624115737.2964520-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: -C-DUGFR_xlti4YDXvGlfxzf4zBO1cntiGzE5wjBrJE_1782302295
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix iov_iter_extract_bvec_pages() to check if want_pages_array() fails and,
if so, return -ENOMEM appropriately.

Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ming Lei <ming.lei@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/iov_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5f60733f3280..1661c237b643 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1637,6 +1637,8 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 	bi.bi_bvec_done = skip;
 
 	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
 
 	while (bi.bi_size && bi.bi_idx < i->nr_segs) {
 		struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);


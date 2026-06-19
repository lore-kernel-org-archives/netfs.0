Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DB3815E7
	for <netfs@lists.linux.dev>; Fri, 19 Jun 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878067; cv=none; b=OSfmnoBxauzT2FZJ7cXXrdKAe0k6mpyMo6bZROs9XraULsKOZdDlVIg6S6kLCqnfkRewP/4ZAKjT8rXfXxOfP/crwLx4sFJKVotOtSz0aZ3FRR6MTrOA856ksiiFXf2+N7XRoSeEosEvLWPRr9xufy9mIhzf6MPxMYi+lM4Ewwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878067; c=relaxed/simple;
	bh=VUlgKQRtFcYZkgLggj06uMIrCxezEkk58BuS/5a9eCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SlXsbN3QmHQ/gjkBwFSeVK77ouVXlZMOjxtdjy+Dq2d1KznYq7zzm0ngaqov+cI+XWIwigUKsM34jc9fZzgNIYn2/5ZlFAtSYaefMJJ4aLJIf28YS0oBqNwQDPvdWktp7Wu/uCwC11KDXFEW5NhlUNSstQaj6+GOQ/GeAlNDcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Odmp9vEA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Odmp9vEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781878065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/liEajtHx9CYrzJvqnOmvWcXVvucaBQw0Nv7dYml2Q=;
	b=Odmp9vEACQnRKJOIlaFHl8bHhI63C1OTQ58LoDPMNg+vuyhZs42lXlZqSFsv8dukbGgRjH
	WQ3MYnUXRQGbIgnGkMIvraw7NFDZR8N6nKi2+ungnl9aQP7w38PSGMay/rQvWIAE/jxGw2
	z8Felt5HPf+pioKhKTqzVgGctJLP+Vo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-CCY_34c_OXm1Mi1y4mu7Eg-1; Fri,
 19 Jun 2026 10:07:39 -0400
X-MC-Unique: CCY_34c_OXm1Mi1y4mu7Eg-1
X-Mimecast-MFC-AGG-ID: CCY_34c_OXm1Mi1y4mu7Eg_1781878057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84C6E185FBF9;
	Fri, 19 Jun 2026 14:07:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88FFD3000238;
	Fri, 19 Jun 2026 14:07:32 +0000 (UTC)
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
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH 08/11] scatterlist: Fix offset in folio calc in extract_xarray_to_sg()
Date: Fri, 19 Jun 2026 15:06:12 +0100
Message-ID: <20260619140646.2633762-9-dhowells@redhat.com>
In-Reply-To: <20260619140646.2633762-1-dhowells@redhat.com>
References: <20260619140646.2633762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: fMTY4ngn6AjlR0auGZa9w5qhaC2sXHC7J9ewAr1LNQk_1781878057
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix the calculation of the offset in the folio being extracted in
extract_xarray_to_sg().

Note that in the near future, ITER_XARRAY should be removed.

Fixes: f5f82cd18732 ("Move netfs_extract_iter_to_sg() to lib/scatterlist.c")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Mike Marshall <hubcap@omnibond.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/scatterlist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index b7fe91ef35b8..6ea40d2e6247 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1366,6 +1366,7 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
 		sg_max--;
 
 		maxsize -= len;
+		start += len;
 		ret += len;
 		if (maxsize <= 0 || sg_max == 0)
 			break;


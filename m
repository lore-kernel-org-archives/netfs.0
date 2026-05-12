Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CF26D4F9
	for <netfs@lists.linux.dev>; Tue, 12 May 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589292; cv=none; b=MWR60Qsb7rQoOOX0rSKRu93bxFjixld8DB0vJuAEn2hgHV4d4TJ3y83w8KTxvQrL5vDw0pswn/1ldevIZjfDPsyKHvjhlxnF6i5XBzyye73z5l9haKXvtZIhdCkIn1ADGLq+4Mo8kcHEkETRIDYT83b9LYMjieNpxctbQjIryDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589292; c=relaxed/simple;
	bh=koNuJFj1Yw+BxszucAohlIs9ERwxVKnVYfx/Vf4HYr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ptmSeaLYNjJVg22QJRLnD/WYvGsYYCbeDGMqvGob/Apn9jsjwaR7W/oBkTA/JnmVp+21z7wFRc4pMlNq58JTPDBMfcF1QQP2ZqGJfF//3Ky/5PLu6Uf9yHHPjGKdDJmy6o46HVaq2RtG9ANDfqz6o8o7PUKMhp6++Mt44o3pSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+7J0+lw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+7J0+lw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778589277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCaVpMsucMqXUPa+HeMt32P8LUmPGDo+qVb1ukNhEOw=;
	b=a+7J0+lwt2DU7XGlFgP0gSZFWoZhzOcZIReS20XMMlaF8oEoA4g7vzyUoJr1ppfD4jiqHk
	Pu6FV3OlVXri2hjAYnXhRIi5wNExAciT9o4yUwTOR7PfJUrgQYCSD4j+11CiGZygk0omhp
	KOUP4NCy+/vGm+xem+tMTDB/sGQQlss=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-iFr2GeCpPwaykEIAW5_3-A-1; Tue,
 12 May 2026 08:34:31 -0400
X-MC-Unique: iFr2GeCpPwaykEIAW5_3-A-1
X-Mimecast-MFC-AGG-ID: iFr2GeCpPwaykEIAW5_3-A_1778589270
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6726619560A1;
	Tue, 12 May 2026 12:34:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8F60180034E;
	Tue, 12 May 2026 12:34:27 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/24] netfs: Fix netfs_read_to_pagecache() to pause on subreq failure
Date: Tue, 12 May 2026 13:33:41 +0100
Message-ID: <20260512123404.719402-5-dhowells@redhat.com>
In-Reply-To: <20260512123404.719402-1-dhowells@redhat.com>
References: <20260512123404.719402-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 9d5qz61LVhg0GQiZZlnqtReIo7zCIc1JlgluZ4tzeq4_1778589270
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix netfs_read_to_pagecache() so that it pauses the generation of new
subrequests if an already-issued subrequest fails.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260425125426.3855807-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 15d73026ff64..fee0aebf5a3d 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -300,6 +300,11 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 		}
 
 		netfs_issue_read(rreq, subreq);
+
+		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+			netfs_wait_for_paused_read(rreq);
+		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
+			break;
 		cond_resched();
 	} while (size > 0);
 


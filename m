Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07914360EE4
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396497; cv=none; b=D0MrSJidYYYWZM4V7RFU27YROWFRivn0IqvTO8CwDST8WG4foxhKafc0Ml+xLE3m4vBBKRiZaZBVodBgEmYCuyw3EGnJsEBc9Q4EGZVh17Jnl6MiJcpz1o/zf0ckPTcvibRpKVjATs6jCMC9r8H/AWerESjJU5xB+907EOcUH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396497; c=relaxed/simple;
	bh=elZ6s3PGePQtvKkuWc/132OUzgTYXmfpO45C022yIGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KAvj8ML92QYoPJgXJ1d8L+T7tN9kqToGbbgDgFwbDn8K4IYFdOySLj9RUv+T5JvHOfgcKF4uGSTEiKo7inMTNEkhlzm6dXqhCcwbDTMfdBIvh2zSnZXSjRVlPNMYogA6oe6PQu6drNeEhB6tTr8mL6S0DBEi4OsqgAguK6dOXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWO6fvNe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWO6fvNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782396495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdumfDDf1PJp00pZdD4aygrxcSHtSzAPned20bGl9Fs=;
	b=cWO6fvNehaAL5nDB20DneZ8DsiVd5QOur6Kki37uuf2J21ENZtPsMR7kSUmIuROQk7G375
	jwY25A2JprWusTjeJTdn/IrgRFtSctyTHA2HaM9CXmrgR+2IDUWXg0+9CUz45p10mEfWPS
	dvD5AQsjglzBV1+EhvBY0Mtzf6k5yNk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-oeLPkOq1M4etwJ0IzOsNtw-1; Thu,
 25 Jun 2026 10:08:10 -0400
X-MC-Unique: oeLPkOq1M4etwJ0IzOsNtw-1
X-Mimecast-MFC-AGG-ID: oeLPkOq1M4etwJ0IzOsNtw_1782396487
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49DAB186BF1D;
	Thu, 25 Jun 2026 14:08:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3605A1800370;
	Thu, 25 Jun 2026 14:08:03 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 14/15] netfs: Fix folio state after ENOMEM whilst under writeback iteration
Date: Thu, 25 Jun 2026 15:06:32 +0100
Message-ID: <20260625140640.3116900-15-dhowells@redhat.com>
In-Reply-To: <20260625140640.3116900-1-dhowells@redhat.com>
References: <20260625140640.3116900-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ZQQC2zq-qHzq-yK2mZklcr_yilVoWSxQqnvuGFAZNro_1782396487
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix the state of the current folio when ENOMEM occurs during writeback
iteration.  The folio needs to be redirtied and unlocked before the
terminal writeback_iter() is invoked.

Fixes: 06fa229ceb36 ("netfs: Abstract out a rolling folio buffer implementation")
Link: https://sashiko.dev/#/patchset/20260619140646.2633762-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 3682896c3fdf..f2761c99795a 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -582,6 +582,10 @@ int netfs_writepages(struct address_space *mapping,
 		}
 
 		error = netfs_write_folio(wreq, wbc, folio);
+		if (error == -ENOMEM) {
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+		}
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
 
 	netfs_end_issue_write(wreq);


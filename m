Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D973A9DA3
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302334; cv=none; b=D+PHaINPxg35qZ6u7d2Uhu1D5cEq1d+qk/NqFlzJ/VMUQE/G0o307Rg3GcRER/nwUZLIHbJ7gbQVB2pXopm0roc0pM1K+2hnB3Bj1SuoPK1eMQrEL4WwDd7useN5xQ5HjXqP7nGCwWGGJmUUK4yaVmSv9y46RIflSFLJwVExTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302334; c=relaxed/simple;
	bh=c24Yit3599uQLRElsJbGFusA/7JcG/6iJ0D3gBMzT4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hKjx60wEkCt0wPytFqIWv7Zvgbw3MSOTzBYZfKF4VUoHBKwWaHR5XrqrtrIql5zwBa2VvbRaGtRatAvElr0hMYwIiekewXg28rmOushB3hhq262UumxU1kQ2y18ZkhtFFOzXQe+gantVz+LQ524dH/0IbjqGd8gOsr8Z1KyRlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/zSQYDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/zSQYDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782302332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+j9T14/yKCuYIYjsdLnru9vHvjv9poR+Pk5ADqQQzV8=;
	b=Q/zSQYDguJ5Eay9u5oMtw/5qMiAFFqfZhPZW1y6DISvqy4dhj+47QKDSkOeNvDEAj3K1rT
	0n2PXnoImmKv+FmoStbtldM3XefZ0mWbgg/MfjSS3638F7xkDYZ7BcTKfjQrRQltpE6k1s
	Y47vhBgSMJEzpn/Je+hdQNXPOnpzxm4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-L0sgAPIIMFiJlli9RKjw3g-1; Wed,
 24 Jun 2026 07:58:48 -0400
X-MC-Unique: L0sgAPIIMFiJlli9RKjw3g-1
X-Mimecast-MFC-AGG-ID: L0sgAPIIMFiJlli9RKjw3g_1782302327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E943195608F;
	Wed, 24 Jun 2026 11:58:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74F42195609E;
	Wed, 24 Jun 2026 11:58:44 +0000 (UTC)
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
Subject: [PATCH v2 12/14] netfs: Fix writeback error handling
Date: Wed, 24 Jun 2026 12:57:33 +0100
Message-ID: <20260624115737.2964520-13-dhowells@redhat.com>
In-Reply-To: <20260624115737.2964520-1-dhowells@redhat.com>
References: <20260624115737.2964520-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: N8Ch6HuHF3-V_fvEVsZdv9d5mlrlMFl85HEMDeCXg0A_1782302327
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix the error handling in writeback_iter() loop.  If an error occurs,
writeback_iter() needs to be called again with *error set to the error so
that it can clean up iteration state.  Further, the current folio needs
unlocking and redirtying.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Link: https://sashiko.dev/#/patchset/20260619140646.2633762-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index e5d4f9ba3d6b..d1f98cca5d0f 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -582,8 +582,6 @@ int netfs_writepages(struct address_space *mapping,
 		}
 
 		error = netfs_write_folio(wreq, wbc, folio);
-		if (error < 0)
-			break;
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
 
 	netfs_end_issue_write(wreq);
@@ -594,6 +592,9 @@ int netfs_writepages(struct address_space *mapping,
 	return error;
 
 couldnt_start:
+	folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
+	writeback_iter(mapping, wbc, folio, &error);
 	netfs_kill_dirty_pages(mapping, wbc, folio);
 out:
 	netfs_wb_end(ictx);


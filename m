Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6833DA5B6
	for <netfs@lists.linux.dev>; Mon, 27 Apr 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304908; cv=none; b=ADoX+aFptM5uptT6624XUaXQdUQzANxD8GNzywQFAjKpPxZaRJhjK5pN+5dooEFVaDGj9YofaneSre29ZjZPw8GrJO9KwEn91g3mwXOAG6K2UPd7E9TcFYrS7Lar1uDuJDHAYlWz6x6LdOJMK/8PBHFeBpf7T5PoEGWkOpAySHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304908; c=relaxed/simple;
	bh=r6K9iFCwGOBbvUFsNm3usyWKYBGnIBFG0RK8j8V5wJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OiyfiGYkDGTvVx7gAxgFt026Lcjfk4MJgZmoCBZ//dVvar83ROG4GprurUkbHX7VbB10QZAydrFVOFbu/ssjGaUqGwhO9uW6dpRl3UL9PueYpOWiA2+UKXc7M90KiIMBSkdAY0H3knBjvU45cHIKr7k90Pb5L10kUVEv3nh3TK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQcH8kAE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQcH8kAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777304906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8TreMojEQ0wPuyO6zSmrQCQs0j8kwVy3C2ZGai7LkE=;
	b=WQcH8kAE+oPESX7PcKGYb7NvAmkXKOJ8kEvAKiVuKurQiylA03ijumc5DMTGL3277kDy1N
	5MuNdARjUZeiTdflcxgYZgD7YsabkFAKLoMk5cJADaVV+/tCkGNvEV2Zj9KxoyXiNOR4rU
	M63ExI7Av9I7+hiDy+IKcDrYVWoO8es=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-ruZpO2nZNXevnvPOO4C5GA-1; Mon,
 27 Apr 2026 11:48:21 -0400
X-MC-Unique: ruZpO2nZNXevnvPOO4C5GA-1
X-Mimecast-MFC-AGG-ID: ruZpO2nZNXevnvPOO4C5GA_1777304898
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B94C3195608B;
	Mon, 27 Apr 2026 15:48:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDD9719560AB;
	Mon, 27 Apr 2026 15:48:15 +0000 (UTC)
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
Subject: [PATCH v4 20/22] netfs: Fix netfs_read_folio() to wait on writeback
Date: Mon, 27 Apr 2026 16:46:35 +0100
Message-ID: <20260427154639.180684-21-dhowells@redhat.com>
In-Reply-To: <20260427154639.180684-1-dhowells@redhat.com>
References: <20260427154639.180684-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: -YroBSS6a6UtHiPJtFJJlcMTsa-oTl5CRuM8GvJo12k_1777304898
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
index ec576d840594..5e299237c9ec 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -508,6 +508,8 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	int ret;
 
+	folio_wait_writeback(folio);
+
 	if (folio_test_dirty(folio))
 		return netfs_read_gaps(file, folio);
 


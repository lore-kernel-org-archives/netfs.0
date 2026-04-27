Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3713DD50D
	for <netfs@lists.linux.dev>; Mon, 27 Apr 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303823; cv=none; b=Fja1bZK1lIXj6LrthrvpkZl2ymKvrRDPyXSQX0J9vbAwDmEHWMQc12No95jqRwEZDOz4pDuwDa1QIqxiX452Pn5EwbO4FUuohFSToqfxNAZp1lK/iZ1kNVCqMZTTJeKUSyjqP2Cco9EK9if3zntYl5ZvJJEherZNb5YjyZ0fz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303823; c=relaxed/simple;
	bh=TzKE7QcFZf39E2UkvuI1rxQbsvby4wW7m4gGjN+BIzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=okv4/p0KLkZvfi2lpwDJyDC/6Ufy2qxu6kWqPyAbax1pLIVNK2SyZ8yPvXDcyJCa73WFBlcg9qmJrb6MkEAOc44WV5NVOBH3g5LUw2d+7ZhwMNKpagFTML2ZHaZJv9jJuDNU7u152iJRvFBYDzKd8PCotpu5HhpgRNslG/hh3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbRG4Ur5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbRG4Ur5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777303820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REMGICrXXI7qiSN2rIwTeEeIpWS2D3QtA/yikvDYdpo=;
	b=GbRG4Ur5Jq+6Ed1rVEvHQUEniwrX6I1EEXeAQ6+/CuDpNOpMqYpNLT8shvwFmrVq1loJqE
	fiYPL5wUKHBQVnZ/voM2G6poBvsTexWOM1KkjNeRDoUGiEnT1B9z0lkInfhcH9+a4qpwH+
	dlkL9mUZIBI/QLlKEZ7PzrXYYgC3w+M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-o_86Fju7MJyIRarjiHxZSQ-1; Mon,
 27 Apr 2026 11:30:19 -0400
X-MC-Unique: o_86Fju7MJyIRarjiHxZSQ-1
X-Mimecast-MFC-AGG-ID: o_86Fju7MJyIRarjiHxZSQ_1777303816
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC26719560A2;
	Mon, 27 Apr 2026 15:30:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF3EC19560AB;
	Mon, 27 Apr 2026 15:30:12 +0000 (UTC)
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
Subject: [PATCH v4 03/22] netfs: Fix missing locking around retry adding new subreqs
Date: Mon, 27 Apr 2026 16:29:30 +0100
Message-ID: <20260427152953.180038-4-dhowells@redhat.com>
In-Reply-To: <20260427152953.180038-1-dhowells@redhat.com>
References: <20260427152953.180038-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: VY3gQG7ktF9m3ps1cob81DvhQZoKHTpe0n0L3qG3gxI_1777303816
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix netfs_retry_read_subrequests() and netfs_retry_write_stream() to take
the appropriate lock when adding extra subrequests into
stream->subrequests.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Closes: https://sashiko.dev/#/patchset/20260425125426.3855807-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c  | 2 ++
 fs/netfs/write_retry.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index cca9ac43c077..b34561e257f0 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -203,7 +203,9 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
 
+			spin_lock(&rreq->lock);
 			list_add(&subreq->rreq_link, &to->rreq_link);
+			spin_unlock(&rreq->lock);
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 29489a23a220..db0f23708b2d 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -153,7 +153,9 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 					     netfs_sreq_trace_new);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
+			spin_lock(&wreq->lock);
 			list_add(&subreq->rreq_link, &to->rreq_link);
+			spin_unlock(&wreq->lock);
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 


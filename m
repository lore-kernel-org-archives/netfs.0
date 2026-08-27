Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C6743B3E3
	for <netfs@lists.linux.dev>; Thu, 27 Aug 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823554; cv=none; b=dfUyclhjrpdWVlLVS4VAjLsv7oLR2zs4LRDJ7jUOuJopXGya6agDn7ADejCAdS8ScDw6NDMWq21xUHHsDqbGB3A11O+7OsTupLMvWeYuSJ2wmlBt76+imGM56Hn/OVqNYt1g55bwQejamSATcPIgUfbizVS/XGYc0kHfueGq1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823554; c=relaxed/simple;
	bh=FzRo1GPNzAWelnrKwWW+888gA+zU/UXIf9GDxf2VjrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qNKViPfH+uPnqIOpr3IoKMBg75eTFIgtV2Pgh/7qDg/HC7SLeTKdlpJPRcTrfKOLoVDqkNkkbDqR72ajCZ7DQu/TkT64vRY7beN7Ikwi64cbLx+zSTYTL+fLjXrT/ejLGnm6YiSLWbjTnpELjSZrCtUEn9znUzFnblNAEREdoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIUlViwn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIUlViwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787823547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/Qxd7N6jCXPKHznu5KtiQXyFK2J5SiupV4se6oGxR0=;
	b=GIUlViwn6oUmxtxJnv7Rbcsw4w7VWqgBSDcJQzodWDDIZhgmmnphkIwLIRtYdSmkBbb3MP
	567cr3e3fGSyd9yc5pLrCBLTXvERImJ7qCETwZFeolsCqk2CC2ysP2Sr0P6i25Tyt2ctjz
	AZcBqk8YRNE2hrDKDKq6NZSD6XCFBi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-MBf9HBZUO4i_8GBU_K4OYQ-1; Thu,
 27 Aug 2026 05:39:03 -0400
X-MC-Unique: MBf9HBZUO4i_8GBU_K4OYQ-1
X-Mimecast-MFC-AGG-ID: MBf9HBZUO4i_8GBU_K4OYQ_1787823541
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEF66195423E;
	Thu, 27 Aug 2026 09:39:00 +0000 (UTC)
Received: from warthog.com (unknown [10.22.88.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 590031955F04;
	Thu, 27 Aug 2026 09:38:58 +0000 (UTC)
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
Subject: [PATCH v3 05/10] netfs: Fix subreq ref leak
Date: Thu, 27 Aug 2026 10:38:20 +0100
Message-ID: <20260827093828.1956211-6-dhowells@redhat.com>
In-Reply-To: <20260827093828.1956211-1-dhowells@redhat.com>
References: <20260827093828.1956211-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ryr3XNU3jwjj6sfOX547oySUa097k0sKUfpFznmTJuw_1787823541
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix a subrequest ref leak in netfs_unbuffered_write() in the event that
subreq->io_iter ends up zero length during preparation.

Fixes: a0b4c7a49137e ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Link: https://sashiko.dev/#/patchset/20260824120224.504575-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index f33ccddaa826..fbcfadb232ee 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -121,8 +121,14 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		}
 
 		iov_iter_truncate(&subreq->io_iter, wreq->len - wreq->transferred);
-		if (!iov_iter_count(&subreq->io_iter))
+		if (!iov_iter_count(&subreq->io_iter)) {
+			pr_warn("netfs: Unexpected zero-length iterator R=%08x\n",
+				wreq->debug_id);
+			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			netfs_write_subrequest_terminated(subreq, -EIO);
+			wreq->error = -EIO;
 			break;
+		}
 
 		subreq->len = netfs_limit_iter(&subreq->io_iter, 0,
 					       stream->sreq_max_len,


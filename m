Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE63630AC
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396478; cv=none; b=Gm7yGprHruZlzpjrKDN+64RoEYQQfBZwe2od37Zq8aqLRA8FCsunBMSsL8+1UAaRof1WE0dVZRlvOKHuoYLmnJUpyXp6jicolDdPIYZ8sO9kSGrDkCUYjv03JkMNYEJzRq3Vjx10XQJOOPgUNsICFcT66Vso+p6rXWdo5J/cOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396478; c=relaxed/simple;
	bh=Yw8I/ZtEAnnW0CdmYQMxWMJdMjN1DXcG2LAXqW6L8Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mMvnUC65IPN5/M44YMT35yMdc9xyRnVjhAZNQdDl3UX1o69D+dwfu6kfpPTJYxGYbv/bm1eH2G5PSx484efntwHHmgRdV1QOF2Y8by80KO5l0+ksUoQpkx4VXGSdUmR8oiyO+pfjaj0lkZ0HXd7aTTOPiVXHADiV8FWj/LbmSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNwBV/z4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNwBV/z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782396476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJeWotLSts92SfZtGdrDgp9DF0vvDCMz9s+A5IDIhUk=;
	b=FNwBV/z4mQPsjvq/Jq1W1PL2znaBmyWzHAbd65mVg8p8pNG9UKxKo3+UPx3rpGujvOcEoL
	+d3rLdsCGJRU1EPdDz0p353N0w7+26zdzM26RTb8rEl5x0VJhRDBgP7rqV44q7EsDBBX/Z
	7Oe0W8yovVe6uF+0SxQtLp+mqEh+INY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-grfLy877P4WB6mRXKCs0EA-1; Thu,
 25 Jun 2026 10:07:51 -0400
X-MC-Unique: grfLy877P4WB6mRXKCs0EA-1
X-Mimecast-MFC-AGG-ID: grfLy877P4WB6mRXKCs0EA_1782396469
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0E2D1955F61;
	Thu, 25 Jun 2026 14:07:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D67EE180065F;
	Thu, 25 Jun 2026 14:07:45 +0000 (UTC)
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
Subject: [PATCH v3 10/15] netfs: Fix kdoc warning
Date: Thu, 25 Jun 2026 15:06:28 +0100
Message-ID: <20260625140640.3116900-11-dhowells@redhat.com>
In-Reply-To: <20260625140640.3116900-1-dhowells@redhat.com>
References: <20260625140640.3116900-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _CKeeCjtP3B_SLd3mzZiDCpbBsDy9Pk82RMDxx_YAa8_1782396469
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix a kdoc warning due to a misnamed parameter in the description.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 243c0f737938..bdc270e84b30 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -753,7 +753,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 
 /**
  * netfs_resize_file - Note that a file got resized
- * @ctx: The netfs inode being resized
+ * @ictx: The netfs inode being resized
  * @new_i_size: The new file size
  * @changed_on_server: The change was applied to the server
  *


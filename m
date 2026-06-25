Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D333A9C1
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396451; cv=none; b=o2s8ac0BBjIjcSXQu1GjAkbfHe8Wht5oo11cy8A0LZKRH8AFKahsVGWIEWQVQRotFi1V2KbvlWbTRFbvEA7ckJPm2bbcEK+1GqNFqo6VGhQHpO7M3NVjoCPdwR3JL26X0IDV2dbNs657n1gLee7kU5XevKDCWwQnt6fVUajYhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396451; c=relaxed/simple;
	bh=RdvGg5oUDGJEEdfGJGQ/pnwBlwSc3oIQFuXQ0iNSvAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QvwWYSsXAQrTd6ymlyoW5gcMbL/SB8uChoXk/Z4mdnTSG+ft4rGsiwMjzTFZpBhbLG90CQoY85G2ozNGPRxM+OSG/qobjLo0fJlsjM9tLlvCPp851y5rFv3x3bVF/k9yHbXYKiU1kvFxR2TmqGXJj/cMv6HPfANeyj66GKbSvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBoRb5q3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBoRb5q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782396449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCH9AytniZX5CSjSRd/+qJL1T4JneHVxw5zGHZC2I1o=;
	b=JBoRb5q3t7qIzCM1mzpL4MuNXUXUlpc3VKi+UQ637P7QotmBLtj9lC0idrPYmibermUpO+
	aJ6+E2MgK3CqCBeSCjb2tvf/U8B3mAAJ/nHUFFYlAtr78ZWt41VzLaRlz7/lEeZGtn8g//
	OwrLjLyhzpqVYBLJEQ9w56pVj7VIxb0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641--_iwJPnPMy2RDNCptzyHUQ-1; Thu,
 25 Jun 2026 10:07:24 -0400
X-MC-Unique: -_iwJPnPMy2RDNCptzyHUQ-1
X-Mimecast-MFC-AGG-ID: -_iwJPnPMy2RDNCptzyHUQ_1782396436
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E45DA19560A6;
	Thu, 25 Jun 2026 14:07:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B41A36916;
	Thu, 25 Jun 2026 14:07:12 +0000 (UTC)
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
	NeilBrown <neil@brown.name>
Subject: [PATCH v3 04/15] cachefiles: Fix file burial to take lock when unsetting S_KERNEL_FILE
Date: Thu, 25 Jun 2026 15:06:22 +0100
Message-ID: <20260625140640.3116900-5-dhowells@redhat.com>
In-Reply-To: <20260625140640.3116900-1-dhowells@redhat.com>
References: <20260625140640.3116900-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: cVcxdMg4FTKKiqjp4PJLxnyOQ60nYEPMIH_tGjgrIKo_1782396436
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix cachefiles_bury_object() to lock the inode of the file being buried
whilst it unsets the S_KERNEL_FILE flag.

Fixes: 07a90e97400c ("cachefiles: Implement culling daemon commands")
Closes: https://sashiko.dev/#/patchset/20260616100821.2062304-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: NeilBrown <neil@brown.name>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index a464c4646c04..d4309dfb55df 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -375,7 +375,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 					    "Rename failed with error %d", ret);
 	}
 
-	__cachefiles_unmark_inode_in_use(object, d_inode(rep));
+	cachefiles_do_unmark_inode_in_use(object, d_inode(rep));
 	end_renaming(&rd);
 	_leave(" = 0");
 	return 0;


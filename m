Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5B347532
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302289; cv=none; b=kr45kIL77nIpbakT7DxklrPM4D9bzmC1uGVMJd19vAm2ER3KlFzNuRgnhW4HTiXXHIwfHhrpldaZqbThYrlcUv/cyCITA7pjX6bZIpwuuvzWTmTXkkrAzw7N97J6WDc106nuxIF2mKOmn34WGeSSRX3CCzZCuES/7TTgpD3F5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302289; c=relaxed/simple;
	bh=RdvGg5oUDGJEEdfGJGQ/pnwBlwSc3oIQFuXQ0iNSvAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G5mTCg/SJSO5JTX8fnM3D6ElMoUk7ppeKpQATIP2fGwELnLQ4aEjLxpER1w56JwnlIwjNXqctEp2lMIgvva1xKt4k+dPfb25vHD80fgP8KP4s56h4QXmAmx5173sGLDic/y3l7XFFyH/Y2H7aR/M4AkRLBl+XPAic99xYdycK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipP26UiC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipP26UiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782302287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCH9AytniZX5CSjSRd/+qJL1T4JneHVxw5zGHZC2I1o=;
	b=ipP26UiCTyqCZ+L98TlzbxFIh4fez+DSTFXlYUmTj43JRvJ9zB9OKLoLmv95PW4MMvmqjJ
	OfUvqUvsK+78vGsAzwmcbCCPGvBFErqwj6HsbTG+B7MC9pP8nCfqEVNpnfTvVMqbnjOfQC
	Yg+VLoK20QTmHuO5g3yU6+L0Ao3AqyU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Kcz0Ba0yO42GHTSNRKa9aw-1; Wed,
 24 Jun 2026 07:58:03 -0400
X-MC-Unique: Kcz0Ba0yO42GHTSNRKa9aw-1
X-Mimecast-MFC-AGG-ID: Kcz0Ba0yO42GHTSNRKa9aw_1782302282
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 865421955E93;
	Wed, 24 Jun 2026 11:58:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDDFD1956049;
	Wed, 24 Jun 2026 11:57:57 +0000 (UTC)
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
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 03/14] cachefiles: Fix file burial to take lock when unsetting S_KERNEL_FILE
Date: Wed, 24 Jun 2026 12:57:24 +0100
Message-ID: <20260624115737.2964520-4-dhowells@redhat.com>
In-Reply-To: <20260624115737.2964520-1-dhowells@redhat.com>
References: <20260624115737.2964520-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: vJzo2Ar8i7ni9JytUudkXO0fR3_HD0crgSJFpXV4yeQ_1782302282
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


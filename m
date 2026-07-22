Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF5345734
	for <netfs@lists.linux.dev>; Wed, 22 Jul 2026 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725414; cv=none; b=gF00t0JknKwmsWPCySg9+8WebTk4K4+Eq7C77aPhh6L6kr/2CqvhlZfk3yQBBvvi/SmWAB2CYHNRl+Ipm1dlEvxfPtnxW2PUgxJrGi3Q+vrn2PncHlZ4uyzea5pwnjGR3Fu3uHrj/afo4+c/x7SO79h5gKz7bc5mMk5uTa68Ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725414; c=relaxed/simple;
	bh=MELxpiVsjg54SuqERnFOBoWpwSE25FVW/pm5aIULwfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=F/naVnJxeSWYuT9MjDcuBnjCvMx+NjKggbbVOig9GmsVOvIn2j3JS7KYykw3dDsOcy1bak/WF4DV5fTc4PAktiTX8PWe/t+N/wGNQ1KT2Q8phHwI41UKrD9gPpfnQJ9oWJGoVV93CtHvsk37rE6ofMAHhxYUWB1xQgRS5MTLiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxwwmfE6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxwwmfE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784725407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RuMIYaYxQ3aZE1J/C1CbAmhDK6Ryjd7CE/reIVD6Co=;
	b=JxwwmfE6uUode2A/a+LhP1I8Ag3VZ8l3POpH58+aGim12hun/qblRRLP97bPVaheaNTzwZ
	fohGvOYNl4hauvkREei39hS68FzDueeVa2PhaDdc8eYuTpzTKpdDM0fb456HS2QUz4Xvo3
	hx8kw76Qf/7F3IBlafVX9GunYGcOQ+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-Fu614UCEMOqxu3toLt55kg-1; Wed,
 22 Jul 2026 09:03:21 -0400
X-MC-Unique: Fu614UCEMOqxu3toLt55kg-1
X-Mimecast-MFC-AGG-ID: Fu614UCEMOqxu3toLt55kg_1784725397
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B06D195FDF6;
	Wed, 22 Jul 2026 13:03:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A1911955D88;
	Wed, 22 Jul 2026 13:03:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 05/29] afs: Fix afs_edit_dir_remove() to get, not find, block 0
Date: Wed, 22 Jul 2026 14:01:52 +0100
Message-ID: <20260722130218.78958-6-dhowells@redhat.com>
In-Reply-To: <20260722130218.78958-1-dhowells@redhat.com>
References: <20260722130218.78958-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: D59C6a_REHC2nYTmzjZiGm6W-g2VS3oqjkLNlrdBVaI_1784725397
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix afs_edit_dir_remove() to use afs_dir_get_block() to get block 0 rather
than afs_dir_find_block() as the latter caches the found block in the
afs_dir_iter and may[*] switch out the page it's on if another
afs_dir_find_block() is done.  This parallels what afs_edit_dir_add() does.

[*] There's more than one block per page.

Fixes: a5b5beebcf96 ("afs: Use the contained hashtable to search a directory")
Closes: https://sashiko.dev/#/patchset/20260706153408.1231650-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/afs/dir_edit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index fd3aa9f97ce6..3ead36a07048 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -415,7 +415,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	if (!afs_dir_init_iter(&iter, name))
 		return;
 
-	meta = afs_dir_find_block(&iter, 0);
+	meta = afs_dir_get_block(&iter, 0);
 	if (!meta)
 		return;
 


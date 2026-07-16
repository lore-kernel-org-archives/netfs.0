Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D593FA5FD
	for <netfs@lists.linux.dev>; Thu, 16 Jul 2026 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197927; cv=none; b=aB4S44jgVduEKjhQXMydXbyM4+/WnSvwAI7NxQzQFSbHYNBviNRKCkUCfGI6BYMj3fcvyO3XJPxcZviREvRc+0FfFnO/LhPyK7EkWt8jubgmGTEXq1AA3dD75yPSmCYQ1+Gzk2oU+6oVmigjiqgdK44YfPfv9FT+zxBiBr/Rt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197927; c=relaxed/simple;
	bh=MELxpiVsjg54SuqERnFOBoWpwSE25FVW/pm5aIULwfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WbOiEgV6cwEnWgxRIeWH9gfV6tuNrbZN9U4JchbcHNTrjWaC/Den2AR49JETwuG+CVgXdIxQjTaN78hAqfhNCSYYeYrUvnDPFDVDETU767nz3bAQcwPnZ3/2scZNJ54yX5+Iyu1z+OywCCMhPBOhdAaibaSLL0PNSmmmHCgOJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNt939Z+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNt939Z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784197920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RuMIYaYxQ3aZE1J/C1CbAmhDK6Ryjd7CE/reIVD6Co=;
	b=BNt939Z+oGjBSHL4BCYT+oS+oPPqDBzFmusgT5vF570TUpPPe9khFYb4BBquCqKUXFTeCp
	4tLZbEojmWKz/pjs34KVHY6uCFTNgkdaNOC0Q/iieAXnCe0+ieycnQwTY5rgER5Dj/Qllj
	e8+mw7alrZlv47fBxjhEWi6VWcA3F+8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-jrktmlciO6-DTPN_f8ZiAA-1; Thu,
 16 Jul 2026 06:31:57 -0400
X-MC-Unique: jrktmlciO6-DTPN_f8ZiAA-1
X-Mimecast-MFC-AGG-ID: jrktmlciO6-DTPN_f8ZiAA_1784197914
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F07A18002C2;
	Thu, 16 Jul 2026 10:31:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D1BE1956042;
	Thu, 16 Jul 2026 10:31:47 +0000 (UTC)
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
Subject: [PATCH v6 08/24] afs: Fix afs_edit_dir_remove() to get, not find, block 0
Date: Thu, 16 Jul 2026 11:30:07 +0100
Message-ID: <20260716103030.3065561-9-dhowells@redhat.com>
In-Reply-To: <20260716103030.3065561-1-dhowells@redhat.com>
References: <20260716103030.3065561-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: l8BKXl57VHCLIbCuiTo91xlbcjPgHliDP4txkdLP_Bc_1784197914
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
 


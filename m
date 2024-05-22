Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F957146001
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412343; cv=none; b=ALZ3+tJN5tC9Y20Q8/iW6njhI3X/2KgAF4DKsrwlIPzeJxjL+B6xHAWOj/HClXF0Q7RmNy4VLa+Nf1Qq0HgrnglVM0deyuVoevebiWy0DY39mNkBUCT1z0vM9s6DHdb28jUBzAztkvHc2eMSfwSv4MDqEeIJUUnvB0724TITWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412343; c=relaxed/simple;
	bh=DYwtOowSorQf8W/s1eRFLYfspBNq5BINeak1ohYZ0f0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=gnFhaOzk/bMbMMKEmzcIxLgZc1DOp35+PIY2O6qTSjTUoP82sqrCSD710C1KxGTGM6qmumnxN62qxyTRFMvomMwSOliLLF5Xc3sR5bbc4kX0GdnY5rGH7sY70e0ZhuYOaCFLOmRejlQ5nHLOh8aWVYiJKv/2rMzACDckcEcFpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG2D8dQk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG2D8dQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716412340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=e5HgR1UJJHE4pqNLP7HJRqo1yRZdPdGaAXEqWOstEzk=;
	b=AG2D8dQk1S5jv/pUYmcfxVunmPmIDnakGXAZPDmAnY/8SC43AROhjPpWg/0XezN//ghrVi
	AY4yV/v/gs00zANxeoPSt80yF4lFWASGcbDiQfBYuh7YqVlTVgT+WaLDIwutSV+Lm88qI7
	BW2M8P4qYUboiO6drTN1GUUMt0rJzY8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-jD23OcejMCWzTI9Q9-d0Eg-1; Wed,
 22 May 2024 17:12:17 -0400
X-MC-Unique: jD23OcejMCWzTI9Q9-d0Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B79A3C025BA;
	Wed, 22 May 2024 21:12:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44C0E100046D;
	Wed, 22 May 2024 21:12:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>
cc: dhowells@redhat.com, Christian Schoenebeck <linux_oss@crudebyte.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, v9fs@lists.linux.dev,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: Enable multipage folios
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <463765.1716412334.1@warthog.procyon.org.uk>
Date: Wed, 22 May 2024 22:12:14 +0100
Message-ID: <463766.1716412334@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

    
Enable support for multipage folios on the 9P filesystem.  This is all
handled through netfslib and is already enabled on AFS and CIFS also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_inode.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 7a3308d77606..8c9a896d691e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -295,6 +295,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			inode->i_op = &v9fs_file_inode_operations;
 			inode->i_fop = &v9fs_file_operations;
 		}
+		mapping_set_large_folios(inode->i_mapping);
 
 		break;
 	case S_IFLNK:


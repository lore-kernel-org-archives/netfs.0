Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30C5DF3D
	for <netfs@lists.linux.dev>; Mon, 29 Jan 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529325; cv=none; b=Z3EAxQ1O0nHSN9cjbuTHmNXMkTuf0hH/ZHtpT4HCokav5cc3clOvBz1MSJUO6D0TqWWbjbapVszoLTfq/3uufWf474Pd4TrX71vMRfVONggb9JBHB4ILrxVxJCB5glCz6TfBxxb6k5byZ3sUREiSEnq52oD/Vck4areqA4k4JFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529325; c=relaxed/simple;
	bh=AnzxcJj9wjtJkMYs3W/gQlln1rYbehXjbzJ6iBM9txw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwoH2s79cR6ZjfJEy9wlVK8cKfAxgWU3X5qzHRPVJ2nzyaxttyv1uc2b/SWry9cdyBtF2RCYbCxlL0hM7EGiH+0RH908NdwxgEwLIKOIdc7fjBO1bfyHdoZaVYWDFxmPGiJ8VtVUSdCWHQK5wQ/YhvtDhA9jlcxx1pO7YeTYK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQyDEz9O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQyDEz9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFEwBUvtYUzBE87TzSBBZpD+94Lt4ih08V10OQ70ATs=;
	b=UQyDEz9O8s45xv9LJ+kacwJitSWmgx4hd1dkWPu+t0SQELknfrMGSvmUmAjhy2USf1TYJ7
	TBIKaTjoMHsFkCu/4KCpjA9k9TFn4o7OZ8+8ZaQ2Z24eJDBM1drEcstRhQmSPClLj1TFhC
	6Rgpy9Fo8Uu4Kdo8tRmyzxrWxnjTRKI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-3fM3ZQmaN2O0NeesbjZpxw-1; Mon, 29 Jan 2024 06:55:21 -0500
X-MC-Unique: 3fM3ZQmaN2O0NeesbjZpxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FC87185A780;
	Mon, 29 Jan 2024 11:55:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C99E4492BC6;
	Mon, 29 Jan 2024 11:55:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Cc: David Howells <dhowells@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] 9p: Enable large folio support
Date: Mon, 29 Jan 2024 11:54:35 +0000
Message-ID: <20240129115512.1281624-2-dhowells@redhat.com>
In-Reply-To: <20240129115512.1281624-1-dhowells@redhat.com>
References: <20240129115512.1281624-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Dominique Martinet <asmadeus@codewreck.org>

Enable large folio support in 9P now that the VM/VFS data I/O interface is
handled through netfslib.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
---
 fs/9p/vfs_inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 32572982f72e..ca9f504b9daf 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -262,6 +262,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	inode->i_rdev = rdev;
 	simple_inode_init_ts(inode);
 	inode->i_mapping->a_ops = &v9fs_addr_operations;
+	mapping_set_large_folios(inode->i_mapping);
 	inode->i_private = NULL;
 
 	switch (mode & S_IFMT) {


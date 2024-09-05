Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8542C0B;
	Thu,  5 Sep 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518810; cv=none; b=JGscI+2Nl+RF/o4F5uxKN3xsSGpMu2DyrqS1OLHbR7adssVcOh1yAg5rap3cwSfdYqqrYrsqXfo5fKwrsTMWOA987iodKHbjLUk1r4vgxkiWnMPJIInle1iDnGfZDkj+RIPGF5eDGySueIvcDnxT8rRm6ycu5jk7ZIGljJsFVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518810; c=relaxed/simple;
	bh=38JsQ1Jq63ahIUMQOrTKd3e8gtJecngXzxRxlfLO/d8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vp+A8rS9TzoMBZCKZAM19CSVHkzSsjbHlsAWKOfhphfjEIbK53A7z6esdXHScenJ5fUlmpJbfOqOnFzE9LeaGkLEZBvyTgYkz9iUucYU5E2dKOKd8P3SReK8YqvUzCn+4Xzx+7w6kuq4z9yTSbmSNY0Plzo5/fqC2mjftpVamk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QegYRVrb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QegYRVrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CE5C4CEC4;
	Thu,  5 Sep 2024 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725518810;
	bh=38JsQ1Jq63ahIUMQOrTKd3e8gtJecngXzxRxlfLO/d8=;
	h=Subject:To:Cc:From:Date:From;
	b=QegYRVrb2NzR7xvbBNcZMUcEpgA+F50GaPdJssc0XzamdfOhOHWA5Fiy4Qt0euORw
	 EmY7BpOjlZdcsu7AGNtI+q3jQ2rOoypLHkQdzahAmzmkdMQ3+N5wFh5LL7Hg2d2I1p
	 Fp/C9ouggfYndWW3efK6ag01QHtsF/zS51Z/P02M=
Subject: Patch "mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()" has been added to the 6.10-stable tree
To: akpm@linux-foundation.org,brauner@kernel.org,devel@lists.orangefs.org,dhowells@redhat.com,gregkh@linuxfoundation.org,hch@lst.de,jlayton@kernel.org,linux-afs@lists.infradead.org,linux-mm@kvack.org,miklos@szeredi.hu,netfs@lists.linux.dev,trond.myklebust@hammerspace.com,v9fs@lists.linux.dev,viro@zeniv.linux.org.uk,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 05 Sep 2024 08:46:46 +0200
Message-ID: <2024090546-massive-repulsion-9ceb@gregkh>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mm-fix-filemap_invalidate_inode-to-use-invalidate_inode_pages2_range.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From c26096ee0278c5e765009c5eee427bbafe6dc090 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 28 Aug 2024 22:02:45 +0100
Subject: mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()

From: David Howells <dhowells@redhat.com>

commit c26096ee0278c5e765009c5eee427bbafe6dc090 upstream.

Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
rather than truncate_inode_pages_range().  The latter clears the
invalidated bit of a partial pages rather than discarding it entirely.
This causes copy_file_range() to fail on cifs because the partial pages at
either end of the destination range aren't evicted and reread, but rather
just partly cleared.

This causes generic/075 and generic/112 xfstests to fail.

Fixes: 74e797d79cf1 ("mm: Provide a means of invalidation without using launder_folio")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240828210249.1078637-5-dhowells@redhat.com
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4221,7 +4221,7 @@ int filemap_invalidate_inode(struct inod
 	}
 
 	/* Wait for writeback to complete on all folios and discard. */
-	truncate_inode_pages_range(mapping, start, end);
+	invalidate_inode_pages2_range(mapping, start / PAGE_SIZE, end / PAGE_SIZE);
 
 unlock:
 	filemap_invalidate_unlock(mapping);


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.10/mm-fix-filemap_invalidate_inode-to-use-invalidate_inode_pages2_range.patch

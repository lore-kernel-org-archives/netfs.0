Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8A3A7F50;
	Mon, 24 Aug 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562403; cv=none; b=DG5Drwa+IhL6UKgbwEp7xVYBuAs+7V85ZiPCn6S9Dushj71s2fGqYxfRm/JglP2iwXb4v+d5GvZ9lzoXvPeCHV2l2aDSNBcROOBaM7D55Z5ZTAeA0bb9aZX8/64a95aizhrcbpkHHjXi+Us2ReJCd73y2lCXxSy5RhXX+J2FtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562403; c=relaxed/simple;
	bh=+ZSZbkJdsImETUGuTtio86WDsSfsd+pwQXtG8mGMv/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QEiNOs9SunGfXHZWs6RCTHKC1PdvlF7mRUhWo39vFL8O1jVsFTrcSzOgs+3YnOfS1JVNzw9sD/p3XSEC8Vt7sOXvRJWumNWJa0Rn1kHMMQZp/md/S3qn67rpA9gtdUCBOd3+7dzJpeyjGWbFPKX8OafqUN7+bz8mDDJk8SsdbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LdtjZU66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LdtjZU66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8521F000E9;
	Mon, 24 Aug 2026 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787562402;
	bh=KJKUYHjcJzfcom8okmtFp+hkII8rJzalq3Rzztwhfhk=;
	h=Subject:To:Cc:From:Date;
	b=LdtjZU66UQx3eyw8rGGPftlPc9is/hPgRTalVWMJFJQaqE+WXY4Pzo6W9xkFAamQj
	 G7XQKrpQFg9FBd0RRT5W5MoJLsQJdbsUUQC+c3kxB7Iqk/WhXtaElMhSBxsZjuY/bV
	 a0NoCUFUyf8TAmcI2znbPllawr1HaHHP2NFQpwXI=
Subject: Patch "netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()" has been added to the 6.12-stable tree
To: Slava.Dubeyko@ibm.com,brauner@kernel.org,demonaxsh@gmail.com,dhowells@redhat.com,gregkh@linuxfoundation.org,netfs@lists.linux.dev,pc@manguebit.org,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 11:06:21 +0200
Message-ID: <2026082421-agility-reusable-88f1@gregkh>
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

    netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-potential-uaf-in-netfs_unlock_abandoned_read_pages.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From dbe556972100fabb8e5a1b3d2163831ff07b1e8e Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 12 May 2026 13:33:56 +0100
Subject: netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()

From: David Howells <dhowells@redhat.com>

commit dbe556972100fabb8e5a1b3d2163831ff07b1e8e upstream.

netfs_unlock_abandoned_read_pages(rreq) accesses the index of the folios it
is wanting to unlock and compares that to rreq->no_unlock_folio so that it
doesn't unlock a folio being read for netfs_perform_write() or
netfs_write_begin().

However, given that netfs_unlock_abandoned_read_pages() is called _after_
NETFS_RREQ_IN_PROGRESS is cleared, the one folio that it's not allowed to
dereference is the one specified by ->no_unlock_folio as ownership
immediately reverts to the caller.

Fix this by storing the folio pointer instead and using that rather than
the index.  Also fix netfs_unlock_read_folio() where the same applies.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-20-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Shishkin Aleksey <demonaxsh@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/buffered_read.c |    4 ++--
 fs/netfs/read_collect.c  |    2 +-
 fs/netfs/read_retry.c    |    2 +-
 include/linux/netfs.h    |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -734,7 +734,7 @@ retry:
 		ret = PTR_ERR(rreq);
 		goto error;
 	}
-	rreq->no_unlock_folio	= folio->index;
+	rreq->no_unlock_folio	= folio;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 
 	ret = netfs_begin_cache_read(rreq, ctx);
@@ -800,7 +800,7 @@ int netfs_prefetch_for_write(struct file
 		goto error;
 	}
 
-	rreq->no_unlock_folio = folio->index;
+	rreq->no_unlock_folio = folio;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 	ret = netfs_begin_cache_read(rreq, ctx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -73,7 +73,7 @@ static void netfs_unlock_read_folio(stru
 	}
 
 	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-		if (folio->index == rreq->no_unlock_folio &&
+		if (folio == rreq->no_unlock_folio &&
 		    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
 			_debug("no unlock");
 		} else {
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -249,7 +249,7 @@ void netfs_unlock_abandoned_read_pages(s
 			struct folio *folio = folioq_folio(p, slot);
 
 			if (folio && !folioq_is_marked2(p, slot)) {
-				if (folio->index == rreq->no_unlock_folio &&
+				if (folio == rreq->no_unlock_folio &&
 				    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO,
 					     &rreq->flags)) {
 					_debug("no unlock");
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -266,7 +266,7 @@ struct netfs_io_request {
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
-	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
+	const struct folio	*no_unlock_folio; /* Don't unlock this folio after read */
 	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.12/netfs-fix-potential-uaf-in-netfs_unlock_abandoned_read_pages.patch

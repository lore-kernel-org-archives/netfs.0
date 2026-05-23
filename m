Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C8356775;
	Sat, 23 May 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528220; cv=none; b=uYOvZqsq46LOZvG0jCW/z/v9KbgYEJRYiDejEzO/4w1C6D9Y2SX6Iqymgi5CgC6ijWZgPhu4SfuRg4y+C3XGWmJqpt9xBlmhcoP1rbsTrn4IXD/vGRr+hGab3LfeLV1n2Ab39O2+Ydsdyw6LdbnkpfcAs0cOZta5G2s230YZNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528220; c=relaxed/simple;
	bh=ALVWjdT8+GSHT24aGdIjE9GLUfk+v7b3HkfSyrvvkU4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l23Lk29lc1IfrbxDeNGUMeTbVl2JSn4/fXFts65KUZOjoKNCjOoD5lwmv1vNK1BBNU4ypg0oVFqqmodsy+E0F+F40z4vRXYxU2EIw35d/hw4ASeWpksnXbCfBDUSn+B6Mp9p/L+23Ia5k1lQn+0EtmFpuSBVhNoPFaTyzZAIBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NM3JQIOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NM3JQIOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845C21F000E9;
	Sat, 23 May 2026 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779528219;
	bh=i/ragtjfYGdr3nlYfSeNFJreoHuC61xNrx93U07oE6U=;
	h=Subject:To:Cc:From:Date;
	b=NM3JQIOEiyZSV/aUCTGVQop+IoJ4f5FWS0DBRwwC5NtpoSXxo9/Kp748FSRZULyh7
	 D5Yu2D37W1TlDW+7BneuDh/6J+9vUuknRXyBc8mRuFKH0SjpWcZOA7+jPZKm8mG4J7
	 chBxOkPC0LYt5rS71G5BsdYO74dOHh59PDsF6c/c=
Subject: Patch "netfs: Fix potential uninitialised var in netfs_extract_user_iter()" has been added to the 6.18-stable tree
To: brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,netfs@lists.linux.dev,pc@manguebit.org,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 May 2026 11:23:41 +0200
Message-ID: <2026052341-stingy-comply-cacd@gregkh>
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

    netfs: Fix potential uninitialised var in netfs_extract_user_iter()

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-potential-uninitialised-var-in-netfs_extract_user_iter.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 7e3d8db899d54af39fafb2eb3392b0cdae9973b5 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 12 May 2026 13:33:45 +0100
Subject: netfs: Fix potential uninitialised var in netfs_extract_user_iter()

From: David Howells <dhowells@redhat.com>

commit 7e3d8db899d54af39fafb2eb3392b0cdae9973b5 upstream.

In netfs_extract_user_iter(), if it's given a zero-length iterator, it will
fall through the loop without setting ret, and so the error handling
behaviour will be undefined, depending on whether ret happens to be
negative.  The value of ret then propagates back up the callstack.

Fix this by presetting ret to 0.

Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-9-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/iterator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -43,7 +43,7 @@ ssize_t netfs_extract_user_iter(struct i
 	unsigned int max_pages;
 	unsigned int npages = 0;
 	unsigned int i;
-	ssize_t ret;
+	ssize_t ret = 0;
 	size_t count = orig_len, offset, len;
 	size_t bv_size, pg_size;
 


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.18/netfs-fix-error-handling-in-netfs_extract_user_iter.patch
queue-6.18/netfs-fix-potential-uninitialised-var-in-netfs_extract_user_iter.patch
queue-6.18/lib-kunit_iov_iter-fix-memory-leaks.patch

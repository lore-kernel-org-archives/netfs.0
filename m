Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD58356775;
	Sat, 23 May 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528230; cv=none; b=TFDemfQS72Pq6RPaFDLmoNwom1S3/FHbroOxo3PA/qi7kMz/oe+AuLZTybr1IRJ0nVqiF7bJQvkdT7c4KcbuaJxUVPmzgaiPSsvkvKCblHUMSpmjT7QVyoKiGEfKjtHNnNgxuWUM4CAygxXViGDeJ+SZ5WiPhwPxWLQ5iTlYC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528230; c=relaxed/simple;
	bh=bUIUGFKnY3Z4EVRyWqxE78d/xZ/iydFC4PoS+S4qLJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gcilaXnd965tNoA0e7o62OS8SYFjfE2Ra/haW5M1Au7pbUBhAqx1Qlf+9TM+Vd4GX+VAFz2XquSb1ZTYcGZaLTEe535D5fjY3sNKwlKKiLPbweblZxd5TcZITGbFS4cFESR1vUKEqy4asssTQkNXGGt1fpfl6V+NTYk+t8cwZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oh4lBiK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oh4lBiK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5591F000E9;
	Sat, 23 May 2026 09:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779528229;
	bh=2XGEAsO83+mFX8zHP0SN+MoQZ49jKrFiYv8r6Cqnit0=;
	h=Subject:To:Cc:From:Date;
	b=Oh4lBiK6q7UWP7WA474nFLW/crEXpDDuPhf3b12tT5NTWztPI35HGy2073bUJvRFu
	 VsRQ3Zh5RBQA+1Mg8oRaYHIiNaW63uPzGxUUP61ASpCXHTTDEDxRElB4b4gjQMYlnO
	 0SMXd3ssw7bte2ycYlycEy9yT0olUy5W33H4nNc8=
Subject: Patch "netfs: Fix potential uninitialised var in netfs_extract_user_iter()" has been added to the 7.0-stable tree
To: brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,netfs@lists.linux.dev,pc@manguebit.org,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 May 2026 11:23:51 +0200
Message-ID: <2026052351-twiddle-obliged-1a2b@gregkh>
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

to the 7.0-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-potential-uninitialised-var-in-netfs_extract_user_iter.patch
and it can be found in the queue-7.0 subdirectory.

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

queue-7.0/netfs-fix-error-handling-in-netfs_extract_user_iter.patch
queue-7.0/netfs-fix-potential-uninitialised-var-in-netfs_extract_user_iter.patch
queue-7.0/lib-kunit_iov_iter-fix-memory-leaks.patch

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3433F4DFE;
	Wed, 20 May 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288951; cv=none; b=ofA0vYvZ7HahWhID5U/SxZRms00oJGTZDq554vg3ce2bZVlMrs6juyMWVNJj7reWEuqnL4bQJkp9Ho5deoIxAmuD8jklg8+9D48Hle7FDjv0hNq7Jqdrmy3fYregFb53Mdn5V5E/lgrJR4WRibDJYCs+jhl4e6lxKfDEMZ7dcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288951; c=relaxed/simple;
	bh=1ZFT2xwRnipcgnYme9F+Kdg+2Jc6VYQwi8OSLQFjaao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=neW2+egl6jXJO4b4zKYn4ccYq1bwNFbpD3NTNfiG2aGWcBYnZ5H+tUnoXz2d5ExikfWKW7X3Gb4T/FNekLlS5nMwE4sCfqQTxmDGnHU0j+h618f7k+5Zxc6fI+CAJz+/PjOJg5fYZNc6QaaYNGB/dtan/OKD+nSCwIlVslpIOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=06lZBJxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="06lZBJxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D231F000E9;
	Wed, 20 May 2026 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288950;
	bh=HLE62M7w9kZ6jsf9hfAUbwys/2p9xPwFi+21QB5zz3Q=;
	h=Subject:To:Cc:From:Date;
	b=06lZBJxC2PEuo0FUOfV8xCfIqx6ZM0wE0R3wvs0GV3wact7rSjf9zg/gt0/0gkzgB
	 tLLeXw+TNL8g9BkkgHzmZAiDKQzjgbtv6XRQNd4RVnwJZ6LXPqZ4dziUeWnfyCJu7C
	 Icj9A4SgsN5FjeOzSgXy28RO9tiLpMqYw7atQzTY=
Subject: Patch "netfs: fix error handling in netfs_extract_user_iter()" has been added to the 7.0-stable tree
To: brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,netfs@lists.linux.dev,pc@manguebit.org,xifeng@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:54:24 +0200
Message-ID: <2026052024-explain-idealism-239e@gregkh>
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

    netfs: fix error handling in netfs_extract_user_iter()

to the 7.0-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-error-handling-in-netfs_extract_user_iter.patch
and it can be found in the queue-7.0 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 0aad5704c6b4d14007d4eab15883e8524e4310f4 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Tue, 12 May 2026 13:33:46 +0100
Subject: netfs: fix error handling in netfs_extract_user_iter()

From: Paulo Alcantara <pc@manguebit.org>

commit 0aad5704c6b4d14007d4eab15883e8524e4310f4 upstream.

In netfs_extract_user_iter(), if iov_iter_extract_pages() failed to
extract user pages, bail out on -ENOMEM, otherwise return the error
code only if @npages == 0, allowing short DIO reads and writes to be
issued.

This fixes mmapstress02 from LTP tests against CIFS.

Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator")
Reported-by: Xiaoli Feng <xifeng@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-10-dhowells@redhat.com
Cc: netfs@lists.linux.dev
Cc: stable@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/iterator.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -22,7 +22,7 @@
  *
  * Extract the page fragments from the given amount of the source iterator and
  * build up a second iterator that refers to all of those bits.  This allows
- * the original iterator to disposed of.
+ * the original iterator to be disposed of.
  *
  * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
  * allowed on the pages extracted.
@@ -67,8 +67,8 @@ ssize_t netfs_extract_user_iter(struct i
 		ret = iov_iter_extract_pages(orig, &pages, count,
 					     max_pages - npages, extraction_flags,
 					     &offset);
-		if (ret < 0) {
-			pr_err("Couldn't get user pages (rc=%zd)\n", ret);
+		if (unlikely(ret <= 0)) {
+			ret = ret ?: -EIO;
 			break;
 		}
 
@@ -97,6 +97,13 @@ ssize_t netfs_extract_user_iter(struct i
 		npages += cur_npages;
 	}
 
+	if (ret < 0 && (ret == -ENOMEM || npages == 0)) {
+		for (i = 0; i < npages; i++)
+			unpin_user_page(bv[i].bv_page);
+		kvfree(bv);
+		return ret;
+	}
+
 	iov_iter_bvec(new, orig->data_source, bv, npages, orig_len - count);
 	return npages;
 }


Patches currently in stable-queue which might be from pc@manguebit.org are

queue-7.0/netfs-fix-error-handling-in-netfs_extract_user_iter.patch

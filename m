Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E13356775;
	Sat, 23 May 2026 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528203; cv=none; b=GLRm/df0Ie4LrJ7XND8ZfguNLPVZV+R+3jnQEZPZiw53xnQiI+57vzI2/fBKI6KPG2gUBKED5zr94cro70iSmTDD5qqmfFwG5CBtDiZcBFe9nUwaJxahU1fFhutQBQw6uvJIzlh+OcEGVACuPFjYnMUvGZskBHe3npA5KP9NPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528203; c=relaxed/simple;
	bh=CfLQSBRaO4UqVG4Be1VKj4u5hQfIaG78aPm+DsWh670=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TNpZnw4BTifEZ+H/GKM+zn/TqHY1PPMmTHUQcojQW6A/HiI8UcdlNiquAEaSPcHGcNlxKFSIsyIUMEsfo03EDeVL+uSNnjPaZPEpASzq4ktEz9krb7cyT/tB/oOxHAb+inD6sLn76eGE05MfYCVAbbD8+ZOBXQkyUNwo5Ba+im4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X4v5yjsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4v5yjsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F91F1F000E9;
	Sat, 23 May 2026 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779528201;
	bh=cq4ufJP+S9L8bn4FrB5ykgxkPRMsLDZCjdzapz1YVjM=;
	h=Subject:To:Cc:From:Date;
	b=X4v5yjsV+PkbfGbo3xCMIBOu/l9D57ZIyXnxDmW+8AHkzba0QcMxcsXW6G0teRy1O
	 2x96L5DrI418rA6lE9kSjAmwKr8E760JZEdsByQNo6o49XGyOK2drM94R+2jX2NG6m
	 18jy/eSRiJhDUKZaLiCj2tzJIgpgaiDBwgh3nYzM=
Subject: Patch "netfs: Fix potential uninitialised var in netfs_extract_user_iter()" has been added to the 6.6-stable tree
To: brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,netfs@lists.linux.dev,pc@manguebit.org,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 May 2026 11:23:24 +0200
Message-ID: <2026052324-disprove-playmate-a3f9@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-potential-uninitialised-var-in-netfs_extract_user_iter.patch
and it can be found in the queue-6.6 subdirectory.

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

queue-6.6/netfs-fix-error-handling-in-netfs_extract_user_iter.patch
queue-6.6/netfs-fix-potential-uninitialised-var-in-netfs_extract_user_iter.patch

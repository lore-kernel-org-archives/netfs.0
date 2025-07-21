Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805428B4FD;
	Mon, 21 Jul 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096133; cv=none; b=XLEzf5VeJwsMVfItkKILimZHevMPP3mw6OtK3Omak26oYwM/rjsIu7uaUymWgjvVXtcEeQsTOYjp7xrb+c6H//PbH8LGPjWLX0W42lc4yuSulxGAkgb32wntI3xsQxRItY14YuQwaxyCGq+M1U+3fvYbU4k+nUvoV+qQoNYIJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096133; c=relaxed/simple;
	bh=kSaaXoMSLzUcuymSngh4s7KVmijU6blDJ0zkWES/Fmo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h/NQHIouel0RJ7RTEb2t8qlTMwn+Ugl2sOVQsJIuNjTbFeo9CjFvMAkC0DOKSkJxMmN9kuSvuF74ZYbiLdOPD/9DGI8G2bMWQJChJh+uh2EK3udYv7akADXjZyJmdWHPYTbjw5drZ8lofgjKfybiux6ae8whIeQ8JmFadbZoxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jXLF7tNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jXLF7tNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D90EC4CEF1;
	Mon, 21 Jul 2025 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753096133;
	bh=kSaaXoMSLzUcuymSngh4s7KVmijU6blDJ0zkWES/Fmo=;
	h=Subject:To:Cc:From:Date:From;
	b=jXLF7tNLjuwhKgsqNUzCfgz88+C/fHgoYYlMtDJ6uunvROmCcOnZRQJraqsDlxfBX
	 u/P49qeuIBiwjtsYapiQBpK8kck/N5x0OIIdifYuikamvPwikK1RW20RWsPHgm4dA9
	 XK2Nx/CuZAwXSqFAwq/OiV7QBKNtpJ5771O7WMNc=
Subject: Patch "netfs: Fix copy-to-cache so that it performs collection with ceph+fscache" has been added to the 6.15-stable tree
To: amarkuze@redhat.com,brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,idryomov@gmail.com,max.kellermann@ionos.com,netfs@lists.linux.dev,pc@manguebit.org,slava@dubeyko.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:06:46 +0200
Message-ID: <2025072145-overjoyed-skinhead-4175@gregkh>
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

    netfs: Fix copy-to-cache so that it performs collection with ceph+fscache

to the 6.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-copy-to-cache-so-that-it-performs-collection-with-ceph-fscache.patch
and it can be found in the queue-6.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 4c238e30774e3022a505fa54311273add7570f13 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 11 Jul 2025 16:10:00 +0100
Subject: netfs: Fix copy-to-cache so that it performs collection with ceph+fscache

From: David Howells <dhowells@redhat.com>

commit 4c238e30774e3022a505fa54311273add7570f13 upstream.

The netfs copy-to-cache that is used by Ceph with local caching sets up a
new request to write data just read to the cache.  The request is started
and then left to look after itself whilst the app continues.  The request
gets notified by the backing fs upon completion of the async DIO write, but
then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
set - but the app isn't waiting there, and so the request just hangs.

Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
notification from the backing filesystem to put the collection onto a work
queue instead.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250711151005.2956810-2-dhowells@redhat.com
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_pgpriv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 5bbe906a551d..080d2a6a51d9 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -110,6 +110,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	if (!creq->io_streams[1].avail)
 		goto cancel_put;
 
+	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache = creq;
-- 
2.50.1



Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.15/netfs-fix-copy-to-cache-so-that-it-performs-collection-with-ceph-fscache.patch
queue-6.15/netfs-fix-race-between-cache-write-completion-and-all_queued-being-set.patch

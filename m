Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C60293B55;
	Mon, 21 Jul 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096124; cv=none; b=COIbzbmPg5iOxS+Qh2k4KEs7h0XxCxokbdrrnL0vcR7mKuCuy2GSB4Ek1xxk/wk83rT7u/mk5VymYl+tUa709hBjQYirLTgZqmiAbddMaMbQ+0UpKbsctKF9LAknv4y5jqNBbW1wc3tXpAPK/bi9ourkEblahroOqbBFg3UyIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096124; c=relaxed/simple;
	bh=AOTL1Z8mCYXOoQetePWeptu8THkeYccOLDjAQAEQkMs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bt12/16qyy5kGcqBaLt00n5c2S/OhcG9oQu4rL4ZJ0QQGxUQZcXAbOkiewOyVQEHi1yibEOe8YyaNCdHqVd8ZKMSG8IoEH63sNU2zlL6Clyeclb2QT4tRLx064/Z9TT/KcYP2aELYe+LWElWkXoF9UWwposKgV7mp6Kb8U4D5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IBz4MSHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IBz4MSHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CFEC4CEF1;
	Mon, 21 Jul 2025 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753096124;
	bh=AOTL1Z8mCYXOoQetePWeptu8THkeYccOLDjAQAEQkMs=;
	h=Subject:To:Cc:From:Date:From;
	b=IBz4MSHRsSDjp3zu7zPq9JjjBmj1MBXWzMzuqfNDNP/PjOM9WzjDyYCu+Ve78K4cU
	 nw0IBentn4pWdrLmB78Dg3BIH8Bns0HMChoJ9k8tuk1iF7Yxo+9PAsEjuP7nV1dgdC
	 Fff+noaz00tCmFJL0fUbRAAKzNhbkNmQ+jHyolLo=
Subject: Patch "netfs: Fix race between cache write completion and ALL_QUEUED being set" has been added to the 6.15-stable tree
To: amarkuze@redhat.com,brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,idryomov@gmail.com,max.kellermann@ionos.com,netfs@lists.linux.dev,pc@manguebit.org,slava@dubeyko.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:06:46 +0200
Message-ID: <2025072146-outspoken-delicacy-3eed@gregkh>
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

    netfs: Fix race between cache write completion and ALL_QUEUED being set

to the 6.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-fix-race-between-cache-write-completion-and-all_queued-being-set.patch
and it can be found in the queue-6.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 89635eae076cd8eaa5cb752f66538c9dc6c9fdc3 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 11 Jul 2025 16:10:01 +0100
Subject: netfs: Fix race between cache write completion and ALL_QUEUED being set

From: David Howells <dhowells@redhat.com>

commit 89635eae076cd8eaa5cb752f66538c9dc6c9fdc3 upstream.

When netfslib is issuing subrequests, the subrequests start processing
immediately and may complete before we reach the end of the issuing
function.  At the end of the issuing function we set NETFS_RREQ_ALL_QUEUED
to indicate to the collector that we aren't going to issue any more subreqs
and that it can do the final notifications and cleanup.

Now, this isn't a problem if the request is synchronous
(NETFS_RREQ_OFFLOAD_COLLECTION is unset) as the result collection will be
done in-thread and we're guaranteed an opportunity to run the collector.

However, if the request is asynchronous, collection is primarily triggered
by the termination of subrequests queuing it on a workqueue.  Now, a race
can occur here if the app thread sets ALL_QUEUED after the last subrequest
terminates.

This can happen most easily with the copy2cache code (as used by Ceph)
where, in the collection routine of a read request, an asynchronous write
request is spawned to copy data to the cache.  Folios are added to the
write request as they're unlocked, but there may be a delay before
ALL_QUEUED is set as the write subrequests may complete before we get
there.

If all the write subreqs have finished by the ALL_QUEUED point, no further
events happen and the collection never happens, leaving the request
hanging.

Fix this by queuing the collector after setting ALL_QUEUED.  This is a bit
heavy-handed and it may be sufficient to do it only if there are no extant
subreqs.

Also add a tracepoint to cross-reference both requests in a copy-to-request
operation and add a trace to the netfs_rreq tracepoint to indicate the
setting of ALL_QUEUED.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250711151005.2956810-3-dhowells@redhat.com
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
 fs/netfs/read_pgpriv2.c      |    4 ++++
 include/trace/events/netfs.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -111,6 +111,7 @@ static struct netfs_io_request *netfs_pg
 		goto cancel_put;
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
+	trace_netfs_copy2cache(rreq, creq);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache = creq;
@@ -155,6 +156,9 @@ void netfs_pgpriv2_end_copy_to_cache(str
 	netfs_issue_write(creq, &creq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &creq->flags);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_end_copy_to_cache);
+	if (list_empty_careful(&creq->io_streams[1].subrequests))
+		netfs_wake_collector(creq);
 
 	netfs_put_request(creq, netfs_rreq_trace_put_return);
 	creq->copy_to_cache = NULL;
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -55,6 +55,7 @@
 	EM(netfs_rreq_trace_complete,		"COMPLET")	\
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
+	EM(netfs_rreq_trace_end_copy_to_cache,	"END-C2C")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
@@ -550,6 +551,35 @@ TRACE_EVENT(netfs_write,
 		      __entry->start, __entry->start + __entry->len - 1)
 	    );
 
+TRACE_EVENT(netfs_copy2cache,
+	    TP_PROTO(const struct netfs_io_request *rreq,
+		     const struct netfs_io_request *creq),
+
+	    TP_ARGS(rreq, creq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		creq)
+		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		ino)
+			     ),
+
+	    TP_fast_assign(
+		    struct netfs_inode *__ctx = netfs_inode(rreq->inode);
+		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
+		    __entry->rreq	= rreq->debug_id;
+		    __entry->creq	= creq->debug_id;
+		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->ino	= rreq->inode->i_ino;
+			   ),
+
+	    TP_printk("R=%08x CR=%08x c=%08x i=%x ",
+		      __entry->rreq,
+		      __entry->creq,
+		      __entry->cookie,
+		      __entry->ino)
+	    );
+
 TRACE_EVENT(netfs_collect,
 	    TP_PROTO(const struct netfs_io_request *wreq),
 


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.15/netfs-fix-copy-to-cache-so-that-it-performs-collection-with-ceph-fscache.patch
queue-6.15/netfs-fix-race-between-cache-write-completion-and-all_queued-being-set.patch

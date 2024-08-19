Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401813D2AF;
	Mon, 19 Aug 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724041505; cv=none; b=eOywgMQfnVQnP3K/O7p0nqopoWSbJ9IfuPeenLQH6TWe+at85jvUy9rAQ6m7ziT2gyXa/b1/cqqHZAWxrRFoxiNeukLQYOSjB+ZuOyaKs4inx1/5rC84Po0UDniTZYDE6Vm1FdSYTSUUhFxsD5W+v+PQPJyzI/ZEVh9vck2NaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724041505; c=relaxed/simple;
	bh=XclenVQ+XvlazwuSGY8fupxdets+iDtH0zr+5wVO8Ak=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vvw2du5Lv9UQZI1NQN5N6fvcoCSYskg1+0cYGhv26rMJmU1WwkZvlo0s269pPX+wnQxEGu+Ju25tf9O++CDuMOZrLCrQxQNbs1libWVd6CTN5nLK/XwpC6/KFrYjMwyfBRrm2dEZoa+FKy/yxUr43GbcGrO5yBV7O14OKLOWTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIrEuKWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIrEuKWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D68C32782;
	Mon, 19 Aug 2024 04:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724041505;
	bh=XclenVQ+XvlazwuSGY8fupxdets+iDtH0zr+5wVO8Ak=;
	h=Subject:To:Cc:From:Date:From;
	b=LIrEuKWqioqXsUrR0zd85ifckqQAGLPSF4m27RWD3ymAAwuvcc/ExTi4qpwYRs71E
	 51ywWMK70Z13HLDMGIUYr1rW426iNzJp15AJWiznn4zhIT3Li6CzknedCMZS7eMNJq
	 GWUsjHJMwfsVKEKr5qwZgEelbx4OFDdPsMP9cwYU=
Subject: Patch "netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"" has been added to the 6.10-stable tree
To: 3575457.1722355300@warthog.procyon.org.uk,brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,idryomov@gmail.com,jlayton@kernel.org,linux-mm@kvack.org,max.kellermann@ionos.com,netfs@lists.linux.dev,willy@infradead.org,xiubli@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 06:24:52 +0200
Message-ID: <2024081952-broiler-extrovert-52b9@gregkh>
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

    netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-ceph-revert-netfs-remove-deprecated-use-of-pg_private_2-as-a-second-writeback-flag.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 8e5ced7804cb9184c4a23f8054551240562a8eda Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 30 Jul 2024 17:01:40 +0100
Subject: netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"

From: David Howells <dhowells@redhat.com>

commit 8e5ced7804cb9184c4a23f8054551240562a8eda upstream.

This reverts commit ae678317b95e760607c7b20b97c9cd4ca9ed6e1a.

Revert the patch that removes the deprecated use of PG_private_2 in
netfslib for the moment as Ceph is actually still using this to track
data copied to the cache.

Fixes: ae678317b95e ("netfs: Remove deprecated use of PG_private_2 as a second writeback flag")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
https: //lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/addr.c               |   19 +++++
 fs/netfs/buffered_read.c     |    8 ++
 fs/netfs/io.c                |  144 +++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/netfs.h |    1 
 4 files changed, 170 insertions(+), 2 deletions(-)

--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -498,6 +498,11 @@ const struct netfs_request_ops ceph_netf
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
+static void ceph_set_page_fscache(struct page *page)
+{
+	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
+}
+
 static void ceph_fscache_write_terminated(void *priv, ssize_t error, bool was_async)
 {
 	struct inode *inode = priv;
@@ -515,6 +520,10 @@ static void ceph_fscache_write_to_cache(
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
+static inline void ceph_set_page_fscache(struct page *page)
+{
+}
+
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -706,6 +715,8 @@ static int writepage_nounlock(struct pag
 		len = wlen;
 
 	set_page_writeback(page);
+	if (caching)
+		ceph_set_page_fscache(page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -789,6 +800,8 @@ static int ceph_writepage(struct page *p
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
 
+	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
+
 	err = writepage_nounlock(page, wbc);
 	if (err == -ERESTARTSYS) {
 		/* direct memory reclaimer was killed by SIGKILL. return 0
@@ -1062,7 +1075,8 @@ get_more_pages:
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page)) {
+			if (PageWriteback(page) ||
+			    PagePrivate2(page) /* [DEPRECATED] */) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					doutc(cl, "%p under writeback\n", page);
 					unlock_page(page);
@@ -1070,6 +1084,7 @@ get_more_pages:
 				}
 				doutc(cl, "waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
+				folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
@@ -1254,6 +1269,8 @@ new_request:
 			}
 
 			set_page_writeback(page);
+			if (caching)
+				ceph_set_page_fscache(page);
 			len += thp_size(page);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -466,7 +466,7 @@ retry:
 	if (!netfs_is_cache_enabled(ctx) &&
 	    netfs_skip_folio_read(folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
-		goto have_folio;
+		goto have_folio_no_wait;
 	}
 
 	rreq = netfs_alloc_request(mapping, file,
@@ -507,6 +507,12 @@ retry:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 
 have_folio:
+	if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags)) {
+		ret = folio_wait_private_2_killable(folio);
+		if (ret < 0)
+			goto error;
+	}
+have_folio_no_wait:
 	*_folio = folio;
 	kleave(" = 0");
 	return 0;
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -99,6 +99,146 @@ static void netfs_rreq_completed(struct
 }
 
 /*
+ * [DEPRECATED] Deal with the completion of writing the data to the cache.  We
+ * have to clear the PG_fscache bits on the folios involved and release the
+ * caller's ref.
+ *
+ * May be called in softirq mode and we inherit a ref from the caller.
+ */
+static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
+					  bool was_async)
+{
+	struct netfs_io_subrequest *subreq;
+	struct folio *folio;
+	pgoff_t unlocked = 0;
+	bool have_unlocked = false;
+
+	rcu_read_lock();
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
+
+		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
+			if (xas_retry(&xas, folio))
+				continue;
+
+			/* We might have multiple writes from the same huge
+			 * folio, but we mustn't unlock a folio more than once.
+			 */
+			if (have_unlocked && folio->index <= unlocked)
+				continue;
+			unlocked = folio_next_index(folio) - 1;
+			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
+			folio_end_private_2(folio);
+			have_unlocked = true;
+		}
+	}
+
+	rcu_read_unlock();
+	netfs_rreq_completed(rreq, was_async);
+}
+
+static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
+				       bool was_async) /* [DEPRECATED] */
+{
+	struct netfs_io_subrequest *subreq = priv;
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		netfs_stat(&netfs_n_rh_write_failed);
+		trace_netfs_failure(rreq, subreq, transferred_or_error,
+				    netfs_fail_copy_to_cache);
+	} else {
+		netfs_stat(&netfs_n_rh_write_done);
+	}
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
+
+	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, was_async);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+}
+
+/*
+ * [DEPRECATED] Perform any outstanding writes to the cache.  We inherit a ref
+ * from the caller.
+ */
+static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct netfs_io_subrequest *subreq, *next, *p;
+	struct iov_iter iter;
+	int ret;
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
+
+	/* We don't want terminating writes trying to wake us up whilst we're
+	 * still going through the list.
+	 */
+	atomic_inc(&rreq->nr_copy_ops);
+
+	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
+		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+			list_del_init(&subreq->rreq_link);
+			netfs_put_subrequest(subreq, false,
+					     netfs_sreq_trace_put_no_copy);
+		}
+	}
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		/* Amalgamate adjacent writes */
+		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+			next = list_next_entry(subreq, rreq_link);
+			if (next->start != subreq->start + subreq->len)
+				break;
+			subreq->len += next->len;
+			list_del_init(&next->rreq_link);
+			netfs_put_subrequest(next, false,
+					     netfs_sreq_trace_put_merged);
+		}
+
+		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
+					       subreq->len, rreq->i_size, true);
+		if (ret < 0) {
+			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
+			continue;
+		}
+
+		iov_iter_xarray(&iter, ITER_SOURCE, &rreq->mapping->i_pages,
+				subreq->start, subreq->len);
+
+		atomic_inc(&rreq->nr_copy_ops);
+		netfs_stat(&netfs_n_rh_write);
+		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
+		cres->ops->write(cres, subreq->start, &iter,
+				 netfs_rreq_copy_terminated, subreq);
+	}
+
+	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, false);
+}
+
+static void netfs_rreq_write_to_cache_work(struct work_struct *work) /* [DEPRECATED] */
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
+
+	netfs_rreq_do_write_to_cache(rreq);
+}
+
+static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq) /* [DEPRECATED] */
+{
+	rreq->work.func = netfs_rreq_write_to_cache_work;
+	if (!queue_work(system_unbound_wq, &rreq->work))
+		BUG();
+}
+
+/*
  * Handle a short read.
  */
 static void netfs_rreq_short_read(struct netfs_io_request *rreq,
@@ -275,6 +415,10 @@ again:
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 
+	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags) &&
+	    test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags))
+		return netfs_rreq_write_to_cache(rreq);
+
 	netfs_rreq_completed(rreq, was_async);
 }
 
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -145,6 +145,7 @@
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
 	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
+	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.10/netfs-ceph-revert-netfs-remove-deprecated-use-of-pg_private_2-as-a-second-writeback-flag.patch

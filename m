Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB77477E23
	for <netfs@lists.linux.dev>; Tue, 28 Apr 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382365; cv=none; b=ahfBHawmLfY65utQHMWodW4cmoS6MHI6Oyea2896heo/rwzcDiw9FWe/Br7AQrirvvt8gmEd0ODtJ1ZhmUULSYdqVPO10tCMfjCqWsQGhz9bb8IYt/Gfc75tYTVlXwfT+wMkYM659zA5RcG6MPGiinyeKnPvuN45wQWJpIdd5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382365; c=relaxed/simple;
	bh=3qCrcikapOBjDiKHYNn87mJHSh0bvZvMd8FSy9FXXaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HMRby3lQA18ipIIwWLCvbKXAsfNmiixT1E+J/lDLKGqSTnveBiBRGFVzljSopW9pZOjzW7eQUG6tVoURXXrLDl8TMunIZCOV772iDRdiO4TIUZ+8m34iPjVVW8Mt6CIsdrwI/JIbn0HXnztm08J2LZh8F/KI9FxebxeH8c9aTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmZDbE/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmZDbE/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3o0bVWAsa0tr+4f6EBlhwvSVQai01iQefbnN9wRCFMY=;
	b=cmZDbE/m1EAqO7DngIKVWGVZ9P6AngUqVeCdYTn4bMxfGFJD6RXrLN09ECrooWEx730ChB
	F2MnRHNTjb6lFLBpYeCyFrcVR5kTuPOMs8e3cKEdkWso8k6zIj68PMJpx6R3MeYrItnckl
	eGX4PAKPcuKtMBQTf1AgjhpIB4JnJcU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-sbygBWJ8NRWifB3zeK4WeA-1; Tue,
 28 Apr 2026 09:19:12 -0400
X-MC-Unique: sbygBWJ8NRWifB3zeK4WeA-1
X-Mimecast-MFC-AGG-ID: sbygBWJ8NRWifB3zeK4WeA_1777382351
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3A921955DB7;
	Tue, 28 Apr 2026 13:19:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 743D6180047F;
	Tue, 28 Apr 2026 13:19:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 13/24] netfs: Fix streaming write being overwritten
Date: Tue, 28 Apr 2026 14:17:43 +0100
Message-ID: <20260428131756.922303-14-dhowells@redhat.com>
In-Reply-To: <20260428131756.922303-1-dhowells@redhat.com>
References: <20260428131756.922303-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ce3DBkCfN8RYAV9AuGkRJs2u02_6lx7pTBC7W0Op6PM_1777382351
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In order to avoid reading whilst writing, netfslib will allow "streaming
writes" in which dirty data is stored directly into folios without reading
them first.  Such folios are marked dirty but may not be marked uptodate.
If a folio is entirely written by a streaming write, uptodate will be set,
otherwise it will have a netfs_folio struct attached to ->private recording
the dirty region.

In the event that a partially written streaming write page is to be
overwritten entirely by a single write(), netfs_perform_write() will try to
copy over it, but doesn't discard the netfs_folio if it succeeds; further,
it doesn't correctly handle a partial copy that overwrites some of the
dirty data.

Fix this by the following:

 (1) If the folio is successfully overwritten, free the netfs_folio struct
     before marking the page uptodate.

 (2) If the copy to the folio partially fails, but short of the dirty data,
     just ignore the copy.

 (3) If the copy partially fails and overwrites some of the dirty data,
     accept the copy, update the netfs_folio struct to record the new data.
     If the folio is now filled, free the netfs_folio and set uptodate,
     otherwise return a partial write.

Found with:

	fsx -q -N 1000000 -p 10000 -o 128000 -l 600000 \
	  /xfstest.test/junk --replay-ops=junk.fsxops

using the following as junk.fsxops:

	truncate 0x0 0 0x927c0
	write 0x63fb8 0x53c8 0
	copy_range 0xb704 0x19b9 0x24429 0x79380
	write 0x2402b 0x144a2 0x90660 *
	write 0x204d5 0x140a0 0x927c0 *
	copy_range 0x1f72c 0x137d0 0x7a906 0x927c0 *
	read 0x00000 0x20000 0x9157c
	read 0x20000 0x20000 0x9157c
	read 0x40000 0x20000 0x9157c
	read 0x60000 0x20000 0x9157c
	read 0x7e1a0 0xcfb9 0x9157c

on cifs with the default cache option.

It shows folio 0x24 misbehaving if the FMODE_READ check is commented out in
netfs_perform_write():

		if (//(file->f_mode & FMODE_READ) ||
		    netfs_is_cache_enabled(ctx)) {

and no fscache.  This was initially found with the generic/522 xfstest.

Fixes: 8f52de0077ba ("netfs: Reduce number of conditional branches in netfs_perform_write()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c    | 47 ++++++++++++++++++++++++++----------
 include/trace/events/netfs.h |  3 +++
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 7ac128d0b4e5..25571a570ac9 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -246,18 +246,38 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		/* See if we can write a whole folio in one go. */
 		if (!maybe_trouble && offset == 0 && part >= flen) {
 			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
-			if (unlikely(copied == 0))
+			if (likely(copied == part)) {
+				if (finfo) {
+					trace = netfs_whole_folio_modify_filled;
+					goto folio_now_filled;
+				}
+				__netfs_set_group(folio, netfs_group);
+				folio_mark_uptodate(folio);
+				trace = netfs_whole_folio_modify;
+				goto copied;
+			}
+			if (copied == 0)
 				goto copy_failed;
-			if (unlikely(copied < part)) {
+			if (!finfo || copied <= finfo->dirty_offset) {
 				maybe_trouble = true;
 				iov_iter_revert(iter, copied);
 				copied = 0;
 				folio_unlock(folio);
 				goto retry;
 			}
-			__netfs_set_group(folio, netfs_group);
-			folio_mark_uptodate(folio);
-			trace = netfs_whole_folio_modify;
+
+			/* We overwrote some existing dirty data, so we have to
+			 * accept the partial write.
+			 */
+			finfo->dirty_len += finfo->dirty_offset;
+			if (finfo->dirty_len == flen) {
+				trace = netfs_whole_folio_modify_filled_efault;
+				goto folio_now_filled;
+			}
+			if (copied > finfo->dirty_len)
+				finfo->dirty_len = copied;
+			finfo->dirty_offset = 0;
+			trace = netfs_whole_folio_modify_efault;
 			goto copied;
 		}
 
@@ -327,16 +347,10 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 				goto copy_failed;
 			finfo->dirty_len += copied;
 			if (finfo->dirty_offset == 0 && finfo->dirty_len == flen) {
-				if (finfo->netfs_group)
-					folio_change_private(folio, finfo->netfs_group);
-				else
-					folio_detach_private(folio);
-				folio_mark_uptodate(folio);
-				kfree(finfo);
 				trace = netfs_streaming_cont_filled_page;
-			} else {
-				trace = netfs_streaming_write_cont;
+				goto folio_now_filled;
 			}
+			trace = netfs_streaming_write_cont;
 			goto copied;
 		}
 
@@ -350,6 +364,13 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			goto out;
 		continue;
 
+	folio_now_filled:
+		if (finfo->netfs_group)
+			folio_change_private(folio, finfo->netfs_group);
+		else
+			folio_detach_private(folio);
+		folio_mark_uptodate(folio);
+		kfree(finfo);
 	copied:
 		trace_netfs_folio(folio, trace);
 		flush_dcache_folio(folio);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 0b702f74aefe..aa9940ba307b 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -177,6 +177,9 @@
 	EM(netfs_folio_is_uptodate,		"mod-uptodate")	\
 	EM(netfs_just_prefetch,			"mod-prefetch")	\
 	EM(netfs_whole_folio_modify,		"mod-whole-f")	\
+	EM(netfs_whole_folio_modify_efault,	"mod-whole-f!")	\
+	EM(netfs_whole_folio_modify_filled,	"mod-whole-f+")	\
+	EM(netfs_whole_folio_modify_filled_efault, "mod-whole-f+!") \
 	EM(netfs_modify_and_clear,		"mod-n-clear")	\
 	EM(netfs_streaming_write,		"mod-streamw")	\
 	EM(netfs_streaming_write_cont,		"mod-streamw+")	\


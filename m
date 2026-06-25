Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B52E7394
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396429; cv=none; b=kOTj8Q4Rt9SXZ0RS9+Xi31zvLtK1lF4KrrpRktmZCtr0MXvixCYTAtXoWUkBrzQCGJiqIcpqgoQpqWkK5yCLz3l9sW4/PYVlMyo9WF4Lx/6XYn8QZ6uvTu2RgF+UFlQU+Qemr2lKGykalWCszDXuYSodifOU0xZnvDvnyoAeWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396429; c=relaxed/simple;
	bh=47UCcrLz70/51EpaUgv63b8mIdmTIeOVVG4e7i3u4ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OyvSRdAaJ0FJAMHmYsFEsRSXAp9zBef6nb+EF5utGYxys1ekLUho5bB3shy/E7lmS6D+rimr9NNKPd290sbLA0IUJ8bqf63lIhIaZKvwG1U1K+Hvf1jymPbkCnAwnLdSsuLnHZMUyfsEKEZtdTs9KjIroqSosjIIHY1gWIQ6ifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RK92pUmF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK92pUmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782396426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d22b7EDr5qdzBcgDcXvADiQplHCZXl5phLFw7eHSDz0=;
	b=RK92pUmFxCPakTkIBHYoJGjC6j4lodA+0vMxt2oBTXPF2VeYby0qVDdZKaiy+x49eHjSDr
	AsKKsqyN04JhckBQoGPE/6ZO40mYL9qHzfEQ0yvWoXZ0dg45LP5HJ96vo3U5qyOq+9uHFL
	FG/8vhQrA1z8JPR3RE+T6lB0Guhv2vo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (54.186.198.63 [54.186.198.63]) by relay.mimecast.com with ESMTP with
 STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-s_JJs8b8OXCD0kFQz4stoQ-1; Thu, 25 Jun 2026 10:07:03 -0400
X-MC-Unique: s_JJs8b8OXCD0kFQz4stoQ-1
X-Mimecast-MFC-AGG-ID: s_JJs8b8OXCD0kFQz4stoQ_1782396421
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F82719560A6;
	Thu, 25 Jun 2026 14:07:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5F9718005B6;
	Thu, 25 Jun 2026 14:06:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Christoph Hellwig <hch@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH v3 01/15] netfs: Fix decision whether to disallow write-streaming due to fscache use
Date: Thu, 25 Jun 2026 15:06:19 +0100
Message-ID: <20260625140640.3116900-2-dhowells@redhat.com>
In-Reply-To: <20260625140640.3116900-1-dhowells@redhat.com>
References: <20260625140640.3116900-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: qWWqHdrv2l4b8tb5NVXSya__bAaXdhR2wx81B1GLa2o_1782396421
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

netfs_perform_write() buffers data by writing it into the pagecache for
later writeback.  If the folio it wants to write to isn't present, it uses
"write streaming" in which is will store partial data in a non-uptodate,
but dirty folio.

However, when fscache is in use, this is a potential problem as writes to
the cache have to be aligned to the cache backend's DIO granularity, and so
netfs_perform_write() attempts to suppress write-streaming in such a case,
requiring the folio content to be fetched first unless the entire folio is
going to be overwritten.  This allows the content to be written to the
cache too.

Unfortunately, the test netfs_perform_write() uses isn't correct because it
doesn't take into account the fact that the object lookup is asynchronous
and farmed off to a work queue, so there's a short window in which the
cache is doing a lookup but the test fails because the answer is undefined.

This can be triggered by the generic/464 xfstest, and causes a warning to
be emitted in cachefiles (in code not yet upstream) because it sees a write
that doesn't have its bounds rounded out to DIO alignment.

Fix this by changing the condition to whether FSCACHE_COOKIE_IS_CACHING is
set on a cookie rather than whether the cookie is marked enabled.  Note
that this is really just a hint as to whether we allow write streaming or
not and no other aspects of the cookie or cache object are accessed.

Also apply the same fix to netfs_write_begin().

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c  |  2 +-
 fs/netfs/buffered_write.c |  2 +-
 fs/netfs/internal.h       | 12 ++++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 76d0f6a29aba..24a8a5418e31 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -659,7 +659,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
-	if (!netfs_is_cache_enabled(ctx) &&
+	if (!netfs_is_cache_maybe_enabled(ctx) &&
 	    netfs_skip_folio_read(folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
 		goto have_folio_no_wait;
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 6bde3320bcec..2cdb68e6b16f 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -277,7 +277,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * caching service temporarily because the backing store got
 		 * culled.
 		 */
-		if (netfs_is_cache_enabled(ctx)) {
+		if (netfs_is_cache_maybe_enabled(ctx)) {
 			if (finfo) {
 				netfs_stat(&netfs_n_wh_wstream_conflict);
 				goto flush_content;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 645996ecfc80..d889caa401dc 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -239,6 +239,18 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 #endif
 }
 
+static inline bool netfs_is_cache_maybe_enabled(struct netfs_inode *ctx)
+{
+#if IS_ENABLED(CONFIG_FSCACHE)
+	struct fscache_cookie *cookie = ctx->cache;
+
+	return fscache_cookie_valid(cookie) &&
+		test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags);
+#else
+	return false;
+#endif
+}
+
 /*
  * Get a ref on a netfs group attached to a dirty page (e.g. a ceph snap).
  */


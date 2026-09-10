Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595E3DDDBE
	for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077789; cv=none; b=Qj6T/PS3RkmORFq1m1t+x1zFG4060dMz2FG81mZD9Y+duKxPnZgQv7wYAjO03I+5+KlNC0TtpSdTXkV+5oGwYHndk/GRWnKkB098AoHgl75KK6adqUZju1oWE5oOcb5+5AgjrW/e5bzAJnxya1yA4L51H+ZUotpN1+s0dAf+ghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077789; c=relaxed/simple;
	bh=v4zYEE3i1XdbFl0MNJmPClT6vCgfK1H2tqCLNzF1UCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lV2yG2cEMk5ZP2yWhEpllHJBFW42p/Tok9pt7mXN2nme8Z7XvvxfC8O5dR4UzOOw9jY5ob8wA1jSATsMGG33EwygwaILfu189xapu4khO1ccs2HbSOOjldjxuM4V60fNC9lSq8iTFILf2rlQs36ke9O+Y4N7+Hy1tLwKA6oBY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIN90Msx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIN90Msx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789077786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXRaGZyJ7r1xkDgtIbgyH0MFExVrvPsQqbcSthdUw6Q=;
	b=gIN90MsxO74bsg0S+2Bl91edidJoLteFa2rlg7aIgkNNRTRQyYvSHs7ZZ0CBaI7c4MmUF4
	Gs0+pHBoGEngs1/tUmVHbPaMMDQucPt46KMZVwonkxDzpLUOU/Jqgl9yFkBmT9EDF/vy9t
	8JG67jGi2/eiaBEd6zFPfwWKio9zGLw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-OKRNYd70O6CYGJtNymNBVQ-1; Thu,
 10 Sep 2026 18:03:03 -0400
X-MC-Unique: OKRNYd70O6CYGJtNymNBVQ-1
X-Mimecast-MFC-AGG-ID: OKRNYd70O6CYGJtNymNBVQ_1789077781
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E989180067D;
	Thu, 10 Sep 2026 22:03:00 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BEB430001B9;
	Thu, 10 Sep 2026 22:02:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/5] cachefiles: Clean up cachefiles_do_prepare_read()
Date: Thu, 10 Sep 2026 23:02:36 +0100
Message-ID: <20260910220242.2165023-2-dhowells@redhat.com>
In-Reply-To: <20260910220242.2165023-1-dhowells@redhat.com>
References: <20260910220242.2165023-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: -qdS8hjOAdSw5sl7GPlGNNnhGB8nGlNCtg62yvW9BqI_1789077781
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Clean up cachefiles_do_prepare_read() by merging it into
cachefiles_prepare_read() now that the ondemand mode stuff has been removed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index e61e885784d6..2c1cd703f4bf 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -375,19 +375,23 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 				  term_func, term_func_priv);
 }
 
-static inline enum netfs_io_source
-cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
-			   uoff_t start, size_t *_len, loff_t i_size,
-			   unsigned long *_flags, ino_t netfs_ino)
+/*
+ * Prepare a read operation, shortening it to a cached/uncached boundary as
+ * appropriate.
+ */
+static enum netfs_io_source
+cachefiles_prepare_read(struct netfs_io_subrequest *subreq, uoff_t i_size)
 {
 	enum cachefiles_prepare_read_trace why;
+	struct netfs_cache_resources *cres = &subreq->rreq->cache_resources;
 	struct cachefiles_object *object = NULL;
 	struct cachefiles_cache *cache;
 	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
 	const struct cred *saved_cred;
 	struct file *file = cachefiles_cres_file(cres);
 	enum netfs_io_source ret = NETFS_DOWNLOAD_FROM_SERVER;
-	size_t len = *_len;
+	uoff_t start = subreq->start;
+	size_t len = subreq->len;
 	loff_t off, to;
 	ino_t ino = file ? file_inode(file)->i_ino : 0;
 
@@ -400,7 +404,7 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
 	}
 
 	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
-		__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
+		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 		why = cachefiles_trace_read_no_data;
 		goto out_no_object;
 	}
@@ -441,7 +445,7 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
 	if (off > start) {
 		off = round_up(off, cache->bsize);
 		len = off - start;
-		*_len = len;
+		subreq->len = len;
 		why = cachefiles_trace_read_found_part;
 		goto download_and_store;
 	}
@@ -462,7 +466,7 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
 		else
 			to = round_down(to, cache->bsize);
 		len = to - start;
-		*_len = len;
+		subreq->len = len;
 	}
 
 	why = cachefiles_trace_read_have_data;
@@ -470,26 +474,15 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
 	goto out;
 
 download_and_store:
-	__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
+	__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 out:
 	cachefiles_end_secure(cache, saved_cred);
 out_no_object:
-	trace_cachefiles_prep_read(object, start, len, *_flags, ret, why, ino, netfs_ino);
+	trace_cachefiles_prep_read(object, start, len, subreq->flags, ret, why,
+				   ino, subreq->rreq->inode->i_ino);
 	return ret;
 }
 
-/*
- * Prepare a read operation, shortening it to a cached/uncached
- * boundary as appropriate.
- */
-static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						    uoff_t i_size)
-{
-	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
-					  subreq->start, &subreq->len, i_size,
-					  &subreq->flags, subreq->rreq->inode->i_ino);
-}
-
 /*
  * Prepare for a write to occur.
  */


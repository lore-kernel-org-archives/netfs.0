Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA63A1E70
	for <netfs@lists.linux.dev>; Tue, 14 Apr 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154861; cv=none; b=Rf2yuedNGi/NuwKq4bgXlgwyoV3VCoFglvKBInhiXa3Po9/VS9HSjHA1ngtIMiIu9twRkdGvhpeHPBV4ZH2qFZ4DMReCXrmesWnkfplhyjb/UEqevieJWh28XCXYx9ir9Zppf1JCIFVOe1J4ZhOgji9J0UC7PdxkK9Z/Wd66wp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154861; c=relaxed/simple;
	bh=vypH1QnBGlF1Ma5c6YJ7lHILulSZ5o2UwdQKk9jbF9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YApgCXtg+CghhPwc9qIE4W+VrVy9EV68qdgGXqRDdXwcIfgZfnz0nUafL+5nzQki6vmJyguT23Z6U5EvKBd6pAdbePTjcKCGiQEpvetcNm0wH1ZkvYJ8JeqUSkDBC9AD8GMKh9a5abgs65mDMK3tViEXCEKPKhPQfTz2N9xgqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkPQFUV2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkPQFUV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776154854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUQTEXAJSgQ5XCpxL5uV1f0w9Ax407L4Y2Hm7hWxDsE=;
	b=CkPQFUV2IleAhml8vLSEW8y4aO7qdj6NjdMzRqYQ9Ucy75zV2q2gzrQGf+3gfhpARZheOJ
	slhCFhjMj7L2bRB3n5Bzbykf28d7hiof52JdPznjYA/V1z4/anm3Qe0ociiusvp2GjA8K+
	GPoRy2SHgXs2NCHLKQK1hzq57x+0Bmw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-t6tv_DRXP0WAGOe5fsDVUA-1; Tue,
 14 Apr 2026 04:20:50 -0400
X-MC-Unique: t6tv_DRXP0WAGOe5fsDVUA-1
X-Mimecast-MFC-AGG-ID: t6tv_DRXP0WAGOe5fsDVUA_1776154849
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3166819560A6;
	Tue, 14 Apr 2026 08:20:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.34.160])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E727F1955D88;
	Tue, 14 Apr 2026 08:20:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 7/7] netfs: Fix write streaming disablement if fd open O_RDWR
Date: Tue, 14 Apr 2026 09:20:03 +0100
Message-ID: <20260414082004.3756080-8-dhowells@redhat.com>
In-Reply-To: <20260414082004.3756080-1-dhowells@redhat.com>
References: <20260414082004.3756080-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: WxGeUZhjmwOtD7XpKBGJyCgwkjqZE0bJf0bqzYIFwEY_1776154849
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In netfs_perform_write(), "write streaming" (the caching of dirty data in
dirty but !uptodate folios) is performed to avoid the need to read data
that is just going to get immediately overwritten.  However, this is/will
be disabled in three circumstances: if the fd is open O_RDWR, if fscache is
in use (as we need to round out the blocks for DIO) or if content
encryption is enabled (again for rounding out purposes).

The idea behind disabling it if the fd is open O_RDWR is that we'd need to
flush the write-streaming page before we could read the data, particularly
through mmap.  But netfs now fills in the gaps if ->read_folio() is called
on the page, so that is unnecessary.  Further, this doesn't actually work
if a separate fd is open for reading.

Fix this by removing the check for O_RDWR, thereby allowing streaming
writes even when we might read.

This caused a number of problems with the generic/522 xfstest, but those
are now fixed.

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 830f1603478e..6399141b4f0a 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -283,8 +283,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * a file that's open for reading as ->read_folio() then has to
 		 * be able to flush it.
 		 */
-		if ((file->f_mode & FMODE_READ) ||
-		    netfs_is_cache_enabled(ctx)) {
+		if (netfs_is_cache_enabled(ctx)) {
 			if (finfo) {
 				netfs_stat(&netfs_n_wh_wstream_conflict);
 				goto flush_content;


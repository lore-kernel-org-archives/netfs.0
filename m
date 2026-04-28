Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FD477E31
	for <netfs@lists.linux.dev>; Tue, 28 Apr 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382376; cv=none; b=G65s3eg+yfUhbJkZzddXcGQ5OHJqHpyJqZW8z1IS0R2ImcoRYR9M73NukyZCOB4fys/Al0qxUnouhJuvu+9j4sYZVJMYG44Dxf+ItoQGNeiVslrGsMiYMAAV9IwKhkdzitVNzAMfpUBrK1OAn42rKZUtPPPGKzj+anaQPHWZhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382376; c=relaxed/simple;
	bh=S62t+upgojIYhz1p6dALu+kyrentByS35lQhzLSLXbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uyau/JS60AFUVewahFqZXEqrhVZFvaVDAISerKTvf77DpeVSEEYEiQLAckQO/e2zvLgSL4LI47KYy7cfLQVgJfLe9I9Dh4Le8T5Ik7qIWM5YngbXm/NiDXz38i+08nrozraL6c3qLhpOPveySfiO+kPhE38oADSBNOtWyDm63Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuWIsM17; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuWIsM17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0M8NeyGOtxqcK9n3lFvZBV03uT/fzw4I/4MxBJJ99Zo=;
	b=XuWIsM17tlSIg1RsOtYxHx2USNInYZrxIEDaYNDf7gLnd3HZWt2KM71NpPte2BCow4Shll
	IYFBp9QmcoBvvzbRo2lPpn/rJKCxQ+wRDc8cKu8IK+XULKuEaLBWM+EkW0o4AnsZNg+lhc
	h+8okY3yBhtFxZJXdt+ZEG38xo48NGI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-ZSty4BcUOtSXjU4EqNIxmg-1; Tue,
 28 Apr 2026 09:19:31 -0400
X-MC-Unique: ZSty4BcUOtSXjU4EqNIxmg-1
X-Mimecast-MFC-AGG-ID: ZSty4BcUOtSXjU4EqNIxmg_1777382369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A213118080B3;
	Tue, 28 Apr 2026 13:18:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7747E1800370;
	Tue, 28 Apr 2026 13:18:39 +0000 (UTC)
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
	Xiaoli Feng <xifeng@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 08/24] netfs: fix error handling in netfs_extract_user_iter()
Date: Tue, 28 Apr 2026 14:17:38 +0100
Message-ID: <20260428131756.922303-9-dhowells@redhat.com>
In-Reply-To: <20260428131756.922303-1-dhowells@redhat.com>
References: <20260428131756.922303-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: jZm8lMSgK8MxOl8tQAtG7LV363EfUEUOPtL1Pb2oGUg_1777382369
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Paulo Alcantara <pc@manguebit.org>

In netfs_extract_user_iter(), if iov_iter_extract_pages() failed to
extract user pages, bail out on -ENOMEM, otherwise return the error
code only if @npages == 0, allowing short DIO reads and writes to be
issued.

This fixes mmapstress02 from LTP tests against CIFS.

Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator")
Reported-by: Xiaoli Feng <xifeng@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Cc: stable@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 154a14bb2d7f..adca78747f23 100644
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
@@ -67,8 +67,8 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 		ret = iov_iter_extract_pages(orig, &pages, count,
 					     max_pages - npages, extraction_flags,
 					     &offset);
-		if (ret < 0) {
-			pr_err("Couldn't get user pages (rc=%zd)\n", ret);
+		if (unlikely(ret <= 0)) {
+			ret = ret ?: -EIO;
 			break;
 		}
 
@@ -97,6 +97,13 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
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


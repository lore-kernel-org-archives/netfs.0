Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E23932F2
	for <netfs@lists.linux.dev>; Mon, 20 Apr 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674294; cv=none; b=lr6KgEtg3os9wMMQUue9R3RqaWlsEQ8CD/z8mvstYONvVNCv+iOxj357PMwk44D2cFmMnCcRwrqn06ZHJVpVI+7/ZwfCQYkrKNpd/A58oXguU5Q3y0StcaB+fBxzJfJT5K8nbY8WtdfRVntteslEYseXfHZZ+Vrg4W4f8acre5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674294; c=relaxed/simple;
	bh=UEd2DPy5Oydn8gPnoSJEViWZQyJhuKPr8I6vUBK9yqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=EjVWhZAC911FRrPwleFIy4jyRedlSBn6i4K0DKg5AuS3FkjKYy+pOViAEfFSyNQumV1ugNjxN1kcWgRyimyZYTr8F7M478voZJKZMs0Xs20Mv8/UQPOf73ZENcUBFvLfiJH6HDTILt/UlWA7rhm8djYNXQxKZsTaey3SbCN6U+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DT2XMj7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DT2XMj7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776674292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/iqAtL+28tWt3sinE2J51vlI+HAUHWznAcDahw6A20=;
	b=DT2XMj7Z2yvWpP9EDXfh31yQYcVE1tgeZhaa7b0rm++OVu2UZuSBBxjSOsCXHqxmBbH9Ay
	96hYbytvjv9vZXiJyaV3EpdQCcRqeRSIONAlEaUURs7Cj17rSrJgVFq5B7m/KkSp/HfgfY
	bzWr0P8ENDSzVOntdHyYWIZhUy/8VQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-V5spEUY1NImn6v35llKtVg-1; Mon,
 20 Apr 2026 04:38:10 -0400
X-MC-Unique: V5spEUY1NImn6v35llKtVg-1
X-Mimecast-MFC-AGG-ID: V5spEUY1NImn6v35llKtVg_1776674288
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB68D19560B1;
	Mon, 20 Apr 2026 08:38:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCB953000C15;
	Mon, 20 Apr 2026 08:38:05 +0000 (UTC)
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
Subject: [PATCH 11/11] netfs: Fix netfs_read_folio() to wait on writeback
Date: Mon, 20 Apr 2026 09:37:02 +0100
Message-ID: <20260420083705.1009074-12-dhowells@redhat.com>
In-Reply-To: <20260420083705.1009074-1-dhowells@redhat.com>
References: <20260420083705.1009074-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Ql8LERU7hdjb_uBMSJQyTQ6eqBLeCS3BmwW1Iyh0eFM_1776674288
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix netfs_read_folio() to wait for an ongoing writeback to complete so that
it can trust the dirty flag and whatever is attached to folio->private
(folio->private may get cleaned up by the collector before it clears the
writeback flag).

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 4d6dfcffba78..dcfe51eec266 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -506,6 +506,8 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	int ret;
 
+	folio_wait_writeback(folio);
+
 	if (folio_test_dirty(folio))
 		return netfs_read_gaps(file, folio);
 


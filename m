Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D419197A7D;
	Tue, 19 May 2026 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149900; cv=none; b=CSb+34xc/5+k2Gtw4OLDxjr254D9HjLNDHOP9nfs/8eSywCUbSorNPCcJg0QNxgkgdrGam4V1WqmYpdmd6h67RjExsHgdkQpo8FOuAlSPRPVkJ6TjWBa5T+wnQSvWD9gQUEA4FzyflztFydt95tg1UewS23lI8dbfb9NLyqXPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149900; c=relaxed/simple;
	bh=1sSkAK1KDJp8Ixat5PEtXt9VZ/iSno5MYaODruOBNSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6I/T4WB0DjMS2muAxiqutue4of/lSu2jMl6xuPvbSBYBRhq67xnbVYpZ0teQHVGCNaE+IjukcS+Jcd5UWIPS8XP50BJd9+Lg2FklQBxw/Hwg+YyWej2Qjp8HkRmBcteg5yXBgBYnTgrKtr8YJMTrn7MsgKWPaAqbPd5lyqE20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0s3b9KXl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0s3b9KXl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jhYXxozh9GZ4QO0VN6JcGwpNrP1QNav/e2vn5m5wumo=; b=0s3b9KXllYY70vDpgxRoi2wG6e
	wbLIDTJdetNmxkrhg0te17/Yg+BU0374oPOgmH4Fhid8n8zL9NpcXmvR5q6r/nmd3VLRe+rwkl/mk
	6koSiLdIzmoxvVg9phk4Kb4gDN8ufOZp23n3jmah4Ino5HquSIqNJSnIbu+T5FlWYLxmZDx8oRECJ
	KRd6PKbynr22RlldC00Gc32Y7mS8fNMx9jnq9GjfupMtvuLi/1jIm3mvVcydZ/FwucFdx+5ko5O+4
	1BfhHJy01/j96zX5oR9M7OL95cLmBu211T/QbG+Q545SqYz29O9EetFExsJABp/z2uKYtsa5p97dz
	meVbNpfw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP8A3-0000000HFeB-0wDT;
	Tue, 19 May 2026 00:18:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	David Howells <dhowells@redhat.com>,
	netfs@lists.linux.dev
Subject: [PATCH] netfs: change kernel-doc function parameter to match code
Date: Mon, 18 May 2026 17:18:13 -0700
Message-ID: <20260519001813.129522-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parameter @ctx was changed to @ictx in function netfs_resize_file().
Update the kernel-doc to eliminate 2 warnings.

WARNING: include/linux/netfs.h:764 function parameter 'ictx' not described in 'netfs_resize_file'
WARNING: include/linux/netfs.h:764 Excess function parameter 'ctx' description in 'netfs_resize_file'

Fixes: 2c8f4742bb76 ("netfs: Fix potential for tearing in ->remote_i_size and ->zero_point")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev

 include/linux/netfs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260518.orig/include/linux/netfs.h
+++ linux-next-20260518/include/linux/netfs.h
@@ -753,7 +753,7 @@ static inline void netfs_inode_init(stru
 
 /**
  * netfs_resize_file - Note that a file got resized
- * @ctx: The netfs inode being resized
+ * @ictx: The netfs inode being resized
  * @new_i_size: The new file size
  * @changed_on_server: The change was applied to the server
  *

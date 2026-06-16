Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2B436353
	for <netfs@lists.linux.dev>; Tue, 16 Jun 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604575; cv=none; b=O+ixxAXtEj4VIEQqUvNsxslvJ1W3Lzm4U5Ld8urhCuHDx2h1jKLnPB8mK9JAJqC+DQSoW/J5uvn2ov0RkWZfPeUnmpKGj0tnYSuihlfWco0zZ6zB0XSIbqM8KBh27qflwYUQzgckhius84jq1796vzy6XhUiwZL/1nmEGWNGTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604575; c=relaxed/simple;
	bh=VUlgKQRtFcYZkgLggj06uMIrCxezEkk58BuS/5a9eCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mG0BWxTWgTkOy2Q3sk1wenaLWWb0Rpe9e9M+8CfjgmVCADLjZx8lfNLwfXKyFYBoSxnKjd3zwwrKijQqcblR4Meq279lHU3joiDGFHaaRMG3trbRRxJSf7/J92Djbpg0Wv8+eUsxC76H2oWc+aRO3DCrQdHAOhWt25tVsw13TBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzW0hsi6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzW0hsi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/liEajtHx9CYrzJvqnOmvWcXVvucaBQw0Nv7dYml2Q=;
	b=YzW0hsi6a/wub9v8Qt8Mpr1VQ5PCLrOE9bE53KNMK9heKcmC994cUmAmn9OhH7zT46POox
	GTdykgcHMJ9jUnW9fcPdXnlL59Ihc6hRWRXDWQe/JDASzndKRcqyJYBceVnH9+otzlcmcz
	JCWsryTX+LJupz7sz4XtfHkg5tN89X8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-ZdxWWUE-OU6UadleGbLJKw-1; Tue,
 16 Jun 2026 06:09:28 -0400
X-MC-Unique: ZdxWWUE-OU6UadleGbLJKw-1
X-Mimecast-MFC-AGG-ID: ZdxWWUE-OU6UadleGbLJKw_1781604566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E01D61800597;
	Tue, 16 Jun 2026 10:09:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A73019560B2;
	Tue, 16 Jun 2026 10:09:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v4 06/30] scatterlist: Fix offset in folio calc in extract_xarray_to_sg()
Date: Tue, 16 Jun 2026 11:07:55 +0100
Message-ID: <20260616100821.2062304-7-dhowells@redhat.com>
In-Reply-To: <20260616100821.2062304-1-dhowells@redhat.com>
References: <20260616100821.2062304-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: jByNQ8kLWW8a8W65qYqwVZLDXhy9Zo5Xh6eLmLUJPck_1781604566
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix the calculation of the offset in the folio being extracted in
extract_xarray_to_sg().

Note that in the near future, ITER_XARRAY should be removed.

Fixes: f5f82cd18732 ("Move netfs_extract_iter_to_sg() to lib/scatterlist.c")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Mike Marshall <hubcap@omnibond.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/scatterlist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index b7fe91ef35b8..6ea40d2e6247 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1366,6 +1366,7 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
 		sg_max--;
 
 		maxsize -= len;
+		start += len;
 		ret += len;
 		if (maxsize <= 0 || sg_max == 0)
 			break;


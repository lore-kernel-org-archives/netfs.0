Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF68418A34
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572966; cv=none; b=SdJTTToje5JY2GKQFL/P4w5eMWw+TTDkjtAtFEVPWVrfH+pClsuccjx3hcWXlctF4BPV+lWEx98fFcZ9AleRDZQZs/g8qqAW0LB3Q86NiU10ec0zuGlHlYKB+pqgBNDY9JvKxCvKmssA+5WPzZzeg3gPUVj1DxZZOYbn0zKKjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572966; c=relaxed/simple;
	bh=gZJj56dXZ3m5mpuWg5Y32mLuivOuA0n2jQSSKK4Lf/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pIrssmcfm7W+JoefwwQrQsRawuNfORFZrwlhQkKMgeplVziJEyuxE767nklCyeRdNn2jkqBfcTeChxdHHpPDztwnt39r8vy0BPV/rPDsb+pgl9gbKBKXUSCpgDCp0Fiy8nH+H99L0GBX35HgcH1937BHXf/XjDyCLhtDmhPGAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqqrQUdf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqqrQUdf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787572964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4i/vAlF7TVRLwxgQcCoqCNsYOQic8KZ0Txwd6Khtt8=;
	b=JqqrQUdfzMfoQqrI+Q3savdqMg5qDaeIfkWxS3IL63qofWtgZm69BDrQAUidJYitVL2jK5
	O1W0JOwTqq/XrW9NE1LSK7fAewBR7y1PqaykFIGV5JdV1dbSVvcdHM7YTazuFqJy2b7Z5K
	lQEZOHLeRyI25YTL6Bwpsay3G8hQwMI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-QKIZ5IQHPW2M0-MoD0otjw-1; Mon,
 24 Aug 2026 08:02:37 -0400
X-MC-Unique: QKIZ5IQHPW2M0-MoD0otjw-1
X-Mimecast-MFC-AGG-ID: QKIZ5IQHPW2M0-MoD0otjw_1787572956
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2192A19540C5;
	Mon, 24 Aug 2026 12:02:36 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.15])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F8A11800257;
	Mon, 24 Aug 2026 12:02:32 +0000 (UTC)
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
	Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] netfs: Fix uninitialized return value in netfs_unbuffered_write()
Date: Mon, 24 Aug 2026 13:02:20 +0100
Message-ID: <20260824120224.504575-2-dhowells@redhat.com>
In-Reply-To: <20260824120224.504575-1-dhowells@redhat.com>
References: <20260824120224.504575-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: l9aGW0nQSIQc9kNtMHvGdQZCqi1Xbtfx3Dy0FQrhvT0_1787572956
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Karl Mehltretter <kmehltretter@gmail.com>

If preparation of the first subrequest fails,
netfs_unbuffered_write() exits its loop before ret is initialized. The
empty-iterator check can do the same.

For synchronous writes, netfs_unbuffered_write_iter_locked() may then
return an unrelated error instead of wreq->error. This is reachable
through CIFS if cifs_prepare_write() fails to reopen the file or obtain
credits.

Initialize ret to 0 so the caller returns wreq->error if no data was
written, or the number of bytes already written otherwise.

Found with Clang's -Wconditional-uninitialized.

Fixes: a0b4c7a49137e ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/direct_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a1..b04019097ab8 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -95,7 +95,7 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *subreq = NULL;
 	struct netfs_io_stream *stream = &wreq->io_streams[0];
-	int ret;
+	int ret = 0;
 
 	_enter("%llx", wreq->len);
 


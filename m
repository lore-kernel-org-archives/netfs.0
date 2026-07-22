Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8C2F7F19
	for <netfs@lists.linux.dev>; Wed, 22 Jul 2026 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725392; cv=none; b=rPDHWbmukLZWOrnUJRzH7NiFFDnthf4QiHMH+w/CHNjwPR/W5rk78SpOgOv94+weaYn7D52urBHchSkiMldq4sgMBo0ZW4pAZi57nEsGw7bt9mKdgIbLFfrebMluQUKzFbKG5FeZkB7XmT4+kplWOgmo9RXt3s4cULaDIjpI9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725392; c=relaxed/simple;
	bh=w23b0JbOxNEGjzuU1PXY3kc0xOYVWl30OQdDnETC6eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rK57j/Lmhtp5vMQLS8kZlTPE6c1RaQMK6RnOZHspGXN9gNQSzvDf3NISuwS+27+unr0UFDKcL7bVbIQ4IbQdTJ9gFFqRP9ZCHJ32rhISZtVJlfmLtLSq5RRCUn1caN1HPYRW0mX3AydUhJEaxsBi91avk/aO4bzKpcdfg0Ew92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOLCmpvg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOLCmpvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784725386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8oEAiWjd86z1Gi65KRoWCtZfHjQ+oKK2jcEq+W4JMo=;
	b=QOLCmpvgzA7s4CyHjRH1ngBqK3fy3NjidBVaxySaI5uJLlY5mxntY/uFHLKfvamwm+cgak
	lrLxFbhpylpbtm1Q8aEdPjlCmkDSrgIf02BrKa5g8LBiAaTOD/IrmIsLStCf2uyfg0dBsy
	Pz7vYmQzfpd+mZkf1DkPtiTiUbLOzjw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-nSB2rKYjPaaYEeeNPRZZVw-1; Wed,
 22 Jul 2026 09:03:02 -0400
X-MC-Unique: nSB2rKYjPaaYEeeNPRZZVw-1
X-Mimecast-MFC-AGG-ID: nSB2rKYjPaaYEeeNPRZZVw_1784725379
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E22091800772;
	Wed, 22 Jul 2026 13:02:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 999CA180034C;
	Wed, 22 Jul 2026 13:02:52 +0000 (UTC)
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
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH v7 03/29] netfs: release readahead folios on iterator preparation failure
Date: Wed, 22 Jul 2026 14:01:50 +0100
Message-ID: <20260722130218.78958-4-dhowells@redhat.com>
In-Reply-To: <20260722130218.78958-1-dhowells@redhat.com>
References: <20260722130218.78958-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: OGqKgfCYIDpUJ7nk25lST9Fpm2l_2m8bjPYjEPasVuo_1784725379
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Yichong Chen <chenyichong@uniontech.com>

netfs_prepare_read_iterator() batches readahead folios in put_batch so that
the folio references can be dropped after the I/O iterator has been
prepared.

If rolling_buffer_load_from_ra() fails after earlier folios have been
batched, the function returns immediately and leaves those references held.
Release the batch before returning the error.

Fixes: 06fa229ceb36 ("netfs: Abstract out a rolling folio buffer implementation")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 24a8a5418e31..3d86414ee40f 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -102,8 +102,10 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
 
 			added = rolling_buffer_load_from_ra(&rreq->buffer, ractl,
 							    &put_batch);
-			if (added < 0)
+			if (added < 0) {
+				folio_batch_release(&put_batch);
 				return added;
+			}
 			rreq->submitted += added;
 		}
 		folio_batch_release(&put_batch);


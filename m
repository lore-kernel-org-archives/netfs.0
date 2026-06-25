Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24136C588
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396483; cv=none; b=AzMooT6GWVrXL4pnUc1N1B1xYEX8q6AXWGWPBBNRDJSulpcti96ZcZ+bqQjNme4vnxPE8QgRVda4SkWpAEKtYnFodKHT2WH92YQUvDfF3eT2XHoZqkDs3hU/4/sTVv4oblpNPegxOCyC8evOutYaAOe5BVZTUSz6lUdLbF16BkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396483; c=relaxed/simple;
	bh=coe08ifGgRrAVXSXWT3Fx82kQrU4dJ2DxXdUoNXBHoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Zfuv0BWwtf60TrhU+F+0KtiusOl96wSCdpLADOLrm26i71Kg6p5+C5C2CKtUeae7xtfYUjajKwHXvk+H6diWpxHufpM0nJlHYVQQKejt+hrRlhzonEk8zJT9rdWqqCzIHtWACBkNB0FYb/OuTR7zCpKCx32pVUTzYdtxtrL85xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eN6X1Bz2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eN6X1Bz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782396481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv01epNYmpMNdBx6opev1XzVj+i1CyGIO7L+nB4+Kjg=;
	b=eN6X1Bz251l4xaxBLWCAaGGgKyZBOpYATUqU7bjhmnO1GWgtvZx3fpC97ZQLs9KR6Cs//T
	G9CCo096CsMhKtrs6DLY8V2KOTtKNyi342E6g2XYZ2WF8t8Et3itAgbUluyoZX7l2VG/LD
	sMVl/KGHa/SvdyI4jEOb9YoipIQEjCw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-ys-sMADcNi6ZtjXTdd9iWQ-1; Thu,
 25 Jun 2026 10:07:59 -0400
X-MC-Unique: ys-sMADcNi6ZtjXTdd9iWQ-1
X-Mimecast-MFC-AGG-ID: ys-sMADcNi6ZtjXTdd9iWQ_1782396478
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0289E197730D;
	Thu, 25 Jun 2026 14:07:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20E1719560AB;
	Thu, 25 Jun 2026 14:07:54 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/15] netfs: Fix writethrough to use collection offload
Date: Thu, 25 Jun 2026 15:06:30 +0100
Message-ID: <20260625140640.3116900-13-dhowells@redhat.com>
In-Reply-To: <20260625140640.3116900-1-dhowells@redhat.com>
References: <20260625140640.3116900-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: DiRA7Y_uSZEUvYOOffDWuBrwHjepyvlfMII33rNpZN8_1782396478
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix writethrough write to set NETFS_RREQ_OFFLOAD_COLLECTION on the request
so that collection is processed asynchronously rather than only right at
the end - and also so that asynchronous O_SYNC writes get collected at all.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Closes: https://sashiko.dev/#/patchset/20260616100821.2062304-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2473bce37649..3b363ce12f3f 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -620,6 +620,7 @@ struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len
 	}
 
 	wreq->io_streams[0].avail = true;
+	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writethrough);
 	return wreq;
 }


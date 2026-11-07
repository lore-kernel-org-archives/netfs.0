Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067728;
	b=cVMJPwsIMXLMzjRcJuRPtNWvapRgn+At21Zu58aFxE8/FHZb4o2kXxVLDUQuGdO4syXh
	 uuHwcRNDvaEI1QCdRD4FrVR7wTJH8tQzaQEsI9HAKOceIYaJ9cWwiZ0GsKUbR7t4EqclJ
	 K2LTLROR46t8MHb6QgcHSRwo31zd58/BLTfPJqKE0zzWY5S81RuvBr+dmtL0TiYl7zMeG
	 GnO2eOctBX8qWqJdGnKbRttxiG5uuYjnt9uN/LBEz+S8rzp6wFj7YKj2iM4XNSoASbW+O
	 R6Ez1zQRjlfnHPzKgPRb+C5H0pguSVF3+OwfuedGe5pek1rUYl67mfD639gEY2XHt2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067728;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=PhNajVV4YOAVa6HzjBax5Vzcm0CeXg6v0Uflf51EUrc=;
	b=F1hVSSjYinndpDkAQI3LtwwmvH4dLmt1SQL+VVc2SePQBnbOxcQvgQvi21T8628cr8WG
	 AZ0A0FRijgk9r8zjeaWP796OQjcI9lErUTM8PSAgMDP3FFpbdIogTLPIa0ZQE2an8PHUK
	 ss6Vrze6e7RjL5rvTaSn55HDN+/w1XBttkBB9jqGVulKcBvziBQPnipgdPb5bx3iQ3WWW
	 PP73vZX7ciKxsqSOwD7Ynv+XtQ7rMWO2KmZRrBO/DEekRQQS0j+Nq/TsvqObvA/B+posz
	 N7zLqI4cGxgcXCBGyngwCwCeIY/sw3tpB6QFgqmUpi6LQtwamBsrGHlKytPrkZ+HQ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GljH8KxR;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0808606EEA8
	for <netfs@lists.linux.dev>; Sat,  7 Nov 2026 16:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0808606EEA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GljH8KxR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794067726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhNajVV4YOAVa6HzjBax5Vzcm0CeXg6v0Uflf51EUrc=;
	b=GljH8KxROePhNvScVD+kZj1O0uYZNHoIp5ZALAkdjBcdEnqQB3sJlbg5fmLIwybJdZ4aYh
	0F+416MllbMtHFZYh9XMsVdxQw0pdCtBo6u3uWe3qAWqDv4dTEE0VY/Vv/nhC+R8q/aE1s
	JfMxZNJDtLF48CGN8pKrG/wMCNz95EI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-HTZ9CGakPamdL-_O4Scg4w-1; Sat,
 07 Nov 2026 11:08:41 -0500
X-MC-Unique: HTZ9CGakPamdL-_O4Scg4w-1
X-Mimecast-MFC-AGG-ID: HTZ9CGakPamdL-_O4Scg4w_1794067718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA9AC1956067;
	Sat,  7 Nov 2026 16:08:37 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24D803001DA7;
	Sat,  7 Nov 2026 16:08:32 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH v16 01/15] Add a function to kmap one page of a multipage bio_vec
Date: Sat,  7 Nov 2026 16:08:04 +0000
Message-ID: <20261107160823.1465553-2-dhowells@redhat.com>
In-Reply-To: <20261107160823.1465553-1-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: iPymF176HvfPWMkbD7CsjOtHLoaOrpAhHcFQWC-UTFQ_1794067718
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a function to kmap one page of a multipage bio_vec by offset (which is
added to the offset in the bio_vec internally).  The caller is responsible
for calculating how much of the page is then available.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/bvec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index b63914ff56e3..7ea62643cfb7 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -344,4 +344,22 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
 	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * bvec_kmap_partial - Map part of a bvec into the kernel virtual address space
+ * @bvec: bvec to map
+ * @offset: Offset into bvec
+ *
+ * Map the page containing the byte at @offset into the kernel virtual address
+ * space.  The caller is responsible for making sure this doesn't overrun.
+ *
+ * Call kunmap_local on the returned address to unmap.
+ */
+static inline void *bvec_kmap_partial(const struct bio_vec *bvec, size_t offset)
+{
+	offset += bvec->bv_offset;
+
+	return kmap_local_page(bvec->bv_page + (offset >> PAGE_SHIFT)) +
+		(offset & ~PAGE_MASK);
+}
+
 #endif /* __LINUX_BVEC_H */


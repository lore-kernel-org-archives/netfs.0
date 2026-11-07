Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067752;
	b=sKh5u7JDCoT2Dr+iLX3oC/txaLOV8IpBKAlIJlH8JgxakaSDS5jNhYjUQJfVA2iX1w4U
	 VRpAzYmoobpQz0uAQpAx8reNEkspU6xaWkcMTmX4Uiu+M3WRxMkIRqlzLuBU83z/FQQRD
	 mCC1H9W4IgEOt6ARPfHvJzqYzfBYk49GJZu+XvgdSD7k5slS4a3XLeYyS4m0rTp0k+9l0
	 9q+kw6TLbWHU2cYcpOFtrbACpkMcDBl5EDo1yNcZoi7C2cykMW3aErpkZBaR+a1PZQW8B
	 MD8TgWKlCgz3QWSfs/wT8ghagpTC5m8yidqZKBbcC2BddwnCvxnU2ou7aEPX8+tG2dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067752;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=CZaqB8zLqbirkp9myGrNJcVtQI5qFYQmk8ue8ilaeuU=;
	b=foIgObhy02fOv7WeTMhsYH8MKeGuprNjgknAPQHj1RJpCO8gO0jwP7XkdN+2xq56dtTR
	 HyaIqKiH7cYEynScdjTS47ZxsRo3d3wbaWwi/D796klQgitbhi/kBCTBEQlLkeolc63DS
	 3stC+RlnKb67S+hBbM/28Q1/3Ilc/SC3MwyRPWCynA20jAbMNnpwJ6lNt37MMRvoXMuFT
	 rH5Q/Clcrr+KkNIiqh3c83SX+9MTTH0JuPF3fodxoBwtJjVe9Apn4nLCF+o0UnntDpHEs
	 P6w4SrJBm4MPB9ZwxzCenJErYM0odipZZ6zNENYjcVBP78BQWvCpZp/+n98CFXq+AwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwOHumoe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A460A2639
	for <netfs@lists.linux.dev>; Sat,  7 Nov 2026 16:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 242A460A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwOHumoe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794067751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZaqB8zLqbirkp9myGrNJcVtQI5qFYQmk8ue8ilaeuU=;
	b=FwOHumoe8BKQv9MIAGg3FeuS+1hKfsmJrpIQKx4BsI76iy4gBKBfk9srLZch/+LBGOeSSl
	W6VT4mOJFZ5bnJk20+k3UM4QHw+AH40ZmhQ4OagqHdzRdesa2MhgPqTZxDo4FOVqnTddIs
	oHffrF/nWQMwU5PiB18ojgaF460eHnM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-DYzUFMebMUqyiW7ZsANATg-1; Sat,
 07 Nov 2026 11:09:09 -0500
X-MC-Unique: DYzUFMebMUqyiW7ZsANATg-1
X-Mimecast-MFC-AGG-ID: DYzUFMebMUqyiW7ZsANATg_1794067747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6991195608E;
	Sat,  7 Nov 2026 16:09:06 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 200A7195608C;
	Sat,  7 Nov 2026 16:09:02 +0000 (UTC)
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
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v16 06/15] afs: Fix an inconsistency in the symlink code
Date: Sat,  7 Nov 2026 16:08:09 +0000
Message-ID: <20261107160823.1465553-7-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 0V3l9K2RVaZUHys7dl17fm3Ts4FvHQ9l31DcVze-XUE_1794067747
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix the afs symlink code to set ->directory_size to the size of the buffer,
not PAGE_SIZE-1 or i_size.  This doesn't actually change the operation
since the value is ignored by the symlink writeback path (which writes to
the cache).

This was spotted by Claude.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/symlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/symlink.c b/fs/afs/symlink.c
index 6b8c122877ca..a1dbd552ddff 100644
--- a/fs/afs/symlink.c
+++ b/fs/afs/symlink.c
@@ -99,7 +99,7 @@ static ssize_t afs_do_read_symlink(struct afs_vnode *vnode)
 		ret = netfs_alloc_folioq_buffer(NULL,
 						&vnode->directory, &cur_size, PAGE_SIZE,
 						mapping_gfp_mask(vnode->netfs.inode.i_mapping));
-		vnode->directory_size = PAGE_SIZE - 1;
+		vnode->directory_size = PAGE_SIZE;
 		if (ret < 0)
 			return ret;
 	}
@@ -116,7 +116,6 @@ static ssize_t afs_do_read_symlink(struct afs_vnode *vnode)
 			trace_afs_file_error(vnode, -EFBIG, afs_file_error_dir_big);
 			return -EFBIG;
 		}
-		vnode->directory_size = i_size;
 
 		/* Copy the symlink. */
 		symlink = kmalloc_flex(struct afs_symlink, content, i_size + 1);


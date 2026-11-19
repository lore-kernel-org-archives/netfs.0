Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077590;
	b=AEl/ap4FQcIkMlBggjyFttdvQtr5VpmGyFd6dhXUPpIlCcR/E4od/BxqZkEyL3r9z4Ob
	 gUDACdSi6eDEI2wo7XHHwE3bAs7oHPhdXmgDGXV2v0RaZaI/Q+DQr5ezxYhzGBHJVua9s
	 zDSQjbPp6lL/KgpdsNHfZ9tHhTEHm9AGowDnGYbzh9juObTf992ODp9qP4Trlz+fK11XY
	 a+i3uConpXj1D9JbznBUmoFimFMn6948w+iypPn68DByjMHrk1DriVBmteODdUpT5AEfj
	 by3IIlwlWf2qDCPBZaifVNEhekHOBDvVvXCLCFDlarkXkmrGXgPUhxqTeipx0RAOIOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077590;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=CZaqB8zLqbirkp9myGrNJcVtQI5qFYQmk8ue8ilaeuU=;
	b=yqUxQnSyFRDpMhIgUWGNTDClhCqXgb9e0gG133SY+EsMajkCI2klzOMvmiVko87BNxth
	 SprtXlH4tUa/ebBFx38iOJsGhAlR5jETphfObHz5B5kGjCcDghNm3bibDdqlA7XWlh7eH
	 SC80mYhSoREX8UvZ8hGoahlO5awCVBKxFGlQLwO3vlr9ErqTCtCe6/9TNgd+0SpmaWgA3
	 s8FhNaa3C3k+0JE1n992LnfPg5zYGNcW/nM/zb2V60SjZn/vXcx8Na0c7dj6dzvWxnzMm
	 EWYpq3Wf6iO88XnhYHisVmRRfgY0338qovYxJ4WMrwhR1wdlVPKblArE4WLg/aXzVVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SGkc97hP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8960A2602
	for <netfs@lists.linux.dev>; Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F8960A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SGkc97hP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795077589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZaqB8zLqbirkp9myGrNJcVtQI5qFYQmk8ue8ilaeuU=;
	b=SGkc97hPrcUCQ1qV7M7E4n55lQ4ter7OQA7zjCLS/h1dUnSqrj515bpVoNbLgoSZtEvu0Q
	NqZup7PQoj+lSi55We3XVOjVitMZmATfQ+XQkzCkxJx4qMtHXZ0M9BEYcopNMMYReU1Qx+
	O++GgTM3yHoFgvNAzeUBDRlloBQvWCA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-SbLcHYapPkatWXbL3lcyMw-1; Thu,
 19 Nov 2026 03:39:43 -0500
X-MC-Unique: SbLcHYapPkatWXbL3lcyMw-1
X-Mimecast-MFC-AGG-ID: SbLcHYapPkatWXbL3lcyMw_1795077581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BF1D180035E;
	Thu, 19 Nov 2026 08:39:41 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFCC930000E8;
	Thu, 19 Nov 2026 08:39:36 +0000 (UTC)
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
Subject: [PATCH v19 07/17] afs: Fix an inconsistency in the symlink code
Date: Thu, 19 Nov 2026 08:38:38 +0000
Message-ID: <20261119083851.3306418-8-dhowells@redhat.com>
In-Reply-To: <20261119083851.3306418-1-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
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
X-Mimecast-MFC-PROC-ID: e7txNkln_PabQltb0ehcdUT_3FTUifzedWqyVWhP_Dc_1795077581
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


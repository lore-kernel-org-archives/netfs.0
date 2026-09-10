Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E933D9672
	for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077799; cv=none; b=UmzOSIdSRT5gPxKZZj5BHh6Q2vBG36UmvAK/dIz6gC7DmVfby2xeRXQ1r0igaxx8ccX357yzrbB6WhVvXER6+MNQKptHo3Mse/P5lHwlxzF15y3s//G3qRlE9pneXj3/+/OZuXJdMCVNMnx2JljoOrLzSutJ8SpntfT36Jccelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077799; c=relaxed/simple;
	bh=hIU/JK4M9LGAjejic2xZGwm/yUtT+JoxFLTRXwrqifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OgJpF70jpgPuCL7NnzRN8zglcLZoIGbjctoxU/4uEnfvKV4NjF04C4n6lZucvB3utbAY+au6mXN2SaP6tNEdMu6anGYxJsUst8yirT+dfeYujSULPPneORjhNEJm4SgN9ROigPjuhFU6YxSKEqscrTa/3lUjnj4LFJHa1ELofG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kxw5wydz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kxw5wydz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789077797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G0bz5tmQKqAj5Nt18/GKSBL+JEXgjJVaCuLVRMABts=;
	b=Kxw5wydzs8SdGrBaADQ4eikwBaaKHKbMBm6j/B0EMqi3Pcl1vZxdxt41Qv6syljh0EOHew
	Wpvk6kk8Dl5fADB5G0YKU4H+fvKlalAXIojWmOORQ3Cbe9m3VAUpbMhTD4GZCpZqOg06H2
	Q2Q5RANZz7VpHG0aeW2xj8y2mGmRNUs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-eH2sjV0pPDaWgUO-mr0BrQ-1; Thu,
 10 Sep 2026 18:03:11 -0400
X-MC-Unique: eH2sjV0pPDaWgUO-mr0BrQ-1
X-Mimecast-MFC-AGG-ID: eH2sjV0pPDaWgUO-mr0BrQ_1789077789
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58475195398E;
	Thu, 10 Sep 2026 22:03:08 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47FB61800345;
	Thu, 10 Sep 2026 22:03:02 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/5] netfs, cachefiles: Add a couple of traces for write failure
Date: Thu, 10 Sep 2026 23:02:37 +0100
Message-ID: <20260910220242.2165023-3-dhowells@redhat.com>
In-Reply-To: <20260910220242.2165023-1-dhowells@redhat.com>
References: <20260910220242.2165023-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: zUKZM3_F7BUqQ5dikAOOhujfBGhlY6WvAagIpcR746k_1789077789
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a couple of subrequest traces for write failure in the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c           | 8 ++++++--
 include/trace/events/netfs.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 2c1cd703f4bf..dac48fdf85d1 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -605,10 +605,14 @@ static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
 	stream->sreq_max_segs = BIO_MAX_VECS;
 
 	if (!cachefiles_cres_file(cres)) {
-		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE)) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cache_waitfail);
 			return netfs_prepare_write_failed(subreq);
-		if (!cachefiles_cres_file(cres))
+		}
+		if (!cachefiles_cres_file(cres)) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cache_nofile);
 			return netfs_prepare_write_failed(subreq);
+		}
 	}
 }
 
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 303309be253f..35826aea1c2d 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -93,8 +93,10 @@
 	EM(netfs_sreq_trace_abandoned,		"ABNDN")	\
 	EM(netfs_sreq_trace_add_donations,	"+DON ")	\
 	EM(netfs_sreq_trace_added,		"ADD  ")	\
+	EM(netfs_sreq_trace_cache_nofile,	"CA-!F")	\
 	EM(netfs_sreq_trace_cache_nowrite,	"CA-NW")	\
 	EM(netfs_sreq_trace_cache_prepare,	"CA-PR")	\
+	EM(netfs_sreq_trace_cache_waitfail,	"CA-!W")	\
 	EM(netfs_sreq_trace_cache_write,	"CA-WR")	\
 	EM(netfs_sreq_trace_cancel,		"CANCL")	\
 	EM(netfs_sreq_trace_clear,		"CLEAR")	\


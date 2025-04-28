Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276A1FDE3D
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855351; cv=none; b=OefsjgpM7C6FgNttMj1upfmjlLn9MiHbQQNuUk7nawQRUU39QxOAA1hmV5F8tGUngUHDQEE7XyFfZ9eYXJwd9fh8HR4gNhQM6PyfIebuYh+3uy/h//L9bTFUH3rZTup/G+Pl7W3ZQILM00nWl7upUgSv2X2comM9UxoCKr1Zw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855351; c=relaxed/simple;
	bh=xGAXijsIWhD5SusN4M0DSp5+o3589RWWI44L35vgX7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKYkYZ52iVLZl57uQpHx0dST3Ch0t+D7Ov9vM/mv9thGbfXaBQ72qOYiFAey3Yq+yFx++6FmcAc7lTyZNuUAHfaShWVtIV8qqOW/UfiR1Q5ZsmPzzhvLdrU9Y8FM7GRhwvgW6s+iC+Rzzb+5dUf5kLWjQFilOzEy0vhRGtPDtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KiZC6DyD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KiZC6DyD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso22747405e9.3
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745855347; x=1746460147; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMnv5syE0qO7OJSA1fIn8ke/RdLf6TMEyfCvrQJcHBY=;
        b=KiZC6DyDJzZD96q7zXs7tPAhM+50Ns+eFE1j710R/y8TOwdTaW5Oo6ZQB7HFe/gacD
         l2fqZYsrTqq3Jw8e/30oQFTpdbeeZU37KYAhK+M/Xzy4OR1Bt70NtxzhYMSi7dGZFXer
         zXBR1mTpM+VS7zfutUnmoQEjBJ9FrfHYi1Vmq1nN6Olr1xzUrP2syTwdv8LpARkmeUTK
         XCk5UUKKTont7BHshd992TTS9q1FuDtGX3Srpf1wEacHwk75VMuLoTsWdzLxOFRPsdxu
         FuFB0UIqjQZ5zf/adHE3wrb6hbB2PQkV1fuJR6RSXljZNgrg2v2O+WEjvKQQakz+duob
         BuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855347; x=1746460147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMnv5syE0qO7OJSA1fIn8ke/RdLf6TMEyfCvrQJcHBY=;
        b=bIsd5sTtPmiKfBWdC+WeI6dhFP8Tr0kF3R7YEnpvFnGUNPyLF7j6u9xYxtYHsip/34
         s0aTSkFklRI/P6F2ubLX+24mWDPiogt1hyYcGGI38QK6Vr1ITfeB9KncztBgHl7sFcQt
         5PBiVOXATtMPo5DnCNkwroKxBxcOMdArrJGr97teCLBYvysbCK8dM3t75fBn25DACSAL
         TY0Cg3e+lSVHFjCO0uq3JKcPqL6w5oWBGW5HOxcS5CUlVkAp5tbt7UQJ/zBBhwsbsCeq
         GzfWjTBUNh8JiKBStaGyN6pl2s8TF/jjYMO1mGFxHYsfEOD9IcNQkTbr3PWfFKHJPjOE
         nHXA==
X-Forwarded-Encrypted: i=1; AJvYcCUzLt/uL2RKfpabMc6s/RzHWw4w0RIWJeqfALYjRxDN7Jtk+yZyyWibkIH6XlQokbzPXqivNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXVC+vVID7qghz+w4Cd5rreVm21b1DoD1YxKLtFsRbSHsprsbV
	LZ+o4xgbF2js5Yicup2EjAGzW6zvhhaxGdiSaNQ4YBjTYHkmzJQGstbB5Dw8Wg2RXI1dHbO/Q7A
	z
X-Gm-Gg: ASbGncu0wA6nVWDIWCigap95NK7HfHWR4ezX/DY1WjlRuxn+ms4N4oK3tO57mi1sikm
	mTG8hmO8djlSBt0GcKQ/7tBCGM/Vu6R4bvikd55mqtbaOSosVRzR0AemNbjvGwksCwmMFs9WL0n
	Llz6IJTFyAVs3yJONyoBTQDON4PKY+kg0RwuU5N9tnbECaoH8zCSkV2qH/XVjhf+xlcUa4sxhTg
	bod5EUgUO6qg+1eAyLGyatswHIDLzNuahFKDxh6TL/Jhnvm0yeT76+6pGIWXymrxt6vBCnhdPS8
	hlTRWopN1LtXuX9TvjBHGh9adUatH0zxXgEZ67ABDHHkjbBKuEJj6jFBi7zr2wJ1VULXlXP8hPw
	Nem/CvdimC5qhyNJQuPuz1UkIbMZ0H1qsXwHKlWgl
X-Google-Smtp-Source: AGHT+IGXL9dyVPRVodF/Fetap7dAZVCVkq++jd5Kw/OkUaZM3TE7pz9rtcjMS3VPpB/B1NERcJRs3w==
X-Received: by 2002:a05:600c:a41a:b0:43d:4e9:27f3 with SMTP id 5b1f17b1804b1-440b0b32f17mr36472885e9.9.1745855347254;
        Mon, 28 Apr 2025 08:49:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29ba29sm162134575e9.7.2025.04.28.08.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:49:06 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 3/4] fs/netfs: remove `netfs_io_request.ractl`
Date: Mon, 28 Apr 2025 17:48:58 +0200
Message-ID: <20250428154859.3228933-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428154859.3228933-1-max.kellermann@ionos.com>
References: <20250428154859.3228933-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this field is only used by netfs_prepare_read_iterator() when
called by netfs_readahead(), we can simply pass it as parameter.  This
shrinks the struct from 576 to 568 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/buffered_read.c | 24 ++++++++++++------------
 include/linux/netfs.h    |  1 -
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 0d1b6d35ff3b..5f53634a3862 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -78,7 +78,8 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
  * [!] NOTE: This must be run in the same thread as ->issue_read() was called
  * in as we access the readahead_control struct.
  */
-static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
+					   struct readahead_control *ractl)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	size_t rsize = subreq->len;
@@ -86,7 +87,7 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 	if (subreq->source == NETFS_DOWNLOAD_FROM_SERVER)
 		rsize = umin(rsize, rreq->io_streams[0].sreq_max_len);
 
-	if (rreq->ractl) {
+	if (ractl) {
 		/* If we don't have sufficient folios in the rolling buffer,
 		 * extract a folioq's worth from the readahead region at a time
 		 * into the buffer.  Note that this acquires a ref on each page
@@ -99,7 +100,7 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 		while (rreq->submitted < subreq->start + rsize) {
 			ssize_t added;
 
-			added = rolling_buffer_load_from_ra(&rreq->buffer, rreq->ractl,
+			added = rolling_buffer_load_from_ra(&rreq->buffer, ractl,
 							    &put_batch);
 			if (added < 0)
 				return added;
@@ -211,7 +212,8 @@ static void netfs_issue_read(struct netfs_io_request *rreq,
  * slicing up the region to be read according to available cache blocks and
  * network rsize.
  */
-static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
+static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
+				    struct readahead_control *ractl)
 {
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
 	unsigned long long start = rreq->start;
@@ -291,7 +293,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		break;
 
 	issue:
-		slice = netfs_prepare_read_iterator(subreq);
+		slice = netfs_prepare_read_iterator(subreq, ractl);
 		if (slice < 0) {
 			ret = slice;
 			subreq->error = ret;
@@ -359,11 +361,10 @@ void netfs_readahead(struct readahead_control *ractl)
 
 	netfs_rreq_expand(rreq, ractl);
 
-	rreq->ractl = ractl;
 	rreq->submitted = rreq->start;
 	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
 		goto cleanup_free;
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, ractl);
 
 	netfs_put_request(rreq, true, netfs_rreq_trace_put_return);
 	return;
@@ -389,7 +390,6 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 	if (added < 0)
 		return added;
 	rreq->submitted = rreq->start + added;
-	rreq->ractl = (struct readahead_control *)1UL;
 	return 0;
 }
 
@@ -459,7 +459,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	iov_iter_bvec(&rreq->buffer.iter, ITER_DEST, bvec, i, rreq->len);
 	rreq->submitted = rreq->start + flen;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 
 	if (sink)
 		folio_put(sink);
@@ -528,7 +528,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	if (ret < 0)
 		goto discard;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret < 0 ? ret : 0;
@@ -685,7 +685,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (ret < 0)
 		goto error_put;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
 	if (ret < 0)
 		goto error;
@@ -750,7 +750,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	if (ret < 0)
 		goto error_put;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret < 0 ? ret : 0;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f0436bac5b59..547b1aa70d2a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -231,7 +231,6 @@ struct netfs_io_request {
 	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
 	struct netfs_io_request	*copy_to_cache;	/* Request to write just-read data to the cache */
-	struct readahead_control *ractl;	/* Readahead descriptor */
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
-- 
2.47.2


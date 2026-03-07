Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163D387569
	for <netfs@lists.linux.dev>; Sat,  7 Mar 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874053; cv=none; b=bU7urf3FgZqKRGNOQK7m5wcp5M/P8OyRi+k1GkzISvLIQ/1FFzyNO6q+t3FU/pbV2bv5o7RjCCPfnrQzU41BOhsj5KgnENnuhmeudL0iZhZB8wgx4z7A/ln8Lvrm2lWx8HhSAofhYozpx8wTjG9e1ubp9SEF9cYN/UtWHySSHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874053; c=relaxed/simple;
	bh=DpJ0U0ChB40a5/VIDnN1Pt8w6d+RWSvZEqctD6dXl5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pv8DWqGrFt0dpw/lKpo5nZeDThxbx04pIxEFzlIjwvFlK3QQbDrVr1s0lb1WSNOGWQCezDMLUG7J508wvyVzE8U5Z+cWKcFsYHnqsaXP0FiphB0fr3RTV4jdxRhHLPKbusiuOd0FuX7M4H+Bn4HDqyJG4wAw28y+B9G0IXb46Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw1pRsse; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw1pRsse"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3598e7155bbso4300213a91.2
        for <netfs@lists.linux.dev>; Sat, 07 Mar 2026 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772874050; x=1773478850; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1qIWIJPlYMXQTKQnekP1rjhdJ7z4pMn0jMtkRlfuMk=;
        b=aw1pRssePDHLSWxylDSbuKQzFr5n0Eog1oq19/UBROOzCVtVaXRWt+yNj3GxFgMGcn
         ATF9H1PlXxJopwsB4Ud9CXLOMkG2VcXFSXD+Qt1alaq+FeTqGmy2tnxNRFYD1z4kNHuW
         oQq8DFCBL0UScYwGQeljTuBvTSAkfRxkNxIplGNv2gnxRV/xSvGN80Mqio4CfstIpF0N
         3XMhaCOe4XP35UKNSd/mL3Yky1XafhBkjmIISfa8iK1tBo250tBf3TFsgM2EVxTkbpLU
         a/ojFxBnjeQtk9qGA5tOUBoZRfe9YCcSxbwRRJQ+YWSgQiVca3kpWU+tXSBDY5wMrUoC
         kb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772874050; x=1773478850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1qIWIJPlYMXQTKQnekP1rjhdJ7z4pMn0jMtkRlfuMk=;
        b=uirubXpPGbT/ZE5o9KsW8OwBSl8sYVMADxCUjucXCwKtLCOtwdxTpifDZMhdqNJjXL
         vVfTlsz8otqYE/N82uniSbV8vQiNMlX/5JXmHZqPN7157v0EjTuMwv+PqfbeK7QUQlqb
         U/ops+1ZUNSRZ7OLuHS1nGkqbh74yM8raQpdeJCdtUVB5iWW1Sx69+wajLCdch1ymFol
         yS2uosMBkxUZ3xphCU1VLRGJtljiG6XylmVKnaR3b8Q6Fh6kfCPeqIX//Y36GlyQ+aFf
         tHVjzBgMzL8F+iRsUK2rrSGxqHZb9ERfqKdht6PYYn87nW7LpQGb7cRBKDpJkyFNAc32
         turA==
X-Forwarded-Encrypted: i=1; AJvYcCXlM15P/CjdD0yaAMa1Awveb1H0f355Xi48b/ARgTYZ/5bCrWGmiKgR6QfRP3M5r3ETO84MOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXxnC53gEuOxeMDVZHCryC9jefJ+HyuIKMQAesq8CeCSNLcu6F
	bsxvGj4VJnXhxA5r0TNTsLMRDL+ISsm4NmmrDy6gNIZYvkTwke5iMvXC9HfbpDTx
X-Gm-Gg: ATEYQzw/TVxE0lbw77/d+dpcUV12FLy10Bhf4GcbhohZLlhHF+4K26pgdZ44P0pXB3C
	M14ZKUB2+eLC0LGYiz5o3l2UQP3cqSx4BlPoSm+Ko5PyNpy28V2YXROAnTgBHmAjOWm/za3OPgQ
	s7RmSlAyZd7tq7dgtfbPo+i4DNnaBZG7Rpc9GgdNUktdf5kshNSvfEJ9mclRvJU3qnOLK5+TWhl
	kjWvDcsGCPIbdL0/8eZ0sT5Y+QQkCTlyNdaCkP+7Vk+hxMznSqHxLehUOM1XVC8jFIga0ksXzzV
	QHhopcWKfaDikhUDJ3rcedOQTH+kN3ycmPb+7wz+mHrKD2N8u9Elb9Bgbm22gCAlNgCKFIA5JgD
	IYnvWi4DeQlQJ8YKiXJ//atEdb4MIOAW51BwOJvkpSCch0NNnZ911KAnzyuyjPpiybQiQFdio2Q
	+GcM9/lzu5juQ7BG924iTGQZ8saHk1AIiOGtvPQwALRJc73PMd9TLjflBzFQaz8s77FSTtxlkqY
	/2J8kwQg1RdPYBLpw==
X-Received: by 2002:a17:90b:5587:b0:354:a546:5edd with SMTP id 98e67ed59e1d1-359be24b125mr4977305a91.11.1772874050220;
        Sat, 07 Mar 2026 01:00:50 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:899a:49a8:c3d1:e400])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0179a67sm4263149a91.13.2026.03.07.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 01:00:49 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: dhowells@redhat.com,
	pc@manguebit.org
Cc: jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
Date: Sat,  7 Mar 2026 14:30:41 +0530
Message-ID: <20260307090041.359870-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a process crashes and the kernel writes a core dump to a 9P
filesystem, __kernel_write() creates an ITER_KVEC iterator. This
iterator reaches netfs_limit_iter() via netfs_unbuffered_write(), which
only handles ITER_FOLIOQ, ITER_BVEC and ITER_XARRAY iterator types,
hitting the BUG() for any other type.

Fix this by adding netfs_limit_kvec() following the same pattern as
netfs_limit_bvec(), since both kvec and bvec are simple segment arrays
with pointer and length fields. Dispatch it from netfs_limit_iter() when
the iterator type is ITER_KVEC.

Fixes: cae932d3aee5 ("netfs: Add func to calculate pagecount/size-limited span of an iterator")
Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/netfs/iterator.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 72a435e5fc6d..154a14bb2d7f 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -142,6 +142,47 @@ static size_t netfs_limit_bvec(const struct iov_iter *iter, size_t start_offset,
 	return min(span, max_size);
 }
 
+/*
+ * Select the span of a kvec iterator we're going to use.  Limit it by both
+ * maximum size and maximum number of segments.  Returns the size of the span
+ * in bytes.
+ */
+static size_t netfs_limit_kvec(const struct iov_iter *iter, size_t start_offset,
+			       size_t max_size, size_t max_segs)
+{
+	const struct kvec *kvecs = iter->kvec;
+	unsigned int nkv = iter->nr_segs, ix = 0, nsegs = 0;
+	size_t len, span = 0, n = iter->count;
+	size_t skip = iter->iov_offset + start_offset;
+
+	if (WARN_ON(!iov_iter_is_kvec(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+
+	while (n && ix < nkv && skip) {
+		len = kvecs[ix].iov_len;
+		if (skip < len)
+			break;
+		skip -= len;
+		n -= len;
+		ix++;
+	}
+
+	while (n && ix < nkv) {
+		len = min3(n, kvecs[ix].iov_len - skip, max_size);
+		span += len;
+		nsegs++;
+		ix++;
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+		skip = 0;
+		n -= len;
+	}
+
+	return min(span, max_size);
+}
+
 /*
  * Select the span of an xarray iterator we're going to use.  Limit it by both
  * maximum size and maximum number of segments.  It is assumed that segments
@@ -245,6 +286,8 @@ size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
 	if (iov_iter_is_xarray(iter))
 		return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
+	if (iov_iter_is_kvec(iter))
+		return netfs_limit_kvec(iter, start_offset, max_size, max_segs);
 	BUG();
 }
 EXPORT_SYMBOL(netfs_limit_iter);
-- 
2.43.0


Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A73D7D9B
	for <netfs@lists.linux.dev>; Fri, 16 Oct 2026 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187755; cv=none; b=rLjzObsOOYx1+iKpJnh8ONyo3HX1VKnJR2ntdKKYfw4BO+kJ0I8s33GZuKBgmugUCHFiu4GB63cC2fq4c4AFfDnOIxSm3ctgzjofuaEs3LiPEXWT8mP+N2o+0rs2g4udihdVSML+QsuDtBGkSjGzPuahXW2kVR2uXrTS7DPmFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187755; c=relaxed/simple;
	bh=6PlFPl5yyg+7VyuqK7O9sVNkpaIz69EVRd4L3Av4NYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyE37odQiOVLBnvDmWNCE6soHSZyckoISVwiaozN+CBKkBM1faTAI8CdMpUYkAwn6eWlEaKJ5R6Asu09K9Rgb+ngZDqeqO1aHroXjnuKNLYFQHA2VREtyIoLGRU7raq0qz34wr19BNvLUxqygzQysrAKDEopjYV7lHqrcQbYogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOSbA4jm; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOSbA4jm"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so682506eec.1
        for <netfs@lists.linux.dev>; Fri, 16 Oct 2026 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792187753; x=1792792553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEYeqJ4N4i7YjnqQCG2LK1nS6owgSqR6t1k2WUrMsnw=;
        b=TOSbA4jmRj3TDRk2hMMbqPtobWf9U/wpeJZN0dp41YnizWoCPKBx6D34WspPXTyMTF
         rBJKCcsMN1xQXest567gDK610E+Nlz2Tffol082zcg+DgOOVeYIzxg+JGmdi6nnhT2rJ
         anuiKoO6ZThas35roewUp7TbKPS/idIt+eKQ8xHXz5DiYt7pvSD2sf66i0NKK0qprLF2
         VsCefPQqUnnR9y6Tqz6nzHmFzFPQbcBrj2G3HRTFvatJEdSB6hKutXZvPHNHTkkwGxRH
         F+DW0QyWfo22fOBjT7TODYLP0C6V19HYGprI4xhO6Ff/AEhQCmG1qeakrYAgMuutCQmP
         2MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792187753; x=1792792553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEYeqJ4N4i7YjnqQCG2LK1nS6owgSqR6t1k2WUrMsnw=;
        b=1zh58YV9Mq2KWePgbmfQEttJF86yGyG3VEgsonF39IaFQgbnP3hqKof5FTlA8cNwX9
         z0l+3pIRBmYwlaUtKWPG5bSCs1KBLa2Pn8piinLkD57/HOuatR0UpU6peBdreaRr5hvR
         3Srr7iqDahweYiUrbt5kWUpoXrltecth9VELvv11UbIojB6x8dt04p83G+CxmLULq66j
         +tWxuVehihO6gxo60vP+HGbFI9nKZEh/KoepPrDIxVnL1jQWGoDEFLwD5B6bpbLFkBMS
         9MY3sAVFaJjvU81qJk6Al9QI0pmM6PpQNiIIu6D6wkwd0i4zZeOKBxegRdrTdfvNKPHw
         9I4g==
X-Forwarded-Encrypted: i=1; AKwUvByq8QGNwBZkWswBAniGuMnmXu8xV4Toijdn0mb10s7TmGT0eFnUprACutx+oyT4IKXG9Tb6cg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJHzcLWSsrJWcQGwMk4ehECsCV58Lid+wqm1Iy0MQ3sE7ijZL3L
	EJLvVmGUbxrz6P/81Tpott8j+v+qK1tfktliAgDn0F6u3eo+e6zFYmh9
X-Gm-Gg: AYBFou0MTySYwtLOlWt9sLoOgMaCL6uCzpkyp3550aRc1ncTNjtHqffon6uB0U1w8rZ
	3oRKlq5vvgK3l4zQY0siqoSTxEHq0LnR8X85nlUWPm6HLNw7w4q5RtJ3wXMcNvn5RFyt0Ew35b8
	z6qJRL7TyniJp2GBg7MRvkKfN11nsHgNKmlH6d79I3vlXbQzKLbhjMUaKZ5woUSEMA1lI2/thK+
	2B4JQ5zQQUJtrdCM3Xox+2KGMzafbJAz8+LaXP42dnip1IObMVUemiDrmPtBd+6q0WhIwfaNA0G
	vOJz5ildDJpZO198jpuXYrPLKfxCgwBJbfAX7kiQHA9auPA36vbEJRhYgKs6yPhagQiCFVQ9ZnU
	+M5NJ/H+NhUuoLb8IM1UTldteOHVN7mminkW4vi+AkF41OhqCKIJ/rk6NiBcIS0AZW08jel0D6+
	QA82i1x16uHVJ/lPY27OJqYT3ySXEjMD0O9Y3edRvAXmErK9loq4CKdfA3ZdHGRPdZNgv+/nNsx
	u7EKYBp7Q==
X-Received: by 2002:a05:7301:52c7:b0:35d:d671:933a with SMTP id 5a478bee46e88-361a185eff6mr1110380eec.15.1792187752437;
        Fri, 16 Oct 2026 14:55:52 -0700 (PDT)
Received: from FredPC ([2600:381:b915:8f8d:c200:c442:48e:8bde])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm10537981eec.6.2026.10.16.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:55:52 -0700 (PDT)
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fredric Cover <fredric.cover.lkernel@gmail.com>
Subject: [PATCH v2] netfs: Fix off-by-one in the flush range in netfs_page_mkwrite()
Date: Fri, 16 Oct 2026 14:55:17 -0700
Message-ID: <20261016215517.33292-1-fredric.cover.lkernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a page fault wants to make a folio writable but the folio belongs
to a different netfs group (e.g. a ceph snap context) than the one the
write is being made under, netfs_page_mkwrite() flushes the folio and
retries the fault.  It does so with:

	filemap_fdatawrite_range(mapping,
				 folio_pos(folio),
				 folio_next_pos(folio));

filemap_fdatawrite_range() takes an inclusive end offset, but
folio_next_pos() is the position of the first byte of the following
folio.  The range therefore covers one byte too many, and writeback is
also run on whichever folio contains that byte.

filemap_fdatawrite_range() is a WB_SYNC_ALL operation documented as
waiting upon dirty or in-writeback pages in the range, so the faulting
task can stall behind I/O on a neighbouring folio that has nothing to
do with the fault, and a neighbouring dirty folio is written out early.

The off-by-one dates from the original implementation, which passed
folio_pos(folio) + folio_size(folio) as the end of a
filemap_fdatawait_range() call, which also takes an inclusive end.  It
was carried over when the call was changed to
filemap_fdatawrite_range().

The flush of the faulting folio itself is unaffected, so this does not
cause data loss or incorrect results, only unneeded writeback and
latency.

Fix it by passing folio_next_pos(folio) - 1, as the flush_content path
in netfs_perform_write() already does with fpos + flen - 1.

Assisted-by: LLM
Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()")
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>

---
Changes since v1:
 - Correctly CC netfs@lists.linux.dev
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ecf119b4f9166..b398c3bef6f3c 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -579,7 +579,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 		folio_unlock(folio);
 		err = filemap_fdatawrite_range(mapping,
 					       folio_pos(folio),
-					       folio_next_pos(folio));
+					       folio_next_pos(folio) - 1);
 		switch (err) {
 		case 0:
 			ret = VM_FAULT_RETRY;
-- 
2.53.0


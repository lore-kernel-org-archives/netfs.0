Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF522ACEB
	for <netfs@lists.linux.dev>; Wed,  1 Apr 2026 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076983; cv=none; b=tdbTIvcWlKKuqx20QZsEgfmEv2ro+c5dMPGSDfQ4PUDTHfYnTZv46nThmcltXM5+4oInpt2xGoAPWa5XqHpCh6Ji9OceOtAKdKpPMSXPtI1gon4YbtzOUxCE/7kYSF8KPsHLoef/hke+Ju8R+2Et0d5w53xBCoMASgu0YlYvuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076983; c=relaxed/simple;
	bh=ruhqRuTEeSnlUtb1ed9VMt41ZI3HJlzRccGuOXzsxs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHtKM4lwFJDq6SwsgeHVtD2bszaYNAinlT+e1CWcBkPQdAHpSICX88IYk533xblS4LzIroClvTI7c44VoFP1KD6y7WDzvW4LKx+656xCQMgnCe9i1zqVJiI3Irm2JPHlnpVEIqvGNpQw+baiTULUmE3UZiIbT3TW1lK4E1c/h+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JzLNDwbq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JzLNDwbq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso14380725e9.0
        for <netfs@lists.linux.dev>; Wed, 01 Apr 2026 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775076979; x=1775681779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4y38OjeCEJcXrt/pjxqcqwKy5B+FZ5WVvHJbYZD1e28=;
        b=JzLNDwbqGcCy/nm8WJ/uRHlbDqBp/p6ydAOBMPwlS1318ACQumt1VlAuj9CLdcdb97
         NeH1aJJHJcfnYXIqhOux8C+Qk0u34CSdqssxpea3wd2jA9kxusfA0Hg61TzjDwB1jg+D
         v+oXk5e4MvqwLJPdjh0LYkfG/6s96SvmPgcc/eN6OTKtYH6ShNJa4PajFQxGoqU7cTrD
         PXPIRfhwlOJQo6mlirwfWn1Sp2y9ZLmXMR/WPAhkyJ+PN0cGAtZufUA/1FBuUAz55oYx
         U6cXex8kwhoo0tOrzkN3GRq8M+OWrhMtRvG3e9J9t7FwKe3pMR9q5E+ebLjMbgNEobBJ
         J00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076979; x=1775681779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y38OjeCEJcXrt/pjxqcqwKy5B+FZ5WVvHJbYZD1e28=;
        b=VBNGhx8wv9B/JFOXPlcE8JN5IkpFseqcHCRsptpb7GB54e4rxzy5rZZIGG1e/bjPYk
         zSUAIzz8Rv8WyH9XgxaSUgvS8XUB4Ts09J47CXcvxj7L646QRtphuM+FzFVrUaQi5VbD
         4q+evdHU3x51zqBj+98D5N4WhhAhAQ8P0P1MA1NPPTbY68GPv7sD2SKhsx/RpHMOexnL
         B9ndr5FEC6xixqi35XGt2DWKI3R7MhdfeOnz90vBc1C7wyTrmbxfz9wfpyH1H0qPGs4m
         +54EdQS5Q/igioP7BmJY+VpTd9GSLnP7XGzNwI0dYpXDbsXMyS+zfzLnt8FWHYf8ETed
         NV7g==
X-Forwarded-Encrypted: i=1; AJvYcCUE6d2lGp0ZuC4dW83iHviA3A3fQSeB/K+DwzKtnQuavzsYmNJlVtE5pz6YgRRs9hQ/ePBnOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtrqeqUg09IfWwzs+rMOX3ALO4Rf/HClp+YzCSmHhmRAiXspxF
	Egl9ba9LjYKkCCxsvK8JGmNkF+D4wMoC9yXuu9Il4PzN8WHachw093/kUdnLT056M1o=
X-Gm-Gg: ATEYQzxmUfUvjkYV+nyiiPObEJXsIRbbykqxRIxxywagJ+ExDFNZLfpsFSL/k3QJOY6
	uTz8bXxnaDJrgQ/1HDo7yaFXS+2HhAh2ivPcTYu7Te/DMmFJCbeVE8Nk5lGtRUrnnXFfRvlCdHA
	ceXRlbt7C9kZcSa7o5erdpczf2/TcS1Cl0WeQCEPmMr2Y7rcagZkG0QgY12Q0/BPee/2sOxPUxq
	ava4XNe4nXsMYDBt34cip/l2ZXzuz7C45mIJuouA2bELAWozZgBzScpd7jXY+JvHP28zrGYhySk
	rhkzsbnTeTE+MI2XCnFWXRnvw6rB0TGuKogA3Q0ochDSMd4JBBRtFNY7+3xp8ZGi02GmUs5uBJD
	cOm/jbDp9llRSU+PfzkTtXIdIUhe86ed1NXcwdaCIRkLFfa8NDJVgXTCOmz10HOHRzvyEwdwhaZ
	CcchGQc4EieAbBgVoa2NXrpsNU84BdA1G6JMNVBsFaCRwbi7LnTzSWhdaMq4LZJB1zkRPmoqHkB
	xq10hFYVHeFrXB/0eNSJ9+kG/o=
X-Received: by 2002:a05:600c:1551:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-488835a15d2mr88248075e9.10.1775076979136;
        Wed, 01 Apr 2026 13:56:19 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a567bfasm53369835e9.0.2026.04.01.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:56:18 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
Date: Wed,  1 Apr 2026 22:56:13 +0200
Message-ID: <20260401205613.2095623-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid populating the local fscache with writeback from dropbehind
folios.

At the moment, buffered RWF_DONTCACHE writes still go through the
usual Ceph writeback path, which mirrors the written data into
fscache.  The data is dropped from the page cache, but we still spend
local I/O and local cache space to retain a copy in fscache.

The DONTCACHE documentation is only about the page cache and the
intent is to avoid caching data that will not be needed again soon.
I believe skipping fscache writes during Ceph writeback on such pages
would follow the same spirit: commit the write to permanent storage,
but otherwise get it out of the way quickly.

Use folio_test_dropbehind() to treat such folios as non-cacheable for
the purposes of Ceph's write-side fscache population.  This skips both
ceph_set_page_fscache() and the corresponding write-to-cache operation
for dropbehind folios.

The writepages path can batch together folios with different cacheability,
so track cacheable subranges separately and only submit fscache writes
for contiguous non-dropbehind spans.

This keeps normal buffered writeback unchanged, while making
RWF_DONTCACHE a better match for its intended "don't retain this
locally" behavior and avoiding unnecessary local cache traffic.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note: this is an additional feature on top of my Ceph-DONTCACHE patch,
see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.kellermann@ionos.com/
---
 fs/ceph/addr.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2090fc78529c..9612a1d8ccb2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -576,6 +576,21 @@ static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64
 }
 #endif /* CONFIG_CEPH_FSCACHE */
 
+static inline bool ceph_folio_is_cacheable(const struct folio *folio, bool caching)
+{
+	/* Dropbehind writeback should not populate the local fscache. */
+	return caching && !folio_test_dropbehind(folio);
+}
+
+static inline void ceph_flush_fscache_write(struct inode *inode, u64 off, u64 *len)
+{
+	if (!*len)
+		return;
+
+	ceph_fscache_write_to_cache(inode, off, *len, true);
+	*len = 0;
+}
+
 struct ceph_writeback_ctl
 {
 	loff_t i_size;
@@ -730,7 +745,7 @@ static int write_folio_nounlock(struct folio *folio,
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
-	bool caching = ceph_is_cache_enabled(inode);
+	bool caching = ceph_folio_is_cacheable(folio, ceph_is_cache_enabled(inode));
 	struct page *bounce_page = NULL;
 
 	doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
@@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *mapping,
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
+	u64 cache_offset, cache_len;
 	unsigned i;
 
 new_request:
 	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
 	len = ceph_wbc->wsize;
+	cache_offset = 0;
+	cache_len = 0;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc,
 				    &ci->i_layout, vino,
@@ -1477,9 +1495,11 @@ int ceph_submit_write(struct address_space *mapping,
 	ceph_wbc->op_idx = 0;
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
+		bool cache_page;
 
 		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
 		cur_offset = page_offset(page);
+		cache_page = ceph_folio_is_cacheable(page_folio(page), caching);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1491,7 +1511,7 @@ int ceph_submit_write(struct address_space *mapping,
 				break;
 
 			/* Kick off an fscache write with what we have so far. */
-			ceph_fscache_write_to_cache(inode, offset, len, caching);
+			ceph_flush_fscache_write(inode, cache_offset, &cache_len);
 
 			/* Start a new extent */
 			osd_req_op_extent_dup_last(req, ceph_wbc->op_idx,
@@ -1514,13 +1534,19 @@ int ceph_submit_write(struct address_space *mapping,
 
 		set_page_writeback(page);
 
-		if (caching)
+		if (cache_page) {
+			if (!cache_len)
+				cache_offset = cur_offset;
 			ceph_set_page_fscache(page);
+			cache_len += thp_size(page);
+		} else {
+			ceph_flush_fscache_write(inode, cache_offset, &cache_len);
+		}
 
 		len += thp_size(page);
 	}
 
-	ceph_fscache_write_to_cache(inode, offset, len, caching);
+	ceph_flush_fscache_write(inode, cache_offset, &cache_len);
 
 	if (ceph_wbc->size_stable) {
 		len = min(len, ceph_wbc->i_size - offset);
-- 
2.47.3


Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B319049A
	for <netfs@lists.linux.dev>; Thu, 12 Sep 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131145; cv=none; b=siEIAOuYncWoW/VjqQgTTloqrBm4+DMZ8e80e1CnMF3VhF1fOcrCGmLDZxJrvLIf4UU2G045ajVo/cOR1N8XLbpnyQ1mUh1paO48UVPFQHSiiKMeYOcT2/NIQDagN/j8aDjwOa2o/eimoPj4JXsEDTycfD63PJuxX/nCgDDQ9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131145; c=relaxed/simple;
	bh=+Uv1yRx1t/nh3AdvtaBsQpatvoFp9YWwQHVWraJdMZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L426VQrkLwCkfc++7IcTpCFvreMXc+4SgvHoFvYKt0896PO6WrhqODIN4O8ohtywozV5NOEhEP9fnwGx+Z2P2R0o8RlvMzXwJLx+aCAs5tbiVQP9x/FjXXdQBmgV0ChFYTF945ipsBjcvg5GZx/8EnrswdksgWwRUc2snJOSCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RmebzCPI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmebzCPI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so7731985e9.0
        for <netfs@lists.linux.dev>; Thu, 12 Sep 2024 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726131140; x=1726735940; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jfx4IHYM/f9TvrOy+r/MT0ESdhaPDLWNq6uOUg30aAY=;
        b=RmebzCPIjzOTZpKZZ7eAF2tr2QqbjklSa20+yNqw5HJTV48Rc3ywg94FWPv6kPMy2s
         K1RboM+LNtAWgoOivxBJbrHT0rmkeZ279DxFsIeaw4OCEKive5lZzUOXF5c7acPbT6cD
         AjkmRTvkPYEaS7t08/ojwUgID3v8uRL8wRsUHbJ0uZd6llzL6/lf3lMyuXP4/D+U1/98
         XYy2qc3sCwLTGfIfR8Snun9mAajTxBDNXqVNy656hqI811fNYr0d7dVhNC+c9sBMh48W
         EGmxcnQlwb3am0LqOzSR544fQ3S7ZeZC0bfJTudljEfBCzsSDdBQlI1aGtNiBSLoO+Xk
         /C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131140; x=1726735940;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfx4IHYM/f9TvrOy+r/MT0ESdhaPDLWNq6uOUg30aAY=;
        b=m9kQx91IIFeUcZkfeDF5U3InkN6vI8F+fOONPbIPkAsQM4Mh4qRCBy382sgbpmXETZ
         bn0makyvuUOFslu2jJQ0S+Q2GFbnoaqUNjAbwc4TS+3pRqFZyaEvlGz1bIAc0kRm1kdO
         LS9S+40joO+llBKffvYFTv3TS0UQQZcV8QCK1Dy9PyMXEJpGPtvP9w8vzJIzBWZ0LviF
         sqfZaXCbiGOiEegxVp2vdzn1lDeo8UuyoYrnXh2WkgnXVP+cHLRq1zfRrGS0CxAVZRW5
         AKQKA5qz96WT+IBuMC4matsQ8XQZJiJoVrRFBpUuFzmuAtddPlc2V3MJqFvbYrOgBixS
         fXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuOOEOBuu0qsOkMBBY9siDZqv7htlJCpmNk3c/0cEW8rOyoWV10Ew2RT+czLEQN130UIxtFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcTTWTEZTW+gz7PggBs+0UUjtmkbNmoUkeLaPC9I3v4CgOVH5g
	yY4jSvIBZgvQ+yaWDBtgNB4nY5vtDOXam7PWEYBWUrLbHViGWyWPw1kyDY/IjAY=
X-Google-Smtp-Source: AGHT+IE3JvQVI8H7Az2p7xH5qjI8YDyhtJ3aO9BUYYnl2AM0k/tr5zbW/XahZ19yePpZcAyKjxL+wA==
X-Received: by 2002:a05:600c:35d2:b0:42c:b555:43dd with SMTP id 5b1f17b1804b1-42cdb5112eamr20411895e9.3.1726131140394;
        Thu, 12 Sep 2024 01:52:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm86851825e9.0.2024.09.12.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:52:20 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:52:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: remove some unnecessary code in netfs_read_gaps()
Message-ID: <df691112-1114-431a-8c71-09d1656f0771@stanley.mountain>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We can remove the "sink" initialization and the check for NULL.  It was
already checked for NULL ealier.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/buffered_read.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..9f96844205b1 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -481,7 +481,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	struct address_space *mapping = folio->mapping;
 	struct netfs_folio *finfo = netfs_folio_info(folio);
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
-	struct folio *sink = NULL;
+	struct folio *sink;
 	struct bio_vec *bvec;
 	unsigned int from = finfo->dirty_offset;
 	unsigned int to = from + finfo->dirty_len;
@@ -540,8 +540,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 
 	netfs_read_to_pagecache(rreq);
 
-	if (sink)
-		folio_put(sink);
+	folio_put(sink);
 
 	ret = netfs_wait_for_read(rreq);
 	if (ret == 0) {
-- 
2.45.2


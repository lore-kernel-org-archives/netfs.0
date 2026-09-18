Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65263CBE84
	for <netfs@lists.linux.dev>; Fri, 18 Sep 2026 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699259; cv=none; b=tzUsYRP9byyr64OuG4ArPqYzUvHCUs26JoH+OeU6uGTczmBLnHH8/Rh/LOEDZ3PFivjvo4Wnoqq6xvo7jxg6eYe0aCav+omnOGF6yFOG2KsutgTfDkoVo0D3wveMYxl9J3Lw1a0vYsKG1VnS4phGi9sXpXyL5xvak9mOox8u41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699259; c=relaxed/simple;
	bh=4RtBTcAG3ZyoV+Wuhgih7ZMjV1Rc/AqLjGt6M9kijLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GmPz8SORp9fRMlCbamFPTD4xn/WhFD/R4VmVBhv0RZn0L02FsYceR23zUJc4N0ZbKYX1cmgydQb0dZY9uqq3bkx0WGe1JgHnq4doJHC1xKXFkx7u4n989IAPSV4L1xd+TrILbE+/XxFLuLLSKtEzcxuSThW7NvOMyDeIv/3Tobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niupPDp4; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niupPDp4"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so70121a91.1
        for <netfs@lists.linux.dev>; Thu, 17 Sep 2026 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699246; x=1790304046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XcNnKNj86Fl8cPyJbGiSdq718Tdcgp6e3IuiJ+1OzoA=;
        b=niupPDp4gYzNuCnLFf+3pC6FjEMcHKNCMFguNPJhJdsrJsBFq5V9Xvi3cdp6gLmr45
         AsbYHKMG8pJ1Rsu8uphXyjFvz4NWvvkCpr4cb9XVJjpz/vSxK+i1wYaGxU/xpMBU2MkR
         hbDEIsBUiQhRhwqkySCr2ja0BJ01SHH2822cWhCOM+RpSiJWXGBz/b8RFns7RpmbOquS
         083ZOMAyejSmEcCcl62eB+Dg6U+nXjG2D20oJtN1WHFHNX5jYzR3o6L+wzB1Dj4L2aPm
         OjwjN1Q4STyzyYnwImimmqL2kUOitmbEdFgqT6N5Z3Rb4uL579NRlwb9xTavPS8hcLEt
         V1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699246; x=1790304046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XcNnKNj86Fl8cPyJbGiSdq718Tdcgp6e3IuiJ+1OzoA=;
        b=WUBb2oVkzsWMGVNbw0VBWpimNLPZ07sjd+oiFWvGBmUkV7iOLSY+p7bFqWPOaABIaP
         kWg62wYvCs9mMOxrtYWf0sUkWo8qSj81UF+Y8Iy4ObqKLKWxvVGUeucWy8s2C/KN0xQL
         cE4Tmos19/UzecSAyYkgCFLhWamSMxmYORc04Up6ZdrdZ5I2p2Gs6n6rOFWTI3663NyJ
         GQgvLktfl3YYBVWhQcQf0JgDVVzEY/lRuupFQgc8wpvb3vU0+Yn2iuX6fevNGopwjiqY
         CiVPRanOfs9UgTgtaILwhLCAgevElZ+gKDZvoZ2JDi1A6eKGu+sKaHJnNg1rFbYMCrTg
         Aoiw==
X-Gm-Message-State: AFuF++mAy3li1i35RI0KfP1418+WUIjij5x9bcKoK+C0ErmewM+qTSQm
	sWSzQzAMcq0hviNr290V8HLvi+uCxJSHpcefCcBKcrKCM452z2uB10P4CD3YmhKKTcI=
X-Gm-Gg: AYBFou0FEhGYCPElbFakHm2Kx38lMZZ+QsGSSjPYxCxq0uCRz3qWPqITFHu8zS+8Xzz
	2aMiEhparS3gglAXjtVrIXYGH4vMGOpn0IfKqbalukzQU9/XDMKOR9C6ItESPfcP7UmsQWRiTvm
	am1GlIulprc01wcdQ75zKPbGjMnQoiJRaSQ2tAJuJkLnpDM+01B6dFeclDi9fjyNWVybYCNC6Uq
	H5cpVL4raSHcfH1eVz9vqNMkQrnLTcl+Vj0RKsj8cGp+TXlSwixllVRlt0DBy+LqWc4FcJgD0ok
	m6EqF/lWeOyxioP7+0ZZPrms2NAwbqa7Efqw4qnYjdIofzRdOyJuTb82CKpwgU7W7KF9iSzBWqo
	CG41izgTgOZVEGlBpZR83V6FFWUsFMUlFQDq1jV2LMpdTan3X53gIjQTMD+kzIe+E+sRh2YSj++
	W4GNEu4eqbWglWGtJR6NsTkRwtUTOuIM9u06nY2D0niu90QXWyAm8Sf3ekYSsn3nW5UDZed+rjm
	E2SuW+Jmi5LSmGUNzoDwumyUdQiROFHBvc/4eO27LZmyiDf3J+hcrbOR4YYkg78s/50FKQubQ1j
	Osc9hE+lTKS4NuBc9+DtXAaAlGntRlAsM2XLhfjTDGar7nDRtuUSZ0j1TUHOpZWHcw==
X-Received: by 2002:a17:90b:52cf:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39e54bd0941mr2438544a91.15.1789699246338;
        Thu, 17 Sep 2026 19:40:46 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm316111eec.22.2026.09.17.19.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:40:46 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH] netfs: remove unused fscache_internal.h header
Date: Thu, 17 Sep 2026 19:40:37 -0700
Message-ID: <20260918024040.338737-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs/netfs/fscache_internal.h has been unused since commit 915cd30cdea8
("netfs, fscache: Combine fscache with netfs"). Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 fs/netfs/fscache_internal.h | 14 --------------
 1 file changed, 14 deletions(-)
 delete mode 100644 fs/netfs/fscache_internal.h

diff --git a/fs/netfs/fscache_internal.h b/fs/netfs/fscache_internal.h
deleted file mode 100644
index a09b948fcef2..000000000000
--- a/fs/netfs/fscache_internal.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* Internal definitions for FS-Cache
- *
- * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include "internal.h"
-
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) "FS-Cache: " fmt
-- 
2.43.0


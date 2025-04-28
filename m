Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E026B0BF
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847008; cv=none; b=UkQSznGxMjCyfFOGtGD31cMkN2INkIs9+YsXCpziCLDNBr2Z2MCPYgMAYdpT1tVu5Xcp+VoC9jwL0IQ3h8oZHYdeLeGFuRDoBVwjNzvp6++0wh8idr2jNgtfa/5nV2xrs2y21fAAlSkhfvqT7rxEp9UbIPy46xsGmcG9/o9IuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847008; c=relaxed/simple;
	bh=Vq/h9KhZcA9eirkQVo2w4gLd0E7LXCueQL2GdN/mYMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=purMcpdA44ANeCn6y7SgFPMNtglpDEHWYRV/yL7IPJCV59E7zjS9Mm5sulHEUcPwnpQ/ojQWn39i7F2U5ZGxWqxet9AX/b3wgAAj4sS5wT9sMbyaB2QYsM0nbjivx/xz0BBU6X9Yq085cnRDjT7NnjRMXRKAU6wnsQmQDlnhykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HjKgwVyw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HjKgwVyw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so42561165e9.3
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745847003; x=1746451803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4n7WimzNe3yrtmY+n2a9ONyzIrADFV93Pw9AJqzK5yQ=;
        b=HjKgwVyw2S+g9x4dPC8qxfcb8lCNfZpXeUfaiY4+FBcHq688U3nXeuuD5e8kRasZrT
         WvMUcLvoApgZmv+DGaEqMw7GXtWQXiOiLl10VTb0Y5XpUCpYPgRs2BjaX4+n7mesy2HV
         b7T9gQzunvrBLqJpDwZ7D2J6U+Qm96gdzntNW1PVZw/W8UwvU2WCLJ3opPJckissTY9K
         Q43m7zhuoPRmwi6dqMu9HLMiuKDcZU9c2nLprU4BzlZ4ljZuX8ib8QmaDxBz/l5glE+6
         jCrZlgmcSvr2fFTkgxVeQsNgJ6GEk2m25V8nsAe5Ibykqr7JDU9W2XwIGQFG0desmWWa
         BgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745847003; x=1746451803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n7WimzNe3yrtmY+n2a9ONyzIrADFV93Pw9AJqzK5yQ=;
        b=fnt3nM7wKBT98elyHVZMo3E9YRa8gPYEO1AlU1z53R6i7o+kjjK85pJujRivK5oyRH
         sxu1TvuEdppprs6WdFQvpayfDCK5Hgsc5rPEOGmD36ZpRWpysHiRBNMGN+GYcSxv4DRb
         fYxpTiFO0gNcvk3OnfoUFZAjdi4Lk0cPhTpVJ3bSldplPX3uVzfnpLuxa1RG0hnPhStq
         J5ZjwlpudpxDBCUxdKvoVh8h+Aa6dwb0LoVyksfKRy0Jp3iUXH0GVsfNfarsGoFTjTLM
         Dveaxhltd5Cc2uGUrQg7hN99phUObjvIMYh1QR1L7Y/RAejlkRpPUmyNLN09eLpmITkg
         zSaw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ISoEONFqXoerInraH7jEGJ0nUukAvokX+iVl+bv2dOTyzmg3t0LyrbfFLTRMmYuM5bP0rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXjQ3pA7/KjCzj7DgzkgUkrXhaa3wmYQLf1fH3caeTi0PBmFiW
	R7luFkZgel4jrPcvICPR5Kho1ktCTqYDQ+erF3GNZLBn8DWUUnujHooL9uZSv+k=
X-Gm-Gg: ASbGnctGWg+MsuUA3SSTwCWROxnLHv08ltmhH53JUtPIU+TVT6ygCi1t6A9o73+y2nN
	DVBEHZB7zz7HohhUwDgz7/Qp7PuAauIs5YITmlu3BePDCQ32v9uhEutQijeyeEmQZAXf7iJX17o
	V2NtN1ONukPdzv2nGqYzBoPrOHXIKQDW6cJkJb4m/F7SxH5JCGWF4xIpdCNJ4WSvetL7Y9NO7q2
	4ocJlndHzwXJUGITeKzB6UQUO7uuuK9DaTCotNjviiMhdsWGAozIQ8FM3QehhEJrZKpzOVYGaJ+
	zGr54ZwfW3lGFoBWoOc5GK9D/0TZmFXPvCus4SAl2XC4US/CDdvpjEYtARf/XOS8ud6uOvyHXWS
	GV4C+pL+sulTPd5TARY0KVzyjcdE9Wkj2eD7vZ/xg
X-Google-Smtp-Source: AGHT+IHzI5EcHrMeuZrsyAK5ccQBf+Ek+CN3wywl5J/YYH7X91D2dg9mc+ls3jyduRP3SI61g86XOA==
X-Received: by 2002:a05:600c:1d86:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-440a6347fe3mr104964505e9.0.1745847003302;
        Mon, 28 Apr 2025 06:30:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e06d8sm159783145e9.39.2025.04.28.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:30:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs: remove unused flag NETFS_SREQ_SEEK_DATA_READ
Date: Mon, 28 Apr 2025 15:30:00 +0200
Message-ID: <20250428133000.3199729-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag was added by commit 3d3c95046742 ("netfs: Provide readahead
and readpage netfs helpers") but its only user was removed by commit
86b374d061ee ("netfs: Remove fs/netfs/io.c").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 Documentation/filesystems/netfs_library.rst | 5 -----
 include/linux/netfs.h                       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 3886c14f89f4..7d380648e131 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -275,11 +275,6 @@ handle falling back from one source type to another.  The members are:
      This can be set to indicate that the remainder of the slice, from
      transferred to len, should be cleared.
 
-   * ``NETFS_SREQ_SEEK_DATA_READ``
-
-     This is a hint to the cache that it might want to try skipping ahead to
-     the next data (ie. using SEEK_DATA).
-
  * ``debug_index``
 
    A number allocated to this slice that can be displayed in trace lines for
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..d315d86d0ad4 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -191,7 +191,6 @@ struct netfs_io_subrequest {
 	unsigned long		flags;
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
-#define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_MADE_PROGRESS	4	/* Set if we transferred at least some data */
 #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
 #define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard boundary (eg. ceph object) */
-- 
2.47.2


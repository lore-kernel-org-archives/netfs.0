Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CD3C39
	for <netfs@lists.linux.dev>; Thu, 12 Sep 2024 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104481; cv=none; b=U3tJv1YkxSxhuIyCkg7qpXQxTmMc4y1B8SMOfsyqlDxI/AbjBKpzb+0t7wse/+DzZ4CFAfxT7DUOF9T4NH5BF7ejJEc7H5gJK7jgr/mS31glBCaD7SMemN/EtPCGObB3W7HEWJ0+bM29PCedTXwYWkD3oeGGbDJngLX36q90rVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104481; c=relaxed/simple;
	bh=LnnSKYc2m+WkeoNBRLKr0nQho3GZx9CIG8/4QlzRX54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Te7syyWUAthEiXsLkPdDivZhdVTXWcIt35uPseQgxaY+rNhW64OoyqBewncvoA1ZE0OobWwbHSUMv6lDEIO4wp+ag0LN4N0MST5Yslf8HaY+Np9V63Epvcw8kWprB5ATVQnDS3dl4QwVusWoH8RV/7C4BX9UIdi2vD1hOX0HVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3rj7bWh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3rj7bWh"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c3603292abso3989326d6.1
        for <netfs@lists.linux.dev>; Wed, 11 Sep 2024 18:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726104478; x=1726709278; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxvlmWpHHF/4iIZjIKJfqtc9ShKcPmj8i6+oHT5mO60=;
        b=L3rj7bWhezPF9iyQ1bA5zRhAvi0vin/a7yMySM5vWJ4ExMmj1fsXU4iDLcrzFLjfX+
         NQcr+TQ0YSkhI8kkAnpW9NPhCqeT9jXI3rVW+sFHyiY9M/8ZXLAsKGKbCoVkWv2q/g3U
         U3U9+DWi9oJ3v4tUQFK7USETLJcLlNoZSiIiH5p7J50V/auZPS3D12nqI/hK1sVXAeNe
         7FoAebWUH9bkPhPGkTcl2+EVOdDOiP/36gqn0EEII5HgbajNKW0URjx4NrorC8QkL6OC
         uCuGgcR1wB/XVZxSQokpF80oSWgV6jshnJosGRJATpXsuzqqbRILQCeR15AX9DH/ExEP
         Cl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726104478; x=1726709278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxvlmWpHHF/4iIZjIKJfqtc9ShKcPmj8i6+oHT5mO60=;
        b=UyWgZU7lu1RfRiVeWN9jvhxSNfOArwdX0h6ahyoCEXpFLT802bG6unuxiZRZXvXtHi
         oXN3R6+43YjgH4AwbRwdv9b7xXUKcp84LhcJhjYRDGRUhVcemjeVpBgS8SjyqSlm0K9s
         /iip0GTLUaSAY69sMXI1YFPlsX/Krts9r39UDLnRxs47DPb+bE6b/BlHHoMrQKMiluLT
         tqe0vU6Bbg6H5JtxGDTRv/vlGb5ACsbnbnBlEDJihPMm4pMX/QPnyG9MVaKB8gaPBwqP
         GYO/N3j9bvXf8udahRICHTt9xmMhzTJetahOEr88LZAX5lyftW1hPaZVDJ1g0IEph2g2
         6sIQ==
X-Gm-Message-State: AOJu0Yy5OqWbuL+PI5oxaRqGGn8mO5swDjjHbUxqys05anrdk/8ChqvS
	gHDJ7tJHsGm3qc5PXHcacvZIAUQqRUPo17M9h4Bt+VphX/IEkDgW
X-Google-Smtp-Source: AGHT+IHoHzzjeziPJcHDiK8w5Pq233wdQWa6xsGvXYWmafUPotT+cxLFnpSKH97ZV6G/H/HsYTfEUA==
X-Received: by 2002:a05:6214:469a:b0:6b7:4712:c878 with SMTP id 6a1803df08f44-6c573582536mr19814406d6.41.1726104478357;
        Wed, 11 Sep 2024 18:27:58 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6c53474d8e2sm47898186d6.87.2024.09.11.18.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 18:27:58 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	corbet@lwn.net
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs: filesystems: corrected grammar of netfs page
Date: Wed, 11 Sep 2024 21:25:51 -0400
Message-ID: <20240912012550.13748-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the word "aren't" to "isn't" based on singular word "bufferage".

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/netfs_library.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4cc657d743f7..f0d2cb257bb8 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -116,7 +116,7 @@ The following services are provided:
  * Handle local caching, allowing cached data and server-read data to be
    interleaved for a single request.
 
- * Handle clearing of bufferage that aren't on the server.
+ * Handle clearing of bufferage that isn't on the server.
 
  * Handle retrying of reads that failed, switching reads from the cache to the
    server as necessary.
-- 
2.46.0


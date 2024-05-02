Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574611C65E3
	for <netfs@lists.linux.dev>; Thu,  2 May 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685221; cv=none; b=C36mLnT4BGMyRQDBD8r89w/19Zi7EgGoY2M9lYnJAI3MX5Vs9UpIdLyMVJTfbuErVnA0cLI5Fw+zCQ1ElYa6GxG76clKfLZa9Ent43ZXkyQf+wMKSVN0yTWuFpdkspi5Cwr2XojI65yW92BKYdhZtLxkzqJ8bbW7FhC1QkD8vVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685221; c=relaxed/simple;
	bh=ai0A+jvOaoWTjJ8XMXQPgpwOrGyUp9q+UPbAaXoatbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ngq/Cdv3+aWuN5YU/fs/2H3AUREtYFlMoo/XYmkgdx/iQ4bbVCuLFC29H6ebIm0O+1m8rQeJwd+r97cRmZAA6wAWpk7cz7qhhvQBunRWl9CTqjxW9n7XyKFjpOVdVj+XmjchuzJGcekCdteU8inCLjtGsfhQAIZpHiWwcoWBE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=WuNBu58Z; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="WuNBu58Z"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a7d4466bso975007366b.2
        for <netfs@lists.linux.dev>; Thu, 02 May 2024 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685219; x=1715290019; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=WuNBu58Zn5YgC5TgjFhButBMn9XHnTlHPkiXGpvtZiudlGndrW4oEz5yw7U6jqzqB9
         18QrQ9VPUXlf74O80UBQaEVIRSWpELIgW3a85ddnE+9OKuW2fSsnyF26CisxB54O1tev
         ZjfW6ZWObtEpvacZk7YAE4YpDorCbEuazfLcaYuZRO/XREgEl0yaCcnPSjLlqqZB4TFo
         LxQH8UsSBuTKqgRbHNfHHenHZ9B78zmjMhwzvBX3Y+JXtBYOBGssKGIQxcNm5VH3hZxc
         oNCRqAJzaaRuC1I9tDJ2Eem/odehiXq4Dc7cO7xTZRf15O6lamknfPqoVs+VxZzUans7
         GnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685219; x=1715290019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=d7rlO8NH6uJ9hPPe0r2a/js4BXCrlbwb8phh6Da5epEZ1L7kYrqJyUDTcR8ytFu6R5
         HzNi7TVJklRLD4B4MxOfZKL4ID7U7QD7ocOpthMQ2c4yrK0d/no+w9jtjIRfz11LdbQR
         66g6r2Somdu7YkzR7YDchGn4cjGsppK8LwD1FngVV4tJxd2mt4sWQnJ0SLMk+aphuQq8
         d1HgLv3LLfWvvR+hkRChiuF1Xp6xA1W7kU2qhN8+LEeHKQ2yaV5Pomfe4gwGqQI+9q1q
         Cp1aerJLtzEDUIK33MOT+zYm1NhZpxVR/0kz2VGqhurMi+LhYYL3fAYCAeja4I/QYFnh
         NLPg==
X-Forwarded-Encrypted: i=1; AJvYcCUa4+jk/2CwHoqLEL4Jp3bLFjcFyvgD+YO9anR50vqlId2Vr9FWVaGNso1TAkTS1j65UmGPr4x5Kdd/i99tGW61MGppIXI=
X-Gm-Message-State: AOJu0YyOBv+Yw774vunPv/SLU5WB+bVunIGkHR4mRDHTCicts3ynj47Y
	AxT2p6gtNoQZsnZ3QHCqMHDSANWLc0zXCVKIZZ0w77FW4qgfoB9mqPhVUEBWutI=
X-Google-Smtp-Source: AGHT+IErvofVOlcBRqerAxB7KV24lTnlqlYfvQ1PtbkRzl2rNuYMLblHiMHF3fUAnpQqQn7VMD23ZA==
X-Received: by 2002:a17:906:8314:b0:a58:a1e3:a2cd with SMTP id j20-20020a170906831400b00a58a1e3a2cdmr379328ejx.55.1714685218619;
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 2/4] fscache: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:29 +0200
Message-ID: <20240502212631.110175-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 43a651ed8264..7b1ad224956c 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.44.0


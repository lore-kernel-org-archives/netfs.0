Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434142F46
	for <netfs@lists.linux.dev>; Sun, 26 May 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758502; cv=none; b=VgaBTwG3J4lvSpz4gTtRe2NNWpyQrL91weohVGfS/I3Fxs/UAbdv6wc5sTh3hAE8ALCVZQjrLRp/YrQHRSYKG1rSgl3PRkPN24aKq4gI/hn0sluvqIN55a2vUO9+7thr0Ii/bRm5nHKvOQCuuPeoMhAkr1JKM5Gp3/hvVxZmxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758502; c=relaxed/simple;
	bh=h07742SfbAhVzUh56nb4wWh/jm6ZTEc0nPN1Utkt790=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJVatkLaNPNlwegtiFPWbNw0nzde8xhI2kkB/FjCZ2dNXZbR9zfLU7p2k8Z02PqQbcsq3HQ6BVT3fy3QvdSSc/8g0VKmnwcIyNqsYbFyzfIZuY89ewtES06HLeZW32Dmas0KlG0ckHlRWvc6lwQbT+n8Viqn8tYcyyl/73qZM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=WEFOsmI8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="WEFOsmI8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421087b6f3fso21273345e9.1
        for <netfs@lists.linux.dev>; Sun, 26 May 2024 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758497; x=1717363297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=WEFOsmI8AxI2/R/77NfwEM68ayc8FolpqBXRxMHKhUZEIbxaS5S2CKIzfjTMpcQjl4
         M7mKoKhBE8aZ5SaHytITkAfwL0SPMKvLxvbtpUpNe25EA2CWjjvSLUA7bki59esy/ctv
         L2whl3HhT4MA/XVH0t/uN/t1RB6A/Qjdt3+27BfLpzIX2hriXySR5r62Q9qVSLPSroj9
         Qy+tZE3Cg3hY56A7QF8OqbibQxQBmRnbMO+Dx2FYZFjJJ9kZnywIp62CXNGZlc+w3lIU
         HaPVbaNdQHRPMonLodAX9Dou0kZCTkjHJIJ69XQYC4vSLB39yfDbJNzyn+LVoFNEcdNc
         z/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758497; x=1717363297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=HY1CyRFHVWpZn87Zbe4xKyn3Nqwwjbau4s+zM//F5kZlNCSgvxLrdoTwBosXFK42VM
         IWwBhMmQD2Yem1VTI/QTSdHlt+trv9wc6HCc6qKeEC2UtwdOVjjNRn4t08bSpSCLFgBC
         jlux6gN8yx3YtlLlCzLf39in8Y2EOghWnCzeuCwH47tICO0ZaqUOE5znRQ7QIPUJ8e2d
         5WmgGuKB0fH2QUC8tKVogcFNpVy1flEvpOO/Ga8t05YhA/fpUND1PfEvj4LnG0fC472b
         ce/puaD+VSlqFv8SC8Lepx6vZ4lTbN71CIuZu47b1WER1htEFog8zUMQxkbhgi0HFzdb
         MuKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjGtyccfgBf54miLKKwPytLKS357YH7sE31LHsanpLTrblbUI7gGoAPs1UPc4Ec2JxzmwyQKtguBVIqAYYh1fBcw1u4Tg=
X-Gm-Message-State: AOJu0YzUCB43VKni8clST0suYn+oiUE+Tn981CwPGwFNVqgIyZq9Wx5G
	3FprJeW93+HVb96ZB5qY/rn+XEagyHQgGD54L+yal+fm/fYBAE0LAJmL9yUk3Zc=
X-Google-Smtp-Source: AGHT+IHW4ae7lxNWn2WaLCNzfX0cTLfvfU9RcG3UisSM/eMD5CFFw81oCKu+GmqWICgbek/bKosQUg==
X-Received: by 2002:a05:600c:6a93:b0:41b:f359:2b53 with SMTP id 5b1f17b1804b1-42108a14eaemr57525155e9.37.1716758497510;
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccf32sm87534245e9.48.2024.05.26.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: amir73il@gmail.com,
	bhe@redhat.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	vgoyal@redhat.com
Subject: [RESEND PATCH 2/4] fscache: Remove duplicate included header
Date: Sun, 26 May 2024 23:21:09 +0200
Message-ID: <20240526212108.1462-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240502212631.110175-2-thorsten.blum@toblux.com>
References: <20240502212631.110175-2-thorsten.blum@toblux.com>
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
index 38637e5c9b57..b1722a82c03d 100644
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
2.45.1


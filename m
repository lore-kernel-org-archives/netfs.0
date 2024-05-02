Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F2181317
	for <netfs@lists.linux.dev>; Thu,  2 May 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685219; cv=none; b=MAXOfpPG+DYiKgE02uOHunOmQ1eJZmrmfvHj8x+XQlVdLSaH7e4U+a0CN8rOvgSWW3pfy/uVzqiqiL137LKXRBUtH2JilhnZX7GXv44dB9AsCEFbbI1NichojwemB91XW5eELVzq+FxULeMtfBchU4xn/Gy5RK9h2xtWisQUuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685219; c=relaxed/simple;
	bh=tVWXNCzdMWLdqo6Ilri79iJRAhyTbQmQeAhLhhvAFyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1uAVDfXzOe90feFum3LYMLVuQUd3sm6U3KGMNvpA2Hytu+moZO05XOC7BhxV9uC4eNMGvTxzEYuqZpoxX/HenjZW5TlREFakrxoIPguSWpqALPNaIYhk7ErS6UGhs6c+szJhr++UKSwrcyC+yspbvx+3eaQLslP66cKcGZjfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Hm2rZ8r9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Hm2rZ8r9"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso1232264e87.2
        for <netfs@lists.linux.dev>; Thu, 02 May 2024 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685215; x=1715290015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=Hm2rZ8r9+vid64/0+reeFww3nLmUKtWo58X6orFFdgXb0c1cPldsG4rODlNC5Clya2
         cl2yeYMsAWGUQT2KImlZGgefgR8diW/NW0g24z/QVDpYQCrp4dgpwd3nGFK+l8iNnbMi
         yc4jrh8xvLfnclVHzsLL5dX49zjb7BmpeobsAfb8Ai9zjsqaNHzSI3t7iQ7NGBYHQPtB
         udBYwtnTxuS2AyhNY40orLwaxX3cRhuR/KMDQsLsr3DZT+6sg0U3BpqhwhBDiqVzJW5r
         6KKltqQkKhuRlX5RqrYIoQDy7JwYToJ08kYWwX5N79VytyEhOjZScduna9O6PZ/eOGAF
         nmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685215; x=1715290015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=YkwUk0uqI9guc/lhvZCMYogGcCNIeKfdx32IKGLcLb4+xmq2uON+2+zsR9CHCH57sb
         NSH2DZovKYnAQu9CiwHwhi8yqp1PLJm6ygPcbXBLycgJXa91VnwAS2rsaJfEkxGBm1wR
         BaXNtKkBj6M2gdyxNQmRRVCeouQYdlcDJHkH83yJmhYmHcCgHd3QgBrh2XfgT0q1/t1H
         xaH1sMWteXXWxe+3O6v5SWgKPKNl6ZfmCjJBdNLYJx8a8hcCg/fMCZL1AqKOCmB3Knki
         mKcRTSqBV4Sb3XbE0P+xHFJZJg7IoKeUR153srSvS1RtKXVfwL2K26b3XB7ExKKSItoU
         KW3A==
X-Forwarded-Encrypted: i=1; AJvYcCXqELkV9dXNEfVkvc1AD9XL5F9bvjbK2c40nGJmbUC800cZet8tALPZh3rA8ZPFucg3Nb5JshZ7SKPSNmRk2leoCne8jMY=
X-Gm-Message-State: AOJu0YzPDsm3kcPqN8IvAoG1Y7M3rjnhPqR5goyRnTo3WUKqqO4FZxCv
	de1SWfWUDgy9/7vfvKlY5PkX4fFxsGg1Q2MuaXFKimvj+vwBJDpCg7EsjpZYujs=
X-Google-Smtp-Source: AGHT+IFdU+CNhHsbaoct4Qy+KcY+OUDNYVYuy7Zm5gtsIUrtGa9LNDfgRLHazZskYH9L85fevDVJpg==
X-Received: by 2002:a05:6512:3144:b0:51b:e42c:2ec4 with SMTP id s4-20020a056512314400b0051be42c2ec4mr584685lfi.24.1714685214745;
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
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
Subject: [PATCH 1/4] btrfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:28 +0200
Message-ID: <20240502212631.110175-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/blkdev.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 93f5c57ea4e3..5f7ad90fd682 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -9,7 +9,6 @@
 #include <linux/compiler.h>
 #include <linux/math.h>
 #include <linux/atomic.h>
-#include <linux/blkdev.h>
 #include <linux/percpu_counter.h>
 #include <linux/completion.h>
 #include <linux/lockdep.h>
-- 
2.44.0


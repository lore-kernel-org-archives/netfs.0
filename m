Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7E1C688E
	for <netfs@lists.linux.dev>; Thu,  2 May 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685226; cv=none; b=XoCED5tLDv0vpsMw1qEgx2EekJxKM9fkAr3XRkMMzuwCra/4oX2fJtzpe3O6lBtsd5LhYe4+EIIsicP02yC30/rnbosakothJvfvAz7/vRom/gom2OsXkSzkxhdX2Ipty4Ybw/bDqS0zd+tZ0TdhxcuBYXj7GyaauzMvNeev1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685226; c=relaxed/simple;
	bh=hLVGXgVE5ObK0tQ9rz0YC8wUaiOnh/HqizcBkXbeCvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+286nshPYO4ayC1tkgVZqPQXf7nLZ2rsoUXQVj676ZVRaQtKMLX8YhGtA09NLxliqOmHlyQ5spt4Ha5+0CItcUOYeRXPJoHrgcLsg9EC3YrPtN5ap3l+07b5BdCuZClu1IZGMP4Fa1rVzXWThda9c2ZuazFqbA8FR/jj3t75Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=0l9n5KG0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="0l9n5KG0"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a598e483ad1so10350366b.1
        for <netfs@lists.linux.dev>; Thu, 02 May 2024 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685223; x=1715290023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK+Nr9GDbKVe99LdxHOspcXdSuPveINKp7xXqjsO2YU=;
        b=0l9n5KG0YnpJw/elC+L78BNJVSWHo27uQ8CEfkSIRAbhewBIKnp/ohxitZqcTxJFp1
         kDCxfVcL7kywQDjV9xmxK/k5vZ3yJlCHP/hDHLQzRLwfDKHRuCH8S+9R1fVRkEPKRgso
         RHf6PC93oatKx1VFzGY9zwsJvLCgFNJFL3CyX8ePBAo+QHUBuayVUI7K3gdfeDyyLlTt
         fakL7UjpvIwLjJvSo0ULDlWJUTqadHFIzirYz8bIF2LnZOR0HePcJOz7EE/0/1om8+du
         XrzpVr5XEY0i+bP3kDvA4aGLoHB85Wa0u8y9lufaey57RU5tksvDLV/S1lUq6XNR6Lc5
         7NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685223; x=1715290023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK+Nr9GDbKVe99LdxHOspcXdSuPveINKp7xXqjsO2YU=;
        b=T6PdVUQK+ZT/c/WxKJAEavW+nQ8eZMrzWNBhvr7V+ySkG1QvhUZ5q1pSfvCzrvS+n8
         tPPLp9WOC8mfV0mXvWPFqbz2Mtf3nZMJnDFnhwkD+Xu2+k5fKTf4mNKkWTuJQD7WopAm
         dmiXJ3yffe5Ie/huswIX0PVHVZbsU3rw8bJFQzNo/3/TjCNoMwo5ZtHUP6ez+lU6Y4wS
         SBowEcnhJ1CUvfIpPtb1wGO9rBdFzejnQF1vb2uQc16ve5FRXO31Rrnlw9xzYKLjqvic
         xJGn7tu0eZhM5/eL2ad3SNyg2cmXOt6a/9rG29ZkdLUcqaADktyTslzoJaqIxHWRneCX
         Ibnw==
X-Forwarded-Encrypted: i=1; AJvYcCU+PBuGdeBic+nwZltZBx6RBH04aZOXj+LCWaCBrVeK3xA7UeCfyseVfiighqVm0ia3bJ3C8Qpr4O01N/zszHTMq5UHHrA=
X-Gm-Message-State: AOJu0YzvuiYbnS0qWBoypGjQgMTHCO3Pnj+pKSNEJTKZ5R/gU8RTocqM
	PxGY+6UztWk0ZMGu54pPZfO4VHAzPptPmJFoPertrBz33VO/elWkvp03sfoUjXo=
X-Google-Smtp-Source: AGHT+IHBzotw8Ke7fIjVdKa5ibyRzh+WvB5Y+2scCGw1BD2igSpBC2Pxgr1SRQKeUwy8LwjKiKAuPw==
X-Received: by 2002:a17:906:c083:b0:a55:b99d:74a7 with SMTP id f3-20020a170906c08300b00a55b99d74a7mr364245ejz.11.1714685223722;
        Thu, 02 May 2024 14:27:03 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:27:03 -0700 (PDT)
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
Subject: [PATCH 4/4] crash: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:31 +0200
Message-ID: <20240502212631.110175-4-thorsten.blum@toblux.com>
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

Remove duplicate included header file linux/kexec.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 066668799f75..c460e687edd6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.44.0


Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D012F373
	for <netfs@lists.linux.dev>; Mon,  3 Jun 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439052; cv=none; b=IWKB1ZQYqyewki/x4DeeGB6GXczedOrY891h28teoGtoUDK0BfFrfMljRHC36H8BDeZsLsFJKQLGl1uYsOeLlE/VLirKQJQTkUK1z3IByy2GR3w+VSUGGzO5jM0rexewJpRZwSDa976NluU48LXulBP2Hu2CPo2/jT3kdJ406ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439052; c=relaxed/simple;
	bh=hDcknhcOYWbRk6WkT26dnpu/5uKCkV7h6LNO0ijMspA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pi8N37wEVelnQND3jYO4I/yueTob6g8028gQHWC93gnakvSvvzizLtJhGpk8EFUuQ/SiZRjX+F1mZ9QOW7iELS3zwd5Cw29wJnMX0hRPwtDWaXyALCXyXAqkP53113kbIyNY4Bu0VRsK0zpu6uIEXQ04ExZuz2UxteDF0xD9ykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBbGqo2t; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBbGqo2t"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ba5681b724so416096eaf.1
        for <netfs@lists.linux.dev>; Mon, 03 Jun 2024 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717439050; x=1718043850; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5EI4ejkvsKs4g2VYFTyDLmFa3QzZwi5NQWive6oeaWA=;
        b=eBbGqo2tYYtOxbEe9ZGPe64/5OhhYdKPKcCV8Yp9Jjq/3QWN/wDVS3473CCGyNSZjv
         qDTlo3R+sV3RTYb+8koDWr7wjqML01DeNovBkiHu3az1hCg+FZ9ef51v17ZJ1/GR11pB
         BjZmTcZocKYjpJ/C86fn1FXXCqdyX2HtrMdzcopnkTWV1/Pl5N5cj7ibNwwFxaoGB+0E
         NHOoTpXOMkQYacFFfK/rjuPkoPgfhV6mGyWm9I6WI0mCu/7B0qs00VoBuxrYsDuI3Ie1
         CKXU2Uh/XgVJqT7Xc2GWVOqs/XwS+U2nDkmTPSXyVgKFLsGdMFJfc/1SuYNm7uBPHdpu
         uy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717439050; x=1718043850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EI4ejkvsKs4g2VYFTyDLmFa3QzZwi5NQWive6oeaWA=;
        b=UyI+6fkLbOA3VfXHkGoeU+93d1s7g/aJ/8CsAyw7ZBgP3zOGezAvulckpKMk9CNui5
         9YDwpkBUo90ULRjOCCVzTKEgXjdMAMJ3Ja1S6mzZlovZYnfPkeZXyzxR6T3HicnwyHY1
         mjtVyIDsRzTbhG1bGB9Nh+ZQUXzt/BOthugsXhrj4w6WUjSOs7BXn2I+PImg+gonlK2k
         587jaA09nrw8TO0G8Tnpr3t86jNNvMuAM2IBzeHyTma/myqPvKmg68czHgdbtggL97jZ
         fBV0UBigJ1st1YBdPRgvGZyiQ7ZC+gvNgJUJa2CsVCfR9UUwTj2yJxMLZBfuwK8B1NPa
         iaXw==
X-Forwarded-Encrypted: i=1; AJvYcCVZkoSqDiHJs1jsAqlmgxwLSjpWKJ+AiDshakAGJ6OBx4suBiymAp0b8shdnlrUdmv2j0ghXv0rRBVgzxMg4ERk2o1rTBo=
X-Gm-Message-State: AOJu0YxY+dZiqAFVj7M3Uy4Un2uwTJJ70gQuCwBneCLXnJJYrT0U2cUl
	Jh8b0xKUV2dp9V3HIsG1Ic/n/gBAKGz4h1d1FDX/0MvkhDtcsCGL
X-Google-Smtp-Source: AGHT+IF/PMhSgjeWGpH+lwhjVNWk5wZqk+U9pM49w8GWSnAmdfw1UbZDr9/cU2rHjJbRKm8oEEESpQ==
X-Received: by 2002:a05:6358:f44:b0:183:612d:44a1 with SMTP id e5c5f4694b2df-19b490c54bamr1072290955d.28.1717439049552;
        Mon, 03 Jun 2024 11:24:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:3c:9322:2d09:c2c:3b62:755a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm5075892a12.85.2024.06.03.11.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:24:09 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	av2082000@gmail.com
Subject: [PATCH] netfs: Fix documentation comment for netfs_wait_for_outstanding_io()
Date: Mon,  3 Jun 2024 23:53:56 +0530
Message-Id: <20240603182356.11682-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the parameter name in the documentation comment of the
netfs_wait_for_outstanding_io() to match the actual function parameter.
This change ensures that the kernel-doc tool can generate accurate
documentation and eliminates any warnings related to parameter mismatches.

kernel-doc warning:
  ./include/linux/netfs.h:532: warning: Function parameter or struct member 'inode' not described in 'netfs_wait_for_outstanding_io'
  ./include/linux/netfs.h:532: warning: Excess function parameter 'ctx' description in 'netfs_wait_for_outstanding_io'

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 include/linux/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 3ca3906bb8da..5d0288938cc2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -521,7 +521,7 @@ static inline struct fscache_cookie *netfs_i_cookie(struct netfs_inode *ctx)
 
 /**
  * netfs_wait_for_outstanding_io - Wait for outstanding I/O to complete
- * @ctx: The netfs inode to wait on
+ * @inode: The netfs inode to wait on
  *
  * Wait for outstanding I/O requests of any type to complete.  This is intended
  * to be called from inode eviction routines.  This makes sure that any
-- 
2.25.1


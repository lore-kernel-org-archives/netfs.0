Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9264D
	for <netfs@lists.linux.dev>; Sat, 21 Sep 2024 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726881190; cv=none; b=svSD+whig0xIPvQj7TPuFYF/rgg37XBzB05Eww5x1aaLdTzLPObVvTJ6aoXnHHJLLRNXm+a8piqNizGOe3nXSh/QpZPM44+Qrd2sAF92tR4OFjfmt9bCjT3GlZFU6HXGClM+bwfdDnXxWgSzUW6S+VKhEyizkjAfpNwl+VovxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726881190; c=relaxed/simple;
	bh=ApJBXp8aU52y3hgoyxSgPpJcY20lFPBpYtQwSED9mO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tE4Hq9YRu34aBSGZzZmUqc9it06V2Ebh7k8JgoRqwnRIBCcwMQdgcsID8REcCA3Ut1fq4+5beiyuKQBKixd9/XSCb+rSWxeNorFoELd1USAZ6P4IR+gkik6lGCYfztoRuQuZXtBKuTRY7Wl4nhCcDhX3dhjIrHWtPIkHvmogdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpdCQ/xN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpdCQ/xN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2054e22ce3fso27016545ad.2
        for <netfs@lists.linux.dev>; Fri, 20 Sep 2024 18:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726881188; x=1727485988; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhWTpLUtCJ0kiQ1X7/HJbn73e+6H15QHc9kTJn9s/H8=;
        b=EpdCQ/xNuNiHzPXdoBF40qgEb96XupJwu1q4XRUomOJ/qLCXrhUKq0uxbJt/9liJ5Q
         ZWLr6TVCPNccuB718dpROeoPp/1cd55UESdFA9BApwYYAv7Hf5dsDTVPc7TCzu7FgGWd
         LyNNuciVjj4Nh0/12hu82o7Ep/GbcRGnzkMwbPlOfuWsPpmhEFNjofVtu8M7ErtgAb4k
         WZkEwWvMn+5gH3mo2iODJB/+dgt7aBCvyYkPd5Y2+VV8E7+ky/vZJs9ergPP54YeBJXl
         xtC5VLV1idagjqDBlb4QAdPe4p5upNoZZc/0Jglr9j/pjXax2uWI7g3BH3h+tm61FoWW
         AXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726881188; x=1727485988;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhWTpLUtCJ0kiQ1X7/HJbn73e+6H15QHc9kTJn9s/H8=;
        b=VCYMZusB6vo+H77kywVChIPTRjSjiK9iOxnJUEIBkBQwLsRnhA0l6ah3CDfazJ2Py0
         mD+j6wOmFg/pabMFYy2vAK2v2P0Hed0cUBLjcBsxQQfoS/LNODLkKSaB6AEwOWywYC+A
         QEjrUI7eMCd9HI6eFt5ryBgUKHfH6ge/M8g6DCSC+dWIVQ3yh/wl1IoQjsuuxzV33iVi
         teYDxbIVsNfptkOayGpEiLVj4/Ge4E7GJuzvN7OFVoY/QwrcLFXUq/2t1mkXeDX//Ags
         tj5FxOiNVnqpODdZ0zfb9T4DRBqghHEXryZ40zmIqBz3sQpcea1l8XG+dHqQsanxi6i2
         7T+A==
X-Forwarded-Encrypted: i=1; AJvYcCU35bjQulHIXvVa3LSfHqqVqVHPYHhaV1xNTlzkoseD5jkOizAp3tB6ZEquJC5rftytdoCLjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfAVzNzy7DowigWrZlJzXKnbrN/NRzRNCcAuFccv3XoHmADG5I
	WdGuKGL1Qx1NJ5ZxRZk0aKIoimxaTnS/MtBM0jV2GSJeXSWKOoJT
X-Google-Smtp-Source: AGHT+IFb/4FuUoDCmoFChGv5caoTFoY7jrMIDatYtcYptR4hgzZ4J7g/uEd8146atPwtf85TrjOdYA==
X-Received: by 2002:a17:902:e54e:b0:205:894b:b5b0 with SMTP id d9443c01a7336-208d83a1cabmr71344795ad.33.1726881187970;
        Fri, 20 Sep 2024 18:13:07 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da7b8sm100732825ad.16.2024.09.20.18.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 18:13:07 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:13:05 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcus.yu.56@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Message-ID: <Zu4doSKzXfSuVipQ@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use kzalloc instead of kmalloc in netfs_buffer_append_folio to fix
a KMSAN uninit-value error in netfs_clear_buffer

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
---
 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 0ad0982ce0e2..6f967b6d30b6 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -22,7 +22,7 @@ int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio
 		return -EIO;
 
 	if (!tail || folioq_full(tail)) {
-		tail = kmalloc(sizeof(*tail), GFP_NOFS);
+		tail = kzalloc(sizeof(*tail), GFP_NOFS);
 		if (!tail)
 			return -ENOMEM;
 		netfs_stat(&netfs_n_folioq);
-- 
2.46.0


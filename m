Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AD1C6604
	for <netfs@lists.linux.dev>; Thu,  2 May 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685225; cv=none; b=FylP0nCPuGuFZjMXgXJH3EZz5gC0kkLT6A1+P4AD9qJXD9gDU8c5ge7sNwGI+O09VIcrBkkMTVMvwx1OqQetYH5sqAu9hlwfV9fJtkneIWVJuUEeu5W2OBkE1kLLAJ2sPNcXs5jPncOJ3RcwYyB3vav33OTAuouCoWZrqaFw1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685225; c=relaxed/simple;
	bh=FTwV9FJr3GNOMfmr7/ZF3Ka+WKG890demF0+p3F69iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgTx54Id0pDcdB61nJFGjz5z9DHJcwUaeXRu4dqDCJFXACqTP1YOS3OWpl99K9pWoWWgCALWIQs9bRa/J9FMlwTqo594pvo1xouIvH/0xxL5C9OfpKpCXowSudYKxdY7Htn9eN4YoL9EazLNYLZ9hfo+npRHhfurpX83JJM8Q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=zcuL0BPi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="zcuL0BPi"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a598c8661f0so20447566b.0
        for <netfs@lists.linux.dev>; Thu, 02 May 2024 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685221; x=1715290021; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=zcuL0BPi0hXHMaykbF96VPVT1+gdbn5Xnwq/OGN/D2y1qrZlRZXYr+1ik/vf7qLodT
         nC0iRiUvRCQxNxvzXCU2+E9RZAc0so+T8vD97I+bkEhZWLZaF9ejQiFHMOawdt9n8OYu
         uNO5z7YeVbcmlpTUgSf/mPcInbq7VwGxgUr96pTeZR5r2KKo7JJJgSK/zYx1DFBV9ksh
         TrceANf52GC0Xsp/pWWWiNoEjPVO2VdLL38QwEc7Ky4hwrCn0EUdBKBDA3PyHPgX0UVM
         RmUb5WrgmG6RED3geggnH1Yyz6B6HpRtUNBrjmAbanKIohJzIuXBUebINxzNQadwaGUy
         Bvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685221; x=1715290021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=FJMojS7SszVMucihoCHMTO3JkhVBdGfrTlkF13Kj28tWpCr2ZLUmxwZtAm8DSXCOKc
         NjPs1chd5HakeRuM7PyfOUWZcPnEnTGjZJidudtngQI6ODmjqFmZpIy8oOgP1mbrLgKT
         J86Ae8B2YKa8/g2+qhPfNZhJhV34SiVTu1ZNxaiD/dVcXQmTj+HXDa0PB3BpHSkQaOu3
         CSxBI+1hjW7Ai74U1CIepAI3nGF9pEsNENhUzIKhLzrE3grS+6YM6lU/Rbm45Dr/BBuo
         XkLCbc+nVj8QXDq790hKW3e8dz6DCIs0uOTEtkYiEloR+biCOpsuLIa3CSyXVdHIgEv2
         Ko7A==
X-Forwarded-Encrypted: i=1; AJvYcCXxdHqUX6pUyyvgR47k1zDi43Bt2jKKRj0h3yhW18taQ/mcHX+K5v3/TyzF4yirDrs0uoW8kT8crzCHrzCPL5jJBG/iwPc=
X-Gm-Message-State: AOJu0Yx93KDRyA/isCPyPkk9ElyWdKJD3Wct4TWoLy1moJg50WYCSjuA
	vGqCo0E2XGUzeM4pQqFEzTi616cvP4WeDb/caapV62yBLh15/naHvl7a/ChmOHo=
X-Google-Smtp-Source: AGHT+IHsnl7RJpj3ymJ81i/nNwARVNtUdevH3erTDDDAwNmlYmS3UuIDG1Pd4ArMQB2iLnX4wSe1VA==
X-Received: by 2002:a17:906:fcb3:b0:a55:5ba7:288a with SMTP id qw19-20020a170906fcb300b00a555ba7288amr430875ejb.33.1714685221271;
        Thu, 02 May 2024 14:27:01 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:27:00 -0700 (PDT)
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
Subject: [PATCH 3/4] overlayfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:30 +0200
Message-ID: <20240502212631.110175-3-thorsten.blum@toblux.com>
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

Remove duplicate included header file linux/posix_acl.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/overlayfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..35fd3e3e1778 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/xattr.h>
-#include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
-- 
2.44.0


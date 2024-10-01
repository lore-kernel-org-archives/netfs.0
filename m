Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D229CFE
	for <netfs@lists.linux.dev>; Tue,  1 Oct 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764316; cv=none; b=dUeJkfImKy9sCO+Q2QU6WYfp3swG2qCwiKfdoOjcNtc6T2G/F1gHX8Sc7jzJDcAOYBTEAwRpD29saycl1mWzH7BAWWL0U7VfDc+x7Ahhbn2YiuY/Dz8szzH6ZdhNZ/2BhcMAAfiZQHlCWBGQSQu4AqlMMskUWY3ffEyAM8VTL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764316; c=relaxed/simple;
	bh=V7IE8NHdwZvkG7MqnoCNEa+e9sLgurK9Qa5ui+9fzqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tW/i2eZfVuJlVI4BJmwjqGl4NU29iJAhq1bfj0Iwxt6q6GSYdNJ8P7ClmZO3+c4rbu74+VcliPIqfdqsC9PwSvtvXUjOxq8cm+NUBVWo3FfogPz2X0U6RE67U9QXKzcNM3fn/3S3aN/3j7PApba5bkIMsAYLeK/rYJVcxu21730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwneyrZd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwneyrZd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b49ee353cso34940485ad.2
        for <netfs@lists.linux.dev>; Mon, 30 Sep 2024 23:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727764315; x=1728369115; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ietMyAYw6+fPlNA9nxxGMDX+EjbWGZRBErvoQIibJ1M=;
        b=bwneyrZdexyLhUWl5rN29gklbnkYxIpyoEO60zIFlvXu0fHHc71z3h/FhQrh2IMmV7
         GC6gUhpASY5to4xJEM/qDgQagfZMcXjLkqEsrnvAzZzhCr3jnv4U/uUvmSxdmQ3cQSDi
         Q+xcwsrf5GV2gFWU7U3pmg6Ar4ZOtvn0I0nfySfIdu58SqwsvmqPgzmAeHhhzWFaLKrK
         n0ZwdA3U1sTkN/XU35Zr0M0fTzqQWU8R8eAJYyjwmUXPLoYVQBOMwrgR4/Zhzt9VWZSw
         yQ/97LLWXutWFqdWnYutt1Yv04jG16ov9djrT/ZawCMnSy/tsRinF8d0xCu+GRt4k4W2
         /7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764315; x=1728369115;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ietMyAYw6+fPlNA9nxxGMDX+EjbWGZRBErvoQIibJ1M=;
        b=wibmVOTagtyDePnz2suw0jCSCrDTi/DuPFawrLvpVmGg89E0i++e1mUeQf4VcMuFOC
         JRvC8z027jj4WMBZyLc36TMjkeIiGMNIJ4sT7kpU4TC0NTS0p0qyBjRNvjyuYftRX9Ct
         88MeD+Kps0wo9/TfTCewOBH12o6A0wzOAXIXABtWxPgLUKX+UGQMi25qZwrV4zHesQgL
         nlVdZnn++rtSmmDX5zwAwZIMsA5gCf/DZAgmLBfSzZUnTgd0t3GWVqYtT+tVtNq0iRqV
         UcE0OTT02d7nS5+bTC2M5BsW/BXRLEV2Dlxbc9TsMQnBFG03OjImFYoTSS/pFRirS/R9
         3cfg==
X-Forwarded-Encrypted: i=1; AJvYcCXhqc6mMYCbHhaz2eZltQYm13P7/ksSOwp1+ku4IfWQ/wcMWqFmSw42kbxpr3KL8XoFLsP5GQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBX6C52JfVq/F5jy8SGCqmOcpVChbWIGYWWVKLvVsUpnKB1LFy
	On0KJnZTUqPvj7aslpID0I8OPT4XxoNrVElxjMjgHFcZ7mc9XuYl
X-Google-Smtp-Source: AGHT+IHgLTXQFOm2nfas7td6RKKxViMS3TnkaZ/ETwRUZ8C4GfYVvBwNgF/ge/Jym6wTwcUXDwn93g==
X-Received: by 2002:a17:902:e743:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-20b37bdc6a4mr193337525ad.60.1727764314723;
        Mon, 30 Sep 2024 23:31:54 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4e632sm63809895ad.230.2024.09.30.23.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:31:54 -0700 (PDT)
Date: Mon, 30 Sep 2024 23:31:52 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, marcus.yu.56@gmail.com
Subject: [PATCH v2] netfs: Fix a KMSAN uninit-value error in
 netfs_clear_buffer
Message-ID: <ZvuXWC2bYpvQsWgS@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use folioq_count instead of folioq_nr_slots to fix a KMSAN uninit-value
error in netfs_clear_buffer

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
---
Changes since v2:
  - Use folioq_count when putting pointers. This avoids touching
    uninitialized pointer and is a deeper fix than just using
    kzalloc.

 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 63280791de3b..78fe5796b2b2 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -102,7 +102,7 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 
 	while ((p = rreq->buffer)) {
 		rreq->buffer = p->next;
-		for (int slot = 0; slot < folioq_nr_slots(p); slot++) {
+		for (int slot = 0; slot < folioq_count(p); slot++) {
 			struct folio *folio = folioq_folio(p, slot);
 			if (!folio)
 				continue;
-- 
2.46.2


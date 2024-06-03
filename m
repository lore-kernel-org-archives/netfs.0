Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EB374C3
	for <netfs@lists.linux.dev>; Mon,  3 Jun 2024 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395842; cv=none; b=Amor8vjTkl8OvHGnWkYeravQFa+yFHSLja3JqFB51tN31hOPMv7WNoojDA0e8YdeG9Wn8+xQFOdGoeHvxxsikH2T6iz2xMYxmwZwISzYtqxlnjGXccr4X5NQmMPO3hIx4eI6LzDpKeuUIT2zP5m6jcoBYOQtkccaaooozxvXNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395842; c=relaxed/simple;
	bh=lLu8LKo7XxtUrSy83Xf34urTJfq4u9txHi/JQrK1T6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBiniVpSHiJt4bUXVfrQ/x0ZylIb4DKQpkeb+PCFTPBk4is6BjjBTuxY9bXplZbUgZbSXR2737S4RNzbZ1+d9DBZYoNjevVTdx2ZgqTHwxgbPMHUTNeNd0bO5ZOgOM5CFqUXk1UyKyzKbJYeFgl0L5frpxIW61GyvilGe6khpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y/abDZqS; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y/abDZqS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717395831; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RJvBTmOHwBqSadSu7zhGvazryslaykXfzim0ANksWbc=;
	b=Y/abDZqSdB4+FDyOeFbGpC0v5rqZkT/P8Lalk3pQPVxMVY8AWWfMxcsDhNqCCSHv2yPYncSag7kIAy8Hkvk+13UrCEZky+LD2J+aTWaeWzhPmjPSvaeQkS3BoFbxK7yt0VzSc1Ey36jDYqoPQTefYL8QhLzNJKGXD5S4gn/z6dw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W7j3vbx_1717395826;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7j3vbx_1717395826)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 14:23:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>,
	netfs@lists.linux.dev,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] cachefiles: remove unneeded include of <linux/fdtable.h>
Date: Mon,  3 Jun 2024 14:23:44 +0800
Message-Id: <20240603062344.818290-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240603034055.GI1629371@ZenIV>
References: <20240603034055.GI1629371@ZenIV>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

close_fd() has been killed, let's get rid of unneeded
<linux/fdtable.h> as Al Viro pointed out [1].

[1] https://lore.kernel.org/r/20240603034055.GI1629371@ZenIV
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Christian,
If it's possible, please kindly also help pick this
patch along with the original patchset..
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.fixes&id=a82c13d29985a4d99dacd700b497f0c062fe3625

Thanks,
Gao Xiang


 fs/cachefiles/ondemand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 58bd80956c5a..bce005f2b456 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-#include <linux/fdtable.h>
 #include <linux/anon_inodes.h>
 #include <linux/uio.h>
 #include "internal.h"
-- 
2.39.3


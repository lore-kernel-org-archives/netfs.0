Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459D2571B1
	for <netfs@lists.linux.dev>; Tue, 25 Mar 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907550; cv=none; b=hNxKZhT1QKwGud1U39BVbCuDKthOFYyjFoHckpNbtWXF22NR6aB25U8lPkwPJFTy6qZamYM4N/BnS+dAMryueO6q/a1eghL+iqA6GvyRlhkbu6cpr5vGO9iw2HncNr+yecRsU4AGU5Ax+/+CL4Pwm/eYrtyXwYe/cTvySosp3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907550; c=relaxed/simple;
	bh=/18HFftOLwQrGyFb3oNTkE9/ks2x+n9TTh+JNKcZMNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDZNXnRJEKDcz9nSOnSbWWENyDEpUY5jkQC/WpnlAGtsV+vc8jGssLYNag4oghBmISSN8J8tqW/dTLf7SenLUrXs9yjmD1hkmOyZ5dp/holutuQwEngLODwym0t0voB7KE2egl5trTNZwcBaowRpLX+LfPqb5WO8f2dPo1zh1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c546334bdeso436898985a.2
        for <netfs@lists.linux.dev>; Tue, 25 Mar 2025 05:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907547; x=1743512347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gK08EjceD7oAoWgY2C5J6cFp6HN4HP7GKFOgnyXyuQ=;
        b=a0IjEmX2aAvARkb2OmfuYp/VquboibhO6fY2EkRpwmZeXVhAX09nj6rPI7X8Mu8BM2
         0VDq7BbDWzWEqzjCGq1JbiAhIdaYUnaKcWNEB4czzfJ9GYO3kY7Kl/2/OpUsNNbIh81U
         6NneJS0V9dJXU+HfYuOAuS/liof418frhxkbgoRvPQbUy31FCI0y9hNN93UlYvK0V4Hh
         XI+zVqor22mXy5pMqSvQjhrOa4mBZ5/GupUXbaVBIA+gHuFuXAFWAVWowKnlquzKMLix
         E9JKSy9kV0ftmmFIhIj/YdntqUcf7RFz1g8kHXby5X8XOYiHp4fAMQvM3SmIg9VdbKUR
         10bA==
X-Gm-Message-State: AOJu0YzWX8AQqYM3XgHk4Edl+cPp/FjINoUReA0YSLznAP65USvvKPcC
	xCWPJleeNbtVtEarN/ovd464wBPF1a6FQT9qGR1Ds1TMCf09l9Vm
X-Gm-Gg: ASbGncsVMUwrvKSsFTz3BWn8D9QroNDbDK/dhv2ErETMj01txrMitg+5vNwrFHfvL2P
	wMmeA1aAR0Urzn/dHCFz2ZGoUsQ4eFaRKAhvCfl5yOKUhx/Um4iPuirgxHqEiQoCMg4kf2z3zWL
	51Yde3xMpb7eyPGIq1eedMqr14bUoV2+tyFSOZ75WkA7509Js4sw7w4QEvQzFKnMDrDJOvgB87i
	WQKVaOBIyz5TOUMxtlZCgYq4pWORi1WMnWiYucpzjaiiWD+mc8NJGaxJWFl4INaZQkSL5b6GkDI
	GrjZgTzotQc40bNyvM04O8QjQlnk0X4zqwruqFyeBOwovo8fA2kDOyS16q9pl66XtaB37T0kOhv
	dPjc43Zx/wyP4hqhyP33Ttc1CS8kIIfVdatPB1nUqjit/vYk/AzGMsoii993OTvx2tNU=
X-Google-Smtp-Source: AGHT+IEc0G/1BKZQGl9iwoOgvjv5YcerHC5f++TxSA6f/6D0rL1vg40qxRFD+8GBxiCdj3WF6RDHRA==
X-Received: by 2002:a05:620a:560c:b0:7c5:4788:a14e with SMTP id af79cd13be357-7c5c80d4a5cmr1135160385a.39.1742907546954;
        Tue, 25 Mar 2025 05:59:06 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (hlfxns014qw-47-54-140-188.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.54.140.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935f1c1sm637360385a.117.2025.03.25.05.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:59:06 -0700 (PDT)
From: Marc Dionne <marc.dionne@auristor.com>
To: linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	NeilBrown <neilb@suse.de>
Cc: netfs@lists.linux.dev
Subject: [PATCH] cachefiles: Fix oops in vfs_mkdir from cachefiles_get_directory
Date: Tue, 25 Mar 2025 09:59:05 -0300
Message-ID: <20250325125905.395372-1-marc.dionne@auristor.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
changed cachefiles_get_directory, replacing "subdir" with a ERR_PTR
from the result of cachefiles_inject_write_error, which is either 0
or some error code.  This causes an oops when the resulting pointer
is passed to vfs_mkdir.

Use a similar pattern to what is used earlier in the function; replace
subdir with either the return value from vfs_mkdir, or the ERR_PTR
of the cachefiles_inject_write_error() return value, but only if it
is non zero.

Fixes: c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
cc: netfs@lists.linux.dev
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
---
 fs/cachefiles/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 83a60126de0f..14d0cc894000 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -128,10 +128,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = security_path_mkdir(&path, subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
-		subdir = ERR_PTR(cachefiles_inject_write_error());
-		if (!IS_ERR(subdir))
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
 			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
-		ret = PTR_ERR(subdir);
+		else
+			subdir = ERR_PTR(ret);
 		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
-- 
2.48.1


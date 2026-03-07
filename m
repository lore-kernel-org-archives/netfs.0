Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB561E7C23
	for <netfs@lists.linux.dev>; Sat,  7 Mar 2026 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858397; cv=none; b=J2G6+pwf+g6QF/WpoQtasOaGIjJaiUrIxJm3kJkqnKqxhuSrNmS1b349mH8sLtD7ChhckBNSClv9DHpPZnzL65lRd1ofbH84ebbcSpWPo8V4QBnEhUkYK8memcYB3GR7yGuNjWD8IWfmvZI4aLGp4In1oGwHI1WVtel6qIp/vPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858397; c=relaxed/simple;
	bh=4ATwsTz8ziLAyDuWlK4KdVZopPk0DA6HM2567HiDEEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Svf/Xd2riKs5Nk61g+lmUh9FYwqtyBM8mdz4gFLwOWCm5PlZI/eTFr5Dk4SrHF4putI4P/SAjHPNTmyqjCeEfIKO+6cZ7H+8GzLYy2hCv8jwVwg58Pg+iHkCc7dGEMyrsdDGnNBfTmHIBr7Tf8C1AudwDU53VOmw5v70bzOYkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huyfqGRL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huyfqGRL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso5093794a91.3
        for <netfs@lists.linux.dev>; Fri, 06 Mar 2026 20:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772858395; x=1773463195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=enfq5btaKGYj0ZOezkkWdQHPcpQw23/+zvd7oPjvhzg=;
        b=huyfqGRL+dH2yAFUomd5hnOF634rv+ukhm+9jrTKIauw3Zntl40nnqCNo4gwcaWgmI
         G6ioa4WzZPrcDLDs7zR6nsqaZVLhEUbOJN6kr3SGQZDV5niQMDXr+nkJObpmw1gwOEG2
         ZvTubdNkZR9gRX4+O9XllR4O1FAGpwI0bY8XTC1J9ebTmVXI37CNy0YaGGgk0+0bQo53
         NDohk6QHSY4pvwtazWQHalAzV5COfbBD1VLNRKpBdeOabrYu/WFifQIbFTMVwmAO40ki
         I1yGYwbNCX9bwZWrzBDOeq4MOguPjpfqNI6iFxnW1owgYv98HVW7oiFCyU2Puw/OOfTQ
         gnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772858395; x=1773463195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enfq5btaKGYj0ZOezkkWdQHPcpQw23/+zvd7oPjvhzg=;
        b=DKdcJRsUgy49CkD++spOwlQjf6tH0/zMoBkV11RAj33CBOAHu7ChpOu8ZwQhph2G2g
         ItEjrHEnrOmNDWPhLCzG4kZ6aPq7gKa5hWv9OwEwjJbEVFUVK/0P4iYKMgq9p27f84qn
         vs104XfYerVTNLIacCzGgzTHDgFXn2WocUnPUYgYPpKuXUcGZDpaEWhZV6VBZIXoNTVE
         PAjdT/HXFAcEa2UpDNzU4aq1+tVX+BX52doJ05mjZWopoXil42IXb48zS6KNzBvBjgxM
         GSDJwhcCg8lO4eswR+K+T5zuL4cE4sOdMhnWbaZKIJGeWVSs3BEGZkKNTwj3JtNeeAlw
         6MyQ==
X-Gm-Message-State: AOJu0Ywqi6GTS4FRuEIU1Q9mf3Y6Tv5TgtFaqgpZKUh75dCXUeaLaVgx
	Oo2FPytF+bg8AijY3QUpOxOS/QDZDJt3sx2wZTgp0PrIxeWly4wp3PsY
X-Gm-Gg: ATEYQzwgzB2buBlXe8LnvVrd1QcuZpR0OOorx66z8HJdUV3fnpYgdR3LAIUkMYey/zH
	3hYHsL1e0yxgsiwQWRfYkQVYBjDvJlQmSHts9O4hY9XOHJaI01+p9dlHvdHUwn4tNDf/VNASYhg
	odj5NthvIRnQnM5V9GXYDLMT8QnxrrQ8jIBw29weiJYHMTtCfuYGT8fj5xpIrDFKy0KUnTn0Aj1
	PFuRbvwKoDZX0WyLqLDaLB0K79Nynxq2CwrDNfJR9KtoAvCqqgye8QTLJlKjpGxKzLOyduMVfjQ
	K2UPVCSiFf9BEGwxEDg5kC4hwX6ymGJ4sRGxSqTR9K8BhrFqzJ5OwBYG1/hiXS3chhfHXckLjSv
	VVMu6svdUHSfodL8JPoD/dyQcHlhDV5X5L270dvNF9MCTLfSwxRchmhC1ULGmnYl0WhB4lBndoO
	Z4u07u2hpEk/6TgiIrR8Uc3/7ehTmWiMk7ouNBLehW5Cu8owoOup+hhkT+qn7tzXOXUoC9aARyF
	M+YjNA=
X-Received: by 2002:a17:90b:498b:b0:340:be44:dd11 with SMTP id 98e67ed59e1d1-359be3536a4mr4381767a91.27.1772858395271;
        Fri, 06 Mar 2026 20:39:55 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:4191:5f1c:7dc6:bad2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d38ab8sm6809244a91.1.2026.03.06.20.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 20:39:54 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: dhowells@redhat.com,
	pc@manguebit.org,
	brauner@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on retry
Date: Sat,  7 Mar 2026 10:09:47 +0530
Message-ID: <20260307043947.347092-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry path
in netfs_unbuffered_write() unconditionally calls stream->prepare_write()
without checking if it is NULL.

Filesystems such as 9P do not set the prepare_write operation, so
stream->prepare_write remains NULL. When get_user_pages() fails with
-EFAULT and the subrequest is flagged for retry, this results in a NULL
pointer dereference at fs/netfs/direct_write.c:189.

Fix this by mirroring the pattern already used in write_retry.c: if
stream->prepare_write is NULL, skip renegotiation and directly reissue
the subrequest via netfs_reissue_write(), which handles iterator reset,
IN_PROGRESS flag, stats update and reissue internally.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/netfs/direct_write.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index dd1451bf7543..4d9760e36c11 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -186,10 +186,18 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		stream->sreq_max_segs	= INT_MAX;
 
 		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-		stream->prepare_write(subreq);
 
-		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-		netfs_stat(&netfs_n_wh_retry_write_subreq);
+		if (stream->prepare_write) {
+			stream->prepare_write(subreq);
+			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+			netfs_stat(&netfs_n_wh_retry_write_subreq);
+		} else {
+			struct iov_iter source;
+
+			netfs_reset_iter(subreq);
+			source = subreq->io_iter;
+			netfs_reissue_write(stream, subreq, &source);
+		}
 	}
 
 	netfs_unbuffered_write_done(wreq);
-- 
2.43.0


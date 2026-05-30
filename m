Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039829B78B
	for <netfs@lists.linux.dev>; Sat, 30 May 2026 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103691; cv=none; b=DzKJ+ogI3BFuxB2avgAtcSHPoNhcHAbzWAmJGFEkM9puoRpC7GXTXPu6Kfj5INP6qaamMZxKqj9ppFK/u4A8pYfJpsx80HEJDfjAAyoDsOuwrfmZi8or1W/QBQGn+9US7W3eig2AVOasXMdm9hNbPkBeNTBCrLKL90OuFJp/J4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103691; c=relaxed/simple;
	bh=gZ0l4mWh0KzlzNEKkfQzTOD6GsEKCgU1TWIntbjzfuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cd00Jq8ff33JZCKuyP7oIwhuOmEbTJasSRPYDz6nRsxKkU2DPj21XdiqyVwYOvcJGqsuIp+r+GKsVJL4ejay1rfLTGZRpVQ6jq9EvGFZRxoVp538QnTte/jRh9EfoGh6qi+DH9DiSw6/LnIuj9uHUBfxCYua0dMAoi6WAV4aJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JHON9Vl9; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JHON9Vl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780103684;
	bh=x4kVQoIVDlmW6bDXyAU0zZRXLchnsuMnK+U1gWy3hAg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JHON9Vl9+dojNR2SAQrXZHvE5qMKYKbaBHN45BGTcMlxBajjv61Vp9hWWsmDY4NqI
	 cI+cO7p0zi2w94awgImLJnDIYyuCxtoAWtr/gJ+pJrsZV5jDsewsiB3GzfvXy6OQaF
	 OyRB9ImrO7Lde1iEbzos6HNmF5Tk9IQG2QLFnkpQ=
X-QQ-mid: esmtpsz17t1780103666t8766b602
X-QQ-Originating-IP: ZRhmwCQdkr9YixAQvtx8hqt9BzVkeR3/TmXHcBtwuok=
Received: from PEN202512010006 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 30 May 2026 09:14:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18313721841793988943
EX-QQ-RecipientCnt: 7
From: hongao <hongao@uniontech.com>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hongao <hongao@uniontech.com>,
	syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
Subject: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed preparation
Date: Sat, 30 May 2026 09:14:03 +0800
Message-ID: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N206jV1NQIGmTD4ULewsu0iMsoHNMIliWdMslq53QvKDGEIIbSTKb6Bh
	grjhSp/b5MN31iriFBIViRCOeqsD96ss6O60B+LLO+sFpMZ4Ft3QLF3qeY3lpVY5+M3cVTQ
	qK2Kdi3N2OwQvnvJ/m2byaxh1d1THJMoiZsqTcgda4v0s3XyfJ3k7yGkiDqUBX1d1rQyFCd
	Dbtiu/99Y2uNHPmw9oACNNowDfvNcx0lU0cgFl2PJM/VBPWWguT4/COBHTTJQaLh0clv3sU
	5mVbxXRTout9NZ43yygpzT39CZ57s5BNpo22ddCSLJG2I4jRvfz7FDjIImsqLvbs/tJWH1+
	6ZsgUvCU/sYpc4o0IdBt/0meuPnLwG+DCHodYa17N8i0Lq+0Y+ZjlZZH0PoLY7NNvBAbdFG
	5sH3Nax7khpVWdZ4W67y8SudZVYPVEZADOeksIBOcB/Gf2vO9HStafNcDL2/RiKHookeMSE
	eXA8EUS6MhW6W6dskvnJxVxal9gwuu+9ly3/idcObdpmFm5t0dbi1TkB9pyHjoF8grzkkmn
	E1tcmVG1dCnNhRaukC0l7BxI7epIH06NdYW9g5p8G+/JHYrjy6v3kfERePs7/oHmPddy8WT
	qA8tGTkxGaBNpc/rVw7mv5HIl30ddxHuZxB4VRj7NIcs0KBQuF7mtHf1IDaJY6l3ZxLKq7u
	8loGKaYKIGMZy8dhIZrSNceD74ayxBhBeCc5gs/sgwamRG420uLJY4SZ1USj5Ilzj+Y38zb
	TInrgwe/G6T7kuzs0e0PMF5yUbGumfP1uio8UAxPOFjoStOkBeUASgBkGqdxNY3kS9/gFDQ
	Bt+/geFYJjWKtfF3S8qgRjrGJqb4PH9QGh6GMm4iOSCXFviKSV7rzvGhqnJnReYPlXF52gF
	M1VgAdVsjjOOz5219mthym0lu04xCrUXux1lCzq2pE/kpnkAQMcKFyuDoJ2h8rUWr+6JcrC
	ASqNn2kcKELPiFf8UcjqQ4E/wwov1vDrndTUytDOxedgzwHOhYXGPAnbH8KzIT5tUo59jQ8
	QiPk7cilUehxoOIwkqckoarnt7QHBDWOlPh2XaaFjy7gMJG1Fv8Gs1+xmW+TEnPhpcsDL//
	Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

If write subrequest preparation fails, netfs_unbuffered_write() calls
netfs_write_subrequest_terminated() and then reads subreq->error to set
wreq->error.

However, netfs_write_subrequest_terminated() consumes a reference to the
subrequest through netfs_put_subrequest(), so the subrequest may be freed
before netfs_unbuffered_write() reads subreq->error again.  This can
trigger a slab-use-after-free.

Save the error locally before terminating the subrequest, and use the
saved value afterwards.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32

Signed-off-by: hongao <hongao@uniontech.com>
---
 fs/netfs/direct_write.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 25f8ceb15fad..2d5361702076 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -115,8 +115,9 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 
 		/* Check if (re-)preparation failed. */
 		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
-			netfs_write_subrequest_terminated(subreq, subreq->error);
-			wreq->error = subreq->error;
+			ret = subreq->error;
+			wreq->error = ret;
+			netfs_write_subrequest_terminated(subreq, ret);
 			break;
 		}
 
-- 
2.51.0


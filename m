Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95570B672
	for <netfs@lists.linux.dev>; Sat,  4 Jul 2026 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783142534; cv=none; b=ANycm0EFeD4F4UKtVAWQYKvOnM73yDq64TS9bKIEyiD6LWEyVm4xBdn8d6Q25GZsWvHaPLO0clRTF8fwUxYcm1dLThhaaX+a/mpxJnBpI9Y4EVvPiRDIAUjhoUV++IgxC7PaGiC8pvnr0gLVP29XOmdQKQZOjwqGjB+MRzgmPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783142534; c=relaxed/simple;
	bh=iIQl7IlCbnKA2hSRRo/KxIBEBmqTOQOA9PPH+NxHrBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n5CH0QJ4AazxI6DiTFs3cM8lGbh1OexGQG2AEV43itOOJ8BF0T34l7GkDMwj/q2uHlzoLa/ezB/MOtQKwccJ5xWxQJYxu7cXhYgAFWaAlHuimwf4FVKHEQYped9E0mT4nsWo+sQmEAGLZvJJ9jLYsISVwnMb1K9f0l6GBQNJ4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=V5N9mq5V; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="V5N9mq5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783142521;
	bh=Cl58ajfQyoKTpZ+XesofDhGeY0hWv811aO6QMaFFebo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=V5N9mq5VR9oqZcJtnd5kGexP6wGecvyG4VCfsiAUMsOQHr8AxIltkzT9502JbQkOE
	 HYYex2kJ3bq1hdeC7Jc3XG4F5C5FzTqHGWMsUKJCgpg1e76ZwL9j2dUbF4B/L/js05
	 dk4KapKFS35nlxKRUPypYZrwfWUccil55wLnQZzQ=
X-QQ-mid: zesmtpsz6t1783142516t5a24f366
X-QQ-Originating-IP: raDJIHWEUcdG2o9c1hVKah+gUahS5I9vjDKkGXOLy+8=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 04 Jul 2026 13:21:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14185401001973905956
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] netfs: release readahead folios on iterator preparation failure
Date: Sat,  4 Jul 2026 13:21:52 +0800
Message-Id: <20260704052152.428240-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NNCgUTg3ctKTVkWMMleBohrV6aZJbnd1rgFV6ilLTgKjq1cFhzg/6bH2
	M3fazzlSJdOYLWUituQm4rq4PT/u+kSxT2mCSv7VrL9YdAcsjS62YLxDCmbPaXbrqvuVBx4
	KjgRTsDPonNk5FkJoxpWnMSY1obhM0yCwp1M9aMKRM1ENNwlq4MyebsGHPgjwezNEZEhkbP
	wDtlGl3Q65TyTaZVEU1WvG8ygJ1DOL7b+sshqfnbYFLbczabrrPYyaKABxbt2OnJPsoHLTV
	mSRXYOSzCJs4g2imx11z6UCQwgUrAgrjN8TbuJWY645ad2SAFdOcWNTiNU7q/baU7ZD0oaL
	EoOpaApheUNxDn3rrO6nvyvcDxgY0Sf+J55Idlt8vYPZ6lU4BPlWoQVtZL13SO7LITkd9mI
	X3AJ5kP7zXZnY2Xv18s/LpURyvJtdxqnLSAM4pjqaCshNTkYUACa2Y7KLfc0PdzPs0LmvLm
	7a/Q4IR94IlDLbflpQvis19l5wgTWRqNeSyZ0wNcTt/2HShbefqHoL3/Uuf3StFczR9H5Nd
	SGi1bkzO1QvusdxWao75CfOKTKesCsKy8eikB5rMxa5R5V2/+lbr9cGZtPgszymwzVrROhQ
	B9OJBz1b8BgY89/Go9ghJWekhGSB9bNe3yJl7TejswvUWAPH7kGDeLbdx2r88N9AsRi3cO0
	tp6Djf0Qp422jhAaeFg+A7ZPP4njD+hVYDBGIqaOGA1b1JLauRPGLU1ghkyd/nkuLmrHtKv
	pOxaHvuSA7mGaf0d1p+oStcRps0Rn/GA+THWRjGMT3eZe5PfSvpq1PElm9C2w3UL7kYMonY
	hL3HCcdZ8wuhErjdZfCbDY5CXIu8oWUCQalRj4hk9FWiMl36A1GJqqEdihqRB9oxSWJK9Sj
	AbAj3p6gg5+5chb77IVIdqozSZ240kPKOcByyTUi45acB4lU+lw7JWBz+s0B4R3IvPe/8JT
	SQMHl8q8ORuUKN9l0UH44NBSI3b6L9LdhSO0WxzXCNSXy33ymo7e00UKaarPvn6WvHtJZ8X
	1+Yf5EJ89cQEzyJk0g2gqnVelZjIJeEUKH2QUOHOIk/pSA7xLs
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

netfs_prepare_read_iterator() batches readahead folios in put_batch so that
the folio references can be dropped after the I/O iterator has been
prepared.

If rolling_buffer_load_from_ra() fails after earlier folios have been
batched, the function returns immediately and leaves those references held.
Release the batch before returning the error.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/netfs/buffered_read.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 76d0f6a29aba..68534cef37cd 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -102,8 +102,10 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
 
 			added = rolling_buffer_load_from_ra(&rreq->buffer, ractl,
 							    &put_batch);
-			if (added < 0)
+			if (added < 0) {
+				folio_batch_release(&put_batch);
 				return added;
+			}
 			rreq->submitted += added;
 		}
 		folio_batch_release(&put_batch);
-- 
2.51.0


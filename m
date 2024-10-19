Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D561D54D3
	for <netfs@lists.linux.dev>; Sat, 19 Oct 2024 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729322214; cv=none; b=jCPJd3UJOceK5c4YiY7SkLcDz+iSs5Gj4CdYtZG2MHFPutlxEr/UHk8u/p0pWDes9JDgn04hO/3L2oeG3zzXxkcaDkrB42F/dQe9P8okQQ1oo5/JdfBj+VqpEZ3O7okdZ5tcVI6aO4309Oag5PQ1hMZFmCtU86Yp8Xm8mnDJ3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729322214; c=relaxed/simple;
	bh=8Ci7FKbEJ8wfLsbm3P5p52CFIcHLE48XvNrbxWMT8WY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LpZRSTqXQktBHJ4Xf56p4QvuX9SyknYXreXTpbixX0c9Q8G0+oKyLTuhYdxodnhtohHqjMcKoTHqwREMOlofuqLQGdukoGf2263PUvZVcNQF7J/iDql2kx7cfDpc9/cDaFmWEuqObtX8UpORnYhq0fcJBFCPsxZlopOdg0ok2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz10t1729322145t2gcni
X-QQ-Originating-IP: MmLkSV7nZrQb/cnEymHleci7bWjXBsTzQKwQIpxawNo=
Received: from sonvhi-TianYi510S-07IMB.. ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 15:15:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11545662678210868571
From: chenxiaosong@chenxiaosong.com
To: corbet@lwn.net,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 0/3] Documentation: update nfs idmapper doc and fix compile issues
Date: Sat, 19 Oct 2024 15:15:36 +0800
Message-Id: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nw9C1WBu09hPdCMjm3icCXpfeyjCQaodp2I5YTDrJHsrcn8xhLBKMF2S
	jss/mTxLIdYwoqUhTV+A8wzvbS/5fkPPa1jwPcSkGTtcEurbjwC+T+HBu3yINtn63O2pGq8
	TG57/8axVh83YurLZQLhs1JmcyReSbcOOyLyZ6AJ0VbAfiEUcrP7mVtzg9WLcSXlvza1ELs
	RGSm+RrVPFqP8YkLZgqSCLjXKhmhTr7WNul/M2napRa1bF6SbXOgjZRwVXlGfzWJUAH7uJx
	PgJCHhxsa+Git/805R5YfRewA3RF4/U4oAlZaFuGEOwSYv6ABqjbvdb8BblFA1Knde11jXX
	2bH2w1OAXqHMCPRvhsteeJVMkzjICxFGeghCc6GZVN5skeCMBXKZbN8heDxiy3OW0C9DrJL
	Vlm0D3Y5Whcl6EFiYg5i9VjxRIHUbbeVfRfODQJ73cwjzt/OXuToFuOaNVEKNLuzEu808Gg
	MRLchYKwl+G0/O5tCrA56Y51BxI1ugWAIOe6JtmG7O8e4Prkj9Fb6JLjR7tPp3bO6pDx4N4
	BzeZ4bknxMqWrvo50XZiNaxSvmqKSZqr+NQ8iZ1iKEgicUXNBecGp/ScW6p5dIrsqWIPxZj
	YgSS7ywvMJkp1GGMWpYBK7OfRMN8pcnLeObD09GFYwaadifqrH7+klDpuF8nlWQARXRUD2n
	yKTdSjcXb/Cs6tiEgcL5HeLGhG9fXZkJ2aWy7uT+wGQVdhjo0+DOOmUsAW7sh4JGQu1mgNt
	1eY3tnOa18IwOMOq0fNDZEGrhsPc1liollacCI+rXw0iHm+nS0gLDyKzsTYRXCwA3HzsiS0
	jwOQYRkvo33JkmMSJM+voY4lyWakScEFoiTU0f7NJnJB37ef28mgKfvZkay+Nd+wG4QOEmP
	SK6IvaPqzXBTR/84iG2ij0rG7kZliI4DLYKpm+/PP0MFeJK+hpQuq7Sa4wR7HaVYc8o9pTG
	oUmk=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Keep usage of `nfsidmap` consistent with nfsidmap manual.

Additionally, fix compile error and warning when running `make htmldocs`.

ChenXiaoSong (3):
  Documentation: nfs: idmapper: keep consistent with nfsidmap manual
  docs: filesystems: fix compile error in netfs_library.rst
  tracing/Documentation: fix compile warning in debugging.rst

 Documentation/admin-guide/nfs/nfs-idmapper.rst | 59 ++++++++++++++++++++++++++++++++---------------------------
 Documentation/filesystems/netfs_library.rst    |  1 -
 Documentation/trace/index.rst                  |  1 +
 3 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.34.1


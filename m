Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5F1CC15E
	for <netfs@lists.linux.dev>; Sat, 19 Oct 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729322209; cv=none; b=myGouYEeH06EgdCZpSsR9rmhKx74BI6DEDqDf7KtusstEPjSjsnAKjJpUo5eLPmcl2hP7m1x4QRa0HNyG2x2RFHp988Ms2Zb2ZQpWkOAFaUCNYx6XhE2PFctOpOBtbg7XvXsCBxUR8BorxOuzQewPWnwxdrOszqk7Rm8nIkUGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729322209; c=relaxed/simple;
	bh=Z5Q8B4bck1mews/VXCUSRyo4bdvk5UfW/acuCx1L4IE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzXoHeC1NaecUABXvoOgOqfjLXsdXCkJ4ye/NGQ7yevjALpVl/Rnr1kt9P9XxTRTaTV9sETTt3YHQnyhfGarDw8rsuvJu3Pe5RMuAtZOJ/aM4IbMhw8/6Lx89VmIIM2z1c1e6T0PJg62Mv6Pe+OwA1l/IKjBeuV0VjYUS4Y4qAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz10t1729322177tbh1ui
X-QQ-Originating-IP: gaImgFu32Uh/c26jfCC4kBP+8UkdjHLBLPOMsCWpONg=
Received: from sonvhi-TianYi510S-07IMB.. ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 15:16:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16716936677098621295
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
Subject: [PATCH 2/3] docs: filesystems: fix compile error in netfs_library.rst
Date: Sat, 19 Oct 2024 15:15:38 +0800
Message-Id: <20241019071539.125934-3-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
References: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NT41pJDfQPFSB9F9kKdcq/EHqcrOjJ4FF9S9GguAtHWY6cx1LXVlEUS5
	hRngvoljSm3tCOwLYIZTXZcBs8K6ifg9EL05m/NNy9hrI2HWH/4hYPEu/bXWZIQlLX0VM05
	63R6oME6aSrdLaanHy/fmqwC1zcH+P0VcEpx5wQfCDtkND704glWMyRZxq0z3e8uTgaPBd0
	IVLCrGJ65Wi4E4YIiVEw2BfKy9Qndbj//vmHtMEiRFwWbKM70TrKMi7NWQ+gzhUt7i4zIGw
	aik+ZCX4rSoX8c3KUTf62q2dVS+dUlPG0F6jrMnPBmS+b1gK3s2dPSyoUN0B388HJ3Yy91w
	O8qJICvmaLKHnedf5sHv3g5eeLu1pw7yQqfagxeG4bZZtCtoTYQCMO8vcNGDxioNYKmbbat
	ohcRzjqM2raicxFhDwjdfDgx7ct6hZrpfO58PRfp4EDQER7PXPo2IKOVjbCAs7RUFzVqJbv
	FmfRXM6S/jYNAzm75WSPrgGZFQE0ylvnOtLPyXA8hvWRe9w5eUZ1JnyI6TyGxyLWkq9XKjs
	6mkogKHMucrmOpnAtqmab0hX8oqh2AwSQLWGT9hecupIa15sfOb1kRloS4doMzSSHawDxgl
	lKGXq7JpktBmD7zsBJ1mU7YHNhBJ5i0LiZPZTHmbePFDIS3jLj+P4IYr3ViqJUo+LKk7GLo
	ltkJQOKfCDRddg0HkMXmMeBlYDZ0MfxYH91q0APl0fuFp75EKlFoSun7m8T3AtSoBYxiTca
	lDiuVzI4wo96wkDgyxIzdvEgDzQhHQ8jEq/msIfM4L94jbI0SjNaWI/7K1J6TcF9sjBgPdJ
	UgHLyRLWs/aLq5pGTd7zNF4yWSi6BDx3HkrbE3UGFLQwXnDCKDC4Q73/ctDgqhJO8v05Ek4
	Xp5HEEho8BJqsml5AZ/fDipH3YFu82pA0312v6AWTFCYrcDKrHG/BpbRd947QAwt
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

`make htmldocs` reports the following error:

  Error: Cannot open file fs/netfs/io.c

Fix it by removing the unused kernel-doc reference.

Fixes: 86b374d061ee ("netfs: Remove fs/netfs/io.c")
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 Documentation/filesystems/netfs_library.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index f0d2cb257bb8..73f0bfd7e903 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -592,4 +592,3 @@ API Function Reference
 
 .. kernel-doc:: include/linux/netfs.h
 .. kernel-doc:: fs/netfs/buffered_read.c
-.. kernel-doc:: fs/netfs/io.c
-- 
2.34.1


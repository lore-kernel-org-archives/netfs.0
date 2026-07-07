Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5428384258
	for <netfs@lists.linux.dev>; Tue,  7 Jul 2026 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401964; cv=none; b=i34+xjDz0j4ZQl2DIkIpN9DFvliVKpmx5YvrRRVOlZ71x4jHbx8SU9iRRqX6Kv/1/tX9dOouaSAO47ZjB2YX2sJbcUC080jqdwzWNMIlZtpq6W+YSn/TFh3MeUA4GKvt9EOEvotrqfuRYs1wUy9g0QP/bf5SEi6iCagjl94Njzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401964; c=relaxed/simple;
	bh=kUqmcmTzZF8uuq0pGRJ/4unGGIVrRmkBhK8+ARKAUtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxUg9IUZ90Gp+p4G96D8fRLEhdkkKNUeS5JFiGgXVAAeKwBSVyCuZkBGDKwrpnDFFE2Efiq8K3K3SozCgsVEICliPB01evhxc/5XxoIPZCQJoGQYAQv52JE1MITrS7IYQOEViNwQ6EAoxlxxvQqesiP2ZS/Z1a8PRncZy5hk6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=aNKQFf/Y; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="aNKQFf/Y"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674Zgql752030;
	Tue, 7 Jul 2026 05:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=aNz4gKpYS
	qXRXAPUS1NE8QU/u06dew90+lMuycO6SNI=; b=aNKQFf/Y0JUsczn05bhqzMQH6
	B9u7CCfgsWlSd12bVFyW8VPlfE9cLpJBFwfLys7mSzT95FXC8ucPsimGOVebFazH
	6DKay/1RUPQGsUEg+XvmRvELvPFGCI2WDmA6TXPA4VjMb14PAginbiM+u/9kVFaW
	DYpC/nC+0kqI0FZrpTzXaPOMHHC1GsvL56lwMzIhmYcoUYSNPSRrAXrv2sf9U4eN
	YCwNZgay4pWDFT7OQhYaJB+FxjHrS7EONWhsLdGKMz4ebfmTzE4mCYtTLoT+0bXK
	2+b8bHdez23LG2dKpQVWnTaZV6pwxejI0ogQJrafkfmVCI0s0tQmyIr49UrHw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f6qcwbn2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 07 Jul 2026 05:26:00 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 6 Jul 2026 22:25:58 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 6 Jul 2026 22:25:56 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dhowells@redhat.com>, <pc@manguebit.org>
CC: <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to drain all dirty folios
Date: Tue, 7 Jul 2026 13:25:55 +0800
Message-ID: <20260707052555.2055002-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=D4537PRj c=1 sm=1 tr=0 ts=6a4c8de8 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=ftnr9pgPjLezqOHR4ikA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: b8d67MFjPKxaeVsr9-W2uXMSJL7dUjX0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0OSBTYWx0ZWRfX3D6xQX71Nuq4
 Z5XxdmYzJggiH7JJIGx+CvJO7ud2BSGvE/BTVvtvgoJQL8KD7CMmgsLqSGv34gSC01UzC+mikYZ
 mY8M/3NcF+4t4fRzhLXw3aK/KMBIGHVIRooNHRIPSxQpYea2vVX9
X-Proofpoint-GUID: b8d67MFjPKxaeVsr9-W2uXMSJL7dUjX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0OSBTYWx0ZWRfXy0AzbPQne88M
 MD39zpvgsHY5qy1ZfnyoAN3LEDEBaVY/PPB5sQ9i0h38kJDhPhamiry8yA4L07CqsGh6noKYrcg
 qRnB1iQAFTWlmoFpvX4+wslL3PJ2QATySy6z2cZ9G/nG0oPgqVkTeyzIKZSR0azK/XBhkN8A3Gk
 1Qmxg5PCCY3wYU6j6kTBEkph4+YFzVcrlgRJK6oKH/cvxEeRv6YUlK7F3n/Ra0RuqnXPmubgZJP
 +89guxJq+I7WlRJg18vTa+koPNq6KozAGhyCg7H+Csxqk/c5W+v+HYcsM6gLmc0CT8lcCsASKyp
 wLBf32UurJsBuYOJmjyQfpHZ5WzJQKqgTN3QFYm8BI6JY95XYnXH6zIWyuHSeRrqGfG5Oef4n6v
 nw/VdGfXAhpJnFONqQn8su1MIlEGY6bzInihz12egt4M7vCop5Cw4lSmcJ9GarNseQq01nNbivZ
 oZIAnfLtBhVnjb0FTQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070049

When netfs_create_write_req() fails with -ENOMEM in netfs_writepages(),
the couldnt_start error path redirties and unlocks the first folio, then
calls writeback_iter() expecting it to return NULL. However, if the
mapping contains multiple dirty folios, writeback_iter() returns the
next one, triggering WARN_ON_ONCE(folio != NULL).

This can be reproduced via 9p (cache=loose) with shared mmap writes and
fault injection (fail_nth), where v9fs_mmap_vm_close() triggers
writeback on a mapping with multiple dirty folios during mmap overlap.

Fix this by looping over all remaining dirty folios in the ENOMEM path,
redirtying and unlocking each one. This ensures all folios taken by the
writeback iterator are properly released, and they will be retried on
the next writeback cycle when memory is available.

Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
Fixes: ac5f95ac5d6d ("netfs: Fix writeback error handling")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 fs/netfs/write_issue.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index f2761c99795a..5aa47128f7e7 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -597,10 +597,11 @@ int netfs_writepages(struct address_space *mapping,
 
 couldnt_start:
 	if (error == -ENOMEM) {
-		folio_redirty_for_writepage(wbc, folio);
-		folio_unlock(folio);
-		folio = writeback_iter(mapping, wbc, folio, &error);
-		WARN_ON_ONCE(folio != NULL);
+		/* Redirty all dirty folios and let writeback retry later. */
+		do {
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+		} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
 	} else {
 		netfs_kill_dirty_pages(mapping, wbc, folio);
 	}
-- 
2.43.0


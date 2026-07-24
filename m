Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F339EF20
	for <netfs@lists.linux.dev>; Fri, 24 Jul 2026 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878265; cv=none; b=IQnspG+js/Z3j1hTbzGo6PqP1yx8tqZj18E7DDZRIbi2cWZrrRt9lv1sOgWdBo24r1JmLdue/T/uUC4miCPHCXiwEe4l52mPuLbsPfbnhFkAiCxozR4XKlHMSiIwidlpRI6jdenxMc17q5JugrpK+wQCSd9v/qSwX8AgyLTkNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878265; c=relaxed/simple;
	bh=WaLiakDJzNEXUiU2sH2bfCHynDy0fCmx3hOHXEAUuZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gvw0zDbyqprl8IUNZQXMwcQaR6UeKyr38snRnAUNQSPGG2LgIe8FRCXkVd+5ifGnA9OLzrQKWJmS+ilk1qHq1cJXgwl7alnbnxqc7rL6yfhj4kc218tzjrUZWfPPMA1O2GCEDhhRhlmSOYpQ4sjMJINpWS4pYc98B2sYbEmwGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=snjHWRfE; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="snjHWRfE"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4nGW5816466;
	Fri, 24 Jul 2026 07:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=K1oNdkrwr
	xz4DSDdr5oW1/b6/8getKn46hlIcYOxQsA=; b=snjHWRfEFXx3/S/mR3bfQ6YT1
	HDXKg/kC+hIjsmcqk4HHtFpQjq5gY1a/2Hr1O9pRwOqBK5MT22Sy9AnLofI6vdCG
	FIfryOb72XLJLUmNdi4lnAnhPQ7n6MQClO9Z8PEdap9lSXR+yPd9dwYZ9g1FtTNp
	nDya9b8bcy4BHilq4wT7U4mK++25dfiebnTEX821sNjcaHJmB2grwu6QGrzTs4qf
	njXoqjNt6WY50d/nxNCtDjEuiePFTysxltLh7BstrnGcKxyWque4TxwS15pMxvsx
	rwHxqrLN+nd6mTD5oDHVCkkgMQiyFIJkgkOOJQTvHD8LZtqb2NYz5HswvIQLQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fkdhy25ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Jul 2026 07:30:48 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 24 Jul 2026 00:30:47 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 24 Jul 2026 00:30:45 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dhowells@redhat.com>, <pc@manguebit.org>
CC: <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>,
        <hch@infradead.org>
Subject: [PATCH v2] netfs: fix writeback ENOMEM by using __GFP_NOFAIL for rolling buffer
Date: Fri, 24 Jul 2026 15:30:44 +0800
Message-ID: <20260724073044.3400217-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 66jfhLq5SvCCOfIF9zrbkG0Rz3MNXVnF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NiBTYWx0ZWRfX5eAhEphyba/h
 pIsQfb8ovNZJ4vRJk7/q6hIBNru/YPiqNccFwGJr3Q9CGH1fkLWHubuPHbJlGIqXPcd41ZPTkfC
 pYOBlI/dFfHUWzIXZgPR/KXBR+CQjoknzRQCh0j4rtWbB0fWFMgtrQ94EJ+im1t5fItZTFj5pLo
 jfVVgCk8SVPmzKPC4G5eyqjhKcM62ZrVIohWsZOHAZ64tiHx3uN37zoEISz16DodE1JtZRCbi7b
 u9uR4V7mtnHniRgU9eIwVVr7O7/qKOMjZYy7/B1lJtpnh3LS2VBu8MRUnHoy6woyDB+DOlyxQhd
 muVsetxJmrjUXGWsbCz+t7fnuQOYqXw9jeI5/huNHKHjEWRGqp791nVSPTCSxheh/lf4ng499ps
 vk3A+97NZkRK4v18APYwHVnCq6xs5HLUHOn9cBZoWHLjOHoFl4tZfb4+4ren3Bow0TWqEmpYIAa
 MVuhGn5takHsUxrDPCg==
X-Proofpoint-ORIG-GUID: 66jfhLq5SvCCOfIF9zrbkG0Rz3MNXVnF
X-Authority-Analysis: v=2.4 cv=T7m8ifKQ c=1 sm=1 tr=0 ts=6a6314a8 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=4-ShLkf2kxAbrXotaTcA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NiBTYWx0ZWRfX0Suz2fmWlgGE
 LhkkxQQVjpqA2w2VtN5tYzMyHes5A86cMatRQg6Tjy/hF3DXNjg5ph/aAbd0FL0oddFVWPx/Nql
 ft78TBrdQ9193pbLNvJI3nmQagta5d841+j/hDlH4e0kYpP7VuZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240066

rolling_buffer_init() uses plain GFP_NOFS for its folio_queue allocation.
In the writeback path this can fail and trigger WARN_ON_ONCE(folio != NULL)
in netfs_writepages() when writeback_iter() returns additional dirty folios
left unhandled.

Writeback must not fail with -ENOMEM. Fix this by adding a gfp_t parameter
to rolling_buffer_init() and passing GFP_NOFS | __GFP_NOFAIL from the
writeback path, ensuring the allocation always succeeds. Read paths
continue to use plain GFP_NOFS.

Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
Fixes: ac5f95ac5d6d ("netfs: Fix writeback error handling")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
Changes in v2:
  - Dropped the writeback_iter drain loop approach (v1) per review feedback
    from Christoph Hellwig and David Howells.
  - Instead, fix the root cause: use __GFP_NOFAIL for rolling_buffer_init()
    in the writeback path so that -ENOMEM cannot occur.
  - Added gfp_t parameter to rolling_buffer_init() to allow writeback and
    read paths to use different allocation flags.
---
 fs/netfs/buffered_read.c       | 4 ++--
 fs/netfs/rolling_buffer.c      | 4 ++--
 fs/netfs/write_issue.c         | 7 ++++++-
 include/linux/rolling_buffer.h | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 24a8a5418e31..fe84e1dd707c 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -359,7 +359,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	netfs_rreq_expand(rreq, ractl);
 
 	rreq->submitted = rreq->start;
-	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
+	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST, GFP_NOFS) < 0)
 		goto cleanup_free;
 	netfs_read_to_pagecache(rreq, ractl);
 
@@ -378,7 +378,7 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 {
 	ssize_t added;
 
-	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
+	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST, GFP_NOFS) < 0)
 		return -ENOMEM;
 
 	added = rolling_buffer_append(&rreq->buffer, folio, rollbuf_flags);
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
index a17fbf9853a4..3c4b1e244c46 100644
--- a/fs/netfs/rolling_buffer.c
+++ b/fs/netfs/rolling_buffer.c
@@ -60,11 +60,11 @@ EXPORT_SYMBOL(netfs_folioq_free);
  * consumer.
  */
 int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
-			unsigned int direction)
+			unsigned int direction, gfp_t gfp)
 {
 	struct folio_queue *fq;
 
-	fq = netfs_folioq_alloc(rreq_id, GFP_NOFS, netfs_trace_folioq_rollbuf_init);
+	fq = netfs_folioq_alloc(rreq_id, gfp, netfs_trace_folioq_rollbuf_init);
 	if (!fq)
 		return -ENOMEM;
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index f2761c99795a..28bcd10ef330 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -98,6 +98,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 			     origin == NETFS_WRITEBACK_SINGLE ||
 			     origin == NETFS_WRITETHROUGH ||
 			     origin == NETFS_PGPRIV2_COPY_TO_CACHE);
+	gfp_t gfp = GFP_NOFS;
 
 	wreq = netfs_alloc_request(mapping, file, start, 0, origin);
 	if (IS_ERR(wreq))
@@ -108,7 +109,11 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	ictx = netfs_inode(wreq->inode);
 	if (is_cacheable)
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ictx));
-	if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE) < 0)
+
+	/* Writeback is part of memory reclaim and must not fail due to ENOMEM. */
+	if (origin == NETFS_WRITEBACK || origin == NETFS_WRITEBACK_SINGLE)
+		gfp |= __GFP_NOFAIL;
+	if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE, gfp) < 0)
 		goto nomem;
 
 	wreq->cleaned_to = wreq->start;
diff --git a/include/linux/rolling_buffer.h b/include/linux/rolling_buffer.h
index ac15b1ffdd83..39b7248838e2 100644
--- a/include/linux/rolling_buffer.h
+++ b/include/linux/rolling_buffer.h
@@ -43,7 +43,7 @@ struct rolling_buffer_snapshot {
 #define ROLLBUF_MARK_2	BIT(1)
 
 int rolling_buffer_init(struct rolling_buffer *roll, unsigned int rreq_id,
-			unsigned int direction);
+			unsigned int direction, gfp_t gfp);
 int rolling_buffer_make_space(struct rolling_buffer *roll);
 ssize_t rolling_buffer_load_from_ra(struct rolling_buffer *roll,
 				    struct readahead_control *ractl,
-- 
2.43.0


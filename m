Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F730566A
	for <netfs@lists.linux.dev>; Sat,  4 Jul 2026 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783141945; cv=none; b=Gl7PLLuSICEWOnGEA4T914rdYAwytDDyN6jH+psYDTckfPbsxSoBpEDt+IxlgoCV5Y0258YUibnMHINyprCSkAOs+6c0el8m4+Fol9gncOLyqK2hZ8o0zcELaW4X8VKyfpdC0i5F8W7D3tL4OhVZd3UFsiqsasFT6PGtpFVgDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783141945; c=relaxed/simple;
	bh=eMzXFzE5Dq1CX/rs6bFeeym1XJwpk6U5tGkYcRut1hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XVbqltrXAlZ2H5d7sS0u86y5LQ4uF7TYXVB5MapDZeJMtnFrEHUPkBMpqfzw5Ae6nv96SnKC14TsqujR2NLLHSrBfX1fcCsZc7vf+2I9I6Vt/fhprnjGw/A80bLlXFGAmK6Waflujcvgt8kgqPik84oydSBSiwgrXFTPjdYYJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gbn7uij0; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gbn7uij0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783141938;
	bh=rK4k/uJJdHEjLSPAnJx6bTU83jF1eke6Ge9DZNozr4c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gbn7uij0SDFcyNZEjLNMjMpci9lIIsiv0Un+o5owTIDhHHTweTOnGBa5g2a6WRzM8
	 aWRb3ybdlNVqAEKrOJrukMAYTQ4JI+sc5Tq0YhrSOrwkhypNIjxDtnLOoIXfmLUxWN
	 Y+WN7S4XigtI0neizkQAivzjbe4TqfCEmn7oWu1U=
X-QQ-mid: zesmtpgz9t1783141934t739b81a9
X-QQ-Originating-IP: PXOjkhpnIgk/RMFt+tThRTMBBC8+KkOQePwRjjewJnU=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 04 Jul 2026 13:12:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15165425779059928051
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] netfs: handle single writeback rolling buffer allocation failure
Date: Sat,  4 Jul 2026 13:12:11 +0800
Message-Id: <20260704051211.427768-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NyPaQtJYQgeohIzv7DkEP8k/PiTg1zBs7Mx7I19voAcefWbDuR04KiWY
	hy9nL/5xGo2f0ZMmLQBxozimpJ7jMDe8SN+7EguQNgTb0Yl5xnl2+p3+6f7Cc9KPYmKwDWc
	xJ3MvaBsBSqv7CV8WDd/nkDlsSO+l5M30BgXc/zNR2oi0BFrGNjmgrolDH2R8EGeSyZySBX
	rhyyOuQMeJpLwtqkEtD0xPJrAYlzdK2tJo6xNwgqeJLmYpJxpk6JHQikplpFKFaZ8PL73X7
	k6R+61ymy5ga/6rIQnO5QoPD/JN4N33L9U/8pOdTqhjlSQU8aViZVoobvXD5abrmDlOudjT
	kGtYiFDrtal44pdrvAatHPt1eKvEPgVct/nHdKULIPFVhT0JSgfWXddI0GOkmmVx2GPIDGN
	N1Kl/YkCeumMA/WdzWZPhNmmtwpb+4HU4qYaFFDzr2SOW/f7yxcPmwVnsPAd2O666F74Jr+
	jI6HNQMXB+SCLqx42UD7gISwYPnDiVx5B1KFdMCZGcRB2oGmJow4tUc0mVdCv+2DiMV/E9P
	jb/nb4wXXak4T4Dsc5QgMdEwal84RKAuOaIXUnCw2V8KLbNn7kyCCP90EepOD8Vk06Uou32
	Q7lx6orNNoYzpe8HglfW0WycZucgNjUReyaH3znPhEB/06gZyqsF2w4HFxdltBXfkSIXU6J
	GuaWQdS0yxr/+6iwHLntEgIpUiYfllwMYvS46Pkhv4r63vGVOoX0w0BhMN7UU208PatpN/9
	21oF4pWlyP76pHFHzFyJpEJTd1+2HiDEqu932YSmQUkEO7Jh84orZTFdT5w3lCdSyeH0smZ
	Nu19J3sRMHYIydaI9rsxrViMS8zNEpOOsWswuKutG7sWs2EMPiJ77J7C5/yf0qfIumwewkS
	3yehASD8XPyXsk/zPpcbasVwfOTVuEYWwS/cA9YU8bAP0T4qthSosJhqrDsYIjC7DCUgC59
	UHqbFNIrsf3yimwidPOtFTNRrCQ5PlzzyifXc46H2KB44QC3+u0CALkLxND0X1tkwd7qwTg
	7XomWu1p8PoQHQo3YhmjjjlTSM6VX4h45LTyZxA/3mrXvcW2+a
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

netfs_write_folio_single() takes an extra folio reference before
appending the folio to the rolling buffer.

rolling_buffer_append() can fail if it cannot allocate another
folio_queue. Check the return value and drop the extra folio reference
before returning the error.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/netfs/write_issue.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index c03c7cc45e47..7ceb1ac3c8be 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -721,6 +721,7 @@ static int netfs_write_folio_single(struct netfs_io_request *wreq,
 	size_t iter_off = 0;
 	size_t fsize = folio_size(folio), flen;
 	loff_t fpos = folio_pos(folio);
+	ssize_t ret;
 	bool to_eof = false;
 	bool no_debug = false;
 
@@ -749,7 +750,11 @@ static int netfs_write_folio_single(struct netfs_io_request *wreq,
 
 	/* Attach the folio to the rolling buffer. */
 	folio_get(folio);
-	rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_MARK);
+	ret = rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_MARK);
+	if (ret < 0) {
+		folio_put(folio);
+		return ret;
+	}
 
 	/* Move the submission point forward to allow for write-streaming data
 	 * not starting at the front of the page.  We don't do write-streaming
-- 
2.51.0


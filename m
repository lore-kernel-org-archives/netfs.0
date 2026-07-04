Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B45695
	for <netfs@lists.linux.dev>; Sat,  4 Jul 2026 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783141585; cv=none; b=FX+/Dy477yIDlaYXCT0SNXmJPfm+9/m/HeqlFCUWzwdmMPHVL+ja311DAXcoHCy+YegxF9eHKKWJ8omucFj08D15Bc7a9z06Yq1OrlWjcwrYDm4srBXnXi0SpkQGWJ9Y8Nbp5WFFS6t2SLFGlyfuJQS+fmgkBTKfzO+qLyePuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783141585; c=relaxed/simple;
	bh=j4Ni1CkOrx5kNUf/f4PKnXGrFH6rr/9dxQ6uW4r98E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yr2RLH+2ThOhlxWbYPlD723XQFL5JU17xHGCmSXyguy4F9sbuezdH7D3/aV30Sbuh9PRgoFlT1bB1EdktOsZ9z812d74aZa26hoQfjXNHBTjXqTXn8hVhIIu09AOp3l7j6JOwwwAMnicpXbF4eMMKFV+hOX91GxBryLZcGKGeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qIKMjnTT; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qIKMjnTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783141573;
	bh=63TF3UwdevQYpBqWyCWyq7vTfUthWQAO/KBrqBuPaCw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=qIKMjnTTTv+DsDouKMcrjYgdOwGSiSQmwgufQu/qYnXmoahcvCglrJiyRrKPRg5KO
	 bHHExjYd/q5zxAnTVOAXS6LaH/cWPRgKap0TRHqQiPbbqqR0P85eVeizRZv7/Voklc
	 JYnVURd2K5l6tQsbW0MdraS5TD7ST/uAK9C7K1QA=
X-QQ-mid: esmtpsz19t1783141567taea2a5c3
X-QQ-Originating-IP: v2GwPoZEc1IBI0+OKJ05vcJNZzNF0927vynRWCJZRpg=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 04 Jul 2026 13:06:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15525942878875438794
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] netfs: clear PG_private_2 on copy-to-cache append failure
Date: Sat,  4 Jul 2026 13:06:03 +0800
Message-Id: <20260704050603.427472-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MHqbB1jS9sMU7QUuQ52jIbstt4PDMtyYMY4gyr/ppi+ja71YDr+6ELdn
	UtMretdcPCq48x01DvWmEJZyeYsmPGnxRiu6lDNpopAs2Tal79JvRHQcx1rhv7p96B/bYTW
	c/MzS1eiWWyf+T4G9+I64r8dLl9fTB/zbWulIF/eaLFe+i3TcEBD4K7RHEwwjqHwCrjx8i+
	ZZjWMx0Z9j4TYu0GgLJP+ogcboHB4bgkokS0S8bvD+SMreftflQEvdqQk+Ta0bDJUqQQIEY
	x59/EGbSsLlRuaACToQaF8SPtrrr05ECdJcKJ8uJIi/WoYdHVt2VVOfmahOyzavymx/ZRP6
	GxWvwfjyEBorXVQzrfvwH+eaKrD742qTXGgBfLP06nKkslFoBcuujce2iEL/0/2HnusEk+u
	5ReYhFrnjzo+MFd36BbhSCD3zFga7cd0CWHsKObZ1FFN6HIapvzngK94uAn6t0ra6BdOzIP
	j4BSkXxELiisUGvCphUt5mZzQaK4QxmGdblyUxEhlTKznh3rwF3XEyYeFDEoeOpkBZ1stS5
	kIpW+Z6/sN8zsiuPXNrQ0F8pVJHjUjA4hOpS63tJjvr3ZhX6hDimM1vQKuI+aVrkYVDKrXL
	FS6BhvFFJW4b7/Zx+uxz8mE3KYvnG4r5bztW7oq1Yz+XlDg7iW4LzdQJC5euZX8XUxeSmIQ
	Kdsvm6+BFeW/KzNuGlSrrhOrB15BfRpJ4BCCuqyXOGmOIqLtm6fxZPfbIbsW3F/S6v4b/m1
	DMNm4OUDQkg8U06Lahmoj+t9tL8MOoPcDgaX5CtGVnQqG+ThbIh0ukzPOPBW8ll3HJWGRpw
	GxO8E2CN1sJlIprYCHeCpHxYUi0i1pW+o4eS+4g2cBEYfxwLSzVETdD86Q+VfWZQw6yXW3h
	WQypFA8KfOyUOoMMPLUm9s99XukFvJNXs/dhK9XnAA9pK2wqswVc/vOuC6NsZwesSzygzeo
	0aHrR0i3yN8zFLq9madVmJlXIDN45eBW8YfkDoU8THARc6U7CaeUrQy/StiFyEg4a3fjtOK
	X9Ka5B5iVLPglPDP8HKTW3Za1W934=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

netfs_pgpriv2_copy_to_cache() marks the folio with PG_private_2 before
netfs_pgpriv2_copy_folio() appends it to the copy-to-cache rolling
buffer.

If the append fails, the folio is not queued for cache writeback, so
the PG_private_2 state and its reference must be released immediately.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/netfs/read_pgpriv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index a1489aa29f78..7eacc58abadb 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -54,6 +54,7 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 
 	/* Attach the folio to the rolling buffer. */
 	if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
+		folio_end_private_2(folio);
 		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
 		return;
 	}
-- 
2.51.0


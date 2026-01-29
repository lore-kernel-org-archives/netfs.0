Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79F353EEE
	for <netfs@lists.linux.dev>; Thu, 29 Jan 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708275; cv=none; b=cbTYrdYY3BbrirzTcdrPk2oru9dI+iffcBCvWcwLUOnQelNK+YYcNgIZuZPbd51Anf8XY6DUA0QjKPZlbukB5GoFTCWrzQd1es70J2HmqZ+wWLiHiw/E6delCYmFNHkTUgx3bNTF0vGLPNCi6HeyUb7x2Diej/+oX3kLxb1iqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708275; c=relaxed/simple;
	bh=epHar85QZNn2jQiJ+e6NQdZiflb3Xgov2Bv+VbUgWAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEm5Ta3lpP+fTVT258NnUJxUVb93Eo2G4uXLEnPCWqPOmYK907wN7OJAyWJzrAOmMJdXk9kDxruXJgK+2g4figViTYgxyVfl0t0g82+A4+AAarxe2BdYnDXJBlPt6smITq5WFvWS5up4ttZmQ0ZQVuILs26bGoXNyeFYXkryZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMH/3XRC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMH/3XRC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f5381d168so1074868b3a.2
        for <netfs@lists.linux.dev>; Thu, 29 Jan 2026 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769708273; x=1770313073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELonzz1IwIu+oEcsmAQI2aawMls9vRcbI3ozJBlZuuQ=;
        b=PMH/3XRCMa2BAp+C4HNy0ihbVVm7/d4vQWRr1251VkMskcR3U1Zz0HvzK7nqppjJHc
         jyEfGgVDeOEWRBeyvBl30ClTjDgLIFKqIjka0wsPR0TSWiLm5SRMaMt9gV6gDewhAdrp
         TIgMSygGf6rmysFwWGS+ItaVloWIgQKxUCjYg9EWroxS+OmcDIVZmd0HLdf29xo3ZXWK
         Yg/pDU+IJCxAqODrt5O2EwJXGhG/zX6LYt2Jh2P2ARnBbcGTE2HcAFt6a8Y7jR0GU0HY
         ugc2fDwxQmmXLDLq/wApjQUFnljjq39N8CDpK7F6tqnzjN0ChHFodUirA3Uv48dEl6KA
         iNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708273; x=1770313073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ELonzz1IwIu+oEcsmAQI2aawMls9vRcbI3ozJBlZuuQ=;
        b=xHDKoNbotpSbKxupqGvyXIXqfdFPFL/WIjzPbJRWUa7qa1X9e7EATHvWPvz8ATjzbW
         1/3fnt3LYlJ8Iwy9lRcUlCQuh0RFcDX/d+btMQBPyrA03EGYhfQYFsAef2h1mc/v0Xfa
         T+/qaedJgdFlmpU4bLIZCyNc7MeUhKg59SAEPnipLNdCCvUbX5ziGzjxkAOEZkzYDSdh
         t01O0Vbxa87TDJzUTj2qB3HkUzzNWjDCSa69TrXqutIY2lRcgJoBmqE+M7SJoPVdRkOT
         sQr9iEr991XbFvXY3Sa/G6BazGmgY7bf/2ocnQYMOjDsAev1mQOadOQyTQPikPSNpjkN
         ZsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzSl3+aF8l5qXKuzNZOdXH2jKHklQzEgIyrsEQy782tdRJ14JwGRaPgrq/TCUGjATAIOyrjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwL3BRYoZepNXsfflxyh4CCS5wJ2wSp1qqmMboLzFI9Xx8JMUAC
	S6YRe4WAG7msbFqSz9PGB+YpvW/JJve0VbLDaC97MH17CYmtuxKA/oYPfJ3y+Q==
X-Gm-Gg: AZuq6aJULeOsTfpqwpdLVPbTrMH8guoLXMcC+rEYaG26VtOmk8E3FL9ts6eRJAO17rO
	bLVemYqKoTk7zXZCCypepIEQm+dIiS6wqfvP3rqaiRZn/5XVefFnHFuHWmMecSIcYoST5n37r1i
	RyPpId9WKB+O/LxQZxg2ZvnocP1eH1x4c/NFIxqYyMG7TPRoexn91Fu/z/+C/01X/9hvPnG7CAj
	3BqajTxJ0FoScqi+m9SpYDNLQIOFYDByodoLpGJqqNa3teozLrpU6W2C2UWCbftVsH5Bs9cGEjf
	RghDXAPmEb7F2yRO7S33Vjhi1tyOIKT2i4/51yEMIJxSLcaumencSsY+E9IA417vcLLZtPdqjPC
	bZYfsRndI9qGYuYjTpTA3/gNGkCxpxr415m0dF52M5u6OrB9/9J1DEo3y0u1DY2hB/DPLp4aKoe
	hZV+rim36v5FvLTdbaKoK0encTTas/ZcS6RTLLDWCW
X-Received: by 2002:a05:6a00:349b:b0:81e:af19:34bc with SMTP id d2e1a72fcca58-823692b1434mr8395908b3a.36.1769708273521;
        Thu, 29 Jan 2026 09:37:53 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6a5desm5512659b3a.28.2026.01.29.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:37:53 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>
Subject: [PATCH v3 3/4] netfs: avoid double increment of retry_count in subreq
Date: Thu, 29 Jan 2026 23:07:10 +0530
Message-ID: <20260129173725.887651-3-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129173725.887651-1-sprasad@microsoft.com>
References: <20260129173725.887651-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

This change fixes the instance of double incrementing of
retry_count. The increment of this count already happens
when netfs_reissue_write gets called. Incrementing this
value before is not necessary.

Fixes: 4acb665cf4f3 ("netfs: Work around recursion by abandoning retry if nothing read")
Cc: David Howells <dhowells@redhat.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/netfs/write_retry.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index fc9c3e0d34d81..29489a23a2209 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -98,7 +98,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			subreq->start	= start;
 			subreq->len	= len;
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			subreq->retry_count++;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 			/* Renegotiate max_len (wsize) */
-- 
2.43.0


Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF327467E
	for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769848420; cv=none; b=O4eQpvNJyp08zkOvs6LMyygS8tbTt6XpBNbcGKC2DDRH+a3tY9svp1ILXmZlopzy6WAWJQS/Dmu+SM2kzrH9y2NmMjbJ3Hag9tKJxeogiia7j1VFAhEjQ6fUH9Tg1Tmg8JXNpOfQXLc6kqJuJQ9tBPidDuKaJft3llTo4kyzSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769848420; c=relaxed/simple;
	bh=oqlPZIT4MLQXSa1ieiGX5oAiYqXDOPrN/FOZrakOBXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0VfpJt6DSG2568cRZO/L0bm1np/mAer8YyyKrlSO2VvRWt6fIJiUABGTNtjZHuq3rznjucrW42ofjNg4HyWXdeNEMOH1PrtrIRsUks6uXMKPz+XtEUg30JDhXs6RYk4jSiv9EKZ5EfC0NvXWT1yWQ5sG561dEe//c5KgJENrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4uD51p8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4uD51p8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230f2140beso2139473b3a.1
        for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769848418; x=1770453218; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMmmP8vI0QxvxuThbE7B2eYmpWupPqzyj24reB8xSus=;
        b=D4uD51p8TqqsIAgBYOxVUrPnKU8bzNTTI+J2QJ+x3e+bqhD51DayOApUpMrfNReeo8
         cFuCJ9MK7LgUo+77Q6V+NKMYgJTjvmmY9GAyeMQb3xd83zO4KSvBe79WM3wpSXbpxedI
         X9/AWB8SubmTTrDe+LtxVgefZgjmtEs5I5gLQl1OkU11hcIDpIyRtw4SG1O097P2HucF
         qy79R4JY9QkNa1ViztmAXrkKLzVGv5+GjUCEE/FeSqQJvfPGKjSJsiNF47UYGZIJ7kPa
         eD8upqYap1zWSpR7EinYff6Y3P/lRiP9ijmSVNXaXwbOnc88qJ2nyRaWJheXyMFMYwYs
         Z3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769848418; x=1770453218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMmmP8vI0QxvxuThbE7B2eYmpWupPqzyj24reB8xSus=;
        b=qwdCS3kXH3d9He+GwKTT3ezQsWAHMG/oBWYXpHL/6ollu8li0yR/WdXx6eFHKOhK3T
         caIJI6EFItE9DeXbpfoBf+bjbqqfPovQn5INMW8pytJoJyxmCj/UORGfxHQEMHuV9C6a
         xkzWz875VxYVAClEOFsr7JfSRFRE/6nyj/z/20u+XnmCnaar+FO+Kvl4psBUou0vwQLy
         a/tsEq6TOTH26Zw4QQknLbWGpzF/w9uYVMtPaAEJ44FZnwKTZtdxk3YqQ+152kc+zVLJ
         JkBDKF7DtWAm9TbRQ6VZWwkyCFI6prUjtcJXJNcWNTI8ONdsM0/jPItDZQCl/kwIVxlZ
         EHJg==
X-Forwarded-Encrypted: i=1; AJvYcCUpWjs81d1R+7ST8mRKY0DUU8gwL12D1CYUKdVXh9Pc63GSOdmWyJ7I87Po+pgwjKkT3V4zSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz53dc/zGYOdbWfcwzs0bO5zc/4WQADhE6QmenzMyoieGBBzIHG
	ce/6ehJPxEAcdw9J50xbLn+YWOisH3lT+Z+MSPALDxL/doBkM481faceU2fqaMBg
X-Gm-Gg: AZuq6aJfsOV8thHG01WvAEUajhnB1udACQ0b9I90gZ/jyKn1syyspdzXWd6xnL9W+7M
	+i4R9uQ/KD19QHIorgHearFW9mgFgcramMcPbrTE4m6DGrePtgvMLucutEUDKAYzZQsnhKxBT8W
	+6qqEkEmJPPJLPGRlUHyCOWReqH+CSUHU9h5cHlFbDkZn9ogmxmkqqku2TrqluI/I+FTJjkr1Mh
	0rDb1e/erNM6WEZND1xKfQxfkYZkXdSJXu00VsF9CeLZc7X6hhndTjBn18ido1QXgSyNUAND8s6
	OofYLuMgwDi49tXGQ9xoIrBbN8xqYN60z14WiejZtFYzFBj/8xDoXbM//Ode0w1CkrXfDGafDfm
	eFWFSbTU0+AwW5VgrM3jus+y4DXXPNQmn/KVChR6g0ypXCqGC2Qm/Y+yhexEjwbjdr9sVBb9e16
	MbJlCl+uB87BguZr1qDEo2xGdKgBkMMUY60A+wV4xIQzLM/gpgPg==
X-Received: by 2002:a05:6a21:6182:b0:35e:5055:1ec with SMTP id adf61e73a8af0-392dfb1ba92mr5637838637.17.1769848418248;
        Sat, 31 Jan 2026 00:33:38 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f610266esm13479121a91.4.2026.01.31.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 00:33:37 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>
Subject: [PATCH v4 3/4] netfs: avoid double increment of retry_count in subreq
Date: Sat, 31 Jan 2026 14:03:05 +0530
Message-ID: <20260131083325.945635-3-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131083325.945635-1-sprasad@microsoft.com>
References: <20260131083325.945635-1-sprasad@microsoft.com>
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


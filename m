Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98880266B67
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855351; cv=none; b=ToNqKPE8jzNkpXVGfflzKIqEicmeuA1EWM7bUf7wiu/YUi93G7fFceyJRcCWtqCTMUTMVRGK93+7qUSFIvNt8tgLuviHTIIHvZPRtSARqIykFHspATgw0M/XbvAAdrSqGxEd7HaM+Cg9PclO2C5wondjoLNGCUQAGLetlRIfl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855351; c=relaxed/simple;
	bh=2fCtoy8N5vMIzLwNkzR/CRd1nKqcPpVMe2v8ApgF6iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KADQCMQLeTeeTNIc3yIFww0xWOFy+bnXrfoq9tJUeO6XU/4AxmbeIi1aJGUazPBxKxWAGZsU0JSNft7WKudmTcOYckoXy7aWj66GrM1TOxnW3UhW7JOJ9e7Pk9cNRHyOEqfysnANeqddpUTey1PV6LH+xq1NqiciGA1/vAelRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SgC2fSpf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SgC2fSpf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so37572255e9.1
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745855348; x=1746460148; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vJ9uNP0iHMrM/+SmPX2MMhjWP/P76u1o3hYif15/zE=;
        b=SgC2fSpfIA1ASIq1ZvU3obwhbEDdPvmuoizdFavWdwjblZIoK3sAFs9dIk63iH29oj
         AlyXM1AHQVmSErW/gMzmpXMVKSp6iIibdCacZOYZOS8SNDUlB1MXomAObI6+tAZrNY+U
         5/xFLlTQvuiinsoN1XUUit1YH7FXKaLV8UPYiHbXxoZ4z40lcXNJnzOCCFFU4ivDcs4g
         rgYS4qt8ZuDwAAfM6Ace+VI/Cr1/dqv4e6De96FlBN/Dvxs/+3OJOsvLlplyRtGR3Ot5
         A09Yk5ErHoBZXPLrMGdATdDHm0NgF9clbrAqZ74l3iscQasRJfPdeUC18iKOTMgrHEA6
         ptfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855348; x=1746460148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vJ9uNP0iHMrM/+SmPX2MMhjWP/P76u1o3hYif15/zE=;
        b=kE1UEMvsIIx0YO7kNHl7IMlLvDlX2qi9GD4CaHRwYYj3RcWmiU4fq75m8k1bWSMgwY
         4TuYdH4XBYOiuuVTkTusk5vJChwfT556HuCdHNNJ0ZC7LtPqWxZH3N07KB+bd6TNzSzv
         bNEMp+6babsuS+hPDRnKti7nSJkS6gx2kp6ZyVJnQpoCMZT8q49kw8QPG+Y3a7WfUVyB
         WrJ2Pqr9dZsb1h46oBS3hInTMuQB82XZ8dM/6Wt94GXPWv0qmVJlbOgSaLHzQjX6jlLJ
         /qAhKrwaFs8ptflrJDa65MmAM0qrmrCEoPJFuPhG4DP/qg33ZDWgfjEjwZl5S5ZEMhIv
         YWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTXbF4lelVGvTlKLAoTYSEXRJvAonpxpWbU0KbfUwjdQKs5PYriF8osmFdfgt3u0v3xH/KEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvmOiSdCacoV+8vNByI0wYYBYrnlaZJ7js3fERH593/z8mXWIw
	QbGOsrB6gV11RWxrwuwjZg4DxkO0OeanwjKs53jY5tRNORUcFvg92FjibAksois=
X-Gm-Gg: ASbGnctXV0BzPo6G1t0XmXs0KB2Ifls+777dkfSmv+K+s/9zSs8rawTM4h2exZiNJk2
	ndEnKZZI3P4H6zJTYroDXML4jpjTuFB8vDfs+LiIrD9rv8qmE09O0k654B8WRUzQrI9ZrTaleNm
	qsjiEbyLBVfceQUa+4X20dbkq1V5hgluD4lUor7xvTSjqXT/vpWRaYUA7OJt31hccqe/0lnNsdz
	Tryt8SC2uZlW2Gj8K92vi5ql7KURXCKP1JJPQK7X3uGku8pZsZes07pHidrWyNtVOJ/T9SN6xNI
	eIcAE2/4rsKwKRpxJsTS3B9BeXjebSYj3O46C1nmKMX/iue7tChpzRgEhsXNujzHPEMKzifhj0/
	lw4BI/fWdMHE/BeVeEryuXMcg7XJR6kc9Lvq44VdyhMAXwvzDWlU=
X-Google-Smtp-Source: AGHT+IG3m2YlpsVhZrJPpTZ5RnkrWV2u/Rr1pKPBf+x2egBpEMrhE8xwuaWfBSBsZxNTPwlfY1+yxQ==
X-Received: by 2002:a05:600c:3b0d:b0:43c:fa3f:8e5d with SMTP id 5b1f17b1804b1-440a65b6fdamr113966875e9.2.1745855347909;
        Mon, 28 Apr 2025 08:49:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29ba29sm162134575e9.7.2025.04.28.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:49:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 4/4] fs/netfs: declare field `proc_link` only if CONFIG_PROC_FS=y
Date: Mon, 28 Apr 2025 17:48:59 +0200
Message-ID: <20250428154859.3228933-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428154859.3228933-1-max.kellermann@ionos.com>
References: <20250428154859.3228933-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field is only used for the "proc" filesystem.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/netfs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 547b1aa70d2a..73b2a04aa801 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -231,7 +231,9 @@ struct netfs_io_request {
 	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
 	struct netfs_io_request	*copy_to_cache;	/* Request to write just-read data to the cache */
+#ifdef CONFIG_PROC_FS
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
+#endif
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
 	struct netfs_group	*group;		/* Writeback group being written back */
-- 
2.47.2


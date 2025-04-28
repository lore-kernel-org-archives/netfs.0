Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357626F460
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851448; cv=none; b=Q2ZhfIRHqTIWEFB1tE4ijXXLJdA+85D375M21p1kDT33Zck6X+yMtXu9s6qN6A4w9Kp3mrYhjTBNhtJ6t+3IhFe0vArRt0PqO1C+3wGO6QPOLtMoU8k73rvbn/louAkx0YmrK/1v3JFBaOEfjLMwrEoxWzGmq9FQ5iBEJk75o3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851448; c=relaxed/simple;
	bh=dio7cFYeS5EIRSdf4UlE5gkakll/Trh742cfuksZgkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yu2Zfk2ZLqDtD34lZD3ZD+yV3WERysU3s2yJYvrSSat5R5dIIkZ3h/wns4EOxDeZNlLrODUv1/H1SPVtpm4rvLn7FPSKxGMAOoWI4geke/D2d+fbsFqbuFuRUzhBd2f//XhYM9asDLawxINN825pny+eW3vckfBABo8sosskesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V6ehGRic; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V6ehGRic"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so36885455e9.1
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745851444; x=1746456244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IT/WHClpJVhijsn7pb0WP8oaOCsopklM2KzHxNlbeXk=;
        b=V6ehGRicZ0HRkAVCYStSiezkGdvlGm1pPlzj+r/A1wU8lV6oC9UtUyuD/p4kg94TJn
         BfDjPau8iWzEJ7OvoAfUvvHGsVr528it2UMXeOq558op0u4gD95lXpOQnjwXyR8fEUIg
         WMQhUAxSEJ5keVDmzUCPdumeR42LyQ9VOOJiRPQ4uk8dVtU+IKmNNI9cIvrP6Q4XELE0
         ZqurNoXugh70j69G22/xHbXd3EGA9LQBW2p1/ujrmKZsFzqtw4xBSbFY8x5zvaKGxcdV
         T7GpoV3p6Tvnw77nDUlgyoyfGz5LvEgRf/dp+K7WCUTdc7ynB3dpjJdtXedFX8Wk9CVS
         fMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851444; x=1746456244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IT/WHClpJVhijsn7pb0WP8oaOCsopklM2KzHxNlbeXk=;
        b=KWIRMrPjoOKMLqBwaK8bjWPVljvVzm/qc2y02Ggd+qclaKgb90C9A71iT41hxqCr1i
         rx0szC/qEGKqOBCwfhWYm49h3efKnJN7qOT2Mq/NRHI4Fg1PuaczyHrofmglMoU7PYQU
         cEsWpb8VmC19EoZeU7nReXCANUu69ILAVEudLDCbTQzXsJebEu3bIpSia4m/9S7P+DtK
         exPO4jDYbbxozrGRFgrd8ZeE/juQIZrp8CEVyUSbWBKKyoYLQTKB+QUERv03Geo/A0YM
         wsDXS+G+eeb7h+AZLD5SLv7JMKvs13F38Gk4CPTRDXyfMtHTtucAzP8YDTctSBRv9MEF
         KtQw==
X-Forwarded-Encrypted: i=1; AJvYcCUBF3PCAduu19utdbOmaZ5cGVj/Ps6dVh48j6tUvBPweQ6ipTgX9pfs6X0DFgOJuRIImrpW6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyepLm/ER2MgcLl0qopqtlsjpWup5Ds8rikLeLFbhchjagBcF1C
	xjHVXttoltr037D+zSYhFoUQcthRq3ep1KAc1wpZfP47kYa7/YM6x6LXOS+TPyA=
X-Gm-Gg: ASbGncthu6nJZ0A6PeqzR2t8xcdQtEOFFMy2324qmYuD8NBqeHhkybzBdLtgTXNUwRv
	yqzYINssfqSJfZdAXelj0p7pcmkpBEpr/ZMncy1WHF1YeIhNvBucIqup0wUGrpQEcLuBZe3ZHYr
	aw0iMHDBohJYXzqlJgmE4VV3+yzABoN93rZqFEDJxcK/VYzMYzr8avtmQM+6vE0eKOua0LVos2A
	f4kwINqkJvEX9NpoiHniqZQ0QqOhMxMTKiIguYJsH+y/mwH1eeDmgfpElNu8Afn6zpNBee4m43F
	5bTkJOSugf2vva/uirYA6uk2+IKfsOTS0Tqhuey9S5tzrm0pEVqX91/Si2F/zR8Ts4qvsLPGwQ1
	gfHJopouAZBj/Y9g0F8SVBmoSA64GKCuULcPbuhkI
X-Google-Smtp-Source: AGHT+IFgMSS9fO6GoRqqJ1sjLN7BMNzCQObouCbx8bEgaE/+Fh406RgxAWJv8L6yJD7Xp9RF50kr+g==
X-Received: by 2002:a5d:525c:0:b0:39e:f9ca:4359 with SMTP id ffacd0b85a97d-3a0891abf34mr46734f8f.30.1745851443610;
        Mon, 28 Apr 2025 07:44:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46517sm11377446f8f.71.2025.04.28.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:44:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs: remove unused enum choice NETFS_READ_HOLE_CLEAR
Date: Mon, 28 Apr 2025 16:44:01 +0200
Message-ID: <20250428144401.3211848-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This choice was added by commit 3a11b3a86366 ("netfs: Pass more
information on how to deal with a hole in the cache") but the last
user was removed by commit 86b374d061ee ("netfs: Remove
fs/netfs/io.c").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/fscache.h | 3 ---
 include/linux/netfs.h   | 1 -
 2 files changed, 4 deletions(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9de27643607f..fea0d9779b55 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -498,9 +498,6 @@ static inline void fscache_end_operation(struct netfs_cache_resources *cres)
  *
  *	NETFS_READ_HOLE_IGNORE - Just try to read (may return a short read).
  *
- *	NETFS_READ_HOLE_CLEAR - Seek for data, clearing the part of the buffer
- *				skipped over, then do as for IGNORE.
- *
  *	NETFS_READ_HOLE_FAIL - Give ENODATA if we encounter a hole.
  */
 static inline
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..d161bbf1f29c 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -321,7 +321,6 @@ struct netfs_request_ops {
  */
 enum netfs_read_from_hole {
 	NETFS_READ_HOLE_IGNORE,
-	NETFS_READ_HOLE_CLEAR,
 	NETFS_READ_HOLE_FAIL,
 };
 
-- 
2.47.2


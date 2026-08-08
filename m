Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184A3FAE02
	for <netfs@lists.linux.dev>; Sat,  8 Aug 2026 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192563; cv=none; b=W7KaIoM/x3SHl6w3/NJ8p99lZdJnPy2PiKMqLMtOa6mOadbQVt91/OeWNVYIrCwLNXLkSOSWLWSkx40exw8Ozk9814VwHTNUu4WfU1lPDgS05w3lns8MY3QQkOkdrx/hRg3x/5ucCRUPNO5bcJzkiMYYnlXNnxiQIj6/XFz34Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192563; c=relaxed/simple;
	bh=vSaaDCCuVmF2ar8FmCnssqQGcR+EygdT9BnSZy6oW+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/9mwapzgsdcrE9IF0Usam1adeA3dJNQOw7Bv0ygjdzzCr/cklv3RPluNOYgJZKLxeK4j++I4Jj57TFG3eO2oZG0Xq449H/U31rOCkfMfvJaK2+U51/mSwx/+pdsTJ5QYcNnze/vO7/RCi8LW+mxcqgR0Yx7FC6ihPQKkn+TS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoPcbveh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoPcbveh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so5415915e9.2
        for <netfs@lists.linux.dev>; Sat, 08 Aug 2026 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786192554; x=1786797354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRYshfP9Ina/Q+U65sHRZbbE3Lz3C2G7D9AgZHh97hk=;
        b=VoPcbvehwIUNTEnLDlIF0mqeJiD+2lX6vWk/TMfY71saIQbTJqVkBPk7/wFDJk5zT7
         9saGl5y8MMZKgYrSYKXHz/28prU5dDQw61WFPASLJeOmBl6Mri+K/Un6meQqShA/bVgU
         lgwYno8O5Ko5hGRWTL2JiqLrRbKY9EKoJxG7huPExLunzyMuRshHHLcfQZBsx2dN1Ii4
         HIcikIJjiRiiGJHkaLb52MuBTLu5bRvP9yUWly6YJz9LPt4eRsRAhiV29Zd9vcB5Z+GB
         Akb9Gv3Y03uFfXXutMqxzCBGfNawzyIQRR5cg98o+sPC1I49And3NyxqucA9vxS/MHLm
         Dzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786192554; x=1786797354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRYshfP9Ina/Q+U65sHRZbbE3Lz3C2G7D9AgZHh97hk=;
        b=D7l5baFj9S1bymZJww5Gi9liTY6YHmeYe07JihN4Ze03bmRY4Ro8Q3Dh+VkI3bpf0g
         Y7TRE6s8uVsRapL+tLgqglvOln13WJjHOnPSjIS2EF3L3lizOv8Uii6RhnDh4gWeex9L
         qlfJ2iR7Y0tGX0MESWgSlgFBwAs7LBVgAckm6k740lsCVWlBpE++vlbbmJA3tohYip5h
         AYCPQSxbjO948EpuRTiIndgPvy3woPcnZsi1OTcz6v2ovDTxXqenjoy5dCmlJotAOGHx
         dSoLdKHelBCJodDO5kRrj+4hjari838AHw4tvXPoJT3WT7tXkuwZQkdE3WYSWEmfpzUK
         Sw6g==
X-Forwarded-Encrypted: i=1; AHgh+RpkHoigXzUPH162i64N/AsC1G2ymUDY0Mhmi0QdI4FrKu5CYaSY57GhW7OxN965Euw/66Tilw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8TBIAQVNnt7NWA962jvT9XKNIqvQ8BLARb+XCl+WyxFe2huNd
	UTFzGYb5QC8Cww3rqOHJ0Iv/jJxs1az5vQGYv2u5Bw3SKSnUUMSq6buq
X-Gm-Gg: AR+sD11mxyV0kyTuco3m+4QqIDcuEX0z7dOS7aq3DBd81zRaX2iVxFPAILv+OQOhQKv
	MS10wG+VkZm5AwroPXz3Q4B9oDy+NsawzVvopI4aQbvbvfbXzowEFBKl4aBj1ddSZ1RR7uyjhmc
	pT6mM4Vt9wdnR2IZU+8r4MvNyoZkNNb0AltN6LT0jxdAWdcwS8/zZPzHH7TxHJx9cJMmH5pAZm4
	vJethXTI46jKI3QvU5QnvQwQ1UOXgxelCiQ96/0gW8b1X036dQtBCr9CeNxL9zRZSLprxqcR8Sy
	FiwLHv7JRhqSrT2xARfyK7wJ0TE3lhvzQxkBZZ6CQJtaeDSGwSB2tz1PucJ49QIxdlrK97jqPOM
	HfPyBbepCjMLFDdwNJDFA9ksxr99K6wpD1/gx9jLgg/p5F+5/N7kkOjCFxMGLbHFRBHMOTnWyUw
	dEwbytGzz6bQQt26U9LmtpY/mg8N9zVYh9fKF2vLP/Kar1uqz8um4vQwAnYGmy3zDMxPzmWRoAk
	kgNrMXrhOvgChbQVqO5epDMGmJLgrksXHCyD0COJb7eQe09Ik3pRUexKPGKBY6GpMT03SfdY+KR
	+2XK6ikrPxVXWU+XKiKY
X-Received: by 2002:a05:600c:3ba6:b0:499:48be:3189 with SMTP id 5b1f17b1804b1-4994e6c065fmr360149945e9.0.1786192553857;
        Sat, 08 Aug 2026 05:35:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542858b2sm257587555e9.14.2026.08.08.05.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 05:35:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] netfs: Fix uninitialized return value in netfs_unbuffered_write()
Date: Sat,  8 Aug 2026 14:34:31 +0200
Message-Id: <20260808123431.73554-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If preparation of the first subrequest fails,
netfs_unbuffered_write() exits its loop before ret is initialized. The
empty-iterator check can do the same.

For synchronous writes, netfs_unbuffered_write_iter_locked() may then
return an unrelated error instead of wreq->error. This is reachable
through CIFS if cifs_prepare_write() fails to reopen the file or obtain
credits.

Initialize ret to 0 so the caller returns wreq->error if no data was
written, or the number of bytes already written otherwise.

Found with Clang's -Wconditional-uninitialized.

Fixes: a0b4c7a49137e ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/netfs/direct_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a17..b04019097ab8d 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -95,7 +95,7 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *subreq = NULL;
 	struct netfs_io_stream *stream = &wreq->io_streams[0];
-	int ret;
+	int ret = 0;
 
 	_enter("%llx", wreq->len);
 
-- 
2.53.0


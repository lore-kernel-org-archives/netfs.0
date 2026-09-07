Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20755377A93
	for <netfs@lists.linux.dev>; Mon,  7 Sep 2026 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761718; cv=none; b=DKISVWrYQB2sCZ04FLhka0TNMjnWKJ0goPjGv4w02314GOtfOX1C5kGEn1vs7zFgvAH8AxGtGSHKnpV59NOVzCVZkZS8bREz8tm9YcN+N+9HOb+ktlQueQglGKgPdD0bkXwltiMzfoaQOhUeGqDBJG7AB09cEgHUyTCivtmgTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761718; c=relaxed/simple;
	bh=O1v7h0Glt9tec5AHuLUy0WkK7jpV3Eob1sB7vRLAoEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kc2QculOVo1tTSA9zLBX2zIVv1kiiyjnDicnt2QQu56dqtXiIt+47r9B6/1FeqkNtXpYAz9ZM2PXYrJcyK8v6wq8mUgbX7RdrcACV0ya6ZZO4k7GkiiTz2ZOZ+zn+8NmRXRUt5qU/bF4bAgQV4x0uVtCA4dPihpF8Bir5mZsQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nsz+5rk2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nsz+5rk2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-855d2bfae95so4541873b3a.1
        for <netfs@lists.linux.dev>; Sun, 06 Sep 2026 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788761716; x=1789366516; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBOjAJZv7VoWT7HeRN3N+zGKpkHHnMAZ/hXhWpBPzzM=;
        b=Nsz+5rk2c/hWQEtpe2+c9QhJFz5qH00dYBe6JfPFUMK0kd0QBjogqBYfUvCBCtLT7m
         Fa7/JYyFrJc7Vxz8e2Rr4MGcIFtNUqJjXIVob7a4xzxvbimVQpw/0iLKH7ooK6A4I3BW
         10owuNzKOCAE8ASfMJsZyasi+hTc8yRUy1/Dxc9y4WGzHlJGQySq1w0QuqP3ojjqi+nA
         ghOZyE+UmNMjYnqvCH1c7X6OtT8Vt2dORydm1bexEp8psh/m8HrnJUntdTSPhqVt8Hx8
         ++cFPldmzojYZjXbvJRf2Anu7NcDR+isnuuS5KM8KXmxeLB5kEc/qo1tDNeUpeNyqqFz
         iUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788761716; x=1789366516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBOjAJZv7VoWT7HeRN3N+zGKpkHHnMAZ/hXhWpBPzzM=;
        b=BgP/KaGScnx8Lc8uYzqM5oRHBU0PjJBBAHjGtzV9+zwBAV/+9QqFyEuQt6rRLVu9l7
         NPDbRDqkB7vvI1tT2IR8B0a/2/OotGO6a+YvNR7+zfdIH4I0i1SBqmvwMYBzUs0K3Xaf
         Y1S6Kicb8EsWj5v8HHQR2l3LVIo5bUb5yXisnZrou94cuGn2oIuVPP7L5YeWOS9V4TN+
         7fRTTW+6lHGl+KPz+imBESP2U3xMnq05IeFNvNeDBNsBIFaVDGTAkCH2YQQJK6riT8pF
         lrQl6eqqK33viMxYzfzGGtIlJls7lzIn4w3v4H+aBL8Cz96djTxFyn0YWBpps4PgS62k
         Y5yg==
X-Gm-Message-State: AFuF++k08w+SIFUe969gscIc+sOgp1pR2jlrjbJGgvszSVT3Reo488ay
	FcolHDGtEMzbG58uVPkcWmDZhy0ZkhG86gvtvpuGmwLidoDzlVX51npNneFMct6sMkY=
X-Gm-Gg: AYBFou0UO7Go85c39tGEiQSVXq1SwUb/rgio80HRU79ifWad/2f+RGzvY/HBPVzJ0FI
	XmGdkXF0T5B8DK/whx37Rc/AfNJfoNPXlCbyel56h1+CRf/d4Nu1xSciSdCFifxLGtZlEGtNy9G
	pZWR+i03/JAMmWTngKl1+SF7hFzlgpz9LhJorpB29ErTsoQPF1bYhWzq0ySh/PiVoOTkK3lKh1y
	UaGTgIYEKlACF+aTsS/OOThPToT8Ko7jVvuJseVu+ba9ED6CEWmk8HpHIEBtwMTB/ipRgs1QT4t
	DdVwbOAl2k1YU3aQivHiBWAErAHwUSO/L8goQU88i67qQ5PwduX1wzb4NBTmhsH91yNCqlqpVFU
	MeUJ+g8TxiMRrHMNfJpeYLfM2zo3SyIddRWyX1KTohag+/umKNvCW7jyP1fcKIz19ZsVDxjWoAZ
	eQhEkJT7szZBUDqGVkxjEOytfGYHR8esHFnWTLxlOezZta4UNKjrNML/vtsC0+tirBgSF6ah28k
	S7mgbOVXWR5Sg==
X-Received: by 2002:a05:6a21:3292:b0:3cb:b6b0:1b83 with SMTP id adf61e73a8af0-3da214199afmr26825240637.9.1788761716261;
        Sun, 06 Sep 2026 23:15:16 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm4657413c88.9.2026.09.06.23.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:15:15 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: fix repeated words in comments
Date: Mon,  7 Sep 2026 11:45:11 +0530
Message-ID: <20260907061511.35092-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/netfs/direct_write.c | 2 +-
 include/linux/netfs.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a1..634a860f3ebb 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -247,7 +247,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		/* If this is an async op and we're not using a bounce buffer,
 		 * we have to save the source buffer as the iterator is only
 		 * good until we return.  In such a case, extract an iterator
-		 * to represent as much of the the output buffer as we can
+		 * to represent as much of the output buffer as we can
 		 * manage.  Note that the extraction might not be able to
 		 * allocate a sufficiently large bvec array and may shorten the
 		 * request.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f837a501008c..fc6e76102642 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -627,7 +627,7 @@ static inline void netfs_write_zero_point(struct inode *inode,
  * @inode: The inode to access
  * @i_size: Where to return the local file size.
  * @remote_i_size: Where to return the size of the file on the server
- * @zero_point: Where to return the the point beyond which the server has no data
+ * @zero_point: Where to return the point beyond which the server has no data
  *
  * Read remote_i_size and zero_point safely without the potential for tearing
  * on 32-bit arches.
-- 
2.48.1


Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C0283FF7
	for <netfs@lists.linux.dev>; Wed,  1 Oct 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307994; cv=none; b=l4KT6m0I59pZi3DTNFY3EgeDFPoa8q3S9iom40LOFbgP8M23wVDXI7W/36R+d6Pq/M7xqF4A9JcPnT6C7lmG99Y94jT7IReTzv3yJaiY7v19KDGe/zyESSJcbi13Fx07piDk6+Y2G97x67JIlD4kZTmLWYluIh/NZsINcjwPs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307994; c=relaxed/simple;
	bh=VyoVY4Q4GDe6RMQi5QGg4ffoiIPwM6SwqIJ2pC+aeyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q48Tevezy4rLFEiQyjap3bH+kQP/13KKTUtSs6pofogwdc5p/MSGWx7OFXJ1vk5hPD1Vps1KDjSIzbM8zYqEPLjDmQ0yXksI4b2BkgQ+6T69Vrr0YHmgSAkjItvL5Dvoqx59yN7mBcB4xZSz/J/m6qf9BJwYno2PmOsWdknHJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fstTN+o8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fstTN+o8"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so4840748a12.0
        for <netfs@lists.linux.dev>; Wed, 01 Oct 2025 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759307992; x=1759912792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4FfG++OYH0UQ2cb2chNsj++JT4lH4Ovdjh6P4PE8Qc=;
        b=fstTN+o8ukClw+/vGcX3l5VbvcMjMJvLZCNkmofQLnUQypo0XbQAGWycMAtq0+R9Dv
         Eb3JajAGnHvnHazTljb2cUZ+Ik8S5y+pnTuWGDZhws8Sv8gI0gnrKM0B1EHavVYs1nBf
         XVKXTR1PUkRhZPZ2qoZFEi41LJ8DCbi/qkWTXkuMKzaNybQqv+c2dv4SBzdSUM9Tl0/5
         JcacO8qjY6BaYzA6Fjcz1Cv9o85CourPjW3AxMu9b+qrV6RI0O5inoR1AJOtF080R264
         Yn4W52AMqdrJ66pazm/ic/I0LnDMQ/lWTIPh1VIkgI1WtPw5/z5uAXcZMJc+VbJnXX1Z
         1GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307992; x=1759912792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4FfG++OYH0UQ2cb2chNsj++JT4lH4Ovdjh6P4PE8Qc=;
        b=fdHgzHpH4DZIKufnhyDoE5FEpY/roY2K6eYlXLVP/3vLkHfP7dqPIScTy1GvMhOaRR
         FpKnXYo+5I8KOcdZ2msezcXTGYPumBEpqd+XQVO+KHiXOBFPIwb2Uj94UoafyYiKfkBz
         R/xJJeCIxPlgcjbz4QXOyuJWpsHxDYvyJuCXh+Xz1RPwMbpM6uDs5/L8WE/n0M+zppkX
         gBOetvs20htGd7M2uaHba+4iiZLV6ms3jfDBTBAovH9eWSnzN9hPMzIxW66v9v2g42Wv
         7Z5yfvXsR/cfFy6YTWffwEj6U280od9Qsuq1vVp4inOocT/X5TJ3zNPgWk2oJezU5tau
         oI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGe/EJNX96XG1hV0fVRgYmxvIayle4sb3Wb3fphiODELNhF4bvcY55T07E8hcLTmxHc4OFeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/w2Tx/kQnzPHnSl8B7pPPVIdPRNxUTuQB27hs0ymAGQb6/JTU
	kaCy3beqOp9wsl2fv+Wtc7s9JcdGl9WFCIT3TMsw7IDmtvAIGhq/rSDO
X-Gm-Gg: ASbGncuFIRQZZEj4EAQxOoVyZkGA6ZA2VNw4cJ2NGhP2O54TCYYHYPpAlA7cs/6d5U/
	mXtAoSsMDfxfSwEQzF4pkaqsCZTcsZ7vNTEGcvTVz2v7OW+0f+X2Qksp/B2AJjaGRd9qKbZxw4x
	Xsa8FzqiGb86UUvxQfA5UDgyym8DTC3f4yHcsLC8S6i/MCwLeBlciTRGUBSCG6oypIxBWCFzpxS
	SuNFu3h/JTpw+MP5Tks+gJ3Nk8R4Nb6mX85Wj0w7YcYLLaMUmcV5UTKmR5dRyKT9RhDB8dNoMih
	s3DVdDF37vfXOfBZgD2wQRnMtCWPyupCEaRnvoWgqWO5aDTZRcHrBjm3S1/3j9hkuSzJuA57zZC
	2GYcDYnV6vR9i+qptOmfNFAtcNEkdSmViAXSB1sN4IWOqkJAX4s6KELKVtadltBycYA7IsB7GAQ
	==
X-Google-Smtp-Source: AGHT+IGDAA5bS+9IItYzYTvHt755RN1Ht/RXQRCnt03we0AczFtZuNBaAi5b7oWoS/mnvJ+e//+JYg==
X-Received: by 2002:a17:903:11c7:b0:269:8407:5ae3 with SMTP id d9443c01a7336-28e7f4b6843mr37492805ad.54.1759307991850;
        Wed, 01 Oct 2025 01:39:51 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1d45sm179473835ad.141.2025.10.01.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:39:51 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Carlos Maiolino <cem@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-bcachefs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] fs: doc: Fix typos
Date: Wed,  1 Oct 2025 14:09:31 +0530
Message-Id: <20251001083931.44528-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in doc comments

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: No change in functionality intended.

 Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
 Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
 fs/netfs/buffered_read.c                                 | 2 +-
 fs/xfs/xfs_linux.h                                       | 2 +-
 include/linux/fs.h                                       | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/bcachefs/future/idle_work.rst b/Documentation/filesystems/bcachefs/future/idle_work.rst
index 59a332509dcd..f1202113dde0 100644
--- a/Documentation/filesystems/bcachefs/future/idle_work.rst
+++ b/Documentation/filesystems/bcachefs/future/idle_work.rst
@@ -11,10 +11,10 @@ idle" so the system can go to sleep. We don't want to be dribbling out
 background work while the system should be idle.
 
 The complicating factor is that there are a number of background tasks, which
-form a heirarchy (or a digraph, depending on how you divide it up) - one
+form a hierarchy (or a digraph, depending on how you divide it up) - one
 background task may generate work for another.
 
-Thus proper idle detection needs to model this heirarchy.
+Thus proper idle detection needs to model this hierarchy.
 
 - Foreground writes
 - Page cache writeback
@@ -51,7 +51,7 @@ IDLE REGIME
 When the system becomes idle, we should start flushing our pending work
 quicker so the system can go to sleep.
 
-Note that the definition of "idle" depends on where in the heirarchy a task
+Note that the definition of "idle" depends on where in the hierarchy a task
 is - a task should start flushing work more quickly when the task above it has
 stopped generating new work.
 
diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index e231d127cd40..e872d480691b 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -4179,7 +4179,7 @@ When the exchange is initiated, the sequence of operations is as follows:
    This will be discussed in more detail in subsequent sections.
 
 If the filesystem goes down in the middle of an operation, log recovery will
-find the most recent unfinished maping exchange log intent item and restart
+find the most recent unfinished mapping exchange log intent item and restart
 from there.
 This is how atomic file mapping exchanges guarantees that an outside observer
 will either see the old broken structure or the new one, and never a mismash of
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 37ab6f28b5ad..c81be6390309 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -329,7 +329,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
  * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
  * requests from different sources will get munged together.  If necessary, the
  * readahead window can be expanded in either direction to a more convenient
- * alighment for RPC efficiency or to make storage in the cache feasible.
+ * alignment for RPC efficiency or to make storage in the cache feasible.
  *
  * The calling netfs must initialise a netfs context contiguous to the vfs
  * inode before calling this.
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 9a2221b4aa21..fdf3cd8c4d19 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -145,7 +145,7 @@ static inline void delay(long ticks)
 /*
  * XFS wrapper structure for sysfs support. It depends on external data
  * structures and is embedded in various internal data structures to implement
- * the XFS sysfs object heirarchy. Define it here for broad access throughout
+ * the XFS sysfs object hierarchy. Define it here for broad access throughout
  * the codebase.
  */
 struct xfs_kobj {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..72e82a4a0bbc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1040,7 +1040,7 @@ struct fown_struct {
  * struct file_ra_state - Track a file's readahead state.
  * @start: Where the most recent readahead started.
  * @size: Number of pages read in the most recent readahead.
- * @async_size: Numer of pages that were/are not needed immediately
+ * @async_size: Number of pages that were/are not needed immediately
  *      and so were/are genuinely "ahead".  Start next readahead when
  *      the first of these pages is accessed.
  * @ra_pages: Maximum size of a readahead request, copied from the bdi.
@@ -3149,7 +3149,7 @@ static inline void kiocb_start_write(struct kiocb *iocb)
 
 /**
  * kiocb_end_write - drop write access to a superblock after async file io
- * @iocb: the io context we sumbitted the write with
+ * @iocb: the io context we submitted the write with
  *
  * Should be matched with a call to kiocb_start_write().
  */
-- 
2.34.1


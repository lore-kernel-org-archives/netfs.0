Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285892FD1AA
	for <netfs@lists.linux.dev>; Wed,  1 Apr 2026 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021486; cv=none; b=lMEmD7m/XgwAWBo3V/4x29lvaKlxd5M3vuhNVCJuDn3qM0YUbsgu7w2LcEEIb8R4SyCLkVr2wK3MJj+HqduT1oIeuD93RqbFIl6uf2qh4XZURx45Ls/T3NMn+7Q7QGcKDi8AmxJhVp4An0OzCua4inqiOSowcPEsYyyeoxM/vcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021486; c=relaxed/simple;
	bh=1acFv9UcJq9+zgv/G5mvLf3RsrhjHmkaCp5DZNmUp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwHtvSBNNjsLjtOL4Bo1G2HpAdnvSBZJjI8bu11Mxz/imS+BC0nv28y60p/LhXxGmhysv+fuybDvR1FijOwViNlhH6Q9KDBHvA7qiThmzLr5BQUIrZ08rn7668MDP8VMePNls/KYpOFWKQhIEdWabGpXIWPWoZrHs+Mg3jOOYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RboqtXrA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RboqtXrA"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b41b545d9so6963293f8f.2
        for <netfs@lists.linux.dev>; Tue, 31 Mar 2026 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775021482; x=1775626282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d53g2GmJS96aqelgbC9uJM1PvtU82NHOHG7LQJxQEik=;
        b=RboqtXrAZPTUJamKiUR6F4MHbpDLMGGlNoTakX+GWod5z9GNFUz+CsywlfPf4Iq/I0
         rsoYeHGl5jB2jAZAgfv2xzImjyjQx7BJrYkUNPB60vmqyPsCmDREdT9i8jrJ8kfT9NPt
         /S3u4T5VgMI/Ie56mCgtgHphH/RicyBwxEBf8uXLv2tbuIE48mqMj046liV+7pu4cV0R
         bDaah+jDG19QmilLIRk+V/8VFIDYMTWP63XHPhWyMDCeP2dbt91oVzSTp5J4v7HXMOwq
         Y3VtXuUn6MOq59JS6kPgViZO0f92bHGb9m8gPbmV69j05N3U2fHgfqJNUML/aJiUigrc
         0Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021482; x=1775626282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d53g2GmJS96aqelgbC9uJM1PvtU82NHOHG7LQJxQEik=;
        b=hQTyxbCpO2FKTWO6xIwsCQO1fosGUFJvPwQJ/U+vt2UG8hOE3m66EQfMShfAwg8wkl
         eQhQoakxXWLZtLijXzEN/NmJxU5hNLUadb71GdqpxTX3qicApgYdbkMuPVPOfluUeR7c
         4sSpzk4HTH/vhIV04Re8zvDBFdNIx+kubXYOlwUqM6+lCW3N4NHAg0rgdPPzx6dvTuVs
         egTV8RMNFoRrojkYIl7M8cTU5EqsxgcyFCMHFkANIKntPxLqyQjc5do2WZNwRpEcrUXW
         MmFKUdIC5Pu+4zI3YhJWVEWjX36oLz2Q25dkzAwBce8BQY/j1Kw0wjuoU9MiABqo3Rw2
         dvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQXVsNOVFhuWy8tILCLuWfmfqECQWDkumlFnCp9vw1ptPQ/1j6kn1OfS7gzyqqnXASHthy/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKwLLRrhbCVR6yPVB9w9YWA7JifRb7pBWnaKh1igH8JkWj3dzp
	zAE1RTifK3H0bDEIKKj18NwIRH8DP1KtUXZUZRshuF8qgZlysxVK9mr5L9fNTEo6oNKk+ff/OpP
	SK5BI
X-Gm-Gg: ATEYQzw8c4mMXeEehxNpcFu4g1+N4+R7ibkc/LiPi33FtdZw16pmFFvm6Ilb//TaAkU
	X+bicsxHlbN+8MfKsQBfqjrP+ChZmUC+Y5eKe/NQZnAHAB0vDy3doaIYy5YtICvBtHVQTQiBnZ0
	UeUcwsrNTR/R1Oc/X9Ef9t2Ma9AnqbnteC0dUFdcqopK3AySKEOOcbSLvztEhv84h0ryEbrBT02
	9+sh9H1/97ys24Ri4id3WAHyptcAHFyEnbgHpLrBV5XUqvwXybkXl+kqY25N70u8KcQRw7IBVWY
	9kzNwm3fpJKmrvaqjcuCIzzZ60tKSQ3/KnVKYKuWIRKn8yv/Av2VQuDY0vACEXGvOTrw3HVYUHw
	hFMbiBWlIoP5pzNTvKnqF5pEfRjVxw/wXG8CXBLMC0AEaytnfdWP6usWJ2F3WGoDX2bQlAyPjw4
	yE53RrpESHY4mtP2yVXdgf9qbQxaT/CjvOafIAZe71sgjKcgVu184leQR627aL1+GNhtQfeAOtD
	iK7DelIIcc1990eqQ2+ft+DtDc=
X-Received: by 2002:a05:6000:4201:b0:43c:f66e:f2d with SMTP id ffacd0b85a97d-43d150c14camr4102944f8f.27.1775021482478;
        Tue, 31 Mar 2026 22:31:22 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e24sm31410655f8f.10.2026.03.31.22.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:31:22 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] ceph: support RWF_DONTCACHE
Date: Wed,  1 Apr 2026 07:31:09 +0200
Message-ID: <20260401053109.1861724-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit 902893e39076 ("NFS: Enable use of the RWF_DONTCACHE
flag on the NFS client").

The Ceph client now supports RWF_DONTCACHE for buffered file IO, but
it needs preserve the IOCB_DONTCACHE state through
netfs_write_begin().

Unlike NFS, Ceph does not need to defer drop-behind until after a
separate COMMIT step.  Ceph's buffered writeback completes when the
OSD write completes, so the existing folio_end_writeback() handling is
sufficient.

This patch changes netfs because Ceph does not get its write_begin
folio directly.  ceph_write_begin() is a wrapper around
netfs_write_begin(), and that helper was calling
__filemap_get_folio(FGP_WRITEBEGIN, ...) without access to the kiocb.
As a result, the per-IO IOCB_DONTCACHE flag was lost before folio
allocation.

Fix this by passing the kiocb into netfs_write_begin() and switching
it to write_begin_get_folio(iocb, ...), so IOCB_DONTCACHE is
translated into FGP_DONTCACHE when appropriate.  Then set
FOP_DONTCACHE on ceph_file_fops so the VFS will accept RWF_DONTCACHE
for files on Ceph.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c           | 3 ++-
 fs/ceph/file.c           | 1 +
 fs/netfs/buffered_read.c | 6 +++---
 include/linux/netfs.h    | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2090fc78529c..b4ea3ba8211e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1865,7 +1865,8 @@ static int ceph_write_begin(const struct kiocb *iocb,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int r;
 
-	r = netfs_write_begin(&ci->netfs, file, inode->i_mapping, pos, len, foliop, NULL);
+	r = netfs_write_begin(iocb, &ci->netfs, file, inode->i_mapping, pos,
+			      len, foliop, NULL);
 	if (r < 0)
 		return r;
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5e7c73a29aa3..341589ef32cd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -3191,4 +3191,5 @@ const struct file_operations ceph_file_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fallocate	= ceph_fallocate,
 	.copy_file_range = ceph_copy_file_range,
+	.fop_flags = FOP_DONTCACHE,
 };
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a8c0d86118c5..6ec7c2459d8a 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -589,6 +589,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 
 /**
  * netfs_write_begin - Helper to prepare for writing [DEPRECATED]
+ * @iocb: The kiocb describing the write request
  * @ctx: The netfs context
  * @file: The file to read from
  * @mapping: The mapping to read from
@@ -620,7 +621,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
  * Note that this should be considered deprecated and netfs_perform_write()
  * used instead.
  */
-int netfs_write_begin(struct netfs_inode *ctx,
+int netfs_write_begin(const struct kiocb *iocb, struct netfs_inode *ctx,
 		      struct file *file, struct address_space *mapping,
 		      loff_t pos, unsigned int len, struct folio **_folio,
 		      void **_fsdata)
@@ -631,8 +632,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	int ret;
 
 retry:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
-				    mapping_gfp_mask(mapping));
+	folio = write_begin_get_folio(iocb, mapping, index, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ba17ac5bf356..d58c614e32fd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -414,7 +414,8 @@ int netfs_writeback_single(struct address_space *mapping,
 struct readahead_control;
 void netfs_readahead(struct readahead_control *);
 int netfs_read_folio(struct file *, struct folio *);
-int netfs_write_begin(struct netfs_inode *, struct file *,
+int netfs_write_begin(const struct kiocb *iocb,
+		      struct netfs_inode *ctx, struct file *file,
 		      struct address_space *, loff_t pos, unsigned int len,
 		      struct folio **, void **fsdata);
 int netfs_writepages(struct address_space *mapping,
-- 
2.47.3


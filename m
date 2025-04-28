Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95B2528EB
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855350; cv=none; b=THP0T/NC1378L2RtCRkcrhfbNNdW5PariO4wSrk1dMB5CPmw+pWpwutrxM7f2LxNYaDSW5VFrQA/IRV+EcjV9ScK5TyVtEIjXyPJ4hm+A6yUALo89lqE/tYItL81ugg7pulMmVwyVCeUm4pIvgI1AIkDM0Jf7kJHU8+FL2EqDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855350; c=relaxed/simple;
	bh=Ny1j6DYTxz+coZnLVhbzxwxWBOdq76xDh59nX9JdPTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5E2euNXL0qln6h+NTroW+vYoBwNGHQ4S9XF6emEQDecrZ2wqPq5QRivtUu25P3oIEuJpdNNKaSEUuGhDQXcqGzQhxWF/GcMDCfiqds2ksiUvb0XGaEDJwLn652CfW6sOTKB0iN+ZPnUsyrRH9VK0hwXt7EIQDuHjgtdYkOTVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aB9R54/H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aB9R54/H"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso39624635e9.0
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745855346; x=1746460146; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUqhWlRvKGSGvfb1cK2QZb/99Wnrk6laqKXGIS6Bi7s=;
        b=aB9R54/HmFrCZGHo86WNqbaFZ662BhNmfzueKxplmEITtwvi8PE23MHFdbZc/eM14h
         d1p55PQ6H53jyjBIXv7GoRoBUiAbJB0S/s52NJut8y1WoufYNiOQCg9SQVUR2woy63bp
         P8m7o9oHdDzAfDLbnxur+uXDGFqm/ZGfaCl82MzuHGYjXsL2cdlb+k2BnnJz0eE45Zuf
         M0y+avG2Gl3F+jGvNPK9EpSdjzBShVHNH4est9NY/iqbq1Q3ydvriCqjEPXPwOWpVNe3
         RH8AK4HEjzijB7qeoGRiq94yeBOO3zYP/8XKzFNK0nNxMf76/vAIThEuCGqhpxAIgBzI
         hBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855346; x=1746460146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUqhWlRvKGSGvfb1cK2QZb/99Wnrk6laqKXGIS6Bi7s=;
        b=iaNXiv/zm4euzjZqMobrrHYEQrbgstwAeuZ+9bZjvqSu0+EA+KrPsrGfxTi/5Nm/Do
         EY6omW0YFul3CdYRyHPF7MjiIyVrsiKw9oWuPx0/1mR8StUOEzEVbi8uCNo8kAONvtXP
         L5lYeLPAO0OJRnBLvmHJPr682IBgjN16YlE3K9v3m3tcmxesb+jQiYrTgG+As4eNNkky
         j9U7xiSpdxmuzplYUZha1oXadtLpa6R6eh/cSdCZRR+Ba9SFQlbmvRzvMWh6HFeu4/i+
         0uQHN+OCH+U1obB2ZOIIceiPy4x9iQdY4nm2mzvdEKEdrDZS2OpyuZ+rXGO0M6FDEZuS
         YywQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1VrDgtH5bW8bSyCLl4k0+e93xOb0ngo0fpEE/1NmNz0YOD6XF2p3hxt6ShbA7+Q9wroLOoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlA/nzy5blhH5a91WD97ySd9ze1wmKuwYZuYjViVCwsdBR4TL0
	+9w040o/Ku6NIUtvpUVpqc4sNOXPjDAjjOfe+BAN5aSxgWBl8rXarNI+pd/R9fU=
X-Gm-Gg: ASbGncuuz3241ApPOANArorCeISX0KwHpLe2gy29QWhuaQS8HdNy9I7+4pg+277sy2Z
	j3dUzlhxWaA6NLGPtBtrL5IMqZsC3ZTcPLSPw9rQ6fuKmA8oky+HdfyAkPyEJzoVsB3OYiOjEHa
	oshTYMfmsqD9oh+DdphpcmvVjU2ANSYOR85ApbPrsudIO5+sDMQQArwfYLI/1hIIjE2IAUw0+ep
	ICz0M5toHwtF/hqfE7UZ5XWaUx0w0K25Duy/p5mW1ncBXGgsmhr6M8xa4k0u9mhjIwP2mB4A0w6
	rafglDcdqEJ0O5N4+bTYv2uo8HMyDyPzFfUQwZNbGps4NGdAOIW+pK5EOp5c92l0RYbP30vcuPR
	wx70uhp2jElmqvP5p93C/V1P4Jk805tq0eh5pBXR4
X-Google-Smtp-Source: AGHT+IFx3lfzXyB5QBVLgQ212hUk8cNSewTLuoqiV1cbMnDp+a3qXEj0E1a2pkMzXBCVBE7A+bQsEw==
X-Received: by 2002:a05:600c:1e25:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-440a66100f6mr95419355e9.19.1745855346503;
        Mon, 28 Apr 2025 08:49:06 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29ba29sm162134575e9.7.2025.04.28.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:49:06 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/4] fs/netfs: reorderd struct fields to eliminate holes
Date: Mon, 28 Apr 2025 17:48:57 +0200
Message-ID: <20250428154859.3228933-2-max.kellermann@ionos.com>
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

This shrinks `struct netfs_io_stream` from 104 to 96 bytes and `struct
netfs_io_request` from 600 to 576 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/netfs.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index da0d36615bef..f0436bac5b59 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -146,8 +146,8 @@ struct netfs_io_stream {
 	struct netfs_io_subrequest *front;	/* Op being collected */
 	unsigned long long	collected_to;	/* Position we've collected results to */
 	size_t			transferred;	/* The amount transferred from this stream */
-	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned short		error;		/* Aggregate error for the stream */
+	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* Index of stream in parent table */
 	bool			avail;		/* T if stream is available */
 	bool			active;		/* T if stream is active */
@@ -243,19 +243,9 @@ struct netfs_io_request {
 	void			*netfs_priv;	/* Private data for the netfs */
 	void			*netfs_priv2;	/* Private data for the netfs */
 	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-iter) */
-	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
-	unsigned int		debug_id;
-	unsigned int		rsize;		/* Maximum read size (0 for none) */
-	unsigned int		wsize;		/* Maximum write size (0 for none) */
-	atomic_t		subreq_counter;	/* Next subreq->debug_index */
-	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
-	spinlock_t		lock;		/* Lock for queuing subreqs */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
-	short			error;		/* 0 or error that occurred */
-	enum netfs_io_origin	origin;		/* Origin of the request */
-	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
@@ -263,7 +253,17 @@ struct netfs_io_request {
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
+	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
+	unsigned int		debug_id;
+	unsigned int		rsize;		/* Maximum read size (0 for none) */
+	unsigned int		wsize;		/* Maximum write size (0 for none) */
+	atomic_t		subreq_counter;	/* Next subreq->debug_index */
+	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
+	spinlock_t		lock;		/* Lock for queuing subreqs */
+	short			error;		/* 0 or error that occurred */
 	unsigned char		front_folio_order; /* Order (size) of front folio */
+	enum netfs_io_origin	origin;		/* Origin of the request */
+	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	refcount_t		ref;
 	unsigned long		flags;
 #define NETFS_RREQ_OFFLOAD_COLLECTION	0	/* Offload collection to workqueue */
-- 
2.47.2


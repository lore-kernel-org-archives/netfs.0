Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF221EDA13
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840931; cv=none; b=Oc9JSXfbyEC3FVgSTBOiI3uYD1dE3e9f0OfTZKSRa7F5fb3zYlSjQcYR5nayaNHynyTwhXKuXn1Vft1xP72HYuPGhcKs5nQeufGHgLWwwat4FtzXkrukQSdWV5YoI0b+ZygOCIUqdIUmSuygdCMH7V/FeO29Qryq0p2VzriBFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840931; c=relaxed/simple;
	bh=S2zQys9jQjl7ZjcZRlkiU1xkTRbKd21inVtiBa9HuzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQARPKpBlagr1bzNKFMkIG7w9igookrBbJC5XZBeTZY1NGWLI9TKGLftbWizkW/2QX9Sdcej4NQIMPenwSYZsggeiH9ovoq7zmhUVGVzs53+fl3kfsHSZ3ODF5CT4Hi+/hZWym0I5+ezn9Z79yMFI6nwwfwW07hBpGMNveLGtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DX7TdFgV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DX7TdFgV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so42417465e9.3
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745840926; x=1746445726; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0q78s0qb5XBHEDUWv0h7QHkhC+VFSCzWihLuUxK1ToU=;
        b=DX7TdFgVAxtt/m79QtsWeM+9GEvBcboKmV4a9UVb93YkmDPbYq8wY8jbrvbxuZjP28
         k206eWLe7NHm9ZZ2hmAYIpbd5a4a2Ly4+jHW+eN7rVusLTRyld7wycaeC4vUgnNcb4Pg
         I6idCPsUOL4wzxSVSYYKrS07D8FkBbn7c/BkPjJM2NAvGzyaBX1TQD2eg+UOv0ld0Pea
         zzotLPpxmHdR+iq6NRMovBntHflbvswmF5VQsuS8aSo/gB48TfwNrPxzcEWd+unpV7O/
         oWpsR7EY/iNX5kKIfk9u6qhHDKzxgMJeJCckde80EOdcXPnbP+OpVyJytyp+os16Zrim
         4HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745840926; x=1746445726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0q78s0qb5XBHEDUWv0h7QHkhC+VFSCzWihLuUxK1ToU=;
        b=lK1Ku8jHXTVZBEk1ohFEHXsi/7YY9pGMwQOkpI9Wv/e7oEfHTtq3BnIvxiC+PD3i3u
         fZeZAOV22+e0VCOwFfI0m34gK0eysLpKQ9Yxv17Gsr1umYSdTWILbeeUb/buZAE0s5Mf
         ABgQw+gaigLrqcF8DtWZkjsJ2eaLKYRbyV5C/Dxxvs77aGlkZJ8OxzZyHEVuGw7+TmwY
         rcG/4/iWPobMH+s3uLUR/qHQCI4srCfCFzCZrELgH3hNsmSo8WZYR7W3eIdCmFASVBTQ
         Uut71qT4M9Ch9wJndkvMH/akj8mxnj0LfzDrHIEZb8WU2/LwjYPWU8cERddCT86c4yEQ
         AHKA==
X-Forwarded-Encrypted: i=1; AJvYcCVCY3BNDl8LrhJbLzlbRGKq924+Uyu9kulS6GZt+IoBrYqveDcIIhGLcf6Kso9ZwYGzmIMqWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyGwD/SXMYBbFmUA99Ux4oEOry6OdpQzvPZAPOUAaeMTI6VNeT
	svLTr2h2jcjgUzXRiA9FYxujjcKcarW/Yn0SJeiLdh3DqLKQY27VZIZJrWkg/G68krnMhSMd4gx
	E
X-Gm-Gg: ASbGncvSbzy7n8WrsR1J8mXWcknk50Q94ss8JARScc1iuqAKK81RTqPYIK4Mre5Ad3l
	hFJ2Y5TX39O6C7oFHInSE50Pz6xxB0Vu97mfEJjYi4x7wgksohXVUQkYKXfPdtkpjSriaPIv0Wg
	VBSFkv3wQYIpfW8l4DNv4EUlbCiDP3ePKxlJW3BLeDgX3VxXsYYX77PyaM3fLxC6gPUmVOBZO+M
	nrOL2MBpqgHmA772cTxKLXmJzaC7mJb+njl20aELa0T+xSOmVQOM8KKrJaLWyTBNwtewgiCy4vq
	w3C+EIE6AD/bex9wc/jjOq+fyZxZwREyIYRMh2UV2NomwBVT7EHtNLoiopR20Mr5y6UvsH8ZwXP
	8KrFT4u1ci3Xk90HV/lsC6aw/BQsYryAyWjPg0weh
X-Google-Smtp-Source: AGHT+IEYPoQYtU0kOe9zY7p5LAAhJRacyEF3DOk0Tid5iIYE4VZLhFE0WyyUoatOxkTUDVWHxJFqNQ==
X-Received: by 2002:a05:600c:a085:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-440a66b6e60mr77264835e9.28.1745840925954;
        Mon, 28 Apr 2025 04:48:45 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5310a8fsm123991385e9.22.2025.04.28.04.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:48:45 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs/read_collect: remove duplicate line
Date: Mon, 28 Apr 2025 13:48:42 +0200
Message-ID: <20250428114842.3180169-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `ret` variable has already been assigned before the `switch`
block.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
---
 fs/netfs/read_collect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 23c75755ad4e..422bfac47817 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -653,7 +653,6 @@ ssize_t netfs_wait_for_read(struct netfs_io_request *rreq)
 		switch (rreq->origin) {
 		case NETFS_DIO_READ:
 		case NETFS_READ_SINGLE:
-			ret = rreq->transferred;
 			break;
 		default:
 			if (rreq->submitted < rreq->len) {
-- 
2.47.2


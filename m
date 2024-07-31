Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3D1A76A9
	for <netfs@lists.linux.dev>; Wed, 31 Jul 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411560; cv=none; b=CYB314QiTQzUSNO9TzLRxZG6mXf8fE2cOWh9f0Vjt/5iFDIViHDzFvmy+qwL/n5Yi0fuYiP4lTaqB+9QT/aVkXdLMKcl282pRILlHU2AoRC72L9kV6tk7uq23xVB0trZMiLPZQno8JM5cXzsCWJZql0gIT8Y72R5BJev0lrf9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411560; c=relaxed/simple;
	bh=fFZMF3NiaRR6TpVbELAswq4kkn1Pf0ZbDbb3nw54F6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPpnF4odybprB3FWz+q8eNV4BCsP2DFr51VEHqHk60mAAlX5YYDI3PKIWAkho5IMLxk07CdYencoWoYGfnTYZqIMiYR2pZ3q6hCsAB6w9GQvTZDJtDwSXxKGDjuct/HZ1vYxXdfDVl6pgJWLiAWbedvLh+p6scm6OahuLQWvYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPFrjdP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPFrjdP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722411557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t8p7PLZp26QdCSQ6mdeX8yU1Tl2ZcAQTz+tPUUyqyK8=;
	b=WPFrjdP4CjWw3/Pd9sUTH6e73nvA+g+bRl3M2Sr4voK4BcXsD44QYqUtl1dnobR5gPnDQc
	bdYhgvYj8ozig1iwKRPyGhizcyY0uNWeEBVzVV9fX+51MVRTTvSIBRHp/BMOnfSB0wq/2o
	R9825YtdK9l75PG8OdQGZJJtylcqKZA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-OQz7mtCHNm6Qo1o7eGaYwA-1; Wed, 31 Jul 2024 03:39:13 -0400
X-MC-Unique: OQz7mtCHNm6Qo1o7eGaYwA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7d63fbf4afso329232766b.2
        for <netfs@lists.linux.dev>; Wed, 31 Jul 2024 00:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411552; x=1723016352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8p7PLZp26QdCSQ6mdeX8yU1Tl2ZcAQTz+tPUUyqyK8=;
        b=ItMPAHNW5pLaL3uCguXUPn9r2LS+s3rJaIqAfkkCI/4DcorCxSOFR8F2ySWlAsFnNU
         VVtvO78YVdF2ik1CzqQXGK4exm4ryQFMh8wWOi9ZbUBlntntknbeZ7iMIiIHSvTpt+V6
         55FOhEQueyPecueBpSg1JxyUfrBmxIljdBoJmZGj9nfx3b9dIEjEfrJT7AYPtdmh9xvv
         dyCN3S4zpP8zhgLZHzPDnPQAfzLZnxZeoyCmqs5Qxer/Lr1EzjlFmdxJG2NDcjUP/lXr
         QkNyuIcLrpBm8DGJuFiR7N3jbKh18RuuZpRs3B7m7hLn+M8Xt2rA/NG9TKRM/rLEsYcE
         n8cw==
X-Forwarded-Encrypted: i=1; AJvYcCWw1mproWRGpv904ginLegOcmYn5jLjlilL5OnIK+8nxGaSWeyk1oIBgSGYXxCekTHUtOQx5YBRoJcfKR/2iCBbzFwpROY=
X-Gm-Message-State: AOJu0Yyo+b/YnrI3FoiDtRNctagZtwYY+IdcEzCzTEXyzQmUP01fdbt/
	BEldbuv4Nt7e9Bkh2IB1ng7ySLB46wRcvovQiP45vjqVAU2HwR7HPQ4/0KpqnlWCQfKqkjhttND
	Cg5uvCMQPqexg19UARnfDtKal3aBhyU2tJn8JW0JKnv68YZnmsESC
X-Received: by 2002:a17:906:6a0f:b0:a77:dafb:2bf9 with SMTP id a640c23a62f3a-a7d4017958emr935767966b.49.1722411552488;
        Wed, 31 Jul 2024 00:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtcaFjOt9xSfQUez2BWgFX52e9aHax58DcvCguPN8jHiEXgVGDi0rjSjC1wDm9eFWQJzoLUA==
X-Received: by 2002:a17:906:6a0f:b0:a77:dafb:2bf9 with SMTP id a640c23a62f3a-a7d4017958emr935766166b.49.1722411551964;
        Wed, 31 Jul 2024 00:39:11 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23704sm735377266b.3.2024.07.31.00.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:39:11 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] netfs: clean up after renaming FSCACHE_DEBUG config
Date: Wed, 31 Jul 2024 09:39:02 +0200
Message-ID: <20240731073902.69262-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit fcad93360df4 ("netfs: Rename CONFIG_FSCACHE_DEBUG to
CONFIG_NETFS_DEBUG") renames the config, but introduces two issues: First,
NETFS_DEBUG mistakenly depends on the non-existing config NETFS, whereas
the actual intended config is called NETFS_SUPPORT. Second, the config
renaming misses to adjust the documentation of the functionality of this
config.

Clean up those two points.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/filesystems/caching/fscache.rst | 8 ++++----
 fs/netfs/Kconfig                              | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/caching/fscache.rst b/Documentation/filesystems/caching/fscache.rst
index a74d7b052dc1..de1f32526cc1 100644
--- a/Documentation/filesystems/caching/fscache.rst
+++ b/Documentation/filesystems/caching/fscache.rst
@@ -318,10 +318,10 @@ where the columns are:
 Debugging
 =========
 
-If CONFIG_FSCACHE_DEBUG is enabled, the FS-Cache facility can have runtime
-debugging enabled by adjusting the value in::
+If CONFIG_NETFS_DEBUG is enabled, the FS-Cache facility and NETFS support can
+have runtime debugging enabled by adjusting the value in::
 
-	/sys/module/fscache/parameters/debug
+	/sys/module/netfs/parameters/debug
 
 This is a bitmask of debugging streams to enable:
 
@@ -343,6 +343,6 @@ This is a bitmask of debugging streams to enable:
 The appropriate set of values should be OR'd together and the result written to
 the control file.  For example::
 
-	echo $((1|8|512)) >/sys/module/fscache/parameters/debug
+	echo $((1|8|512)) >/sys/module/netfs/parameters/debug
 
 will turn on all function entry debugging.
diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 1b78e8b65ebc..7701c037c328 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -24,7 +24,7 @@ config NETFS_STATS
 
 config NETFS_DEBUG
 	bool "Enable dynamic debugging netfslib and FS-Cache"
-	depends on NETFS
+	depends on NETFS_SUPPORT
 	help
 	  This permits debugging to be dynamically enabled in the local caching
 	  management module.  If this is set, the debugging output may be
-- 
2.45.2


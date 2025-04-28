Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1B207DEE
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850746; cv=none; b=OduFDlOo3uRZhieWTg7KEfEhSFZHHReDYkrjjiqH3q0sRZHB37B+9Hsi93CY9aHU0u0NSRXW+jjWIZVEE45AJVXr07Hm4COiHRwG/dhPtjo5Mot49QuzLsSWE5o4jii1q1N+B8fu7RXWdxfZA0Ztw1/nXcu067glbmL4TiEguaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850746; c=relaxed/simple;
	bh=e6iBIvRrCjrG+kwjv+jVID8U1/VKrlrNPYZnjI/EnAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVdFFEMPf+1ERmHS/aOx1zSOQCBssxBjZix5P4/CiCmFK84IUPnewqSBI0HnLYyfO1G3pbUq/Oyjtb6/jjI0hEuXPsga26bCwAJcq6cTgGjajYQr9abafZUgem1cn2cyzq2ax31PN7Qwh7opOjGCEMHKIewAuzX0bdcG3B6tYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SZk9kqLg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SZk9kqLg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so30141345e9.2
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745850741; x=1746455541; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7rJxcvfxmf0ceZVyKY/5V8iu1OWkb06zWKdp+678T0=;
        b=SZk9kqLgCqJj+G07UpTEOc385/kcZwl4i30oxbBpUa/XvLkUFH/SDvrmDjto+Rb5rw
         LoVnyL2edXbBt5iLImQIu0KgqLlftLUCKlMOhUotr9WJ0nryytwsl5lH65HkB3CgDddG
         wN2cYGAIQoXymi1KCZnfmg/qUvi6Lg2almduQCf+k4ni7K6cTE/6h2CDDGCmmo9ISU1D
         DBWnKiTa5x69Hybwi0i1Uwb5UF3k8OoTUJGZBCzz9i0VqSa3YMYJvCcPihmikFshSYTY
         LmrLUNDbmeO679ivyIxD+/I2IUWZWzl6DdTD+8ZAtlpdGhM6rUmeGefFbn6QEDKXnqPp
         6dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745850741; x=1746455541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7rJxcvfxmf0ceZVyKY/5V8iu1OWkb06zWKdp+678T0=;
        b=JEMp5A4Ht6a5tC4/sY5hr+eNRNH5tvOCNi4knTiaeUFL5sAuMheIhlJmZp5Adfz6Tn
         L0+dqxJJbzo+arF+Ht40FlHjDkQ4H6Rjfe1xYCAiHxr1u31u9Ru4Hk6jlZzRZql2riYO
         uNjYtl8XTvX5ZwAP1uw9iKr37ahoM+jDgrkcbMIuBFbIxmZEnrX7E1fjBmU5RgUe8f/k
         Dfyuy7pfSbxdOerKL27bsowSLQNkxsnketVYz9cVCvKePGkEGQDFhEGhRSZ/7JRYz1QU
         2qd9YfGe5DM5RDv1HaENmJijk7FgtdWfUa9aOxZGdwRZfgGN5KTg08clnOJ8+TWxhaY5
         DdQw==
X-Forwarded-Encrypted: i=1; AJvYcCVbIGOfdvTR/nG5YBsM5V8DOhZNPxpy9hIZkzpwI0WHpnsDVxSHAYw7e1KKwk+9FWDYZ4jCUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg2CuS+sJrdZyU8DSvuS7Yv8u8dQ2lpFOlb8kf/U+lvSlcXHBj
	+CB34xPK8kTnh8C1Uy9VQnlkUtgvpK1pPZpKkoXm3/IDelwReCqSwmb90zob+Fo=
X-Gm-Gg: ASbGncuthO0bIQB+hWZsT+2vLboSMkVtscyRz61GYEbYxksNcwX4oVMqJAJtGc/s5/n
	N5R4EIUG4pwAF6bAdMxSnlbyLxTR/d+ZjvQIp/UNNbjSQ3hT9qrIRgSl+M1P2iK1BAKGHnXdAxP
	TN/eQmhBboLvcbd1SQikHLRxyMuad6DboyoABOFBbWGOjwHvgFEArDbPDjkW2C1Vc/7/9H1RYhB
	TWv03NO0KzWhYl8W3Wg/h543ErVaJdgN/BqsNX8NY+CEzCBfrbPcNoh/wLrh37+JMpilvz7z2/N
	m+xgIZiErVj841veTt9uUm97yEv7KVB6jYir8x6u/ac+RgAYzqFPbj+q646TKkkbqefLi+ozBWf
	ewY24J+z8FSbSCj2P7FuX4vSdHg1pMX8Eoyl042TP
X-Google-Smtp-Source: AGHT+IHX0Lwtyuyo7ZtJiFuwKOdWkGwo/2whSkrPojV25UvEACyMAzULzUcwL5zkTjBa6aKQPVsEZg==
X-Received: by 2002:a05:600c:154f:b0:43d:b51:46fb with SMTP id 5b1f17b1804b1-440a65ba6camr112281055e9.2.1745850741045;
        Mon, 28 Apr 2025 07:32:21 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538747esm125073855e9.35.2025.04.28.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:32:20 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs: remove unused source NETFS_INVALID_WRITE
Date: Mon, 28 Apr 2025 16:32:18 +0200
Message-ID: <20250428143218.3206453-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enum choice was added by commit 16af134ca4b7 ("netfs: Extend the
netfs_io_*request structs to handle writes") and its only user was
later removed by commit c245868524cc ("netfs: Remove the old writeback
code").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/write_collect.c     | 2 --
 include/linux/netfs.h        | 1 -
 include/trace/events/netfs.h | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 3fca59e6475d..17f4e4bcc789 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -495,8 +495,6 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 	case NETFS_WRITE_TO_CACHE:
 		netfs_stat(&netfs_n_wh_write_done);
 		break;
-	case NETFS_INVALID_WRITE:
-		break;
 	default:
 		BUG();
 	}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..e9a155265758 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -48,7 +48,6 @@ enum netfs_io_source {
 	NETFS_INVALID_READ,
 	NETFS_UPLOAD_TO_SERVER,
 	NETFS_WRITE_TO_CACHE,
-	NETFS_INVALID_WRITE,
 } __mode(byte);
 
 typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index f880835f7695..59ecae3ad0fb 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -77,8 +77,7 @@
 	EM(NETFS_READ_FROM_CACHE,		"READ")		\
 	EM(NETFS_INVALID_READ,			"INVL")		\
 	EM(NETFS_UPLOAD_TO_SERVER,		"UPLD")		\
-	EM(NETFS_WRITE_TO_CACHE,		"WRIT")		\
-	E_(NETFS_INVALID_WRITE,			"INVL")
+	E_(NETFS_WRITE_TO_CACHE,		"WRIT")
 
 #define netfs_sreq_traces					\
 	EM(netfs_sreq_trace_add_donations,	"+DON ")	\
-- 
2.47.2


Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D443839A8
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782332030; cv=none; b=dAQPLU8k2F5eFoUMq9IUZk7l99VrTEmmW+HQrmBvz5taiBexD4X0D9n96u0o+u4Oansnov9tMxmff8C0HAq1dtODkMfDM7CpOCPpAYKZCbmU4VClCQ3y5oYaEFqg+hjkhHXSpGr9/jdugPFCi0ODiPKKTbvVNK0QcM/v+TdHoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782332030; c=relaxed/simple;
	bh=xI5xcvp5mGEQ7XhRqOY4Tv6Va2uYix/X6g+VU8h4FpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSaLVgiSrwJ4DaYmGchkVjpN364XtHXCumJ85c3OvlZXZAzApgz+KPohRls9mGDbDZJVJIo9jOlIlVhZr/ZMq5w4g54+OSmkJbhk+AwA0XsVOPhoCFUN5sEDCIWTXsmpKRsiAdNMOENu3j+Aq+XQVmSt18vO1gY56hA442X4xJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2TXPF1D; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2TXPF1D"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c887ad05211so39076a12.3
        for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782332028; x=1782936828; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqqyVxYSR69pT9ofMMz2pm4tMEW2deyHKj8QeIUn/cY=;
        b=T2TXPF1DIRuipEXAoiwU5P1iM/MT1bBDAxfbvDX7XBx4vhzTNOl2TMVwYqyLPSFj3l
         EluMd2SH/6RK7u4m1Xgfl+9O4fCvzjBV1Rp9h6MiFb5KPJTQjynmBmKPEuDsYS0peL6q
         ckrT2tVZXj3cvHsQ8vAwAkEhn0/qDvNlWiUA+5r0Prv0T7fapK8ac4GquQ3xLQoLr1if
         9VP4WZ/9GkE2M/mDabxPnMKnGfd4O2pn/jxCR4rz/pGjpl3gxOxa/gWNi09GUgMo4xql
         oYL8TVF5Jy1irujlfXC5G2/lpIlqAVWB+IasgK2T2B7TlifyzOhIhHvK6FM0BuzmlmQ8
         GseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782332028; x=1782936828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqqyVxYSR69pT9ofMMz2pm4tMEW2deyHKj8QeIUn/cY=;
        b=fG72HXKNJ+XTtxOjWQsvVLCTIWO8eqBC9kHwR5xt8T0bw6febArblSgQomcWWqIqLx
         kFOD2lPPogs/OAx17ewbnm7R0WI3Vk8xfFVHos4l3A55EZwyAXj8LHyn6VtBrj/wJDMP
         65K0tegyna7zkOCKTiUSvXDP3zPhpycffcb5Bu0COhu9pwSmxCFgYZTyDTSP1Iya/7u7
         QboHfTZCvFocoQnd+fEKiV5q3zuHM6IHYag8O9QmcwydA9zX6x7f8fOMKOeQzXr7ORlt
         N4ENIl3HhTTcN6J1M6slqp+g/DNU2Si5TEdwgk4Jfy3PRoijYQAuBur4XHl8sW+64gmP
         l9PQ==
X-Gm-Message-State: AOJu0YyBH9mvJE0biZqKVz08p8hLtWoP/JweX8GDnYIGHw9RoapyLzSW
	R3RhmpGUDkNQ0ibVyZofBhphVT31zJtFEfwaDszgy4NqoC2Ptjpq92Fu
X-Gm-Gg: AfdE7ckOx8n8P6e9UAaYuFgZW0deXVOEjatBfdNdweRTzF6h2zA9hpEfw0SoZ34DDDu
	8xgWOVYixRqDAywMcON2M5cVQBd7bg6bzQkwI3lUJP1vVz2tp+bkkM6YVpcrVOj0BXscHU4i7rv
	C91qf0dVkRvgFTcOdjeF6e8h1W6TrVzzBr8d6SHWasDB+MDoTS9ECih8B6S5OhnXIQKnUFhNWPd
	34oYEdLR6XSPWuS4Tiz5TcJ7Dyftto6FdvoyKps3lsd5HZMeIq5MwhD+zqw1cn7ibLqyaNnmocu
	GAdVM4Fq9qz0dW2LLhg4VfTrI0XG3Y+qIDsI7YVZ85TtsaSvhoU2YuE56XOjd8joEDj14S0DTgn
	t3TkUAPyy+l5AKVtXsIb5WHTGJrwigBitCMjI6usuCcIddmltbE3SxZEyS63DI81PzrdlfcpvfE
	7CUsQ7F6AgubTm
X-Received: by 2002:a17:902:d4d0:b0:2c0:b359:99c1 with SMTP id d9443c01a7336-2c7bf10e092mr50660025ad.2.1782332028375;
        Wed, 24 Jun 2026 13:13:48 -0700 (PDT)
Received: from pop-os.. ([114.4.214.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63d245asm4777925ad.58.2026.06.24.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 13:13:47 -0700 (PDT)
From: Yudistira Putra <pyudistira519@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yudistira Putra <pyudistira519@gmail.com>
Subject: [PATCH] cachefiles: reject copen before OPEN delivery completes
Date: Wed, 24 Jun 2026 16:11:24 -0400
Message-ID: <20260624201124.120004-1-pyudistira519@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cachefiles_ondemand_daemon_read() creates an anonymous fd for
CACHEFILES_OP_OPEN before copying the OPEN message to userspace.

If copy_to_user() fails after a partial copy, userspace may already
have observed the OPEN message id.  A racing copen can then complete
the OPEN request before the failed-read cleanup finishes.  This allows
the OPEN waiter to observe success even though daemon-side OPEN message
delivery failed.

Record when the OPEN message has actually been delivered and the
anonymous fd has been installed.  Reject copen before that point, so a
partially copied failed read cannot complete the OPEN request
successfully.

A local reproducer that faults the daemon read buffer previously showed
COPEN_FAST ok=1.  With this change, the same reproducer reaches the
failed OPEN delivery path but copen is rejected consistently:

    Trials: 10
    READ EFAULT: 10
    COPEN_FAST ok=0: 10
    COPEN_FAST ok=1: 0
    WATCHDOG_TIMEOUT: 0

Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b62cd3e..72fa413 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -143,6 +143,7 @@ struct cachefiles_req {
 	struct completion done;
 	refcount_t ref;
 	int error;
+	bool open_msg_delivered;
 	struct cachefiles_msg msg;
 };
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0849eaf..16136ff 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -196,6 +196,17 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		xa_unlock(&cache->reqs);
 		return -EINVAL;
 	}
+
+	/*
+	 * The OPEN request must not be completed by copen until the
+	 * daemon_read side has successfully delivered the OPEN message and
+	 * installed the anonymous fd.  Otherwise a daemon can use a partially
+	 * copied message from a failed read to complete the request.
+	 */
+	if (!READ_ONCE(req->open_msg_delivered)) {
+		xa_unlock(&cache->reqs);
+		return -EAGAIN;
+	}
 	xas_store(&xas, NULL);
 	xa_unlock(&cache->reqs);
 
@@ -469,6 +480,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 			goto out;
 		}
 		fd_install(anon_file.fd, anon_file.file);
+		WRITE_ONCE(req->open_msg_delivered, true);
 	}
 out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-- 
2.43.0


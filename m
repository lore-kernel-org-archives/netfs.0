Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172F2F12A1
	for <netfs@lists.linux.dev>; Sat,  5 Sep 2026 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585539; cv=none; b=kNvhP33wDrBZqXGlBN6ARWapUwX0Zk/CeagX++cHfgKV2hKxajeCC0fXL0xV4ExDHYGlTqGjh5fks/z9XHrZq0H+2jeGc9us/lkA1bG4e0SRPZWl8y7xZ6mme9QUI0Nf6n4BHN2iCCuvErwOAzweh57LLm4RrdaIxZp9DnNUEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585539; c=relaxed/simple;
	bh=UwfSi01JrjgFFoyq4nGcZMTUyyfTi0iyb+hO2kMTbno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HebeynNmZ3pplMCBO9FzgxLJXU5OZTbNq/m+S11+AeiSFl9t2B/lBA1b2r4ciq71QOeUsilImsmcliE/02Vb1dhhwl2/X4LrjlTUrXZ35oz/SkKje/ceG5eHf1OWgRDG6ehU1Yd8JPjUv81iSfUzLh1uNxpPQMSMuxJFb/jcOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT+4bWLE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT+4bWLE"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48436216a98so1144302f8f.0
        for <netfs@lists.linux.dev>; Fri, 04 Sep 2026 22:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788585536; x=1789190336; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YP1AYjVYNbHbr+XqRGPctt4NDejyNq5oyC8iI1I37GM=;
        b=JT+4bWLEaeU7L+8wJuXEFhuSO4OaN4Kf1xAbskEgaCLTSlmKChKW08HuHphpJ2W/LN
         6Z9WJ4k+7SXv6TJB/SXGOd2rbSV6eB8uUZmoz6Iwx4q/+fKOVxgqGVQSmZDXR9g2/cpt
         BTSIqHPvEdvXaW86m2QANwt4Ia3HdqiGoS5OSAaqcKZlo1yocnLInc8zrjqZcbv/whj1
         oIQ1mPFlXjfhuQLE7cYmhFDC6VHbbrhmwqqF2xriDJMr/mUh6zKylxpUPHwD9aChB4JJ
         JzxAnM26/DnoHWQor0Nn7sV8pjs5k4NVlKTQBGVoRZOpRcm2aE+Ar/3GaJbg7JfmfYL0
         Gr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585536; x=1789190336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YP1AYjVYNbHbr+XqRGPctt4NDejyNq5oyC8iI1I37GM=;
        b=VSkxtfOd/oKUR/NY6w8KvS1TxHRmYxyKCOiayWrlvwJWRcq4uIWqGJ3fYNHT9nB5/5
         fT51MR1ys+Yz0EINIlmeXl0ijNki9/AOVFEzygefs1+/hRGrxcz7dUf/hzD1bq4KFm58
         5t6ds7I9Z9CNTvHqmFh9ox6Uocd6dhpJsgMWDgPY6/fwNIJLrl83r9mTHgp/w/x+5v7e
         NMEGhH68qC6jreNv/E5n9CQOE1dHnqZO3wabc91FpVU7j+3en2889geWbKoOlV8Iqeqo
         kqEn1d5fKOjVpV5HJdKwrHeK44sC61AxHc3LOZlXbnDULu8jh7ZdRczjN3rpHFhqV82G
         OBvA==
X-Forwarded-Encrypted: i=1; AKwUvBwA2Ky4G3WxOPaiVn2U43fi9kYeZGv8IHUOuTx1sVwEKpMv9PV0UKUMUWcrCDDMoSsEC1clTQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nY8BQGmizVG0azYHp6zKfcOaG3bdcF8OL0ULeMzYD+GE3FFnUe
	w2itM8WQbRvE7mxoXeipvJvox4NRpu5IPF6XXzMQ7ElsJDDZbrNs3+1T
X-Gm-Gg: AYBFou1NEIOVhASSHyK1C4OAbKmbRVWmP3E6pav/IETLs0TdNTb7T6rP71Fxt3EsYcC
	F9DQG0ScoC5rapZdMlqecMLsHc+1uewicQ7NkhEVRsl8vYrPAo19/yiNqG9g5+ivq67YJPLjM8j
	efy7IeAuy5Y9LDdm/Rqk2y4eXp1uguAjq2qA5Rmt6WcnOT63w4WulP2WkWC+fJ2nLzAV5GYKwwB
	2qi/F6uyF7ZvHqyEdL/+Rumjrtt5hmMzS4QXPZB4ZU6kvjp4mXcT9YKr8Z6mWoEc5Zn+AffPVPX
	t0YD+IH5oNAPnkTfckL/j/Zs6mwu7cquW0iiDjX3AgJC/MHqpcVdhPySdiTXkUsldA+V3XgGW2g
	yo8jGNUxFMJYQEl0KHG50onfkexmyZuGnPEdTMQIs7kLWUPS0u+5VXNXF9yocJkFQcLh/xOH1rL
	JQ0E5UJCLunpPOiN8qbYGbiLwb1biYrEyeqWKoLYb5Z3LRcSUZrxR8YMWWtr/yCdwtwK6rArD2y
	5Wa/L+wBoL5OWuu60ZDXevODTixA16/LPF0zZfa9ddwypDzroI7eOsTIC77OvlZ6Gy+0CCJvshQ
	NjW+bs6he3gPhcHQy5UkHpQUle2zTBFEBRMdWQswLCXSUCaK4C32VctdQLH80hAo9lQ=
X-Received: by 2002:a05:6000:701:b0:485:8c17:9766 with SMTP id ffacd0b85a97d-4858c1799b3mr6894505f8f.40.1788585536473;
        Fri, 04 Sep 2026 22:18:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm9581135f8f.22.2026.09.04.22.18.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 22:18:56 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix the debug module parameter description
Date: Sat,  5 Sep 2026 07:18:51 +0200
Message-Id: <20260905051851.11516-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugging mask is registered as the "debug" parameter, but
MODULE_PARM_DESC() attaches its description to "netfs_debug", the
backing variable, so modinfo lists the description under a parameter
that does not exist.

Use the parameter name.

Fixes: b900f4b89b4d ("netfs: Split some core bits out into their own file")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/netfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 927badf3989d..ec402837aab8 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -22,7 +22,7 @@ EXPORT_TRACEPOINT_SYMBOL(netfs_sreq);
 
 unsigned netfs_debug;
 module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
+MODULE_PARM_DESC(debug, "Netfs support debugging mask");
 
 static struct kmem_cache *netfs_request_slab;
 static struct kmem_cache *netfs_subrequest_slab;
-- 
2.39.5 (Apple Git-154)


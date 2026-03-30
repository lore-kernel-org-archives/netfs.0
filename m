Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453173C277F
	for <netfs@lists.linux.dev>; Mon, 30 Mar 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868161; cv=none; b=QB+vtVuVnLHWGEHPKUBZU/5eB42InqXTq8jDouREH3V6qbm5DIdrJ3Vkccf28WM0tvd3z+8FAzAkofkRYIUX3koEERxAFRJRNe18JYJL3CegOwcv/66oTzzwu1hR1iNlsLCPusi2JeGaLPOq8iaN9iqdy6hWqbAVPpAgdNhH8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868161; c=relaxed/simple;
	bh=ztpxb9hQu5tkAcfN8a3ttcSKgHCqdHEOgG+ht9Crucs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syPjoQJ1r7WsCQriapRV6/h1WVgxUK36LiwjaeN2D2Zd/svgqamnJXyRW9cAG0uxfWCzgRiB9YfH8OhgkbR4TX723Hvpgij9WUgSNtJO3QifljUSrNteR07nc/RtXdISwZb0mzb8G0zFSAeojtpcI40Zag2Z5mWCBPjPDC28bZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RA1WKPGv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RA1WKPGv"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b9144790dso2324617f8f.1
        for <netfs@lists.linux.dev>; Mon, 30 Mar 2026 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1774868156; x=1775472956; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgOUnrTeGkoKfySHKsNvdoK2i879eNBFvf4HV8oBRY=;
        b=RA1WKPGv4ADIoMIFJm1RaPAyGvzP0Glys4HP+ulRWQ8cT0SRqWwpOsWkGluG98gKQm
         Vm8V2VxBOn1MyDt+wkWeXr8ylkJpq7FgIqG3jYO4CnbCHN6ecC3MQdYTIyFvQKgoHtVm
         R4fVqAlggd6XHvaGdUB8YlfulpysYoI9QAVz0OExNSIlCrF9jJOl1xRZmrnXe/0a9qRE
         odo+PJ5T3Jnk8MABwiI/h3iWjoT+WQ83TspFbtDn8UJKKhEd25Rrcg4A0tKOdq3whCfU
         JxEhIbZQ/u50o9Ae8RfAqdPCU5G/AUdQhBXAxODwYjRT6nABkZad3aZdx39HA+jFLeXG
         om1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868156; x=1775472956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqgOUnrTeGkoKfySHKsNvdoK2i879eNBFvf4HV8oBRY=;
        b=lwirjZ07t615dO0WXnsFF+tuzPVnyyEm65XlZiXhSHwRzrm2YOWFXkhUS7Hlg8ykvo
         V09cDnr+mgEszSodCVul2w04gP7kklfB530Qo1iRqgs4mgqrruw4N+TNQlEL5buGz8t5
         nHbX50W4G/lFG7Im8tpJHWVgSdkjfQzxTyUVXBpzuKjNaE5FvAh0M8K1F0OKKgHBVck7
         imKZ7LmIXCcxt9mgKG2h9dGVTt7RfRva/JcB5HTaRGgDmz3HxyLjSOGC1eEgIrvOfdbS
         sld3IRIiUPTMfvNh1NYFQ1x7v1PRKduuH7o49RyWo+Ij9+DdZX2CaqifxZXBwOp/P7Co
         gFoA==
X-Forwarded-Encrypted: i=1; AJvYcCWkD7dwdjEsjxC9G9kfz4KvL6O7sCyEllLHtpm+HDkyzlwwD+TWV0HMAT8GWln+aUNfVuYBjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwygY2qSSbLB8E/Cn48VhnnTMr0x5kuE/4bECHdkUotoba+1cyo
	VZNjCw5FLZoqe/K/zOaaAKFz64b/K8I0JdBEhCXgw7RxsWEgJn/JBcLkcpYDjV49AZc=
X-Gm-Gg: ATEYQzzwMjUibbSLvcp/LCRhuR/2czejKWu9tPsE7GJIE6wfTt6rVHE4UY9vN/FZUFZ
	m4oD303iH3nfuxp9d4TpODyGuE12KVWTJrj2IS0obO6djCDRsvdoDYRf2mTuhjDj0l2xhH4W50D
	WZsYZCQ+oQhrV4nW1Jv7pp6tuoubhvt9uIXmnZApdjxRgdgGvGtBxhm6hGrttxHpj1PbSLHqV71
	iZ631BhO6oIhTqcpFSfWS2wInh+rDPL3FEpu6jf8JUxIvLvs1ovCfKLCZIEW5dfc5yuRCd3r0QM
	OahIskcLOViaxx9Dej72dBmHsGkjuCh4DO36SrwtzciP9Zai+Ph1nyV+ZBqB/PHoIJhePg7ViOH
	NtHGd6qOGoTvnv0lHWMbWXR8acyvqV+CC7IgMNdmareqP/4dvaANwmMRoAJ7MuL2VESHpWE6BKt
	47x5HjMrng1PXLfwsn5kNaeLb+VDyXitP8mRYGMeWg4KzGwrgLh42AAmx5F8KwHlf1CG3Z0fjEi
	Zce8zAXX/Gb7NMPkHUn9KfeD4SVaOrd6BvXrQ==
X-Received: by 2002:a5d:5308:0:b0:43c:ef4f:79de with SMTP id ffacd0b85a97d-43cef4f7b6amr11247379f8f.16.1774868156221;
        Mon, 30 Mar 2026 03:55:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf330872asm16371655f8f.17.2026.03.30.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:55:55 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfs: add missing folio_end_private_2() to netfs_pgpriv2_copy_folio()
Date: Mon, 30 Mar 2026 12:55:48 +0200
Message-ID: <20260330105548.1371339-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This deprecated PG_private_2 copy-to-cache path can leak folio private
state on rolling-buffer allocation failure.

netfs_pgpriv2_copy_to_cache() sets PG_private_2 first, then
netfs_pgpriv2_copy_folio() tries to append the folio to the tracking
buffer.  If that append fails, it just returns without calling
folio_end_private_2().  The folio is then no longer tracked for copy
completion, but later invalidate/release paths still block on that bit
in netfs_invalidate_folio() and netfs_release_folio(), so the folio
can become permanently stuck/unreclaimable.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/read_pgpriv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index a1489aa29f78..ab73fa62378b 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -55,6 +55,7 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 	/* Attach the folio to the rolling buffer. */
 	if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
 		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
+		folio_end_private_2(folio);
 		return;
 	}
 
-- 
2.47.3


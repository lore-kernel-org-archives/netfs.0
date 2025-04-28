Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AB255233
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845917; cv=none; b=pRo0rocJlRU8r788TUA6Vkw8iEwas2bMR0qu93XX5NcWqW1aRJyCtwElyM5JonlCcqg6TkheogHVzlVTUeZUTr+v9iytRZ2t0T2jPxymr0wLCBZtwNRnIewKlEitfgw2tsX64JNYD44nSVlpRCm+68ikZsyMv/fObIZsYW9Z0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845917; c=relaxed/simple;
	bh=vmT2BPuNeQMRR4MvPACHB6GbxLQA/K2IZKLlEqetco4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dx+hPUTZpPVCSR+DvOb/3DgBo7VIY42fOF4ZAFX5AWq4NEA2OKI/ah7oh+5VXlN5YeeomIef5Ho5lJp52Xq0UAiNjcz2MAcFFZyW/3/lT17qw6CfvUHn+7cFTAx1Lhl5slTneXmNMy8sBXg9rvg7a9uGFufxHM9p6J2eF0gZosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bgCNr9fs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bgCNr9fs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3595199f8f.3
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745845912; x=1746450712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4J207YyuAGkV1CbUzAQtkN//0ZWB3j4SQpv1vFi2Uk=;
        b=bgCNr9fsQDYK/VP1wZ/k2VFGZExfwio00orC4qqe5en6RcjddspBdiZsZrDxaTZsy9
         lNqpcQN6/I91Jc2Uw+GtkqmSQT7KZwlllrOBAgBXSzXoB5jBQRrSrz7Wj3My4+uznMTV
         BrFJtjAKhPxKNB4jM8iLdxnAXPkbSAlKfaE6ioeL/+tBMEfYMoti0vGfE/m7Dk8tgmvk
         ZTAXqGxnoGBWOEXozI7AuJjjL0e4F7yD4zBRGlVDvky4PoiM6+7wz+Hvs7e5e+xeAaR0
         tMjIeE0EusFJ50oJCIvtN9w6vpJAuHN47pO/AlHW07vwkF3UV2/ZAISh30Fgs3OmE6yy
         cYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745845912; x=1746450712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4J207YyuAGkV1CbUzAQtkN//0ZWB3j4SQpv1vFi2Uk=;
        b=fqhHVOq1Kwz6wkQsU40L/urTBJyxCy5zPlzjjoFMzrJCw5giIx8UbzzUxpAAyrOk3F
         GPXfcX1ZDKizmwHGkEVgP/Bga+rBeRv2MFesEHiEddBRi1CiP4YT+x/uW5G3pk+/CbQH
         +hElezWv5cFK9Iy0+AfshPDy5Es/2ObcTmaI/UBe1q6afHMGCKAQELqjfVukkD4+oEPJ
         4TkzImP3CJ7y2awnuAuswLVtWHdOqm6dT17oKnjekmb/26OLsOdGfBqMsC7b/XhUoNNm
         4Z2vw+ENFLEG/UXnqlo3ROcRlIJ28iHIsW45R4Al6sYEwkUi8TmjBZdT/Bc9dHnM9MOp
         Y9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2HDzqhi4iz4kiKlg6RpCpi/8qtA0sQjGGWFoVjT2MboP3laODZqj9JC3RGh0oYW+V98re/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2C3uXbJEEbzaIk2QRDfM4Dtsz7un4dfdGh1a9qZW4l0MGpKOt
	id0EddfNrrYLeRbZXBEKJd0DCjyGH78wWA55KHdeOVIYn9IHts3yzm3sks7LLuA=
X-Gm-Gg: ASbGncuc4NVF1FNY+DT8CWjplLKVkp84++YjwTYFJpv0KCoOSpNwpSuzeSYs0otTUXP
	KW64f9KOzz1BhGBe8U6tUssP7VyU9Pyq64Qj1Zw56SDXKFtUV0v/QNe/iQCzIID1wJr7P56wQ2D
	tYgeheDvRqsqeSpBnEAxyKiKBp77UmEGOqdAVvwVJPtCTqdS27vgonxCMS8n4nMk7MtthevsLrG
	dyYbO+ydbplDhqe3cqkUw0BB5Iz6SYteCQFfIUYk8qqSBOVdPHe42ArQONKobbKd3dNM1pYVajg
	eYF98vTw77941SP8fh6ckXwjUTTIsb/mRbvzhunXE5fV3LfUVSNhuvI8JF3vy+HYh0QrPRcyqpt
	w3F4b9RH/iOXK1wwp860o4UDDmIodgwTKJUQkqJH5
X-Google-Smtp-Source: AGHT+IFeEs3neKdh4mQxt/dEhTHmRuQ9dywG7AxB1fh+tdreaTzRhkNeBWh/xRaAkPWiQL9l+gfCpw==
X-Received: by 2002:a05:6000:2405:b0:39e:cbde:8889 with SMTP id ffacd0b85a97d-3a07aa5fe38mr6168054f8f.6.1745845912502;
        Mon, 28 Apr 2025 06:11:52 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53031acsm122256695e9.9.2025.04.28.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:11:52 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs: remove unused netfs_io_request flags
Date: Mon, 28 Apr 2025 15:11:49 +0200
Message-ID: <20250428131149.3195399-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETFS_RREQ_DONT_UNLOCK_FOLIOS has never been used ever since it was
added by commit 3d3c95046742 ("netfs: Provide readahead and readpage
netfs helpers").

NETFS_RREQ_BLOCKED was added by commit 016dc8516aec ("netfs: Implement
unbuffered/DIO read support") but has never been used either.  Without
NETFS_RREQ_BLOCKED, NETFS_RREQ_NONBLOCK makes no sense, and thus can
be removed as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/direct_read.c  |  3 ---
 fs/netfs/objects.c      |  2 --
 fs/netfs/read_collect.c | 14 ++++++--------
 include/linux/netfs.h   |  3 ---
 4 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 5e3f0aeb51f3..f11a89f2fdd9 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -106,9 +106,6 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 			netfs_wait_for_pause(rreq);
 		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
 			break;
-		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
-		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
-			break;
 		cond_resched();
 	} while (size > 0);
 
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index dc6b41ef18b0..d6f8984f9f5b 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -64,8 +64,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	}
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	if (file && file->f_flags & O_NONBLOCK)
-		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 23c75755ad4e..173433d61ea6 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -83,14 +83,12 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 	}
 
 just_unlock:
-	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-		if (folio->index == rreq->no_unlock_folio &&
-		    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
-			_debug("no unlock");
-		} else {
-			trace_netfs_folio(folio, netfs_folio_trace_read_unlock);
-			folio_unlock(folio);
-		}
+	if (folio->index == rreq->no_unlock_folio &&
+	    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
+		_debug("no unlock");
+	} else {
+		trace_netfs_folio(folio, netfs_folio_trace_read_unlock);
+		folio_unlock(folio);
 	}
 
 	folioq_clear(folioq, slot);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..e0c3a63f4f86 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -268,13 +268,10 @@ struct netfs_io_request {
 	unsigned long		flags;
 #define NETFS_RREQ_OFFLOAD_COLLECTION	0	/* Offload collection to workqueue */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
-#define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache from read */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
-#define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
-#define NETFS_RREQ_BLOCKED		10	/* We blocked */
 #define NETFS_RREQ_PAUSE		11	/* Pause subrequest generation */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are now queued */
-- 
2.47.2


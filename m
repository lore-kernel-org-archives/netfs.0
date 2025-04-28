Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36111A7045
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873269; cv=none; b=PInMOadFHj/4Nn4NarbX24/If1JnAiRkIJznoAO0hMu3DDnfsrD6jnBTDV4KpUEaLi/e1jp6uWjmc9HpKAbqZDenfEQBVHM8Z1HWkMe6TIrbjccQ7ok2w1dCMivx89wl0FMp0r2+LoHNh4Da369athWDWhp/dzyLyFAwKJrX/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873269; c=relaxed/simple;
	bh=enIVs5dQifBMz4z1G7vwxdbmti9Me+ulWTX7ccL8yPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEFWD2zd+9/4Ma3Paqsx1uMTSYt0PciFRIdwNrIYmuuzbkkydaPPfDlrwZXJq5HLcROG8wYOwkfOpGKFQNF414TfeJnlmcRus15mSBBOonG3ioGhEMBACxLkSiUtMSyWHdbS6Pl+E2hp3rJlyDKK7uSBN6wGfCnt+JUGeP0Aenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cLPQvhVt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cLPQvhVt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so49695775e9.1
        for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745873265; x=1746478065; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qozprAcAK6hNuz4heaeJkgS7NDgBnqM+GK7PXfa7ODA=;
        b=cLPQvhVt0xty71X/V2oOA71/SmQwDgLPeBGELmkCEonUjKraOrsY5+CJsGzASd7oFe
         vIjB71OP5ngwz8RnYeX6bIwW4DowOejrC2wVOrT4m6x5kDILcdfOQc6874GH3x3W6opd
         1jAP9Iefte/Kv3NyRRjZEtVLGFzbH6Heu2UgE4CYMKoPs1/TxWk0jFGfJ2trNxayx+j9
         lbGHs76rlsrPK7wus0vPmx7bPSBE7hEnRDWVZMceerkxoZVZg1KwYv324kivUL5LxEUh
         +UkunOukng32kRLBprVMu8byYSp8X7nw+WH/GxEfuxk6yzQuOmnjnq2T+nC/yUMpT5H1
         thoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873265; x=1746478065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qozprAcAK6hNuz4heaeJkgS7NDgBnqM+GK7PXfa7ODA=;
        b=tREPkT5niogz4VyVFdk7xN/1ceEnhYpKyqA9IwSe0aoQLS9UBbFqD36HtD20AWCkAf
         kGBnYBD8KkKQUYcQ9u0ClXexLfc0p75ChWeC4l5yScK7Pi/XHV57iWhCg2O8OTKPXBb/
         Xnmb4rpFUAUtWV4PQRp7NiKx8JLoW679dCUiENWlmvONn1gcUiRxUmQeP0GDGe00zuqQ
         0hvNS/R3rXJBERIiEt24ys/fWLYZr3j/Jldfe9rf93vZW4UMs3IhtgWt56F5H09p5Ex4
         /o6aYNcBO4bQ2Vu9ha+exG4SGJK9LNTfBnJ1uGUPbmj9JzSfE43apfGHOYqP6upH86Qu
         tXig==
X-Forwarded-Encrypted: i=1; AJvYcCV91G6HZ6stNzcLjo1ezDdwQqhMaAdUVasXZBnd8ISclQOG8mvdqUBgqLyK4sIDTwdwyp//BA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3U/ZudkXavZ9IojZ+pTbyNEYFv9uXeZBEr4wbzua4/sVfPJfX
	3O9tfHi163hrSU6yRuKnuJu7vsx4aljfnFa9RD4A3FrlI5JNAqevP36msD1w47c=
X-Gm-Gg: ASbGncsTA+yMJFfi27XvdH12mypFG7jvLyIS2MEDbq2f8BwCHpHFpyVl2M+DFTAd7Ry
	wh1TChXOHx6oJckd1eMH7DvnCYrYAodLx9AJuXsU2hYZeLTdPA+5zYV18V+kkBM63uA3LYlefnn
	b68ebuH4V/bM6vqOiSO2j62jz1RrpQsTgsRTUL9gkO6PW6vvKhLqxJhDXQDOzcAeYmjnhNW4yEC
	XT+LFZjSlTA7hsaQPCoufNLRN5Bgd12eTRGhi1xDeLaLytyFhdDXqPSuPQkZapLiCb3ogF0F7jP
	WHMzY7bnpCvy+KBTZgNC18TpGkeRVGnISj6/wl6A8VXoT4Rc1IXC4TqtzGR2JQvjl7DmUj4yG6M
	8x1iK/LaWiLx+47i0DWVQ4E+gkyyrkdbDk92O5v/q
X-Google-Smtp-Source: AGHT+IFLUDLxJ99cgSmn36X6Wg1jyEYbmqHCL7bpSE8/qYfb0DrwqBuz3clea8rZtc5UxvlGtdqV/w==
X-Received: by 2002:a05:600c:384a:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-441ac85cfffmr7214575e9.17.1745873265189;
        Mon, 28 Apr 2025 13:47:45 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29ba29sm168590675e9.7.2025.04.28.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:47:44 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 1/2] fs/netfs: remove unused flag NETFS_RREQ_DONT_UNLOCK_FOLIOS
Date: Mon, 28 Apr 2025 22:47:38 +0200
Message-ID: <20250428204739.3405489-1-max.kellermann@ionos.com>
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

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1 -> v2: split into two patches, see
  https://lore.kernel.org/netfs/88831.1745855591@warthog.procyon.org.uk/
---
 fs/netfs/read_collect.c | 14 ++++++--------
 include/linux/netfs.h   |  1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

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
index c86a11cfc4a3..ab6f5e0c38c7 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -268,7 +268,6 @@ struct netfs_io_request {
 	unsigned long		flags;
 #define NETFS_RREQ_OFFLOAD_COLLECTION	0	/* Offload collection to workqueue */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
-#define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache from read */
-- 
2.47.2


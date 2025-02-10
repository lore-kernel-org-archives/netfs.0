Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC451F4639
	for <netfs@lists.linux.dev>; Mon, 10 Feb 2025 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214687; cv=none; b=QfaB/AbBc1LFjNyMMeb+mxZTd2wpG6IhYYJt2+13ZBFpZvIEXsyet4Bt7HFcXV68Jr2hNuXAu/5VzP4FbBNGMBxsjZxxepbVH56/ckY8D2CU5FY01rAf06yKjruAohULeNN9ia42O2GqBVUhhyqVC5mHYhpbhc3VljPVT1DjZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214687; c=relaxed/simple;
	bh=FuRalVomnUo4fAYGb7ePQCR9+STX3xDmBsVlwWk2WsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btRflk5muZGM2YzIlqHwrEhNJO8hsu16KgUuF1HSlRaSo8vxTUtR3CT9elQlr1ZUo50VvhESsYyue6hU9GlXChAFcVzkCN+QdzAbJj/DjK+ZGeMilLuIsZPkslKzCWQeuf4GvAr508YfWlb7FzHVp4SOQGlPjYpeybzKgafjo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Tbs7Ean9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Tbs7Ean9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7d451f7c4so83352766b.0
        for <netfs@lists.linux.dev>; Mon, 10 Feb 2025 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739214682; x=1739819482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRdLgzD1wD3MEmKM8GjV3bFdVy6SihSEQKzMmUmzv9E=;
        b=Tbs7Ean9tvLQDTWNN1rNh9NtawFA4ccwu1RC6vVqEV3vKPkN4IPVwKZcoyQV0pcp/i
         4hGaQPMA62/86ahWBKY9UZ7cKJZVjEOjfK7YnmZ87ApKme97p31Mg3cpJPeO7MXYPP5A
         QRnRaKvrB8cLpw1nSspVsin5Hz2WAVPHkB1Nf2QHjiqTT/bqTS2T962qy4aFZATg3XxK
         cZ20iHBtlxsURcVkqdQyKiEYGuj2JyNL4vuuSuJ63YTMUkvzTGCjSDLOnXUXQuujYRdk
         y/3/ENYXEZuInwg807KnckzXlaCyIMgv9HeQEiygqnMrUexkFQubpLe9980PHew4IB1g
         IviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214682; x=1739819482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRdLgzD1wD3MEmKM8GjV3bFdVy6SihSEQKzMmUmzv9E=;
        b=VPJvm5pJ+l7kHFE92PutcvVt2BNStHtpCKdKG4Rs5jI6uFpEr7ljZEE/5yjMv8OpEr
         nbErke3FkEyqudgJzpwCojDvacR26UbFkbbJ6Ay0A97lLTh/CzcNlvgDMZDAordqaRX4
         w2lhPQMwlGwMXW9miSI6jolWyXwO5VyKiIAySUB3nBDew8ioqR53EYgVOH0JYnp2Ogm7
         cIseua5ZmSjXbbAdwOP/FslTTrsGxp4WRadIEyWMUUpr3/5EQDRQ+LQxsJeMfvE+uSeZ
         JT6oTZD6anIH0hkXRRTd8//Mki6UwjWGP2ymwoI8T9e4bRdqyu4E3/W69WqXGrgGKus7
         JIqg==
X-Forwarded-Encrypted: i=1; AJvYcCVUuU+8huzLVHKSzpxxX2fNSBOLNLIpfiTWckY8I3Q7u9cRcVrGzy1IwTy4c5XAJpah/a3L5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTppp4ucoWW545W55sGC/R4v/8sd+/H3vg6zAHvdrZXpJbwZwX
	4ufEcDONb0O041kopihuYO/2y79iTJzXHEpOnA1ZWuLosNhlU5BDmRooroBYbJ0=
X-Gm-Gg: ASbGncswwi7LD852byDUxQsmpM8GEbWKR+JvL3A1Fu+E0fp00Au0L2grWymK92bK6us
	bT3zhzXC0iR8g0yalD2TjudtbpF0X5rAtK7odA2WRVqV8stIrPF84Qbb/u0MaMcprffGW1WUPO7
	lOjIQc6EcwF8DOlIDjBUr4iYAMmKYN366Wj/tChRtE0Dd8zrLXJakOG+E4nS3zJxE8kiRzAkaFJ
	74Z8bay7HnjWXAUdRg4j2YVdpt2kNph3qnEKq2yIA7YFiYM8/BnKpLgOmjpgYdX+7OrnT/mT3pC
	5HgY5KpWgRGrFBY4Xymd+WSkGXnJeLTNLwwv+zKeMs/iViR5/2Rqu7Y8qoKdKCqFXrTTGCWuYAV
	c/TWQidapaovCuxw=
X-Google-Smtp-Source: AGHT+IGhMqK5v2fSt6EV9RNWf/Z5VkBUx+UNoSTflx/SUbiE5SXTICj9mdVUZA6Z3mG7mSkQBoQAnA==
X-Received: by 2002:a17:906:4fc5:b0:aa6:79fa:b480 with SMTP id a640c23a62f3a-ab789a6b504mr1707903766b.10.1739214682515;
        Mon, 10 Feb 2025 11:11:22 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f19d800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:d800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm812424766b.102.2025.02.10.11.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:11:22 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs/read_collect: add to next->prev_donated
Date: Mon, 10 Feb 2025 20:11:18 +0100
Message-ID: <20250210191118.3444416-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If multiple subrequests donate data to the same "next" request
(depending on the subrequest completion order), each of them would
overwrite the `prev_donated` field, causing data corruption and a
BUG() crash ("Can't donate prior to front").

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com/
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
David, this seems to fix the bug for me.  Please also check if we need
a "donation_changed" check.
---
 fs/netfs/read_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 0d95cdbe5611..681b630b4f06 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -284,7 +284,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 				   netfs_trace_donate_to_deferred_next);
 	} else {
 		next = list_next_entry(subreq, rreq_link);
-		WRITE_ONCE(next->prev_donated, excess);
+		WRITE_ONCE(next->prev_donated, next->prev_donated + excess);
 		trace_netfs_donate(rreq, subreq, next, excess,
 				   netfs_trace_donate_to_next);
 	}
-- 
2.47.2


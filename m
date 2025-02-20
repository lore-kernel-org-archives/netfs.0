Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6701D61A3
	for <netfs@lists.linux.dev>; Thu, 20 Feb 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065099; cv=none; b=QO+YfOZ8+KkG89UkGDWTzqZCTKBtERkrVhZ3VRhKn39vWmjnfQGr9gxvhYuwiwNLSFrt6+JD6j0EufqVFD0WoPNQVa/hepqNbQCp/6XYXQFbxDbf3ep4l0geNSVQ5N1YwJ3gecVVMD+5gx2AhNccmknJ2DPDGzme/NVSmkNc/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065099; c=relaxed/simple;
	bh=GHKtQKfRX625ruMmSBwhohcDd+91MZuTfcrrZYKfjbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCj8e3vlfwonxldISUigpHc3zqKpDWxM+bipfo9kZxMYSDAFK4UQ5qclaszufrvRAoUSEuAmS9MW6Id3T+rrjoNgcxnUDoDJ+RYab6ICy9hItGLRYyoRVDNEiHwHO6TbuFcNUFX0IvhN/T5wLsfeZ15uZK+YiCT1mVqv3GL/uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AvitxqQb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AvitxqQb"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb81285d33so220131866b.0
        for <netfs@lists.linux.dev>; Thu, 20 Feb 2025 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740065095; x=1740669895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y956Nga+wi17KckdN9/Mw3XRjcXaF3kNwC0PxZ5/5C8=;
        b=AvitxqQb6g4vJez8D9XVuGrY2q/1ua0E0dcYrJLILjFC0xKqwNtQbMBg63oF+Ojte7
         BuMZHWNfujQAxNfAn/Jf1iJSfqWxvBH35GFiKWIAq6KYgP3rsdU1X/cYpvllTttgQBTQ
         1lolQjDRgbQX0EyDxNr41MRkN8GueaKC/i+fi3NJNJSBV37ovdDoftX1Lefz6UCJodMz
         SwtDGl6vnYEFz6AVB10Zt5GUeXtocAlk/VHRaZziGURuqIHf0gT7P+jMYZ8UvpoygzZt
         wxZtldMjCsucuLhHcxdWG4A9rK28d6+1Eqtii+jg4/KoawtjySe+2q+zlPnEAZxmKq6A
         hYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065095; x=1740669895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y956Nga+wi17KckdN9/Mw3XRjcXaF3kNwC0PxZ5/5C8=;
        b=iRbdA4wQ+HlaiosUYXe6LZZ+X4ifqwP9Xwpr9NOYK8wlv402oaCw39pemSv67y3a/L
         UYZrn+BbEMochO7ez2YRzeelVVRm3PWPPiB5pbldabqQOOHAtU0esnZdU8G6MQhAlneo
         0uri+GXkYGI5O0W8nscjaIEPa0QH13kCoH/9qO/E5BlhDaASgmfdw/DbXBWbUqIO3TUl
         eOdSG12eRp5bfQHH7JMnAW9W9vLiYh+0yst8FmrYHni8VCLQIXlWy6cZ8ifXduWWq+df
         73cWuI94rRvdhT1SHHWJqfSUQH8FStfC9ldF2/JaXhzUr8lFENxYLWG3fTz/zmF0/zD2
         fNZA==
X-Forwarded-Encrypted: i=1; AJvYcCWY1CU6LmYKOUiSXuHOGnBFzl0rhdB9rS+ZLlN2ca7dT+0izAzndteD/iTG3S7bQcTxULv7Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMY/XkaEDUXIKDjGljBfN1SiFVDJs9iOQe2syQVK+3Sfagsrhb
	3CrMr4cZq1FKyg9p+7NW4QFuz/gpZxFVo17wj0NhVjwCRYVCNAUrcnScTIrUoks=
X-Gm-Gg: ASbGncv44GcK6wNtZkPVgJKRaSaVjxnSUFoRWd7hHCzrq8NZwOKP/JiEQ8qOvdFlgsm
	lvDsl3gw5We1SshrsgftMvxERgFOO9CUfxChvIl56ae8EGMJ1SJf01n/vQQr253bXTKQERjeEtP
	Lyo1xdKZlyTc0mWqR+rlGTVqh+3s9W/SFY16NigKbx/SR6UaaVyCc1ekf/kgd1zr2inPnwUE0jD
	OLNQKhIph25mlm6GTMyigjAgfLLHcnOIrcT8OKxnqrot7YyNm/pDz15VqePKRV069lXfCY2KBWt
	jFPwMAQmd6pGCHCZ7JyJZLqkuYyFMJAW+ZVXxN/JESi2za1pyeCMJbDX0MhDXZau8HGVPY7I2Gm
	nlExo+53pfJpuVUs=
X-Google-Smtp-Source: AGHT+IGpFy9Nqr+lyOCNzWNyFcfvqTsorGUY2iR8cFQABQ8lCUVSSIHVamd16JAap5iL/T/ZJ53L+w==
X-Received: by 2002:a17:906:d554:b0:ab7:ef38:1277 with SMTP id a640c23a62f3a-abbf3885ecamr256927166b.26.1740065094910;
        Thu, 20 Feb 2025 07:24:54 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f007700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f00:7700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9f3a695dsm751274266b.2.2025.02.20.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:24:54 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Date: Thu, 20 Feb 2025 16:24:50 +0100
Message-ID: <20250220152450.1075727-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
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
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/read_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 8878b46589ff..cafadfe8e858 100644
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


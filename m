Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF54B658
	for <netfs@lists.linux.dev>; Fri, 25 Oct 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729831221; cv=none; b=SvdoqRoISOJnNc9cx3eDKe+LpIAlWu1qMkEL4U3Bv66gzw/9eXrdmfXWOJnhN/sMjHyPed6J35mk/RxKNYnI6DQT1mq6wM3+UoKVMPdwGPKSurt0yNjBPHpbNlP+IlZURmFcsia/3lyHcpWsa8ksYUcE0ELMlv46xSvgKyTjUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729831221; c=relaxed/simple;
	bh=ld6+ggNizA3A2eIeDt5kCacXAG+qxFT6pKHcEwM1EYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dbOp89USb8eZqdXzy8FqR8HBENPhi3QtOmz3zoyQeocQcut0No0ihbSkcvkrT3qT+bPJswOcoGv/69tvURw8pNqOAe3tAc8ZhTSjRC8dO61JiBpOF45q4m6fLVTz8OY/CJGoSfjMGsvhYV9AAnXlhybn8s39pFETdlPHpXyBBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5KB27CW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5KB27CW"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7edb6879196so828740a12.3
        for <netfs@lists.linux.dev>; Thu, 24 Oct 2024 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729831219; x=1730436019; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=To20Nw2+64QsmpudbVv9vAcH+arowhkF0pMy9qpll/g=;
        b=N5KB27CWvOOo2q0W3dXNwoW6F3VgVMLtkfb1M4rosjB/b7zaUTDTeaB3EEZMd2Kuca
         RAsMPwQmJD8sq7eZHa6ZdkQLmLtKCNMh61EaWgU9ujVuy8kmrPFNmBTMBKlzOU5UPlcB
         Q56ZYcfwwXnUbZ9m7LwYryOMC0D5hbiYo28E61xo5djlSBls8nt33slzaIiHnEmOaSUE
         xrSzgi3ivjiMRoLC8JMrKzjgQvkeiCR5Wr+yiA3O5kWdLryUgUJGfmqPofosh1DqY5sU
         TQIwfkuHhScpNdu128eFoir6zHgfvocY98KeayqgWs0nUFIExsGFuq4QNj9oHs6P2DFr
         1Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729831219; x=1730436019;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=To20Nw2+64QsmpudbVv9vAcH+arowhkF0pMy9qpll/g=;
        b=eWAxn5Ry+y13kWdUrZHJ8ikVYMYKv7wxgFkFY9hIuOvmSAFNA0dj6zrrTHPxbBTT/r
         h7Adda00U7HqYSDnY4f8gBWpPjlJ7v59efznDw9J3f0X1jIsZwzBGLkiw+pydaTdvsXJ
         m2fqGtLLgjjAjz0oEj/g9gMFUK4zqlQch3AvGmUiSjjGAvBS1A99phkXuXgMU4iPCoQb
         nHWNlTYhVEQHyTQa6s2W8addmFHrFLAKQCQGLF0Q/Uj4EazSuM2QmpN3gE13v+wvCTwE
         sQOxBV7aTc7wqPeqBaJuxxVOlk29Q0jeOPnnPjg29YO10eI3bFNhCkiYxKgi4FtFLmq5
         quqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY99NGwad1GdVH0q+6ClvwrCqADnQBM6CSESR6TT3PPaMletzN76UT1gJdCol2rtdZgxiwYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOotkFQ0E3/1u3oBtktaFrXKIL4jtw6XTrzehzroyDuNZErGbV
	hkzjAqZt+dQtiOvC1Q6Rl4U/l32NPWoOHT+rRf3Ut/MDDYCfwf0N
X-Google-Smtp-Source: AGHT+IHBTV8w2SbFVAAq6pGuZ4l55H/pI1GXYvikxial0g6R3qFj6l0XrgeElRJ8DSCk0nRjWidKyA==
X-Received: by 2002:a05:6a20:db0d:b0:1d7:c3e2:4e1f with SMTP id adf61e73a8af0-1d989b1ab76mr5069697637.25.1729831219094;
        Thu, 24 Oct 2024 21:40:19 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921a78sm256782b3a.12.2024.10.24.21.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 21:40:18 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:40:16 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] netfs: Add a check for NULL folioq in
 netfs_writeback_unlock_folios
Message-ID: <ZxshMEW4U7MTgQYa@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

syzkaller reported a null-pointer dereference bug
(https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16) in
netfs_writeback_unlock_folios caused by passing a NULL folioq to
folioq_folio. Fix by adding a check before entering the loop.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16
Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
---
 fs/netfs/write_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1d438be2e1b4..23d46a409ff2 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -98,7 +98,7 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		slot = 0;
 	}
 
-	for (;;) {
+	while (folioq) {
 		struct folio *folio;
 		struct netfs_folio *finfo;
 		unsigned long long fpos, fend;
-- 
2.47.0


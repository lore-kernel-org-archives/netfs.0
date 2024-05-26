Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570013048F
	for <netfs@lists.linux.dev>; Sun, 26 May 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758621; cv=none; b=VVBEZxMAN6UfUiwj0ob2f2LFa13BrqKPFxTbLOUzTUAenW+614/XaqODCo8hbm7lFfCsJ6hCC29WnTWkD7SJ0ECwiSVvF9OB8x75ug/UeHMGR26e6f5WOkZVQ+1HkW+5qujBigb9hIhwa5BtjSK6z/tu5XOuyhmd89SnajmEQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758621; c=relaxed/simple;
	bh=4br1+bsqarhpsUSUDMHnPY9ItAu5sQzF64WsQKB/4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAkMWAoYnt6ZqBFWb7eU7kEP4J1JXbZLCzkBdidGqYafAiFelhckk3t2ZFCVtX08UiwbrzPTjBmxoAq6JDC71QAJXyeZIIa+KoHHZwZfRG8WycO6YwgbmRzX7vo6VolcflEx2bqsqafsIWyGERBls5w7GPLzb4dd0z1nYyfek1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=K2gS9gr5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="K2gS9gr5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354e22bc14bso3972008f8f.1
        for <netfs@lists.linux.dev>; Sun, 26 May 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758618; x=1717363418; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=K2gS9gr5KfHGL0utz061NSGkn7XJ5Lma5I7J43KnbQCTJfNuKTqEd/AWjt8yaQd+bt
         YjT/UmjdchW3pLDUa5F6dHWlmLiabN1zk5+yRGvSg+DuHPfPpV2SkJdBrATzcfebqIac
         09hQ70URlQRQp9WZ0eBtaZK1APfO2ZPAIV8NRSIV4ESvpPMQ03SkOosy4qQuZ7vp6QAq
         jkE3trlYOzYZeLo6aD3LF22dbcsUrlWFqEC46sURv/+IgJuEHmSldhQFlbNSUYLzLZYB
         z9g4pVeW47kGy2TbfechUCDxs/QfMrDSqxdrvUYvWCn4WrFyryiRsNUSY9jfCHSOQjSJ
         vPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758618; x=1717363418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=LSKgts40vTqPb93wQ20voNyT66KuBmzpENIkJrc4DEglfcQkuavQVTsfbN1GqUl4NE
         Ce9L/ClKfkh8fJurk/2tpI8D+1vPjuQbJ9A1xiMSjtdwWDbj/I9+4WOatYudsw7ck7cr
         fgHzNdlclvueBr3hWQ0QV2vsW46C0kZfn+cGfDQ53f/2U6v5VrX6ESufW6kfTxaztGzF
         +A4peinAvI/WttFkQ5LK28zv1/YSIVjpJdiOkxseBsVu8JEXElRuERxZBUkloLBxftP4
         OFru4WRcIv8bX6uY8DEhkuZpgPXkLwnotaTK3LvALB5w86kq11g2AuvVeW06q2Twe9Bi
         Xziw==
X-Forwarded-Encrypted: i=1; AJvYcCVCuLXtlit0WJLC0IWskIQlwESAJwEI5xR1XUP7z5Q6NkuMDYw+g2uaEVNrDZxcludFi8rmkYwUOkxQ19TBNSRlbCGZ5L4=
X-Gm-Message-State: AOJu0YwN46sUVZSNHUUA0APaXzrVbtvlrIcej9e+Je4YlpyUIb5WXHKl
	YaM4benI4g7lgGLa2vgvbvJkM9NqnlPhw+nEZp6kKIqv1MbcAOO0AEJETO9I854=
X-Google-Smtp-Source: AGHT+IFy5L/fF6HnmYmy15FzQ2I5Aj94AJhD6S8HOgJeCGnH2efGYlzLjxrfvdfR5wJ4GRUcUbR/8g==
X-Received: by 2002:a5d:4e01:0:b0:354:f1de:33eb with SMTP id ffacd0b85a97d-3552f4fd249mr5166115f8f.26.1716758618179;
        Sun, 26 May 2024 14:23:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de1bsm7224197f8f.13.2024.05.26.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:23:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: bhe@redhat.com
Cc: amir73il@gmail.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	thorsten.blum@toblux.com,
	vgoyal@redhat.com
Subject: [RESEND PATCH 4/4] crash: Remove duplicate included header
Date: Sun, 26 May 2024 23:23:10 +0200
Message-ID: <20240526212309.1586-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
References: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/kexec.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.45.1


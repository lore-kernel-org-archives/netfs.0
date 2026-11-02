Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632030;
	b=NxyJkTqwnAo+yhW+1hLRxSi2iKbz0E3uHgYI64eP4QkZOyYgaQqjdP76hiYYNWseV5zM
	 SlrfsK7uTgggKFmoyzolFDT84X1t/XPftMmzAjmxhIdfF7QiEno+A0V2Otd+y5h3oW8Vj
	 wzYmfFHQEYWfxkCZlm6FVO1jgu8W/shbViPtdVYzKzDi/T0jcXUgJ2hMi5KBZvfK7QRu8
	 WK6yI5Afg9VT/MKo7Vn2K819sC/kv/Xm+RV0dA3iGG8RJ9113JWAYNRUm9/dhpOfjaTBq
	 0AB6rPWZad+p9vbcsjGKbC/Zr68sLWGU6yCcT8sLbpf/erjRcjj9TqLnKLqyC3e1uPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
	b=EJg3VTZl34fXmEvgCwt5h5PVTLOh88mciv0c5K6pYs53Qcf1AnBP2q3kGpsFzG9P9l3K
	 b1HV4uQ6sKdvxPT1q+lpHrWEQJfDgoCW1rBXJjdTgaZhFnxmo1dPQu2bqRUgZqG7npv9l
	 btvud54wP+CGZ6EzFQhvXX60Y6QEW+RcAA2mNWGe8UaqpfO9y0tUDKdImxYS/FpyNYcnD
	 rlHOcjVMHw4alnei/zJ5p59t+fXbjRKIZCInIoeaFw+/J5D4MAMPLI+OUbHjeBLOKPGvt
	 pTdFHs0afgV62nleNeSYG+Eao0vE66WILcu4mcdFSkdnbhKNfKI81fBnGJHKoFxbRpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dU1xUwI9;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F636072ED1
	for <netfs@lists.linux.dev>; Mon,  2 Nov 2026 15:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2F636072ED1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dU1xUwI9
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so26267825e9.3
        for <netfs@lists.linux.dev>; Mon, 02 Nov 2026 07:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632028; x=1794236828; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=dU1xUwI9yjldK2v6LOdGEsWvve9f9YX6jw6Z7IGUcTIxu+GifZBi43X+ISueDkHbvk
         TSQl9Yc1x8MbWJQYX6Xg13hRIa4uNR4nD54GqyAzUxM5zd/FPNdIAWqalJXX6QJBbNSg
         yeQm41d400ZcTREOz9Sjh1dubP6sqhpxuoIPkM4UD6yaFc8uUYWIp4zg3Wo38o1eg0/K
         r4BzJ7E3YSILhUT8sdhlgAZOU9uMlMikgjFN+64EsnO/R1v3Drm/d4DuU6cDOUKo3NKy
         uRD5vzNZoS2W/DxBxiyt5gaGdWalbbGYiGt29TgJsu/yN9koGB5HN04PRL9NfZw6U5vy
         pl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632028; x=1794236828;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=CirCLCWupy2y8PNEcZ+EehKaCiFoBvtdVcZC0qY9xRKwfWdnZJ+n/Y3Y63r+LIJNJ3
         1ki5HoiE6VAE8e1BFHMVXcdMIFTaLiSrfpBOQJJccmKxBncMUIVz1Djj6OZfv1kY0bBu
         z84IhMd5U5ywOftGiu1j3Xlwkgn40bWNbvm3Q59JJI+Q/nB1kyzvTW3JVSzEF2D5ZLEG
         Tq6sNZRqHmS9fzDf4IWml7k7UjS4Eg4ehxbdOTHK9yweYqPRDHl/c8ViYGt0dk9/lIwK
         YNiQY0iQAHj8P5dsVoLfKtBCLl8uJAuCb2Fe74tu1UjIZ13nD4N2IhwObjKkHfkIgrvm
         Uu2w==
X-Forwarded-Encrypted: i=1; AKwUvByTObWlzTQwP8t4P0xEKRTLmhLFnF/aJIoOD3haKuM7+oMeA7JYfmTaJDaDm975pzO8I2OfRQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKBjrNsPSFd7WYxc9sd+5tBVmQsTesynV4Nf82mA6coEFOwwev5
	cTPh6cvoxfB2td2kuJIyTSqz1rsM+5KEblKhbYJ92WLwgWLFemfNI9fl
X-Gm-Gg: AYBFou12vW8WiHV696dCTj9pox0RCr7tClaP69Szau/jmqHknJodLUaVbU7QWfvKS+N
	JVli5utZ2yPAmSO0nX6tV/v/4nxt2ZnVg8OOoCgG3jKyDs3p0bhrHRFzn9RrvufJmqkWOr48MJA
	SRk+olldKua1OUeq0OvIvRJ2QFsdd53nR0DHDioWOK4jnh8GE2AVtbTh1cpavIuDyjsT9BZN7hF
	CWFBSHYD9jV5h1C6qHKnJBXSp8Flv7Zu69lIk/38ayM9JG4i22st0UejMkl2laXlgp+IIJpeVBL
	gos+ItxdOOrqcV3OQiGkRNoKcrqctuydijWGr+2JEJxeTIOeigeNw4bwwZFVbxqDeoQ612FS5mk
	lN+JMO/JVyL2sWcx47Jq+GuPeptb4PsD32XQqaKVRJNW2c7vsjfoeQK880u78VPhQFM+/Sjhyy6
	2vmDbBFzvDMqDNxFeBFwp4tfGuIHEWkNgLq3PygJE+OPGVoaxxWWVX6tLDUCpoYZxaaXMux5T24
	PCEH3ZZQDYOyms0bepgmXH1qeTN7he2I6qi9WpTbEoToAEpwY3xNzl9B4JRntd1IvlJFeFWksK0
	BU5SnwLrX6KLsC7SB3csF0Tk5fup8RdoZZ3kp91eJKr6
X-Received: by 2002:a05:600c:8b55:b0:4a2:1655:87e2 with SMTP id 5b1f17b1804b1-4ac17b2b023mr254051745e9.19.1793632028227;
        Mon, 02 Nov 2026 07:07:08 -0800 (PST)
Received: from localhost.localdomain ([2800:810:84a:dc6d:d32b:1515:b2a9:c74e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm395629535e9.11.2026.11.02.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:07:07 -0800 (PST)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v2 1/2] netfs: preserve prepare_write errno on reissue
Date: Mon,  2 Nov 2026 12:06:54 -0300
Message-ID: <20261102150656.207612-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102150656.207612-1-ivanrwcm25@gmail.com>
References: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
 <20261102150656.207612-1-ivanrwcm25@gmail.com>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

prepare_write() may call netfs_prepare_write_failed() (FAILED + errno)
before write_retry calls netfs_reissue_write().  Clearing subreq->error
to 0 for a clean I/O reissue (82e8885bd763) then makes
netfs_do_issue_write() terminate with 0.  The collector copies
front->error into stream->error and mapping_set_error(), which ignores
0, so writeback failure is silent.

Skip clearing error when NETFS_SREQ_FAILED is already set;
do_issue_write() already terminates FAILED subrequests.

Fixes: 82e8885bd763 ("netfs: when subreq is marked for retry, do not check if it faced an error")
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Steve French <stfrench@microsoft.com>
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 fs/netfs/write_issue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index b8237e1314d8..f23364116421 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -268,7 +268,9 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	iov_iter_truncate(&subreq->io_iter, size);
 
 	subreq->retry_count++;
-	subreq->error = 0;
+	/* Keep prepare_write() errno; do_issue_write() terminates FAILED. */
+	if (!test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+		subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_wh_retry_write_subreq);
-- 
2.43.0


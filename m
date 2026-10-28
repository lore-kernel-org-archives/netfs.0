Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211158;
	b=kHtkQNAJhikUBXFuL21HPVfS6VkoYSMegz798RzAwFNHBGsZ2BUG3d5QxuqT32w+Nle2
	 AIJJI6hGPHTHFw/a2WKruVGK23+qVk5kRjJkNpvEBHq+/VkmbT8u9sO15v2HvN1Wiw72c
	 CI/cQTWogKdkfh2PTZwhI4RSeNdU/r97moelPTDilKf1CPIFRiQcADQneSyOG0NOuK144
	 3BWyJ9vHDc6PIbtN+ue+S6VqoL5lgi2lChwSZjXNHq3AR8eBi0SFID2TKIpN3JvfF1TlF
	 Sj3E9nVdTLyN4yG+VvSezGEXZxnHTLs/ScfATfEFc3GGShgiMi5op0uXFvnYHxw4fLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q0d6qWi5B+qlp69DsFDkPKiAVkLkzeJOiKS+6AQfdW8=;
	b=HmX6PAsvAvohoQpfQYosnJl6MuGtrOTQ5trrvG5vn6oXcZ6Fe/KRpdazVxmN+/Xu7Z0d
	 GeDkBe7sTd6R/0dC7DErO9ZX3RD3l9YpxqF0vwqrZXavYQ54/7PYbQOYyjQ+xrh8Bveqc
	 AaRq0LIagwQpSeuT2QxXNCKoow7RQz/hjShu5RrX80+ulVB1VqlQxd2oYq2AtLcqcYDWV
	 6DJma9Z44f5eLemUPwAdiNr08x+lxzKHw1/KU6fnXQ01RwW6owNyw1IR3WMoBTfDattRN
	 Q1ZuRznkPPFa0/lb70G5RYQy4LHEAPSdYe4+W6wbOvmYoJzC/HtLyK4uiyjEznaXYOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ea5wiVFT;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEE60A2627
	for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 18:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9DEE60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ea5wiVFT
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1810109eec.0
        for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211157; x=1793815957; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0d6qWi5B+qlp69DsFDkPKiAVkLkzeJOiKS+6AQfdW8=;
        b=ea5wiVFT9VX8iY+8CHXklRFTGSC2edyqop9vACt9Up05aU9rCV38rbyGw4J2d5lIAg
         cftMkwtqOVs8vuoON4S6tZYnKGTDxXJ1aV0pvJbFJcidBjNbibiMDJt6/54PlU0WJCEf
         wXY2t12EloSn4Xh2dWgSNlsKDvoBeOIO+WG9f6AS0iFkouVAxw4ffD5oL7JkW0mpH+U6
         Su9ERvNA/H4xJrY7/MW6VhV5V2wtpQlkDjp2sOtR4dN1MZUJjfxIqeFa8MRUAC1EdutU
         GRKiOoT2cVFYIC7pqpCuLyJ2nWRnnk22RZHnb8BjeM12wk3oPQJgHHpTLED6A+YKA3VK
         6qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211157; x=1793815957;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q0d6qWi5B+qlp69DsFDkPKiAVkLkzeJOiKS+6AQfdW8=;
        b=D9NIdORiwwrdkkfKtKjZjCT1fDUNOyp4xo0Z7Ae/rQbqJuGsOXHPzpOoWUi4vSYZ++
         2zZTMls3A0bT5WdG/z8jEHn0dZMjCn7I157xlzy9Ijg18Kd7D21/bl/Kgz4IDQT5qzFZ
         gkzu72jWDdLDXs/A+keFBIpx81G7bfNVbCxC0J7IQAHd0PUDHj9WzQSzHUOnyCJrSpi7
         oqX6xFe0dyuBuyAd1rOeFfPBovi4zyKSRu3fgDXcxO0EATMlqhZbU/OEUhTEHpGqURo7
         0GB6dIrLNiqQgjLHXWEJ+3rlyduqbTMjgUzsNFom+vpTeHYOcGIsTDpssb8E/Pn9PXOy
         RxKQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8QN/ukIvebVc8jutsHQlo2MnAvIlO5ZYHGUGFb1+xTzSLCR3nT4SCLWj7kRdYuKHEYhRL4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ9YkMW/6IC4mKRYxPSQ30B/D1MwkTXUvthJrQ3s6NxO3AJckvm
	TwMr42w5w/xuUNA6jvEarF5AZwmrX6h7GFy8SIw4X/zYNh1/bh3Zjhe+
X-Gm-Gg: AYBFou1nMYBG2WHjhthKL8tmNg/lfmcFAfUPg524w8q8mGU+U06cOpgKd3EddNf/jje
	eTzD/WFTifa5BqYtJim7PZAzpQEGbNjsptZMuI+ddUG2qnn95sU7zWR53UZRIzLhbPNQH9+ieMe
	Kb2Iz+43Tl4CgQoGxkqcqIMEUdsNt5e2h355ZmEEhN3Nn3shE3P9uKYhA8r0HBfBVjjIqBtXxOw
	iugL52gRmGz0JYVA3nan1LE0oySCIGzrQtkVs0LE+Suj6T05jfOpxwe1YaLRhNYQtnRgvFK8FV4
	eThOYphWbKFM8UfvPBwEOdYA3s1+diD9qVazKTJ/PgQ07HcVZXvVCxVeBPjqSdZvOXgmdVrjp/a
	QT6Lx7vQRSyVyh45Uk+7uTPT7X+Uo0ukmxNeScxf5+6nNtsNCl+3MrNvunhLrKjL0kgHr9jIJu1
	YVMqWewC+UfDHDbg9fBqMI5LA1eftWilGxZBuFIEkkAjoK9rXSXWmHq/z0fZAXGSwLjGsruD2dU
	3FbmaC29wwu9gy6MTBGkyqtbde1v1TtLg8jYl79mMQU4qAUioKqRVVvxFfpm5inekljfBn59yHu
	KddQsRKBXlQddUOSZTlY64r4
X-Received: by 2002:a05:7300:a230:b0:369:a113:7578 with SMTP id 5a478bee46e88-36a1ff4734emr3881706eec.1.1793211156240;
        Wed, 28 Oct 2026 11:12:36 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da675sm8309394eec.5.2026.10.28.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:12:33 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v1 0/2] preserve prepare_write errno across write reissue
Date: Wed, 28 Oct 2026 15:12:27 -0300
Message-ID: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
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

cifs (and others) may fail in prepare_write() with
netfs_prepare_write_failed() before write_retry calls
netfs_reissue_write().  Since 82e8885bd763, reissue clears
subreq->error to 0 for a clean I/O retry, so a FAILED subreq is
terminated with 0.  The collector then does mapping_set_error(0),
which is a no-op — writeback errno is lost (not an infinite retry).

Patch 1 skips that clear when FAILED is already set.
Patch 2 adds a KUnit stub test: FAIL unpatched, PASS patched.

  ./tools/testing/kunit/kunit.py run --kunitconfig=fs/netfs/.kunitconfig \
	netfs_reissue_write*

No prior lore report found for this interaction; surfaces on top of
Shyam's NEED_RETRY change.

Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: netfs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org

Iván Ezequiel Rodriguez (2):
  netfs: preserve prepare_write errno on reissue
  netfs: add KUnit coverage for reissue prepare_write errno

 fs/netfs/.kunitconfig          |  3 ++
 fs/netfs/Kconfig               |  9 +++++
 fs/netfs/Makefile              |  2 +
 fs/netfs/write_collect.c       |  4 ++
 fs/netfs/write_issue.c         |  4 +-
 fs/netfs/write_reissue_kunit.c | 73 ++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 fs/netfs/.kunitconfig
 create mode 100644 fs/netfs/write_reissue_kunit.c

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632026;
	b=fPkiSXsQDXyvguGyTcJHE4XuhTac7GWYnXanhpYWo4/2ZHGQFH2AGJQFy2GauwaSKb8i
	 tGACX4Kjb1lp3p6Oql64Qisq0kA76F8Nb0IkPvavxpDSfU4qydWyxvCBw6WGRXt+4lU0U
	 JficG1vlqH1SKgwt9iRPSV3DdzBY9b1NguD9buocfMZvIjt/X9L0Z/j14VEKj9pjDvkLe
	 DCbeHLift+pRAZUiXuVxK3i0F0gjEsn6VhSNnsc9pgL0HInf1aBxB2xTMyLNcxKZnro/Q
	 m9PBSb2Gq1etERE40SyEuGddK3eVm3IeAOSdM01dZRJFkqODw1Q8nIy89WBM4bZ+gfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dylFydTJD2AJSyC001lOFTgMCOP2ZnGzBFoGx74ahLY=;
	b=EJtAqHtOBO135EfTgi5akW+mVsj+cbDXtv/XAfEDFXFVQ7/1r/TtOdzmZpfY82YDTXBb
	 7VXOWvqijGUkLNtx6l+kmWycmqFTBQ9pp3Hg/PMpVOUdB5qWUwXlysi/+141SxRe7Dhu8
	 ZonIQMd6u6bNGvmrlZbIGxt79hPFCLtgk4Irn7PDuxFpzRFs0UpSvNfztCUikUXmVtrL9
	 tTvmStrPOVscGMqExkZjYHARilrLAh1TPcd3827JR72BrsXJcIDIO6WQ/PeVfiORyAEzb
	 pQqmuvfsuZICZEfBU7CAjazjT/3RP48KJm8JkTXwqicwAyfLGFqE2bzfZsmpfR2L6GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IxY+fr7f;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F166072C41
	for <netfs@lists.linux.dev>; Mon,  2 Nov 2026 15:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F166072C41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IxY+fr7f
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so20043555e9.2
        for <netfs@lists.linux.dev>; Mon, 02 Nov 2026 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632024; x=1794236824; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dylFydTJD2AJSyC001lOFTgMCOP2ZnGzBFoGx74ahLY=;
        b=IxY+fr7fZsYntyvDnh+aIH+EY8Je3P3+hpjFZj4dKMwnRQnbwLdvYrE6B4zWsPhRiF
         sWvEi5cWbRk9so8AnrVbI1wCQWfdSSCVlzQ5G2Zz3JWrSFx3NOWhqZNcWfJ1PpZv1e2K
         v71IYtBXHXHZFCg659ByDij1E4qgXh4wVWWXzI129mTU72u/WUF4CGerFIktYSk3xIkr
         gkzPgXNCrY2cwzd4JZj/XGJdv+MH7oglqjKGU9uaSoYdmA3gZ0vUFVuBbQNG460E5O2Z
         Ui3yXAZYNbPf9shEOEdR7V9Edhuzr9JHhOJ3jZbYUkSY0FJnTwHFsGOcvbZzTh3vp7EQ
         QgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632024; x=1794236824;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dylFydTJD2AJSyC001lOFTgMCOP2ZnGzBFoGx74ahLY=;
        b=Y/CraWTt4T1Pzx1LeAbFA2+Cgcl49sdbDsQeVQtAj1mKsj8RjrwYN08ORSrqGFDU9O
         XyQb9Rb1IRefJL3SA2M9AxW4tPkFfO4Kwy8zxud/ICbWeIzLTWYFAqGkWluq33OVoBCM
         /+RJCgNhtEcK9cz1qpSJgD/vW4qRezRIdBwxqMm+IZFTA+n9+7cRRJR7BDhExhVuCvN3
         BiyGFNMKvJ8yO7U5K6SvkGiGIJhjtaZeQOsNWmYaWGamQjAKZaBCvrW3XCaEcAzRNF3y
         qeXFPaQyG2yVJcUbjuG+c4+/pOny1MNOwq7UbnZP39IKA7VKWxD77GTR5rCfPi0YPHVI
         voIw==
X-Forwarded-Encrypted: i=1; AKwUvBwYHXAAyc3xzp4deyAWFvk7t591Fn/NX8ribpqsA1X7izzdKlvluFkXsM+v4z+TmHjOe/0Y3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKyngi1Rs6wUuXEgNE3fRV6oTNrLTcoi8SW9c3HLxARfFQJLN40
	Wnvbu1zx8ca+4BrAy2AdsKKhwHJA/wwN6/h5ULlfKQYxIrmWMjUhviYJ
X-Gm-Gg: AYBFou0VP5KEumZgjEW2IM2TgU9VkHNj8Z4s9Kmjc3CmMn4FLHqesjPARCTeddycfRA
	MCGnTKXTJfNoS23Kl5/S+zLEsttVnxNOE5lFnxm1d5g6u0IXFPsEue8r0jaEZHBn6i3T8tkc0gm
	qhOmk0iB7RZSQn/V+tQy9lmSKh0LPJSFEy+YWtRXo+zGPmjc4gMCuSAufa1WrcqX/tQ0oCeDdnN
	Ewf8SRU7A7YGUz3uPa5XeRhR9DJBkdVazjJK5CSGkbH6cutnM8EkjXQHFYk4svhNM7OEDx7xpr4
	XqX03oXKXIRdPcavKWBIX6jAB4lnrzjkJM557cppHwFf4tygZSJ9ed9brZ44bgB2dY0g1PGtGNS
	xt5NgF9fatY1AEuk44Pb3S1xMXjL9UdjcpyMOBtfrUdJimjsvm/gIA+a9hlJY4fEhz8BYNbSjzO
	HtK7nAzwhLIlKJyZJv41qB9OURwcPTcyauA0OzfctOxc1E/jLUEXXXRoA4cdyFXEj9dE8X/FTdp
	U/NLIsSQzXtmoh0zAsZIfaAEAPxBxfmlfF9lOXzuVHcpu4Dr0GB3k1idzf2Ug8Pf8070JgeJiyn
	CNa+VTjlKgxPeJ76vzIrV/WQztea3gf+5Qjt6hnqw5UaEg==
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4ac177539f6mr227554115e9.17.1793632024294;
        Mon, 02 Nov 2026 07:07:04 -0800 (PST)
Received: from localhost.localdomain ([2800:810:84a:dc6d:d32b:1515:b2a9:c74e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm395629535e9.11.2026.11.02.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:07:03 -0800 (PST)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v2 0/2] preserve prepare_write errno across write reissue
Date: Mon,  2 Nov 2026 12:06:53 -0300
Message-ID: <20261102150656.207612-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
References: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
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

Changes in v2:
- KUnit: allocate netfs_io_request / netfs_io_subrequest with
  kunit_kzalloc() to fix ARM allyesconfig -Wframe-larger-than=
  (kernel test robot).

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
 fs/netfs/Kconfig               |  9 ++++
 fs/netfs/Makefile              |  2 +
 fs/netfs/write_collect.c       |  4 ++
 fs/netfs/write_issue.c         |  4 +-
 fs/netfs/write_reissue_kunit.c | 80 ++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 fs/netfs/.kunitconfig
 create mode 100644 fs/netfs/write_reissue_kunit.c

-- 
2.43.0


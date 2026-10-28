Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211162;
	b=0FTGPo6EdaL/32GHkD9lr/UrzJavuKagFZWvilv5UvX0n/sxI8VlBs7E92L1njsPzXn+
	 CX6UGL4BcTxO7NkVwkm01SmYmh+e/YvT/8peIW2US7dzH8DsaEp7ysjPdkdDLLcyVtViV
	 yZ2KzWVCcwQOVrKB0/Idoq1Im90eAVFZfAfGOpqkOKylcfEDJgWkmb6giphJtuJG5fFNg
	 6BXmCT0H2gLntLpy+ExZqE4OdU8Uzv4dwvQrFPgRET0YM5CnvFI8MAAu+G2P0N6t0wxXv
	 gbKk8+vCFmJkkpOiYi3uGTxx8AlW8c6B38OUaoQ6uSz3/y9lsL+K8Y1pI3jMhAjFtRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SC+rlLyAXoWmtdm6xDuX7v9is1jRIFMfGWnpAh7mi7I=;
	b=g6f7au/dhEOWIHQtdfkpf+4gQuGw/nBlZ85F97c/bCMP8Vsqqx6GyQUyLQx/0VbNwhYv
	 9sleGn31NE4BZ6x2f95hTmZZOG7h3DtL9wI/9KjLwYouiDhyEHbs8jGKTyDSTX09aAhwS
	 rz+92gtJpHf5uWhEKv2sYCU/DZt/HTRH8K3hVnY/wFZgT18rQjNaHvdv3LNwr3nrtSmLF
	 HAZRVd1zDrsAEGhzikVPVi40cCBahKa7BTqInPgC49OUxAB0XFoXgfuGNES4RC4zrl6db
	 kWsCpgGmoXc120uqeq8JpbgATS3zeXmjz2jSZ16LIqe25FDqdMxCnn1akmA5EiCE+sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWS1B9Jp;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8B60A382C
	for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 18:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C8B60A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWS1B9Jp
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a18fc7a38so2653351eec.1
        for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211161; x=1793815961; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SC+rlLyAXoWmtdm6xDuX7v9is1jRIFMfGWnpAh7mi7I=;
        b=hWS1B9Jpz4XbjZaPSxhCSTZrinPbzTk19ypcxIgZpLk0ZuXRruKRnQkwy5yhxKWd0h
         XLqrRil9C+1L/dNjmHxamDw5V1uuiGoh7prYz3KSyP7Nw4hpz09n414Xsz5oScSerfLD
         TeDTZnQag8xhnNopsLfoOnVQ5mYOWtip5WOD8mojs/vHyXaQkhwkT6SH62nX/y7KKfrH
         STD7IfOmRzVmNClZnn24jSapnbk8Fw2slawwynBTGBiVVeXkCZSZaGCuOcTP911JZQwD
         5OrdWHphJ7cB06BBg9A80O/XA7Wez7xHykY3qPXrhbaoI/4ClZriWd6IovLznfoZybIw
         H0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211161; x=1793815961;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SC+rlLyAXoWmtdm6xDuX7v9is1jRIFMfGWnpAh7mi7I=;
        b=JO1WTfrEXNWKPBH4UJ/PRDg1R04dUcofJz75neMgQrrRwe4dOl7koFE7FPAHyiuutp
         LAsDABlRpbEqsbq93od6gTOWmtnRDe34yOA9Cs82tUOoKNvbuaG5G2DAuoyO98a98Ovo
         AwJPtN1hzw5KTWwo/CA3xteAZ5B1vx0/k3fvj+0AnKYpuOZD5HSfr0hhtGsacB4JeBP9
         07EQ/b/PcIG7FgyaSbbK7GgxIvKLE2PXz+wVLp0toD2NJp8vIWRgIYM20HRp43y4Siy/
         6QnO72GB67STaiNBbV4sA6TxmcgEnYJ73YP+SN95JTkQBH/y/S/nozhiGtNaC7+j600R
         +NPQ==
X-Forwarded-Encrypted: i=1; AKwUvByiu1+WL3JG02e60KgBYwz9DxvjyMbsym7Eq9nwXb+s7p4XvbTrcMk42TeYd4xWXSeZUVeUEA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJZ2mxv1k2s9B6DZYbAlsXXDxilydazSfawfbyRuWhL03ET7XI9
	YvQebUo4Swhw9KGKk21byV+ufrp3NKbJXzthH7DTNj7HfFbSXz5NWQpA
X-Gm-Gg: AYBFou2Hv5qBWEJCA/32qL9LIYM76uvaciXzOJiwoCR3m1oX5741gA1LBmj6ropNZgI
	e6QN3zV94K4dwSzyQ5EH1uoDlLE65YBQno3XxUrbuYGik9sy6NPLpdIsFkpvO7V+XDwRc5njsH6
	GlEiPDbDSgTvy6cn/cs1mHoICUKITTWPk9igB3KzrzO3G8T598XwxX0L6yd+tQQ1y9wltytyJVX
	x+ip+esuzaBiREkjzKkdRV4enDYeGB69kOiDGxr8aln9b/Q3vOrC+UJPZ67eOYPGfT1LyeUBoSQ
	l7DlK3Ey7W9qal7S8zYkYdDXXZW/qj4djosqBnwFPMDCYa26WlQGikP5zEz9b4CDLIlpcUXS2Ms
	m8S2zaKx+o8jUBtnFtb0B7RMN3ma4LQplP6r+uqRWt0e4xCC5e47joPnsIOyZWFGKh0FI/8r4Hw
	YcrWrUlJckz9O4URtUqFno2Oez0r/iAisiXGlNF1dZTgEWqyYKXjFaVxKKyV288ZdOQzVaRktSp
	XLDOiR/CioK6OvDYlKyBu1soAlyXz/jViR2XmrSHGGTQwlHhsWnCmPiy/77GYEnk3lwUvdvJ9uL
	Ina3i+lpGzn5J6z2LRx6eUU=
X-Received: by 2002:a05:7300:cb0b:b0:351:4866:255c with SMTP id 5a478bee46e88-36a204a1735mr5413054eec.32.1793211160870;
        Wed, 28 Oct 2026 11:12:40 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da675sm8309394eec.5.2026.10.28.11.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:12:40 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v1 2/2] netfs: add KUnit coverage for reissue prepare_write errno
Date: Wed, 28 Oct 2026 15:12:29 -0300
Message-ID: <20261028181229.1408342-3-ivanrwcm25@gmail.com>
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

Stub netfs_write_subrequest_terminated() and call netfs_reissue_write()
with FAILED + -EIO.  Unpatched trees terminate with 0; patched keep -EIO.

  ./tools/testing/kunit/kunit.py run --kunitconfig=fs/netfs/.kunitconfig \
	netfs_reissue_write*

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 fs/netfs/.kunitconfig          |  3 ++
 fs/netfs/Kconfig               |  9 +++++
 fs/netfs/Makefile              |  2 +
 fs/netfs/write_collect.c       |  4 ++
 fs/netfs/write_reissue_kunit.c | 73 ++++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+)
 create mode 100644 fs/netfs/.kunitconfig
 create mode 100644 fs/netfs/write_reissue_kunit.c

diff --git a/fs/netfs/.kunitconfig b/fs/netfs/.kunitconfig
new file mode 100644
index 000000000000..c783d180ab8f
--- /dev/null
+++ b/fs/netfs/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_NETFS_SUPPORT=y
+CONFIG_NETFS_KUNIT_TESTS=y
diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index d0e7b0971fa3..d796dbe4bd7c 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -33,6 +33,15 @@ config NETFS_DEBUG
 	  management module.  If this is set, the debugging output may be
 	  enabled by setting bits in /sys/module/netfs/parameters/debug.
 
+config NETFS_KUNIT_TESTS
+	tristate "KUnit tests for netfs" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select NETFS_SUPPORT
+	help
+	  This builds netfs KUnit tests (e.g. write reissue errno).
+	  Say N unless developing netfs.
+
 config FSCACHE
 	bool "General filesystem local caching manager"
 	depends on NETFS_SUPPORT
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 54834cde7e56..fa1544b9a199 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -33,4 +33,6 @@ netfs-$(CONFIG_FSCACHE) += fscache_proc.o
 endif
 netfs-$(CONFIG_FSCACHE_STATS) += fscache_stats.o
 
+netfs-$(CONFIG_NETFS_KUNIT_TESTS) += write_reissue_kunit.o
+
 obj-$(CONFIG_NETFS_SUPPORT) += netfs.o
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 6e8ea534230d..f3236fe494bf 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
+#include <kunit/static_stub.h>
 #include "internal.h"
 
 /* Notes made in the collector */
@@ -529,6 +530,9 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error)
 	struct netfs_io_subrequest *subreq = _op;
 	struct netfs_io_request *wreq = subreq->rreq;
 
+	KUNIT_STATIC_STUB_REDIRECT(netfs_write_subrequest_terminated,
+				   _op, transferred_or_error);
+
 	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_error);
 
 	switch (subreq->source) {
diff --git a/fs/netfs/write_reissue_kunit.c b/fs/netfs/write_reissue_kunit.c
new file mode 100644
index 000000000000..fca5f7dd9265
--- /dev/null
+++ b/fs/netfs/write_reissue_kunit.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * netfs_reissue_write must not clear prepare_write() errno.
+ */
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+#include <linux/uio.h>
+#include "internal.h"
+
+struct term_capture {
+	ssize_t transferred_or_error;
+	bool called;
+};
+
+static void capture_terminated(void *_op, ssize_t transferred_or_error)
+{
+	struct netfs_io_subrequest *subreq = _op;
+	struct term_capture *cap = kunit_get_current_test()->priv;
+
+	cap->called = true;
+	cap->transferred_or_error = transferred_or_error;
+	/* Mirror production: leave subreq->error as prepare_write set it. */
+	(void)subreq;
+}
+
+/*
+ * prepare_write_failed() sets FAILED + errno, then write_retry still calls
+ * reissue_write().  Before the fix, reissue wiped error to 0 so terminated
+ * reported success and mapping_set_error(0) was a no-op.
+ */
+static void reissue_preserves_prep_error(struct kunit *test)
+{
+	struct term_capture cap = {};
+	struct netfs_io_request wreq = {};
+	struct netfs_io_stream stream = {
+		.source = NETFS_UPLOAD_TO_SERVER,
+	};
+	struct netfs_io_subrequest subreq = {
+		.rreq = &wreq,
+		.len = 1,
+		.transferred = 0,
+		.error = -EIO,
+		.source = NETFS_UPLOAD_TO_SERVER,
+	};
+	char buf[1] = { 0 };
+	struct kvec kvec = { .iov_base = buf, .iov_len = 1 };
+	struct iov_iter source;
+
+	__set_bit(NETFS_SREQ_FAILED, &subreq.flags);
+	iov_iter_kvec(&source, ITER_SOURCE, &kvec, 1, 1);
+
+	test->priv = &cap;
+	kunit_activate_static_stub(test, netfs_write_subrequest_terminated,
+				   capture_terminated);
+
+	netfs_reissue_write(&stream, &subreq, &source);
+
+	KUNIT_EXPECT_TRUE(test, cap.called);
+	KUNIT_EXPECT_EQ(test, cap.transferred_or_error, -EIO);
+	KUNIT_EXPECT_EQ(test, subreq.error, -EIO);
+}
+
+static struct kunit_case netfs_reissue_test_cases[] = {
+	KUNIT_CASE(reissue_preserves_prep_error),
+	{}
+};
+
+static struct kunit_suite netfs_reissue_test_suite = {
+	.name = "netfs_reissue_write",
+	.test_cases = netfs_reissue_test_cases,
+};
+
+kunit_test_suite(netfs_reissue_test_suite);
-- 
2.43.0


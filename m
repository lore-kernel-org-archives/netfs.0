Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632035;
	b=LJqw0bRmjRzZIXx4g0eT0+Pc0eb4U7jT/79dOt5GJYP2F6Vts2BUFBnZQMbE6AWHm/8I
	 drCC+4g90kSSRy0kAf4L2CrS7TKW0qN1pqAuzsEbBEx6+GtYBf7NBKQ6IybiH8e2sZOh8
	 TD5c14U65cWgPBbVPRo680CCxHHmDQ+8l8NWxfCE7fGI/KbkJAQTtzfMOh+i72ZAq7jre
	 R29dp+/R0SRO2/I8UMoNZVX8tC5fxAnLMI0owNAgu1TPRulUOOJDdCd4NVV/4uidFKz/V
	 sqXGytxvM5ci5krAX61UfrKplQE7EhA6dzHEI7AB3KkgX9E6G5siJZd1L3YgotEUJsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fA+/6n3xf0JnFJOXkIesJrFydGTUim2+GD5U2sr0aT0=;
	b=QKzaKKxHWyA1MjIj9OrVmM0hzIBv9EifLq4tKnOO55Wjol6XNlUe9eOABwT2oVeAo5vq
	 uWw3zexxv2zBvaOo4ac1+h/g4hUCe9+2ywtWI9h/Ag6/4cSY7PN6/p+JzIviQYMs78WXX
	 bP1vyle8adJOAnFhUk8zdI5GcXn32GJ0r3kgOkIxGZ4rA9o0ctU9ko75OVS1zNCyi0tlc
	 teUINIw9b1TjwsqM8IfU/cA8P73o8wFQSiZpXxGa7N46274xiaupb0phR9zgWnb18P3tu
	 IkKWcNRQ6BB8RKsQGwOmQRy5TxzCXCFvAWChLUlnHA0FlivdSAJzK1n7Ke5boW2meEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHk0497f;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124C6072C5D
	for <netfs@lists.linux.dev>; Mon,  2 Nov 2026 15:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1124C6072C5D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHk0497f
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so20160765e9.3
        for <netfs@lists.linux.dev>; Mon, 02 Nov 2026 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632032; x=1794236832; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fA+/6n3xf0JnFJOXkIesJrFydGTUim2+GD5U2sr0aT0=;
        b=JHk0497f3mR9qNpnEnMN0XnGNJZqOzQ3Ps5hx4FQtOgM2M9qWyIEGzgjBNDwwsxRuc
         tM2Gy3M/KU3VMdhPZZTOvNGpQrKmnu45RTrnQipJL2QCYV9BuoK7S/u+fKJvha0Iu2cC
         th7esVGsN5S43PoP+Cmz3zTqmpagW2a8YJI8QqpuUZA1tILkfy2jzEG3402NTacaKz4A
         auXQecE71NNrj5p+sjuA+TuMfNsA536zFBKehdTJZw87g/LHCrwViixX/kvDAsujM9f1
         x/DA+jGNs28zLcVCd6Cx/ALoLRO8YFOX6yjA7d/iMqNqX/kIcZvrNTcZDL18F6JWP9z6
         bGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632032; x=1794236832;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fA+/6n3xf0JnFJOXkIesJrFydGTUim2+GD5U2sr0aT0=;
        b=mzO1LDsNHE9RaaH4rMSaKyp9JFPE+RC7041asLvd799xsziHYIyAWUfoo7MdZpkGdc
         yzj9N0qfFA+JRpmPr92g+0W3UFMcj1Rb/l5kFuDZ33kIv/g8VxbiJN1RJ50q4qffaoVU
         AymJKxWbXHSCyxZFeQzOXEzF5iWsed/8b4R3yaEMBdKfj19zXkpuguxyXWraxC15Xr3I
         Fwv/QSpsDjQ9tLFEx30+cr45Oih8RHblay+meuYoJyhXdtUjovSaYIto8B5wPFvbnO3B
         52ijhEfgTMbPua+3LWvlJ/ngALQ0SanKzPZzv+VkjB1mCrGcD6Nm6Vh9frkx2hftl6VM
         6BUg==
X-Forwarded-Encrypted: i=1; AKwUvBwQySzCtk9tbVnt3bsRbR6Wf2bfpiJxHODMjdMocqtn5Ce90xzdERNShEnxk7FomjMKKuTbjA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLKqLSvRGZq66fKStfl+cbWzyrDCD6Zx7p/u1+6DNxpooXy8OvN
	MtKL8/UPiNsqINbqPrgdEpMojGYtdR15ppK+ppfDga+DF5xKXU9HvVHhlGkyTsWXwmk=
X-Gm-Gg: AYBFou2x02sogoUKhafShlTtzAYySXTtfn7GNdY1oXADW9oQ7dZ4Fi0DO4d1qBd8h5F
	2FYJTGgGjrGC/KO4J+wNn/EaoY1gq/RRHXpoVHGQrlovg6NTp2va+CZidHBUioYwQshCAcCG+qy
	fInCwdOgW36mW98RGNrEohT8UNiJPbOdoKdtQlI2OF65IrN9rxHU0v3i7r4g4IApoy38nQOnFn/
	IEP6dzEf9EF8EKiGC+X9Yi1fzIkXxVpf++PLhckY/IfTZOWK4LSZFWrO/Twonw5s2EGO7kHBqT6
	YJSXL9V0kvPH76Js40PlKTRlABJlInk4CmE3ChLfRMluI/Iup0F0vjOcrxV0K5keYEZTysa30YG
	wBmtnQnQ/k7E9jnz0t5MGqf254yUzWAcDfGOPiXujcpscJGZku3uWE5mryTkmN+PmdCOGP9HEDE
	hyt+ttooq4APy7c82v98CXa9vwogYbzPRs7+p6843lvhDLAAHZuKBzvQZ0XJey4Mf4r5lM4oq03
	ID2XtX9LTtT11pRGU90Bdkc/aBSN6iKQ8PzmJYy9dl56VKNOVxVSsAU0n3BFt92mtgnvmD3ULS4
	941f3+Ry0RZnjgy5NzStGSfQgXgGlSFR3HLJk0heIr4Z
X-Received: by 2002:a05:600c:c4b8:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4ac150b38dbmr245909115e9.1.1793632032302;
        Mon, 02 Nov 2026 07:07:12 -0800 (PST)
Received: from localhost.localdomain ([2800:810:84a:dc6d:d32b:1515:b2a9:c74e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm395629535e9.11.2026.11.02.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:07:11 -0800 (PST)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v2 2/2] netfs: add KUnit coverage for reissue prepare_write errno
Date: Mon,  2 Nov 2026 12:06:55 -0300
Message-ID: <20261102150656.207612-3-ivanrwcm25@gmail.com>
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

Stub netfs_write_subrequest_terminated() and call netfs_reissue_write()
with FAILED + -EIO.  Unpatched trees terminate with 0; patched keep -EIO.

  ./tools/testing/kunit/kunit.py run --kunitconfig=fs/netfs/.kunitconfig \
	netfs_reissue_write*

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 fs/netfs/.kunitconfig          |  3 ++
 fs/netfs/Kconfig               |  9 ++++
 fs/netfs/Makefile              |  2 +
 fs/netfs/write_collect.c       |  4 ++
 fs/netfs/write_reissue_kunit.c | 80 ++++++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+)
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
index 000000000000..df3ef10f4985
--- /dev/null
+++ b/fs/netfs/write_reissue_kunit.c
@@ -0,0 +1,80 @@
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
+ *
+ * Large netfs structs go on the heap to keep the stack frame under
+ * -Wframe-larger-than on 32-bit allyesconfig.
+ */
+static void reissue_preserves_prep_error(struct kunit *test)
+{
+	struct term_capture cap = {};
+	struct netfs_io_request *wreq;
+	struct netfs_io_stream stream = {
+		.source = NETFS_UPLOAD_TO_SERVER,
+	};
+	struct netfs_io_subrequest *subreq;
+	char buf[1] = { 0 };
+	struct kvec kvec = { .iov_base = buf, .iov_len = 1 };
+	struct iov_iter source;
+
+	wreq = kunit_kzalloc(test, sizeof(*wreq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wreq);
+
+	subreq = kunit_kzalloc(test, sizeof(*subreq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, subreq);
+
+	subreq->rreq = wreq;
+	subreq->len = 1;
+	subreq->error = -EIO;
+	subreq->source = NETFS_UPLOAD_TO_SERVER;
+	__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+	iov_iter_kvec(&source, ITER_SOURCE, &kvec, 1, 1);
+
+	test->priv = &cap;
+	kunit_activate_static_stub(test, netfs_write_subrequest_terminated,
+				   capture_terminated);
+
+	netfs_reissue_write(&stream, subreq, &source);
+
+	KUNIT_EXPECT_TRUE(test, cap.called);
+	KUNIT_EXPECT_EQ(test, cap.transferred_or_error, -EIO);
+	KUNIT_EXPECT_EQ(test, subreq->error, -EIO);
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


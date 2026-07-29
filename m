Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A293EDE75
	for <netfs@lists.linux.dev>; Wed, 29 Jul 2026 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362439; cv=none; b=aGMgbemKzVYx8gsSb4eSwoLF4y4fzmJOi5mu5+rG2a2ICBNzJddGP3cW3HczW3rdrSRumXnXvTp+n0d0adNMwjPEIMw2R19RvAymSfvokNTsIi6OUZ0Wt0O6j9x5BiRKMdtJ+SKlUX5aJIv9dZIXx5f6YRBuZBvEsIqsKJSdoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362439; c=relaxed/simple;
	bh=c0G3dmuuNY0dy2CHcZLFb3guPHeaGhZwlrnovkufTfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwlOEsQ7lbeNLBeph4DoGt+Q20eKlZlME8ZX2Z4HxDqVwqF9bIaf5BQyL4hOhpRR4z0TZFMHI43xLMJ3zUGQ5VAjOiIqSoPyBWtMLtjy5ELOk3do1DalIwEPxUMZtlmget2/HawiHhY7nUKOJ1/LHryWtJ39zoq2SDfmO1NS0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=STMNSc8d; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="STMNSc8d"
Received: by mail-yx2-f3.google.com with SMTP id 00721157ae682-81dd189c50fso329067b3.1
        for <netfs@lists.linux.dev>; Wed, 29 Jul 2026 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1785362435; x=1785967235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZUAsb9HYPBzr1dnWu/lrqicq+GYlgqjjIxv1YNlsFGk=;
        b=STMNSc8dnNONjPKfBz+9dZ6qPSLQ07tW7IDgDOfBLgu76W7fm3j5ZczlCtdsxeKVIk
         LYSQ+SYo6Mdmu13q7AzrABmsWW+JAuAkv8GbGiVoZppsInF3I/3wG+9UevXXVYwG1fTg
         f0cLMVNUrQjsp1pXLLJdyQLS8THbsQKDPVIsLZY6BjK+CZOgxDn4KI4hymhzO9k9TNY7
         OC+PPwW3rgM3owEL7dMG2AVGa2uk1JWm1oZ4Fc3ozmq5y74zahw8pkOB4YW9TS8alOTi
         R08TjwvzTCTewxPSbmFJuipU8IlDNg1TJ5Xc+BJSmSp2RyyitDxHUXiXT/7/mIpWKeqp
         0XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785362435; x=1785967235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZUAsb9HYPBzr1dnWu/lrqicq+GYlgqjjIxv1YNlsFGk=;
        b=UnD59ZnGuwBMRwIsGdOb1/qsLVM820/fjBfpfetTUsl2dnQTx3KxWeUAOZ4E+sHlLR
         6POSjiVk9p8lpAQrxM7/fGPQd/uva/yMoMHHp9OO0gIsqo29RQn/VPSbA3RWoXTRjrVF
         FdbVc2B+KLULVyavOIdWr3X84rwS6iBgVZTbbG7+tdAa5rR0jdDKRmmnYbz117WiTmDc
         6QccDbDM5sbNkXjTLaS84C1bHN6F0qzC1VLt+buMwOuRq8cfdIj4Piw+9wbzHAwPQbSo
         yDu+0vhMFIr5YOXhyoCvMoQ9Lhtyl7mDB4AlxedNzBpKDyyOybuVhUVb/NagHxgdfO/N
         4zhg==
X-Forwarded-Encrypted: i=1; AHgh+Rpb1VKHG+51j6PYTBr3UsFE4qgVixYBGt1mbWrsfDZ3tQuS01GSqFXm9XjjnlbVmGlju/XiAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIcLQDjvt1yBUYMxSfISrZ31+3zxVj/7UqNVvtNcyJCm+ux5P0
	hTfJztmuV6ytZJtRiUK/QYeHlXuq5c86paE1ZdBzyMJ4YP1YUrE6Xvqmim6Pz7Lm8zXj
X-Gm-Gg: AR+sD11V900DOfKRt7veR525oKFOjouGlRkm6prLwCDiAS+lOMiMtBRMC0rjBb8BF9D
	ZzSgvccqmSqKqw7wxsTKyyNPh4Q4ZT83dfgfEf4F4N4nAw77Yz2IwSoXyAZlupoDU4Qm368vrtO
	4QNXRkr0l7CVgMeMkMDfCkEZcMimWaMJHGPW9neF3xRrwPEZK/UOWgTJ9QOX7VLunwhOH8bOFP5
	gvcrHJTgmCn72UGViLaYMQibSz/4NUBhCYIRB5Gn1G0kjWABZawl5tACchn0vaPkToophLNTB4t
	97zs7FuRAMsilCZCyrifpi0ycG3YX+B6rxXS6HjpDtWUM8Ls7qGRJf8MY/teA4rxVuRs+Mj5IWV
	BGmhIN8LOoNPXldBP/yjR9T+AyMaUFVvt3pV9dmCaHqGLIYI3og7yXgX62pU92geHyVXhzcsXgo
	mIU9jVM+0dV8oAM1icXbWOx/8vuUggDz9y/8D/P4pC3vRwv9JBJU/xvz4vmRIbGok/0A/qhNqF6
	/lOUCG99qbkWzlQpWnTrTwtTKSMMnode4yDJFhSXWVuzzhLXTFr
X-Received: by 2002:a05:690c:6987:b0:81e:ba5b:97d2 with SMTP id 00721157ae682-81fb5e800f1mr8501767b3.2.1785362434907;
        Wed, 29 Jul 2026 15:00:34 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb7de8f28sm557587b3.28.2026.07.29.15.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:00:33 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	pshilov@microsoft.com,
	longli@microsoft.com,
	dhowells@redhat.com
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smb: client: fix request buffer leak in smb2_new_read_req()
Date: Wed, 29 Jul 2026 18:00:17 -0400
Message-ID: <20260729220017.944651-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smb2_new_read_req() allocates the request buffer with
smb2_plain_req_init() but only publishes it to the caller with
*buf = req at the very end of the function. Two error returns sit in
between:

	rc = smb2_plain_req_init(SMB2_READ, io_parms->tcon, server,
				 (void **) &req, total_len);
	if (rc)
		return rc;

	if (server == NULL)
		return -ECONNABORTED;
	[...]
		rdata->mr = smbd_register_mr(server->smbd_conn,
					     &rdata->subreq.io_iter,
					     true, need_invalidate);
		if (!rdata->mr)
			return -EAGAIN;

On either of them the buffer is neither released nor handed back, so
it is leaked. The caller cannot clean up after it: smb2_async_readv()
does 'goto out' on a non-zero return, which skips the
cifs_small_buf_release(buf) at async_readv_out, and buf has not been
assigned at that point in any case.

The write path has never had this problem. smb2_async_writev()
registers the memory region inline and jumps to its release label
instead of returning:

	wdata->mr = smbd_register_mr(...);
	if (!wdata->mr) {
		rc = -EAGAIN;
		goto async_writev_out;
	}

Commit b7972092199f ("cifs: smbd: Retry on memory registration
failure") changed both sides from -ENOBUFS to -EAGAIN in a single
patch, which puts the two shapes next to each other.

Only the -EAGAIN return is reachable in practice, because
smb2_plain_req_init() calls smb2_reconnect() first and that already
fails with -EIO when server is NULL, before anything is allocated.
Both returns are given the same treatment here rather than leaving
one of them correct only by accident.

Because -EAGAIN is a replayable error, the failure also reaches the
retry block at the end of smb2_async_readv(), which marks the
subrequest NETFS_SREQ_NEED_RETRY, so a failing registration can be
retried rather than ending the I/O, and every attempt that reaches it
leaks another buffer. smb2_should_replay() short-circuits on
tcon->retry, so on a hard mount the attempt count is not bounded by
the retrans setting.

Only the asynchronous read path is affected. The synchronous
SMB2_read() caller passes rdata == NULL and the memory registration
block is guarded on rdata.

The memory registration failure path was pointed out by the Sashiko
AI reviewer while it was reviewing an unrelated patch to
smb2_async_readv().

Fixes: bd3dcc6a22a9 ("CIFS: SMBD: Upper layer performs SMB read via RDMA write through memory registration")
Link: https://sashiko.dev/#/patchset/20260729192002.876156-1-clusk%40northecho.dev
Link: https://lore.kernel.org/all/20260729192002.876156-1-clusk@northecho.dev/
Assisted-by: Claude:claude-opus-5
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---
Tested by fault injection, not on real hardware. I have no SMB Direct
setup, so a throwaway debug patch forced the memory registration
failure branch on both the read and the write side, with a countdown
module parameter, and the resulting error paths were measured. The
mount was ordinary SMB2 over TCP; nothing was simulated beyond making
the registration return NULL.

Detector: small_buf_alloc_count, the counter behind "SMB Small
Req/Resp Buffer" in /proc/fs/cifs/Stats, incremented in
cifs_small_buf_get() and decremented in cifs_small_buf_release().
Second detector: kmemleak.

Same kernel, same test, without and with the patch:

                                        unpatched   patched
  clean read, no injection                    +0        +0
  5 reads, one forced read MR failure each    +5         0
  5 writes, one forced write MR failure each  +0        +0
  buffers still allocated after umount         5         0
  kmemleak objects under smb2_new_read_req     1         0

Both runs consumed all five injected failures on each side and
returned the same errors to userspace, so the only difference is the
leak. The write column is the control: the same forced failure on the
path that already has the release does not leak.

kmemleak on the unpatched run, the 448 byte object's contents
starting \xfeSMB:

  unreferenced object 0xffffa241013cca80 (size 448):
    comm "dd"
    backtrace:
      cifs_small_buf_get+0x15/0x30
      __smb2_plain_req_init+0x33/0x230
      smb2_new_read_req.constprop.0+0x93/0x2e0
      smb2_async_readv+0xfd/0x3c0
      cifs_issue_read+0x87/0x170

kmemleak found one of the five, which is the usual false negative
when the address is still lying around in stale stack memory. The
counter found all five.

Two limits worth stating. The five failures came from five separate
reads rather than five retries of one read: in this configuration the
read was unbuffered and netfs returned EAGAIN to userspace instead of
reissuing, while the write side did retry and completed successfully.
And forcing the branch says nothing about how often a real memory
registration fails, so the reachability argument in the changelog is
from reading the code, not from measurement.

Build: x86_64, gcc 15.2.1, W=1, clean in both
CONFIG_CIFS_SMB_DIRECT=y, which is what compiles the changed hunk,
and CONFIG_CIFS_SMB_DIRECT=n, which checks that the new label is
still reached. checkpatch --strict reports 0 errors, 0 warnings, 0
checks. Applies to cifs-2.6/for-next at fa724e235cfd and on top of
the earlier patch in this thread.

Not marked for stable. The leak is real but I cannot say how often
the path is taken in the field. If you think an unbounded leak under
persistent memory registration failure warrants a backport, please
add the tag.

Per Documentation/process/generated-content.rst: this patch, the
analysis in its changelog and the test harness were produced with the
assistance of Claude (claude-opus-5). The memory registration failure
path was surfaced by the Sashiko AI reviewer on an unrelated patch.
The claims were checked against the tree rather than taken from the
tools, and the numbers above are from runs I can reproduce.
 fs/smb/client/smb2pdu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4ce165e40657..b885060be200 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4564,8 +4564,10 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	if (rc)
 		return rc;
 
-	if (server == NULL)
-		return -ECONNABORTED;
+	if (!server) {
+		rc = -ECONNABORTED;
+		goto free_req;
+	}
 
 	shdr = &req->hdr;
 	shdr->Id.SyncId.ProcessId = cpu_to_le32(io_parms->pid);
@@ -4596,8 +4598,10 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 
 		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->subreq.io_iter,
 					     true, need_invalidate);
-		if (!rdata->mr)
-			return -EAGAIN;
+		if (!rdata->mr) {
+			rc = -EAGAIN;
+			goto free_req;
+		}
 
 		req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
 		if (need_invalidate)
@@ -4638,6 +4642,10 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 
 	*buf = req;
 	return rc;
+
+free_req:
+	cifs_small_buf_release(req);
+	return rc;
 }
 
 static void
-- 
2.54.0


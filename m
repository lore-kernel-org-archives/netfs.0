Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65082353ECB
	for <netfs@lists.linux.dev>; Thu, 29 Jan 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708274; cv=none; b=YLVpkZ7Cu26AM/fZQ3sfxAHNH4Q8M4z1Id3bXTF6a8x1ZHA2YLarCRgZScz80qyWaNIJaq1xAfHko4i2tdAyRL8ng3VCaHP4zATvnhclyX/Aj4+43hp0Wm7Z0FIVWJERyGbR5XdfTHEMs+5NQl8C8qluovaP9xg3u+2L7pL6Bgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708274; c=relaxed/simple;
	bh=gGboFYBJHGwbQ6CmsqonPgIpA+0UuN62xAZ9Z1ScB3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnjR+8R9IzgK9k0y/WEgAFYfpGQrqHng/AKeLinWraMysM37BmS9Su0BvMAlCnO/Se/UqVEyHJRYzL9T44OvcSqs6riJXezbT1D54AfKMEF4ffGa8wDxSER6szawH3N+l2xJftkI9ofT4+WY3J4e+kInjvQcMoks/udrwosELHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuF2aDUa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuF2aDUa"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8231061d234so1012086b3a.1
        for <netfs@lists.linux.dev>; Thu, 29 Jan 2026 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769708273; x=1770313073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlNMowHZilVKV7zVKlSzSEcRiQso4KCzR8rbSekgQMU=;
        b=VuF2aDUak+n0JmlgaPAU8UELsyfGZB1Xb16ue5wXzZAIoMUvC/1sN4VO0Su/uG+ucH
         QP6uQdR1yvbws4NrKTdkWkdQqjNtB9R2UW6EOmNOsOG6DoHMNe8kcvYY2Xjo9S3qWMpx
         r/pjizBMyxwhZ67h6pBA4TVJ7VprVi643OLgIiB7cCyV5DRqmfinXwJM44gncrahpWtE
         siX5JL4H3VQ0WonQenkw7E3aX6wgC4ZzqPgOuw1tKaZ83yMh7ib4srMr0HrnJdVUQGUh
         NpTyJWqVTKZNilhmZEZJLKrW1WVlU2/XHvOAO5k9Ch/nFBcF1a7QIWscQJeWWyTKfNOu
         P9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708273; x=1770313073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XlNMowHZilVKV7zVKlSzSEcRiQso4KCzR8rbSekgQMU=;
        b=YuemP6hXhC94vz7a/g1jH7kn0K5xZUc+e2l5YNa36YfzYHLh0GghYpScHmIGPewARa
         FQrbvF1iQ8dOOmPBlWQdTOp8WQERhVx9yC3GQ5t+IewPO5P5aqTXoXOPB3zWno9SiSvD
         cT8Nxluf9hwLwS0kgob1echWFlPUWUf3v61t6qk5aRAJ4+MvyEsSRlsnLZugxtyYDL3y
         4e0itO5FPiKozFPjPK7g7TAw6THHreINniWFhRYABjZQQNwVkewh8KwRddn6F+9ZWD90
         TK54flH7+lnwCoH+IeeaVLDaIrdOIYpxvmTpxuJY5msDaPcfYoFVEB8QF/WKbNQ0OEPd
         /OlA==
X-Forwarded-Encrypted: i=1; AJvYcCXmxs4mC70JlJcDD6kzAw/MijuFqA7UA6cVrpdKCNkcTOrdKnWv960H9SGhgqm8xtOqr1FkEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya1/0IFmUbxY9KrLT7paRxdm0UemCmcqOcqo7OaoKPyZTaEEvi
	Zu3PxZAjvmIEvN8N4CaG4h0bWLmIpmPz8h3DRmHCXpSjVo8qPm1hb7BV
X-Gm-Gg: AZuq6aIv7kwXOCaFL6bYMnmnUKPHeocjNduNOceSXC5hAK9ZhrvxLztfFwj7gdtUEMT
	LT1coS6Mw4ACtiE1R16ylRMz5UV52hTdyxKshJnI8DWEg2mKgtonEbPp70UFZWovIEC718E3fDl
	DPzWZHzrkDCRwTKayhNCOiCn7T6VURDKG3dw2xfQLQ/vTxJsjzySlka65ZAWTK7z7qafRKu7Sv7
	4byC4wr6R3HvRoX/n4BSHlvuiXhNK7QwlYBbYO271bAdjCn4MOsWDUti37pvT4b+kEEO6xUXUj2
	EVgvdMzt7dsI2UhBMd5v6Copobd9Lu6QJCQiJUFT3sb/+KEIiVY7kEZn/p7DvH6Uxh5wRjpRaer
	iKcmb51OHB6baNe0AL00LIAx7zFDWLW027oYJyTIIh6SDsGXIn5H498CaLuiLQnDlOLZ3hLIUyg
	JZPyhoYC3t1Jt8d7iv6YwbYVVU7gKzY5mkI/O3Zpksaybh4OSJwZA=
X-Received: by 2002:a05:6a00:1893:b0:81f:b1d4:b486 with SMTP id d2e1a72fcca58-8236917312amr8964915b3a.8.1769708272749;
        Thu, 29 Jan 2026 09:37:52 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6a5desm5512659b3a.28.2026.01.29.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:37:52 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>
Subject: [PATCH v3 2/4] netfs: when subreq is marked for retry, do not check if it faced an error
Date: Thu, 29 Jan 2026 23:07:09 +0530
Message-ID: <20260129173725.887651-2-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129173725.887651-1-sprasad@microsoft.com>
References: <20260129173725.887651-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

The *_subreq_terminated functions today only process the NEED_RETRY
flag when the subreq was successful or failed with EAGAIN error.
However, there could be other retriable errors for network filesystems.

Avoid this by processing the NEED_RETRY irrespective of the error
code faced by the subreq. If it was specifically marked for retry,
the error code must not matter.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/netfs/read_collect.c  | 10 +++++++++-
 fs/netfs/read_retry.c    |  4 ++--
 fs/netfs/write_collect.c |  8 ++++----
 fs/netfs/write_issue.c   |  1 +
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index a95e7aadafd07..7ac11125ca028 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -546,19 +546,27 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		}
 	}
 
+	/* if need retry is set, error should not matter. pause the rreq */
+	if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
+		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
+		goto skip_error_checks;
+	}
+
 	if (unlikely(subreq->error < 0)) {
-		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		if (subreq->source == NETFS_READ_FROM_CACHE) {
 			netfs_stat(&netfs_n_rh_read_failed);
 			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		} else {
 			netfs_stat(&netfs_n_rh_download_failed);
 			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		}
 		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
 		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
 	}
 
+skip_error_checks:
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 	netfs_subreq_clear_in_progress(subreq);
 	netfs_put_subrequest(subreq, netfs_sreq_trace_put_terminated);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index b99e84a8170af..7793ba5e3e8fc 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -12,6 +12,7 @@
 static void netfs_reissue_read(struct netfs_io_request *rreq,
 			       struct netfs_io_subrequest *subreq)
 {
+	subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_rh_retry_read_subreq);
@@ -242,8 +243,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	subreq = list_next_entry(subreq, rreq_link);
 abandon:
 	list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-		if (!subreq->error &&
-		    !test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
+		if (!test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 			continue;
 		subreq->error = -ENOMEM;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index cbf3d9194c7bf..61eab34ea67ef 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -492,11 +492,11 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error)
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		subreq->error = transferred_or_error;
-		if (subreq->error == -EAGAIN)
-			set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-		else
+		/* if need retry is set, error should not matter */
+		if (!test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
 			set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-		trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
+			trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
+		}
 
 		switch (subreq->source) {
 		case NETFS_WRITE_TO_CACHE:
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index dd8743bc8d7fe..34894da5a23ec 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -250,6 +250,7 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	iov_iter_truncate(&subreq->io_iter, size);
 
 	subreq->retry_count++;
+	subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_wh_retry_write_subreq);
-- 
2.43.0


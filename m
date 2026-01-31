Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B32D9798
	for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769848419; cv=none; b=C1nRXUsd5o5e1oOPM/AK+rEbPurqQof4cxp+qSCyX59ztMeaERzOWpxpztgQExVCVOeTxRpRMRtzNm/T977vN2mqoru3UD/Ndx6ObCULR9RwQ/RASYyD49SMQ5iKoC+l88bpG7ISofz/79EJaZrpJDIzjBJPGqLGZuzdWE3vILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769848419; c=relaxed/simple;
	bh=32HI3VVuet9CGhqAqFayH22V8ZI32Slvo8w1XSbuiY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnZe4vNRV8HUCD6N9VtORR6EACETCEXAXfZ2eNYq0X2CqnVPXHCyKxrz+3NPdI1kXruckNxhj4oXdCSD8PN71A5Kcar8LHlrIccGo89gWUhRVFo7MSCkGx8Hiqr87ndA4B+n4LzDfz4WCTrjeDvyFL0hSAa7Gh8ujnUhrfyuCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu22/LzO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu22/LzO"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6788f3db37so322732a12.1
        for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769848417; x=1770453217; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBxtvZtO443rAUE6E1s+dTwvzdvck5HHY7gnJWK6jJQ=;
        b=Gu22/LzO4OCXdal6HoEbbn2t1EG8ZjyVZv4XzubGWyiPlXZU1BKyWTWSRNDFOFyEqj
         cGnvN61bwVTA6XMqb5xLx9/85uWyJBMUTJMUiCZUoXiMrlo5FYBUv88jnJfqabUdzmK7
         svs4f5OeTI23zwaBwRYA/vlxhYMSpnMWPHlm3IH58jK9VkstekfrpSXP/APQO8nCILLf
         mUtEL067U/Ib6/a/42Cjel8v6wH6ATVBAb6F1kh/Jh189iWRduVCwiVcRHpRegu2+hdQ
         JI68358ghmd9CMSy9O89MDxrjUhbr/rjByb+dwRb/sr/J163iIIrhrs7BGYFGKJRK72Q
         Tcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769848417; x=1770453217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gBxtvZtO443rAUE6E1s+dTwvzdvck5HHY7gnJWK6jJQ=;
        b=DgEnEX1XqgaB4+vjAIDQQaL2epFPLjh674wuDHS2+JzSAshRUq2yjyp/X55Qw4+Z7B
         69Y+tJr1upZFc4OhMR6VG1w6lh4JTyj8RcBHm9+ahBO9mjqM3hV4l/QAmXA4jHGZ9vwN
         x6Sj8EWYuNjsneZQnhovrC8H09Sue3jQ1jaJYwUKm9hlYPRrTzKe0daxg/pzcSSUWMbD
         0ZA+BmmzTILvLmiDc4RNq0RG1pqD3YKIAixwIocFIzpGl67ZYo26yzDn4dB2ZTM3fdYS
         3NIUQ9/HeMEGwOO7+d7d7vPZ3J+/q/nZKOpnjsj6suPXxoWN2N9VNVtrnmcKk9AiVAI1
         7sLw==
X-Forwarded-Encrypted: i=1; AJvYcCXaXCDAkWQBGCRHicWLkg9d34+DB26SjMZNk3Tnu+T8bbf9WKGXCMRFM9FA/qqSq8rKP3y3iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLeaWjg2GsKu2hjclIzDB19ZmFctb4tjYW2QOaxqILkHJAHeTe
	uuqiyTABC2WMLX/tP4eUk8POr7+4BGe0NmlYp6yLvAIfpRaO2S8s1cHD
X-Gm-Gg: AZuq6aJVLTEykKjTnBI2HFLOo9ib3LpgrTIlX0/7QILQh6S0D9+9JwjOFx0tA72ZO3K
	IYcRw25GYo5QTdgJVaQLjCcTRejBJ+FXqW1UyEYEId1yhhjjQWY6jQ7hSR3LGIh6IrmXiUC1bwQ
	NyjGNt83D8c93se1ijhftuoYiG+iLswoOTW3dF9FO3JF+p86fVM3jwd+VVG9oWrbryFmIgDbahe
	AiUuiKl0hNotuAMBqy2NI8PvF2nL3NnbSZ/SySeEkZtOB9LoBhfS25caexhICCPJYv/5509FvSC
	3GZNS8Tzbi9UApxmQ3upspqzu4vWA0CPbq0Cs3AxYFYfbvrNv79jfqjhd7e1co+BVXPqe/fqssI
	VcVtxILfV90UMLj1oLbLn96F8rcSsxvtKIPJtiqvdn0w/i7MF5V7mWgQpfoKF9P21hDiJf1itBX
	rVGfCeIqtsyii7cr7V6qpLX6sUSi1eRrQSmPlgJzY=
X-Received: by 2002:a05:6a20:12c1:b0:38b:d95e:69a9 with SMTP id adf61e73a8af0-392dffe929amr4724099637.16.1769848417283;
        Sat, 31 Jan 2026 00:33:37 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f610266esm13479121a91.4.2026.01.31.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 00:33:36 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>
Subject: [PATCH v4 2/4] netfs: when subreq is marked for retry, do not check if it faced an error
Date: Sat, 31 Jan 2026 14:03:04 +0530
Message-ID: <20260131083325.945635-2-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131083325.945635-1-sprasad@microsoft.com>
References: <20260131083325.945635-1-sprasad@microsoft.com>
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

Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/netfs/read_collect.c  | 10 ++++++++++
 fs/netfs/read_retry.c    |  4 ++--
 fs/netfs/write_collect.c |  8 ++++----
 fs/netfs/write_issue.c   |  1 +
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 7a0ffa675fb17..137f0e28a44c5 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -546,6 +546,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		}
 	}
 
+	/* If need retry is set, error should not matter unless we hit too many
+	 * retries. Pause the generation of new subreqs
+	 */
+	if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
+		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
+		goto skip_error_checks;
+	}
+
 	if (unlikely(subreq->error < 0)) {
 		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		if (subreq->source == NETFS_READ_FROM_CACHE) {
@@ -559,6 +568,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
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


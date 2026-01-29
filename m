Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266D353EFD
	for <netfs@lists.linux.dev>; Thu, 29 Jan 2026 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708276; cv=none; b=i7sldErtl23IQIRTeTdVgPZurDA0GvaJt7s8MXSpAOoylnPmTe3QlVLQYk6FE1R026OynwULRpcV46xpngOd+Rzy3je8W22keNZWt23o3/eUTxWCKheHMF/f6CukgXi6qEEs4vWLNo7uToNSpDUE9mQYiJ/FM2LpOli6zbgsid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708276; c=relaxed/simple;
	bh=gvYiKn5oDxUVk6P5qTF/G/mVc5BjhcQ8+5P/bcMaGss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZxqS+uq4JXX74QiSH1Z4Wm/ttBwlHUA065UJYcGhv/XiZ6v83izn8F4JoMIt4LQUNI8MOoVGhL5AGOq0aDwpfPZE3q1ZwHH9Qhp0bA3uuXYW+j/5grK6zaQR8jCpSsPvdbexYdBeuqjuQVyxwiFXZbSraBPNF9/2GvNmz9V04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/+Sy4RR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/+Sy4RR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so716594b3a.1
        for <netfs@lists.linux.dev>; Thu, 29 Jan 2026 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769708274; x=1770313074; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC3j1nuoIF4S0p17bi2j91kgQDo7Qz6LfflWWUzaCxg=;
        b=c/+Sy4RRIJ3ugyuVhaoaxHZGri5dw4755xrQcLkhcURYsSA0V/tmcksyktt7U4jV8J
         x/8pLQYM5qR893twnOIuMbuQEk9YVMfwXi2phTsk5ApSTmRlrc+zGtYemZjwGHmWhQsZ
         +OUYIivU2oEtNvywAEefMnemINvlkfjG3SaETIUhHfaNyxgfYam6tncEfevdPeLjInr3
         U2ccBjU0nerPiARXcx9eaEKUjoS4jK7vZgOgLNNJDm6YEC3TTOf6u34WiZZ5kVH4vjAN
         dwj2fatP7J7hOHbK8FonNU0MqGLmCgnxwNvBQ4xNZhjSsK9Z6wSdQpygU9AsbSnN7GKQ
         47Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708274; x=1770313074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vC3j1nuoIF4S0p17bi2j91kgQDo7Qz6LfflWWUzaCxg=;
        b=w+8c2oYnbEOULlzU/StiaCxzq7ShPF3fw8N33LcjlX2aolhk6AEsAmw98rq161qN5o
         bf7AGP4wDq604MFjj179TlJEG5x555ijYuyFZB3Y+EMg2uiCP5LH5VHXtRBw6cxI3ZSY
         a5DbGU9qmboOL+tj7HaQghnIN4ffheoDgCzGmF6n5HbM4t6RaCWlBJy/vBDCzGsC2Orq
         9PtudfXlhomhLsiZm8VbH32kcFn69mXifGiuLxP/u/4Hx0XTEGKvlnT5zcVVeVxwOy46
         IwkXKsy4EIOJrX4mu02FaSS9JHN8M31E3UvGxzXYFT0Ujr03tsqbzzj8iuZkE4V+QmnG
         oA+A==
X-Forwarded-Encrypted: i=1; AJvYcCXWnsxTaKRsDH1O9m7927mTR/bYWt9HuiLrNnqfGEvus0QB8HQqlvnvNKhW9nEl2TyfdG/B1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGun8D7U4c/Gucla9NgB4MW6gmJJiRz96RVf3gClNbhxt+vSKn
	+QSU7xMwfhcbQPu9mu7uChusvl/TrOo01m7+epZv8OwIERxXiYHsUfrEK4T7xwzZ
X-Gm-Gg: AZuq6aIss25BiljVaAQIE5vCt7zWn3jbcY4YPhMO1qkFFEkWKOuhqqDWGdaPFcForM6
	NG+ctKL6YpYrwKSkjeexX7AP1Lnoymo9KC5015wrHKHuhcKUP22S/dV0LGj4BuN3t3Ne1DfzwI5
	Cw68FK7SB6+NBQZM7jqzYu56LIS035H4sT7qMuck8ZweJM88shbVvZs7pfUHJp3rerp2qHZF/Fm
	OlvKKm8NzGNKhv9tHDqv6VSWBD+z6z20CCdeAAXMWifgb9q5FT97AcB4931prW6TOdefJNuRlMr
	X9Y/bxgy2bwTrGlzA2MWGYa6Oj/EtFjBbogZbj8hkgyMtksSkmoFMqsFBmhTZYkdNUzEQXixQe8
	IZkuH6kUfToypYdJAx9QHHAtJlkr71HmAQVkfOMTzZPzHiHRiUfQentlklBca8TqjvXtZLoQeTy
	XYjh1O2zdntiwEq7FOU0RVlb//2WWAs8GPypmtW/F+
X-Received: by 2002:a05:6a00:ad06:b0:821:7307:44cf with SMTP id d2e1a72fcca58-823aa43a205mr130388b3a.15.1769708274448;
        Thu, 29 Jan 2026 09:37:54 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6a5desm5512659b3a.28.2026.01.29.09.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:37:53 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>
Subject: [PATCH v3 4/4] cifs: make retry logic in read/write path consistent with other paths
Date: Thu, 29 Jan 2026 23:07:11 +0530
Message-ID: <20260129173725.887651-4-sprasad@microsoft.com>
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

Today in most other code paths in cifs.ko, the decision of whether
to retry a command depends on two mount options: retrans and hard.
However, the read/write code paths diverged from this and would only
retry if the error returned was -EAGAIN. However, there are other
replayable errors in cifs.ko, for which is_replayable_errors helper
was written. This change makes read/write codepaths consistent with
other code-paths.

This change also does the following:
1. The SMB2 read/write code diverged significantly (presumably since
they were changed during netfs refactor at different times). This
changes the response verification logic to be consistent.
2. Moves the netfs tracepoints to slightly different locations in order
to make debugging easier.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/cifsglob.h |  2 +
 fs/smb/client/smb2pdu.c  | 79 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 3eca5bfb70303..f6ebd3fd176d7 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1507,6 +1507,8 @@ struct cifs_io_subrequest {
 	int				result;
 	bool				have_xid;
 	bool				replay;
+	unsigned int			retries;	/* number of retries so far */
+	unsigned int			cur_sleep;	/* time to sleep before replay */
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 7d75ba675f774..b8adfd2c55b8b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4650,9 +4650,19 @@ smb2_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 
 			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);
 			rc = smb2_verify_signature(&rqst, server);
-			if (rc)
+			if (rc) {
 				cifs_tcon_dbg(VFS, "SMB signature verification returned error = %d\n",
-					 rc);
+					      rc);
+				rdata->subreq.error = rc;
+				rdata->result = rc;
+
+				if (is_replayable_error(rc)) {
+					trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_req_submitted);
+					__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
+				} else
+					trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_bad);
+			} else
+				trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 		}
 		/* FIXME: should this be counted toward the initiating task? */
 		task_io_account_read(rdata->got_bytes);
@@ -4728,6 +4738,14 @@ smb2_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		if (rdata->got_bytes)
 			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
 	}
+
+	/* see if we need to retry */
+	if (is_replayable_error(rdata->result) &&
+	    smb2_should_replay(tcon,
+			       &rdata->retries,
+			       &rdata->cur_sleep))
+		rdata->replay = true;
+
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
 			      server->credits, server->in_flight,
 			      0, cifs_trace_rw_credits_read_response_clear);
@@ -4776,7 +4794,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	rc = smb2_new_read_req(
 		(void **) &buf, &total_len, &io_parms, rdata, 0, 0);
 	if (rc)
-		return rc;
+		goto out;
 
 	if (smb3_encryption_required(io_parms.tcon))
 		flags |= CIFS_TRANSFORM_REQ;
@@ -4788,6 +4806,13 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 
 	shdr = (struct smb2_hdr *)buf;
 
+	if (rdata->replay) {
+		/* Back-off before retry */
+		if (rdata->cur_sleep)
+			msleep(rdata->cur_sleep);
+		smb2_set_replay(server, &rqst);
+	}
+
 	if (rdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(io_parms.length,
 						SMB2_MAX_BUFFER_SIZE));
@@ -4823,6 +4848,17 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 
 async_readv_out:
 	cifs_small_buf_release(buf);
+
+out:
+	/* if the send error is retryable, let netfs know about it */
+	if (is_replayable_error(rc) &&
+	    smb2_should_replay(tcon,
+			       &rdata->retries,
+			       &rdata->cur_sleep)) {
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_retry_needed);
+		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
+	}
+
 	return rc;
 }
 
@@ -4936,14 +4972,20 @@ smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
-		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 		credits.value = le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
 		result = smb2_check_receive(mid, server, 0);
 		if (result != 0) {
-			trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_bad);
+			if (is_replayable_error(result)) {
+				trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_req_submitted);
+				__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
+			} else {
+				wdata->subreq.error = result;
+				trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_bad);
+			}
 			break;
 		}
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 
 		written = le32_to_cpu(rsp->DataLength);
 		/*
@@ -4958,7 +5000,7 @@ smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		cifs_stats_bytes_written(tcon, written);
 
 		if (written < wdata->subreq.len) {
-			wdata->result = -ENOSPC;
+			result = -ENOSPC;
 		} else if (written > 0) {
 			wdata->subreq.len = written;
 			__set_bit(NETFS_SREQ_MADE_PROGRESS, &wdata->subreq.flags);
@@ -5000,6 +5042,7 @@ smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	}
 #endif
 	if (result) {
+		wdata->result = result;
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
 		trace_smb3_write_err(wdata->rreq->debug_id,
 				     wdata->subreq.debug_index,
@@ -5022,6 +5065,14 @@ smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 			      server->credits, server->in_flight,
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
+
+	/* see if we need to retry */
+	if (is_replayable_error(wdata->result) &&
+	    smb2_should_replay(tcon,
+			       &wdata->retries,
+			       &wdata->cur_sleep))
+		wdata->replay = true;
+
 	cifs_write_subrequest_terminated(wdata, result ?: written);
 	release_mid(server, mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
@@ -5140,8 +5191,12 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	}
 #endif
 
-	if (wdata->subreq.retry_count > 0)
+	if (wdata->replay) {
+		/* Back-off before retry */
+		if (wdata->cur_sleep)
+			msleep(wdata->cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
 		 io_parms->offset, io_parms->length, iov_iter_count(&wdata->subreq.io_iter));
@@ -5187,6 +5242,16 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 async_writev_out:
 	cifs_small_buf_release(req);
 out:
+	/* if the send error is retryable, let netfs know about it */
+	if (is_replayable_error(rc) &&
+	    smb2_should_replay(tcon,
+			       &wdata->retries,
+			       &wdata->cur_sleep)) {
+		wdata->replay = true;
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_retry_needed);
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
+	}
+
 	if (rc) {
 		trace_smb3_rw_credits(wdata->rreq->debug_id,
 				      wdata->subreq.debug_index,
-- 
2.43.0


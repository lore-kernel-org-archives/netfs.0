Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9782FD7DA
	for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769848421; cv=none; b=jLZCsNfpPSndrXOBr92FtD2iPUNtzqrnveUVSVQ7TyL6AGAvBWn+HyH6zuvtzC7d2H+C5YPDZLvKoVF4R/jXAyLPzx09ZkmIxtCytlI6t7k1cDLtI5hBV51FZAUE7Npq3qcVtyGCuduEtJD0ukIwolmhjxDd1kVDfo5clau51ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769848421; c=relaxed/simple;
	bh=PZReqsRFqEbjyH3sRN7Lx0F/Gj66WLJnFALoI9BOb90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVXnRgbNRM1VNraZLHz0w9GVOF8CNK12dxPd9eB++/zgovqshXC44oy8UgH4Tc5j4AmdFM9LkN5uLBvFDovpw2odwzoXPK+xJB6smyoBDJhA4rWQbpbJN/eq+vCXGnOVQFdj/3cIqeaWQIKrccbRorqJArVrAOlul6qk3hM3ANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U24SzQ+N; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U24SzQ+N"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1807976a12.1
        for <netfs@lists.linux.dev>; Sat, 31 Jan 2026 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769848419; x=1770453219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOZ6ZHcm6ppEdluoyXDcvmAOKAm8r5cFvGsVVYHXadE=;
        b=U24SzQ+NQkqq29+frWE69W0eo6NrSRL3sDv/2XUHMF7nQm80h5j5ArgNgsciCDBWRb
         M4CkZG6GWoaymnszUOCJ2B/Q/YErRvhOA7B+EEEzpHGH4l/+/oxGBtrqFk+CPeTU1E+O
         ksbPf/pXD2zjzpfT2NDjW548bqblSKhOJUmqvlrIvbWvB4NEc2JS3dcaISiyHO89M1sJ
         a3iQpbbwhf0LJyQR7rjXKmoAo8NMjvFun6AgFMUmzZXN9aHxogAdLGAzYi+spTqBNHdX
         yi6lBtuulesqf0OzvRal+WQgMU03MZvn5L39Ohl+cQyXi0rJmmfe+UmaqXY73s/7LjOO
         T35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769848419; x=1770453219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOZ6ZHcm6ppEdluoyXDcvmAOKAm8r5cFvGsVVYHXadE=;
        b=DggAjD8ep5iIplwIWcs9WxikwPjVYKsu50a1yHjzopElMNrBk4RQmdwQXufy/VCX25
         LQLyjlmF49QwMoxYAdrtVovCvIOxouFpAhlfSI3A/aWdSNj3gTIhchpue82yvHsJmosb
         usaT5eA4slDenv8CL0+LpOx4sfq5wJNNhAOCRoqVKm0MN4kW3Dj1wJpt52AGtWaMgJmx
         3u1cMeiW09+/EuA74OfoJyZhqARdpvOJEkymP0yjJEXrvQeXveHbK4TnwmYg80QMhL4+
         jVpvExoRK60QgAX9EROFn/CUkZSjRKlC9fKOvIyTVv5S5n4qRUZfM1dPRCjToqp8Ug6x
         /yuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoCcvjUHbOX42aTq+WSekBmmajrVtq8YSxV313qnMgHCtPfyQYHBgsQs6lYx40oifYiDZqBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaOh9i24FD6hOjhxqWWi7e+CFTojcYx7hFankNGFWPMhkFbsId
	RjunJE1QpJpSKUuVpuxzwGZ2fCjXRkU9O/v4p12CyJC/ndTypfN5D21r
X-Gm-Gg: AZuq6aKiC2oTNHt3eb6eMyl6uvkepWtWgRTzU7j9CSfmJGG2TACIDLWqnZJavITgfMO
	zAXSdSYL7k3OE+r7NFbUSxVBqi8WBrhmj7GH4iahodLLX3kAzrwpHEZSqIjd3rRypqkH4FHRa+d
	gy/ISo9yAi9B4oOnRF92qeOMj1PBi8mx+JpCSwjX7kXUasJvwZQ/cGUkQJsMVfKXaTX6shhplDd
	VjK7d7tN5XdSrNcBVuZF/iRJf4SgfXcLuuFpG8QR9UsidEWl3d10imMfRRVpHPyEC8ddy6ItDJ1
	9+fikPgJ/tYtpfVfxTUxALEE/DuVqCHcqBlz/PwUz4fM3l4AefVZZVbPej1/hltRnb8O1n/SdsJ
	ShKaxAAwnol7eyw5C7peKNy5Cdz7jHhrrqhGPEwjxoEWLP13JDBKJlMVposHIg4ji32ZS6JQnMW
	nddBd7Y/jl+ayx6pkZ4quEEQfu8vAh8UKC5+Fqicc=
X-Received: by 2002:a05:6a21:3991:b0:334:a99a:1796 with SMTP id adf61e73a8af0-392dfff8f95mr5124238637.11.1769848419161;
        Sat, 31 Jan 2026 00:33:39 -0800 (PST)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f610266esm13479121a91.4.2026.01.31.00.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 00:33:38 -0800 (PST)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>
Subject: [PATCH v4 4/4] cifs: make retry logic in read/write path consistent with other paths
Date: Sat, 31 Jan 2026 14:03:06 +0530
Message-ID: <20260131083325.945635-4-sprasad@microsoft.com>
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
index 7d75ba675f774..fa22702a61a6e 100644
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
+					trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_retry_needed);
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
+				trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_retry_needed);
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


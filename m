Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961323;
	b=pM91d6JzXh+MrLRm/0yvU/Y2A8Iflj7yl/vVU/KzI2yaGvp5/cf4u9zqWo8AjglIFanG
	 ZPXzQBAiantKj5qXx97cIcGPbmh3wYnRm7DUqPe0tFtQBV448+AVPuoArhJJodukVPH01
	 EunviiWNdkP08RelTf919XCtDEeDVpbyuD1iOo97xSmin2q/Ae9PABNHlR+GaHzdGSDEC
	 msSVRV1qN0ecC4YyU74Ej7CBFFRj1WHRxH/syxvg65zS9L8UDU5sFQRAYCOKGeu5Qtj3n
	 S4+GJC1DMyGrvvoDOhB3xfxbBYerWDroKSssgCurcZZ61eIZPN+XkxSRK6qPxP+vdkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3pL4qI55xeS4q74Qd8OgYkkf11qD+6PkbWN1emyH6OE=;
	b=RUOfb/o+cpUff/9pfIGYAvHIzgA0Oyqmkyl8m2h2b5R5wdtd09HVn/frbm3HMIbq+AS+
	 N9I7gQJwuGbSVDuYj1XMhjEA3EI/F3nN3OG+4WvMgKNeHLeKT3+eFR/SM/YO8xXFEi79z
	 +otS0izp2eMbNNlLc8VIzvqHeNYgsQBOyohtxUQ78CyIpH7+WjLIUafrKoswvhIAAg+pd
	 uVlLJmtmj6ob+zsz4cFT5qePDvS8OVboisuaT2pE5xjlnTmJAMjLAkLdZcDOmA4ec2S5m
	 /RRfQaW4HuckvoxL7fOVxnIiHAlBnPyjRXjqPTrfu0V+mpLIxu5L/YX98N49WKAwWBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hifTicOh;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA31606A32A
	for <netfs@lists.linux.dev>; Wed, 18 Nov 2026 00:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA31606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hifTicOh
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-380b40312e2so1307052eec.1
        for <netfs@lists.linux.dev>; Tue, 17 Nov 2026 16:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794961322; x=1795566122; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3pL4qI55xeS4q74Qd8OgYkkf11qD+6PkbWN1emyH6OE=;
        b=hifTicOhCsRhm9H6VwYVNkL21Cqb644FcPZWHYHMdT5D2P2O8kswZ9vojjo2xo2MZk
         iNq2GsfUL2N0DrPeT18VWoE+2hZYV9+BAEfIfTRSy5NRYnYcBYutzOQbm1wWGBRVI9d2
         YWzQQPIQ2WkJNAAmYhoYTi9+UlLLokqJa7LvXb4fhtWuPCCxXCA/6F4ToAMkzgyydOB3
         KXIfSjwHEvGTsgCUGelJx3lk8ylYS75v+Ztfnur3gXpm9QcZbuGa5zeJwFQ3liaD1JrA
         fLtf7ITX79lWZKWcUR7HMs4W8rCNjVzWZWnktiOgwZvJjg/w8WGfdmUE8UfEa9Vz5vJK
         zFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794961322; x=1795566122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pL4qI55xeS4q74Qd8OgYkkf11qD+6PkbWN1emyH6OE=;
        b=q8TbKrfx5pCT8UC5Im+apzKNBb9rVlGjsxK8Jo7UgkwLis9uiRsUH4RaKUe5TS8shj
         GUMBCreXDNaYy5OtR4eg33OE750LjyF4nwr1Qr6/Cp9i3x/T4JJMx+ujM1S14aCe7YFv
         rwCJbxKgpTJs00kw8JWEIWsvUUrvJwx0Cz43TVe4FhpnOjdH5Vi564cz6BCWVhHb2KoQ
         ZscdS0igxaq3l28ilpE9doLwsVIhddvpOxWWnsEmUCdCi4Kx2emBf1tKmQy31jMEyE2u
         FJteIBe1sotTuup7xJsSWUvud+T/nbS24vuxjaWH6xvhfLalN2APcotxsGXR6pd9AfbE
         xEAA==
X-Forwarded-Encrypted: i=1; AL+hErH6QidTak3dB3KkR5u0ut1SR8buKpo2k2lVB3AecpvFwYU1qRy0AuhRVEyTBd9DAFk+WpW1Sg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jKJmvgUf1idFEuf34mmV3w8HYu/KAPkKZMcmEJLpzZxwFXC9S
	sxXM8k2zbPlz7sACROC5hsXoyTacIwSXWT2lkg6sB+WWtvOoELoFoSTD
X-Gm-Gg: AYBFou2s/uglb9rz/TkT/aVIoz6Z7/2hHr/nj/GleJxGhd5M7NN5dj5cWpxU0DjNl7l
	qMJrRtevAv6wtSODDMj2Flxm4Ib7XVVBK5C1Ib+e5WTllRgDeMhfktSe3dPwla7DeXXXC/t46gA
	FbO3NN51GLlPb9MM4qsnwLJrWBeHyAjPN5vTZGY9ZDw9BVJ1L4EGNAHlrisdbfJsioCQtM0E5Kc
	mxoFGd7lVkbw6yBeJQP7p3FdVNo+oYPstXlxz1zemZpC52iWCF6guxa1ylcMRSMnW/Ef0P8Mjxq
	oNvTy8oFHwvqT8kErqORvKV9lPC+8pYR/HG3NiZsVXaO0E1rlkLIdQC58Vgh4odKIWDoJ0+7tod
	8ybaZnmNnO1aMJde/AMDeZZwDH6l0roiAAqxcblYcSYtimg/Tt1/vvCLGDjjZii6MqhZauZiwEG
	en//9w4LlDCp+9aOAKJtimgYpgRyDzMV3cBNDNxl3w3sjourniKZ2724lGGESOR7QHtORmOsy7F
	hzotePYSiME/IozzihKqglWNi38wx1D4rrYwVT9cn+c/nPHFe3lSm+FHVyRmgFe/Wpt8QExNXIr
	z3lLnniy3HFfU2lTkbjzsv3cI3y09lcUCh/Ig2EATINao8Nz3PNpg4P2L/d3e3fglm8GLIOkZEy
	XxngS2Tsv+cIQsgGDhlP/3q2FaC+peH06ZgR6+5FketuOWlR0bA==
X-Received: by 2002:a05:701b:2806:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1b543beb5bemr978760c88.15.1794961322120;
        Tue, 17 Nov 2026 16:22:02 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:b1a7:bebf:2fc7:37b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5446f954dsm1665354c88.2.2026.11.17.16.22.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 16:22:01 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	linux-cifs@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	David Howells <dhowells@redhat.com>,
	netfs@lists.linux.dev,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smb: client: do not let the server grow a write subrequest
Date: Tue, 17 Nov 2026 16:21:59 -0800
Message-ID: <20261118002159.20576-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smb2_writev_callback() takes the byte count from the SMB2 WRITE
response, masks it with 0xFFFF if it is larger than the request (for
old OS/2 servers), and then copies it into wdata->subreq.len.  A server
can return a count that is still larger than the request after the
mask, for example 0x8002 for a 5-byte write or 0xFFFF for a 4 KiB
write, and the subrequest then covers data that was never sent.

netfs uses the subrequest length to decide how far the write collector
may advance.  With a grown subrequest the collector moves collected_to
past the data that was issued: netfs_writeback_unlock_folios() walks
folio_queue slots that were never filled, and
rolling_buffer_delete_spent() frees folio_queue segments that later
in-flight subrequests still use.  This is a use-after-free that a
malicious or broken server triggers from an ordinary write:

  BUG: KASAN: slab-use-after-free in netfs_limit_iter+0xed4/0x1040
  Read of size 1 at addr ff11000010561511 by task kworker/u8:4/63
  Workqueue: events_unbound netfs_write_collection_worker
   netfs_limit_iter+0xed4/0x1040
   netfs_retry_writes+0x1410/0x1e90
   netfs_write_collection+0x2647/0x3880
   netfs_write_collection_worker+0x1cd/0x3e0
  Allocated by task 141:
   netfs_folioq_alloc+0x39a/0x470
   rolling_buffer_init+0x29/0xc0
   netfs_create_write_req+0x12f/0x840
  Freed by task 42:
   rolling_buffer_delete_spent+0xb1/0x220
   netfs_write_collection+0x1f62/0x3880

Never change the subrequest length from the response.  If the count is
still larger than the request after the mask, fail the write with -EIO
and record it with a new write_overlarge trace point, like the read
path does with read_overlarge.  A short count still returns -ENOSPC as
before.

The folio_queue form of the use-after-free exists since
commit cd0277ed0c18 ("netfs: Use new folio_queue data type and
iterator instead of xarray iter").

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
 fs/smb/client/smb2pdu.c | 17 +++++++++++++----
 fs/smb/client/trace.h   |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index b26bfb4bd..2f05ba613 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5181,14 +5181,23 @@ smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		if (written > wdata->subreq.len)
 			written &= 0xFFFF;
 
+		/*
+		 * The server must not report more bytes than were sent.  netfs
+		 * uses the subrequest length to work out which folios this
+		 * write has finished with, so it must not be changed here.
+		 */
+		if (written > wdata->subreq.len) {
+			result = smb_EIO2(smb_eio_trace_write_overlarge,
+					  written, wdata->subreq.len);
+			break;
+		}
+
 		cifs_stats_bytes_written(tcon, written);
 
-		if (written < wdata->subreq.len) {
+		if (written < wdata->subreq.len)
 			result = -ENOSPC;
-		} else if (written > 0) {
-			wdata->subreq.len = written;
+		else if (written > 0)
 			__set_bit(NETFS_SREQ_MADE_PROGRESS, &wdata->subreq.flags);
-		}
 		break;
 	case MID_REQUEST_SUBMITTED:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_req_submitted);
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 5331ce6dc..18760a819 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -153,6 +153,7 @@
 	EM(smb_eio_trace_user_iter,			"user_iter") \
 	EM(smb_eio_trace_write_bad_buf_type,		"write_bad_buf_type") \
 	EM(smb_eio_trace_write_mid_state_unknown,	"write_mid_state_unknown") \
+	EM(smb_eio_trace_write_overlarge,		"write_overlarge") \
 	EM(smb_eio_trace_write_rsp_malformed,		"write_rsp_malformed") \
 	E_(smb_eio_trace_write_too_far,			"write_too_far")
 
-- 
2.39.5


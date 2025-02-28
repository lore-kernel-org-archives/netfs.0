Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDEF26B2B1
	for <netfs@lists.linux.dev>; Fri, 28 Feb 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746168; cv=none; b=Y/gSpzkNDXLKXIUzty8L+LbfjWCslUUP2HHZ5dMWKpeBJPaZtm1+l8c2LTWzV0rnhcJ42elzc2hH7eekw8NdCYOue2LQUFoSyE3i/4D3d7/mbsRqcxOgMgOCo34mwla6z0wtHoetf8C8AEabPtVvMkd7ijROZQuFQX0R38QoQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746168; c=relaxed/simple;
	bh=wqfpViftRXFo0yIzjPKdTRnmgFn+vPNeSi1IWa2AEO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZm4iO4UOSM9Q1t3YVjEgY0Q1EmXkmk2DxriaORbliQVXUS6y7z0LbIbvie/0m5iAXrXA9Op41joAdrpPXySYp1IDh/oI688HnYRK21U8JH2ypFOTpfN8k9oa53JQ4KXp7vMtvVvKxG8gkeo7UrN7mSH68ypGqgxqzf/7WHFpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JsO35ZsK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JsO35ZsK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb81285d33so395217966b.0
        for <netfs@lists.linux.dev>; Fri, 28 Feb 2025 04:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740746165; x=1741350965; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4BRVcVlmrp47N8mDLSs1UXLB3XHPD0CyzYo4hVKAt8=;
        b=JsO35ZsKE8t9f57u5sBM7VrWqGfy8IKRvPsJ8QRgsgeBIKj75uNYAkF7fgSG6GmCMq
         CZGyFpR/Qp9hpsoQsQT6n8hCbfxTIGhtnh5xg+dBIM4KKOlxitX3I1CfRS/HbspwrFZ1
         LNlLv8OBuCWlJCyg2gJJHOf9pDZ9WD4P/JycUwobR3tE5aJ2pjwzOmt//nMYwFq+T9lA
         Fyk+P0oeLo3wvl49ljKgqAvMW3AV7YZ3gHXxha3gcClCsMrflCOT/odEGg892xDKWFSH
         kgJ1fj2Gtbf4CQh3XGQF2KPL63IsA6XSmE79XGcHU0HLgVKZ5GXWp6QQbPTSU4i8kHZK
         Y9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746165; x=1741350965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4BRVcVlmrp47N8mDLSs1UXLB3XHPD0CyzYo4hVKAt8=;
        b=u+0J/gQT0I8yEGufsU7GvZSEGbl5sEISHZ8BHGpS6wBTVRdO5R4y0PrYTTxfn+1ml/
         k4r1gpuVhxHYDnVH2U4VJW2FMi80/97CG2FJ9/TdpkgjEapHGLDqJhWj0NUslw2b1PYh
         zBf8miAAuuCec1FcT0wWk/kerjgciqa45nNJGjjLAN+Rz3xax96p/m2c9ScdvM+Zt11x
         5Gq9e9wQshxHaC1+djBM2T7wGKtvOp1+p0uHNXB2NuqpTmI8TMjr7fVp5X2KGi+oD3C0
         GwFZG/wj5dZXSyZuVTBsGyg2TMpiNRu2mnPbhROReQHZ8URbtCcjJQ4Ks2R+TQ83qJzg
         MJmg==
X-Forwarded-Encrypted: i=1; AJvYcCVAwXwztI6vJtc2GpWKGHEgjj1cbJ5LEYuIbH8pCifT2a7jX3GnIwlvP/S/wc0XOK+qPdvgxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YweM5daSfnpgtzZkWDz8xWf/As6E729IMXkfPvsByJqL/YhPbuq
	/XwTCXcDlWHy7ipYSbPS6TODOGVal9aPSbnjMpAljxZh97j3SN/nmUn8O7N02Ko=
X-Gm-Gg: ASbGncum7QFJPqkaB6+iIU6mBjLqoRoAj4s/zHeZEv+coCh1eg7WWa4CogSIvo1hkRn
	sMoxKkyu9nmpC9sDU5612lI6+dPxVetqcDUodlO5MVfsNm3A4EmEu9NkhCN8GXwldVUhv1fU69m
	7FkIkwAT66qDcPaXiyyxYPG4OUQXJU5f4V9sSjB8fnEe7/Aw+wkBzFbhot0VsXiymicGoQ3X7O5
	aOH2k6IZen4gL3USgbpJ71kAIuM/0c0Bl3HX3qoaPn/pPHN4r7H/xHNDGgm7seOUaoLSpzsi2hk
	PPiR6XTFS3dd+Cz0Hkf4VPZQ/jtvfpALvar/jTG8oUvCpNGBdFD4576RU/hoNGlIdkvci/o4tGx
	xnqcx0S0M7OKYxS5btusTOv5mgA==
X-Google-Smtp-Source: AGHT+IE2GiFAgvvybx/Z0OJcY5FetkfNI3YyL4jA3FpXCLa3pK64kiuKgDkLUvKt5glk5Ln5cfEWcA==
X-Received: by 2002:a17:906:c104:b0:abe:f686:8189 with SMTP id a640c23a62f3a-abf25f900c9mr345104666b.11.1740746164792;
        Fri, 28 Feb 2025 04:36:04 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f191800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:1800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfdcsm2457279a12.29.2025.02.28.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:36:04 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/netfs/write_collect: call `invalidate_cache` only if implemented
Date: Fri, 28 Feb 2025 13:36:02 +0100
Message-ID: <20250228123602.2140459-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many filesystems such as NFS and Ceph do not implement the
`invalidate_cache` method.  On those filesystems, if writing to the
cache (`NETFS_WRITE_TO_CACHE`) fails for some reason, the kernel
crashes like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0010 [#1] SMP PTI
 CPU: 9 UID: 0 PID: 3380 Comm: kworker/u193:11 Not tainted 6.13.3-cm4all1-hp #437
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
 Workqueue: events_unbound netfs_write_collection_worker
 RIP: 0010:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0018:ffff9b86e2ca7dc0 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 7fffffffffffffff
 RDX: 0000000000000001 RSI: ffff89259d576a18 RDI: ffff89259d576900
 RBP: ffff89259d5769b0 R08: ffff9b86e2ca7d28 R09: 0000000000000002
 R10: ffff89258ceaca80 R11: 0000000000000001 R12: 0000000000000020
 R13: ffff893d158b9338 R14: ffff89259d576900 R15: ffff89259d5769b0
 FS:  0000000000000000(0000) GS:ffff893c9fa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffffd6 CR3: 000000054442e003 CR4: 00000000001706f0
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x15c/0x460
  ? try_to_wake_up+0x2d2/0x530
  ? exc_page_fault+0x5e/0x100
  ? asm_exc_page_fault+0x22/0x30
  netfs_write_collection_worker+0xe9f/0x12b0
  ? xs_poll_check_readable+0x3f/0x80
  ? xs_stream_data_receive_workfn+0x8d/0x110
  process_one_work+0x134/0x2d0
  worker_thread+0x299/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 CR2: 0000000000000000

This patch adds the missing `NULL` check.

Fixes: 0e0f2dfe880f ("netfs: Dispatch write requests to process a writeback slice")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/write_collect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 294f67795f79..3fca59e6475d 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -400,7 +400,8 @@ void netfs_write_collection_worker(struct work_struct *work)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
-	    wreq->io_streams[1].failed) {
+	    wreq->io_streams[1].failed &&
+	    ictx->ops->invalidate_cache) {
 		/* Cache write failure doesn't prevent writeback completion
 		 * unless we're in disconnected mode.
 		 */
-- 
2.47.2


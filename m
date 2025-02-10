Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F22512ED
	for <netfs@lists.linux.dev>; Mon, 10 Feb 2025 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226712; cv=none; b=FZ8qLqg8mfhfM0mxynUdfjgLkAfbrejN55bMr3njaVC8NpQIjc41PN0vwFe+c3Eb2mV2bp9MbBmK9Qq1glwXLfJkAhoMFzZ03rQQf5hzBf7slY2a8wqmK+Ia7ClT7gaf+ox34q1R+JS+qH9tzxCjhNrjmwjwQkKSEKFN/V5qy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226712; c=relaxed/simple;
	bh=pTRZmgPDUm60FMsGqnRNJP4E0Tz9Yq6UC2rtO3tHUvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVxK0T/b7bhFqYsR/Gfpsb11bOM/uMFNoLDX7GiVpZ1UI9Fa+AUD2XgRUT3uEOfDl+W9CobECEbiOju6HfzGJlV4RslGJzxFZwO30cuVSAs4hQTnznr1NbtOe7C1pM0ORXcWS29Ttv8qTNmTJ3iJbwoWUz6lEVmEWc8+tEAe/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=T2UZtlwv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="T2UZtlwv"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso798638766b.1
        for <netfs@lists.linux.dev>; Mon, 10 Feb 2025 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739226708; x=1739831508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xU+5Hff3ByaZYFLomcfM/RhqG5OmVBr1nASPzJa0E9g=;
        b=T2UZtlwvqttsBQJ0ksgZA2aln0Iegjyf6qvLu3ofuNrRjetF7YN+OwLhUIK7/jb5vY
         ZHd+wmi9Z2hn4Fi+EPCAx42sxcKJIMaSWM97KTIlf8cFeHz6YNPcx3Fridq7yTjSFwD9
         6XmP9bRTNF4dqydctYPNkXES5xOTUwVHdOHM6gPIaZbKcKOi4BexKvenCXIKQlTRM6a5
         OPhGQAkPbFb1GyCQB1BpXgVBaE9dh6woXw7E67wxSO/NQwDaPJqAjGJxcHsa1trq2DtB
         cM+T/hz/axL9VERL62wuCi1MtHUd8sTZopL7mg8nF1sj+XednFoSExCirYrPgu0nfpLd
         ZFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739226708; x=1739831508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xU+5Hff3ByaZYFLomcfM/RhqG5OmVBr1nASPzJa0E9g=;
        b=WaqRUH91kJMkOblD791d9YDWdmiDooM4PPkHcqLFUo4m3EAJUk2+0nRRnCzuHZxonr
         bxQUT7eNd+NoawKJxYF0clZtZEMSXMlnsd2SSrUvbm/VpkuSclA+CHH15De9XHIAzNah
         pmJ+9ctNuxYyEZbekteSQGExiezV8ijGrR57fjaY7admBDHY8u71RwMIfGk3wFVuWkd9
         oHxolTjB+DSL6dO/dz2GKxScwlM89PrCV7tCbNQZ3KTzXL+Xeyfhv/gOpF9PZCWmgkpA
         Yiht/PBIfpD91j8Wdx1Ee9iah1/olloKSiBK2ANTRXLbC1sdw0tO5+OQa26VNCD18ng4
         ymfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr5YUoNu0hAN8Eohvn8RbzKLAhaEAGTNqf7QuWWY335MSDD3hiHD5B99Rs41xr5fgYHLpMtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/diOw1Um6qUl/0AlvW0be4+VsLPjsmzs6Xq3IK6qOHN6Ewvjs
	D0wM05torfO1smjqWLFx/EgVGsxEE4izLiirA8M8bcftKz+uvt5IQ1lmcmAuWwpFuAuxsvMBWYA
	b
X-Gm-Gg: ASbGnctD4DHFdb8fWZkObRO+MVuelEEVCD61TmhOrKs6R5etR7/luDn79Z4qrPpGWh1
	OnJj0bmLwPyieEgQssxtO/Xr1tKlGLx1e7X23p74zJT0t4GMLDK7yOu5pxQu0LQmGifooBV6Hwf
	54dRCl8YFJmsTO6bEq5AvvkxYZEn0hKGQSugxvi2iWC5h3kYnKO0F8f6Y/Qn3frw6gQUFowaBDv
	RVrRKDkJbR5nDpWzeYUFFSixUI3D2FjzkGYCYKECC8jlebMI4IokF4ZL4UuZTitNkrfGoZVxlJD
	oK5kzchBmUeMstvGvlsBRAV0duXKb+ReWdvQ7JoItc0pDBoIZgfPqrF8ixqiXz6ah6/7MRZ6a5o
	gT0YYSete3x4M5/A=
X-Google-Smtp-Source: AGHT+IHjtW2LQcoXICJ4bXGo/wQbq7YrAWuKqCJ6/w7CIf+NkajZc7njbeyBgfXRV7CZ7jt2R27Isw==
X-Received: by 2002:a17:906:4796:b0:ab7:59a0:dd16 with SMTP id a640c23a62f3a-ab789a6b646mr1696451266b.2.1739226707788;
        Mon, 10 Feb 2025 14:31:47 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f19d800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:d800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7afbcdbbesm454870666b.24.2025.02.10.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:31:47 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without `marks3`
Date: Mon, 10 Feb 2025 23:31:44 +0100
Message-ID: <20250210223144.3481766-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the beginning of the function, folio queues with marks3==0 are
skipped, but after that, the `marks3` field is ignored.  If one such
queue is found, `slot` is set to 64 (because `__ffs(0)==64`), leading
to a buffer overflow in the folioq_folio() call.  The resulting crash
may look like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP PTI
 CPU: 11 UID: 0 PID: 2909 Comm: kworker/u262:1 Not tainted 6.13.1-cm4all2-vm #415
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
 Workqueue: events_unbound netfs_read_termination_worker
 RIP: 0010:netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
 Code: 48 85 c0 48 89 44 24 08 0f 84 24 01 00 00 48 8b 80 40 01 00 00 48 8b 7c 24 08 f3 48 0f bc c0 89 44 24 18 89 c0 48 8b 74 c7 08 <48> 8b 06 48 c7 04 24 00 10 00 00 a8 40 74 10 0f b6 4e 40 b8 00 10
 RSP: 0018:ffffbbc440effe18 EFLAGS: 00010203
 RAX: 0000000000000040 RBX: ffff96f8fc034000 RCX: 0000000000000000
 RDX: 0000000000000040 RSI: 0000000000000000 RDI: ffff96f8fc036400
 RBP: 0000000000001000 R08: ffff96f9132bb400 R09: 0000000000001000
 R10: ffff96f8c1263c80 R11: 0000000000000003 R12: 0000000000001000
 R13: ffff96f8fb75ade8 R14: fffffaaf5ca90000 R15: ffff96f8fb75ad00
 FS:  0000000000000000(0000) GS:ffff9703cf0c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000010c9ca003 CR4: 00000000001706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x158/0x450
  ? search_extable+0x22/0x30
  ? netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
  ? search_module_extables+0xe/0x40
  ? exc_page_fault+0x62/0x120
  ? asm_exc_page_fault+0x22/0x30
  ? netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
  ? netfs_pgpriv2_write_to_the_cache+0xf6/0x3f0
  netfs_read_termination_worker+0x1f/0x60
  process_one_work+0x138/0x2d0
  worker_thread+0x2a5/0x3b0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note this patch doesn't apply to v6.14 as it was obsoleted by commit
e2d46f2ec332 ("netfs: Change the read result collector to only use one
work item").
---
 fs/netfs/read_pgpriv2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 54d5004fec18..e72f5e674834 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -181,16 +181,17 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
 			break;
 
 		folioq_unmark3(folioq, slot);
-		if (!folioq->marks3) {
+		while (!folioq->marks3) {
 			folioq = folioq->next;
 			if (!folioq)
-				break;
+				goto end_of_queue;
 		}
 
 		slot = __ffs(folioq->marks3);
 		folio = folioq_folio(folioq, slot);
 	}
 
+end_of_queue:
 	netfs_issue_write(wreq, &wreq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
-- 
2.47.2


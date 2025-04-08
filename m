Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88929218821
	for <netfs@lists.linux.dev>; Tue,  8 Apr 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744096668; cv=none; b=ZUltJwxcImgHAiN0aw3Tcc0Qud7QSaExrCw4ZLzgvPvxnRVRw/XS4RsphO/UWCiLLd/j1fUqeSfOd/JHFaeJr279p9qS0qaobZK2u3NNgY0rNjA3YmPeodW66pFNW6zyLs3WcpiVMUF/V3Egcc8SoUAVPPQDV0v7VAjpt92wWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744096668; c=relaxed/simple;
	bh=QJaTq8DPTo2AfOZqsOxCCBCgtYmWlA3+LXHRBHQTNto=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t2jXaQWbMY5LmPBkpPX2w+nDcD0Nc+U01V+uRkcj7FIOuvwEuV4xOhLjt3SJ8kQ3Gw9LlnjwQXqvKz+W5XeP+MlNiQn1HtNMF4Zuib/quNgniRRSJkZ+DoPE2Yf2GBgk1xGrL/+xlWdgLqg21qRVCZX2tud/kR2/QNNzQwBgIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYEJWrH/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYEJWrH/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso5479924a91.0
        for <netfs@lists.linux.dev>; Tue, 08 Apr 2025 00:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744096665; x=1744701465; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QJaTq8DPTo2AfOZqsOxCCBCgtYmWlA3+LXHRBHQTNto=;
        b=LYEJWrH/BTwaoO18z68+85KVmgTofzb8O8UuVNT7X/ZKRGabUxdf+4iXK5XXTH0UQf
         4e6tSv/aswD67n4zxiqk9RK0wEqd8qc60swI+1wXSmJu/Ucxrc6Vq/tZbafZ2Dysy+fZ
         fFMy6Rdt3mmbBpO1UG8ABS5VVFbEbIsHptqV4mpN9vTTygxoFilTq44wYz6nhJ8Z/Dbq
         n1FWB6DKlakNu7BrpCPzkTq7D7EMSlpaOZdGl0754Lk/Rr5VFmla5anK7eeH3nF85q9r
         7G0Goz496NwFe1iL99Waazy020AcOPhCVizQV3rpG7iPqA/zw+v+W74PHv8ItfT3r1Xv
         Bw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744096665; x=1744701465;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJaTq8DPTo2AfOZqsOxCCBCgtYmWlA3+LXHRBHQTNto=;
        b=LdX1CNhR2lai20iWvxZ3KX7cK3s1Vqdi0MYOnFWHrD0Hpirl7vue0JebIMBghRpaMh
         m+ukNIbFUMyoH7LAwOeotDBYI/6JXmCZhb4qJpUcqHRPn2NxwNWLxzE2MfIUrQYgUEgI
         H1Su9MJOPaYRHG2Pkhdh8esN2z4ZTpJJHXvyrEuHTfijCISNdwTlgztSBFuIyqLUeynJ
         hYHgcWoCLsDZsqHYtqu/meuyGP1xAV68IH2onSA89SVampGyGbj90unevXMuFm/FmQY5
         FTWZEex3PuiNCuoZfrhoPcLt+wWYrNtmfsFF8papGGxqKkSEIHrQ8PJsRVM4p96lQAE2
         cBpw==
X-Gm-Message-State: AOJu0YwNxyO+IycSXFMz7u0VXAbAHw+RKKtOd6sfHiI33woI3lBdZWsf
	MAg7P6QXXgYqeOG9nJ4uXgQL/gmIrSI1X1IxCpKbCJ1z78gRazgXWP9xdNGOAocYR8HjAz6zscT
	GLQjCIly30ot6AhrcpK3rPOSDzXhKzl4oz3Ykng==
X-Gm-Gg: ASbGncs4etlbVL4p49ElblNMRBgoXPvScMG+gM//ATSRTGfn2VQMyIxGT69SwKgCyBT
	XdzDu8OrqtFq7dH1FeliOv+jNZpCvtZ4rT2OOknzKuhAiWqpeanH5tIzgQ40gJsRkuWo1d17E9K
	dqC6beUM0PyAGCmeTxiaU0thHI3SY=
X-Google-Smtp-Source: AGHT+IG4pi9hnvnXX2pYFsiChM3L1nDMt7szbxKDYVS/AO4/E0riHOCSmubJcqI65ssIJWBYh1GhjLfT+4ZpIYWTRlk=
X-Received: by 2002:a17:90b:2643:b0:2fc:aaf:74d3 with SMTP id
 98e67ed59e1d1-306d0bde65dmr3383814a91.4.1744096665088; Tue, 08 Apr 2025
 00:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Abagail ren <renzezhongucas@gmail.com>
Date: Tue, 8 Apr 2025 15:17:33 +0800
X-Gm-Features: ATxdqUGnFE5PrDk8HS1Qt5pOF0Uel3GRFXEtvJEbnDFlumugRHw_Vhr_IiGWFrg
Message-ID: <CALkECRhMTA5dUcKzAFmyuMfxa_HsA7VRg1N6UxXSms8J9daa5w@mail.gmail.com>
Subject: [BUG] NULL pointer dereference in iov_iter_revert() via netfs_write_collection_worker
To: netfs@lists.linux.dev
Cc: syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

In case the previous message was rejected due to attachments, I am
resending this report in plain text format.

During fuzzing with the Linux kernel,
we encountered a kernel crash (KASAN null-ptr-deref)

in `iov_iter_revert()` triggered in the `netfs_write_collection_worker` context.

The bug was reproduced on `v6.12-rc6`.

## Crash Details:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000023: 0000 [#1] PREEMPT SMP KASAN NOPTI KASAN:
null-ptr-deref in range [0x0000000000000118-0x000000000000011f]

CPU: 1 PID: 3000 Comm: kworker/u10:3 Not tainted 6.12.0-rc6 #2
Workqueue: events_unbound netfs_write_collection_worker

RIP: 0010:folioq_folio_order include/linux/folio_queue.h:291 [inline]
RIP: 0010:folioq_folio_size include/linux/folio_queue.h:305 [inline]
RIP: 0010:iov_iter_folioq_revert lib/iov_iter.c:599 [inline] RIP:
0010:iov_iter_revert lib/iov_iter.c:644 [inline] RIP:
0010:iov_iter_revert+0x2ec/0x5a0 lib/iov_iter.c:611

Call Trace: netfs_retry_write_stream fs/netfs/write_collect.c:181 [inline]

netfs_retry_writes fs/netfs/write_collect.c:361 [inline]

netfs_collect_write_results fs/netfs/write_collect.c:529 [inline]
netfs_write_collection_worker+0x3c94/0x46f0
fs/netfs/write_collect.c:551 process_one_work+0x99c/0x1b80
kernel/workqueue.c:3229

worker_thread+0x677/0xe90 kernel/workqueue.c:3391

kthread+0x2c7/0x3b0 kernel/kthread.c:389

## Summary

The crash happens during a call to `iov_iter_revert()`

inside a `netfs_write_collection_worker` task.

The `iov_iter` appears to contain an invalid pointer,

leading to a general protection fault when dereferencing memory in
`folioq_folio_size()`.

Specifically, it crashes at:

movzbl (%rax,%rcx,1),%eax <-- trapping instruction

with:

RAX: 0000000000000023 RCX: dffffc0000000000 RDI: 000000000000011e

This implies an invalid `folio` object is being accessed.

A check on the validity of the folio (e.g., via `WARN_ON()` or `IS_ERR()`)

before use in `iov_iter_folioq_revert()` might prevent the crash.

## Environment

- Kernel: `6.12.0-rc6`
- Platform: QEMU
- Trigger: workload involving `netfs` writeback

I checked the dashboard, I think this is highly related to :

https://syzkaller.appspot.com/text?tag=CrashReport&x=1300b618580000

https://syzkaller.appspot.com/bug?id=78d77d1af0176dc57be694578c1ac93e92587191

I hope this can give you more information about the opening bug.

Let me know if you need additional repro information or traces.

Thanks,
Zezhong Ren

Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3B8460
	for <netfs@lists.linux.dev>; Tue, 15 Apr 2025 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688260; cv=none; b=uo9oaHKGbPpVxQYu+mLA0hYpPrf2hReVfjUPoH8bM/XytjxpANFlG7IACqAgZnZfHnE6B4lCNXvte9ewJ4vBmPjElUCXh/uK/ff2WH6kAuoArCB44KNXVwq3m4KZa9ezsmrkLjGO4IQF6S5SgFqo/QLwdcPNtkOabb7Rr7S+XoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688260; c=relaxed/simple;
	bh=sQ8ESBAKb/Wh/8FhbWjE9WC7W++mp0x2AlAbM/2e5zM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MesDD/hoRud59a7MQ/8G/E/5xMBcYzgcbLoCcK/Eysc5Ea8gvE1/lOyL9yWMwYribfAS/TadtFLAuLwNLl5JqR67uPkFfNQYmtQvs6f9lonAZwls5R/4d3yq4snJgOGXKulrH5erOyUYr/GeYrUKAmHZ1OBtb0GHiuNpH6KenO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W++rcK+q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W++rcK+q"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-aee79a0f192so3354590a12.3
        for <netfs@lists.linux.dev>; Mon, 14 Apr 2025 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744688258; x=1745293058; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+ouR+eHwzTFLNUveamcPYRFqOvK3X4QjhEq8EbSXa8=;
        b=W++rcK+q6JrZODLjALpYQjhliHkK04vlujRW63NrAkUtkCieGTfdKwapNMoD7GSPBI
         S005fiXdqP7QyfXceiDtjOO4TXbZL3kywDYg19SdfkhGNojgqBLDJE2xyNSIoD2UdgV7
         LJzWAuIeVgSNZ8uNconySm5zV7kVJq1/p5JLARxrACeT/BY62qEFEqUyWZIUPTHF32mk
         Xqhk/cGW9YndOmG8CPoxqFSTS+sRHVmeEOhlR0SMmzBxCEs/v4KR3amyOR2Rf7bnCDbu
         kKQdvli71iMMwuw+3PT9Iu6nPeH+zYj0qjCQSOeam8DTuMHe9z4IhIie4FFx7sbEhLij
         kUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744688258; x=1745293058;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+ouR+eHwzTFLNUveamcPYRFqOvK3X4QjhEq8EbSXa8=;
        b=hUuhS0+0iocDd/A0r1tm3I7qLKgLnLyp37IQOUAa/UmEjpEkFn/0xyw+SCTz/2J1lg
         Bw8lmokZhYEEVb9TW1D0PRcJID/bf+lmHRkUrLu3+3H8iinO5hrRoUWimin8/okwsA+8
         YcizNR6EnhEEKinN2h5ZVbciXhmHGq4/aDlwVQkq/VQpGz7qQmNh5jqZHZ/Rbv5UtTb+
         rpJpdWlMCYVtH3+tMk22izWSd6KdZr/Y86dRqkVH6Rg3Ax9VThzsL1dMJ9kC/hpP1Y4I
         wyVJWrs1AsyaKjC5XmUdG9Xa4fhhIR7v82LiPFjiHz3rtfbPmj44ajgaqS51ljJpFUWy
         9/4A==
X-Gm-Message-State: AOJu0Yw/wii6kl8n/7Ki0+7c+arou42P/17V+oj1Q0hCJbjz/l+z3tWn
	tGiAN1dMmttC9nlzZcJH3FNNaUR4isTZTHfir9GZ9PUGAYEdGHtceXEUviZSghVQkXB4fQ2D3bX
	8AJ9TuDq/mgNLoOaHPXFutGFBAsESsiCR/XXB3Q==
X-Gm-Gg: ASbGncvpSeBOLbikUpN0Jvk9qwjDrjkqPu435RwhQOIZb8FzTZMsQYjlUjzWQQ6JDDa
	ZuY/nbud3o/72h0S5NF5Q0AuOcbjC3TM0b7acPViHUI16Jj2AS169b5MR/dI+SumYchb+4/GMov
	uhWOKelXExnZWoFuXKqnZXUv1cNg5eGXwtzQ==
X-Google-Smtp-Source: AGHT+IFOEa/+mj4xs5uojPRzeI0cmf5Mt28LwjVjwJ7nt2DVZ9HAsMSIKh7pFDXrTiWLVH7O29QXaiwQ6FVA9yoaEtg=
X-Received: by 2002:a17:90b:5448:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-3082378e686mr19787159a91.19.1744688257653; Mon, 14 Apr 2025
 20:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Abagail ren <renzezhongucas@gmail.com>
Date: Tue, 15 Apr 2025 11:37:24 +0800
X-Gm-Features: ATxdqUHUOTnAFR1FcUg8Of7YLXfnPrHL2OTv5jiMn6gSPKrhx0TUKWGEtW65Euk
Message-ID: <CALkECRgpOBE=vRkJdeTEgQSy=HAtO-d5GaJSLH7Pb4MHZDs7eg@mail.gmail.com>
Subject: [BUG] NULL pointer dereference in iov_iter_revert() via netfs_write_collection_worker
To: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

In case the previous message was rejected due to attachments and HTML
link, I am resending this report in plain text format.

During fuzzing with the Linux kernel,
We encountered a kernel crash (KASAN null-ptr-deref)

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

I checked the syzkally dashboard. I think this is highly related to :
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6719 at lib/iov_iter.c:615
iov_iter_revert+0x52e/0x590 lib/iov_iter.c:615
Modules linked in:
CPU: 0 UID: 0 PID: 6719 Comm: syz-executor233 Not tainted
6.13.0-syzkaller-02526-gc4b9570cfb63 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 12/27/2024
RIP: 0010:iov_iter_revert+0x52e/0x590 lib/iov_iter.c:615
Code: 8b 5c 24 18 74 08 48 89 df e8 fe 4d 45 fd 4c 89 3b 48 83 c4 38
5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 f3 54 e1 fc 90 <0f> 0b
90 eb e2 e8 e8 54 e1 fc eb db 89 d9 80 e1 07 38 c1 0f 8c 3c
RSP: 0018:ffffc90004e7fbd8 EFLAGS: 00010293
RAX: ffffffff84be267d RBX: ffffc90004e7fd90 RCX: ffff88802de63c00
RDX: 0000000000000000 RSI: fffffffffffffc00 RDI: 000000007ffff000
RBP: fffffffffffffc00 R08: ffffffff84be218d R09: 1ffffffff2032e26
R10: dffffc0000000000 R11: fffffbfff2032e27 R12: 1ffff920009cffb5
R13: ffffc90004e7fd90 R14: dffffc0000000000 R15: ffffc90004e7fd40
FS:  00007f08bd3816c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000002a982000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_file_read_iter+0x3a8/0x550 mm/filemap.c:2808
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f08bd3d30f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 1d 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f08bd381218 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f08bd4566c8 RCX: 00007f08bd3d30f9
RDX: 0000000000001000 RSI: 0000000020000400 RDI: 0000000000000004
RBP: 00007f08bd4566c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f08bd4222b0
R13: 0031656c69662f2e R14: 00007f08bd42004d R15: 636f6c627473616c
 </TASK>

and

[syzbot] [ntfs3?] WARNING in iov_iter_revert (4)


This can give you more information about the opening bug.

Let me know if you need additional repro information.

Thanks,
Zezhong Ren

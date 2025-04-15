Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D32DFA5C
	for <netfs@lists.linux.dev>; Tue, 15 Apr 2025 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687528; cv=none; b=GZaACyOHjhQZ6POqdW5q326aaECK+9Be21EdS2hZ9nYyGO8aw4hB1dUPNJfFvA5HB1Y6QcOXYGZ9lNBGngsR3NE484SWKk9u5yDjH+pREqTCtf8sDdkV/QVWHZBZZP444QiEatSEhvHtMM7pb5UR+J6JgBF7Zi5MAS6IeUtk768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687528; c=relaxed/simple;
	bh=AelriznfL9/VcTufYIriBOfOD0UT2WLT7Bv6chbaUI4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MSdZc+fefuuJt9i4edTNJ49g4Fl5K26ejcWcdlXou6MLXqoaj35BxrwkdsjatO6dzQU1470DcDJ6tisw2lhsr9i53wz4HCHe6jQzkQIQG+iRpgpqlr4wk1zgzvsJoqyrpZu1OBHn84R/eLtDefJHF93Winm1G66M5WmUt/4ZKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id4o1tu5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id4o1tu5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso4194815a91.3
        for <netfs@lists.linux.dev>; Mon, 14 Apr 2025 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744687526; x=1745292326; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AelriznfL9/VcTufYIriBOfOD0UT2WLT7Bv6chbaUI4=;
        b=Id4o1tu5ddiG4pR8vaLfoPEzjiapH8ZY7/hqm5AOJqVXXxWSNbOOYS9FRlk98Txp3D
         7GR6Ej9+IVz0PyquJ2ABpX/tgh2+hXT4R3XWTm6KysDf69W4U3YJDUKWfo69tPHZpFuD
         WztRt/v0Rs9zfn1gwc6HFcrmTMql9Dx9W2bmcVvTwPdKdz1m3I6WTUsrtGONsY/9x2tr
         +G2AoVFPD+GCnX3IcuQqKdrgLnR1XD7JEi8vgZmPM76Y15yaqaZ4ufz/KitSACoOV6PQ
         R/+BOD2DYt06zuTd9pAEbczVW+1xpfjliCttnK6B+PydBE97HfPEoNMJ294ScKQbVILF
         cQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744687526; x=1745292326;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AelriznfL9/VcTufYIriBOfOD0UT2WLT7Bv6chbaUI4=;
        b=nR/ulMjakDq9VLkNNJlR746DkNp2ufbhbHrYKRNWpjrgJt++6ow6dTzJC2Pwjfwwni
         fqNi58LLtlBRRYn6RCbHMDemZA/x2jjRMGBJMo05HdQjlEWWBVpGtk0IBWuiU1eqFPON
         ZaQY38WQO+5o7QQLnf4kgfIfso0UdwLGt6Mapl9FOvHcNDyFj+mNhrMbh5jA90W42P1K
         /ykNesbMxHD91iVTIJlNJw6HLvdjle6XYL6JfcFA87IWIpAR045zu4Tenrai1hPsFwwL
         kw6sMOEmH8OoUxNvUN+jFXo7Ie3X/2YChI+WeGM01h+lli0QZLcAa5NHV8nV+/2GFFMn
         GIQg==
X-Gm-Message-State: AOJu0YyqxD5s9+Fg59Wv3ZcMgOrpYbZ+bLJx39lI742+VsnS8A0kb0oc
	tRa/rjJRiyWZp1MtXo1NP7/rRhmCu7QUFYZRUoL+VQJP0+8RI6hjHwz91R/kAjf/MuRB7QeuepJ
	wTQR54j2q3zetgoPDykN+S1RD30+3/1rHWybojQ==
X-Gm-Gg: ASbGncu7VfU3R/0Nu2kIGCHSYo/kJSC2I080V7fj+6lpcZQeJGxbL09aXO4Y7C2FPmH
	sZa+pvGtfydrwTKlmRAyKSUX7Z90Jb942+QFF+dGG6q1rlvpSdOwI5Hiy9+q4jILE7g/AF/tl2o
	YJ0MuIj+xC5fqpRqmOKaxuNkM=
X-Google-Smtp-Source: AGHT+IFo+BLfSNpC1vkxUzQ2yLYMWLzOsXqW263jSgJCd3OAIZVjmjTJU001TQASNkxwo9qwUN9m+7QFJ40TWUuM3wQ=
X-Received: by 2002:a17:90b:38d0:b0:301:1d9f:4ba2 with SMTP id
 98e67ed59e1d1-308236723b8mr19423978a91.28.1744687525862; Mon, 14 Apr 2025
 20:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Abagail ren <renzezhongucas@gmail.com>
Date: Tue, 15 Apr 2025 11:25:13 +0800
X-Gm-Features: ATxdqUELtm6wSrZR53h52xJZ82hNP4v9iVEe7r3fsdmI8RIk6vfzdn_TIQZrcpQ
Message-ID: <CALkECRiNhHNT2+Mnykfvs+v1W6wr5RByjr=axhntsFHPryXF0A@mail.gmail.com>
Subject: [BUG] NULL pointer dereference in iov_iter_revert() via netfs_write_collection_worker
To: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

In case the previous message was rejected due to attachments and html link, I am
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

I checked the syzkally dashboard. I think this is highly related to :

-syzkaller.appspot.com/text?tag=CrashReport&x=1300b618580000

-syzkaller.appspot.com/bug?id=78d77d1af0176dc57be694578c1ac93e92587191

I hope this can give you more information about the opening bug.

Let me know if you need additional repro information or traces.

Thanks,
Zezhong Ren

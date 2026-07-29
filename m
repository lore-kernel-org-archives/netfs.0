Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC643990D
	for <netfs@lists.linux.dev>; Wed, 29 Jul 2026 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363061; cv=none; b=iOIMUcqdyTsWuNto9Ag+PUWyqfmiNPNSZqwQmopnmvPq5gj82zkdecIJROBDE1ADDgsZkFdyhpXHbyIoAgeRqFyykwJ3OR7XyqLSqkV1ecM3aElpF3MwJiecxN9zW6SxfSvRLJfb/ofZxD1Hr+x4qXWDcG8aocMamQlc5ypt/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363061; c=relaxed/simple;
	bh=Fm/ZsjlZUEnQKQVa9Pkq2OJ7WqamyVNg0vZrQ+JWmY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNQLSBhqPfsmfT6Oyo6WzRyNPU8U1AT/DCEjrvSwE9djc49wPsVM1XEPS1pe7Jy0v5Jim5vl6gFExvMwWI8k9lzXoH5pxjMawX7Wh2qfrJUBH/6j1FEYL1qhUar5AAVAwJJNy7gX2u7gA225xtUdPQ7iD8fAuT91PFxffk7iamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=c+N9gt1w; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="c+N9gt1w"
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-81f905d74d3so283057b3.1
        for <netfs@lists.linux.dev>; Wed, 29 Jul 2026 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1785363056; x=1785967856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bzbqd6cHw14arRCmdANVMgvo7OgWV+NcW27pLqH0Jzo=;
        b=c+N9gt1wtB1ZxH0Pjx/f7ik1f4fk+EsYHDOE5FAJfFWy2wWVY4FiDkUqql0v7vgKS3
         Aj4SJmE8t02ra41XKZaMroeZnqZi93k3GXLmSFsXmdjDSkIPNo7WxPLvgBz6hLH+Gzeh
         ht8u9U2kvq5swnlaKgGfrCvF/jVpCJPiDeQPHgvSc4PAKlsdTE9p1QLgm0U6l7RkJitR
         RmeRmvwSXss73+OgnjBz6SZLyMeXxt0s+ncmFyEP9ziPoAJoN86/8agJjNVRGSwcysk5
         KCTbg+FM1QkSD7uv56zhLaVzxmQOTN7GK5MSBNTqEtwJYxX6RtDvupDqvZOoSxNV67h8
         SqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785363056; x=1785967856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bzbqd6cHw14arRCmdANVMgvo7OgWV+NcW27pLqH0Jzo=;
        b=cJDoNpbRWl4/0Cv4ZtfU+8SBu20FuuR7m2tdddx5IFcN6cd1Z7lapWpjU4PnamoJ9o
         bvmGOh+jQFdrTKlaTqV0tJpVLWpLP/AksHMN3SxB2HDd6qQQDaeiw+RoA0482+fQSRIC
         FX+Ja0/PU2oTpGnsTU0qG3EF3fb4w25tC+LwfIXtdzaa4KS/TfRaHjT9BWk/RtTQKK3g
         qIne71IyailBeLM0g4fT4ZsKJ0OPPmJTq2/ItPk+6UDz7s6OXMDXCAtJ/X8EFPvlao3d
         oHhhVlB6fX8pZOT3vHvixGKwXayRcsQfwv5pkggEkH25To4k6/pctP2cS7cBz1t0bu13
         Agig==
X-Forwarded-Encrypted: i=1; AHgh+RrB8pcI098ce1Cfwu4NtVvRdpTKrQccGcyQuPn0aHUPaJLQWzkY3PEbVTo1lsolv0vp2wpRmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5pU8yMz1BnIwf3LSZRzqcK1JLAjTsRAzgVLeR5w2aBZ2k74ZF
	Can0XB+sOUBrglWSHuMpuhOmZxQ8QKVKLacn7zwyNpDKiLCtnQnWgQrgWJzoaWdXRfTp
X-Gm-Gg: AR+sD13dxmL9latg2mVrPKGlhLaHgEshaRp59Y+cE3UojI9QAx249LqHO//apSDThjG
	533OYQnuLIK8lwTv8HWqonSntYYwz7lQamg5RBGM4Tfsb3ZBvNaKOy2RAO8SgTOznCPUgXPuX8i
	ER+vXiSCzXDK/e0RtKz0awlRJFfCkUxGt9XJUifxKjjbekfhDv4INbLV80oyQSlCTBj3HnkzLIC
	teHaTquakMtR0wLjyauNWT7LnexvNXY0FPKksj11CtmmEhZhPBJUUweiwFAxqsxpCRrV8o3hT/L
	uMSoKkXAj6z8+d1W98aWAuV81YyfzPfmxdbMqrixIJET9JnEpK+AJOBe98To6weTEJW0MKWdL9V
	2qGVmcwtynMgjNdHnonyqJSnu8IP2noXDyVDCRDEV51TaEf4F6/e6KjzMjFNocWcThNWbslMVOe
	IhIQQe01a/0CfGnnSvfuthY+hMmgYHGGTrttdDdIEXW1diWdPhbl2BRvER6aJQ/W8ByPOJKQ1wf
	dsS88ZTc8UOXkW+LA45VHSR2ZO5s9KL5lDWc+5cAguZuVSuM3sI/GqVwaDZxCuJxTIGZBpaDqY=
X-Received: by 2002:a05:690c:298:b0:81d:45a:977b with SMTP id 00721157ae682-81fb5dded86mr9179807b3.4.1785363056078;
        Wed, 29 Jul 2026 15:10:56 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb7ded638sm658137b3.27.2026.07.29.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:10:55 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	dhowells@redhat.com
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smb: client: set replay flag on the read send-error retry path
Date: Wed, 29 Jul 2026 18:10:35 -0400
Message-ID: <20260729221035.944949-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729192002.876156-1-clusk@northecho.dev>
References: <20260729192002.876156-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 29, 2026, Steve French <smfrench@gmail.com> wrote:
> Any thoughts on the AI review comments from Sashiko?

Yes. Both comments are about pre-existing code rather than the line
this patch adds, and Sashiko says so itself in both cases. One of
them is a real bug, and I have sent a fix for it as a separate patch.
The other is a real property of the code, but it is symmetric with
the write path and this patch does not create it.

Details below. The code reading is against cifs-2.6/for-next at
fa724e23. I have no SMB Direct hardware, so the one thing I could
measure I measured by forcing the failure; the numbers are under
point 1.

1. The request buffer leak in smb2_new_read_req()

This one is real, and it is narrower than the comment suggests, and
it turns out to be another instance of exactly the read/write
asymmetry this patch is about.

smb2_new_read_req() allocates via smb2_plain_req_init() and then has
two early returns before it assigns *buf:

	rc = smb2_plain_req_init(SMB2_READ, ..., (void **)&req, total_len);
	if (rc)
		return rc;
	if (server == NULL)
		return -ECONNABORTED;
	...
	rdata->mr = smbd_register_mr(...);
	if (!rdata->mr)
		return -EAGAIN;

Only the -EAGAIN one is reachable. smb2_plain_req_init() calls
smb2_reconnect() first, and that already returns -EIO when !server,
before anything is allocated, so the -ECONNABORTED return is dead
code for any caller with a tcon.

On the -EAGAIN path the caller cannot clean up, because *buf was
never assigned and smb2_async_readv() does "goto out", which skips
cifs_small_buf_release(buf). So one small buf is leaked per attempt.

The write path already gets this right: smb2_async_writev() does the
MR registration itself and on failure does

	rc = -EAGAIN;
	goto async_writev_out;

which lands on cifs_small_buf_release(req). The read path leaks only
because the allocation is hidden inside the helper.

It is also not necessarily a one-shot leak. -EAGAIN is a replayable
error, so the failure reaches the retry block at the bottom of
smb2_async_readv(), which marks the subrequest
NETFS_SREQ_NEED_RETRY, and smb2_should_replay() starts with

	if (tcon->retry || (*pretries)++ < ...->retrans)

so on a hard mount the attempt count is not bounded by retrans. Every
attempt that reaches the failed registration leaks another buffer.

I want to be careful about how far I push that, because the testing
below only partly bears it out. Under forced failure the write side
was reissued and completed, but the read in my configuration was
unbuffered and netfs returned EAGAIN to userspace rather than
reissuing, so I got my per-attempt figure from five separate reads
rather than five retries of one. The per-attempt leak is measured;
how many attempts a real failure produces is not.

Scope: CONFIG_CIFS_SMB_DIRECT, and smb3_use_rdma_offload() true for
the I/O. The synchronous SMB2_read() caller passes rdata == NULL, and
the RDMA block is guarded on rdata, so it is the async read path
only.

None of this is new in my patch. The __set_bit(NETFS_SREQ_NEED_RETRY)
that closes the loop has been there since 2c1238a7477a. If anything
this patch slows the leak down, because the reissue now honours the
back-off that smb2_should_replay() had already computed.

The fix is on the list already, sent just before this mail:

  https://lore.kernel.org/linux-cifs/20260729220017.944651-1-clusk@northecho.dev/

It gives the function a common error label so both returns release
the buffer, rather than fixing only the one that can be reached
today:

	if (!server) {
		rc = -ECONNABORTED;
		goto free_req;
	}
	[...]
		if (!rdata->mr) {
			rc = -EAGAIN;
			goto free_req;
		}
	[...]
	*buf = req;
	return rc;

free_req:
	cifs_small_buf_release(req);
	return rc;

Fixes: bd3dcc6a22a9 ("CIFS: SMBD: Upper layer performs SMB read via
RDMA write through memory registration").

I could not test it on real hardware, so I forced the registration
failure with a throwaway debug patch, on both the read and the write
side, over an ordinary SMB2 TCP mount, and measured
small_buf_alloc_count from /proc/fs/cifs/Stats. Same kernel, same
test, without and with the fix:

                                        unpatched   patched
  clean read, no injection                    +0        +0
  5 reads, one forced read MR failure each    +5         0
  5 writes, one forced write MR failure each  +0        +0
  buffers still allocated after umount         5         0
  kmemleak objects under smb2_new_read_req     1         0

The write column is the control: the same forced failure on the path
that already has the release does not leak. kmemleak on the unpatched
run points at the 448 byte object with contents starting \xfeSMB and
a backtrace through cifs_small_buf_get, __smb2_plain_req_init,
smb2_new_read_req, smb2_async_readv, cifs_issue_read.

Full numbers, the injector diff, and the two caveats I want on the
record are in the patch's below-fold.

2. rdata->replay is never cleared

The mechanism is right. netfs reuses the same subrequest object for
retries and short-read continuations (netfs_reissue_read() and
netfs_retry_read_subrequests() adjust start/len and reissue the same
netfs_io_subrequest), so the enclosing cifs_io_subrequest, and with
it ->replay and ->cur_sleep, survives. Nothing in fs/smb/client ever
clears either field. So after one genuine replayable error on a
subrequest, a later continuation for the remaining bytes will sleep
up to CIFS_MAX_SLEEP and set SMB2_FLAGS_REPLAY_OPERATION on a request
that is not a replay.

But this is symmetric, and it predates this patch on both sides.
wdata->replay is set in smb2_writev_callback() and in
smb2_async_writev()'s out: block, and is likewise never cleared, so
short-write continuations behave the same way today. On the read
side, smb2_readv_callback() already sets rdata->replay. What this
patch changes is that the read send-error path now behaves like the
read response path and like both write paths. It widens an existing
condition rather than introducing one.

Worth noting that the async read and write paths are the only replay
users in the file that carry the flag in a structure. Every other
caller uses the replay_again: loop and recomputes .replay = !!(retries)
from a local counter on each attempt, so the flag cannot outlive the
attempt that set it.

If you and Shyam agree that the stickiness is wrong, the fix is to
clear ->replay and ->cur_sleep on both paths when a reissue is not a
retry after a replayable error. That is a behaviour change to the
read and write paths both, so it belongs in its own patch, and I did
not want to assume: a subrequest that has already failed once staying
in back-off mode is a defensible design, and I would rather hear
whether it was the intent.

So: the leak fix is out as a standalone patch, and I will write the
replay-clearing one only if you want it. If you would rather have all
of this as one series together with the patch this is a reply to, say
so and I will respin.

Analysis and test harness assisted by Claude (claude-opus-5). The
numbers under point 1 are measured; everything else above is from
reading the code at fa724e23.

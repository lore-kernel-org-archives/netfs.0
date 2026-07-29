Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F03AF677
	for <netfs@lists.linux.dev>; Wed, 29 Jul 2026 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352833; cv=none; b=Lw7Kj6SCdH2kM4OGzIBgfFA70FFUepbJEnHObfcpFC1GgC0U9MImq+F5OR41rp1qqDXQcPN+uSuoDPUF5VUautRvIjCOxDc4gfB/eNt+f5a1p2IkN08cW7tIlJokTHaTYmvIxbmVBbjQnKV5sFuao3oqR1x9EL9G0U9sjchspHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352833; c=relaxed/simple;
	bh=/D42fnyjXlWPLe4z6N51wGEr7INuEDKR9LleuOCi1H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fkz9k780uLBFL8+iGplZzpWc/8DKqthOQ5nxta5cOmqpv6SwsJHXgc7KlX26teEASTsUTL8l9xUppWGLXbnov1/gWj/M3dTFuP8ixy2DCW/HioNmI3Mme96vY1+yLN/q4WfmOClUEEqRzWat/D6rq4Z/yzR21iUUVdit5ktmS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=lRVCUWoq; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="lRVCUWoq"
Received: by mail-yx2-f1.google.com with SMTP id 956f58d0204a3-668ce49dc73so24325d50.1
        for <netfs@lists.linux.dev>; Wed, 29 Jul 2026 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1785352819; x=1785957619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=acwLwgXNlL7fSykrj8gBRXc1ymnL+0zYtWGnv03vX0I=;
        b=lRVCUWoqVDi0IAqyTvU+6wFDzwG68cc+Pi72OtVaHoI+nyrYZjEwGwbyajLdAQr5qW
         6I2SOsxjTTyH/QY+UO5PuvjE/lQwBB+XkNSYttFkKaCupdTxRIexjAnqjvHfrCGAUK3P
         gsquH5EgbzJoKgz2OobBnKK6GBt8fdzqob8rAYXPQtP3w1+7nIiKDYF3LGFAhpDGwZum
         saXx7I/msOe+1V2jIT6weTYQ8zkmsQMfc1NeUuFXHjLfBSVgtSYNz/4j8rV1bufUEv2R
         MWScqCjByftkbVIZGn/7SNyN/TU35zn62NB4HH2qpU44wIh6aboTkcpv4ejmaQ37he/o
         nIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352819; x=1785957619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acwLwgXNlL7fSykrj8gBRXc1ymnL+0zYtWGnv03vX0I=;
        b=EbpF4TQQPbfEs9j62+JXZ9edHfushWQVc9tw34XguOLg7LkptIzaDpvGuiCNIOyK+q
         WfRicA8OLsrS1w5eif4sDm1nz++u5Tx67TMBRqDDm0NnlK6t+r8dy1kf/Z/GTUeCK4H8
         wdTpnLAle1ztkwkDY6YBT4V6W7xFqbB6g5a+Oh1DZ+WhQhVLBFHMbevBEi+N8uFRC6Jc
         KNqxY97wVTYFA5jG+8aWtFLX+CRMc5RMVITL7BOfMAjf215xDPWzK8ykeZc80xSzNC2k
         at7+7ryUemU2SsFX93N+CAQ7ubR37gBPXaTEVyFvnv5I9NNFUrUOT79fU2J7xZN2QBEU
         1afQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGQRBPEf4FJGuXquerortgvVEKFfuSDrKIEtIydMYb3trMxrASeIh7U/UQgXp9SkEmTNIXiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcyEjbagXzL0QlqSM64RkTMMEDEAbZ2OTnhwv3lPcdnv4WTMFu
	3eex8yJoPX1GDhvooGh13qiGml+onk19Y9eN5OdpBFD7Uwn8e3mlESFbX46J6zE7Pua2
X-Gm-Gg: AR+sD13leEZGsqPDNEc4BJNAOU0WW71IQ0PIKe6Ns/9Uy+NW6sowHZEQaSAW8b+reIX
	3uzUNd96HVbYYkseU0nLf/UtKDMv9lKpJ19RMBl3M60jK3z8KK/RJlY/XzQaFD75Wwz5Mc8ypYv
	EaDGqgW4AZQPrBK3dOY6iR6PpiDjrfxemTcUySN9eEG0si2L46/Ro2YRqrATSNL1hBjfU2/TBuM
	BsCGUmaLhOe56JdazAVBPP1Fy5E15XqTjKy7qpUxP3tBmRrK88FKZtv2MNx5uD/PVx0/d/ASOvp
	E1+nGaKNvZx7Igygw0oddsw46CDrrdxhiiUe8VmmhGZ2hn8XQ9M38LTCNkoMAw2o407YGfQ/gEX
	NdpwORKNaDrguDxwzoovjpuMAiz/RdoFZDRtSoms4tI4wtjb+rVBGyd/y/7tg5+eyKzftwdmtj3
	yDV+bd2UHRRW/yEJf5jzpeh8nny9CodC/D1vEQHfjDWspnc+wtrp1FxyuH3KhBbrKxEXvXdmj6/
	gfXJX247TuEgQh6fAeOhzQfQQI/mxxqfiXN6YPpuuETds1k3KYi
X-Received: by 2002:a05:690c:e3c8:b0:81d:bb95:9f84 with SMTP id 00721157ae682-81fb5ee74f7mr1759787b3.3.1785352818965;
        Wed, 29 Jul 2026 12:20:18 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa278d1ebsm24117127b3.12.2026.07.29.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:20:18 -0700 (PDT)
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
Subject: [PATCH] smb: client: set replay flag on the read send-error retry path
Date: Wed, 29 Jul 2026 15:20:02 -0400
Message-ID: <20260729192002.876156-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smb2_async_readv() and smb2_async_writev() end with the same
send-error block: if the error is replayable and smb2_should_replay()
agrees, tell netfs to retry the subrequest. The write path also sets
wdata->replay. The read path does not set rdata->replay.

smb2_should_replay() is not a pure predicate. It consumes the retry
budget and computes the exponential back-off, doubling cur_sleep up to
CIFS_MAX_SLEEP. That back-off is only applied where the replay flag is
tested at the top of the reissued request:

	if (rdata->replay) {
		/* Back-off before retry */
		if (rdata->cur_sleep)
			msleep(rdata->cur_sleep);
		smb2_set_replay(server, &rqst);
	}

So on the read path the back-off is recomputed on every send-error
retry and then discarded, and SMB2_FLAGS_REPLAY_OPERATION is not set
on the reissued request.

netfs does not pace the retry either. netfs_reissue_read() calls
->issue_read() directly, and fs/netfs/read_retry.c contains no delay
of its own, so read send-error retries reissue immediately while the
equivalent write retries back off.

The read response callback already sets rdata->replay under the same
conditions, so the read path does use the replay mechanism. Only this
send-error path omits it.

Where the back-off belongs was settled while the commit below was
under review. David Howells asked whether netfslib should be doing the
back-off [1], and objected to sleeping inside the response callback
because that runs in the cifsd thread and would stall the socket [2].
The sleep was therefore taken out of smb2_should_replay() and moved to
just before the replay in smb2_async_readv() and smb2_async_writev()
[3]. Setting the flag here preserves that arrangement: the sleep still
happens at the top of the reissued request, not in a callback.

Set rdata->replay here, matching smb2_async_writev().

Fixes: 2c1238a7477a ("cifs: make retry logic in read/write path consistent with other paths")
Link: https://lore.kernel.org/all/1652858.1769038134@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/all/1653031.1769038583@warthog.procyon.org.uk/ [2]
Link: https://lore.kernel.org/all/CANT5p=pXP3+CywpmK-on2uTvxO3S=31_B85_UDR7RoK1dQVtMA@mail.gmail.com/ [3]
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-5
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---

Tooling and testing, per Documentation/process/generated-content.rst:

- The site was surfaced by a static audit sweeping recent merge windows
  for state and contract defects, then resolved by reading the two
  paths and smb2_should_replay() directly. The audit had left it
  undecided because it framed the question as whether a synchronous
  send failure leaves transmission ambiguous. That question governs
  only the smb2_set_replay() half; the discarded back-off does not
  depend on it.
- The patch and changelog were drafted with LLM assistance, see the
  Assisted-by trailers, and reviewed line by line by me. I am
  responsible for all of it.
- The behavioural description above is derived from reading the code,
  not from measurement. I have not observed the retry timing against a
  live server.
- Deliberately not marked for stable. The change looks correct to me on
  a reading of the two paths, but I have no user report and no measured
  impact, and that seemed too thin a basis to ask for a backport. If
  you think it warrants one, please add the tag.
- Testing: compile-tested only. x86_64, CONFIG_CIFS=m, gcc 15.2.1,
  W=1, clean. Base is cifs-2.6 for-next fa724e235cfd ("cifs: add
  fscache_resize_cookie() to cifs_setsize()"). I have no SMB server
  test rig here, so the retry pacing change is not verified at runtime
  and a test from someone with one would be welcome.

One question I could not settle, raised separately because I did not
want to put it in the changelog without evidence:

smb2_should_replay() short-circuits as

	if (tcon->retry || (*pretries)++ < tcon->ses->server->retrans)

so on a hard mount the retry counter is never incremented and the
function always returns true. netfs does not bound the loop either;
subreq->retry_count is incremented in fs/netfs/read_retry.c but never
compared against anything. That suggests a persistent replayable send
error on a hard mount could retry without a bound, which this patch
would at least pace rather than fix. I may well be missing a
terminating condition elsewhere, for example adjust_credits() blocking
in cifs_issue_read() or the reconnect path breaking the loop, so I have
not made any claim about it above. For what it is worth, the ->retries
counter was described on-list as tracking client retransmissions "when
soft mounts are used", which is at least consistent with the hard-mount
path being unbounded by design:
https://lore.kernel.org/all/CANT5p=oL+tP5_SFNRabROCqDMjriXj5osnyyAjrMeq6BiJcr1Q@mail.gmail.com/

I read the full review history of 2c1238a7477a (v1 through v4) before
sending. The read/write asymmetry in the send-error blocks was not
raised by any reviewer or bot at the time, so as far as I can tell this
is an oversight rather than a deliberate choice.
 fs/smb/client/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4ce165e40657..06ab6eeb4f13 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4885,6 +4885,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	    smb2_should_replay(tcon,
 			       &rdata->retries,
 			       &rdata->cur_sleep)) {
+		rdata->replay = true;
 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_retry_needed);
 		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
 	}
-- 
2.54.0


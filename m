Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069283;
	b=mUJtxBHD42OA9GN6emHlyNVHKWp9902O8xqL4xj5JoyToZ7J6u+jIBqNb7sIDKv78e3i
	 R6yRMHswTyVX9lMx8nksBI3CPRA/zYhTmiXTOJlX4zS0+P9BqW6aj+rQhdqyRhDH0tuL3
	 qswzPv3lgleMbjd/o2LB55RHKf5yIw2D3kRONbJxuKfSrS8Vhxg4IbdTlucggySLeyb+s
	 O6rOvjj2OmbSUY9nLV3cYkuEMhco8flagFP3m2AZGmJ1ZaYv2QJsYdU2FcPbze8vVogLA
	 YOC27h1lenQP67PVINRs8fVV7m/svwHNiC6Fy5gItxWvDlXkEqj52C8LlWEtEO1bNHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
	b=A4FRTSXmWjKKASQjumJiB2Up2DnVYqFOPqXP6mRpmxaQZSkFul7IfLY/COCBnYv0PgQq
	 hal5XbpLPMDKJ1FUN508FMHm1c4p5BiPas/L27di57L7rlp8S9d+R98HN3uJLbJztuuCu
	 Kg7b5sJ6PQ7mSUt0N/50ZRyejQMjNOox+qWAai3TTKy2QOgv37rP7SmKnkf4WUPrJzn61
	 KkX1mWMT47wWDw6ALFRJZtYj2vt4zYGGni3Rq/f5sQlmlhJstrXesh7irji82SWSX1644
	 UGPASR12HKXhFylNcpel2+HptUHuIGoA7suE/hpYRH7a1mE8jV1B/xe8jh5l8YONveg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="V/37Q8TG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8EF606A325
	for <netfs@lists.linux.dev>; Thu, 19 Nov 2026 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C8EF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V/37Q8TG
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ea3f6a506so17780366d6.0
        for <netfs@lists.linux.dev>; Wed, 18 Nov 2026 22:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069281; cv=none;
        d=google.com; s=arc-20260327;
        b=afbwrgxi85s3OUm8Gdg7v4v/W3CFPAcoDRhQoA0U5ujY0xQv9Tkeay6y7LjZ7ULD/R
         caD6fHxyJz/CEKqNdpIi1CxrqSQ4Swpi0aKMLSOP4T60ePXlicMrOPp3Oe0K92a0/V8+
         QL/bFQ2TqYoNN2efqZR4RpvR//uRbrXDLe8gImM+/9wuQcAWL34dYhAye090L20MjFkg
         6PngKtsVNqF2IF74JtTVE+Vbfg1OfMnTA/DCCNd8tvgqdRQiNGBfqMRntymCt/qfQFtg
         9JQyGV8fcoPJA+a9ysyzMoqYassbaua7oFjxth2sXnkN3/PL8BnvtId0G03Oa3zqENOu
         fzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        fh=CEgSywi4gpN5CUyD0eXnJPyc9t/yl3Hp2AZadgjScIg=;
        b=Fy/jhmUnGV32YB0wsT/1YmT6j5G0kKd1IohGPYml0x8T1qGAlvPvtMFcfQgVSEeg3H
         ZsSZYA5AEnZxnqZWQENWXvy6sPyezqjbELkUws9Hy0sxQvtFH33vlLKPG04r30hb5PTC
         uG8YzXHkftiTOuc5rq1b/sjUPhV2/UE7a/lCM+/fCvJ4zbDxJZ5dPFYddXqdWjkcOUb3
         7yNA97riUFupcYuHg2z3rZwf4teh0zNRCcKluNFmyfT0IU3vwd5CRnhMdgmu0ydOLDLl
         0LZR6BuoRohJZvqTvd7O1R0mi99QNKLOdah+kp3JW0iVBEnEwPCZW1Jho1uHlPISqhPO
         towA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069281; x=1795674081; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=V/37Q8TGvSgZKOvZgj6ikogiPmUP+LPIJRlq9HMK3xJZrXdJoxgHvKPYD0EeZWLtOL
         zQJfeJgXewoG9H3alqbaSiYiOtUaI70Yp3hJaPhusmRhZ+pFTI9mZxP2Y+W4w3SliocT
         0qarLQn96QjZjR8bs1u7+BEBU4Lrf7DdPkjXgVJ51yzMZ43/vwAqHbJCYGc3bXz+IQxy
         bEjSK/nnnKCxcnc2jKnEKoymXbLQOe+1F2W3Eo/JkriAqAkdoGdSV5o+V5mFib9jhARo
         PMVUAQWMhQETvAv2jARWhRJohGqOWlSRXdPxEWX94wCoagi3+VZBjzls3oyGWnOyZ6ca
         CV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069281; x=1795674081;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=KBViMrDZBmf/XcqIIsVfZDJio5sgPM/Z8QpzHOX5VTm9wfG3WFCDBXIiwN00UWqg6s
         aQ9jX4W2pZLTyGTP5MfNpnC03M/BYqSef2z1v8WJY6GB9KLZs6cWTehIOcDjz7sMMVr4
         GeoBJUZfSuQmoXoccJcV3t2gNWZGDTypqWoAUnv2OQedtVtRiE6//f1sbqhgk10fTiBd
         4Gnh5Yaq7w0WNv+0AvOnhq3XVQrbPZYs3DfNdWYc0DYfnJE6OGIeSHJYDiArf7E4lUhZ
         XVcMjmHtVrHjBcEvGOXJJX/PVFDeu8bVYhdvZMsZlabhooMpJmpYAvHVxoXT1T/Y3LoS
         zN8w==
X-Forwarded-Encrypted: i=1; AL+hErHuB/Q5Dn1yICuUTBw0I8WV1Ri8w8fMXqfYN6YSj/Hht3Rq/cHOSSx1vfwxi5WU1RI/V8hcSw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8vHpaS4+OkVqJwl9vmpwFfaNXv3BBCaNWKt5lVH3ZRH5akHgTR
	Kpf/+Vx6GBmFGtuXCFnJ0xGiuAXW+xCCzp3KbPrjXeudNQgMKzdmmHR165mGoj5jIgAbhu6Mbjj
	J6pgSD5IdR3CDhvplvjFHzde2yhUFWaQ=
X-Gm-Gg: AZFdTZf7+7AHfjYYy2n781gLPvIMyXKchVAfKeEdAw4t/I6uMMc62SsxiRpcURPZi+w
	kUMCBxFXbJsQw8HbDtUJEv/mMPWbYaXHOvyDiJk3my1Z85qgZUgtMMuttFlSp29MTaVYBcvn9J1
	4JIZWzzhjSNTU3h3AX/IeNvuIr9Nql68aetHMIcTcBocnjQSCy5wZGJ85dbpGzIp5gXC5OK4w+E
	DNBohhWt4ZEPc67a/h6D4dweC39fA6l2GE0LX2glG63irwnTMogJRchk36XOPM72bdIpvAcbFPT
	VB3p645vc1bcmL0O7fbEO0UeDFSStlFcxrpOr1qIpA3TPyywepMJVuKQqPhFRMC8+b+yJP9H2V7
	AO/mS5a0hoDXv03cZTu2h6ebf6X7ttSIi/7OPRK/uw0z3qMrJv9glF3x1vQGLMrcLbOjihIlC+z
	nrSi2s/s6E0GshJNNOAZo=
X-Received: by 2002:a05:6214:8602:b0:921:117d:2e88 with SMTP id
 6a1803df08f44-92114f1258fmr78619116d6.28.1795069280925; Wed, 18 Nov 2026
 22:21:20 -0800 (PST)
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:21:09 -0500
X-Gm-Features: Aa3M54rKctNstj-xAw2aIWk4fNeHbccByvy8aMtrRliTYHyg6gQPWk7NFTjZLmk
Message-ID: <CAMcAce918POMDvZtF6QbhZMzmf+m49jKGdBEKV2pUi_Y3nn-Ug@mail.gmail.com>
Subject: [PATCH bpf 3/3] bpf: Add missing raw_tp_null_args[] entries for fs tracepoints
To: bpf@vger.kernel.org
Cc: dsterba@suse.com, dhowells@redhat.com, pc@manguebit.org, 
	idryomov@gmail.com, linux-btrfs@vger.kernel.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Four built-in filesystem tracepoints pass NULL pointer arguments without
corresponding PTR_MAYBE_NULL masks in raw_tp_null_args[]:

  1. btrfs_prelim_ref_insert (include/trace/events/btrfs.h:2878):
     fs/btrfs/backref.c:328 passes literal NULL for arg 2 (newref),
     and TP_fast_assign (:2856) checks newref ? newref->count : 0.
     Add { "btrfs_prelim_ref_insert", 0x100 }. (Also affects 6.12.y.)

  2. cachefiles_no_space (include/trace/events/cachefiles.h:718):
     fs/cachefiles/namei.c:122 passes literal NULL for arg 0 (obj),
     and TP_fast_assign (:729) checks obj ? obj->debug_id : 0.
     Add { "cachefiles_no_space", 0x1 }.

  3. netfs_failure (include/trace/events/netfs.h:413):
     raw_tp_null_args[] currently lists 0x10 (arg 1, sreq only), while
     fs/netfs/buffered_read.c:790 calls trace_netfs_failure(NULL, NULL,
     ret, netfs_fail_check_write_begin), passing literal NULL for arg 0
     (rreq) as well. Update mask to 0x11. (Also affects 6.12.y.)

  4. ceph_mdsc_suspend_request (include/trace/events/ceph.h:89):
     fs/ceph/mds_client.c:3691,3726,3749 invoke
     trace_ceph_mdsc_suspend_request(mdsc, session, req, ...) with
     session == NULL (arg 1), and TP_fast_assign (:107) checks
     session ? session->s_mds : -1. Add { "ceph_mdsc_suspend_request", 0x10 }.

Verified in QEMU on x86_64 7.4.0-rc3 (20eef29b7c84, all 4 tracepoints
flip LOADED -> REJECTED) and 6.12.118 (btrfs_prelim_ref_insert and
netfs_failure flip LOADED -> REJECTED; cachefiles_no_space and
ceph_mdsc_suspend_request are post-6.12 tracepoints).

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef10af2..30be05b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7274,6 +7274,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "afs_make_fs_call2", 0x10 },
  { "afs_protocol_error", 0x1 },
  { "afs_flock_ev", 0x10 },
+ /* btrfs */
+ { "btrfs_prelim_ref_insert", 0x100 },
  /* cachefiles */
  { "cachefiles_lookup", 0x1 | 0x200 },
  { "cachefiles_unlink", 0x1 },
@@ -7284,6 +7286,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "cachefiles_mark_inactive", 0x1 },
  { "cachefiles_vfs_error", 0x1 },
  { "cachefiles_io_error", 0x1 },
+ { "cachefiles_no_space", 0x1 },
  /* ext4, from ext4__mballoc event class */
  { "ext4_mballoc_discard", 0x10 },
  { "ext4_mballoc_free", 0x10 },
@@ -7314,7 +7317,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  /* .. from mm_page event class */
  { "mm_page_alloc_zone_locked", 0x1 },
  /* netfs */
- { "netfs_failure", 0x10 },
+ { "netfs_failure", 0x11 },
  /* power */
  { "device_pm_callback_start", 0x10 },
  /* qdisc */
@@ -7416,6 +7419,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "pnfs_mds_fallback_write_done", 0x10000 },
  { "pnfs_mds_fallback_read_pagelist", 0x10000 },
  { "pnfs_mds_fallback_write_pagelist", 0x10000 },
+ /* ceph */
+ { "ceph_mdsc_suspend_request", 0x10 },
  /* coda */
  { "coda_dec_pic_run", 0x10 },
  { "coda_dec_pic_done", 0x10 },

Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F38494
	for <netfs@lists.linux.dev>; Wed, 11 Sep 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040218; cv=none; b=T+kiVR95aZYy5sCGzp3ARfyB+33xrTC/vxGI/aKnHGtkFxSl1l32o0uPQDCbh4oVW2hs6v8Hcn3XivEuCNIQSlenzSaGtvLmmZ8TZrULKN1coyNi5uIl4/aXWVURwVuXrd2Hcv+wh7EEubkQStHYbjLwXCiP/wyK1lVW+290PW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040218; c=relaxed/simple;
	bh=idDVYcbF2twbHzBaaj7y0QzDzhdkiNeCygq826Qo+y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IPxqL9gI9ES8mVTrVmZ1EX3XuTirNHnyFNQW9mbTaUxCxEWYTeu39DGWsyL05twO1fjejZChPBiFjOrfkt1vIBwRgnIaQN/d09uUhhn2LmrtLXBlOsGWe1emX/dM6tPyrln+6QmefBajwbi1s2oPQ/Wz7abOMT2lkKPVs+fuiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIXb4DsB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIXb4DsB"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c5bab490so329473f8f.1
        for <netfs@lists.linux.dev>; Wed, 11 Sep 2024 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040215; x=1726645015; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2TQDeSRi71WntaE88G9wJ1KduLE7HmcmNISSwtm0Is=;
        b=tIXb4DsB4p1WtGJT8ku9Cd4Fs+ZT6M3nhUauCzz4dRfNMI6WF23fS5g+MeLL6s1gqM
         i31p99v/N+fpXQgAARPsY/jqFlj/e34661IPcU5v3YorF0Gn0VJ8kfDl3ghDNaYwz3MQ
         ozNuN1C5psTFynVqVPemTY2VPC1zt6pwuK07m+GbC//wXaSrxI1bn+2k2Y2kjA4pw0DO
         Oh9R6xWa3P6gOjjEIsMb0f4KilPurMwdRQARHcHdfBGyX9sLkHuaUpJl1wb4X1q3Pwie
         a5gdXuCaZhQzwAXlZSHho4TcYYzSJ7GQtldFRMTqy2iLYyfhiigcpwBoDXDdjznrsiq9
         +GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040215; x=1726645015;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2TQDeSRi71WntaE88G9wJ1KduLE7HmcmNISSwtm0Is=;
        b=MfH8vXlT48/JhhrjLL4khtCmI4suXNxYDyndGhFoiAQ1xL5pi/b0TdZCqgS434Q+8J
         lWroa2SvzD7QePAo4uNZE93EykcADLinkHsvC34l4Wa0oEQTY5KVsyQUmxoflRZYB773
         p4qBYrZ6o5eM9PSnn+S8QdFoJrOT/1kqEZRnaF3ewrWGeQPq3NCAEWngj38zN342nHSR
         oSqS/lAj28S62ZvL+Qwd/aPK/U7zuZJvLcG/wjAnKTXaxHEqPy09k115Z/fDnKreOdXD
         RyrIpn8Sk8eVSDM/c7CAS0Sxws4bWCKfSHA2ukB0ePvuVhI8J88x4pKyBJPvQDWBjF9Z
         kXkQ==
X-Gm-Message-State: AOJu0YyMEV/Xk271pN7vUi5JLqWFRki7h0j0Vl2RPcrikAJjMB7MkJuD
	Cl9lvzMT+nuseiy98YDeqjY3Gj8tkmfuw+N94ixHSuV6zQf/tk32rxFCgMoUi2A=
X-Google-Smtp-Source: AGHT+IHkY1KKjA1CdhxGd6l255cVox7AW8gpQsdvC0ibCo+Lzk1P/9uHCX0JvyLJle6oLMVgxMzB/Q==
X-Received: by 2002:adf:ed12:0:b0:374:be11:22d7 with SMTP id ffacd0b85a97d-378a8a1c2c2mr3468889f8f.13.1726040214530;
        Wed, 11 Sep 2024 00:36:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a279sm10853999f8f.9.2024.09.11.00.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:36:54 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:36:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Subject: [bug report] netfs: Speed up buffered reading
Message-ID: <b53fcb96-a595-43df-8bd1-6d3d3d873d4c@stanley.mountain>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Howells,

Commit 5c7822a3013d ("netfs: Speed up buffered reading") from Jul 2,
2024 (linux-next), leads to the following Smatch static checker
warning:

	fs/netfs/read_retry.c:152 netfs_retry_read_subrequests()
	error: we previously assumed 'rreq->netfs_ops->prepare_read' could be null (see line 51)

fs/netfs/read_retry.c
    33 static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
    34 {
    35         struct netfs_io_subrequest *subreq;
    36         struct netfs_io_stream *stream0 = &rreq->io_streams[0];
    37         LIST_HEAD(sublist);
    38         LIST_HEAD(queue);
    39 
    40         _enter("R=%x", rreq->debug_id);
    41 
    42         if (list_empty(&rreq->subrequests))
    43                 return;
    44 
    45         if (rreq->netfs_ops->retry_request)
    46                 rreq->netfs_ops->retry_request(rreq, NULL);
    47 
    48         /* If there's no renegotiation to do, just resend each retryable subreq
    49          * up to the first permanently failed one.
    50          */
    51         if (!rreq->netfs_ops->prepare_read &&
                                   ^^^^^^^^^^^^^^
Check for NULL

    52             !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
    53                 struct netfs_io_subrequest *subreq;
    54 
    55                 list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
    56                         if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
    57                                 break;
    58                         if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
    59                                 netfs_reset_iter(subreq);
    60                                 netfs_reissue_read(rreq, subreq);
    61                         }
    62                 }
    63                 return;
    64         }
    65 
    66         /* Okay, we need to renegotiate all the download requests and flip any
    67          * failed cache reads over to being download requests and negotiate
    68          * those also.  All fully successful subreqs have been removed from the
    69          * list and any spare data from those has been donated.
    70          *
    71          * What we do is decant the list and rebuild it one subreq at a time so
    72          * that we don't end up with donations jumping over a gap we're busy
    73          * populating with smaller subrequests.  In the event that the subreq
    74          * we just launched finishes before we insert the next subreq, it'll
    75          * fill in rreq->prev_donated instead.
    76 
    77          * Note: Alternatively, we could split the tail subrequest right before
    78          * we reissue it and fix up the donations under lock.
    79          */
    80         list_splice_init(&rreq->subrequests, &queue);
    81 
    82         do {
    83                 struct netfs_io_subrequest *from;
    84                 struct iov_iter source;
    85                 unsigned long long start, len;
    86                 size_t part, deferred_next_donated = 0;
    87                 bool boundary = false;
    88 
    89                 /* Go through the subreqs and find the next span of contiguous
    90                  * buffer that we then rejig (cifs, for example, needs the
    91                  * rsize renegotiating) and reissue.
    92                  */
    93                 from = list_first_entry(&queue, struct netfs_io_subrequest, rreq_link);
    94                 list_move_tail(&from->rreq_link, &sublist);
    95                 start = from->start + from->transferred;
    96                 len   = from->len   - from->transferred;
    97 
    98                 _debug("from R=%08x[%x] s=%llx ctl=%zx/%zx/%zx",
    99                        rreq->debug_id, from->debug_index,
    100                        from->start, from->consumed, from->transferred, from->len);
    101 
    102                 if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
    103                     !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
    104                         goto abandon;
    105 
    106                 deferred_next_donated = from->next_donated;
    107                 while ((subreq = list_first_entry_or_null(
    108                                 &queue, struct netfs_io_subrequest, rreq_link))) {
    109                         if (subreq->start != start + len ||
    110                             subreq->transferred > 0 ||
    111                             !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
    112                                 break;
    113                         list_move_tail(&subreq->rreq_link, &sublist);
    114                         len += subreq->len;
    115                         deferred_next_donated = subreq->next_donated;
    116                         if (test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags))
    117                                 break;
    118                 }
    119 
    120                 _debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
    121 
    122                 /* Determine the set of buffers we're going to use.  Each
    123                  * subreq gets a subset of a single overall contiguous buffer.
    124                  */
    125                 netfs_reset_iter(from);
    126                 source = from->io_iter;
    127                 source.count = len;
    128 
    129                 /* Work through the sublist. */
    130                 while ((subreq = list_first_entry_or_null(
    131                                 &sublist, struct netfs_io_subrequest, rreq_link))) {
    132                         list_del(&subreq->rreq_link);
    133 
    134                         subreq->source        = NETFS_DOWNLOAD_FROM_SERVER;
    135                         subreq->start        = start - subreq->transferred;
    136                         subreq->len        = len   + subreq->transferred;
    137                         stream0->sreq_max_len = subreq->len;
    138 
    139                         __clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
    140                         __set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
    141 
    142                         spin_lock_bh(&rreq->lock);
    143                         list_add_tail(&subreq->rreq_link, &rreq->subrequests);
    144                         subreq->prev_donated += rreq->prev_donated;
    145                         rreq->prev_donated = 0;
    146                         trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
    147                         spin_unlock_bh(&rreq->lock);
    148 
    149                         BUG_ON(!len);
    150 
    151                         /* Renegotiate max_len (rsize) */
--> 152                         if (rreq->netfs_ops->prepare_read(subreq) < 0) {
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference

    153                                 trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
    154                                 __set_bit(NETFS_SREQ_FAILED, &subreq->flags);
    155                         }
    156 
    157                         part = umin(len, stream0->sreq_max_len);
    158                         if (unlikely(rreq->io_streams[0].sreq_max_segs))

regards,
dan carpenter

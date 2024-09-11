Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D24127E18
	for <netfs@lists.linux.dev>; Wed, 11 Sep 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040170; cv=none; b=tt5uKHUfb7+gsNzqfLm13rCDT3f5EtXYXc4awNXp++nzyafBrNIusdy5qaEgPhKoxb3Hyuy/z1d4ohSxAODK21TsTCRdhefVSMtzBIMCGHlZdomH00+2Cybt2m7R/xKX4xDAk3xhmMKGoFrEx9yKWRmb6NeSXOFWYRzogMnZFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040170; c=relaxed/simple;
	bh=DY5UIDJybjBzU5hCuIqaNaCHCKnbr/lkmHx+5jUDBzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jNLawxTqo1lk/Z2sofHYM5pnEXYNWIN1JIuxIudc4NSPuAVWYJaSZyWFrQd3z7L62FUM31f1e0WVeDQcPpPqssSYkHJK4FJmBlHalAzxr5XP/NAkVzXqL7ZRLy+HSx774RdXv+Hdt6jNxCfgacvhWXAm1HdUBxdXa5QM/3w64l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyQ7YenF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyQ7YenF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so1294395e9.3
        for <netfs@lists.linux.dev>; Wed, 11 Sep 2024 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040167; x=1726644967; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnye/O5h64jZX0UqjFGMVVMpk2xIV68uIK21//Cjhl0=;
        b=OyQ7YenFmk/tDCgHs8+zcejtHd+4wCHkdzteHfd4ZrowRByp4ouY30mJgrhwhzI9Fs
         f5DYR34geTU4ODRsInOD2/UDvQVPV0b3bAQWHW6vCRnipZv9J0PXrv9uV3dTCLA66Ud3
         2R+nwTuYqpGj87EQ60iaq2rL0ypbMT+nlk+tV1nLhhnnYHv6bQJUrptgu4vRSDlZvmZ5
         JC7hHkUZyQoaIhaW1UC7voMgtBCk7keM21X4umlCI1ysyHhkCFaF0fcwqhwectdcfPa4
         2/FYTvLQzLpPS5P45miG5/6D2LUYXk3tXMwYFgJjeWdxcrb2/gsBbBQFSipRt2yatJWq
         EQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040167; x=1726644967;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnye/O5h64jZX0UqjFGMVVMpk2xIV68uIK21//Cjhl0=;
        b=jCbXZfwVxPGiSjBWjsFtVDGKeVG716GhpcnKi2nKsWU4SJYF1BVRsFm+tRTLBdGXn6
         2vNDoZAM1x5GTYbaYAfmfgLwyKaelGUDl2qyjovUl78Tc5NcE6rqq9jLHlgnYcSD0Jq/
         2BuKMn53ycpp9KWWdS3IXhewsdERumCw7GVA/jvLACnpqZqG6WzVn2ciu01oKSS/Q8XP
         z/KDjR3G8F/4vY9pyeFA1HcWxHUqmNoK/ySznusrQvkyBeQXTuY0CXJaKcYi90SdmGvr
         k1tF49KScuMro95EkgkUj0f83C5mqzMn6+Qu4Xvx1TEmKFOX8fWSjFlz6qjqLsDx1BSw
         VVMw==
X-Gm-Message-State: AOJu0YxzqP6sVqCIzubD0csQxHodpKJEiDtewHUM1shqLrv8pqgYRkQ1
	cuROvo+AOByT5D7rRzyDoyyMpOQi/BSOOf6tfk5vDXzmBNPxURm+NBQRFvumDiU=
X-Google-Smtp-Source: AGHT+IGaOQWTqDcI2f8ytkRuoPCGpr8jaSawJ3htZbk3hIYglrRo4lTsJUBoiTKMc10v1zTEeuSp/w==
X-Received: by 2002:a05:600c:5128:b0:42c:b62c:9f36 with SMTP id 5b1f17b1804b1-42cb62ca18fmr77044265e9.5.1726040167206;
        Wed, 11 Sep 2024 00:36:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddda1sm10690358f8f.95.2024.09.11.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:36:06 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:36:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Subject: [bug report] netfs: Speed up buffered reading
Message-ID: <6caf8f55-4eeb-4ada-8ecf-9c92ce83f40b@stanley.mountain>
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

	fs/netfs/read_collect.c:175 netfs_consume_read_data()
	error: we previously assumed 'folioq' could be null (see line 115)

fs/netfs/read_collect.c
    86 static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was_async)
    87 {
    88         struct netfs_io_subrequest *prev, *next;
    89         struct netfs_io_request *rreq = subreq->rreq;
    90         struct folio_queue *folioq = subreq->curr_folioq;
    91         size_t avail, prev_donated, next_donated, fsize, part, excess;
    92         loff_t fpos, start;
    93         loff_t fend;
    94         int slot = subreq->curr_folioq_slot;
    95 
    96         if (WARN(subreq->transferred > subreq->len,
    97                  "Subreq overread: R%x[%x] %zu > %zu",
    98                  rreq->debug_id, subreq->debug_index,
    99                  subreq->transferred, subreq->len))
    100                 subreq->transferred = subreq->len;
    101 
    102 next_folio:
    103         fsize = PAGE_SIZE << subreq->curr_folio_order;
    104         fpos = round_down(subreq->start + subreq->consumed, fsize);
    105         fend = fpos + fsize;
    106 
    107         if (WARN_ON_ONCE(!folioq) ||
                                 ^^^^^^^
Check for NULL

    108             WARN_ON_ONCE(!folioq_folio(folioq, slot)) ||
    109             WARN_ON_ONCE(folioq_folio(folioq, slot)->index != fpos / PAGE_SIZE)) {
    110                 pr_err("R=%08x[%x] s=%llx-%llx ctl=%zx/%zx/%zx sl=%u\n",
    111                        rreq->debug_id, subreq->debug_index,
    112                        subreq->start, subreq->start + subreq->transferred - 1,
    113                        subreq->consumed, subreq->transferred, subreq->len,
    114                        slot);
    115                 if (folioq) {
    116                         struct folio *folio = folioq_folio(folioq, slot);
    117 
    118                         pr_err("folioq: orders=%02x%02x%02x%02x\n",
    119                                folioq->orders[0], folioq->orders[1],
    120                                folioq->orders[2], folioq->orders[3]);
    121                         if (folio)
    122                                 pr_err("folio: %llx-%llx ix=%llx o=%u qo=%u\n",
    123                                        fpos, fend - 1, folio_pos(folio), folio_order(folio),
    124                                        folioq_folio_order(folioq, slot));
    125                 }
    126         }
    127 
    128 donation_changed:
    129         /* Try to consume the current folio if we've hit or passed the end of
    130          * it.  There's a possibility that this subreq doesn't start at the
    131          * beginning of the folio, in which case we need to donate to/from the
    132          * preceding subreq.
    133          *
    134          * We also need to include any potential donation back from the
    135          * following subreq.
    136          */
    137         prev_donated = READ_ONCE(subreq->prev_donated);
    138         next_donated =  READ_ONCE(subreq->next_donated);
    139         if (prev_donated || next_donated) {
    140                 spin_lock_bh(&rreq->lock);
    141                 prev_donated = subreq->prev_donated;
    142                 next_donated =  subreq->next_donated;
    143                 subreq->start -= prev_donated;
    144                 subreq->len += prev_donated;
    145                 subreq->transferred += prev_donated;
    146                 prev_donated = subreq->prev_donated = 0;
    147                 if (subreq->transferred == subreq->len) {
    148                         subreq->len += next_donated;
    149                         subreq->transferred += next_donated;
    150                         next_donated = subreq->next_donated = 0;
    151                 }
    152                 trace_netfs_sreq(subreq, netfs_sreq_trace_add_donations);
    153                 spin_unlock_bh(&rreq->lock);
    154         }
    155 
    156         avail = subreq->transferred;
    157         if (avail == subreq->len)
    158                 avail += next_donated;
    159         start = subreq->start;
    160         if (subreq->consumed == 0) {
    161                 start -= prev_donated;
    162                 avail += prev_donated;
    163         } else {
    164                 start += subreq->consumed;
    165                 avail -= subreq->consumed;
    166         }
    167         part = umin(avail, fsize);
    168 
    169         trace_netfs_progress(subreq, start, avail, part);
    170 
    171         if (start + avail >= fend) {
    172                 if (fpos == start) {
    173                         /* Flush, unlock and mark for caching any folio we've just read. */
    174                         subreq->consumed = fend - subreq->start;
--> 175                         netfs_unlock_read_folio(subreq, rreq, folioq, slot);
                                                                      ^^^^^^
Unchecked dereference

    176                         folioq_mark2(folioq, slot);
                                             ^^^^^^

    177                         if (subreq->consumed >= subreq->len)
    178                                 goto remove_subreq;
    179                 } else if (fpos < start) {
    180                         excess = fend - subreq->start;
    181 
    182                         spin_lock_bh(&rreq->lock);

regards,
dan carpenter

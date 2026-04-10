Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1D2DC767
	for <netfs@lists.linux.dev>; Fri, 10 Apr 2026 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800761; cv=none; b=QDACyItzV1ndWdvwYVCmegHYiYEYKcsoGcXW/C1HpDmyTppGWEcZxIH9S2w64Cmqk6yGn1aMCUI/hTw6fr6R9Expn8bNy5a5ikretcMDSAl6re1kIbMghuFYLxbvSS1vqqpLrx4w3uaXOfLVdmVIBSZL2AXsCHx1SRDwsNkX4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800761; c=relaxed/simple;
	bh=ys5DkVZJq0GuwqSjzZXEYHSbFOhD+C4s6x/HWZuWJu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oq+ASD+tsFYh1qLCtGFnP9tzNRYCMhlQeUwn1C4c/5zK2+VLH3NLc7DSrX+TyXv4xMmVnlJhtCs2SWv87Afbcsic2r3/BLZqQSm1crfKIy2Y0p/8M4IFOneMRwu5XNwESHRsBY5tjNuTBleOF9RTHP2oMt6751a75+ZPAcAm5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4sJqkNH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4sJqkNH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b983bb07eso980035f8f.0
        for <netfs@lists.linux.dev>; Thu, 09 Apr 2026 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775800758; x=1776405558; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ttLDxm0ieSoWUqU7Qsf8QeJ6W3C2avJVf1XkCWa1Pk=;
        b=l4sJqkNHSatHNGc+G2mQD1Zugz9e4+5hE8Pd17Cl6bsRmQFo+CDs5wfP/o2hYb/0E/
         OCDh9PHe/cqQzP1g9N7G1QJCNfHwCanIAlJZus/e4ktleofr+WU3HsKydQ44lpmkOkOk
         fCJCSBp4+4GFgBvb+e0kjmwzc7RYJU+Nbe1KP2MRtYZ/FYTej185onwm8hB2vSDOy+1H
         2scfIC6gNCdYWv+mBcPNgmTziDKgVcO3WvE0b5W3AMwSsovAVBiPlxxRWDgltcaLXGmc
         gs1/5N5DyuRiRmnqsOfZ8c3DeutahFyIX9O5YOAhNjQvmQX/b/WwpN52f5se/NtfGDz0
         7ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775800758; x=1776405558;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ttLDxm0ieSoWUqU7Qsf8QeJ6W3C2avJVf1XkCWa1Pk=;
        b=iszBwRQDMphC/2mrfkaNKS0Ea4Is9khVChuxL44Dd3+91jwqraBa9/8A2cCEFs0hOC
         Tjw1pbYZnbCbmls1R1N/Ja7vF/58ve+VFOpXCP+GFZVdmd8JUJreW8+cpXYhgTSWH1R6
         +Rj2YPezmVsrXrVwi7/mWy6stgGpvhxnF4X5hjmh9z3ABOdrfkEJ131mUAmDjg4uYHxR
         UZ8iYWG5zkeRLRLIJaqQtAFhwEXZar+XBVmLthRWgR5l0yZmen0sCqv56kyGnHNpvC/9
         bR+Nm4XYfMPvFibiq3FnCLkpqpdL4uX+FnYKMDW1NQvXxTCfq5QSMk4cb3sk9c5Dx4pt
         TKtA==
X-Gm-Message-State: AOJu0YwdGrp54LNhDIwMUfn71a7AARHvNjZtZY5F492PISEc7ZOtIzBe
	uEsMKZ+yN5rhAr7/c26uhRJ5O1vHir9E5bsDeJrOsMJX7XEeKXEnkjM9
X-Gm-Gg: AeBDieugU2Qh2lBbekpkkSSQG0ETahCB/0uZQT6FYLz86A2U93o91l1LUuvuxOzUQyu
	wVwf3Ne3LI/sOL4femxVVRx9BH++M5x1CrLb8l4kEjwpMtflV4QZblC3LZ7Qawk7XFsQ+ibCM9A
	y3FkyniUGV4wlADUxmB8oN9k5mRzef2wNqnEhKU4ntSoHK1ci1b9TBOEgpb/3eckH8QmnFet0s5
	cVTxsTmS8u6oPcB/RRayK23fo/ph04WGSuDrvrTNXO8yI/rzp/HeLFdPm+tAJi5rl9UtTsnuwH2
	adG67t/b48w2fLTYlNQnWSWkyqt3T7VHzWl6y48Q2tt4MCYqS7v64YxemNKbQm34ATFzFkgsHJy
	eebEXkI4GJ+Ru/RyN3uRUUEm1dHICFQ7pL0/LPvLUXxTHKC81itjKC5Wlog+oDR4bKXNxECxpr8
	/HQiJDJ/Gh4Wfz2tAG2ks=
X-Received: by 2002:a05:6000:288b:b0:439:c040:cc8a with SMTP id ffacd0b85a97d-43d642b6a81mr2345267f8f.32.1775800757998;
        Thu, 09 Apr 2026 22:59:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63ab84cdsm4849467f8f.0.2026.04.09.22.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 22:59:17 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:59:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Subject: [bug report] netfs: Fix unbuffered/DIO writes to dispatch
 subrequests in strict sequence
Message-ID: <adiRsuLerMVmvJ36@stanley.mountain>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Howells,

Commit a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch
subrequests in strict sequence") from Feb 26, 2026 (linux-next),
leads to the following Smatch static checker warning:

	fs/netfs/direct_write.c:203 netfs_unbuffered_write()
	error: uninitialized symbol 'ret'.

fs/netfs/direct_write.c
    94 static int netfs_unbuffered_write(struct netfs_io_request *wreq)
    95 {
    96         struct netfs_io_subrequest *subreq = NULL;
    97         struct netfs_io_stream *stream = &wreq->io_streams[0];
    98         int ret;
    99 
    100         _enter("%llx", wreq->len);
    101 
    102         if (wreq->origin == NETFS_DIO_WRITE)
    103                 inode_dio_begin(wreq->inode);
    104 
    105         stream->collected_to = wreq->start;
    106 
    107         for (;;) {
    108                 bool retry = false;
    109 
    110                 if (!subreq) {
    111                         netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
    112                         subreq = stream->construct;
    113                         stream->construct = NULL;
    114                 }
    115 
    116                 /* Check if (re-)preparation failed. */
    117                 if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
    118                         netfs_write_subrequest_terminated(subreq, subreq->error);
    119                         wreq->error = subreq->error;
    120                         break;

If we break on the first iteration

    121                 }
    122 
    123                 iov_iter_truncate(&subreq->io_iter, wreq->len - wreq->transferred);
    124                 if (!iov_iter_count(&subreq->io_iter))
    125                         break;

or here

    126 
    127                 subreq->len = netfs_limit_iter(&subreq->io_iter, 0,
    128                                                stream->sreq_max_len,
    129                                                stream->sreq_max_segs);
    130                 iov_iter_truncate(&subreq->io_iter, subreq->len);
    131                 stream->submit_extendable_to = subreq->len;
    132 
    133                 trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
    134                 stream->issue_write(subreq);
    135 
    136                 /* Async, need to wait. */
    137                 netfs_wait_for_in_progress_stream(wreq, stream);
    138 
    139                 if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
    140                         retry = true;
    141                 } else if (test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
    142                         ret = subreq->error;
    143                         wreq->error = ret;
    144                         netfs_see_subrequest(subreq, netfs_sreq_trace_see_failed);
    145                         subreq = NULL;
    146                         break;
    147                 }
    148                 ret = 0;
    149 
    150                 if (!retry) {
    151                         netfs_unbuffered_write_collect(wreq, stream, subreq);
    152                         subreq = NULL;
    153                         if (wreq->transferred >= wreq->len)
    154                                 break;
    155                         if (!wreq->iocb && signal_pending(current)) {
    156                                 ret = wreq->transferred ? -EINTR : -ERESTARTSYS;
    157                                 trace_netfs_rreq(wreq, netfs_rreq_trace_intr);
    158                                 break;
    159                         }
    160                         continue;
    161                 }
    162 
    163                 /* We need to retry the last subrequest, so first reset the
    164                  * iterator, taking into account what, if anything, we managed
    165                  * to transfer.
    166                  */
    167                 subreq->error = -EAGAIN;
    168                 trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
    169                 if (subreq->transferred > 0)
    170                         iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
    171 
    172                 if (stream->source == NETFS_UPLOAD_TO_SERVER &&
    173                     wreq->netfs_ops->retry_request)
    174                         wreq->netfs_ops->retry_request(wreq, stream);
    175 
    176                 __clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
    177                 __clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
    178                 __clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
    179                 subreq->io_iter                = wreq->buffer.iter;
    180                 subreq->start                = wreq->start + wreq->transferred;
    181                 subreq->len                = wreq->len   - wreq->transferred;
    182                 subreq->transferred        = 0;
    183                 subreq->retry_count        += 1;
    184                 stream->sreq_max_len        = UINT_MAX;
    185                 stream->sreq_max_segs        = INT_MAX;
    186 
    187                 netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
    188 
    189                 if (stream->prepare_write) {
    190                         stream->prepare_write(subreq);
    191                         __set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
    192                         netfs_stat(&netfs_n_wh_retry_write_subreq);
    193                 } else {
    194                         struct iov_iter source;
    195 
    196                         netfs_reset_iter(subreq);
    197                         source = subreq->io_iter;
    198                         netfs_reissue_write(stream, subreq, &source);
    199                 }
    200         }
    201 
    202         netfs_unbuffered_write_done(wreq);
--> 203         _leave(" = %d", ret);
    204         return ret;

Then ret is uninitialized

    205 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB92330641
	for <netfs@lists.linux.dev>; Sat, 20 Jun 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948483; cv=none; b=ruQZIfFauy+U7ayNByKxPxjeY2h0ypJ9dLlDSBHCSU3V5jcIYApzo2KMlmQfQIUsYbxpd0XFFQ4j6nPz/Xdb3TV+Tu0LioF6c/RglXqirmdGuOixGbrPlVFnIGm0RVj97Uxv0PIUbc0gAzaBCRihBjk/I9t38aylyyUnHg1jU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948483; c=relaxed/simple;
	bh=rm+aw7TFBQrv0ZMiBQCFF9M2c6Nn7tnQjkvVVs92QX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L1s2TQ5p3K5nwDQ68bFPVkQ+EEXKiHg8Q/319msl+Kz0M3d1Q4y1ZjId97FPSnXdDqhg9ZC87jsGistOZXHMastQ49YyiZ3c2jtIA5ju834W15SIwWCJmsY9bloScfFlcIvldG/42SmK6LCyfclpYhqSnHSsfGbPdoAh2IDU2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqh6IXM5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqh6IXM5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso16246835e9.2
        for <netfs@lists.linux.dev>; Sat, 20 Jun 2026 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781948481; x=1782553281; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRrLrsYWq7vs1SMlDwD8RRSsANgu2xFW6mXj7zPJgy4=;
        b=Fqh6IXM5A9ao/mZpbEyxHaq/b2OZ5Eupdyqt5zgYNQgYIEzDxGXf5pQLjv6THwxkqB
         s643eeE4kqpYlFWe+RpFGR5OPNNFhHJqHOknWWs4jtT53PFubng6fHB1dd8U5/gSlgsG
         1cAHJyvxmRsmlXygwy+8slEf8WyPdqdGt9oWEKcj639sExU1he2/8rqrTDbp9k5GnVhr
         RUAFeORdBNGt/ExvoDGcOSmFM7+a/DNrkiBQK87lG1kThR2Wo5LDDXBPXYGNzoIMKTsk
         iD8a0HZiR8bj93sx+ckIkbaxSMz2yzir36Trn5kmtQGg7ANjZGWiMugdC5E9StiinuzM
         cUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781948481; x=1782553281;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRrLrsYWq7vs1SMlDwD8RRSsANgu2xFW6mXj7zPJgy4=;
        b=OQ288c8lprOWX5ZA2jz2TTQml0V1G7Tr8TC67cunkZXk619S4Rb3WttkWjfcS10RBr
         5GuYe0G5QxqmoyE5pNQ5dia+59KiPu1imKNo+8mw26OgUU77XJPpU1SQbbL7+ZhzD+ML
         xKuLpkfA9L9R0TfC/DbucMtJBoRkAgitSvIdCrRupYCRsrt7q3O+lzAOxZm7Hh0Oio0x
         GBw+20TAijALG0HMsbaNFOc6Fw6DpU8tie/wU6khSuujX3IYSa/B9xK84Hf65dC6cRKm
         YOzYRzfCKyrb5fV0VVHQ3oA4KxCX70OoJ6UpNzHfoWe6xwMW7aE7z4lD4CMofpXXv8Lk
         CiWg==
X-Gm-Message-State: AOJu0YwTVleVCNRN3TfxZpme7XOEf31/Xmi0F76dkXwCTsAQgEd2mB7I
	JTnmT3g6Olj1FqIrhlobjVZyY9H83w+RIQKPOK9QRXM1cuQnaZ3P/11kYDPzgBvp
X-Gm-Gg: AfdE7ckn5d8vaU49fBLKSPmJEYrZPhN+AXlYUHhMvkq/PSvxHMa1jB+4mK6UJizSMkb
	nI+44lJ7YcdEv9SLtZoBe6oKUF5MEC4svwzo7dNtnQAwoYv10TFaA6UNk/FUcJ68z4ry+VM1uS3
	cFLZDBcwFRUW+kVAXggdAmrNURxn2Uddz921Zuo3qJ8WhecUtoMCEiBfwlRxJqM8oiYM/dzOrYN
	opzCZHkZtbO2BQTztHgZYeshsL0AxIvpz2UFKGZqYt0fZDFrd6vGKvG29nTHrGzwrD+Gln8g2DZ
	rbyrmKOfyDwrGEjoFCgI+Y0uEAZS5ZJd+pDnQGelJ8hqLzXY8xQkhVeQVLSGw1dh6nf3lqaNR4d
	h5Goin5RFUEIgISiHZyA5ctJ7V5sk1iZ6ebhJT/gpGgm0CCjuYIr0kbzMGBQrG5D0f+hRZwmXp5
	CcKKRYSxIq
X-Received: by 2002:a05:600c:1c1c:b0:492:1e36:552b with SMTP id 5b1f17b1804b1-49240e7f307mr128612815e9.36.1781948480646;
        Sat, 20 Jun 2026 02:41:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c698dsm7004085f8f.16.2026.06.20.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 02:41:20 -0700 (PDT)
Date: Sat, 20 Jun 2026 12:41:15 +0300
From: Dan Carpenter <error27@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Subject: [bug report] netfs: Fix unbuffered/DIO writes to dispatch
 subrequests in strict sequence
Message-ID: <ajZgOxr6BtqXzgly@stanley.mountain>
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

	fs/netfs/direct_write.c:119 netfs_unbuffered_write()
	warn: 'subreq' was already freed. (line 118)

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
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
netfs_write_subrequest_terminated() sets the subreq->error but then it
calls netfs_put_subrequest().  The "subreq" variable is refcounted so
this might be a false positive, but Smatch complains that maybe the
netfs_put_subrequest() frees subreq.  This is a mempool so it likely
wouldn't show up in testing.

--> 119                         wreq->error = subreq->error;
                                              ^^^^^^^^^^^^^
Leading to a use after free.

    120                         break;
    121                 }
    122 
    123                 iov_iter_truncate(&subreq->io_iter, wreq->len - wreq->transferred);
    124                 if (!iov_iter_count(&subreq->io_iter))
    125                         break;
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

No need to set subreq to NULL, I think?

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
    203         _leave(" = %d", ret);
    204         return ret;
    205 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADE2904;
	Tue, 28 Jan 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083123; cv=none; b=MDI+qLN9WtV0vIgJPrxyA+HJzZLudkbl0lqQ2LUMV03+kgP1Yj8aSILspJnEN/O+Zw2rmsyUIbaoKLVRprKa6smjrvpB/fTOZBlkUWF+/h4MvT/PF1qwkZuktdo1bm9rKGxxafsPq0L7XgxK8oaSHx+1V/kjDqT/2sdZz2O9Kns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083123; c=relaxed/simple;
	bh=rgGyPw6WivR4wckN2azykOiMjybNsZ0pBxyqM9AmsYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCWmumD286GcOATvB52nIs8ySmEq/Imi1p2oqwph/It8At/vTHiKUPsW3wPLnpa63/7Le/Su/GP0f3fx5Hs6oxXpXuDqNb2Iashvf6Ti6eR7pjdsf31315/Yb4+pa6yb50zLjbRz+fmUIg5vjaT1n0OIS6xvuVMZKDxSFydtDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaee0b309adso185713166b.3;
        Tue, 28 Jan 2025 08:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083119; x=1738687919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6y7s2ycTPBwMzwbJK9iV/0/faT4TnIsalXlg0D1E2U=;
        b=jEX7Qv88c0woT022+ZtggNbNh/TZn9VEycsNtjNrZI0LpJxOehVWWBT4JUVNuKR71L
         vKrbh9trDRMiuGmVtTzoPTucFmvQ/UMsriHT5heI+H/XSeE8f2QmbcysqfQsZTkNwA6N
         i5ZNfIyzeUTJcD/tbIUdwPNrNs1eZ20DoS9MLTYlXVVXnDjVcqxoWmyK6oj1DCPbyrJf
         ZtJcAcTjTvCnnWOx/blqFgyrLqflquXQ4F+30HRjpV11QJ7Puo7beyhbP6ZFnKoAzkI5
         L/1qRhlLIIq7JtQ8R4fN4cnSyiBdTIHerjfgaXASVS7NVr0P2w84++P2I+QCu24wZOjH
         dUtA==
X-Forwarded-Encrypted: i=1; AJvYcCUeKVg2zo6VPW+LBV++oKX/yEpBgL5CtyAG6RGp8EJtxk+zYylxTCGeM+DZoC0ZVKzNHDgOJw==@lists.linux.dev, AJvYcCUiwATMCHWPqs/KX15wOeNFJwfVIdm3bhW3E26nmeTkleQilureNsUFYBEEStzg3TwNnVBxng==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyxVtpsKbvxevv/ZzYhYlHZptyJhPdU/BQ1y/8FTyC6DKx0R2i
	styGtt9ttTUecXNiBkhJNHMqe5EpFeYJ9iO0yOzkw8Pu3W2tXmclofWKRDOBu6k=
X-Gm-Gg: ASbGncvsa1OJPa2xY8PSHeblvu/X37I7K6L+Yp+tzLyEyqN0XVGraWBsNThxAAF0Oq2
	ES4L1PpyJS0cUq28OdwnlzYGewJ4ZfeovPj2Y5h+otptdc+d3MI1KmVopEIdx67nwEnoUjBlqtG
	H4dYvZvDouYivmUJDsF/6Xg2lTXMIaskfhj8Bc82D0DT0J6RL1N5BIvDbTheDaSGbs3oN+ZiNan
	hgtylVifkuCcWWT/Ajuiz70F1cc8H1EPmWp5QNR84pSKtQ0DC8WOhtdRwow8Ju0Y5KoGyaiR/rJ
	zEWY//vlXXErXXno/TmyZAO8xqNEg8/k6+k8fGJbIyFQsSr278h3oacolJI=
X-Google-Smtp-Source: AGHT+IHCUiuJrMwKZ/t5J1ZfL19Ku49GLds3WU9mQDEVd8V/J3bhBxDBRhKdb7RaPTS0trVuRhuAxQ==
X-Received: by 2002:a17:907:1c26:b0:aa6:88ae:22a with SMTP id a640c23a62f3a-ab38b3aff78mr4256499366b.37.1738083118447;
        Tue, 28 Jan 2025 08:51:58 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e12d83sm814920866b.37.2025.01.28.08.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 08:51:58 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so177636166b.2;
        Tue, 28 Jan 2025 08:51:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWC33M8qmndQJ8BCbWmehGQz1KCvo2fPivNAAKqZT4mq/j0iz/SgkqJsVj/+2VJzSpJUT+hQ==@lists.linux.dev, AJvYcCXZIb/1mH+rWB2drd4X2cdA6ItNslddl8VA6HGhKPJPhyeLHIP9EtWaUZVNe09CSADuyohN2g==@lists.linux.dev
X-Received: by 2002:a17:907:d0f:b0:aa6:a9fe:46dd with SMTP id
 a640c23a62f3a-ab38b3aff9fmr4771843366b.38.1738083117609; Tue, 28 Jan 2025
 08:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3173328.1738024385@warthog.procyon.org.uk>
In-Reply-To: <3173328.1738024385@warthog.procyon.org.uk>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 28 Jan 2025 12:51:46 -0400
X-Gmail-Original-Message-ID: <CAB9dFdtdNXR4K6dMaLTrWCO_Op7_g=NZZ5icB-iarvrLp8eoeA@mail.gmail.com>
X-Gm-Features: AWEUYZnlT7G53bpulMTDgO_Ga7IAUdNVp8mNwIWx3vbOISgKSRaogUhhtO1InLA
Message-ID: <CAB9dFdtdNXR4K6dMaLTrWCO_Op7_g=NZZ5icB-iarvrLp8eoeA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix a number of read-retry hangs
To: David Howells <dhowells@redhat.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Steve French <stfrench@microsoft.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:33=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Ihor, Marc, Steve,
>
> I think this patch should better fix the hangs that have been seen than I=
hor's
> previously tested fix (which I think isn't actually correct).
>
> David
> ---
> From: David Howells <dhowells@redhat.com>
>
> netfs: Fix a number of read-retry hangs
>
> Fix a number of hangs in the netfslib read-retry code, including:
>
>  (1) netfs_reissue_read() doubles up the getting of references on
>      subrequests, thereby leaking the subrequest and causing inode evicti=
on
>      to wait indefinitely.  This can lead to the kernel reporting a hang =
in
>      the filesystem's evict_inode().
>
>      Fix this by removing the get from netfs_reissue_read() and adding on=
e
>      to netfs_retry_read_subrequests() to deal with the one place that
>      didn't double up.
>
>  (2) The loop in netfs_retry_read_subrequests() that retries a sequence o=
f
>      failed subrequests doesn't record whether or not it retried the one
>      that the "subreq" pointer points to when it leaves the loop.  It may
>      not if renegotiation/repreparation of the subrequests means that few=
er
>      subrequests are needed to span the cumulative range of the sequence.
>
>      Because it doesn't record this, the piece of code that discards
>      now-superfluous subrequests doesn't know whether it should discard t=
he
>      one "subreq" points to - and so it doesn't.
>
>      Fix this by noting whether the last subreq it examines is superfluou=
s
>      and if it is, then getting rid of it and all subsequent subrequests.
>
>      If that one one wasn't superfluous, then we would have tried to go
>      round the previous loop again and so there can be no further unretri=
ed
>      subrequests in the sequence.
>
>  (3) netfs_retry_read_subrequests() gets yet an extra ref on any addition=
al
>      subrequests it has to get because it ran out of ones it could reuse =
to
>      to renegotiation/repreparation shrinking the subrequests.
>
>      Fix this by removing that extra ref.
>
>  (4) In netfs_retry_reads(), it was using wait_on_bit() to wait for
>      NETFS_SREQ_IN_PROGRESS to be cleared on all subrequests in the
>      sequence - but netfs_read_subreq_terminated() is now using a wait
>      queue on the request instead and so this wait will never finish.
>
>      Fix this by waiting on the wait queue instead.  To make this work, a
>      new flag, NETFS_RREQ_RETRYING, is now set around the wait loop to te=
ll
>      the wake-up code to wake up the wait queue rather than requeuing the
>      request's work item.
>
>      Note that this flag replaces the NETFS_RREQ_NEED_RETRY flag which is
>      no longer used.
>
>  (5) Whilst not strictly anything to do with the hang,
>      netfs_retry_read_subrequests() was also doubly incrementing the
>      subreq_counter and re-setting the debug index, leaving a gap in the
>      trace.  This is also fixed.
>
> One of these hangs was observed with 9p and with cifs.  Others were force=
d
> by manual code injection into fs/afs/file.c.  Firstly, afs_prepare_read()
> was created to provide an changing pattern of maximum subrequest sizes:
>
>         static int afs_prepare_read(struct netfs_io_subrequest *subreq)
>         {
>                 struct netfs_io_request *rreq =3D subreq->rreq;
>                 if (!S_ISREG(subreq->rreq->inode->i_mode))
>                         return 0;
>                 if (subreq->retry_count < 20)
>                         rreq->io_streams[0].sreq_max_len =3D
>                                 umax(200, 2222 - subreq->retry_count * 40=
);
>                 else
>                         rreq->io_streams[0].sreq_max_len =3D 3333;
>                 return 0;
>         }
>
> and pointed to by afs_req_ops.  Then the following:
>
>         struct netfs_io_subrequest *subreq =3D op->fetch.subreq;
>         if (subreq->error =3D=3D 0 &&
>             S_ISREG(subreq->rreq->inode->i_mode) &&
>             subreq->retry_count < 20) {
>                 subreq->transferred =3D subreq->already_done;
>                 __clear_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
>                 __set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>                 afs_fetch_data_notify(op);
>                 return;
>         }
>
> was inserted into afs_fetch_data_success() at the beginning and struct
> netfs_io_subrequest given an extra field, "already_done" that was set to
> the value in "subreq->transferred" by netfs_reissue_read().
>
> When reading a 4K file, the subrequests would get gradually smaller, a ne=
w
> subrequest would be allocated around the 3rd retry and then eventually be
> rendered superfluous when the 20th retry was hit and the limit on the fir=
st
> subrequest was eased.
>
> Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
> Closes: https://lore.kernel.org/r/a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_=
xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=3D@pm.=
me/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: v9fs@lists.linux.dev
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_collect.c      |    6 ++++--
>  fs/netfs/read_retry.c        |   40 ++++++++++++++++++++++++++++++------=
----
>  include/linux/netfs.h        |    2 +-
>  include/trace/events/netfs.h |    4 +++-
>  4 files changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index f65affa5a9e4..636cc5a98ef5 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -470,7 +470,8 @@ void netfs_read_collection_worker(struct work_struct =
*work)
>   */
>  void netfs_wake_read_collector(struct netfs_io_request *rreq)
>  {
> -       if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
> +       if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags) &&
> +           !test_bit(NETFS_RREQ_RETRYING, &rreq->flags)) {
>                 if (!work_pending(&rreq->work)) {
>                         netfs_get_request(rreq, netfs_rreq_trace_get_work=
);
>                         if (!queue_work(system_unbound_wq, &rreq->work))
> @@ -586,7 +587,8 @@ void netfs_read_subreq_terminated(struct netfs_io_sub=
request *subreq)
>         smp_mb__after_atomic(); /* Clear IN_PROGRESS before task state */
>
>         /* If we are at the head of the queue, wake up the collector. */
> -       if (list_is_first(&subreq->rreq_link, &stream->subrequests))
> +       if (list_is_first(&subreq->rreq_link, &stream->subrequests) ||
> +           test_bit(NETFS_RREQ_RETRYING, &rreq->flags))
>                 netfs_wake_read_collector(rreq);
>
>         netfs_put_subrequest(subreq, true, netfs_sreq_trace_put_terminate=
d);
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 2290af0d51ac..8316c4533a51 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -14,7 +14,6 @@ static void netfs_reissue_read(struct netfs_io_request =
*rreq,
>  {
>         __clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
>         __set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
> -       netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>         subreq->rreq->netfs_ops->issue_read(subreq);
>  }
>
> @@ -48,6 +47,7 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
>                                 __clear_bit(NETFS_SREQ_MADE_PROGRESS, &su=
breq->flags);
>                                 subreq->retry_count++;
>                                 netfs_reset_iter(subreq);
> +                               netfs_get_subrequest(subreq, netfs_sreq_t=
race_get_resubmit);
>                                 netfs_reissue_read(rreq, subreq);
>                         }
>                 }
> @@ -75,7 +75,7 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
>                 struct iov_iter source;
>                 unsigned long long start, len;
>                 size_t part;
> -               bool boundary =3D false;
> +               bool boundary =3D false, subreq_superfluous =3D false;
>
>                 /* Go through the subreqs and find the next span of conti=
guous
>                  * buffer that we then rejig (cifs, for example, needs th=
e
> @@ -116,8 +116,10 @@ static void netfs_retry_read_subrequests(struct netf=
s_io_request *rreq)
>                 /* Work through the sublist. */
>                 subreq =3D from;
>                 list_for_each_entry_from(subreq, &stream->subrequests, rr=
eq_link) {
> -                       if (!len)
> +                       if (!len) {
> +                               subreq_superfluous =3D true;
>                                 break;
> +                       }
>                         subreq->source  =3D NETFS_DOWNLOAD_FROM_SERVER;
>                         subreq->start   =3D start - subreq->transferred;
>                         subreq->len     =3D len   + subreq->transferred;
> @@ -154,19 +156,21 @@ static void netfs_retry_read_subrequests(struct net=
fs_io_request *rreq)
>
>                         netfs_get_subrequest(subreq, netfs_sreq_trace_get=
_resubmit);
>                         netfs_reissue_read(rreq, subreq);
> -                       if (subreq =3D=3D to)
> +                       if (subreq =3D=3D to) {
> +                               subreq_superfluous =3D false;
>                                 break;
> +                       }
>                 }
>
>                 /* If we managed to use fewer subreqs, we can discard the
>                  * excess; if we used the same number, then we're done.
>                  */
>                 if (!len) {
> -                       if (subreq =3D=3D to)
> +                       if (!subreq_superfluous)
>                                 continue;
>                         list_for_each_entry_safe_from(subreq, tmp,
>                                                       &stream->subrequest=
s, rreq_link) {
> -                               trace_netfs_sreq(subreq, netfs_sreq_trace=
_discard);
> +                               trace_netfs_sreq(subreq, netfs_sreq_trace=
_superfluous);
>                                 list_del(&subreq->rreq_link);
>                                 netfs_put_subrequest(subreq, false, netfs=
_sreq_trace_put_done);
>                                 if (subreq =3D=3D to)
> @@ -187,14 +191,12 @@ static void netfs_retry_read_subrequests(struct net=
fs_io_request *rreq)
>                         subreq->source          =3D NETFS_DOWNLOAD_FROM_S=
ERVER;
>                         subreq->start           =3D start;
>                         subreq->len             =3D len;
> -                       subreq->debug_index     =3D atomic_inc_return(&rr=
eq->subreq_counter);
>                         subreq->stream_nr       =3D stream->stream_nr;
>                         subreq->retry_count     =3D 1;
>
>                         trace_netfs_sreq_ref(rreq->debug_id, subreq->debu=
g_index,
>                                              refcount_read(&subreq->ref),
>                                              netfs_sreq_trace_new);
> -                       netfs_get_subrequest(subreq, netfs_sreq_trace_get=
_resubmit);
>
>                         list_add(&subreq->rreq_link, &to->rreq_link);
>                         to =3D list_next_entry(to, rreq_link);
> @@ -256,14 +258,32 @@ void netfs_retry_reads(struct netfs_io_request *rre=
q)
>  {
>         struct netfs_io_subrequest *subreq;
>         struct netfs_io_stream *stream =3D &rreq->io_streams[0];
> +       DEFINE_WAIT(myself);
> +
> +       set_bit(NETFS_RREQ_RETRYING, &rreq->flags);
>
>         /* Wait for all outstanding I/O to quiesce before performing retr=
ies as
>          * we may need to renegotiate the I/O sizes.
>          */
>         list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
> -               wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
> -                           TASK_UNINTERRUPTIBLE);
> +               if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags))
> +                       continue;
> +
> +               trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
> +               for (;;) {
> +                       prepare_to_wait(&rreq->waitq, &myself, TASK_UNINT=
ERRUPTIBLE);
> +
> +                       if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->fl=
ags))
> +                               break;
> +
> +                       trace_netfs_sreq(subreq, netfs_sreq_trace_wait_fo=
r);
> +                       schedule();
> +                       trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queu=
e);
> +               }
> +
> +               finish_wait(&rreq->waitq, &myself);
>         }
> +       clear_bit(NETFS_RREQ_RETRYING, &rreq->flags);
>
>         trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
>         netfs_retry_read_subrequests(rreq);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 071d05d81d38..c86a11cfc4a3 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -278,7 +278,7 @@ struct netfs_io_request {
>  #define NETFS_RREQ_PAUSE               11      /* Pause subrequest gener=
ation */
>  #define NETFS_RREQ_USE_IO_ITER         12      /* Use ->io_iter rather t=
han ->i_pages */
>  #define NETFS_RREQ_ALL_QUEUED          13      /* All subreqs are now qu=
eued */
> -#define NETFS_RREQ_NEED_RETRY          14      /* Need to try retrying *=
/
> +#define NETFS_RREQ_RETRYING            14      /* Set if we're in the re=
try path */
>  #define NETFS_RREQ_USE_PGPRIV2         31      /* [DEPRECATED] Use PG_pr=
ivate_2 to mark
>                                                  * write to cache on read=
 */
>         const struct netfs_request_ops *netfs_ops;
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index 6e699cadcb29..f880835f7695 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -99,7 +99,7 @@
>         EM(netfs_sreq_trace_limited,            "LIMIT")        \
>         EM(netfs_sreq_trace_need_clear,         "N-CLR")        \
>         EM(netfs_sreq_trace_partial_read,       "PARTR")        \
> -       EM(netfs_sreq_trace_need_retry,         "NRTRY")        \
> +       EM(netfs_sreq_trace_need_retry,         "ND-RT")        \
>         EM(netfs_sreq_trace_prepare,            "PREP ")        \
>         EM(netfs_sreq_trace_prep_failed,        "PRPFL")        \
>         EM(netfs_sreq_trace_progress,           "PRGRS")        \
> @@ -108,7 +108,9 @@
>         EM(netfs_sreq_trace_short,              "SHORT")        \
>         EM(netfs_sreq_trace_split,              "SPLIT")        \
>         EM(netfs_sreq_trace_submit,             "SUBMT")        \
> +       EM(netfs_sreq_trace_superfluous,        "SPRFL")        \
>         EM(netfs_sreq_trace_terminated,         "TERM ")        \
> +       EM(netfs_sreq_trace_wait_for,           "_WAIT")        \
>         EM(netfs_sreq_trace_write,              "WRITE")        \
>         EM(netfs_sreq_trace_write_skip,         "SKIP ")        \
>         E_(netfs_sreq_trace_write_term,         "WTERM")

Looks good in testing, with afs.  Took quite a few iterations to see
evidence of a retry occurring, where the new stat was helpful.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc

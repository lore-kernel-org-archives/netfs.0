Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F71F19A;
	Tue, 11 Feb 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236047; cv=none; b=OiJ2BcZxoKfaCL/hqZNI1oSzjdznfxgTocfMgREjv4kTkph8HKGO6bsT7FHhOv8V3wF/fdWTaxpNHoAvkFkpPFWGHsit4qlCZ3SsDtFM/UKGU2Hw7PhG2QXYVSXdw6Oz8qwO+6/CC69sjgmsXz4Fzphl3866Q+wQzPg1H7r6ihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236047; c=relaxed/simple;
	bh=VtjSX7NVMNTMsIobvwS6cshGZ2l7KlG3DCyzTH34EPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MarMuO7dErdh8zDyzrvcp7fGpu/cN6/IUnK/4/F/Odm1fD1yqKIyz6vBldWLMWeEcHHHE5MM4pBrZwhtpiaKxLlvms+lCzg0Q8pxakr/ipDATNIQXh49LVQzJGRllKMI0KskTykDMHVKFhOlATKjLVeJi7/4jvEOiPfE1qYwB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIHwBeVi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIHwBeVi"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5450475df04so2868451e87.0;
        Mon, 10 Feb 2025 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739236042; x=1739840842; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3aiVLMNRlyfUkDqwbDVYlMoR0XccIIxNWtQMkt7xoU=;
        b=ZIHwBeViviMMQCzzBpcRRz6mOUu3wpmUAvRUU2w0sWrVfmREGhJWl9ew4uE0gtJSFr
         1hOv4sjwYCZeFK8zkAL501LY257cIlx1L5I4YBM1T5gtPtBWONjnBzk+t4Me80Nba6d/
         yRlvxXjRDbne3yluVvOzz65Uk4YBLmRtMm6zI0wRhHZ1popXwiHy2/VGYQFRPIis9glD
         tiXZFqJMxEGbGCUXxdkzsDpaBefLe2cGRMz1ntQ+K7iq8zI6yFJavKX77xM8zwSD+apq
         SM6N0NKiEqrmKnqpcjspwpm7DGXjvPRvSHCfXW6V7shUvCXe+GAVe1a766yFjlF6BX7q
         /GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236042; x=1739840842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3aiVLMNRlyfUkDqwbDVYlMoR0XccIIxNWtQMkt7xoU=;
        b=wELN98LEkyoHT+TYjSmprXxw8gUUSdLgzFMZujFf4ZaufLyaJ+qDgoU90FvnrzBofl
         PZyA3oINBTelryts2M7aQVPXp16RfWw3AQVUqN2NbIxDnmdEVyItjDlvB397sdGU7qnO
         bBCmhlbQJ6oMOT3XQ2R6VUQk1XeZ6l44vAl3GeYwW848FL78Oq0wtvlTgYuJdf4wcmt0
         ZVV4q6WEAkLYpQxKlPIHKB0S8To0jt6jzJuqSyIIGMIoybv/zXOBMGIUc5RltL8h2AJR
         HYETccCJQuuT4ApyK05zr9iELClbyQExCu7AofNG6MZqg5AdgNRJe/Vu6JCnEL8SPJI9
         vXQg==
X-Forwarded-Encrypted: i=1; AJvYcCUY6c+fqGXzmARu+YbLo2TvH3ErOKZX8b2cL4CXoc+9vZw9igcsRADQ1qmebpqVCp/Ocp++xQ==@lists.linux.dev, AJvYcCXmjsTOQ5qazm0U0e8rdY7VDJvAqHTDUGkr7y8kk3O+bSnLhEaH5j36o0JiXF8sZQCkd2q71g==@lists.linux.dev
X-Gm-Message-State: AOJu0YypuofzmnoWpdhcIWV2Cv4VCgAFH6J9ts7PuuxHa/fWlRZs0i9P
	2Zvisb8N1V+nTxr5NzNMYHl4At0MFVJbXjrKrAsPlR41uqpwrQDzFPRej4yy1YZHJpc5nFJ7cvy
	SVStRIAWTw3JWhguWhGx4m3wTrQg=
X-Gm-Gg: ASbGncvf9z1cTwErO3Wpn/ueUOVDBxUBKswjKXysIPaqKVHZtQQXfoj0Zc3A+7F7T1G
	bU7uAgK8Gd2/LITqMKON65W0OwMXEAWjnGw1CJgoKsUDLU1siUsdYDl4ugoXyreVv2/syofMGqg
	==
X-Google-Smtp-Source: AGHT+IH8obq45a+qNxBooIODCvuLPlny+GRRvg8vhmVaa7eHC5ijRJaPNEfU/tlz7UQMZA7GAVDryYzPzrl5ImEylSo=
X-Received: by 2002:a05:6512:4024:b0:545:746:f36f with SMTP id
 2adb3069b0e04-5450746f4f3mr2904851e87.42.1739236042041; Mon, 10 Feb 2025
 17:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3173328.1738024385@warthog.procyon.org.uk>
In-Reply-To: <3173328.1738024385@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 10 Feb 2025 19:07:10 -0600
X-Gm-Features: AWEUYZkK1I5w5IJb7KEfEYF23bHLVE0P8v8Dh-x3wpYUU-U4ZGbsjmuT8ReSpmw
Message-ID: <CAH2r5muh6-PtS3TcAEAP9xjStcib3KzDtiQmmmWOPHaV2jr2xA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix a number of read-retry hangs
To: David Howells <dhowells@redhat.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Marc Dionne <marc.dionne@auristor.com>, 
	Steve French <stfrench@microsoft.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Paulo Alcantara <pc@manguebit.com>, 
	Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, 
	linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Steve French <stfrench@microsoft.com>

Verified it fixed various hangs I saw in testing cifs.ko  Here is a
success run with the patch e.g.:
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/=
builds/342


On Mon, Jan 27, 2025 at 6:33=E2=80=AFPM David Howells <dhowells@redhat.com>=
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
>
>


--=20
Thanks,

Steve

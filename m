Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA226AD9;
	Tue,  1 Jul 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389644; cv=none; b=neq/sHljN5aCiRtz3nHaV2xdkXLBuy+e142RWO2sp7UJBYp/15JJTR6lxt5MFY3QpMX+y7jCsFHdQ/esX15mIRpJ6uiWMwk2B2USzVL6A639U4X7Zhd7cDZjHAiOHEgI4oJ7WMkSe2RUU/ktHbF58FsOFeoCWmucQ3PTSclKs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389644; c=relaxed/simple;
	bh=rkq3DGRe/lPxR2ofGTATmveYcwg0fwOyu3wyKRPEeec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/qlzSmpiCo/gyMimiBkxCXoS9cmsif+sI437kqLTtIWmjLemc9GwbAetxHmBLY1riL5Yd9tyTIpskS540uLj+H7I0PF6pfMAeFnDgH7In4pZo0A0uyeHOJzfA58gHceuaOV40bm2wLvwLbwukK5hldYb3bmEqqkWqaxm3kKB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7H18GmY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7H18GmY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70109af5f70so15041676d6.0;
        Tue, 01 Jul 2025 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389642; x=1751994442; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTazUoyxInDAJ2NwZxhqJI5YRJsIYXcAsvJl7/gp0ws=;
        b=T7H18GmYeHZvRQHbr+4TEGMA0+NpjLyZSOvCDRiaL36Q6aJ5GlgElBA8Zc4yX8wcqS
         UJ5ECshlXwyK3DtOgf0NFGghNmJbwTNASL/XM5guqjrR8xHOubpy7943IArK4K6A4F36
         BFU/LfLpqcVqvPy1D03FuaJGdeunn6sNLNyJm0JQ/TnQuuwygcCzycLdugZyVyMQ0/yr
         Oz+WKdmu8X5uCnFYbOMshttT0RxonpQjdjA4p1YWujyjrQcDmLWHDAUGC/WtbRIu0m5+
         g+vnl9TFZZQ4ioYfTYwTv/I/scj1uEGOgZwZ3ke/FalYpt7qZ3B3S5Elir+Jy9SPiO6P
         u1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389642; x=1751994442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTazUoyxInDAJ2NwZxhqJI5YRJsIYXcAsvJl7/gp0ws=;
        b=XZ5StGdw/EUr2hOgo8HLFjWMmeKbF4Q6Wfui9QXn+Smi8ZvyQGsYAtWF/IfeTOu/PJ
         RXZJ7Rgy1O/FLhliyMzdB+VfGpYasz/AiiUYGhzvjVwWNcVmHUcaYFUtNZM6MtHX9ekl
         gva11ala3PHWGQ0Sf2DUi4wbKRL3vZSGnk4Rmv/ucpb5gw1WoeORxTDqym5xAo5CTsTo
         5xUvG1LeW+jN2zqAkwGDG9qIm6V3kNT3Jkyr52rmbZY6PHCASHqyUM4k55MPBlSF6UlY
         8gYuoHkYKhZQ79Rghm15/1t9XmRClvhVZvN/BZFVgeyJQKApPHjG2n4K4v7M5bqACPtf
         wu7A==
X-Forwarded-Encrypted: i=1; AJvYcCVG58VPtb6WwV7MNGLVwA1zJ58bRm9Ebmv8aRpd8ksmGxO1DYrlso7nIOsjcoVNxlelW6TULw==@lists.linux.dev, AJvYcCVosy7VzhtWxTPhrzGGkGJXXrvfEn+oFXrWJh4+kgzO8MiQAFenMDWS78H5VOh4k0HIXmiFmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjI8MNChAdOgqdfj9iX8iPmF+6HlZ7HC+0F60Mx0STheKv2Rb9
	Us7l/EPBlBVF4Npnp43OnAmLt8/1G7aX7zkI8H/heaf3heqJUihQ5NhcL4YRD9QsXX1dE/JHvmz
	DpXzku4pNdVdQwvHGlJX8mFvwR3IDEC4=
X-Gm-Gg: ASbGncsEWtKkZwZ9/02suEts6/bFl7S8ZgsDdJKtd5Xj+/ILFVIS4kqjemq9z41kFIW
	OoutkisDTRZujeHSaE10ONEOOcKx85tCS3a9lpD1QWDXDRsbjepzoACGWndAUUbTIJVT9R0+SUb
	ldXgoMTPVZ5VcfD/xqGn1Dogj/9NdYnMG8kb1q0wBDyw==
X-Google-Smtp-Source: AGHT+IHOCEIHYgm8k1vptLe8LL1tAI0jytjNx1TpB7ZG4wg2ZutjYESoQ25ENjDT+uRfDdRVBd1/zvyP4q+gP4bjeCU=
X-Received: by 2002:a05:6214:4309:b0:6fa:d956:243b with SMTP id
 6a1803df08f44-70003c8e7ffmr346050926d6.37.1751389641585; Tue, 01 Jul 2025
 10:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <20250701163852.2171681-10-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-10-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 1 Jul 2025 12:07:08 -0500
X-Gm-Features: Ac12FXwp3sKlhUbj28TBsCjjpDbuA__SF55TZQEDUJu-EBlXwc0hooXFiXTAO58
Message-ID: <CAH2r5msN59rNqDxJaBTPZQ_smsYOiMbyy4V+cMdWeuGbe9GR1Q@mail.gmail.com>
Subject: Re: [PATCH 09/13] smb: client: fix warning when reconnecting channel
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, samba-technical <samba-technical@lists.samba.org>, 
	Shyam Prasad <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I already have this patch in my for-next branch (which also includes
the  Reviewed-by from Shyam)

On Tue, Jul 1, 2025 at 11:44=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> From: Paulo Alcantara <pc@manguebit.org>
>
> When reconnecting a channel in smb2_reconnect_server(), a dummy tcon
> is passed down to smb2_reconnect() with ->query_interface
> uninitialized, so we can't call queue_delayed_work() on it.
>
> Fix the following warning by ensuring that we're queueing the delayed
> worker from correct tcon.
>
> WARNING: CPU: 4 PID: 1126 at kernel/workqueue.c:2498 __queue_delayed_work=
+0x1d2/0x200
> Modules linked in: cifs cifs_arc4 nls_ucs2_utils cifs_md4 [last unloaded:=
 cifs]
> CPU: 4 UID: 0 PID: 1126 Comm: kworker/4:0 Not tainted 6.16.0-rc3 #5 PREEM=
PT(voluntary)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-4.fc42 04=
/01/2014
> Workqueue: cifsiod smb2_reconnect_server [cifs]
> RIP: 0010:__queue_delayed_work+0x1d2/0x200
> Code: 41 5e 41 5f e9 7f ee ff ff 90 0f 0b 90 e9 5d ff ff ff bf 02 00
> 00 00 e8 6c f3 07 00 89 c3 eb bd 90 0f 0b 90 e9 57 f> 0b 90 e9 65 fe
> ff ff 90 0f 0b 90 e9 72 fe ff ff 90 0f 0b 90 e9
> RSP: 0018:ffffc900014afad8 EFLAGS: 00010003
> RAX: 0000000000000000 RBX: ffff888124d99988 RCX: ffffffff81399cc1
> RDX: dffffc0000000000 RSI: ffff888114326e00 RDI: ffff888124d999f0
> RBP: 000000000000ea60 R08: 0000000000000001 R09: ffffed10249b3331
> R10: ffff888124d9998f R11: 0000000000000004 R12: 0000000000000040
> R13: ffff888114326e00 R14: ffff888124d999d8 R15: ffff888114939020
> FS:  0000000000000000(0000) GS:ffff88829f7fe000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe7a2b4038 CR3: 0000000120a6f000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  queue_delayed_work_on+0xb4/0xc0
>  smb2_reconnect+0xb22/0xf50 [cifs]
>  smb2_reconnect_server+0x413/0xd40 [cifs]
>  ? __pfx_smb2_reconnect_server+0x10/0x10 [cifs]
>  ? local_clock_noinstr+0xd/0xd0
>  ? local_clock+0x15/0x30
>  ? lock_release+0x29b/0x390
>  process_one_work+0x4c5/0xa10
>  ? __pfx_process_one_work+0x10/0x10
>  ? __list_add_valid_or_report+0x37/0x120
>  worker_thread+0x2f1/0x5a0
>  ? __kthread_parkme+0xde/0x100
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x1fe/0x380
>  ? kthread+0x10f/0x380
>  ? __pfx_kthread+0x10/0x10
>  ? local_clock_noinstr+0xd/0xd0
>  ? ret_from_fork+0x1b/0x1f0
>  ? local_clock+0x15/0x30
>  ? lock_release+0x29b/0x390
>  ? rcu_is_watching+0x20/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x15b/0x1f0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> irq event stamp: 1116206
> hardirqs last  enabled at (1116205): [<ffffffff8143af42>] __up_console_se=
m+0x52/0x60
> hardirqs last disabled at (1116206): [<ffffffff81399f0e>] queue_delayed_w=
ork_on+0x6e/0xc0
> softirqs last  enabled at (1116138): [<ffffffffc04562fd>] __smb_send_rqst=
+0x42d/0x950 [cifs]
> softirqs last disabled at (1116136): [<ffffffff823d35e1>] release_sock+0x=
21/0xf0
>
> Cc: linux-cifs@vger.kernel.org
> Reported-by: David Howells <dhowells@redhat.com>
> Fixes: 42ca547b13a2 ("cifs: do not disable interface polling on failure")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Tested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Steve French <sfrench@samba.org>
> ---
>  fs/smb/client/cifsglob.h |  1 +
>  fs/smb/client/smb2pdu.c  | 10 ++++------
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 318a8405d475..fdd95e5100cd 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -1303,6 +1303,7 @@ struct cifs_tcon {
>         bool use_persistent:1; /* use persistent instead of durable handl=
es */
>         bool no_lease:1;    /* Do not request leases on files or director=
ies */
>         bool use_witness:1; /* use witness protocol */
> +       bool dummy:1; /* dummy tcon used for reconnecting channels */
>         __le32 capabilities;
>         __u32 share_flags;
>         __u32 maximal_access;
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 084ee66e73fd..572cfc42dda8 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -424,9 +424,9 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon =
*tcon,
>                 free_xid(xid);
>                 ses->flags &=3D ~CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES;
>
> -               /* regardless of rc value, setup polling */
> -               queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
> -                                  (SMB_INTERFACE_POLL_INTERVAL * HZ));
> +               if (!tcon->ipc && !tcon->dummy)
> +                       queue_delayed_work(cifsiod_wq, &tcon->query_inter=
faces,
> +                                          (SMB_INTERFACE_POLL_INTERVAL *=
 HZ));
>
>                 mutex_unlock(&ses->session_mutex);
>
> @@ -4229,10 +4229,8 @@ void smb2_reconnect_server(struct work_struct *wor=
k)
>                 }
>                 goto done;
>         }
> -
>         tcon->status =3D TID_GOOD;
> -       tcon->retry =3D false;
> -       tcon->need_reconnect =3D false;
> +       tcon->dummy =3D true;
>
>         /* now reconnect sessions for necessary channels */
>         list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
>
>


--=20
Thanks,

Steve

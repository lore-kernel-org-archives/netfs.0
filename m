Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE826A1AA
	for <netfs@lists.linux.dev>; Wed, 25 Jun 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868474; cv=none; b=f0fzQ35d2+XeaB3ytZt33UTNBA8ST5CGAd4eLe7uDU93ujwmXASz7iTA1l/4oV7ZiSJPFMeaGlQHAamqmZvW/omPpp4x+H/vKEq3i9z4E4TMyW5b6RU4K68DH2s2JSE821eOWMq7uUC091Pw0VjSPlzqBsOHbS1pKzN+RV65pUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868474; c=relaxed/simple;
	bh=XMP6ERBXfxV519EBoe1Y/mZ/m+8At/oi36qL9USyJ5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYbtnXwd9Mesur4GlxAhhbXIFuUtsbCvxb4yneJDE1xv4KCD7qG1jKPzWms5ePlq0HLGC/FHXxC7HZt09+HGFMNAgdjSFk8Z+Xgr33uWeC1mI1W5t9ychwG7qaZqBH76agzyEknW8agz0IvsmHeCwfzeAshgtb6/6tI/5GKPrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V78f8+Jc; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V78f8+Jc"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fac1c60e19so11351606d6.1
        for <netfs@lists.linux.dev>; Wed, 25 Jun 2025 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750868472; x=1751473272; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NVslBr1xkJaej9KYSvp2pb98xkmIaEpx8AR8MBWA3Y=;
        b=V78f8+Jc1HfqyOyHwfPkqiPiqvHwCir+kYk4aQCKtwbG3iqLs7CCrPbNavLRboG72F
         3dK0Qx20QVAokEjIbsgEkuHpq3q/hOX+xAeKpte9QlQWgTeq8Wgod8Hrli7WFjfZE2im
         PMKXrySo/9PIRyMiA9bi+2rtsjEkJpQic5bak7hWFb/Utn+mtyVxV6gUJ8KazNrNpGfM
         3Ft9NYAEK80Y0XnAejOiRAl/2iDNtVulxL5MVwV14F9MVQnIperXYmeFOqLXczoUuzQG
         R/LQy+i2UL7W7Dq1exliLjW5n9HQm8pZT0Wc+R21zpn8b65MOqZbmwYW2vCZgV4/Jmeh
         CZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750868472; x=1751473272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NVslBr1xkJaej9KYSvp2pb98xkmIaEpx8AR8MBWA3Y=;
        b=NBSEN6cBvmjlKX2IlEBZUOWYqjVGfI1Rxjp2nToFY38hDIa7HL5/XNxq5+1usnfTzf
         INs0zdgqZD48OHQDLKR7vvU3vSJfc8+jI4rrqM3pBD3bTV5mefm/1d5eafRJE8K7QNa7
         EfCY5psLEV4w9uEhGH+5yienj7AAmlSVul7aZnRq9ZT8S3hb/ysr0oI7EL8GU1CTokiL
         s726b+7PvHNt1rodACdtyX0j5OOo12zD2Mobd1y+wcwMlHtnxShmu7iDfMeJzYuZi27i
         M2AMQu2Co6x0f9aGa8hcKLKmiKpJPm/t5Xzz+nOZauW44VD136/iVyd75J+8CQASat3T
         opBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYD2KM3ggTo+cRSFMF0ilpitLUS3ALFKXpMDsGXeA0pd3gkH8W88HXYfbPG7iIV4t1yxoIfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/yk24bIfvGJREL6knT6FPpJdBkZsxb3iWiBRZK4aRJCMBre5X
	nNt4ra+RlzQKLUjSUxFeZuPxhxkfw0z6qI++dJxqvkvZFyEG+aFzcW6jBhpfo9MY7F0D4ilPN3A
	L/mHApLnWKjfizK7jOGWBCdf3Ul7cfq5ZvQ==
X-Gm-Gg: ASbGncsviaYRjMK1IsrHY/ANr9Ip5NWfAeO/le/derzVNkpJ8clJEz9B4Q0YsfOprtb
	zVYv1bVSreuXtrSJtBWsA8wKr81zbQoqoqU4G2Nt6eQE+VAZmoZoLqsGg+YczbwWRnqjI5KVElW
	8bqtvhmBqjN9zdsMeAWhBnyL0F4z5B2sV6Rtrn8vKhlpxDlkCc8nxa/7pMF5nQsKYIU9CMFgm3r
	aAN
X-Google-Smtp-Source: AGHT+IF0E2ADWqAWPU392h4IO+FZ/wRsjmuf7c03br6vhyt8kFz6PcUB5E7QjpVnFsCxdOzBZ17XM3vfqbwilSgcRb4=
X-Received: by 2002:a05:6214:419e:b0:6fa:ad2a:7998 with SMTP id
 6a1803df08f44-6fd753a870emr3103946d6.18.1750868472164; Wed, 25 Jun 2025
 09:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1372501.1750858644@warthog.procyon.org.uk> <1382992.1750862802@warthog.procyon.org.uk>
 <011ec23b-d151-4ef8-bbe7-ba79e3678ae7@samba.org>
In-Reply-To: <011ec23b-d151-4ef8-bbe7-ba79e3678ae7@samba.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 25 Jun 2025 11:21:00 -0500
X-Gm-Features: Ac12FXwJI9fijUzybZTm6c-W7y-I5jTYEiHnpSWQL96V5yQo6-_Q8OXO622L3v8
Message-ID: <CAH2r5mtzPKaiOmwQsaSTRWy1YdWygvVBdOPrhLLGbEfNAWXvEQ@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: Fix the smbd_request and smbd_reponse slabs to
 allow usercopy
To: Stefan Metzmacher <metze@samba.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next and added RB and tested-by

On Wed, Jun 25, 2025 at 10:55=E2=80=AFAM Stefan Metzmacher <metze@samba.org=
> wrote:
>
> reviewed-by and tested-by: Stefan Metzmacher <metze@samba.org>
>
> Am 25.06.25 um 16:46 schrieb David Howells:
> >
> > The handling of received data in the smbdirect client code involves usi=
ng
> > copy_to_iter() to copy data from the smbd_reponse struct's packet trail=
er
> > to a folioq buffer provided by netfslib that encapsulates a chunk of
> > pagecache.
> >
> > If, however, CONFIG_HARDENED_USERCOPY=3Dy, this will result in the chec=
ks
> > then performed in copy_to_iter() oopsing with something like the follow=
ing:
> >
> >   CIFS: Attempting to mount //172.31.9.1/test
> >   CIFS: VFS: RDMA transport established
> >   usercopy: Kernel memory exposure attempt detected from SLUB object 's=
mbd_response_0000000091e24ea1' (offset 81, size 63)!
> >   ------------[ cut here ]------------
> >   kernel BUG at mm/usercopy.c:102!
> >   ...
> >   RIP: 0010:usercopy_abort+0x6c/0x80
> >   ...
> >   Call Trace:
> >    <TASK>
> >    __check_heap_object+0xe3/0x120
> >    __check_object_size+0x4dc/0x6d0
> >    smbd_recv+0x77f/0xfe0 [cifs]
> >    cifs_readv_from_socket+0x276/0x8f0 [cifs]
> >    cifs_read_from_socket+0xcd/0x120 [cifs]
> >    cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
> >    kthread+0x396/0x830
> >    ret_from_fork+0x2b8/0x3b0
> >    ret_from_fork_asm+0x1a/0x30
> >
> > The problem is that the smbd_response slab's packet field isn't marked =
as
> > being permitted for usercopy.
> >
> > Fix this by passing parameters to kmem_slab_create() to indicate that
> > copy_to_iter() is permitted from the packet region of the smbd_response
> > slab objects, less the header space.
> >
> > Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> > Reported-by: Stefan Metzmacher <metze@samba.org>
> > Link: https://lore.kernel.org/r/acb7f612-df26-4e2a-a35d-7cd040f513e1@sa=
mba.org/
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <stfrench@microsoft.com>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >   fs/smb/client/smbdirect.c |   18 +++++++++++++-----
> >   1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> > index ef6bf8d6808d..f9773cc0d562 100644
> > --- a/fs/smb/client/smbdirect.c
> > +++ b/fs/smb/client/smbdirect.c
> > @@ -1475,6 +1475,9 @@ static int allocate_caches_and_workqueue(struct s=
mbd_connection *info)
> >       char name[MAX_NAME_LEN];
> >       int rc;
> >
> > +     if (WARN_ON_ONCE(sp->max_recv_size < sizeof(struct smbdirect_data=
_transfer)))
> > +             return -ENOMEM;
> > +
> >       scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
> >       info->request_cache =3D
> >               kmem_cache_create(
> > @@ -1492,12 +1495,17 @@ static int allocate_caches_and_workqueue(struct=
 smbd_connection *info)
> >               goto out1;
> >
> >       scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
> > +
> > +     struct kmem_cache_args response_args =3D {
> > +             .align          =3D __alignof__(struct smbd_response),
> > +             .useroffset     =3D (offsetof(struct smbd_response, packe=
t) +
> > +                                sizeof(struct smbdirect_data_transfer)=
),
> > +             .usersize       =3D sp->max_recv_size - sizeof(struct smb=
direct_data_transfer),
> > +     };
> >       info->response_cache =3D
> > -             kmem_cache_create(
> > -                     name,
> > -                     sizeof(struct smbd_response) +
> > -                             sp->max_recv_size,
> > -                     0, SLAB_HWCACHE_ALIGN, NULL);
> > +             kmem_cache_create(name,
> > +                               sizeof(struct smbd_response) + sp->max_=
recv_size,
> > +                               &response_args, SLAB_HWCACHE_ALIGN);
> >       if (!info->response_cache)
> >               goto out2;
> >
>
>


--=20
Thanks,

Steve

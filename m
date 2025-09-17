Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2C4086A
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115379; cv=none; b=PGK1qtbzn9xUKq+/4HN6YqD+jMACWiV9CXy36Z1rRmrlFSR59jmd2X1IIL20P2l91dcIU5sgZ6x3WhaHNUAg+koqeCtEht0rO2F5RX/1Oa6rayiyMuDkAKSMOqfaWeSTMrIh1CH0Qxr/7+XvDcBGQMIoYCP4ASEd0ucEFpIWnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115379; c=relaxed/simple;
	bh=IXtdj43M5q2Ed5NQe9mn8kcTi6HyJvp+nQtN50y6JwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fvqczsri6EBCQCXFRUROjqSyyn+jDjdSij5uH9hiOW/BsGtvnLmVxaDli+ZbRBO4t25YuU/1AwXhGhX9G6ZPy0EnH128xp+7BsE0rBwE8Lb0R3r7N+9B/NRK5V/ldkdXHnnD+AbZXNog1RV+63mGV3GGm/gk3jc8yoQvp8T58yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/Q3dRuD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/Q3dRuD"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso9717210a12.2
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758115375; x=1758720175; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNei8MHThiloklPU7UxzTmaJV1wQ0pvOzFsJZ+duSAw=;
        b=P/Q3dRuDbJOoQyOy4Ma2i1Q23boDKpPhlIbOFgEkP6Z493jR3/mgETJaAkX3Us5OoP
         rEeyzckuNWi0Yi02TFm9bXFTKisXE1s1cxViV6GGcPIfgLrV9OYNS6hrAkEnM8zKkMTH
         k76oc+zV4Fg7svgnSjxhHKssG5oExSRfkSsIRIWOWeL7ekH6qiSNj3Nqv+rqzG5FK4XK
         ur3AmfVLn11OmhLDHK0RMxL0BGfLZ8x4FbQqJJVEY+UXJni48AC0YlQGy/RAjxl1WpPv
         +qESVR+ZGN6wilzQ9H7kh9vfjOvyY91QGtw8DEntm+IvKztmKFJ9g5RGIEXtnfLfXGep
         Sbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115375; x=1758720175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNei8MHThiloklPU7UxzTmaJV1wQ0pvOzFsJZ+duSAw=;
        b=ZttZutcP+zDDwl09Mi8lh9VAYwEwSamexBSI8RZdYCIYdcJiNk809h1tFQV1jvCkAA
         DtmSvYD3+D3pM0z1j8nNuouQ8/eMVeap9jaXihtU5A8C730pKorMjyBl6Lh+wedj5mla
         E7fXdsxEo5lAXkiHM8aXbsGMA2i9jV6W1uJzayG+fanVJMVZAbFNYRijURWck0dDm1md
         xUDAswlXq0+NGA8kqyTJIUFGr/w7qYDbWGS2JFGniBDxQqujTsh09pdyVpA+s9jQlvag
         caW+n21E+h6XINszFPVipZTgxp6LlRHrEz8KCH/lYtlDFTJBqfplUcXfjHyRDpVMxX+Q
         t5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzsRJj9QROloKWKEOHqZxBJyMs20MbjBo2S1X8HbId/5mvNKwPizx5Vr5N5cxxxTripNSJZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiiM+xrehavzQumJqnbad+1GLuPhkmvPjMmVKwb1m1LVv+O+0T
	1WPN078Qzqbccz3mPdImZ3jsDGWHHn7GJgqKJ7o2bmvjE/LTu3FQXRPXGPWVn+1qfH5cRPXtuqB
	ys/aHXcnU6s7quT0W4EwvDcQn4M/uGyI=
X-Gm-Gg: ASbGncuQGEKRttqeMxSLtxVvvdHMrXM5BBy6xgasDhHj60VxEeXeyvQZ22obXptovau
	wF5Cko4oecPa/YDyhIVe45E92kYEE8ieL5Np8h22Ugdz3hMvcO9Y+lv8VZX+uOnrrZ4z0AwBV3Y
	Bur2NABViNhEs+1u1Y15KFdqaq9hNeNuNaY0OMY8pDzyhVFu6TluWOIsNuOsmoMQ4LOQgUpLXCu
	yB5ZNGxO5lkDg9scYQJeVeloE4YQjaY4LvwsNo=
X-Google-Smtp-Source: AGHT+IH1fnd7pg1OiM+Vful9dVduFaBmJC8BwTm18iho+3iiqRU+5s4WiBnxugsYrfCl+j7st2Br4O7QIh8RDO+5yVc=
X-Received: by 2002:a05:6402:34c2:b0:62f:65f5:a8cd with SMTP id
 4fb4d7f45d1cf-62f84213d25mr2465122a12.7.1758115374571; Wed, 17 Sep 2025
 06:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:22:42 +0200
X-Gm-Features: AS18NWCj5D-vA3jAqNwkPHxdj4sWxauOvPCPJajJmK9sXPHNO63KqrqU8QfOTfU
Message-ID: <CAGudoHHiH+2+LdQGBs8cS4Hr6sDWk6diEG+JQ7HMQbWdiNtKAA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:13=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Sep 17, 2025 at 2:44=E2=80=AFPM Max Kellermann <max.kellermann@io=
nos.com> wrote:
>
> I don't know about ceph internals, so no comment on that front.
>
> > +/**
> > + * Queue an asynchronous iput() call in a worker thread.  Use this
> > + * instead of iput() in contexts where evicting the inode is unsafe.
> > + * For example, inode eviction may cause deadlocks in
> > + * inode_wait_for_writeback() (when called from within writeback) or
> > + * in netfs_wait_for_outstanding_io() (when called from within the
> > + * Ceph messenger).
> > + *
> > + * @n: how many references to put
> > + */
> > +void ceph_iput_n_async(struct inode *inode, int n)
> > +{
> > +       if (unlikely(!inode))
> > +               return;
> > +
> > +       if (likely(atomic_sub_return(n, &inode->i_count) > 0))
> > +               /* somebody else is holding another reference -
> > +                * nothing left to do for us
> > +                */
> > +               return;
> > +
> > +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n",=
 inode, ceph_vinop(inode));
> > +
> > +       /* the reference counter is now 0, i.e. nobody else is holding
> > +        * a reference to this inode; restore it to 1 and donate it to
> > +        * ceph_inode_work() which will call iput() at the end
> > +        */
> > +       atomic_set(&inode->i_count, 1);
> > +
>
> That loop over iput() indeed asks for a variant which grabs an
> explicit count to subtract.
>
> However, you cannot legally transition to 0 without ->i_lock held. By
> API contract the ->drop_inode routine needs to be called when you get
> here and other CPUs are prevented from refing the inode.
>
> While it is true nobody *refs* the inode, it is still hanging out on
> the superblock list where it can get picked up by forced unmount and
> on the inode hash where it can get picked up by lookup. With a
> refcount of 0, ->i_lock not held and no flags added, from their POV
> this is a legally cached inode they can do whatever they want with.
>
> So that force setting of refcount to 1 might be a use-after-free if
> this raced against another iput or it might be losing a reference
> picked up by someone else.
>
> If you got the idea to bring back one frem from iput() in the stock kerne=
l:
>
>         if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
>                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
>                         atomic_inc(&inode->i_count);
>
> Note this guy still makes sure to take the lock first. As a side note
> this weird deref to 0 + ref back to 1 business is going away [1].
>
> I don't know what's the handy Linux way to sub an arbitrary amount as
> long as the target is not x, I guess worst case one can just write a
> cmpxchg loop by hand.
>
> Given that this is a reliability fix I would forego optimizations of the =
sort.
>
> Does the patch convert literally all iput calls within ceph into the
> async variant? I would be worried that mandatory deferral of literally
> all final iputs may be a regression from perf standpoint.
>
> I see you are mentioning another deadlock, perhaps being in danger of
> deadlocking is something you could track with a flag within ceph (just
> like it happens for writeback)? Then the local iput variant could
> check on both. I have no idea if this is feasible at all for the netfs
> thing.
>
> No matter what though, it looks like the way forward concerning
> ->i_count is to make sure it does not drop to 0 within the new
> primitive.
>

That is to say the routine async routine should start with:
        if (atomic_add_unless(&inode->i_count, -1, 1))
                return;
         /* defer to iput here */

this is copy pasted, no credit needed for anyone

As you can see there is some work going on concerning these routines,
I would wager that loop over iput in writeback will go away in
mainline after the dust settles ;)

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries&id=3D9e70e985bdc2[1[1c6fe7a160e4d5=
9ddd7c0a39bc077
>
> > +       /* simply queue a ceph_inode_work() without setting
> > +        * i_work_mask bit; other than putting the reference, there is
> > +        * nothing to do
> > +        */
> > +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_=
wq,
> > +                                &ceph_inode(inode)->i_work));
> > +
> > +       /* note: queue_work() cannot fail; it i_work were already
> > +        * queued, then it would be holding another reference, but no
> > +        * such reference exists
> > +        */
> > +}
> > +

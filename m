Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403231A81D
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114844; cv=none; b=jyIL4oeBXlC7OPIWB7tSBR3QcU5K0JYCX8gz3rRonYDrKO4PdxQjhq9y/TPSKIXEy7kjFkHuH5TSYRjyZ78jyPQZu/Y+zXx7uKRmAiqyu4W5W7oagn1OCeUklbLIwXzL8tui6lY/UP1aMG5oOrthSEcDtaxpdJ8XihEbOb29Rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114844; c=relaxed/simple;
	bh=HfiXVahdmKU9llTpUf4nFKXL5fsS+NIMrnVM7WxbQ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ9RHyTAMDRMKvPHotfwGam+LZxfqb+sHYtZZren7girq8tu8wxFiVFjLtLT35Ca6gYxFY5AMhFqOLZ4mKBUoN1EYAMT9hC88v13YzD1O5W0vDa5CRT6pLRsfyUfDP2DNY5yYiJqPHrYj6uVndhnphYpRerqKpkVT3NYAB2GagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+36RmV8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+36RmV8"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso4033068a12.2
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114840; x=1758719640; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5H63/AUiRra8BoZW6vXEUzxV1wo5MwGIxUp9c3IcVo=;
        b=h+36RmV8Taumvy1oX4KMc519S+IIi3P3v356KylExg06vd9KN4v6uWmSx3Y6vqxvVn
         i6eivCS88VLM1rLVxTtIBpQJry0HWmLNhGPDqVaXvJ0RujSRNB03B7yQUJvB5je4xTur
         ea5AVdgWJsIEQ2katns4iDEqchRsHh5XLlzuGjQZBanHREU2JcJMEDZeI6/A77u/7HD1
         9xVP8t+Hvujl90GaOaMgYuhbCNFuQtr6h/gEuCSH4vTw0lcBYS379N0sL0QLXMYZW3Te
         A5Ks8uEhgrhDHbJw1r7bfvvTjKhFeIkYygljN2QYjdU9s7C3YP9vIYJbNG9aCX8cJXbJ
         9WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114840; x=1758719640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5H63/AUiRra8BoZW6vXEUzxV1wo5MwGIxUp9c3IcVo=;
        b=DSTxNS91lhk7atjWRCKvIsl21PuqbZvVnaqk4VXDMZOqcgrMYy3213aFxwdmXpF8v/
         lVuUfh/iSotx9Roxin9jfJubroc61aUb9KG92YKEOkrmv1UB8XCy+c/ylfbnWH0GKETU
         h6D8CWfQ5eHTOv1m9TcxGm6AXZnLiWAfn9qx2QpRBRywLDL9EHQ/giV/xf8SMWgs1JGV
         Zn2A58QFeF2WsinYAETQj9osXJsTSIhBxb1FAOra/S0DKOtISoFlCsFQpoDzCPk6TD08
         H7GXpEBnwExlsIexJw/t8OEhklfAvabydtEF6UP0jN4yz6nl5005caTl5BiBSuWr9kk/
         gOeA==
X-Forwarded-Encrypted: i=1; AJvYcCXEsqExWVQOdKL8nCHpieY1+DQedZwU/2EwEpbdTaMTHXhKWBr4LHjXtPvMDvXqTo7FIgzHAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHo9+UPrJixp6bXQlcX8tAQLzTgH5mW6laqtuNm9q5ppY23zNm
	Jml3IPley3eckdqJzshA0Woh0PmykyS2+Sk3Todcou9ixwlW0ldqH2sYNEnjIcZ0lPV9u2UBSnr
	w5PmPIoZBSnfSUfztlw+LUdaot2vAnLg=
X-Gm-Gg: ASbGncsPiKSWc1tpHPpA1QXMbvTzgqj+hicsqIQuOvatGbQiZY4y/IPSBNZ3XWEFalG
	s4cfi8U6oSi+bkp3TTLYgoemNvDsRUoecZroXOuZAPLnlUa4Z24++39x8WLXBkSRXV/Bk52gpnJ
	KAqBx+wMleKTa5PSBq5h9mmcmDmP9HVoQWvBHNjt7iLdD3vnyZkVHBOUlNt3yegzx9al5SJQE4X
	cbKR0VCPOXabXoe2ZSogkJW7vRpC2OHL1RTd+s=
X-Google-Smtp-Source: AGHT+IHZqG7bIkkgFnNnamLc+d2ib1zkjvzaCKTtDXUUOD25WDP7oC1jkuiVQ7lPHR9J6yOsbhbl9bqd49wGef5FN+U=
X-Received: by 2002:a05:6402:5c8:b0:62b:63f8:cdbb with SMTP id
 4fb4d7f45d1cf-62f8444b4ecmr2100800a12.25.1758114839438; Wed, 17 Sep 2025
 06:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
In-Reply-To: <20250917124404.2207918-1-max.kellermann@ionos.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:13:47 +0200
X-Gm-Features: AS18NWAAFc83ppVkA4fnw2IGGyxvDdDuE0G3TJ0kjzGRSMkmIKZ5yfl7jNQoS8Q
Message-ID: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:44=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:

I don't know about ceph internals, so no comment on that front.

> +/**
> + * Queue an asynchronous iput() call in a worker thread.  Use this
> + * instead of iput() in contexts where evicting the inode is unsafe.
> + * For example, inode eviction may cause deadlocks in
> + * inode_wait_for_writeback() (when called from within writeback) or
> + * in netfs_wait_for_outstanding_io() (when called from within the
> + * Ceph messenger).
> + *
> + * @n: how many references to put
> + */
> +void ceph_iput_n_async(struct inode *inode, int n)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_sub_return(n, &inode->i_count) > 0))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +
> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* the reference counter is now 0, i.e. nobody else is holding
> +        * a reference to this inode; restore it to 1 and donate it to
> +        * ceph_inode_work() which will call iput() at the end
> +        */
> +       atomic_set(&inode->i_count, 1);
> +

That loop over iput() indeed asks for a variant which grabs an
explicit count to subtract.

However, you cannot legally transition to 0 without ->i_lock held. By
API contract the ->drop_inode routine needs to be called when you get
here and other CPUs are prevented from refing the inode.

While it is true nobody *refs* the inode, it is still hanging out on
the superblock list where it can get picked up by forced unmount and
on the inode hash where it can get picked up by lookup. With a
refcount of 0, ->i_lock not held and no flags added, from their POV
this is a legally cached inode they can do whatever they want with.

So that force setting of refcount to 1 might be a use-after-free if
this raced against another iput or it might be losing a reference
picked up by someone else.

If you got the idea to bring back one frem from iput() in the stock kernel:

        if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
                if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
                        atomic_inc(&inode->i_count);

Note this guy still makes sure to take the lock first. As a side note
this weird deref to 0 + ref back to 1 business is going away [1].

I don't know what's the handy Linux way to sub an arbitrary amount as
long as the target is not x, I guess worst case one can just write a
cmpxchg loop by hand.

Given that this is a reliability fix I would forego optimizations of the so=
rt.

Does the patch convert literally all iput calls within ceph into the
async variant? I would be worried that mandatory deferral of literally
all final iputs may be a regression from perf standpoint.

I see you are mentioning another deadlock, perhaps being in danger of
deadlocking is something you could track with a flag within ceph (just
like it happens for writeback)? Then the local iput variant could
check on both. I have no idea if this is feasible at all for the netfs
thing.

No matter what though, it looks like the way forward concerning
->i_count is to make sure it does not drop to 0 within the new
primitive.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries&id=3D9e70e985bdc2[1[1c6fe7a160e4d5=
9ddd7c0a39bc077

> +       /* simply queue a ceph_inode_work() without setting
> +        * i_work_mask bit; other than putting the reference, there is
> +        * nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}
> +

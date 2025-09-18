Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B00A31
	for <netfs@lists.linux.dev>; Thu, 18 Sep 2025 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153908; cv=none; b=BK8052rKuBrJRwc6UqKLEiJ7GyTutBH1dxMsjaX+IZ8kpw3hCM/dET2tIZV7czzPbgT0fpHpSUb0y9dEmVAeAr0wbMeXr4Qz1f4J1vGVCr2q20+TDfmmWrrAqfnipEk//ZH7WA3/wpHrLeI5VWUGM82lU/ujaaat1kpF8UPdqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153908; c=relaxed/simple;
	bh=/60HjsF5kDxVQb13pIAAZhD9mjEiPULAqqfFawaT56Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDlEpdVXcwtgISgN1oLNowpdC7aJ++iNgvck6TEFtACkBsFdM7KD5rZe23BbjPlKLyH8l757J0TkTkYTQqJuQZFQ1At9V2ssMaOZRP9geOdGL5y9qCjFk+AGgULiWlhKdSoToYTiEqpHJOwN9jTcazFU68kVhkdV9PwulLzEc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBXzOkVL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBXzOkVL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so499021a12.3
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758153905; x=1758758705; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7rBzal2frbQpnRlW30Mxkh3elZt0aXaSIdElcYyVLY=;
        b=aBXzOkVLpAGoxZXEUAv3Rxlf7uCBc+gTGlwvjwrxHArS+AhsUTp0m55zXz3nRI9OUn
         SSzyOSCn6AemmB0IhOZ+0jCwYIDCEWUT4K1FsZG3kpIiaF04YMoYDvlyWiznhyldzicM
         s5a4QZbk5hvJrxGCyysAMv+pLPzBUuDifgqWDI7u3l9ZSl6FZ52GGMv0wQnlegikO1PL
         BbSZzjJVwyJTP7CZlvCfvU0IHP7yWrUeVeuh1UYNLwKc9hXqVCRoalU44jY6j/sfgjz5
         AaartFE6AGFWlc/Agq9lB6ZtsHc8QRGdUZp8aq6yBkUIl6rsWR91cdydm1Jbo3LfyVpp
         xztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153905; x=1758758705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7rBzal2frbQpnRlW30Mxkh3elZt0aXaSIdElcYyVLY=;
        b=wlvYvayToV7P/WR7zfpo3+JRAWZMmH52c7VQzF+x1a4HAYLhbOIYPHEj/hXD7osLm3
         E4SWSKyciTcg7alquZ3+CpGR94NS8hJS7gseaAfXttDBC0orDalk5yIQev805wRbK/mR
         n93tW9KPXr//v4jwVYDWgZ+dpM6abUtNOwSoNv38w0Nn99HHAXlW8AVTZ70tKP0EPG+L
         iu9hxdwuWnbWXZVszomxq2ql7v6kponjMcFVpgwZpzlk5hDaKT8wgpcgiu4a716cBkdv
         xPxQxvsX1/8J7W+yA5uDHDkj1rE9xqiPXNQJWaxpnKPa55xI9LtVIevrVY3r8urnTy3c
         xHfA==
X-Forwarded-Encrypted: i=1; AJvYcCU0dKSYaUfUTT/XUKe5llOJdFBwl8CkiVlM0mxFGGGW6TW3859aBQS/t+LntbHBClb8aVcvGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8MJNqxa6ngXSADuljEwYaBxKqdGfb3CUmr9dkQ7iIyAu6artP
	ixjunKYH7k02q53dJojtKpljC0H8dv379+8O7efmZDTIkn399YmwBvIIt0bXDLyFwf+PKAgnYsZ
	ync4CJpQxJVFuROs57D/OVSNjmxyngGM=
X-Gm-Gg: ASbGncuSN+sIHroRS5Dqfhf9aIkLBPC7bzSVsS753TrNQulGwK3WE7X/YinZkFBr0EY
	CJvehAHE94o93RX898nVcSBEnHcgD/NbzQa34KMzFf0t402GquEDT3RnsYohrq3YK4JC9ENBnNk
	NRyCuRD3sV59yYb9uk+YLZm8ZldVOycEtWUl+nHFv0oTfUpsEjAUzzT7QXw4kNeiKDO/bK7cUj0
	E0ZS1vYq5+AsB6ckxeqbs9/ADULRtIpfgi8LuLszeesytyffebLXSOiLA==
X-Google-Smtp-Source: AGHT+IEG0rY/6zoPQ0V4J9TEMxL5qWtyUtLwQjBHHbE0kU7UOpID9Vbuyc6wLRhaE+GAd8+JbDeWJnkobCY95bQb0m8=
X-Received: by 2002:a17:906:eec3:b0:afe:e9ee:4ae0 with SMTP id
 a640c23a62f3a-b1bbb7425fdmr420216666b.59.1758153905204; Wed, 17 Sep 2025
 17:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area> <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
In-Reply-To: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 02:04:52 +0200
X-Gm-Features: AS18NWA8wIEg-rpkslqLzmFrp09CSxzRRbJVlRWEvQeLl_2xapCCNgyg1L-JlpY
Message-ID: <CAGudoHEpd++aMp8zcquh6SwAAT+2uKOhHcWRcBEyC6DRS73osA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com, xiubli@redhat.com, 
	idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:08=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.co=
m> wrote:
> > - wait for Josef to finish his inode refcount rework patchset that
> >   gets rid of this whole "writeback doesn't hold an inode reference"
> >   problem that is the root cause of this the deadlock.
> >
> > All that adding a whacky async iput work around does right now is
> > make it harder for Josef to land the patchset that makes this
> > problem go away entirely....
> >
>
> Per Max this is a problem present on older kernels as well, something
> of this sort is needed to cover it regardless of what happens in
> mainline.
>
> As for mainline, I don't believe Josef's patchset addresses the problem.
>
> The newly added refcount now taken by writeback et al only gates the
> inode getting freed, it does not gate almost any of iput/evict
> processing. As in with the patchset writeback does not hold a real
> reference.
>
> So ceph can still iput from writeback and find itself waiting in
> inode_wait_for_writeback, unless the filesystem can be converted to
> use the weaker refcounts and iobj_put instead (but that's not
> something I would be betting on).

To further elaborate, an extra count which only gates the struct being
freed has limited usefulness. Notably it does not help filesystems
which need the inode to be valid for use the entire time as evict() is
only stalled *after* ->evict_inode(), which might have destroyed the
vital parts.

Or to put it differently, the patchset tries to fit btrfs's needs
which don't necessarily line up with other filesystems. For example it
may be ceph needs the full reference in writeback, then the new ref is
of no use here. But for the sake of argument let's say ceph will get
away with the ligher ref instead. Even then this is on the clock for a
different filesystem to show up which can't do it and needs an async
iput and then its developers are looking at "whacky work arounds".

The actual generic async iput is the actual async iput, not an
arbitrary chunk of it after the inode is partway through processing.
But then any form of extra refcounting is of no significance.

To that end a non-whacky mechanism to defer iput would be most
welcome, presumably provided by the vfs layer itself. Per remarks by
Al elsewhere, care needs to be taken to make sure all inodes are
sorted out before the super block gets destroyed.

This suggests expanding the super_block to track all of the deferred
iputs and drain them early in sb destruction. The current struct inode
on LP64 has 2 * 4 byte holes and llist linkage is only 8 bytes, so
this can be added without growing the struct above stock kernel.

I would argue it would be good if the work could be deffered to
task_work if possible (fput-style). Waiting for these should be easy
enough, but arguably the thread which is supposed to get to them can
be stalled elsewhere indefinitely, so perhaps this bit is a no-go.

Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAAE23D28B
	for <netfs@lists.linux.dev>; Thu, 18 Sep 2025 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160279; cv=none; b=S2AHUejrxeQaB6u9FngEekwvp7evXkIVUx8+WUhJ3Dw44y7SpdogXyatVWk1KFwAgV/YVlcLoRUR83nDxjPZ+EDYlojQKeQEgamRsOk59gjMMxkhOiavhAryyvBp7jeMNr7ciSmXKL09hbBNgMLSs1xd2DOrVk+bxSPWrp6tsiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160279; c=relaxed/simple;
	bh=JJEQS/0s/lxRSz7OqGZhxNFVh06XY8f/nYaXfPxYXkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GET4i82OUkpkF0wNZagywkNtJ5DR9K0k3HlLjNZYMlm8HIUVXqVaLdY45dssK4sCv6uXWKP+LgIIKo/Z1y3UaT+kyh6YtT2c3obIKYCsglX3Mu42fOddwjh7cemPqOJox0qamnEzMS6rovG02o6De9zh73NwVwU/LWdBgs1ADbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jJpjycw+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jJpjycw+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26060bcc5c8so4155105ad.1
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758160277; x=1758765077; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mPKC9h93ZO0Pkb3BaJcs9twO0UNXFk3n4QtX4kuiljM=;
        b=jJpjycw+BOzIk4TiejYvvDzLaiT4IqVIUVk+lR7xM/9KWQnMxs2N9Ipmzx78qfY3Bt
         mQ6vR8xnmAElo+0ZvJUQPxSm1agTnCqxel/WLgoeL20F4vWMIpTS/IrJCfZ64aeAxMyW
         XtlU0HszTUQHEa+3MgyLnpgfZumnxkptXL9i/KP66AqDk1bEDIMMKZnsuOUd36yd6ljB
         qYlALznfzxEJnMo76Ft23fFzzN7F0aCDZulRi9RwDz10NST9dKxORrL2NCGvak5ed+aH
         g1wj8oURXXsy1tsvQnVA3lQNvFb09o+/tJP5AaZk2XkieyknecRjDL4vH4PsBZYvHB1Q
         T5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160277; x=1758765077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPKC9h93ZO0Pkb3BaJcs9twO0UNXFk3n4QtX4kuiljM=;
        b=Vv9HguX67ocQ2udyqiB33c50JoGcWx1UiRkXtGRm4INuYYcakRRVSsdbChb05jTb32
         w81saWSqEgFqescE40R0r/jYRXDFaPgvP09t3ZXm4dryZLoOPBWvxjb90F6QxnnhYb1v
         l1Y/sxEzsjz9HZX7fu2b8eIPiD4QAERi92ZFgrA9rgG8jz6t4vSS/F8i9OlzAvRHlcjw
         AUCNZVtlJWlDX/P8ilZqdUvRLAzH4qasZspFYvky2bqQL2uz2Eot2ybr1bKvuiz4KwLU
         mdRCteZmE26BMXvb1uKKJ13cVAAn5ctNyuLyElRu6hRNS7igPdDMTZRkoVmd/hNbduA9
         rn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOGFrVtiiGBIKJ6A6AUTJIH35MqqDrddiE3xz+xLRAXlWs8DYxPmSzinPGyNazq15f7tKOxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfVlORuy3b8sJ4Nh/+7fPLQ0PY/SrwK+tUaxVda0kiKssr6Pd2
	Dz4Xe5fmV1L8+o+lgvUQQ0wVKlJVmO/5K2lDgrLEA699in+qRDi+XTdorWj9rwybJ2E=
X-Gm-Gg: ASbGncuKNr2ECaIa5dp5MbiwH3A/qAVrhRw7ONwJ9qY4CDklynhiFcgJ0VtVYA6Gxm4
	12JpVSdKHTeRmGi35TOS9P5ILI+uS8SxaJx0RNsFhOXf+D/JgvuUhkuuyxKcoRTqm5f8uAnzVDj
	qbvc1M7pDVJaNFUQWN1b+kBI3Mw6hsvzuzMSiuEbkVySyp6PT4C9G+bbXG0OjG4N5b+uFR9uIYW
	3eYW5bgCvLHHNwFk44TrD5/VzkdltDk1RKTvWOY1CDWZfBu/oTMtg+2hBkt8nUyLFxMp2w3jQVR
	oxB7O3EjkHU5ZiVigoVjiVZ9gnLhtIGPzPoqdIvbNU8+WPIlxcwy8z1e/vgLRePLwEAivhSQhC0
	DylS6Sr3VJMke3tP3sx782y31p6ekaTJBXoNM/9d6t4YReMO6/bj4ReSDI80VekEhrekhV0F2n9
	1UAJ0/sO7nPnJOSxRQ
X-Google-Smtp-Source: AGHT+IEQEMLF+AkQCKrFjQMCt++VkC31OVf4qYwYO2fibK0/OyoVi+36lHzSsrG8E1/bpbzbmm4DtA==
X-Received: by 2002:a17:902:e74b:b0:262:9ac8:610f with SMTP id d9443c01a7336-2681216b6cbmr53522805ad.22.1758160277042;
        Wed, 17 Sep 2025 18:51:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e14f1sm8241685ad.71.2025.09.17.18.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:51:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uz3nm-00000003LsE-1BF9;
	Thu, 18 Sep 2025 11:51:14 +1000
Date: Thu, 18 Sep 2025 11:51:14 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com,
	xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com,
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls
 asynchronous
Message-ID: <aMtlknQpc3NRNSfH@dread.disaster.area>
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area>
 <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
 <CAGudoHEpd++aMp8zcquh6SwAAT+2uKOhHcWRcBEyC6DRS73osA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEpd++aMp8zcquh6SwAAT+2uKOhHcWRcBEyC6DRS73osA@mail.gmail.com>

On Thu, Sep 18, 2025 at 02:04:52AM +0200, Mateusz Guzik wrote:
> On Thu, Sep 18, 2025 at 1:08 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 12:51 AM Dave Chinner <david@fromorbit.com> wrote:
> > > - wait for Josef to finish his inode refcount rework patchset that
> > >   gets rid of this whole "writeback doesn't hold an inode reference"
> > >   problem that is the root cause of this the deadlock.
> > >
> > > All that adding a whacky async iput work around does right now is
> > > make it harder for Josef to land the patchset that makes this
> > > problem go away entirely....
> > >
> >
> > Per Max this is a problem present on older kernels as well, something
> > of this sort is needed to cover it regardless of what happens in
> > mainline.
> >
> > As for mainline, I don't believe Josef's patchset addresses the problem.
> >
> > The newly added refcount now taken by writeback et al only gates the
> > inode getting freed, it does not gate almost any of iput/evict
> > processing. As in with the patchset writeback does not hold a real
> > reference.
> >
> > So ceph can still iput from writeback and find itself waiting in
> > inode_wait_for_writeback, unless the filesystem can be converted to
> > use the weaker refcounts and iobj_put instead (but that's not
> > something I would be betting on).
> 
> To further elaborate, an extra count which only gates the struct being
> freed has limited usefulness. Notably it does not help filesystems
> which need the inode to be valid for use the entire time as evict() is
> only stalled *after* ->evict_inode(), which might have destroyed the
> vital parts.

Not sure I follow you - ->evict_inode() comes after waiting for
writeback and other VFS operations to complete. There's nothing in
the VFS eviction code that actually blocks after ->evict_inode() is
called.

> Or to put it differently, the patchset tries to fit btrfs's needs
> which don't necessarily line up with other filesystems.

Yes, that much is obvious, I think it will be difficult to use it to
replace any of XFS's custom asynchronous inode cleanup code at this
point in time...

> For example it
> may be ceph needs the full reference in writeback,

IMO, we should always hold a full reference in writeback, because
doing so addresses the underlying eviction vs writeback race
condition that exists. i.e. we currently handle the lack of
reference counts in writeback by blocking on I_SYNC in eviction to
prevent a UAF.

If we have an active reference for writeback in the first
place then eviction doesn't need to block on writeback because, by
definition, we cannot be performing writeback and eviction at the
same time....

> then the new ref is
> of no use here. But for the sake of argument let's say ceph will get
> away with the ligher ref instead. Even then this is on the clock for a
> different filesystem to show up which can't do it and needs an async
> iput and then its developers are looking at "whacky work arounds".

Right, that's because we haven't addressed the underlying problem.

That is, we need to hold the right references at the VFS level such
that filesystems can't drop the last reference to the inode whilst
high level VFS inode operations (such as writeback) are in progress
on that inode.

Done properly, eviction can then be done asynchronously for all
inodes because we've guaranteed there are no active or
pending active users of the inode....

.... and at that point, all the custom async inode garbage
collection stuff that XFS does goes away because it is native
VFS functionality :)

> The actual generic async iput is the actual async iput, not an
> arbitrary chunk of it after the inode is partway through processing.
> But then any form of extra refcounting is of no significance.
>
> To that end a non-whacky mechanism to defer iput would be most
> welcome, presumably provided by the vfs layer itself. Per remarks by
> Al elsewhere, care needs to be taken to make sure all inodes are
> sorted out before the super block gets destroyed.

Yes, but first we have to get the reference counting right, such
that inode eviction only occurs after we've guaranteed there are no
other active users of the inode. Page cache residency and dirty
inodes are still in active use, we should account for them that way.

> This suggests expanding the super_block to track all of the deferred
> iputs and drain them early in sb destruction. The current struct inode
> on LP64 has 2 * 4 byte holes and llist linkage is only 8 bytes, so
> this can be added without growing the struct above stock kernel.

Right, we already do this lockless llist based async garbage
collection under ->destroy_inode with XFS. 

> I would argue it would be good if the work could be deffered to
> task_work if possible (fput-style). Waiting for these should be easy
> enough, but arguably the thread which is supposed to get to them can
> be stalled elsewhere indefinitely, so perhaps this bit is a no-go.

If the reference counting is right, nothing expect a new lookup on
the inode should stall on an inode queued for eviction...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

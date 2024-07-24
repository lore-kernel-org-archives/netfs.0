Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2D12E5B
	for <netfs@lists.linux.dev>; Wed, 24 Jul 2024 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784902; cv=none; b=dfA5KdxkqQDd1H1T11UcELXSFR8QMJ/f0nRjXa3bmI3B63ixWpWvxSuO+QKLkF0QadAWpiVra7cRAgasv9bMY6sapjmm1etQM8YFggEwh4NJZrGCDYiDyxlH20cJuLPSxeb5BqoUtBidm/jWwjQVwUVwYmf+iuphPa2UvhNfNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784902; c=relaxed/simple;
	bh=Oyyg+ReOchMwd+NZy24LdIINkgJ0x8GX4pTvKgw82Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQBewmX+7/mesMzgMiZ8drNF8Aj0XVgSTSa0btIZIdqzqFfeHLEGVeV1w8gsIk38sqMGpJro3Gl+ztoGyJ7OaLh8uf89MbZ9SUielSUJXfYcwfIW5EKBoH405UYAUKUlAo8hjDw8m0vtbkxrWf2hWToAi7AXxMyqKHgw29s9SvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XLYOuW8H; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XLYOuW8H"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-708e75d8d7cso3531446a34.3
        for <netfs@lists.linux.dev>; Tue, 23 Jul 2024 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1721784900; x=1722389700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgLCl6dX6lWPw/0VkbIOMrO8TcbOiQmYCM+eTQ4uubs=;
        b=XLYOuW8HIfDH8O8v30cPGsSf2HHesyr1dZ2jOh4jRbEhnYp4Gn7riw05JoBwMxqfDi
         rBTUANSMSsD0To5gEWkQSd34yRhr0xJJcKqETonbTuNsoHMD++eHzhubxMCS2jtKQaCT
         gXCdYeSfIJzb55GpUdg4V6ZMhHnArb1mdJn1BVx1cdgkrR32M5hcpH/TTc25GjWypBMS
         OJLSxbd0UgoNIZgEE8QT+MCISooserkX4i/O0iBPpxqcaiTB5/ItnluX+KZBXTTdcoBX
         7I9ilmn+4tsSWCGKi86cMgqkXruzKhL5lRXHYZr8vgHqe0CPD3EvYMO2t7/TfHD8kCQN
         +Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721784900; x=1722389700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgLCl6dX6lWPw/0VkbIOMrO8TcbOiQmYCM+eTQ4uubs=;
        b=ks1qOJujiMbLwqYeTQIWvbMsPJSPnpWkMeKXU7byCewnmXJS+TgEwncW6kdeuOAFt/
         Fx32OX6Efd5Kszk47TPGwUscnvPuakWgFShLWF7TMNpNor8jKd3NPd63ATeW0uPREBL1
         XnHZRSZgf2jl7zfOEfuG3IFsIe/hiUcK/1zdue8LqHGn6BMsFdaYokJ2l8ATEKGpQ/Go
         oNin6ZDyFJxYkv7zurAobT+pG7LAqcDBTukPZsRoPlK/03sk1zhuKTlKtHZr1vLWQ+C1
         CfSw83fExMKEKgv3dj1U3tTM70Y3BFq9NHtR4Z5uOi/k7MEakE9t95Jr1TonENYtOq+C
         HDzg==
X-Forwarded-Encrypted: i=1; AJvYcCXQdwl9isi8exjr9xyRON8MhugFmoAz1iOuZEpcFlLbVZ02n/ZFYHFWZT1OmUHjUg0M/jnsEWE+WbvoxWVXN5tYjnnxCEI=
X-Gm-Message-State: AOJu0YzOff5zZKQQGXGPGf7Igvp2EJucIXVGMZjOrjYW1ZpnI+VMYjps
	1FM3yMKhwYvrsQEAI2cRCbJX6Xo4nJlI5IDzHMNU7NqxJAbpEi9jNRz6cBbO8Go=
X-Google-Smtp-Source: AGHT+IGrgiMmxeNAbEwss35kPfOGl5/tmfkncr/e5mJYcy66/Rdj0joepPVI5re+d+ypl9k1ZUALDg==
X-Received: by 2002:a05:6830:7316:b0:703:6434:aba8 with SMTP id 46e09a7af769-7092518c2f7mr731676a34.0.1721784899996;
        Tue, 23 Jul 2024 18:34:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2a535f88sm4001440b3a.19.2024.07.23.18.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:34:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sWQu9-0098ej-0k;
	Wed, 24 Jul 2024 11:34:57 +1000
Date: Wed, 24 Jul 2024 11:34:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <ZqBaQS7IUTsU3ePs@dread.disaster.area>
References: <2136178.1721725194@warthog.procyon.org.uk>
 <20240723104533.mznf3svde36w6izp@quack3>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723104533.mznf3svde36w6izp@quack3>

On Tue, Jul 23, 2024 at 12:45:33PM +0200, Jan Kara wrote:
> On Tue 23-07-24 09:59:54, David Howells wrote:
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  6.10.0-build2+ #956 Not tainted
> >  ------------------------------------------------------
> >  fsstress/6050 is trying to acquire lock:
> >  ffff888138fd82f0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_fault+0x26e/0x8b0
> > 
> >  but task is already holding lock:
> >  ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x165/0x250
> > 
> >  which lock already depends on the new lock.
> > 
> >  the existing dependency chain (in reverse order) is:
> > 
> >  -> #4 (&vma->vm_lock->lock){++++}-{3:3}:
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         down_write+0x3b/0x50
> >         vma_start_write+0x6b/0xa0
> >         vma_link+0xcc/0x140
> >         insert_vm_struct+0xb7/0xf0
> >         alloc_bprm+0x2c1/0x390
> >         kernel_execve+0x65/0x1a0
> >         call_usermodehelper_exec_async+0x14d/0x190
> >         ret_from_fork+0x24/0x40
> >         ret_from_fork_asm+0x1a/0x30
> > 
> >  -> #3 (&mm->mmap_lock){++++}-{3:3}:
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         __might_fault+0x7c/0xb0
> >         strncpy_from_user+0x25/0x160
> >         removexattr+0x7f/0x100
> >         __do_sys_fremovexattr+0x7e/0xb0
> >         do_syscall_64+0x9f/0x100
> >         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> >  -> #2 (sb_writers#14){.+.+}-{0:0}:
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         percpu_down_read+0x3c/0x90
> >         vfs_iocb_iter_write+0xe9/0x1d0
> >         __cachefiles_write+0x367/0x430
> >         cachefiles_issue_write+0x299/0x2f0
> >         netfs_advance_write+0x117/0x140
> >         netfs_write_folio.isra.0+0x5ca/0x6e0
> >         netfs_writepages+0x230/0x2f0
> >         afs_writepages+0x4d/0x70
> >         do_writepages+0x1e8/0x3e0
> >         filemap_fdatawrite_wbc+0x84/0xa0
> >         __filemap_fdatawrite_range+0xa8/0xf0
> >         file_write_and_wait_range+0x59/0x90
> >         afs_release+0x10f/0x270
> >         __fput+0x25f/0x3d0
> >         __do_sys_close+0x43/0x70
> >         do_syscall_64+0x9f/0x100
> >         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This is the problematic step - from quite deep in the locking chain holding
> invalidate_lock and having PG_Writeback set you suddently jump to very outer
> locking context grabbing sb_writers. Now AFAICT this is not a real deadlock
> problem because the locks are actually on different filesystems, just
> lockdep isn't able to see this. So I don't think you will get rid of these
> lockdep splats unless you somehow manage to convey to lockdep that there's
> the "upper" fs (AFS in this case) and the "lower" fs (the one behind
> cachefiles) and their locks are different.

Actually, that can deadlock. We've just been over this with the NFS
localio proposal.  Network filesystem writeback that can recurse
into a local filesystem needs to be using (PF_LOCAL_THROTTLE |
PF_MEMALLOC_NOFS) for the writeback context.

This is to prevent the deadlocks on upper->lower->upper and
lower->upper->lower filesystem recursion via GFP_KERNEL memory
allocation and reclaim recursing between the two filesystems. This
is especially relevant for filesystems with ->writepage methods that
can be called from direct reclaim. Hence allocations in this path
need to be at least NOFS to prevent recursion back into the upper
filesystem from writeback into the lower filesystem.

Further, anywhere that dirty page writeback recurses into the front
end write path of a filesystem can deadlock in
balance_dirty_pages(). The upper filesystem can consume all the
dirty threshold and then the lower filesystem blocks trying to clean
dirty upper filesystem pages. Hence PF_LOCAL_THROTTLE is needed for
the lower filesystem IO to prevent it from being throttled when the
upper filesystem is throttled.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

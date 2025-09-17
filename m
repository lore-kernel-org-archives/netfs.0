Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802430B500
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149470; cv=none; b=FjgWyio/Dpt6NBoTCbLEOQHSVlU206sGjFT0o1L0DzMURNca40gIXX7yRtKo+ZsYwnhetVLKqIUG9rJ1eOwx06xe+PCVuTJ/vx7rEWsCp0XkJEngSSW8QkZ/rH4FNs6B0IoJiOVH0Q/HT1OEam3jfu63sZUDiMUzu58qSGLmtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149470; c=relaxed/simple;
	bh=uXQN6FSQJnpjKMExP2GtxNzt35X+QqvTVhfhqwNmWL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyswBoH45v6F7vbHA81zwQkQqMI3mK3/fheTKXC5QAopEzP++d3YgOmuHFk+fQ+oFPOCrcvh5FAH5H35C/qZNabxzAZMNFw8D4XXhBcQ4KZrE4D1+VZdnFObUWFd+4SIde0kv7zIM621VdeN37xrkD/SR3QG0TwVbaiztH4o1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Gt40Nchk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Gt40Nchk"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77d37d71967so39833b3a.0
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758149468; x=1758754268; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiBmD6NJZU/wz6ZMowNVOrSIvY548tKi0Wxl6W6YNg4=;
        b=Gt40NchkV3vwfFLbb6UJfaLsFA4bBew/5FvQSDwpmqrB2EDvx/J11QNwO1BldC7fcg
         lodZWYZOzpPwQJMwicqUoQHn508kfuQxeOSRWF/Er53Y1+RzXHlIQ7UPek20/KRVPSuB
         EawnNkx/tuwE0jftwd4dCPkXC8v8taJbizJ7pOiyPAwMlw3+KFXnAUazC5yy4kxiDDdo
         iBx5DG8CeIafk8JzDvqGv/t7mNo5CrLsoM9NIWnheKkwZQNXN7neC3wOiYMtvZni52Ud
         PZhtcIJ5IMA1RJvmQho9YRrmATyK4xURV8n8Qea1mHaXTZ2zDRb4KUayLzAxYV69CFIi
         Iptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149468; x=1758754268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiBmD6NJZU/wz6ZMowNVOrSIvY548tKi0Wxl6W6YNg4=;
        b=Xojs/XPivjA79tE2+qiu6mEdH7b2RQmWjpeFqbS7gwsJj1OrbouQBvCiEgCaPosctj
         seezpGNhO0+1vfatx+bpVMUXmBpH7kRm2QCS+TVOZvJ1p5YxFCDfYyT126n7Fn120Q68
         BO43UWx6WEgoyMfs2v9v+OtmmjyQ+/f+d8XUKiVQRTNRMXK7smQKiZoK4LYRzuAChavh
         EcUtWdSm6Bcn7Pi4antIjACU/pgBDPq+BaFbQTTnNnWvFD9gi9a+QriXi9E6CvogG+0L
         BzELIGa8tt7cXYkdUdWHB0T9eh8lz7bQSDxY5pO6lCk5TeQ0xbMvchzHAUoKp2uXpIEi
         0Dng==
X-Forwarded-Encrypted: i=1; AJvYcCUN/syhE/bEsHJwh6BOwKvGAjwAUhpP3ny6GpJdqnpX2szW0QLnTMiojXx+Y8aXnAZiLTSy4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT8O2e/0HwFpBcVmbkqArLpCoFOYkM3muzW2lT3e0bVG2tBeQv
	XPYdb7xM7nnwDtPmsGCRZptQCytCudAVXivbWoslooiJqDsu+P6evp0sQIbGVHp+xqA=
X-Gm-Gg: ASbGncvKVJ8mvjep9v7p30eM4wj62FGOyMzwKfbVUjMKnEsQY4o4b2llkHx1fKa6e01
	iTd3NM6z/HQ2eaFu+PXqzRbfdJuYRRk3M6kNbyJlGqMmI1JY17XoC/TgBgjaQf5xnCOoP2W/lua
	e9x3ockK1PEms9OiYtfPmAjgx1i7l/72HfZLEorwB1iOy9c8Nr50QS4UoknpET4bLWcZ4Lqvxi1
	8XGMD0+05H5Z4SqpkIMJcmvipNr2IYxpFIpexjSLmtXei0lK7tMbYMYr0Kzf+PHaac0d11sSKuW
	SgrB9EBVDD0Y+1nx0Nk0rN1mptteoinnFEY4V1SkKLLS+xeoJAZbO8o5hfHoVYo78x441iRyUwQ
	nkimEjP9BUnGY5tJOKwaWv6RTuBTizvDqYKIlOzQP2AyWhB6BkvTm0BU1l4cZtHW4Mwv/xyIxhw
	DZE5as1A==
X-Google-Smtp-Source: AGHT+IFwfCQkVNjD6CXMbnqb6iNxIizQ9+fDYixTv2KRx6v3UbkFCsyowVxUeZhQg3zfx+PNmkXznA==
X-Received: by 2002:a05:6a20:a127:b0:24d:d206:69ac with SMTP id adf61e73a8af0-284522d3d4fmr1738503637.14.1758149468140;
        Wed, 17 Sep 2025 15:51:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc248fa0sm454091b3a.30.2025.09.17.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:51:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uz0zR-00000003IYr-0zrK;
	Thu, 18 Sep 2025 08:51:05 +1000
Date: Thu, 18 Sep 2025 08:51:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com,
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls
 asynchronous
Message-ID: <aMs7WYubsgGrcSXB@dread.disaster.area>
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917124404.2207918-1-max.kellermann@ionos.com>

On Wed, Sep 17, 2025 at 02:44:04PM +0200, Max Kellermann wrote:
> The iput() function is a dangerous one - if the reference counter goes
> to zero, the function may block for a long time due to:
> 
> - inode_wait_for_writeback() waits until writeback on this inode
>   completes
> 
> - the filesystem-specific "evict_inode" callback can do similar
>   things; e.g. all netfs-based filesystems will call
>   netfs_wait_for_outstanding_io() which is similar to
>   inode_wait_for_writeback()
> 
> Therefore, callers must carefully evaluate the context they're in and
> check whether invoking iput() is a good idea at all.
> 
> Most of the time, this is not a problem because the dcache holds
> references to all inodes, and the dcache is usually the one to release
> the last reference.  But this assumption is fragile.  For example,
> under (memcg) memory pressure, the dcache shrinker is more likely to
> release inode references, moving the inode eviction to contexts where
> that was extremely unlikely to occur.
> 
> Our production servers "found" at least two deadlock bugs in the Ceph
> filesystem that were caused by this iput() behavior:
> 
> 1. Writeback may lead to iput() calls in Ceph (e.g. from
>    ceph_put_wrbuffer_cap_refs()) which deadlocks in
>    inode_wait_for_writeback().  Waiting for writeback completion from
>    within writeback will obviously never be able to make any progress.
>    This leads to blocked kworkers like this:
> 
>     INFO: task kworker/u777:6:1270802 blocked for more than 122 seconds.
>           Not tainted 6.16.7-i1-es #773
>     task:kworker/u777:6  state:D stack:0 pid:1270802 tgid:1270802 ppid:2
>           task_flags:0x4208060 flags:0x00004000
>     Workqueue: writeback wb_workfn (flush-ceph-3)
>     Call Trace:
>      <TASK>
>      __schedule+0x4ea/0x17d0
>      schedule+0x1c/0xc0
>      inode_wait_for_writeback+0x71/0xb0
>      evict+0xcf/0x200
>      ceph_put_wrbuffer_cap_refs+0xdd/0x220
>      ceph_invalidate_folio+0x97/0xc0
>      ceph_writepages_start+0x127b/0x14d0
>      do_writepages+0xba/0x150
>      __writeback_single_inode+0x34/0x290
>      writeback_sb_inodes+0x203/0x470
>      __writeback_inodes_wb+0x4c/0xe0
>      wb_writeback+0x189/0x2b0
>      wb_workfn+0x30b/0x3d0
>      process_one_work+0x143/0x2b0
>      worker_thread+0x30a/0x450
> 
> 2. In the Ceph messenger thread (net/ceph/messenger*.c), any iput()
>    call may invoke ceph_evict_inode() which will deadlock in
>    netfs_wait_for_outstanding_io(); since this blocks the messenger
>    thread, completions from the Ceph servers will not ever be received
>    and handled.
> 
> It looks like these deadlock bugs have been in the Ceph filesystem
> code since forever (therefore no "Fixes" tag in this patch).  There
> may be various ways to solve this:
> 
> - make iput() asynchronous and defer the actual eviction like fput()
>   (may add overhead)
> 
> - make iput() only asynchronous if I_SYNC is set (doesn't solve random
>   things happening inside the "evict_inode" callback)
> 
> - add iput_deferred() to make this asynchronous behavior/overhead
>   optional and explicit
> 
> - refactor Ceph to avoid iput() calls from within writeback and
>   messenger (if that is even possible)
> 
> - add a Ceph-specific workaround

- wait for Josef to finish his inode refcount rework patchset that
  gets rid of this whole "writeback doesn't hold an inode reference"
  problem that is the root cause of this the deadlock.

All that adding a whacky async iput work around does right now is
make it harder for Josef to land the patchset that makes this
problem go away entirely....

> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index f67025465de0..385d5261632d 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2191,6 +2191,48 @@ void ceph_queue_inode_work(struct inode *inode, int work_bit)
>  	}
>  }
>  
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
> +	if (unlikely(!inode))
> +		return;
> +
> +	if (likely(atomic_sub_return(n, &inode->i_count) > 0))
> +		/* somebody else is holding another reference -
> +		 * nothing left to do for us
> +		 */
> +		return;
> +
> +	doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
> +
> +	/* the reference counter is now 0, i.e. nobody else is holding
> +	 * a reference to this inode; restore it to 1 and donate it to
> +	 * ceph_inode_work() which will call iput() at the end
> +	 */
> +	atomic_set(&inode->i_count, 1);

If you must do this, please have a look at how
btrfs_add_delayed_iput() handles detecting the last inode reference
and punting it to an async queue without needing to drop the last
reference at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

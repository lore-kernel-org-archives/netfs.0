Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A219004B;
	Sat, 29 Mar 2025 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743290880; cv=none; b=UwaDBiob2eFAiE0yrQSUXs9l3EUVrjLN4H1gUogzNztE1dLV7v+8XKKcbzlwAJ/0bDEz4FcYGieiewnF1ccaX7tC1IUT72HITJd1qRE2FqkFubp3a/ob9BCqhcMp3nmkVVzwHM0FyDWq/MQvgnA7FhGfV6QrolKiT784ePWd62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743290880; c=relaxed/simple;
	bh=2GeF9mw/vkR55QHz+A360axYh48CX3mSIzfzx+BdoNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpUcX+3v3nixCduQguxJB96KfKHoCKjZ6bLAHY/DWin0KS0tpVFOq6NpY1OzAhH6o5SoMefb2l9WrtvutMBSupZJ/fMy/qTLnkytyvIDr1+qKq/QwrJbNL+je1/XQMXacQIRhkTfp3LmrbAr5N2K/0TUo5+kowQo6N98gl6JMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=U2dqDAnH; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="U2dqDAnH"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id BCF9D14C2D3;
	Sun, 30 Mar 2025 00:27:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1743290875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WeiyxRMgIex99fp1xakmLhCtXZGOkhzhI5rZH/LrpM=;
	b=U2dqDAnHGruTEEybQgUbQlpesAKQgGQXF0XM65i2aNxHdUWldo9rDYzGptLZ0RpqCz7HIJ
	p4k3g7Gbo8/DvZoVQH2/JSmVnJxmRC+AqRfoU7rdF1sLpOZ/fFQmt86CBkHhTayBOnHLRR
	jv45nxgMWGwuU5TnTR42F4UidH4gnHsndYnNDtGSa6H9SsdUYUE2AAl15GUtV4sLF/QpPw
	qc2TcG2NU6U+ytYs2ruURRH+XIPv2zJiJTS1wUC/A0og0QOQzpou8VcBQy8UwEq+6eriXp
	ILOXFJV29YSP7GMUiC0sq3KWa7obzWNLVdHSNnP3il07zj9M1VdZWQbxAfpW4w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b24f9e42;
	Sat, 29 Mar 2025 23:27:48 +0000 (UTC)
Date: Sun, 30 Mar 2025 08:27:33 +0900
From: asmadeus@codewreck.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, ericvh@kernel.org,
	jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com,
	netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <Z-iB5QkZyayj0Sua@codewreck.org>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
 <20250328170011.GD29527@redhat.com>
 <Z-c4B7NbHM3pgQOa@codewreck.org>
 <20250329142138.GA9144@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250329142138.GA9144@redhat.com>

Oleg Nesterov wrote on Sat, Mar 29, 2025 at 03:21:39PM +0100:
> First of all, let me remind that I know nothing about 9p or netfs ;)
> And I am not sure that my patch is the right solution.
> 
> I am not even sure we need the fix, according to syzbot testing the
> problem goes away with the fixes from David
> https://web.git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes
> but I didn't even try to read them, this is not my area.

(gah, I hate emails when one gets added to thread later.. I've just now
opened the thread on lore and seen David's test :/)

> > - due to the new optimization (aaec5a95d59615 "pipe_read: don't wake up
> > the writer if the pipe is still full"), that 'if there is room to send'
> > check started failing and tx thread doesn't start?
> 
> Again, I can be easily wrong, but no.
> 
> With or without the optimization above, it doesn't make sense to start
> the tx thread when the pipe is full, p9_fd_poll() can't report EPOLLOUT.
> 
> Lets recall that the idle read worker did kernel_read() -> pipe_read().
> Before this optimization, pipe_read() did the unnecessary
> 
> 	wake_up_interruptible_sync_poll(&pipe->wr_wait);
> 
> when the pipe was full before the reading _and_ is still full after the
> reading.
> 
> This wakeup calls p9_pollwake() which kicks p9_poll_workfn().

Aah, that's the bit I didn't get, thank you!

> This no longer happens after the optimization. So in some sense the
> p9_fd_request() -> p9_poll_mux() hack (which wakes the rx thread in this
> case) restores the old behaviour.
> 
> But again, again, quite possibly I completely misread this (nontrivial)
> code.

Yes, this totally makes sense; I agree with your analysis.

So basically 9p was optimizing for this impossible (on a normal server)
behaviour in the 9p side (it doesn't make any sense for the tx pipe to
be full with 0 in flight request, and tx pipe never goes unfull, and
reply comes (was there) before the actual write happened!!), but this
old behaviour made it work anyway...
So part of me wants to just leave it there and if anything try to make
this kind of usage impossible by adding more checks to mount -o
trans=fd, but I don't think it's possible to lock down all kind of weird
behaviour root users (=syzbot) can engage in...
OTOH syzbot does find some useful bugs so I guess it might be worth
fixing, I don't know.
If David's patch also happens to fix it I guess we can also just wait
for that?

Thanks,
-- 
Dominique Martinet | Asmadeus

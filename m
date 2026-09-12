Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BF29992B;
	Sat, 12 Sep 2026 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177427; cv=none; b=NXEQbcpbEuP5urQZQ/l4DbFeO/Fb9lweW6JN78B+qfhoIFr/QMbIQYMCBLyHXZ1d6FfvDC+Sw7j1zzvox3I88XLPzoA1/4NvEGqIrpLLBts9m6yIdMvEFbybfIfmA3mEaLlAsk6r7bEA3ZzcBuSrk+K2dkaUh67yrtULGp8MtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177427; c=relaxed/simple;
	bh=dwNEotiBX9ImSwU9tAK5FGyfJw8Hi5gCTBa5mUMt7mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1FY+SP/i7lvZR0ENeTRnip7obv6mxuaOJlQqV632+gqrX/+KsqimyaFwBxCv5PEJ0fyEY2NMi2QfE/kdc/jyurBViOVxf0yYgonL+npy1LVx9xqNUy+bpmgPsAaVwA78ci25ArWRCtuqcST9t2o0yMLZeFDsGAwsn/qboEzqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nxpQWAqs; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nxpQWAqs"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C899114C2D6;
	Sat, 12 Sep 2026 03:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789177414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fEQSP8Q+z1w18nBkqi4X6Q13reJFv7eEeGjCxF9GH4=;
	b=nxpQWAqsfmi2S4Ku5PzdyGKXFNgqQBvy0EgYANycGA9WvnyAVVzjiPnfd22WgKgIg24tDl
	fZOu2JNtLx9f3mBHvtkIbAYo4crLMnqbKO0pS/XNvOloT+uWxogIRRWgD7xICM36Fq/a5A
	u7Zibu61lX6QRZH2d5HxpBj2D0XRIAngUZORiA1+GtmMtQ+1mkbo4Aez4NSesBsryEi7Om
	VUSIgrm2hEzzw8/7TpZC2nb/fDNEQeX7yvanhy94GHtHbAhJGx9mbbMNoQB3aqANWkkJaP
	KeqP+byCQCwq0Rc4I7o7KeyPZ1uZ0+Tx7lx4YwZwd7NJLAQvMYA6s0wejgSaQw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id fa89e7f4;
	Sat, 12 Sep 2026 01:43:30 +0000 (UTC)
Date: Sat, 12 Sep 2026 10:43:15 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, dhowells@redhat.com,
	pc@manguebit.org, Michael Mulqueen <mike@method-b.uk>,
	v9fs@lists.linux.dev, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL
 corruption of file data on cache modes with CACHE_WRITEBACK
Message-ID: <aqSuM7ILn8g4ElC8@codewreck.org>
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
 <10911959.nUPlyArG6x@weasel>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10911959.nUPlyArG6x@weasel>

Christian Schoenebeck wrote on Thu, Sep 10, 2026 at 04:06:51PM +0200:
> > I searched the v9fs and netfs public-inbox archives and did not find this
> > reported - apologies if I have missed a thread.
> > 
> > The nearest existing thread is Pierre Barre's "[BUG] 9p: data corruption
> > with cache=mmap under concurrent stat/write" (24 Dec 2025). I believe that
> > is a different bug: it needs stat racing against writes and manifests as a
> > wrong i_size. What I have here is single-threaded, deterministic, and
> > destroys data rather than mis-sizing the file. It is also absent on v6.18,
> > the release that report was made against.
> 
> Even though unrelated, that's not fixed yet either, is it?

Right, David sent a patch in [1], but that patch is much too complicated
(should be split/sent as proper patches/now I've actually started
looking no longer applies) and I haven't had time to look at it much
(... OTOH given the patch he sent just now I believe it would also have
fixed this new regression as well, so we might just as well have been
better served picking that up...)

[1] https://lore.kernel.org/r/1667424.1771432276@warthog.procyon.org.uk


More importantly this new regression is much bigger and should have been
caught somewhere, but I ran my "9p-for-7.2-rc1" tests on top of 7.0 and
not on top of the merged state as of 7.1 so I didn't hit it (that's easy
enough to fix going forward), and I haven't had any time to look at 9p
stuff since then (... despite the dozen of patches sent during the 7.3
cycle that I didn't get to look at either...);
I can't fault anyone else but myself at this point but the 9p client
really is in a poor shape right now :/


Anyway, getting back on topic instead of lamenting: things can't be
worse with David's patch so I'll try to find time to pick it up/run
quick checks/send to Linus over the weekend, thank you both.


Long term I'd like to say I want to spend some time sorting out the
older patch better but I'm afraid I'm going to need help...
-- 
Dominique Martinet | Asmadeus

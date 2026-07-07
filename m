Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025053148D9;
	Tue,  7 Jul 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451136; cv=none; b=Low3a715Nmt2TJnmD1lpXYbRBuNfdCS8xLg4IT2x+owahT1vWuJLFpx8USN9zOSrORI539O49SOay55z6ApUPotdQmxWD5fprrpc1QqtAM535yb1GV+09hmSU1OM23CS/gt/uISAeGMrhRIDAbycNyV1Z3lDcZZGEDP3CnM8Awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451136; c=relaxed/simple;
	bh=VIAVGByRbKVmnQ9qZjpf7nj0iyuTpXOWR2qikgwD6N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9gz6OWwddv2z4GTuLgspfzuTEO6xLGJwPSQckTnRiwrBj8RUydQoc5E40qKZnerGuN0Z/B4PHeUUAi9sOZiAEOOgLle+EkF0QqLNBNNh93a4PZkruQnXD4C/LnZEG1Dl16HdTjyg8v8phWAXgFdtcGAf0kygeXrdn0wrzJzWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFTDc4mh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFTDc4mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF4C1F000E9;
	Tue,  7 Jul 2026 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451134;
	bh=9he0Lj8iGDsoUDXw1lOp97qkLyYrbq1eZsl8g12jV34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TFTDc4mhN56We/IKn+QePPnsSN5M0B6gg7xg2xFmQna9Dwe1FhqI9ptIzapqikXuN
	 +51UhcvKiu2Zvg1FvVM5Amn2OW3e0LxFyq44+lOsPeSIwnFYCazpKq1SBWaXfOWlsV
	 A6EeBcJtr9dRoZpYhcBWC3KB6xXfn4r2F6K6PFr8The7SueZZAPFHwDbHaVg4wEDAN
	 2yoPMWfwnLl4ErAu0M4s7Wqi0sh5zsB+3ce4yqQVxEKplWKCUMGq0kOqw0+IKg08N4
	 0PcaS3sbba0dXQpgj3vuuhNyMtXFntih59fHWcdsJLYkByMMDi6EQJIKzSHw5iT4kX
	 BKnUMHwME4hrA==
Date: Wed, 8 Jul 2026 03:05:30 +0800
From: Gao Xiang <xiang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Gao Xiang <xiang@kernel.org>, David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
Message-ID: <ak1N-lyu5YZSM_99@debian>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20260706030439.14212-1-xiang@kernel.org>
 <20260707-irrweg-errechnen-matten-dae8db86b437@brauner>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707-irrweg-errechnen-matten-dae8db86b437@brauner>

Hi Christian,

On Tue, Jul 07, 2026 at 08:59:17PM +0200, Christian Brauner wrote:
> > It was an effort to enhance fscache as a kernel cache for lazy
> > pulling (at least according to previous Incremental FS discussion [1])
> > and EROFS over fscache was the in-tree user of this mode.
> > 
> > fscache has since evolved to be netfslib-oriented, serving network
> > filesystem inodes via the netfs library, but EROFS never acts as a
> > network filesystem and we need to cache golden filesystem images rather
> > than individual EROFS inodes.
> > 
> > Since EROFS over fscache is now removed, clean up netfs/fscache/
> > cachefiles upstream too.
> > 
> > [1] https://lore.kernel.org/r/CAOQ4uxi4dzxArY24YO=+kBCK2gGoq3Ptb8WkzCqSogPgU_R3dQ@mail.gmail.com
> > 
> > Signed-off-by: Gao Xiang <xiang@kernel.org>
> 
> Seems sensible to me. So I'll take it unless David has objections.

I hope David can ack it too. I didn't test this patch
seriously since I have no proper environment to set up
netfs although it should be a trivial removal.

Thanks,
Gao Xiang

> 
> -- 
> Christian Brauner <brauner@kernel.org>

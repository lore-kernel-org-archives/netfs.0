Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957648662E;
	Thu, 10 Sep 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043453; cv=none; b=Ps7m/1amfIBSwCOWl9BG+btXvmdrWz2sqJm+kvrpuzmZwP43n1MebS99t/M9RKQYSh6JdNVa9dQ4CIY0URejt+49hRnTTd3VXpLsXsJbrCUmhgdJ4BXVW9AnM+LWKqie8qhvlNqx9mfmmJBb5cKqGmOnZP2HTRzGAiQlY0H/Xx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043453; c=relaxed/simple;
	bh=6urVsuJIUl715zS3BvrWpdJaYp5NktJ7HLYC0pqHIuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5GhFiwCVn5CdzFH2buto8ffWhgUnoD2V/Fzic03vihsOB5IRcD4iJqLRw7Frst9KBQADutiIDzEa5oX8pTZSt3wHMQOEJsQvlUExapvIVoblrBBGlUV1JyUlw/LumERJXRjGVn3YIkyt4qdywm/yLdXJTfcAWkUWFVRWWY3Ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=0lRBhRvR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0lRBhRvR"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 17DDE14C2D6;
	Thu, 10 Sep 2026 14:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789043026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPANr6PUeBWdZgT/kVNZz2RVAV2JjeA9vYyXUoFCFU0=;
	b=0lRBhRvR4b4OcIGXAp0Ga1mnes1kPOYs+RDUSCfmdCM53MxwOrIsV3T+RwsgMYgczAqUh/
	1VqNKQMMSNFhbQ2kQ5whbbekrt0GBuNLtQL6gHvurXjCkeaQo03yf3lZayjWKVwmmT5eTj
	0mbq22czH2IpzMhUOnHOoUk7c2wCbvH+cxiVjeFUb/3hKxQApj+tL8PZrVOc+BitVvjnAM
	6kkGgIJWllNmO6xgxuPPs+cJsLdq8NOdUk65GOhSTuTqZx80Faoal2ZkxS54nzw1KqA36d
	ikyvqJF9vIs9ZtingGd1XPgAOoV0viKDiw9HQhLgg6R/zwJVefGl3aDkYqE5Mg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 98836a56;
	Thu, 10 Sep 2026 12:23:42 +0000 (UTC)
Date: Thu, 10 Sep 2026 21:23:27 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Mulqueen <mike@method-b.uk>, dhowells@redhat.com
Cc: ericvh@kernel.org, lucho@ionkov.net, pc@manguebit.org,
	linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL
 corruption of file data on cache modes with CACHE_WRITEBACK
Message-ID: <aqKhPw8wVS6qCBQr@codewreck.org>
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>

Michael Mulqueen wrote on Thu, Sep 10, 2026 at 11:56:24AM +0100:
> This is my first kernel bug report, so let's hope I've done it right!

Thank you for the detailed report!

I don't have time to look right now but given the timing (7.1-rc4 -> rc5)
and that it affects cache modes only it looks like a regression in
netfs,
David, can you have a look?

-- 
Dominique

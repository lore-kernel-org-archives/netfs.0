Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E10CA4E;
	Sat,  9 May 2026 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361175; cv=none; b=SAW4DavZjXI/pGMCdzLDfjCJdKPzpa5z7Mf8QI5fY5UipGz9nvYWBGbQiu2fWFnZ65zbnourDOyhTYsVLVhRYY7FkLQK6Z2RZzpZ86RZaE1RwUgD+Dzoxk1fxHf4nfd8QfTOfgL4hv8TuEHCFOIbO3jxXiNAu8sehkbzjCB71XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361175; c=relaxed/simple;
	bh=uBUThkzPq3bIh8exkMvvIMZ3xi0qvfWeGRDf4xCY3bA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NonlvrMHfukAxMkenYvI4J1CnwhBNFPH8zTJ+A2Xhuq4KxO5v2z+hiRxN5ye37s8thvuyrQEPh21vC0XjXH6CzdLEs7xVqWyk85Cn6XujJdSY5Ih0dA710Qz08QmYEGn0B8PY/MkAJu4QxDtPl8J3wG6ANntjmYIUwGtXdUdq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Mjt5OQkl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Mjt5OQkl"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3DF4041084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1778361166; bh=YBtbi7A9YrkmaUhKGVC2kX+uo3qrOmV8imEJ0JVJ4g4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mjt5OQklw/q0tOxGnFv39kDSqfDkjS6mig9GI1AWkdAPa4cvTRNrNmfpymjESUFi6
	 H/5FakCtFplnTQnl9nZRo/fnegO8vkIXQvGFIZm2hHkOPBIHdefRa3KJ4X+KSry3p0
	 8dZISKSFgyrQYN/1LKrpJRLd7dka+/NZCfofGK1GocxfGMQTNvP92mAU6eWMM37PaK
	 wHbR3WasqikofHbBUvC+f9BEkcUp3ZE5H0hzMpvzxk4qnLfaNcYFlnYQCX2XR46ys8
	 5zJT8dwRorNdXw6bqCfO4cVxjbEkC8tbwufzeeduIu6LLSPsH2YJM0iOI7YEbkIEgh
	 y7top2NlvevUw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3DF4041084;
	Sat,  9 May 2026 21:12:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Adrien Reynard <reynard.adrien.08@gmail.com>, paulmck@kernel.org,
 gregkh@linuxfoundation.org, dhowells@redhat.com, mhiramat@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
 rostedt@goodmis.org, skhan@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org, pc@manguebit.org, rcu@vger.kernel.org,
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Adrien
 Reynard <reynard.adrien.08@gmail.com>
Subject: Re: [PATCH v2 2/4] docs: fix repeated word 'that' across documentation
In-Reply-To: <20260509143050.16458-1-reynard.adrien.08@gmail.com>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
 <20260509143050.16458-1-reynard.adrien.08@gmail.com>
Date: Sat, 09 May 2026 15:12:45 -0600
Message-ID: <87wlxcz3qq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Adrien Reynard <reynard.adrien.08@gmail.com> writes:

> Remove duplicated word 'that' found in RCU/rcu.rst,
> driver-api/driver-model/overview.rst,
> filesystems/netfs_library.rst, trace/histogram-design.rst
> and trace/histogram.rst.
>
> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> ---
>  Documentation/RCU/rcu.rst                          | 2 +-
>  Documentation/driver-api/driver-model/overview.rst | 2 +-
>  Documentation/filesystems/netfs_library.rst        | 2 +-
>  Documentation/trace/histogram-design.rst           | 2 +-
>  Documentation/trace/histogram.rst                  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

When you send an updated version of a patch, please:

- Post it as its own thread, rather than as a response to a previous
  version

- Include a note after the "---" line explaining the changes from the
  previous version.

Thanks,

jon

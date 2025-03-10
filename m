Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FE21D59F;
	Mon, 10 Mar 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607467; cv=none; b=E2noqJRYxoqX7gpzno/oHGAHFXPjmirJqm7Z/GxsN8rAQ8+vtryqkiuVdenm8t3YV8aQG9Iu1elafXO4Qn/IySVXtOn+Jid96WCZqza5Kko6B4OnJeIjTRat22Xc5sdCs3PbMF3DF52GILeHRVkywNJXnhezyeJzD3Syer6l32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607467; c=relaxed/simple;
	bh=TMVIkW000zu0GOdJHNpRrJU4fx/u5zB3ylgzoOlVG5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4D8c4k3PzjC2tDgtj2PtGHLshru7hCKwZoNAOhHgYa0r1UrS5/e7uli5+ijai+c4aiu1O857haEovC/Q6M7jo3Ka4V8N/EfLTQzvVSZY9kWK20OoaRI/0s1TkadsNKgXqFVJGEOHq7jQIvVntCJOJygjyNL6Mbn5YYYU7ki97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxniHUeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxniHUeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EA1C4CEE5;
	Mon, 10 Mar 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741607466;
	bh=TMVIkW000zu0GOdJHNpRrJU4fx/u5zB3ylgzoOlVG5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxniHUeR/2HArORuh8XoCoGfBP6Ai+7INXBQAqCnzGEZ3bNxFPACd40G1ZM4F0gON
	 RNShgNLc/cGhJa8yIk9+3bOdvDxbNkvVuJbaquuvUpe6h7jsa6nVTNsne0xnCuCAcp
	 Pe7gA9+BCZZS8BjcV+24R8eJthTLQoOtBspVwF3Q=
Date: Mon, 10 Mar 2025 12:51:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Howells <dhowells@redhat.com>
Cc: max.kellermann@ionos.com, Johannes Berg <johannes@sipsolutions.net>,
	netfs@lists.linux.dev, stable-commits@vger.kernel.org
Subject: Re: Patch "fs/netfs/read_pgpriv2: skip folio queues without
 `marks3`" has been added to the 6.13-stable tree
Message-ID: <2025031056-puritan-washday-2239@gregkh>
References: <2025021411-village-lash-4680@gregkh>
 <168198.1741339005@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168198.1741339005@warthog.procyon.org.uk>

On Fri, Mar 07, 2025 at 09:16:45AM +0000, David Howells wrote:
> <gregkh@linuxfoundation.org> wrote:
> 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     fs/netfs/read_pgpriv2: skip folio queues without `marks3`
> > 
> > to the 6.13-stable tree which can be found at:
> 
> Can you add it to 6.12-stable also?

Now added, thanks.

greg k-h

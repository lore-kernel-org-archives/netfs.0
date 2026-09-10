Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AA27AC4D
	for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789018119; cv=none; b=mH5REpKOWZF0v8VD9vlWsIRFBcB5gkiCcC61QHscG0icqA/zLYqwkrdWFFXkNuT5g8+FzMBUG6qQUWUAwt03mtx2LcfWwOaH8SSBN7pORKT6k+fjpKOPYWPE9lMqDajg7T1MT7SKle5KGYDY0BTgqnSSXB+xymn1PzmYapBGNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789018119; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH7I+EP5mudOI5eZEZuIILidk4CssyzVA3Zvrz2zYfPWAPPuXYd92mLwPnmZyhW1B/DH+L9YFm11/c3DTwIO6I/MSnWoFvCn24h4OUn00KxOqzD9qcWeqA6ePWiByHbj4Ri91Z/wm2UscY2ht+XT+41NrGvliZuecaL4oO1Bp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B58568D09; Thu, 10 Sep 2026 07:28:34 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:28:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <20260910052833.GE27133@lst.de>
References: <1667275.1788941191@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667275.1788941191@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


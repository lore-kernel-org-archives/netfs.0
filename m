Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EC364043;
	Thu, 23 Jul 2026 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782764; cv=none; b=VpcGon0TMBgLkT8E8gAfcmbxqFH3J2R1YN7zZ7Vn/i3JkNw2jckp2C3DK1SPaOnLwRefv9XUySIf9qIMxYIGZjVi12DC0gb9MYEQTWhghlrI+lPoHmtbB6iC8JMEluviBJ5DCr/DC0Vz/bONK/iiUY1Of5+PV2U6DqJ46aFS3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782764; c=relaxed/simple;
	bh=ayOzQix9/gTYq9M0m6I8a/r4dGjZwVvBNvkPnGJdxk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7f7af/Q9U+fTxMZnMs29LsWq5v8NRtHKl6KRb5O1R927eHNgVSilOY3lqn648tbIv+M6gH2G42Yt8noUcFcjO/vMJuaI0oGInm4d+cWepRY9kWyavHTomNU+dvf4lS9Tz/77krEw6kb6IqpfR/AivCRg32rY7XxZ5/YyAUTJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kv9zBbyc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kv9zBbyc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U4UbiPkK7EI+69g6SLEDDSULAWyL39C1heYH0r6DsTM=; b=Kv9zBbycanX/8NKI02LlWyEsiN
	7kt5fSORYfPULKHrN0wN+vhwicY6OOWNikst1fXiqB/UqozK+JndHDJmF2h0eUBfigL5KVXsq1FPY
	rPg5Kywe/UsNi1OE2DRMQHat8VYL6u+xgYHIXPYICw1OAPQx9aCwWJlyiorl2VQO6EgcGU0luK9aj
	LHlRztfDBHNbzhI33/PAj3dZTUEoHN7aq7Ld7o9aQaff65ppledyQS3bp37Yqbl6e17aSf2hakEhV
	hGn/ZNQnH3x/2aJHx4wNBEvfM8obIsZJY95curEmbb8GG7xLvno9Han7rtaPlB6JanQc4BI4P06pR
	mLOnuzuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmlWT-0000000DRRC-433p;
	Thu, 23 Jul 2026 04:59:05 +0000
Date: Wed, 22 Jul 2026 21:59:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to
 drain all dirty folios
Message-ID: <amGfmQHmZZuBkcwq@infradead.org>
References: <20260707052555.2055002-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707052555.2055002-1-yun.zhou@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 07, 2026 at 01:25:55PM +0800, Yun Zhou wrote:
> When netfs_create_write_req() fails with -ENOMEM in netfs_writepages(),
> the couldnt_start error path redirties and unlocks the first folio,

writeback must use mempools to back resoures, or __GFP_NOFAIL if it
can't for some reason.  -ENOMEM must not happend in writeback paths
or your toast.  So please fix the cause of this error and not the
symptoms.


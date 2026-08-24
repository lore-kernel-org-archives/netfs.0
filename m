Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585638735D
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599628; cv=none; b=e1AfNPDVYUb8gP61MVbtqIrpFLczDrkGoA7USUNikT6vkBVuweR2M0n82KUjJhiIel+R0hUGQC/2TfcKhrRjusDKeXmZa3RzGIp2eD15IJEB+Po6SS/kW2jrrb4xKO+MZRgMNW+FGomYEAAf7g5sKKl3G2Xg0Tvtm9OKPR/kSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599628; c=relaxed/simple;
	bh=6hZ6bgXsRUd/APqTrkyJzfEZrhzRTJE6Erb4+74BbVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJKPfH5Ku0f4x8V9fHzAMoyeynbBMPmcg/1MSRWX2LShkUA7HVv21BR/jQFAfgEabMN7TQsLiU5u4HoEIH+unihrcrQNuRDIxJ12P8N1o2QFemqpqOWyPKRx2slLW/4MLSW4UMtu7d9kYSfPEW31szca7d6R8JmVoWPPAD4h0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=efmCouGZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="efmCouGZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P7JiHPphnHdKutiOJ17fK92xzeLchKFPVvv2MdA/7R4=; b=efmCouGZ/HSKyZ/h3+EQ+qVD7b
	q9Bp1qkatbfUegomEJm85QDk1teZ2kyPyqRtCjyJ0t4pA14Anfn5a8mcsjItATMs5KLhnD5oVIp9j
	3UPWO5evib41/iL8IyO6um6ENlUM1ebOBJj4m2qx/3U86Q4jAwMbYClxyXUSVVmMMgGZruPuMtJJb
	UXwmxO2NlgKDufX9RxcNSZChEY9OlCz/i+KvzFrmhrzERbcIzLkIfdPKpP5g0TxYDBOhKOyP71E0+
	ApZETpBhLviD+n47Uw3D2jp/cIkqXiOOCMGnrh1mjBvGGYP2oGVYhTNkK5qzNfBGWJZXcIXPx7SZU
	6jWe0Yrw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyaJy-00000007hsy-2Mhv;
	Mon, 24 Aug 2026 19:27:02 +0000
Date: Mon, 24 Aug 2026 20:27:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev
Subject: Re: Function to do end-writeback in bulk
Message-ID: <aoybBhYB7Km3y0qG@casper.infradead.org>
References: <aoxueo-kIy1Hkmc-@casper.infradead.org>
 <aoxidVrUtl3F0QUi@casper.infradead.org>
 <761202.1787584160@warthog.procyon.org.uk>
 <762789.1787586428@warthog.procyon.org.uk>
 <770270.1787598865@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770270.1787598865@warthog.procyon.org.uk>

On Mon, Aug 24, 2026 at 08:14:25PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Jan's more of an expert on the writeback path than I am, but once we've
> > cleared the PG_writeback flag on the folio, there's nothing preventing
> > us from removing the folio from the pagecache, right?  So the inode could
> > then be evicted, and then doing mapping->host would be a UAF.
> 
> netfs inode cleanup waits for all outstanding requests to complete, which
> would include writeback.

I don't think core kernel code can depend on that behaviour from all
filesystems that do writeback though.

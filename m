Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D834261B71
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588223; cv=none; b=GFs8R4DwDRL1UODWkT/b1PH85MDa56UEZskIJAyrLk246yo151vEZKp2fFHC5Td2nsIHmMXc83lf10oc+bptyk7RQzyGfsmnYbpdW+gs1QELFSLmjWF7TVzjPO8W3VVM83gt4gaianX2xTHd8ERmgyE+EyfxnEBjOYXs2a7p87E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588223; c=relaxed/simple;
	bh=5IgnrMKmZ7PYq1L+CXWctKMQi/TXvm6jL88/AYlO+Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyXUl1OcTDw4atMLs25L6tprbjMdLtdEIsU+LxuoNWFSkZW1vblgNj+qOJvgJ1B1Npe4GyG69+yOa6PVVNhsYB6qdL+g68hSO7wE38RfDtKxF9b5G4O6HcrJXA7AMPVnOl+d27yvgnCtu4UEXXxFN16J4Ba3XwVgKIbJNTrCev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rvLaGLbC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rvLaGLbC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IpURZGG5KnOHgruigP0o7zUSd8VIjeuQ9Tc8FC0GTc4=; b=rvLaGLbCw2w97ciCUuG0l7CRU9
	tEFARBg1H448nVBwzCAJy8GWMZgs4ri8cuZuLJtFrQKUxKFeWua08Ko4iwWz5Eox3FObjwbecLSmx
	RFUTLRlrFBiJl42QF30WE2+kYX735Kr3PNFgdbdocX280DkpgwhTMXVYSEwdCp+E+9hy26BlChB+v
	muTO48GPF+swFtHX8s7wByW7WHwZAg4gKS7CR9z8IqxT0gXPE57nlRNvRswXFRe2fVovCsWHJJhtK
	22eTIeKNK1v35AOsA0OEorzpuTOoS1gKriZby1Z/kn2skbEpYQRk27LPW6+7+pr7/a7wMnW5hx2sz
	KAAxcf9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXM2-00000007UPa-32ub;
	Mon, 24 Aug 2026 16:16:58 +0000
Date: Mon, 24 Aug 2026 17:16:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev
Subject: Re: Function to do end-writeback in bulk
Message-ID: <aoxueo-kIy1Hkmc-@casper.infradead.org>
References: <aoxidVrUtl3F0QUi@casper.infradead.org>
 <761202.1787584160@warthog.procyon.org.uk>
 <762789.1787586428@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762789.1787586428@warthog.procyon.org.uk>

On Mon, Aug 24, 2026 at 04:47:08PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > I hate this API.  I much prefer the _iter() style:
> 
> I'm not that keen on the _iter() style, but whatever.

The implementation is more contorted (for the iter style), but it makes
the callers easier to write as they don't need the callback function and
to package all the data it needs up into a struct.

> However, does that make it harder to do the stats manipulation in bulk in
> future?
> 
> I was looking at __folio_end_writeback(), and I see:
> 
> 	....
> 			wb = inode_to_wb(inode);
> 			wb_stat_mod(wb, WB_WRITEBACK, -nr);
> 			__wb_writeout_add(wb, nr);
> 			if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
> 				wb_inode_writeback_end(wb);
> 				if (mapping->host)
> 					sb_clear_inode_writeback(mapping->host);
> 			}
> 	...
> 		lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
> 		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
> 		node_stat_mod_folio(folio, NR_WRITTEN, nr);
> 	...
> 
> And I was thinking those could be done in bulk... but there seems to be an IRQ
> disablement requirement around them.  Does the folio_xor_flags_has_waiters()
> have to be done inside?  I presume this is to prevent a set/clear race on the
> master WRITEBACK tag.

I was envisaging embedding a folio_batch into the ctrl struct and when
that fills up, do the entire batch at once.  That gives us a 31x
reduction in overhead, which is usually enough.

Jan's more of an expert on the writeback path than I am, but once we've
cleared the PG_writeback flag on the folio, there's nothing preventing
us from removing the folio from the pagecache, right?  So the inode could
then be evicted, and then doing mapping->host would be a UAF.

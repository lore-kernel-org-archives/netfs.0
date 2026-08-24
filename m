Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00A370ADC
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585155; cv=none; b=k7hzQ3Z/0NeQWblYMmsVgzGR1+nv8zfZ1ZUuf0Pro4mcMdWlmUg0lq/60jain/FZGI5HO2pFmeTBC7xzboM+IrUjzIT5EbgANOopg042iWvdAIU3TIjalMSAdwVBlh+TbhpR7W2hzS7v8ViD5SeyibGasY3BX0rVMxVPQSz+RNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585155; c=relaxed/simple;
	bh=8A4H4zoetBeK6mlENiUvsbzz+yqH6vqLai/NiD76JTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF/5TpJavMkP546gdCtVwE56mJqq11GkCQ1keadjvL8/udskPlxGapAD1jCZM41LBuh7GznYuqaOdj+YPtnFjW3R1aK1/WN2fVVDa2k9fs6537EeadcHJjtcDY53pAjNDfd2mqOdTFjckI65RrViQEff9AaA/v+ktF2zFUGgGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iYhH6d8J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iYhH6d8J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l2LzoAyJ9vw2v4GMjjyZIorxX9whGnKO+YhBhKJnaEE=; b=iYhH6d8JSzi3FHp/m20Xweu0XO
	BQ3wBNF8r6z3xGUzIPzGfqrmsA2tDbPqRA8xbSlMcTKsC0fYTHW4RFJ8axYkPRhAhBhFimuWjoHb8
	koLcFZZUx2Y2nGqDNV1FIl7rwXnHAzf53kKzB0YAsboHsfmPUBDYkri1aNeLmRB39YHrP56KxdsD+
	O7f2ZuQE770zIKY1wA9+cDiGdyyKvBlIOEi3wMSx4CDOmzTL4/aQJ2jKrlnwhxtCvr8mAonSK4CPg
	s4IV9rqsdCoW1an6sP/ESdCb5L/u4lLPbHtIBlqFtlUVtKzJcJUeUn18l4mYtp7zeQcbt1ngaU7Jd
	0EL9ISHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWYP-00000007QlO-48hm;
	Mon, 24 Aug 2026 15:25:42 +0000
Date: Mon, 24 Aug 2026 16:25:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev
Subject: Re: Function to do end-writeback in bulk
Message-ID: <aoxidVrUtl3F0QUi@casper.infradead.org>
References: <761202.1787584160@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761202.1787584160@warthog.procyon.org.uk>

On Mon, Aug 24, 2026 at 04:09:20PM +0100, David Howells wrote:
> Can you take a look at the function below?  This is what I've come up with for
> the moment for a basic bulk end-writeback (and I'll need something similar for
> bulk unlock).  At the moment, it returns true/false depending on whether it
> made progress, but I'm thinking that it might be better if it returns the
> remaining size of any folio that partially overlaps the end position and so
> didn't get unlocked.  This would could allow me to set a minimum amount to
> accrue before I call it again.  Whether progress was made can also be
> determined by comparing @from before and after.
> 
> Thanks,
> David
> ---
> /**
>  * folio_end_writeback_range - End writeback for the folios within the range
>  * @mapping: The pagecache to modify
>  * @from: Pointer to the starting position (updated)
>  * @to: The end position (exclusive)
>  * @cleaner_func: Function to clean up the folios in the range
>  * @cleaner_priv: Private data for the cleaner func

I hate this API.  I much prefer the _iter() style:

struct end_writeback_ctrl {
	struct xa_state xas;
	uoff_t fend;
};

struct folio *end_writeback_iter(struct address_space *mapping,
		uoff_t from, uoff_t to,
		struct end_writeback_ctrl *ctrl, struct folio *folio)
{
	if (!folio) {
		ctrl->xas = __XA_STATE(&mapping->i_pages, from / PAGE_SIZE,
				0, 0);
		folio = xas_find(&ctrl->xas, to / PAGE_SIZE);
	} else {
retry:
		folio_end_writeback(folio);
		folio = xas_next_entry(&ctrl->xas, to / PAGE_SIZE);
	}

	if (xas_retry(&xas, folio))
		goto retry;
	ctrl->fend = folio_next_pos(folio);
	if (ctrl->fend > to)
		folio = NULL;

	return folio;
}

(you can embed the rcu_read_lock() / unlock in here too, but probably
better to do it in the caller)

>  * Unlock folios that are entirely within in the given range, where @from is
>  * included in the range, but @to is excluded from the range.
>  *
>  * Return: True if at least one folio got cleaned, false otherwise.  @from will
>  * be updated to point past the last folio cleaned.
>  */
> static inline
> bool folio_end_writeback_range(struct address_space *mapping,
> 			       uoff_t *from, uoff_t to,
> 			       void (*cleaner_func)(struct folio *folio,
> 						    void *cleaner_priv),
> 			       void *cleaner_priv)
> {
> 	struct folio *folio;
> 	XA_STATE(xas, &mapping->i_pages, *from / PAGE_SIZE);
> 	bool cleaned = false;
> 
> 	rcu_read_lock();
> 	xas_for_each(&xas, folio, (to - 1) / PAGE_SIZE) {
> 		uoff_t fend;
> 
> 		if (xas_retry(&xas, folio))
> 			continue;
> 
> 		fend = folio_next_pos(folio);
> 		if (fend > to)
> 			break;
> 
> 		cleaner_func(folio, cleaner_priv);
> 		folio_end_writeback(folio);
> 		*from = fend;
> 		cleaned = true;
> 	}
> 	rcu_read_unlock();
> 	return cleaned;
> }
> 

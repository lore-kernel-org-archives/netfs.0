Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62C261581;
	Mon, 27 Oct 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576664; cv=none; b=h2Q2aq1w4YQAilW6S0LguF/q873a0mm6F8yGp/hAGrCgy49BywVjYQFbsON/GqqPvg8wqxXhWgkNR3BnPft/3C1evL1P9e9wEzigie0ToRxMA1Pjsk/AYjgLBjDhCWguCMLHsMAqEtP7DJzdbPLot+WdjsYP1teQsthjw8y/BdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576664; c=relaxed/simple;
	bh=+nl6qHCZHJGT3JnqOAFKtfNaNZnKGabhphRMOwUnD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO0J2uZf4EUk6fKU4XqJa2rH2MDzd/c3FDb4oxiLXBlzhs6FghOTpM+mU4aF8Mva8myTyR9RhZPM2IlADTa0QeyPowuUKxfawhb/khnLpd5F9isXXYjyXj8drWxjoWNBX6e9TU1LgtdVOhgscOxVhh04CAbQ5CZQT0+2xS3tQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wTpgTHVv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wTpgTHVv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0990qxvQJ+FfqCLKog5x9UKLwa0JywL1QcNAF1x4llM=; b=wTpgTHVvS2jrMlkFlt2wdx9c9T
	uGIJM2/UwY+7gVOrs1an/vxD6/siK0p3FFZZ9Wlev7u7ocFDFpgJG6AA7DCfPc6Iq4qzY6phvduod
	c6ajJSjtPhTeuYE/f3YCISPNxLmJPkhWFRBKwyA3DPpC/uFyyL3gk2hnf/UrihT/j6QbzMKjFjsho
	9/gUv+Q5ZstKIg8+VMl4i/BSqsAK6FRRpjCxv0zFRF49XM+HyjvNIKg6zfP96AEx1Cu3wUuNwz0Kb
	jOO1+qCJbDE1QRKarxONhdGS9Zyid2wAH+uo/BZzPOl4c7B821nv3bosVt20ByqgF1PfKoi9/4mtU
	P1ZW1P7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDOYl-00000004Fae-1Y0U;
	Mon, 27 Oct 2025 14:50:59 +0000
Date: Mon, 27 Oct 2025 14:50:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev
Subject: Re: [PATCH 08/10] netfs: Use folio_next_pos()
Message-ID: <aP-G085ZIN_lR9c0@casper.infradead.org>
References: <20251024170822.1427218-9-willy@infradead.org>
 <20251024170822.1427218-1-willy@infradead.org>
 <2253016.1761574605@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2253016.1761574605@warthog.procyon.org.uk>

On Mon, Oct 27, 2025 at 02:16:45PM +0000, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > This is one instruction more efficient than open-coding folio_pos() +
> > folio_size().  It's the equivalent of (x + y) << z rather than
> > x << z + y << z.
> 
> Should that be noted to the gcc bugzilla as a missed optimisation?

I don't know?  Maybe there's a Law Of C Arithmetic that prevents it
from doing this optimisation that we can ignore because we know that
the calculation will never overflow.

I tried with both gcc and LLVM and both produce better code for g()
than for f():
https://godbolt.org/z/YTc883f6G

Interestingly, LLVM does better for f() than gcc does, but they produce
identical code for g() (minor difference like using sal instead of shl
but that feels unimportant).

If you want to file optimisation bug(s) against gcc, feel free to use
this example code.

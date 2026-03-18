Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953C3FB053;
	Wed, 18 Mar 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851133; cv=none; b=hKednT3k2Zm/qwgA67/KZZuMTRepHkHqRXPpS74eiJw4DjIeX4SHLaDMzs/LvPr0ANry3iX1kXkjyv/A0cBEq8uTW4Mb39bFOdWXlPsNXrUJl45AztiUla7KHgKZq/qAcKBgud/fg96VjdXPCSHc1+lSoWomxRYT14iAm+zEgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851133; c=relaxed/simple;
	bh=yFmsiKMZ6LIKiIoYQngAUtBJrmBcteth7bPXdLdaSU4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=plov4MFIrS0Cc3TivnLQFet6fbn7X99ZMxTsgGdA1zhDJNPkEVVLwyn9c2XVds0jqMxAnIMBvVRFe65waka+2+MEHn7wr7AxUrZsNrVAVrX8lf5HDF9e+pk/nTo5w0FxfC/f8zp1voeaZEQoih6p2odGGXPGiu05jE3IbgtwQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=EnUfUEZz; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="EnUfUEZz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jojGjcss2Or8mEfvtNw4nzQRr4QUxTorpz0ASy7gfwo=; b=EnUfUEZzdEdHls61fs2YJdlECP
	V7fqbn6kOnMRdoilNr5w0bPSenewxidjQ89E1X9DFGpd9Tp6htsq/LG6kRWjhKHl90YWJ5oHxS88a
	s4F9aYahrBzqneRo2LDj/Kc6P4BMa+Le23KMkG7jt8sga4kkOAZMOe7Q/GkO0qfTke6chhZuSwNnf
	OVc0INOSOo58dIRdv1sOo4yVCy5F4hhOxpcB3m8QabzYypXsmq50gWJcu+bzNV2uOzM27ONkdCPT+
	vgE8J5y0io3SpCPU30gj6wvl0v+jZq0QPj/jXxr1gIXTaNopUJYPP3gdOkgWkmAyWrFm2TiRewCYQ
	f9FLqXqQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w2thw-000000019ID-465s;
	Wed, 18 Mar 2026 13:25:20 -0300
Message-ID: <b391df6ccd4c9e86cc58964a374fc55f@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix read abandonment during retry
In-Reply-To: <3775287.1773848338@warthog.procyon.org.uk>
References: <3775287.1773848338@warthog.procyon.org.uk>
Date: Wed, 18 Mar 2026 13:25:20 -0300
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Under certain circumstances, all the remaining subrequests from a read
> request will get abandoned during retry.  The abandonment process expects
> the 'subreq' variable to be set to the place to start abandonment from, but
> it doesn't always have a useful value (it will be uninitialised on the
> first pass through the loop and it may point to a deleted subrequest on
> later passes).
>
> Fix the first jump to "abandon:" to set subreq to the start of the first
> subrequest expected to need retry (which, in this abandonment case, turned
> out unexpectedly to no longer have NEED_RETRY set).
>
> Also clear the subreq pointer after discarding superfluous retryable
> subrequests to cause an oops if we do try to access it.
>
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_retry.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

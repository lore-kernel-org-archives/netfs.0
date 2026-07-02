Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8347ECC3;
	Thu,  2 Jul 2026 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997180; cv=none; b=cY8E09auNm97jCIwrxCHiEBC4RRwlt0/Gkq8FPTY71YdABezWHBIpI5T/7TcotclNeqDYlGjB9s/XpWNLPSdBV9ceWyKhELrwgf4ExQV25ypZ4jmRvCCZWGyEA/BD9ExqEeYpa6V+kLd1JM7aG4wSJhiMJvD8Lg+Cz1QiaGz814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997180; c=relaxed/simple;
	bh=2CKrVTAOkTbPnCp/F1aLjYU4Edx1SXe/AJHS7vEokS8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=lN9+gEIq0MfqisIJubFhLWU+DqG1tOKM933gAhJPEbZzfqHe0dojQHu68zR6V9+O2AOSIicUPBaOsXhU5zLyEF/Y4BHrf/fHR7ih1wahL8wWkFZp25K2xhzCvTm2McOuqZ3Pa0r44+i6l/lfbKyDPx1mvFpoLpfTqe7fMccLfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=spMMO2JO; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="spMMO2JO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7tem6lvKLeyjhDcNo6Ng4g9CzbOH/+ygr0I/5scJB6A=; b=spMMO2JOdjwXMGa5Q/yQQJBRYW
	hZyKsXZZWyL+r/vltyzaXSegzBf44JjnIat/Z6JihPt49d3Xip8ooBOk50ufjvy44oluG5i8C9Utw
	zaSOrKn8iunBQKaMK+eTDuOoo8KLSaNW/t24Rd+XTtWhUngUK0pluFx5uNJUYh4h/IY9yASO4vRPZ
	4fkt4Dt0jv4PNoq42RJ1EwTyDII7U5zfoCKXyjEU2YqTGA39yhDOg/MOCBmYHj+UBeRFOY/s7fetC
	pDoamnYFJZpgju1EoJUf30EGr1Xux90kvNL9IDTyWbIgyBJl3fH0xvINVBfhjSo+oEK47Ib56w7Rr
	8wGOaHiA==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.2)
	id 1wfH0z-00000002Z8a-0TiU;
	Thu, 02 Jul 2026 09:59:37 -0300
Message-ID: <4941c0d1bb3092af2a379de75fbe2908@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix barriering when walking subrequest list
In-Reply-To: <138807.1782980582@warthog.procyon.org.uk>
References: <138807.1782980582@warthog.procyon.org.uk>
Date: Thu, 02 Jul 2026 09:59:36 -0300
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Fix the barriering used when walking the subrequest list in retry as
> there's a possibility of seeing a subreq that's just been added by the
> application thread.
>
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_retry.c  |    7 ++++++-
>  fs/netfs/write_retry.c |    7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

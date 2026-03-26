Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACE39768A;
	Thu, 26 Mar 2026 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566997; cv=none; b=NrqZw/PLckyQYPvuzimB8lJGYQ6n9lId/mYcdJn3Fv7ZCQfsrL1DVjGRlR5Tfc8eVGDNQYuosBp6Tv+P5gqLqb3m7xcFPwz3gJMlghjS5f40tG21cqabDh4aFFGr6qF7XuXTJPsDs4nqSyA2XhYj6jEDq+iUhGkiTQMP9EN6mYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566997; c=relaxed/simple;
	bh=c6u7kkVBWwEe3cJ2qykNrGvbHSuF7xgqcdI4GmPOPIQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=YWnLZY5HxbnAWuBJPRpXpQpoxfQCvAxjAa7rOEcImNFyVI6dcouZSysXber6MXUBqkFbReP2DqQpr6LTJgCilav1LK1FGhMNUGg+mgVRbJm7aqd/GdCqABtSbFfu47wyNc3Wty3PDR/Fv48qLcM+ghDvDTcnffYjoFpDP4oxUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=STQ4kM4D; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="STQ4kM4D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rgF90ddOM5VHBu8QGEvv8mkSA9361Sxm7PQr+9hlots=; b=STQ4kM4DC4xPSOmzwTifr//vqw
	04HG1xvWB6TENtW73BYb0Q0wdFW1HyAoXRMNMFQ+iGwpIStm8h4pcCgewMpSKxEOSOGZudFm5ul4q
	MkLBlhKlZiFmZNm1yhCJ4+tJAP1SQ+2dZx6nmEMyv47cAmvxQgWA7wL7RnlzB8/mS1pCjrQpfnczn
	OKUyIgwzxF2GzcetX0zXw2ewBkPhbViI/NLZD0qwKyvhsaHjf5Wuqyyo15m2xX5MeSfX44G4641qJ
	iG3W3WkfLi2LlQgG9X8k9fsnTlMcnlhiXrPDFIcpu0rDacNhCHsTpfkfRnC7kqVbmGhxXIx74UIzR
	icks/XeQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w5tvy-00000001hCb-2RVe;
	Thu, 26 Mar 2026 20:16:14 -0300
Message-ID: <60e35d05911d01bbb31449682c525f5c@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: fix incorrect dentry refcount in
 cachefiles_cull()
In-Reply-To: <177456350181.1851489.16359967086642190170@noble.neil.brown.name>
References: <177456350181.1851489.16359967086642190170@noble.neil.brown.name>
Date: Thu, 26 Mar 2026 20:16:14 -0300
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

NeilBrown <neilb@ownmail.net> writes:

> The patch mentioned below changed cachefiles_bury_object() to expect 2
> references to the 'rep' dentry.  Three of the callers were changed to
> use start_removing_dentry() which takes an extra reference so in those
> cases the call gets the expected references.
>
> However there is another call to cachefiles_bury_object() in
> cachefiles_cull() which did not need to be changed to use
> start_removing_dentry() and so was not properly considered.
> It still passed the dentry with just one reference so the net result is
> that a reference is lost.
>
> To meet the expectations of cachefiles_bury_object(), cachefiles_cull()
> must take an extra reference before the call.  It will be dropped by
> cachefiles_bury_object().
>
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Fixes: 7bb1eb45e43c ("VFS: introduce start_removing_dentry()")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

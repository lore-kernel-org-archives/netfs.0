Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC31C8EB;
	Sun, 13 Sep 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289815; cv=none; b=K6BHmWSEe8MBx7YHjFkKQa3EWvofO+2HU8YAhAYUHlrZ6a7M3e/zIcMIAQQyGL29izLSXlUITFpCCINqI4NN0cxwuzoj/4qiftgle++vIUa0PthKVrRNmHrImrhKjRdgoBhvJHuRGaWHNh8JrOOBlp4ffykANiOJsjg1ioFnxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289815; c=relaxed/simple;
	bh=ZfeqPtAYBOabE0FO0b6gVhk+JMZmLTBvbQjDlUu0+DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBDkpGzglR81v0euk/fWQCg3YcYfw+OTT5WBnNP7Cgur9E705n2QBBWd8w9M+wfQjg08mOgr975ZIsmliSdCnwiWG1N3nIahl0iKMQEeK2AcR/83+BasKz3QwIUXUkBTcOU3KgcBWSalqgXvHgO8k81klL9LrrKBbpi+VcYYe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=APGDO+4p; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="APGDO+4p"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0E99714C2D6;
	Sun, 13 Sep 2026 10:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789289811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zMyDui7pewsquYCfDccrc4Y2pVXLT1eHWR/lH2aHOHU=;
	b=APGDO+4pwpgLMFh9FjESEZbw+bnLnGIIbtuvSrA9sagXGlag7kpb2wvyEuYfuoiEK1XE3C
	gJLkVrildGeJ87H2O9PcEsUWJve/6zCGUlPYB7KtNtqieJ25F/zqIG1adqaZSbUo94iPeP
	JKi9FJBo4bjpm5aru2pz+kMZSUMaIQI3e0Bd+r70eLJhdCqD0KvbZPdehmXNlxrAbWoDvE
	Gd3QaVHUu0B8/IoqS7BQOPo8QDJlYXED+5q/FP9SkVt/oJxGNdXxg8BNyKZ1yFQ5hl/Tlc
	3CNEDPY0/AGAqoxLNvUgB8p2ObH2LWwOqG4VwBscJX6TWQ+jZPi/KFvNvOOAfw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b77b36ff;
	Sun, 13 Sep 2026 08:56:47 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:56:32 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Michael Mulqueen <mike@method-b.uk>, ericvh@kernel.org,
	lucho@ionkov.net, pc@manguebit.org, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL
 corruption of file data on cache modes with CACHE_WRITEBACK
Message-ID: <aqZlQL3-poBn-QbK@codewreck.org>
References: <aqUIEEvKad-o-zft@codewreck.org>
 <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
 <2226525.1789118704@warthog.procyon.org.uk>
 <2718782.1789286113@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2718782.1789286113@warthog.procyon.org.uk>

David Howells wrote on Sun, Sep 13, 2026 at 08:55:13AM +0100:
> Dominique Martinet <asmadeus@codewreck.org> wrote:
> > When v9fs_issue_write() is re-entered, writing the remaining data at the
> > original subreq->start offset rather than subreq->start + subreq->transferred
> > would overwrite previously written data.
> 
> Retry should now be resetting ->transferred to 0, so actually I should remove
> adding ->transferred from other filesystems.

Thanks for checking.

I haven't had as much time as I liked so will likely end up sending it
tomorrow.
-- 
Dominique

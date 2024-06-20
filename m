Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DB355882;
	Thu, 20 Jun 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915728; cv=none; b=VLqhPMwhpP/rxg+akpLHMoywdn5LDgIhI1OyLAjktYWuvoAEbOYhh2B6o2AAs3Eh8FXiPPp1EHqdjMXJ2FuFqFnvxsXFXcuI3D43lbUBjPlHoj9UqHWoekr6H6UfUy28i3ko2gcIktJPLcL/fpvFgR/NQaW+xlZHCmMmmYKfcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915728; c=relaxed/simple;
	bh=rY6eGqJ75wEmGu1HgeNvbS4fJ9EDXfDA5wrtzZT6MjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB/vwWI2RJaChObH7m4JSqr/DJpyMUYzzzFIsNngd1Y8rn9V/bHLkfefxuFq+SG24joTBbaNrcNkfXv2VnjlWokMFsCxFqNcnsVakEDTnTN15rl2mI3AjaLl7SIBxyb97MtdcZvt8EGNgOftf08mbe9B78ZnbYT6Qi7j0YFYuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=h2seSato; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="h2seSato"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CB8F014C2DD;
	Thu, 20 Jun 2024 22:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718915715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaFyOqx3Wna3PHffZA3lbOwaWZobih6I6zyfeyta8vg=;
	b=h2seSatoOQGsC1oNd084UzbsoydUhd9vEuvTIVA67+KxCi+z8q0IS0pjF2KDpOyEXXn6xC
	V5F5tFKch54wcT/63BHhocLiZ4AACqT7Li3GdqjRb9Uoce/o9dTPxiHGE3wZwgzlrvpbcq
	r+1Z8DInjQu2mvVXoWl5Vtyzy4YtD5CUQZ+l8QQu5f6ZIOEm7+irf9TT9TglH+VFtK9Bf0
	bUxiZ+0w0EPSZyZ4qOyV46FOnADlcelQ9/eQBgzAH5dQg48/EYTHDT1P+dqnsewYmXODfm
	X8KMzeUD8xxj/M3UhmTOhPXsiVwITjND5inF4G6cZ4fpaCqg3uxxlbubVPnIGw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9c0e7542;
	Thu, 20 Jun 2024 20:35:04 +0000 (UTC)
Date: Fri, 21 Jun 2024 05:34:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 06/17] 9p: Enable multipage folios
Message-ID: <ZnSSaeLo8dY7cu3W@codewreck.org>
References: <20240620173137.610345-1-dhowells@redhat.com>
 <20240620173137.610345-7-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620173137.610345-7-dhowells@redhat.com>

David Howells wrote on Thu, Jun 20, 2024 at 06:31:24PM +0100:
> Enable support for multipage folios on the 9P filesystem.  This is all
> handled through netfslib and is already enabled on AFS and CIFS also.

Since this is fairly unrelated to the other patches let's take this
through the 9p tree as well - I'll run some quick tests to verify writes
go from 4k to something larger and it doesn't blow up immediately and
push it out for 6.11

-- 
Dominique Martinet | Asmadeus

Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E41437118;
	Tue, 15 Sep 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492620; cv=none; b=Rm8lAeil347nSvA4Fx30/jwubTFD71dtXCQZhBZ7UcUm0cRhJgCYIsryKvqxkMzoaWMjoEoje9ACoOJMsAi6bMc7allkLwd/HyGK1H5gw5mJnvWbYi5P0nDPiaCek053iElEnYzxd0hovYJjmSFQn+nJXo66wmUVNBCYVsxkEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492620; c=relaxed/simple;
	bh=hZgponRuLJY19Gz2NBtmhH8HkvY9RPF/FSkbRjhb+ws=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=RCve/SEQ+W5vczqXmi3I5Bj5XZMlGo0/OM457obeKvVkkhbMD3Iby3RG7JLUsJg45f3AEQBuvs6HwXjuU4AqCIpcFvi1rZ87nwpyhUpZ+tHT8UbN35x269V0HvZ3CKDP78ojQ2h4PmrfRshpswmCRVfeIopbG51yrJul/Xz5vKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=RYtCXnjH; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="RYtCXnjH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WFNuwrvd/wtzkzXvvlSZ5oinYk4fY9Pmt+CxoSiAO54=; b=RYtCXnjHotxVgijwD4b8zgdwah
	QjlG+xD9QvYAvBiqhpDmv8aHQIa+OC2qQH3KRSszawihdQLRW8sB8g5svKuB1a0PpWZKToZvkYBE+
	D3tNETu3PXF7zaHcpZEt5CtxSaTbVWlJqq5R7RJAUBPK9Sb8i1IVbraaA69SqLF1KjufvNujKGPxM
	sjIP0gqud83ldKQIUzWZrb6JoUS3go6ZZHTE5wJGrAth/y8y3A+Skh5lhqdnGXmHee2dC+YkM8mS/
	6WJUIceutMA9tIJt4+tiN2t0HKaz/wUFZcSbj8uSyuzsaIxoMafkkT9KTeFRmH415m+BEBvp92Vwa
	hBKKEdOw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.5)
	id 1x6Wm4-00000001VZE-1NhU;
	Tue, 15 Sep 2026 14:16:52 -0300
Message-ID: <b43959f691534540e12266c38e778a79@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
 linux-afs@lists.infradead.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs, afs: Fix symlink reading
In-Reply-To: <3912795.1789489319@warthog.procyon.org.uk>
References: <3912795.1789489319@warthog.procyon.org.uk>
Date: Tue, 15 Sep 2026 14:16:51 -0300
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Fix the reading of symlinks from the cache in afs by making netfslib trim
> the amount read down to i_size.  The problem is that afs sets the size of
> the iterator to the size of the buffer (PAGE_SIZE) so that the cache can
> round the read size up to the cache's DIO size.
>
> Note that this also impacts the reading of AFS mountpoints as they're just
> stored as symlinks with an odd file mode.
>
> Fixes: c0410adf3da6 ("afs: Fix the locking used by afs_get_link()")
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Paulo Alcantara <pc@manguebit.org>

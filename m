Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CF22D4C3;
	Wed, 25 Mar 2026 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453586; cv=none; b=im3OgvTS2Gd2zziWMfSu6/ROEiGzh76g2/i3HMkJ9Oc60L2B//BbmQIX7w9U1GLc5AG+5BHMnhDpKBgK7/8Xw/LSZK3lpd5pjd+32zFfQW0q+lHN98CqYGWBD8FKODjuR580GZcV1K5WN4oYflTAVGFT37dq3LI8AZV+cJmfg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453586; c=relaxed/simple;
	bh=fQfeO+c3s559NrL6yqHrEqSjict74HyD5RSOuFeFibE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=srpR07mi8cVHHZiTtQFu/4SiwrZkkSQlRL9f0ylOBt+H5JzJ7Fiaytpfage/i/f+RfiYfRwN38DTniyYML3pAhD8nJvzFOf9kzDZ3JTmKOkze3L8rWCh6X0h8DLqxAHl7Y1DvGbMc8LHRT/vWjjSUXS5MovgeisPNiXjom6OcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=6KrGNcGp; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="6KrGNcGp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vtvToygHD/XhQ/RgwXcfB1cu6LKJlBXHH2QlzqxoAkc=; b=6KrGNcGpovKVawiJXiU7029SjM
	HdT6XgGtdkB0n0NVDmrSmgLAlLwVXPQguHfRhmL3LjNcJv+K/kIJjSgwIEVTonL5WACqTooIeu9dU
	YIKU205HJpYUPeF0wOeVBRcte9vPyJO3D575uRpBNQHQ+qsI3Ox+ZFBo/47n/w1Ijp9X1F2F8RvN5
	xmuVHvOqjppYnl9U/sr694RD3RT0Kwfn7y+laMejjjhVJ+Vq5/6Z38p6z7uKEwfC6+oxS7NAnLBSl
	csP5dc61g832G+Jp9EBhBLuy55Ghfehj+MEGMIN2hiWQw0Y5sb6wJK4LKdLNn+xUtasScw8a5cgsl
	a33PcaLQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w5QQx-00000001ara-1ctF;
	Wed, 25 Mar 2026 12:46:15 -0300
Message-ID: <47ff638d0d81bdacc21cfd176d57415e@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix the handling of stream->front by removing it
In-Reply-To: <4158599.1774426817@warthog.procyon.org.uk>
References: <4158599.1774426817@warthog.procyon.org.uk>
Date: Wed, 25 Mar 2026 12:46:15 -0300
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> The netfs_io_stream::front member is meant to point to the subrequest
> currently being collected on a stream, but it isn't actually used this way
> by direct write (which mostly ignores it).  However, there's a tracepoint
> which looks at it.  Further, stream->front is actually redundant with
> stream->subrequests.next.
>
> Fix the potential problem in the direct code by just removing the member
> and using stream->subrequests.next instead, thereby also simplifying the
> code.
>
> Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
> Reported-by: Paulo Alcantara <pc@manguebit.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_read.c     |    3 +--
>  fs/netfs/direct_read.c       |    3 +--
>  fs/netfs/direct_write.c      |    1 -
>  fs/netfs/read_collect.c      |    4 ++--
>  fs/netfs/read_single.c       |    1 -
>  fs/netfs/write_collect.c     |    4 ++--
>  fs/netfs/write_issue.c       |    3 +--
>  include/linux/netfs.h        |    1 -
>  include/trace/events/netfs.h |    8 ++++----
>  9 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

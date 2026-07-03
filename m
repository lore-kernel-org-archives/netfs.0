Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801E23FC41;
	Fri,  3 Jul 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072375; cv=none; b=QPiKd8/4DLCG6BzhSl+lzQh49MEQOcK+HhX8fOHYlwwBDiENbqcBzqjBVEHthIHvdmyru+KN8JxD0MBeLx7hrVNY/e5U1VESVC9FVBCdwgknRLxJhkgt6HlmmzPtE8Shz8YOvh8jQbEpEfYdQHZ0ylpc5lN7AmIz5VoechPFLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072375; c=relaxed/simple;
	bh=x5Ar4Cs+W/l3enbFUq6cKpeeYUVIGEpuC7GzDEdWscQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S2razxP8eniKzjJnXFd63C1a3EbA5sFZ9+WjUBtj2ySbTVvzcDvADoiPftVm+2gfWFSznGHz8+v1qOUdvCMdaI8ZUIdJWD0W0oPGLHM4qy9NapoeQs/JbRZELwfuC3h/q/dPOrP8ARSwfRikFjwCHkouofdbxEAxNUMbcBQ71/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzSamxX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzSamxX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8C51F00A3A;
	Fri,  3 Jul 2026 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072372;
	bh=aYfi1DgYCoqmp6BXAJS3MPwK15/tcRR6Ta96i1fepSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nzSamxX3DRPKlWCO8DNsRMtcVfgvdZyMQa8lVCETjbZEyO7yL/1T+cz6ScZLJ1isz
	 agwOQgU/Dx7D9fFEsQl59pUoe5l+GL/EAfU6GgnxOMgJIzT742wdX4zPQTPlGt869O
	 Hp63LL/En/yG1CZTdtorAJUJzRXjzTIhoTdl38SZrlgPnWHTe1RDKQ9wuh+FvBr8GC
	 ks4OaDxg6WGjd8DOEEvB00FpbG1l6BnRZzy2Th2zFANkldANAnbgXv9zAXalnpnllI
	 nqs5O2FLkGXUOtyKhLuV6xo8DQX1hlw+OlsQn10DRqJaus2TB1ZL6Pc8nRjZzurkYZ
	 +PZ/skzG6pBUg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <138807.1782980582@warthog.procyon.org.uk>
References: <138807.1782980582@warthog.procyon.org.uk>
Subject: Re: [PATCH] netfs: Fix barriering when walking subrequest list
Message-Id: <20260703-fotokopien-durst-hemmen-be0624293ef6@brauner>
Date: Fri, 03 Jul 2026 11:52:45 +0200
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x5Ar4Cs+W/l3enbFUq6cKpeeYUVIGEpuC7GzDEdWscQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5txWl/JIS+Lwoq5yl/02fqO62uKwZoe5x1z3TA+a+N
 G77t7eso5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIPfBgZHvd22D9ZVWKSPlUw
 2GnSugMpx5MSf/NccVVZGXF+LrvGbEaGGw4X/z0449F/79ar48feGe+50lijcfbDkvYf6ZueBG0
 TYAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 02 Jul 2026 09:23:02 +0100, David Howells wrote:
> netfs: Fix barriering when walking subrequest list

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] netfs: Fix barriering when walking subrequest list
      https://git.kernel.org/vfs/vfs/c/5c6ce05e4065


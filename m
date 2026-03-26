Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB013FA5C3;
	Thu, 26 Mar 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534780; cv=none; b=rBu2+ZtN//4cKkcHqtOvfhLKWRYojK86BtP6RmJ109AvVoXVV3/SibQTyyUlIzY/Nba75VVJVc2+dFhR1d2oLKU9SxkRPC1Auvu1F3hXzmxG2qkhtdC3nmHty4L0sHk62Gqcc9XBdLHTmPNvPzqSSNPh/ocd/4ZKNBPS0G/8Io8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534780; c=relaxed/simple;
	bh=ae+8E4rgiKK7U6BPSk+L7P67HpJKBXeXYEwDqqy/CEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdkL76IvWyKyiNaEztdrvc6lPP1r53K9p234i2VzkI76GoUd7Nm01lJhwQyoYJKOGCaB3iDy7z0+vzuMIFc18PrQywNDjLm+N7zjwNcjy/jgX0EqP96SpWngQNjV+pCzpM5woR3d0OKYHBpLwTUSJW+m1jkMH05UJuOdCIhKszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7Lwv9sj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7Lwv9sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B6C116C6;
	Thu, 26 Mar 2026 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774534780;
	bh=ae+8E4rgiKK7U6BPSk+L7P67HpJKBXeXYEwDqqy/CEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7Lwv9sjGtzwRBd2jinx6Y8qazNUDDr+p6RNjz9Wmq5kZ1NqC9Q118hlLsP/QGiJZ
	 G9oGXd9Q8kbVDNW8E08tsfDD0wIwdJNzHrquzZZcCFiENJ1eanqWc8vSk6xkBmy3kr
	 beqhK6qTbvrSlmlLo0zTOiDm/yAI7srfGRlJxJdtp1+8XeTAohBE+Bv7dQuu4YDEcj
	 UKFRjiM/oiw/MigNDz+h+y2BWORSx2r3TBL+g2ix6/S42KCCGcuEvG5/bhs3ZhoDsT
	 +NY0jJR0yrEtOprAxmfioIbaQ7eyP7Zn0Iign9IC9UBV2TO6DlM9L1INrUURyJrpXV
	 MoTaN0VHUj5Zw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix the handling of stream->front by removing it
Date: Thu, 26 Mar 2026 15:19:34 +0100
Message-ID: <20260326-umeinander-umweht-e3824cbadfd8@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4158599.1774426817@warthog.procyon.org.uk>
References: <4158599.1774426817@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=brauner@kernel.org; h=from:subject:message-id; bh=ae+8E4rgiKK7U6BPSk+L7P67HpJKBXeXYEwDqqy/CEE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQedShvXn9w4p+8H5LrxTYpqYluj1sUaed/+ZTV6XVp5 vMzg6fe7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1AmMDLOPmYnMK95mlnZb 4/29n5+87ldGiQYcLn1j+mOi0qtJtw8x/E+3ylkseU5LYFO+qKZN88/b3SvfZ/0I9770Y6/dAfN cARYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 08:20:17 +0000, David Howells wrote:
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
> [...]

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

[1/1] netfs: Fix the handling of stream->front by removing it
      https://git.kernel.org/vfs/vfs/c/0e764b9d4607

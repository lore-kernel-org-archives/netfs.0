Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9113C3446;
	Thu, 19 Mar 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915635; cv=none; b=cD9sxd741oit6C4URDj8GgkoNTZ8rwdcoNEYMOX0et5FEqTgGBrpuIjuA8z+U+SivgTknmPibUFwNGHP/GvvcB8ZfJXr/6nK/IeesdVx5LZ4pAhAUfUWsB1yIK5GRYhcJe8yXi2uhVMbEXXrsA7IvzrGHjp4tC2DKX+xlE1Hpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915635; c=relaxed/simple;
	bh=uAj0AsIG9LNa9IceShPz0DbaNm5QZ/tNIVLq6LD50qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhKjfNJuUbRwyAKSuoog3Z4LTfDzUPHPhiKIjS0E8pq0DVx/XNdX1mpcGk6IMn3LDVKTXX9DHimcSNYqZzAdWElG3sA92k7zoRGsNHoVbkHM7OyH6AfjX82dbsfQ7iOfaRlSqkPx2VmhUYKkft951D5/8c7PYrq/WbeMYoRjhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKIFOSIy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKIFOSIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A67CC2BCB6;
	Thu, 19 Mar 2026 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773915635;
	bh=uAj0AsIG9LNa9IceShPz0DbaNm5QZ/tNIVLq6LD50qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKIFOSIym4zCPO1StlKWss7JAwUuhqZG3giqa25IFWV2LOd/ZnMyn4BiTb2xkyudj
	 /S1BCLcgUXBQFu8CM2l39gf2OV3TPJnBl6Cilezw4e7YFR82NqGE048bPVJeDawgrP
	 flwje5fVnmWKQTfIENfq73JR6JVqfyXTPXPwr0FB1DDQe4jc32l45Ojgd3+ADFbZBT
	 msecQjJVlbaaNLR3+HZiUI0lolfhQwXuatU9MAsrhTPnjidu+pkuKqhjummXKTy9yf
	 ygQlxQ7HHy2ncUyaeT9bLRlCaGyZR2yFPikuVzLnJk6yScv85qqEL8PUnS5142lVEh
	 TmCB9bkZ3lB7g==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix read abandonment during retry
Date: Thu, 19 Mar 2026 11:20:30 +0100
Message-ID: <20260319-mietschulden-erbeben-9de8101da585@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3775287.1773848338@warthog.procyon.org.uk>
References: <3775287.1773848338@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=brauner@kernel.org; h=from:subject:message-id; bh=uAj0AsIG9LNa9IceShPz0DbaNm5QZ/tNIVLq6LD50qk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTuPvvu5TKugFexemfVn21+9VwgeV7KQ2nrykvC3478P KW+ePrptI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJaNox/BUXePCqVmfFyojf tup7Nzxo8c/5xLGzgdvjYP7CuIRoZVVGhu9KPz3KYhzPzlN73PlkeZVL8Pxi1XzhszcfKul1upl b8QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 15:38:58 +0000, David Howells wrote:
> Under certain circumstances, all the remaining subrequests from a read
> request will get abandoned during retry.  The abandonment process expects
> the 'subreq' variable to be set to the place to start abandonment from, but
> it doesn't always have a useful value (it will be uninitialised on the
> first pass through the loop and it may point to a deleted subrequest on
> later passes).
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

[1/1] netfs: Fix read abandonment during retry
      https://git.kernel.org/vfs/vfs/c/7e57523490cd

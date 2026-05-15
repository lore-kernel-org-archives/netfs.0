Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070F3B38A4;
	Fri, 15 May 2026 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851991; cv=none; b=RiYn+y5iQu3Nn8tGbOu0dx56EFfVf2oP9Y9GGqgtYAhTMgYxbxBNmBU9x0xXT4M1iEy2vxCfb0T4G3zeJ5bJc98bgU3/AEX+arPqjDR96RTJiLbOmadP3jmnIJYKcFFD74b6ETcofhe0GRa/1nKPG7K+moU60JOyF2KPfyCcaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851991; c=relaxed/simple;
	bh=uCCYlDtoxu2mmphQViAU7ngALBim3AS4zCQ5qL89txc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+i5a+LlrKxkhlwfktSMjUYDbFcrjIVAv2426Oe15zLVNVK4D/powiKMKFwLzaXrAsndMCjNTyo8xE8HPWQ1JZdPL/tgP0pbQebNHXw9e1Zfy1AZN1sfZHl+UfI26LTTyDBDJHNnppM9FZE9L+xgb8q6sH2ypChBYX7E3mwhLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTPwLPTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTPwLPTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCBCC2BCC7;
	Fri, 15 May 2026 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851990;
	bh=uCCYlDtoxu2mmphQViAU7ngALBim3AS4zCQ5qL89txc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTPwLPTu5bVyO8bR4oDmSSPOmYYfkc/ERPThwTX+6ohnwtME/SByQdjesF28npCMK
	 ZrVCCi7JJuGjMUmNVjYS4+oqTH0A6ylyZvvfuWL9qc0q1DfZwv+ibwenK5ge6jv8ps
	 XhnPhwQVTx9gKwZRwpDpOJVb8VVjAGW7fiOFwSf+FsgsNnVSoeGm5dscGHMMTpqOlc
	 RL7UUn3DKUUzO1U5QuJQkfisRn+gPTgCF5Dgd9V/6823I564OKxzpnahCN3pygQwzR
	 qzNfbvbGDbTbsJmOJWYuP5XAGiuY45Vbra7I88P+0T1C0Yi7ZROT73N2EXQ55v/h2u
	 bOyhZcA4CZfkg==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix error return when vfs_mkdir() fails
Date: Fri, 15 May 2026 15:33:03 +0200
Message-ID: <20260515-rosten-antik-07a1eec2b142@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513103406.202320-1-zenghongling@kylinos.cn>
References: <20260513103406.202320-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=brauner@kernel.org; h=from:subject:message-id; bh=uCCYlDtoxu2mmphQViAU7ngALBim3AS4zCQ5qL89txc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSxK0w8Z33cZ/PliT21r10XT259HCpqn+4/5bisyT2O8 vX/H4pwdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk+l1Ghl3e3hv8VE8ybb49 x+3tzs1PEzhXKMwXzltukPos0V18yXqG/y5HhPuXeJUuKNk/8dOr8t+rVB0vqzdaGF/d/jFnd9v aizwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 18:34:06 +0800, Hongling Zeng wrote:
> When vfs_mkdir() fails, the error code is not extracted from the
> returned error pointer. This causes mkdir_error to be reached with
> ret=0, which leads to returning ERR_PTR(0) (NULL) instead of a
> proper error pointer.
> 
> Fix this by extracting the error code from the error pointer when
> vfs_mkdir() fails.
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

[1/1] cachefiles: Fix error return when vfs_mkdir() fails
      https://git.kernel.org/vfs/vfs/c/8a220d1c312c

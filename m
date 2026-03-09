Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236B3783C5;
	Mon,  9 Mar 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047852; cv=none; b=r/6+IE869Go7MLOi85s6QOQ4TG1m4XfqH1Gx5zZ+IJripBBKRYq6hBaF43eDuRUjSIGUuHMLTWOX/62vdigH4zZl5L5O6pwxsxtV2trNDyCV2evPdUwkAutoErNabKXApnGPA2TCLflOZFEkfKoCjvN6ZVBsiuwn4m79WGV6i8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047852; c=relaxed/simple;
	bh=8AVx+6PpZLmeEmZfmErpNzzwzguq4bd/Ps3vZTGRPyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nyh5R7kxQQjeqlSqPNsqvqNFaFO0rBsGzgkOsJ9R2WuW6Q2UiWJXKrVWhosioivD4TV7nT/FLVFJkPouoO4nkk7XfLKKkn42LhMDvWeNPqERvn7KX/rw0Nu4Wu/a2t5L2Ax67U5h19+0WcLHmJuqqaLsKC++Ay7c3SadLZUcLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqcNBi/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqcNBi/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC440C4CEF7;
	Mon,  9 Mar 2026 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773047852;
	bh=8AVx+6PpZLmeEmZfmErpNzzwzguq4bd/Ps3vZTGRPyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqcNBi/ONNrbMjCW+oYZYLfCAwVlG8Iz13Zu5/5AgoWEPMuLa8fl3VH8TETzUaGuo
	 kTSs+hOvpMI7WGuk3G8HBSQgFKv2FeD2lk+57na/MGoAQ7jjFgMUHwXiK6OVVCOtw9
	 Gx1z1Jb1psKwJXX21eG6zxv5hY+5eaTbAfY7CLmZbJyxBte/6K79QZzHXll3TpOYzh
	 D5qvpiAuYbO+bQYKavPQt7khDqJPslzzPC2AIXQSDe2PzOEMyTtXCyksGjW+rDmDZm
	 vj6CyQeokqMin00Xa3LGmntftm31KsFWwGy4ZdXDiVPQwz2XEkJEp6SuPFoBD0nxk4
	 6lvzcaBY6wMIA==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	pc@manguebit.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: Re: [PATCH] netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
Date: Mon,  9 Mar 2026 10:17:24 +0100
Message-ID: <20260309-stemmen-gezaubert-dc04924cdbc2@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307090041.359870-1-kartikey406@gmail.com>
References: <20260307090041.359870-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=brauner@kernel.org; h=from:subject:message-id; bh=8AVx+6PpZLmeEmZfmErpNzzwzguq4bd/Ps3vZTGRPyo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSum6DGuEPr5yqmprmr1idPK1pwuPG6Q5Jj/aylLu+cb i+t4Zt2pKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiVmKMDCem8DMVb26fzB1Q 1npH42pYwoLLft96hF7KRGn3Hl3N5cbI8PPE3QcdP5a3nHb4o8lT9zY389lFoefZ65l7p9nWtC+ X4gQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 07 Mar 2026 14:30:41 +0530, Deepanshu Kartikey wrote:
> When a process crashes and the kernel writes a core dump to a 9P
> filesystem, __kernel_write() creates an ITER_KVEC iterator. This
> iterator reaches netfs_limit_iter() via netfs_unbuffered_write(), which
> only handles ITER_FOLIOQ, ITER_BVEC and ITER_XARRAY iterator types,
> hitting the BUG() for any other type.
> 
> Fix this by adding netfs_limit_kvec() following the same pattern as
> netfs_limit_bvec(), since both kvec and bvec are simple segment arrays
> with pointer and length fields. Dispatch it from netfs_limit_iter() when
> the iterator type is ITER_KVEC.
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

[1/1] netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
      https://git.kernel.org/vfs/vfs/c/67e467a11f62

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C6378818;
	Mon,  9 Mar 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048142; cv=none; b=IJ9WRZtDwELbJAEC97Ix9oXCKf5RjRzwPXnrdcAIdExXt9/UzRzjr6ecYiib3Z7nY3+sMjMVJXJYV08bpQcXf9AXzl1sJrXH3XsbKSslFzNUMzzL1oD0X7vTp2tR1aGjU4SpNRRsGT5h6PovphZtFTc8zPFRkPlqTQ+dRB1pWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048142; c=relaxed/simple;
	bh=NNRrhOP95yIU3huGoi23y9116OgRi4u7uiC3KLgFuJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S84wzcGPz4/6GkIZeCWS0b5m+0UFlUKY/QtW2cEmu+zgFHV+Yu4sPcfSBXx7bx+eTIle2h5HLzIbwi+cOW1RgQn14QJ+xHEJCLlOmlJ5JfEZZeI6ZgPxkPFNc4l04qv09n23ktJw6ezaTRwXiSn0Vui7v8IThYUEnXrKP4JHVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmdsx5s9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmdsx5s9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AEBC4CEF7;
	Mon,  9 Mar 2026 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773048142;
	bh=NNRrhOP95yIU3huGoi23y9116OgRi4u7uiC3KLgFuJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qmdsx5s9CMyxp0xM84f40rRsgBIYP4uv4GL/LV+XNH/A1HNUCng+K9EXGmgwKiorE
	 ez42WmXYRzbnrGxJdNQR0iqxvS5t/WlcBRKhyk8cny9KIc0X9mdAhH55pANcjSL3KT
	 b66bPnZYjVqaqojgSS+USzgsBZm0jPHas7lq5mvC56Q357e5uRyx9FBVM8sKyFp5Se
	 l0kxEH4YZcQiUubwseGTD37t36s6Sa5XSNTymcc+waoVriHVdMq/JRr1kfTM0PPee8
	 K57Y8Jh5jreW/iiRV47B+eCh3+kg2//y+GTLEpHDDjx8jCMzBTtL7YIkGTUjtfdk9n
	 hphV6LKW4NIeg==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com, pc@manguebit.org, 
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com, 
 Deepanshu Kartikey <Kartikey406@gmail.com>
In-Reply-To: <20260307043947.347092-1-kartikey406@gmail.com>
References: <20260307043947.347092-1-kartikey406@gmail.com>
Subject: Re: [PATCH] netfs: Fix NULL pointer dereference in
 netfs_unbuffered_write() on retry
Message-Id: <177304814006.2374995.6514193767382546447.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 10:22:20 +0100
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-83dbb

On Sat, 07 Mar 2026 10:09:47 +0530, Deepanshu Kartikey wrote:
> When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry path
> in netfs_unbuffered_write() unconditionally calls stream->prepare_write()
> without checking if it is NULL.
> 
> Filesystems such as 9P do not set the prepare_write operation, so
> stream->prepare_write remains NULL. When get_user_pages() fails with
> -EFAULT and the subrequest is flagged for retry, this results in a NULL
> pointer dereference at fs/netfs/direct_write.c:189.
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

[1/1] netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on retry
      https://git.kernel.org/vfs/vfs/c/e9075e420a1e


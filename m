Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F00377ED9;
	Tue, 23 Jun 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210514; cv=none; b=lrQITtIeoeoc3FfhAsQbKSG85EYTZu4x4qXVoZiwrbN9AfLB2OrdN/69gy2dpPmUyoHSTW8rthLMLI3tqjl0asrOU53x4vHD4MOjjljgRhih36Fuh6W005IJe/SDCFrDcyCLpyVpBlnUsNS5gIzFHSD6Dy62xUWNByCQTXPPWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210514; c=relaxed/simple;
	bh=bmvHcYHnkNwBomC52bCwlpIpvDEl/JgLRhPO+Sif+rU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fV3cMjAm7V0VdoPeZ/xYvtMI/gK3U/InN+p37fdVYhaVH4gbiv/CCD6m90hw2qO7z4SrT3PyIR3dbnvreMwJ8gjSHctwmViKHYG+xYClecBsuviY9ahiU3FYQrbCzF0esAKXL5+aDDZLA3Cp2ItvyVb2aBcoaUAmcgiEOLyAezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLrtNyL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLrtNyL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47101F000E9;
	Tue, 23 Jun 2026 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782210513;
	bh=iRFFbFuE0WBfZ007mZX9Zz4YpDYpv7dY7dfYOCrsYgY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=SLrtNyL32JTqfP//FzIP1FTMjBswN8fQWy0xtFOB1VkIuA6tFgfQ3ZNEomUm0EJGS
	 xmE63mt0Xq7vTG00o/ctYiMNPmQkm3PhAlAUcNYNYFu/s1tA33h4yXexa0gww1GG5R
	 5joJMt5tQcOclzaiZENnFFeEv5tPE8qW30tzMk6Av9ZxgdLVfPciw98hDgkcTU1WnE
	 fZXcb5Xh75ON3AxK/tEQuB/sT/hsjPps8Wc/sZWlh7KUlxbYMleB2YylpKhdmTsffh
	 PrnnExKroxRvacuq+ECx0r3WYEg6IZNRrfHnCnQsIy0TTDOQb+iUDudZiDbsm6ZzO/
	 ew7lG4jTu7WzQ==
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed
 preparation
From: Christian Brauner <brauner@kernel.org>
To: hongao <hongao@uniontech.com>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
In-Reply-To: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
References: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
Date: Tue, 23 Jun 2026 12:28:29 +0200
Message-Id: <20260623-verfrachten-normen-guthaben-80158e85ec82@brauner>
X-Mailer: b4 0.16-dev-8bbda
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bmvHcYHnkNwBomC52bCwlpIpvDEl/JgLRhPO+Sif+rU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZxZ/XS7ZO8RVnDBWYe/Tr1T+xJ8tTmdg+TtF3OMPOv
 UV8q2FtRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETU5jMyHODMvPc1xvlA52lL
 Q4Wtu7Z90xJ8niT49EEm1+pr5wv/xTL8D9FtsSzI6VgkovNpq5Z/n2d7YoPOkoy4Hx/jLaRbQ/6
 zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-05-30 09:14 +0800, hongao wrote:
> If write subrequest preparation fails, netfs_unbuffered_write() calls
> netfs_write_subrequest_terminated() and then reads subreq->error to set
> wreq->error.
> 
> However, netfs_write_subrequest_terminated() consumes a reference to the
> subrequest through netfs_put_subrequest(), so the subrequest may be freed
> before netfs_unbuffered_write() reads subreq->error again.  This can
> trigger a slab-use-after-free.
> 
> Save the error locally before terminating the subrequest, and use the
> saved value afterwards.
> 
> Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
> Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
> 
> Signed-off-by: hongao <hongao@uniontech.com>
> ---

David?


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676593939D7;
	Fri, 25 Sep 2026 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352483; cv=none; b=Kf+Bm/lvL1LB7en3KgGBy4dQRP7EFmB30TP86IkeSiXNS2+9hJGINe/Fg6hCfFkdpOxt1KLXvkRyqVlqyow0ohZ2VRdogYmYyntNZqdqVsHHIHF0958MV4Kg9r210Jh0PC535pNoT0xm7hbcANc29nlhFiBXHAgdKHHOG5DeMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352483; c=relaxed/simple;
	bh=nS3b7hquJGdw8h3vzq7afMXon8vQNmcTkIRwXL4eGls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d6f1zxQHwII+cN+sIjgXlIt6z+/IR9rE4fakMXbT3FOb3rlaTQu92jkpoWPBQqM8pn7MFrUtzCp1ZWMqSyXmb09w3F3+6ohU0oW4YtSDPBn285souCnQW1FSk3wSqmtcElubskhw3CqauWFFrK/fDx/fRRjIlxy62/dHpsP+8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2NK4vA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2NK4vA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFF61F000FF;
	Fri, 25 Sep 2026 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352482;
	bh=qJMPwoHXFGpzjeH31/tvqLRcRcV7lfXRywlEzGMftj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=o2NK4vA8XlB52zrMJ449a3qTLw8kqrdC0C6NyDo8MpfhpkL7OSZ7aa5cFfJv9ww3K
	 cNHwuE6/8idDUcObGVXVygiytzEQBono2ITV/0+riDLzL5uDCM3SjHGP87mRQXHRMF
	 U9ssvXlZLNesggoI6XreLhfdJAZvdJxnofJjfE3JjdCaa//HaKBATvv8DdgFDzriGC
	 1//GTDq6vvxzMFxgA+YgTtMZbOKn07tMIWkmyEBSHRz/4rIeqg9ZIIQtFhSSot6E2m
	 udxIcnJbVt/9n/u5zYDr4IIoGd6NoR+UIifwN6nqaUCagf/HZhhrIBrwmuL1aJSIRf
	 qB+sYOrL+EvWw==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>
In-Reply-To: <20260918024040.338737-1-enelsonmoore@gmail.com>
References: <20260918024040.338737-1-enelsonmoore@gmail.com>
Subject: Re: [PATCH] netfs: remove unused fscache_internal.h header
Message-Id: <20260925-klima-revision-verwoben-67d88abc1af3@brauner>
Date: Fri, 25 Sep 2026 18:07:57 +0200
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nS3b7hquJGdw8h3vzq7afMXon8vQNmcTkIRwXL4eGls=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtmxN3NWVa9d7stwEHroY3eFt9ZLdbmzJh+9btHN33f
 YTLZsbZd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkkQ4jw80Psfs+Opf6VhRY
 3HCY+siQR+X4vFLelIn73Yqem0xkcWT4zTJFyZHjn/Fa/ZUZLzU+7p9puiA23lPfZcnS/euyGTQ
 7mAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 17 Sep 2026 19:40:37 -0700, Ethan Nelson-Moore wrote:
> netfs: remove unused fscache_internal.h header

Applied to the vfs-7.4.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.netfs

[1/1] netfs: remove unused fscache_internal.h header
      https://git.kernel.org/vfs/vfs/c/d439f95953ab


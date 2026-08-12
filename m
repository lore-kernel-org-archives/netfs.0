Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D4455185;
	Wed, 12 Aug 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544783; cv=none; b=BMxWcS1771JEYvSY9LWudJsey37GKJ5+5dIgLJAY+oo1UyJg+YmRHwriJ+8OIRwjalSq7dSgzczj/FTCllrrCZviei6zkpuxJCOqvOW/WYrUd5V4HMs3h8KPh28Gm0fpO1U0di3MN98/M35Dl96JNa2j9+MkPypg9bIn7C2bpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544783; c=relaxed/simple;
	bh=kf82btbWVEF7ldoT0M+F8gWvP8RldYftJie0/C8/1RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKWuDBbKNs5DlsiqBouzdl4glYFFltWftSq5EHt+XAVrUO3RuU7Yp+Xa7dajhEFDllOTra9q4k4mwWN6hLzaa4I4aHH8F8SfdbzKqXYKGBd1udONg3rKT/7g8TRSWR0kaxQuCT/0kCcoTjz1Vk/m/KdjAr8ax7ES+WxCFkihxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP2idE8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP2idE8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165021F000E9;
	Wed, 12 Aug 2026 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544782;
	bh=n0+XZgok1eHql18L7XHMKns591enUwwfrPR1jXjyqIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lP2idE8G4Hw9D9Tma0zrsBhKrGeKkaRQyzPS2IrmnXsS5l2AeqzWnw2LtDafEn/Ci
	 LpogMrhm0LLU4sDudrL407ywKSM3QvdRzmlsO7/DXPlOtMA7NWq1iDcUUU6hjTzqof
	 vzYiUldN3c0idffj/EaYpC6zmSKCyfUh2jwfD+cYlycpVjaFUvIWRt95PtY9szVBWr
	 seJdC7ag/hVXZMb3IZ7Ce/0Te37m+waFSihzCK7xGKVIqWz0K5bpyVVBil6vI7rfxE
	 iJtqEFu0Qf50Uy5nEPOJoDEhYgKniWQSgu2lbUlnz66iVZHdTej9a769bT9hfomxcc
	 bx52NelttEZlA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
Date: Wed, 12 Aug 2026 16:26:12 +0200
Message-ID: <20260812-gegeben-messung-weltgegenden-8491254df0e0@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1046393.1786544127@warthog.procyon.org.uk>
References: <1046393.1786544127@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=brauner@kernel.org; h=from:subject:message-id; bh=kf82btbWVEF7ldoT0M+F8gWvP8RldYftJie0/C8/1RY=; b=kA0DAAoWkcYbwGV43KIByyZiAGp8goigQJZBZ0vpz73ayYqFRuXcPPtdGeUSdfbXGadNG8aZO oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmp8gogACgkQkcYbwGV43KLCVwEA2KA7 +HpySt6MAFnPPRpzqO5RdG8hsjdBt+VmjmloJqEA/1sQ4QMUc//v2o0fb7V44BGKPBq/w3tCBN9 0RkPdYEoC
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026 15:15:27 +0100, David Howells wrote:
> It was an effort to enhance fscache as a kernel cache for lazy
> pulling (at least according to previous Incremental FS discussion [1])
> and EROFS over fscache was the in-tree user of this mode.
> 
> fscache has since evolved to be netfslib-oriented, serving network
> filesystem inodes via the netfs library, but EROFS never acts as a
> network filesystem and we need to cache golden filesystem images rather
> than individual EROFS inodes.
> 
> [...]

Applied to the vfs-7.3.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.netfs

[1/1] cachefiles,netfs: sunset ondemand mode
      https://git.kernel.org/vfs/vfs/c/949eb95d5bcc

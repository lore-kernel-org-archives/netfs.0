Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7902BE63F;
	Tue, 30 Jun 2026 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808741; cv=none; b=skGzcUEmHuPZ3JX1Ad2NxB8v812hMe41ZrP2VeyVIvxfr1rJ0IXIW78tFtSxeGhaeslS/QJrpuqvpNOyXw5WzeaVZKm3tFRT4PXykT6YLW6GxcpghIFe9Nc23JF44tJFVqjDPkzPY/VSg8w7oC1PBf+3+tNI7cHrflYc7eBPEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808741; c=relaxed/simple;
	bh=p7NcjLTCHAU4XGeKVdGFtERbLu1j9f6AIJejEQVyaXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZtvEsabn3piBBpv30pGPFn1ZeYPLdjxnpZ0MUvDrXpB6WCTY3tn2GoGTEEmG6bZzTi6bu/jqf0QcdnQMq6XUZU4J5HJp//1aoIKwA0sqaUOLJRHvEX46fa7NeozNykjm9PamTdiPbCwvv4JPyHDDdOHCYLnxePLvDeHDr3hjbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdtT64cN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdtT64cN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77E01F000E9;
	Tue, 30 Jun 2026 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782808740;
	bh=JO7K29wF3xs9lZKgiCQ4LKYyHpt69w1WzAX+Sb4mevU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EdtT64cN1QWmxC5MRlpo3ue31LOo4IMbvc2tKJzYDbxZzfAX3cHq4BSsk+W/VPpZq
	 TmeY+OPVVJu86LetbhkOwcDtgTkMvAeAzlqlxH+/2MZq1pMWoB7ZjuQ+W6RhHGWfcs
	 ZYwY0vJLltEPVeInjxbUc2idMu6GLFiKO5RF+KfiSPemxWt1TnC29WvVdJWSoBSaX3
	 9osdn41VDsk142mzcvfCssPWq6RpuowoAYntBA/8VSuZa5KZ4VMfP7GMw4pF3IlJMb
	 PxZwNa/Fl6X2yN7wEaewl3K83i7BpzOBwf/W2SPZ3h4KZ5DqOOaUOwd5x9FgrX/hL4
	 s0Kpqizorm+sw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Prashant Rahul <prashantrahul23@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, netfs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260624-netfs-doc-fix-v1-1-d826fc570a2c@gmail.com>
References: <20260624-netfs-doc-fix-v1-1-d826fc570a2c@gmail.com>
Subject: Re: [PATCH] netfs: Fix kernel-doc parameter name for
 netfs_resize_file()
Message-Id: <20260630-hissen-lesebrille-zieren-7cde341435fc@brauner>
Date: Tue, 30 Jun 2026 10:38:40 +0200
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=brauner@kernel.org;
 h=from:subject:message-id; bh=p7NcjLTCHAU4XGeKVdGFtERbLu1j9f6AIJejEQVyaXg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5NyxS9Tg5z/9q7dnmLZ6e9S86bV5W/ea58ixWhT9Xf
 4F5FztvRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET2Tmb4n61sWCIREzK1v/LW
 OrX9LizBMZ4iBdtOiWiz11ouEg73ZfgrvPFM9Z6fuWzL95xRkPvW1iY1Z5aOyORanh83g/d0PFj
 FCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 24 Jun 2026 18:59:29 +0530, Prashant Rahul wrote:
> netfs: Fix kernel-doc parameter name for netfs_resize_file()

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

[1/1] netfs: Fix kernel-doc parameter name for netfs_resize_file()
      https://git.kernel.org/vfs/vfs/c/fcaf5da60beb


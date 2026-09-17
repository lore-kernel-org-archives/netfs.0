Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DA3921C1;
	Thu, 17 Sep 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640879; cv=none; b=opiSZC2p+U7SFkY5vdG3blrB2Ew9bzhYP7+Q8ZC+KigsCrqurdTqecyRDRIe6OBJEcDr68KXCLoYE6O5TbB/tUMHhAVAdx+0mc1xSBTSAukHLQRrfoxPtV5Z5NowCUl01INfbgF2fNv4OwY0ooyWjOo7qjSx5rJiCDBLwHa3fzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640879; c=relaxed/simple;
	bh=MjxPemX7u6QvWceCtzXMtGre1zecfRugdHyEfrYesZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP36/AuWTJX4I7/M3LAITtluDFQgCrhpN0RLprZekfnlxTR1nuWKaNobcYLeozB8peM1tdFtPXOjYr1e/22lQpJQngcCIyjavbBTDK+xczLojO0qJsm7BodMe5fVVGxyRQ0Rr64FovC+FhS0itndJxfepCj94fKzTJluSaW1lCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1HiC3u3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1HiC3u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACCC1F000FF;
	Thu, 17 Sep 2026 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789640875;
	bh=orbnNtgIcmvlUMlvcfVnBTDTsam1qoFJ64c6f7ycEpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1HiC3u3ExvQ9fqZxKoWkDm6EilWVvho7Gy4x3NMxgGrZs6J20HUtC4R1dZN7LfKz
	 +jcby38/N8WJ1p2sTeRE2UJrs3lTNnRn1jw9tMOcqt79ghUF2EhdVyJCFqx6dfc+zQ
	 S2MWHmrrOB1TEn9TsvX6GCEWXwe75z4ZzNsAy3/RRKWhcAgqQ92kfzzsFSZEzX00kj
	 4Qklg0GyAIW0XcP+puKjg5rTyE9OAEoIEqYJN15F9+Mr/N3qkniBKO1vdgGHaNSlLL
	 BrhX710YfVVOdwGOQz07gc16L3RwmLOeWVpUUoAHpwTqRqmWIt5/p65tIHNOjbvES9
	 yR04F0oC8/2+A==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs, afs: Fix symlink reading
Date: Thu, 17 Sep 2026 12:27:50 +0200
Message-ID: <20260917-allrad-zerreden-gehen-fb6dcaa8dc0a@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3912795.1789489319@warthog.procyon.org.uk>
References: <3912795.1789489319@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=brauner@kernel.org; h=from:subject:message-id; bh=MjxPemX7u6QvWceCtzXMtGre1zecfRugdHyEfrYesZo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStPrDsXc80j4e5/eIH+te+Ssu5Mm2r2NaHE/ZY/N44/ eLbrLO7T3SUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMZJY5I8ME9d0NQf+WxnPf LG+TeF3uaii/fvnsW29F/C/c9DmdzPOWkWG9VJneyr1XilRNDrYKyh641pKT76c6uUu5xUooyOD qNxYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 17:21:59 +0100, David Howells wrote:
> Fix the reading of symlinks from the cache in afs by making netfslib trim
> the amount read down to i_size.  The problem is that afs sets the size of
> the iterator to the size of the buffer (PAGE_SIZE) so that the cache can
> round the read size up to the cache's DIO size.
> 
> Note that this also impacts the reading of AFS mountpoints as they're just
> stored as symlinks with an odd file mode.
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

[1/1] netfs, afs: Fix symlink reading
      https://git.kernel.org/vfs/vfs/c/c51e89c5b5db

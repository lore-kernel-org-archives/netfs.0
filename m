Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236E3D890A;
	Tue, 31 Mar 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950746; cv=none; b=kidBCLfbPP5IJp8ANz7PhQd/ep5syC/LUTb3p4BrUZQcibngrrnH1/2Wy09ZJoh0BmTJc5hSobxSUgzYuQAHwJHiOgnuA053ETNFT6JTJpAJ6OnxvB3LnFnkAfTYtFFXmyCviQhykDdTzpUdrql886AedStnkGGgpQ90VjIj0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950746; c=relaxed/simple;
	bh=17qLFkIbQA2q1tAC17tUA3ZGIC5prgMJ3fgdS0mLA4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRIwd1FdU7EBTqyTEhkoLwhfrFQMmgWUHMWLvre7GBjXbu527Pye+4LUO2zGaCicU1TFDvDzORXbsIP7BQglvsfIkiKHp82V7jGMggFDPQKneetyHR9+uTi2lKXWv02x7XlbKxYJz1NkRXhJFf5RuL/zUdTquhDF+Quf/Z20fTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqr8r1bB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqr8r1bB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE38C19423;
	Tue, 31 Mar 2026 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774950745;
	bh=17qLFkIbQA2q1tAC17tUA3ZGIC5prgMJ3fgdS0mLA4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rqr8r1bBFrxo8SZkPBiPt6zvkGrDgZWYHvbpcXTiwzJnMYMDe4YOEcMJljdf8emer
	 hS9J33wXjmqX8Kiz4cDsDFBbcUIEd8ueSJD5GmUj6kagywoxLpPhjvrhPmt2Dspo/y
	 OQQAnTOcc315TvSU8X6fWcXq6fGoa/FT8O7r86JraVo0AFkUTMXih3irZ/VOTmUyQo
	 pRLWOAxGehAqhrn5Q2ayoTZCyoY1rsTuzNSa54F/HluLHlV7d0NlrbUoiFMWvlzA2v
	 t5gFw2u1WJlYY+/FxaHta63RzxtKrYcnY1/QV/ADoWGbp1rg8kvlMHnINy74Q/ovF6
	 EFCEaPpzQ0JYA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: fix incorrect dentry refcount in cachefiles_cull()
Date: Tue, 31 Mar 2026 11:52:18 +0200
Message-ID: <20260331-abspielen-windkanal-8efc1a3700fc@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <177456350181.1851489.16359967086642190170@noble.neil.brown.name>
References: <177456350181.1851489.16359967086642190170@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=brauner@kernel.org; h=from:subject:message-id; bh=17qLFkIbQA2q1tAC17tUA3ZGIC5prgMJ3fgdS0mLA4A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSenhnyf579An4OruPac0O6WJTZf3Y9t3ZlVTLWk+4v3 /5OR/tmRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETCjzEyXMry2ZDG+jDE5nGh 0aXL6+eZz9GXt3X/bczYedVDZPfE+YwMqwou7igIvX3eifma3N85iWl6TA+cr+8Ln+09P6zg/aM j3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 09:18:21 +1100, NeilBrown wrote:
> The patch mentioned below changed cachefiles_bury_object() to expect 2
> references to the 'rep' dentry.  Three of the callers were changed to
> use start_removing_dentry() which takes an extra reference so in those
> cases the call gets the expected references.
> 
> However there is another call to cachefiles_bury_object() in
> cachefiles_cull() which did not need to be changed to use
> start_removing_dentry() and so was not properly considered.
> It still passed the dentry with just one reference so the net result is
> that a reference is lost.
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

[1/1] cachefiles: fix incorrect dentry refcount in cachefiles_cull()
      https://git.kernel.org/vfs/vfs/c/1635c2acdde8

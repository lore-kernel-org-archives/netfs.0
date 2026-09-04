Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B23D7D7E;
	Fri,  4 Sep 2026 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508353; cv=none; b=DFWHRjNE9P+CSAlHWiH7EYdbQ5liddj5+bVeOtwKjS68rdEjS6NlE266Wca8IJ87Gp61k4m/dV/eokDot8RDJScDBoW8OP0dKK7DS1kbAdWqlzBUvxssGBIsdi092/LmB4aY2Pp+qeu/n9iaQJaXijk1Uq/fGbLcpgQxkN9nxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508353; c=relaxed/simple;
	bh=jEAl2HVmOXBTfZRdguPW6L2Wf/n3WoEsLeLQH+D/imY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uQ6K6he1Rlitbg8Nj8K+IQHOpZuxzXy9Ng4k3lQEH4PiYGk8nC1FYDtYSNOFoS2XGG6X9+xmnyd51F5Lg7tW3E9nJX3DOAFvY5lCmNG26DGnhljrNWAy418MaXQhXaN0axLYKZ5BgArxKpBl8ra51Sv6ejWtwzZDscJ+WiDdlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8FJX0/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8FJX0/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D21F00A3D;
	Fri,  4 Sep 2026 07:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508352;
	bh=ZivGdNQ3WNPzqFX/awBPwifUwaOW7ieSdZtEVQOV0vI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=e8FJX0/1oHuwQ0VlxZ4KlL2PIFs8ErbOMZgBbexGOg0z9bh6ws6TUvm91m1t55AWr
	 wpoWNeqNBPe4J47m+WQauNMeH9FqoCA6qqhAq9Huvuxf1MD82ngwKTAGh3K4rYZN8P
	 CL2XKflNOGNO9/jt6jm06CnbreSEkQVHLgJ7SJ0Gv158dV914wTp4JMi//dTdhzV2y
	 uj969Xb30Epg7G5SFAF3CGDeFxW7BjQjT7UGjnuwtlqaggUeyDefIlLP9TWR79kIWY
	 Zh8u7OqrTIw/cMrdlxUFnksnUfr8eQNGgbpMEsoMQBvsdH2NmDmfSt80z62AA7g68/
	 p+eltDXX5MvYA==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zenghui Yu <zenghui.yu@linux.dev>
Cc: dhowells@redhat.com
In-Reply-To: <20260620131425.8210-1-zenghui.yu@linux.dev>
References: <20260620131425.8210-1-zenghui.yu@linux.dev>
Subject: Re: [PATCH] cachefiles: Fix path of the "debug" module parameter
 in help paragraph
Message-Id: <20260904-dahin-zeitfaktor-deckname-e614210965bc@brauner>
Date: Fri, 04 Sep 2026 09:52:29 +0200
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7

On Sat, 20 Jun 2026 21:14:25 +0800, Zenghui Yu wrote:
> The correct path of the "debug" module parameter should be
> /sys/module/cachefiles/parameters/debug. Fix it.

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

[1/1] cachefiles: Fix path of the "debug" module parameter in help paragraph
      https://git.kernel.org/vfs/vfs/c/880a32f0a6e6


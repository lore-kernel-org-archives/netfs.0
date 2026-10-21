Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580452;
	b=yMb9JmSX9YeWbxe4LgP/KnGVqknJo4Mje54H2D1cTtW5+0NZU+0A2h04/g4GySEnHqF1
	 hISiC5xbysm/aay3ByXKzFR/56/l3U8ICZS/YXaa2osmipYnUmcxxMfW2N7rqXryq6NhZ
	 jxXxXZlBZEVNZJy5ESwQ4dAyFR759NGcJ9xJjXfjRJY2171BiOtEey16lLS6c1YY/K4Tj
	 njzfIVCxNmeWinEyfCMKNUUfEK+hbFaQb/EXJOqaqBHmhzYZa8BTj335jRUcF1CL7wtke
	 quQ+dwxKXrGj/pAa07j3+5HrauYUzewiJbuGtCfbDwk2bIgb4ZERv60S39ZVriTGk8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580452;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=aZ9SAWkkwTTy4NnoMgvNraUdhnHDvEnXt6t9/TvONPg=;
	b=g3FpQ0Setk1QhXPLgMCvht/gVYtiMYCLHB86rYzdD2sqVoJoOYJX2akvKDbA3m/yu2TQ
	 bcf6ZTLPNr32ONdGa9ds1oPlU42UxYujj6EMOXwz99RDfF8u7wYJAaIY3eLzM96Tm4nur
	 3VQ/w7mE6LEbKUPpB88QxMT3GsIRhsp1KZ+IVraV+euWGP9Dc8Kks4gcyQI+kXs1eIc9u
	 sQ6Jsz5+x1Pzh5YsHlbagGLh5t9Brhjvj2FGe9RR8dhOa7HIzC15uSW2XBAT04j/1PORW
	 jUN5MTXmaHGYdzDcklVn0SpoO9rjEbwehPsYbnvGiiITs4ldC7F3F31LF6mYMeJrcCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HweTXTA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B06606A319;
	Wed, 21 Oct 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HweTXTA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BD11F000C9;
	Wed, 21 Oct 2026 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580451;
	bh=aZ9SAWkkwTTy4NnoMgvNraUdhnHDvEnXt6t9/TvONPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HweTXTA7etRFHCaPlJVEsL1HLJMWcPMjcHG4GmkaI4vVHFc6XfIm8d09zbkMtNMNH
	 seVtvv8MImechffrqTnLC6ChEUY1zxmU36yzlMAaCqseeBxOTeWsTuS331wSyCx9l9
	 RuQGrYjhhv2qzDaaLbLLePOg0iL7KE42jUzcsowqtMeqETZ85rcU1wUVScxovCux+h
	 idBcx+lgwIsCnXBOn3DWdapXYKR/FVZMAPDat6LrVBqyyL/+whMVwAR7QfzW6iN7Is
	 Hi0E4P1SK+2tQD0waAAPMLo6ZwToRmj8mOBA2kLB3oNaRSYoTxHt3/tr+PDAHDIWY3
	 gL3KPByRbnasQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Jeff Layton <jlayton@kernel.org>, 
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260905051738.11317-1-kmehltretter@gmail.com>
References: <20260905051738.11317-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] netfs: Restore selective debug mask handling
Message-Id: <20261021-inzwischen-ufern-blasen-f5882ee63602@brauner>
Date: Wed, 21 Oct 2026 13:00:48 +0200
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Sat, 05 Sep 2026 07:17:38 +0200, Karl Mehltretter wrote:
> The netfs debug macros test only whether netfs_debug is nonzero.
> Consequently, selecting one debug point enables every entry, exit and
> general debug message.
> 
> Documentation/filesystems/caching/fscache.rst and the NETFS_DEBUG
> Kconfig help still describe /sys/module/netfs/parameters/debug as a
> bitmask of per-stream function entry, exit and general debugging
> points, and the fscache_*.c files still define FSCACHE_DEBUG_LEVEL,
> but nothing has decoded either since the mask handling was dropped
> when FS-Cache was folded into netfs.
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

[1/1] netfs: Restore selective debug mask handling
      https://git.kernel.org/vfs/vfs/c/35f4755ed06f


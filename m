Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FED2C11CA;
	Wed, 22 Jul 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724954; cv=none; b=SYDqMugp1Vc7Eoltf41peYuLEnFhNdZzXEH5nA0fuck2G/Ir0BmiBLDSELrjZcX4V31XM1wZHrNKNoFdv0+IeGs/G02L37Go2yI+w3bZIEqy9KDNOpw9farblGwtfI0N/TPw4PVD3Q+1BC/fO7iHQC4p7WraPhTiK0pATdYDSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724954; c=relaxed/simple;
	bh=axG5SXmNf9WMitJsh4sW9lrnxoEkRDoQwizhupNVMGg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OUKFn3it47FZJXxaWGsn3G54IRhKrQ7wgwaFKHvDSIbbwqO4n1mHv0PqJwuPgClchNBv0skL6jC/s3DVlD+C8Th0zgAuKZrbbKdHg/FxytoUjs7xq78TW5WcRPCBxuAMk3dr2LLWBcWIRsGJuRrhw14NF93Pfce9Xc39idRdw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfWOGX3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfWOGX3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235791F00A3A;
	Wed, 22 Jul 2026 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724952;
	bh=7yV6eDaODahotylKaj63jD/buNSAlSi53kxs1uoxXgU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=FfWOGX3Dnt8SCuSHDSNnVkt1VslUOjuqR7MCwpTpEQvs+xtjAEO5rZD0dLO0ejPma
	 p06Y+mvcTxU69pTNF+GTlRElvCOpWFhUBShNFqQc7Veuxj91enKyy5im2G7VgnK54L
	 QpnxSWwQsq6pQg64/h9+ZbzH8EP/pP0oDwfC5FvCfeAhxG3edPfE+8p6c9r8UDKz54
	 ZMNOE/WkneUA4aMWINnFS/0GEQ4wSI+lMV0KT24ykcJlEQYYBxCRkiGb7btEOgUa5y
	 iT80Zm6DQCyJE4K52YQ2mpoNYltqtT0Tr0R6+UAvOx0CpxdKpfBRFgYMhpntVK9HS2
	 cmxcDUAd0l5Nw==
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] netfs: clear PG_private_2 on copy-to-cache append
 failure
From: Christian Brauner <brauner@kernel.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260722071310.18593-1-chenyichong@uniontech.com>
References: <20260704050603.427472-1-chenyichong@uniontech.com>
 <20260722071310.18593-1-chenyichong@uniontech.com>
Date: Wed, 22 Jul 2026 14:55:48 +0200
Message-Id: <20260722-wahnsinn-wellblech-jawohl-69c279e66bc8@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=190; i=brauner@kernel.org;
 h=from:subject:message-id; bh=axG5SXmNf9WMitJsh4sW9lrnxoEkRDoQwizhupNVMGg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQl7L12+ohe+66YbybLv3voTYnr21tS5/Pm0qPCiPsXC
 muZd8mVdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkRTDDHy6fKZN2vWFODJdY
 V/DYat+XI8sEjI4rHX3126jOXdXlhBQjw+85OwJDP01yFPmwdovcbtP4UAeJjOXPZ5T3fghSl9R
 5ygIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-22 15:13 +0800, Yichong Chen wrote:
> Hi,
> 
> Ping. Any comments on this patch?

David will pick it up and include it in his next round of fixes and then
I'll pick it up.


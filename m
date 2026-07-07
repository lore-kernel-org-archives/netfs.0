Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C493939B9;
	Tue,  7 Jul 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450798; cv=none; b=KMh/Nql16s3QF5xXPlptwk9A7p+utK44ep5UtUTRAKlKeee5AMhTBMIvWidhnSfaHjE70h6ev6XxpTtGp8vo8vGIGhEr4X7znc1T35cwzX+j88SWRXrZI48i9a1QjVZVNZGffAkAOsvvqc3XPiB3KqjJk19ugU2YCz7D0dbUqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450798; c=relaxed/simple;
	bh=ePEvq4qHhgB8eLUTof2l8M6uod8v2R2q6zjtKBcRIWk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YyOWD86U1fwwDe5Dchp08MRjq8cmDu0hCC2TIVuYW7lLMBD5JAFznM1B40KIAqClTpc6xm5G5PdjbcNLJu0vn53aetO3CpPRMHIurcQ0FxWbkYJ+Hu5dUaTPoFuggz2PHah5pI72dSeFvH4ZmX61ChHWaDAUW03SwAFnUMAxdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEJ8QCxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEJ8QCxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA51F000E9;
	Tue,  7 Jul 2026 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783450796;
	bh=FGXbLfrsF83Byjcnl2WP1EeIGD7sTlRCfmVt5QiDXI8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LEJ8QCxrRyTOW6qOF579z8aAHoimy+4a6m1LNLO8yyNbX970X0FFNIrq+Io0RXPta
	 Y5P0kw36qPZYzXlpSxkXIlbNOP9ubL1w8vydkRORrDuSDFh4XhVW8MDBJtpLxpUIHo
	 spzA43Mk/QIJ6yzMzg0joVkInv+2gwUrNECbIvnqkvtw0+3KJT9EWwyFqUAbVNL8C+
	 mOtsaP9DAI3gx8R6Vx4NuTn3b0AlONfBZ5QQY12oP0fvp2V25pZlAMl+wmiLlY2YS3
	 JSN177smBFaAjizEkvOLMdaTx332gBwHC+g91oFRlljjaewCvkvzddPlxojsv07yPx
	 /nzIYvbb7DjNA==
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260706030439.14212-1-xiang@kernel.org>
References: <20260706030439.14212-1-xiang@kernel.org>
Date: Tue, 07 Jul 2026 20:59:17 +0200
Message-Id: <20260707-irrweg-errechnen-matten-dae8db86b437@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ePEvq4qHhgB8eLUTof2l8M6uod8v2R2q6zjtKBcRIWk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5+qz6NvnltqPV06a/K7mqPGvbYr5V1fJf97z76e5qk
 PSkeXYWW0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEfGcx/Pde/fLe0Tm/r872
 NWJn/dVXISN674ZdSaDRkwCj7769s0MY/ukfS61bkBEloHNinUako/f5E3L7fI89rVn1TbL1QLq
 yDgsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> It was an effort to enhance fscache as a kernel cache for lazy
> pulling (at least according to previous Incremental FS discussion [1])
> and EROFS over fscache was the in-tree user of this mode.
> 
> fscache has since evolved to be netfslib-oriented, serving network
> filesystem inodes via the netfs library, but EROFS never acts as a
> network filesystem and we need to cache golden filesystem images rather
> than individual EROFS inodes.
> 
> Since EROFS over fscache is now removed, clean up netfs/fscache/
> cachefiles upstream too.
> 
> [1] https://lore.kernel.org/r/CAOQ4uxi4dzxArY24YO=+kBCK2gGoq3Ptb8WkzCqSogPgU_R3dQ@mail.gmail.com
> 
> Signed-off-by: Gao Xiang <xiang@kernel.org>

Seems sensible to me. So I'll take it unless David has objections.

-- 
Christian Brauner <brauner@kernel.org>

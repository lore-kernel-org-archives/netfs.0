Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924443C3F6B
	for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073733; cv=none; b=n00wq65/1HYRQncCBF7VBBMzp8086q27dxR3VF+PSr/dNp3kvBxDbVuUAQRR4PPXAzgNdFt8+XaGd78vexd77HznjDu5zMLgHYOJWeR7SNACZcoea8/RvudBdw490OvwmbPac/6eCMQ+5HA0XnTL9kBKSiV+kTiD9f0yXhh1DkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073733; c=relaxed/simple;
	bh=+IQPGIwLYqvXsJqCN6VhyEqpKbVenm0hH3MftI0zwx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dwBp6GHOAaK5ojncVolsq1PoO+xUOB2lBWXSdQrN4moQ++AptVHeXKAq0/8vdTKdtvBxcaHaQWkwCu2m3MXaejkYfTtwDDmh4nmtQL2a1NDzZYM4lm2qgMg11d2CQJnA2HlttaWTGSQdGJYEiaVHJLGtEZ4ARBkxqdTvJ1bALsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=DL5EIwqY; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="DL5EIwqY"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7fcb425fb6bso138473a34.2
        for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073728; x=1789678528; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24PnjIv2e3Qe4pGninNHOu7n10wogA5QDlxPKFi6KAk=;
        b=DL5EIwqY3wprcmbZAv0fTRiOSrfLGv9vO9I4dil7YqOs93JdLY26eAzxpk5qk9zLj+
         OQjUVAMLTa9v6h0517Dzc1jSn+cHqS3ur5vhQgW8dXELjLDry0PU2Y6tqg54KoeQqowY
         ikKlyWgvh/fkfzx7rM/W5iwTulQAR5HsuKimD5mCL36sNi2hFkCaABTpx2AAT0rLXI2y
         Sd5KaC0LTMzsXHR/AuDGWZbMX9N7rCjXzq4hOCr9hAHpp0mqRatnfRnf6cKKvzu1uedq
         ybQHNKdgMvobzrpwgtYH4v19O8f42uNdEbpIVqhYEgnClj3neYL3N5xQgMRkWiM+PFly
         pQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073728; x=1789678528;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24PnjIv2e3Qe4pGninNHOu7n10wogA5QDlxPKFi6KAk=;
        b=cdCSzILBw9WdGWRMr89uB8LwL8wVVi5mRt1i1bU24tz8Jgmnwwb8hBa2f5QtSYAedC
         eMVFCUALfpLNp6ZBUGOrLHhwheLohGNFaxhJFvo74Y4Ssqh8iIt7X+GJTCxsbS/oWqLo
         qEpDi/UZExsnb9Gb+Eju538hVmwnNdRSd3wcxsDaeOXI7sCUZQIBQUyomgfHufcCEwG2
         IhN7JQ9LRiWzn3tS58rFFDTkAWf5UHWHbqSkK7M0qKv7fT3jiZc1KUXdJVBv174yjhMF
         ZeQOShEy7nC7mG/BSBxmUTN+WxE0PgSihPeFdC8SutskJEyn2wDMoSMiSE2/X8vR06lo
         v+Tg==
X-Forwarded-Encrypted: i=1; AKwUvBzzqrrgbvBWQ2I59OF5JHk/eYbxgpAYkWqw1jJQJLxjU29dG4+rcySmIJMeQfnx+tspFlXN7A==@lists.linux.dev
X-Gm-Message-State: AFuF++m6qITe4ETwyfGOQUVdJg+nIowXcsnslH+ybvV0gYmp0EZQDnWq
	AGfGdMl5Wlk1wQAF7W2ct2pAqxVwWj7uwutWCi+wKo8Uu2KPkzba7SB4ZgFj5lVNrk0=
X-Gm-Gg: AYBFou2pOpoWAISgRyCSRA4hZnluErQbt2GtqnQfHEQDOS0dOvd7MiPAQn8wQLfk3Ei
	1ijL7WBfulD7p4DOxFaLsJujaqVWNOcViqEk6hJZ77J8dWauu9xH1jNCWONaFLS+v4qAZ1Oolti
	NFtVKj6+6KS9Z3bBH4cqmsgVQYlRhdet15U1pNxo81rFgD7xsI5CKldN1wbjSmWIZKC7EfZzqgT
	Db06aLUTpXHfirrj4NjFX84TZOy5CLE7waRMWAZGtow7Bp2jKJyv0W0ZBIzPz2mgfG5L0s2nkhk
	wWK6A3Aco3ASArBhiszGo7wd4qSrifAUhyHPFC1A8VWmwZBGEFnfz2Z3w92ib75H2rVaiVxQBcM
	KYwYEUsEOhrh9ZkRdcpASTpMyFGwu9Qdh90H3J0LTjfuHN52I4jwRE0oiVCWOi9I1mgN7DWyFep
	MaZOHSKE0xqSY2CSSCdaByGrhX5c6qk4W3NwbjJXlzFXUd8Xww29mOs8E+xzj+Bmhd7YzyJ+3Z6
	VHCkeafI+XCclnQgIVsaMlnFZI2BJzvud+uDJlYsyN/s0fpHxz72waf9zuk2A==
X-Received: by 2002:a05:6830:920:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-803fa7dc0eemr999678a34.0.1789073728657;
        Thu, 10 Sep 2026 13:55:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1667275.1788941191@warthog.procyon.org.uk>
References: <1667275.1788941191@warthog.procyon.org.uk>
Subject: Re: [PATCH v4] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-Id: <178907372695.484803.16149783487967985464.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:26 -0600
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 09 Sep 2026 09:06:31 +0100, David Howells wrote:
> Commit 14b007e17881 added an address check using iter_iov_addr() and a
> length check using iter_iov_len() to iov_iter_extract_bvecs(), but these
> cannot be used so and are unsafe in this circumstance as the functions have
> hardwired assumptions about the iterator type.  They should only be used
> with ITER_UBUF or ITER_IOVEC-type iterators; they shouldn't be used with
> ITER_BVEC, ITER_KVEC, ITER_FOLIOQ, ITER_XARRAY or ITER_DISCARD iterators.
> 
> [...]

Applied, thanks!

[1/1] block: Fix start and length check added to iov_iter_extract_bvecs()
      commit: b0d8d56b7c93ed767eb4f2be9988e7b9dc023566

Best regards,
-- 
Jens Axboe




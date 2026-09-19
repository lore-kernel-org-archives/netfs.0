Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397D1A3029
	for <netfs@lists.linux.dev>; Sat, 19 Sep 2026 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795861; cv=none; b=ASXiYDsD81we3YMDfAmUkATt+bXjtGqbNIsISM+6ztMJaxrdySb3nShcHq4Ydvd7mnyL0Z7pZ7/liT/LMtgJ8KBqOxaR7OUJlAsjjwljP8ICJ5zRHasnNAMobo70Zz4hQbCDjb3NLNkPPu7XTR4GOkVaBqbK4dRR52KBRSAFteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795861; c=relaxed/simple;
	bh=iDSXDPQtwjL7QMN707DL89rqjryGZ/GwAAl925LsBhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBGvc1JWqWcwAJ2Q1rrbr5gB2SD3KWs0OC+LB4tv8oGE7l71dKhmbUJJ7BUc7OuprHltAff3/maH8UjsImXAAakZ7wcjyrOUO9C5kLMwBV5AX+har8gRHMjkal9VEKJX9gJgv0Ri5aan7M+XXxC0jkPDXfHF2JHeRmx85FLJGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfsIWDCs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfsIWDCs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso14805995e9.1
        for <netfs@lists.linux.dev>; Fri, 18 Sep 2026 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789795858; x=1790400658; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iDSXDPQtwjL7QMN707DL89rqjryGZ/GwAAl925LsBhA=;
        b=kfsIWDCsf0JqPF7b+T8fAtGiOySj9xvsz/0AUwEDdvQVnMxXppZts0+Ax4VtdFfCQC
         eVIDXHPkjLfkMD36+TwnC44oj43ZvUJ/+cjLO2UY0JiUdFMUl1W9kl3e26MvvCorvgbE
         fgsZI41zO+06vWnUwZdtoNbLM3jrH9aYtZi6hsg/6v4/GovaA276gJTGEc2yksqQFh1g
         ZnyUbbrfIRf908xQ97JRfM9B0IQzIs2FoPmoCWnoctawXGuWKu4hogP0TkrhflJEqEIw
         PT+cT1JMH/AO7GTgtuYLZNFZbaTlKuEGjtb/0yQKx+SY7093ikf47O4QkL+zfbcNUT23
         KcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789795858; x=1790400658;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDSXDPQtwjL7QMN707DL89rqjryGZ/GwAAl925LsBhA=;
        b=yyedlHpfrEoobJy4AShfHh4ao4D4JAVEYFtky1hmyRb4U69Mp9GtmAtkP7LZAayydP
         p5zzd+IEqS8GQcEZtn12J54ImzHp3TPxeak+eUVL5B2MDyjmcidaV5SmBeGnd3dO59i2
         MmdG+2cP/aCopjYJCaJp2yOUHjFAM/kLYY1d389PWiXyomCmdTgdDBiKwcIMSz0MsVZx
         OMRz04quHnrSHFCY8MHjhSqSeqluSFDYVxScc6uMxqdQTXfhKtPTvgTnZn5uuFQKkDk4
         OeH2WjIk4Dn37R1/yozQ3Lh2GMx+f4dqMBBa7UjoeoqESFXkaHsT540bnN6NpC9wwdi1
         FzEw==
X-Forwarded-Encrypted: i=1; AKwUvBwfm8mF0SHfNTseBohRv7zTD4GjHEsBKMGqN/Q4/Nc0LDSRhnPsb5OwHS4c31lS79mHcZg7MA==@lists.linux.dev
X-Gm-Message-State: AFuF++lWTv1EU8ehxUCYtzSzr67SDgKAnVhML9ecZx7TBbwluf9l5Zyj
	WDQTnO9x6tuFyAuKz42T3XlItUgDZNEagJQ6yI8/mrVKt/6nU+fsZONU
X-Gm-Gg: AYBFou2XEfeHACdpxk9htIBmbhx3Ama2c06USe5eOYRnn1m7LWRFLOJUtfPqWcx36Mx
	VPgZxX1bv0Rs6t2gPrRGSb1nIpu11UK/bS/RP/Ti6qvRWaDCwdn31SgxE0NB/I3Uchzr0fYSNdI
	jXzBmEKGrYW/RZ83+2m9nZf3fDBuTFXQqqdFxC8mNHQXFisHSJ3aHa9CszGiLnCSmxPXaXJb51t
	PFALNHbSuLz0WGKfwisEuVS6uYkCdHfrBAeQxWKHp9LfYoI2LaeHxkNH1GXZxn+w7n4HOTmxelS
	nmQjINSw9u64qIsDuxneiXKflaxgaAPq72/i/FxWcOKEeqKWEwk0fnv7/En6kzYGDxYdAxUfcf5
	VzncW1+/JijZwISC442bXphyecPBJEU0RXaqKSPOffhCu043WxNU7BOJZ5OMYBZL3r8iO+wYLcA
	v6hoqV2C1yRcLW+vdVYku+osvC5UdJfD1ZVKxl81SU6xll8+J1BGQcxvUFexMDjAQQnmDw/k115
	NUa4r9tEmk+ohKeaTyuD5ooLV82IabOlCArUnqmJ7MvxuhLX5+DeNCkgD1ZWErpLuamiTD5THYl
	FOq+GAScgIcqIACpDKz6JBzpLWP6V5MIBN72KMkdQZ/Nein8PnzOkn+SnuQl3EyMal80Z8vYhht
	Wp+hCmdLoh+75loj2gOHXMw3ZQQ==
X-Received: by 2002:a05:600c:1989:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49fc5673292mr67378265e9.7.1789795858091;
        Fri, 18 Sep 2026 22:30:58 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc5748e56sm107214215e9.2.2026.09.18.22.30.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 22:30:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix debug parameter sysfs path
Date: Sat, 19 Sep 2026 07:30:54 +0200
Message-Id: <20260919053054.26169-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822075005.74963-1-kmehltretter@gmail.com>
References: <20260822075005.74963-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 22 Aug 2026 09:50:05 +0200, I wrote:
> The module parameter is exposed below /sys/module/cachefiles/parameters,
> not /sys/modules/cachefiles/parameter.

Friendly ping on this documentation fix. Is anything else needed
from my side?

Thanks,
Karl

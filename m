Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7F12CDA5;
	Sat, 14 Dec 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734171384; cv=none; b=BTkqpgYMYPyt1KiygqYzwZplCZPrK+5cR0O4bI7S5YoqLi95UcPCj3YRhB2X44zWDMP7Bg2SV3e2cmYG/A4hKQsc6Wz7JlIY9PFYMLmhNnAOOiLKyQeAXphNoIelgM4rUk41sUfp5u2d+75uLkgSFoHwbSpF7saSvNhl8bRBVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734171384; c=relaxed/simple;
	bh=ppurqkLg5frVMfdj9t/MeoIOWop6fX3bDcl+dcNOFPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIDlCbRmraRb9ssKJX4kbEzGEb43DXW1Cv3wbKbUiTI7yTgm7d8WK13cUqyYywjRhKO8NvRxOQbycwelw67CUfXE3NoAu8sK7gLlDiIZYFWUYJwdmp6NXwT+Ntsu/RM6hlJsjVpnxwzdhqYa1GWBxQcmPG2pp956Lx2yTn2+AyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUcDz3g2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUcDz3g2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161eb95317so23944485ad.1;
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734171382; x=1734776182; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC99pq7hRHFrLDw7siiOrZ7FqbwdIbl7gLGxK8elhYI=;
        b=ZUcDz3g2iGdi0/EjrMhKwRFUnpHCbf7bXfnDcI2Oa1dWMqYPKR71/sM+oYOXYur41P
         Q4tuCst/5VpxDNHw77NH2+kseu5nG2ZgsAqm7l+QnKPH5Aj+bdujkWvpwv7EaQX/DCmp
         gNXrC07xtIMAmZoIyvRb4x/kcJ6fIDMN5WlH7sEZPoEqz06+KhTeEoGgKJ1KauWna3TQ
         qUOC7e5lOn4QxAaX3pRc6QCdk0N6ZIScYMY/7qKc1v1gcXUplortHQSyW+f3RkPfBHZ8
         1icg5mztvTgXPJGt2FUZkDI9EXJRg3L9RVLYFOlev57lzU/XX81p/TpBWelY12RNNJJF
         yOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734171382; x=1734776182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC99pq7hRHFrLDw7siiOrZ7FqbwdIbl7gLGxK8elhYI=;
        b=nymsJFIvXctx24Yx7HmkMhPG7wdin7cAjwm+F9ausmSMsY16mToDPx1GBYJt5/vbV/
         dGuOHDL+4vsf6DlQ3GHUO0wvrvPvAGSAJ3wW58/k2g/DdSeRvI1Ga4q76KKBExJH2caP
         VIcylXEkc4OVjh4WJeG5bIqFKSs3F1KQX2a0RHSLHm+DkUUIL2u0eDWnL0gTb2y7AHjY
         oAN0c6FoESwdzjHl8RReKtfGp89sCK0G3sk1opIO1aTl7HyvXIc3XyqEja8kO0N3yOFN
         wICb3db2brqFTRtQW+CWy33RvcbL2+ApZYa4T0IAsjgW0UuvK/UjBAmnc0pOQLA1yihr
         xlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9in1LNKj+aFJFoBB7Jo//H0IaOmQcf9aZ+ZDMTZjwlZ+kPL0VsCz922pw+CZvEsJao+AGQ==@lists.linux.dev, AJvYcCXtNcWRwi3UZ0v+em+1+zkt57IZn4CnqX3VHTvH2XjtfmqJARrZksksO9+t6ME2Q9WCNlh/cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxDylhc3lQndlrNrE6Zaj3l/GwKnQdXsxNfOBRQMUJXT06f3v3
	c21gH/Bq91XZMmz87Rymfrl4FyitM/wYznbuAMy3lFVxPaUodNiY
X-Gm-Gg: ASbGncujBx3ky52mhQhiYuNxooatiF3LjhCengJ6bffAmL58nZuVi1QpHybOlGxr8To
	rogXcgKTAMzQU3PtiumwbbZZsI57qh/jjSZGdCTDMxhDY5gNLwCr+W/eWKwdo4Sn+OH8+CCvZ4L
	WPlXo8tDRK8CTl9GYKChZIITa9Ou4Y1eWWgvbeYZsRiV8RmLNfAeswi9SeYY0PyPGTgJWjxxVOf
	E54uOk1wlcyRFGz2ZbZ6k1b7agAgAwM3DrSje5ZYgUgowo47kNZofCVqJ+oIDB26Ev/AeBJxRz+
	sYFhWAxcLeboVdHGQfV5H04=
X-Google-Smtp-Source: AGHT+IEZVE15/vEAohikUk6vjIGzOeFn+yVnxHcYlw+pZKWRHHAPNEYP1GeDSZ8W1ZJPAeFwPcezZw==
X-Received: by 2002:a17:902:f70b:b0:216:28c4:61c6 with SMTP id d9443c01a7336-218929fb17bmr82919535ad.34.1734171382443;
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50455sm10069475ad.159.2024.12.14.02.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
Message-ID: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
Date: Sat, 14 Dec 2024 19:16:18 +0900
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using
 clear_and_wake_up_bit()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Max Kellermann <max.kellermann@ionos.com>,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>, Akira Yokosawa <akiyks@gmail.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-8-dhowells@redhat.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241213135013.2964079-8-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

David Howells wrote:
> Use clear_and_wake_up_bit() rather than something like:
> 
> 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
> 
> as there needs to be a barrier inserted between which is present in
> clear_and_wake_up_bit().

If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:

    This operation is atomic and provides release barrier semantics.

correctly, there already seems to be a barrier which should be
good enough.

[1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.clear_bit_unlock
[2]: include/asm-generic/bitops/instrumented-lock.h

> 
> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")

So I'm not sure this fixes anything.

What am I missing?

        Thanks, Akira

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Zilin Guan <zilin@seu.edu.cn>
> cc: Akira Yokosawa <akiyks@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_collect.c  | 3 +--
>  fs/netfs/write_collect.c | 9 +++------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
[...]


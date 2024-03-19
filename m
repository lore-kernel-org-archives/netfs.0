Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDB85923
	for <netfs@lists.linux.dev>; Tue, 19 Mar 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864843; cv=none; b=BTBKsMBap0ImVS2uDg8HkpleL55PZQEfHhHLgK52c+JT/V1eGUmLEH7GufG3bcqttNaZAApRL2W0MbaXVm15YeaHZ6MT8HX1ZJFNmX0ZPf7Scr6Zhrk5/KVs3Yg/yMy3gu/VSfIHkQr42DmoyI0TZxtDYS+M+FZZCnihGdGT7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864843; c=relaxed/simple;
	bh=xK6oFtMSPOO/+MFMrzgdRfpeW/yJYOp63dnRub6XKM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciQ7VJdgbwgRdQx+D6ysbPnNO/XJyczAfUMUNLhWOgE0+fsA0tMODuunLMjSl5aCUVqaEXmbDOl4Kqc/xaUuHqjKkeoFvqH3wn7um1V47Rv/Kid/t3SarwA9r03kkkLvzPVpahCQOGDU7KhKl8vba50dQJ/ZIqmRyg7YiWeicJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=f0Az0xTq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="f0Az0xTq"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45f257b81fso756038166b.0
        for <netfs@lists.linux.dev>; Tue, 19 Mar 2024 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710864839; x=1711469639; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qssoFyi0EHVSMQZ8tvcNSLF8ll1cyBFfjAUL3WkFTKQ=;
        b=f0Az0xTq6PYukZYhEX+9zwuh4HDQRJqFNasBkPDcWFtm9a1V3OgvlDbmU4HfkhA2MP
         5F/i72l5606RNTvclHQc2Z9siJXV0p5b76dq7PdQqoniZBIam/glElf3KSmGIqHpVzAn
         HMveNLLVsVdCklo9L6jx4NY5VqNib5I6xl5AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864839; x=1711469639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qssoFyi0EHVSMQZ8tvcNSLF8ll1cyBFfjAUL3WkFTKQ=;
        b=lX6MQXkW7yjqu+fyGVYB4qS7rdF5+pDZtXxVPhdZsPv7NERAWzSjsfwAw/xXJSPgp1
         mdSSZKxoF5KL+0L9QdP7U62vMWNU7/TsDPwbstPvJAlYXsOiDqM4ks6ACZBGeTe8NMv3
         JOcXuAXPMzdbWQjTqH3BcjybINtdcdCwrWHnEf2a9Tr8CaWOZ4Dc7pyUOSvt7stGxOxx
         ajSbbnlsEwgPLTt/7eBqRSUvKWbD3maeWhCamYPbZbqyKs0Vs+001rixXQllyV4i5iOD
         9EhZ6P1vWP00qhFAqUW7e/xpBRh5G83Hf/SDzT4V1iNj2G/hJnOo/5cqxr5d24Spx46w
         kttA==
X-Forwarded-Encrypted: i=1; AJvYcCUfKnJ16w9ck3MMLpooC+iVRCmqZ7TQxmR3MwZc2Wl6kj+O5/hykwGKdc8+TJ8C9w5U4fDbYWu5MUu1HpurfFDdlhmgk/c=
X-Gm-Message-State: AOJu0YwL7F0fWhyd8Wdt2g8IzLDAQrhaAMxpAxzcMsqzdk7mICYQXTjq
	bP+BZAng4kQZ+OwpaT6qnsgXj0tnSxkkOAW+oojJl7TB3oJiJuD7lmk3SvF+Vhx3dfd9ArIaYMY
	/wPqV3ltwIiuCRy+mu8UB5QgFLMCIqHSEOz4QcsbnUI9kJDus8Hs=
X-Google-Smtp-Source: AGHT+IG80idJ/eoHfs/tS8xY4ItmYTZEjrCulMFp8PsOW5O33PBCGW/QH9XqH6EWMgC+d4lP/zrFK1SKGKNE4vf/7pM=
X-Received: by 2002:a17:906:af07:b0:a46:47bc:580b with SMTP id
 lx7-20020a170906af0700b00a4647bc580bmr2203920ejb.56.1710864838625; Tue, 19
 Mar 2024 09:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk> <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk>
In-Reply-To: <651179.1710857687@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Mar 2024 17:13:47 +0100
Message-ID: <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:

> What particular usage case of invalidate_inode_pages2() are you thinking of?

FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
to clean up the cache.

The server is free to discard writes resulting from this invalidation
and delay reads in the region until the invalidation finishes.  This
would no longer work with your change, since the mapping could
silently be reinstated between the writeback and the removal from the
cache due to the page being unlocked/relocked.

I'm not saying such a filesystem actually exists, but it's a
theoretical possibility.  And maybe there are cases which I haven't
thought of.

Thanks,
Miklos

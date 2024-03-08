Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917AE555
	for <netfs@lists.linux.dev>; Fri,  8 Mar 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884380; cv=none; b=XvwXBsSDVTWOBHCnnt90G3OEQgfd3kc/AEVecL02hGWLiemxkvhXMO59A4fugyQUcyc6zCUPKijP3sc4LsaYto9ELu9oQunsDQ2q5zXrYcMpsb7obgvlp6GQz3hgVyeRksFcC1d0X9NRasewa2xzblfJ4MBGjifaHtihsZeUjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884380; c=relaxed/simple;
	bh=sH4bAKDnIswJKnbTcqpk0Pb3FW7/UPFUpIR+aBApz4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4eNpgo59n+D3Z3cOvUFXsD0gzLn8SnYhp3z4TxsJMtXnL8h75dEQHgIUcuqZayrw1ctYLHuF+sxd8iTIO2XhOtcM0e2E4LTp/9GRWZj+YaUnYtRvnXcCAwsHbUxpX1NFntKf6Jt8STkNi9XyHZW8CivxViZ37S9tPZeVknYMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XfPB/wLx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XfPB/wLx"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so256265066b.2
        for <netfs@lists.linux.dev>; Thu, 07 Mar 2024 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709884376; x=1710489176; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hrvCXGaVO3HhvR4A5xt8TDit+qLJ9i7NLCGUzaXWqIQ=;
        b=XfPB/wLx85k3u2ujabDtmfYJjFTzayKaQrIuhvNetKOohSeBgHs/xm6qD0Jw97SJK/
         CPDGIKaJUD/myH2c+9ratvo1ha7hF4/0YycWLq6ExwffmcxPvSSXgdZO94E9kQNgxPXm
         fmdQtPY2g4D0+jQjUpsHWb5oKWR0MtFGD8LoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884376; x=1710489176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrvCXGaVO3HhvR4A5xt8TDit+qLJ9i7NLCGUzaXWqIQ=;
        b=LX61Vhz8TFg/etdDTeEzE0tPi8MyIZsnU8CyK76TMwqwREFkwlzs+Ega0Mx0AIYvTI
         1jZuuFxdrZgu95Vmx76q9txRgFw18UIWg2QbOA6qykYPQtl9PkWXQCHUPlZY/yHQJQ3g
         GGNr2Aaj9J0WP9xO5FPWuuN2JWn6cAsQnUsTpigyPGvHZljYvhmy88kOX89MBpfP8wqt
         rCVbn+eQRz2PbVK8k6kbNhnEsYXl0yOEWkSzc+YHmuwgAt13fEva7cdPxweiYRwXMxh+
         y4ZgnYmai1hNJcykprSAQFf8XFmb5MRhrBTpiW1iwUEofO9TXqF+8MOcus7cqnLr/+N6
         w0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV7fWltEcpd87XxrNnMXrNpgu0TzqgmS0ZK+XmAAI8rB9A2JoVQp/u+h/f5fCvuoTEgdKCgdU1L1G7VSt1a4PSpEodzQG4=
X-Gm-Message-State: AOJu0YyN7DYrm/c9JoOaueuJor4+NteNY/2NOQXfJMU99jRgh/6HDtFX
	/PMbuSKpxDXCtEL1BvKR0cORbw0sBXOciUpN+oVCECztWE2tJ3HThEfCqYQvltyDQc87SOyOPEa
	qWieeUP/UYzZ0KxUlDqU9B5Um+sRbmgpp9A7ADQ==
X-Google-Smtp-Source: AGHT+IGfxe+G6Hzhhm3qO2+tkAluEdwQIf++vT61Cv18s0V9jevPsUAy++K+ZRtxdczK/SgeeJRbLSjfJGJhUS+augI=
X-Received: by 2002:a17:906:a2cf:b0:a44:488d:8e42 with SMTP id
 by15-20020a170906a2cf00b00a44488d8e42mr13783793ejb.66.1709884376420; Thu, 07
 Mar 2024 23:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk>
In-Reply-To: <1831809.1709807788@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 8 Mar 2024 08:52:44 +0100
Message-ID: <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
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

On Thu, 7 Mar 2024 at 11:36, David Howells <dhowells@redhat.com> wrote:

>  (2) invalidate_inode_pages2() is used in some places to effect invalidation
>      of the pagecache in the case where the server tells us that a third party
>      modified the server copy of a file.  What the right behaviour should be
>      here, I'm not sure, but at the moment, any dirty data will get laundered
>      back to the server.  Possibly it should be simply invalidated locally or
>      the user asked how they want to handle the divergence.

Skipping ->launder_page will mean there's a window where the data
*will* be lost, AFAICS.

Of course concurrent cached writes on different hosts against the same
region (the size of which depends on how the caching is done) will
conflict.

But if concurrent writes are to different regions, then they shouldn't
be lost, no?  Without the current ->launder_page thing I don't see how
that could be guaranteed.

Thanks,
Miklos

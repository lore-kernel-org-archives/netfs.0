Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A31F503
	for <netfs@lists.linux.dev>; Tue, 19 Mar 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866473; cv=none; b=mCJb2nH6LnpueMWKvsDIDxYbldjANgM8xJkS+cE0YwCf8+Q7m8M2rXMAbjJN07r0YOL/4we48+w6ILDPPE2MiD1rKC7p54DjVybIBJ4bYo/vSnuqmbFcWpZQmS7RrB5ZxHE/AubBXYZX4GIfp0TmaZW/ZOXwqTkeQU5dybQ86IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866473; c=relaxed/simple;
	bh=nRp7+YyTBHw31NX7xj7EtsXhg3dkAR+p6w1ZMt+sOEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThEpqmgwh85lGDivYXOnw1GbijIkET8zgTgFNC7ANOMoAyn1Dcr6FhulTKQMdkgphbhmzfnXCc6/sY0QBYN5xhOcsZ4LmkFG7TnWAS/l7XadJNGxcqoT+JOmuFUtAL8Ph4fYHdTYepw0yhKUv7jyRjoKOLWCqh7KHbyTrsCesKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LX6KDbRI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LX6KDbRI"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so8046709a12.2
        for <netfs@lists.linux.dev>; Tue, 19 Mar 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710866470; x=1711471270; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=LX6KDbRI2kWb42hsSLXduAp4nrHfgws2azIQyh/Lm3Tcb3bRozDwE8UawChfvtkW3Y
         FaOnfANW9nwM1Pf8xnSBAnFvXPxQOdGVFzNhKKJ6jexhLYOPxqbg80SA5AI2jRw1gq15
         p9eiVjsEVUsMLerQFgkPS0JENJEGfEibWnSVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866470; x=1711471270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=iD2rGXWN9zhc4s36t2/k1Yd7F/7aGkyKun8SEWoL946xO3FeMR/TiHOlLO6C+oIxUk
         fBoVMT50qThtnIKedAk6TpU2ZvVtwgYxC68DmdHv1C4k7zG/dhJi4v4NHumERwEgRvX6
         GzfWqyw+bqPPpmZoe8Szf2jPOSpUS7OrO5beerrjLXDQwB/z9xdfunKU8Jrwzy3W9nRr
         DWJoubkIFD4dvdgqEPi4jNaKyx22JWFVsbUsPxx0yJp5hj2r2t1uoTM+ltuMdaevOeY8
         U27nQV40VafWtbHATwQlW/zAO5ARggYtrAXvtiSz/QGpEPj/UDhZbSI21mXcZKMzKMBU
         xPBA==
X-Forwarded-Encrypted: i=1; AJvYcCWCawzbUhrNMElrfZrK0uqwjMjuUNwV+RV7FYAf0ThiR1bsomkW/7m5KOYH+UpmFUUDxH2/kjq3THY9yM788E8zqruiedY=
X-Gm-Message-State: AOJu0YzTOsyCUICYgTm5dMkpRtWURueIlFlyYOd35uItRtOj2V3/G+OS
	KLmHkExaePs51n4paLRrIfOOJiwKXuYMsz1AJ3aYR/EQZuXicgF/ZOGxOqum8G5ag4EjbpO67lA
	7+J1MiJwfSvTh/LdHUysfVcLsESEjFVTuSEPbFQ==
X-Google-Smtp-Source: AGHT+IFDeEEaIOtSBG5DGppYGHWRw4rXZqpgILKwzYCMW4SSXhcYWj+KFRDuw5xeuXxFLrQ0w0/J7Jaydr+ESekL/l8=
X-Received: by 2002:a17:906:70c9:b0:a46:6bb8:1ec4 with SMTP id
 g9-20020a17090670c900b00a466bb81ec4mr8429584ejk.76.1710866470240; Tue, 19 Mar
 2024 09:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk> <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk> <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
In-Reply-To: <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Mar 2024 17:40:58 +0100
Message-ID: <CAJfpegsCBEm11OHS8bfQdgossOgofPcYhLTFtw7_+T66iBvznw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:13, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:
>
> > What particular usage case of invalidate_inode_pages2() are you thinking of?
>
> FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
> to clean up the cache.
>
> The server is free to discard writes resulting from this invalidation
> and delay reads in the region until the invalidation finishes.  This
> would no longer work with your change, since the mapping could
> silently be reinstated between the writeback and the removal from the
> cache due to the page being unlocked/relocked.

This would also matter if a distributed filesystem wanted to implement
coherence even if there are mmaps.   I.e. a client could get exclusive
access to a region by issuing FUSE_NOTIFY_INVAL_INODE on all other
clients and blocking reads.  With your change this would fail.

Again, this is purely theoretical, and without a way to differentiate
between the read-only and write cases it has limited usefulness.
Adding leases to fuse (which I plan to do) would make this much more
useful.

Thanks,
Miklos

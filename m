Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66A78276
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899253; cv=none; b=fSYktfmKxHpfK0AIhnrYnTElhG0EFUjsiQow5e3PDMf5Wmup4td2qxAdAKhSOPj9lcFTfz8To+NpheNXEIp2HzWcTBe7cQIbz+0loITH5y4fW4lJyxtS5YTfi0GlaDEqzXZqOfZOMmR+NJZZZtRSaIjbeiP1zn0xHifpCu/mC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899253; c=relaxed/simple;
	bh=omEsVcWsZLflnY3L1Zl9HbjS8CtMimcbznoYdlCCSdw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=t1+PJ9xj80eEggyzG+vgO9hWewNlEodcG4nIKnd3YoerH08jmUUM1IDJBBAy/kRU6qz3BPSgizIysM/MQajf3OKrNNHrfXm/5d0HJcDEnPTO+Gaq1QKQxtNt/vFotSI2rRJAhMXRajXmBcjqHFIAcqkg3D4qonzuNjUxhISFl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMOo4LXR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMOo4LXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732899250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6x4H8Hyhdkdq1brSVU+4ZW0xvhZtskcZPKa0jF7BcE=;
	b=UMOo4LXRmdT/mLUSLCWNApAlytUR5Ad54c6nvuwsHqjO59wvfiWkf3prHdmXE/XFmBnNPC
	ga0TXzuP7OZSj6PjcHOR+iFi8XS0CFW3bchO7vI0jCQSmN+7F1noZUMiEi+NzxZ/gHVtGI
	43rjmbuLHu+yHVIvFn3HqIbJFAi5X6k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-aG6m9G-QPZ2BGv0vyyg8xw-1; Fri,
 29 Nov 2024 11:54:09 -0500
X-MC-Unique: aG6m9G-QPZ2BGv0vyyg8xw-1
X-Mimecast-MFC-AGG-ID: aG6m9G-QPZ2BGv0vyyg8xw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF4471955F43;
	Fri, 29 Nov 2024 16:54:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 158E51955F41;
	Fri, 29 Nov 2024 16:54:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+_JUNO5EZosu00H=tZsgfCAzQkBBkJjVfOHYrX_6mHEPQ@mail.gmail.com>
References: <CAKPOu+_JUNO5EZosu00H=tZsgfCAzQkBBkJjVfOHYrX_6mHEPQ@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev
Subject: Re: New cachefilesd implementation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 16:54:05 +0000
Message-ID: <4022108.1732899245@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eftNm_R1jnX0cusDBZhrVTRsRPlPjtioLJL55blHh8U_1732899248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4022107.1732899245.1@warthog.procyon.org.uk>

Max Kellermann <max.kellermann@ionos.com> wrote:

> the venerable cachefilesd has caused us numerous problems. We have a
> rather large cache partition (several terabytes containing hundreds of
> millions of cached files), and cachefiled's culling would take a
> thousand times longer than it would take the kernel to refill the
> space that was freed. cachefilesd had been running for months at 100%
> CPU with no visible progress. This made our fscache unusable.
> 
> This problem is caused by cachefilesd's bad choice of data structure:
> it maintains a sorted array of object pointers, making
> insert_into_cull_table() extremely slow and CPU consuming. I figured
> reimplementing it from scratch in a saner language was faster than
> fixing the old C code base. So I did just that, with C++ and io_uring.
>
> This is it, after barely one day of hacking: https://github.com/CM4all/cash
> It is not yet complete (hard-coded configuration, no graveyard
> cleanup, bad error handling) and the code sure could be prettier, but
> it's already running on our production servers and has cleaned up the
> mess that cachefilesd has left behind.

Nice:-)

Now, would you be able to clone this:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/cachefilesd.git/

Then rip out the existing code and put in your code?  There's some stuff in
there that is necessary to run on SELinux-based systems and it would make it
a lot easier for me just to replace the current cachefilesd package by just
pulling yours directly.

Also, you are using a simplified BSD licence - can you make it joint BSD/GPL?

David


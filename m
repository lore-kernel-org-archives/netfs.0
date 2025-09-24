Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C243128B8
	for <netfs@lists.linux.dev>; Wed, 24 Sep 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727510; cv=none; b=Sa/njRSATvQpF1FqiyMfzvnXuVZMEqfkV711qKOoLgd7m6oxUr8s2I8ZRxjwLLQbnMWBo9URG1pPTGXNTrHbBuA2FJltJ7bpfultptPncvCsK9mcFvfDeyZvdf2+bkzjXkUKrZqbQj2Sze8GCEnr8TFmWx3e7nSUIQuiUhMQxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727510; c=relaxed/simple;
	bh=U0SdXOUahWvhCvNN2IiXkoLSJW4W+TO1RjB82fo7u/E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PmNepMzK2esa2M3OCM6mu/eBHqQUAzlPWkHdZPvTUFcPJfMbTkTbhOzWIGd9pPHZ4Rn6Z88o3v9OYD/8WzVSWPiyF9kHeT8Ax07Z93Yc4DkSOKNxBIz4GOuHO83QkekDFF/5olqRu2lGTpQaDvFnqp0e1kjbTIN1OdDewWlEwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SF0wGCGn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF0wGCGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758727507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g839bYXXnXzsEzs4lSTasjKmFEmWp6qANvpUvXmul2w=;
	b=SF0wGCGnUi3JIJWCWoX8JPRVh2SDGavo68Gc8I4jci+4y27inloDGNbMVFgr7j3UFeYbVh
	/wkJ0L8S5/+YKhhgRM4t80A1HVbqk+WndF4HyAWgYMFATGDxRwaPqlXRM43ObX72/QdC4h
	5HSjPp9N6Xm+ezJgLF0Ak67Kr86K2m8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-U7tKr2YSOna7enw23176AA-1; Wed,
 24 Sep 2025 11:25:04 -0400
X-MC-Unique: U7tKr2YSOna7enw23176AA-1
X-Mimecast-MFC-AGG-ID: U7tKr2YSOna7enw23176AA_1758727503
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF799180034C;
	Wed, 24 Sep 2025 15:25:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A5ED1955F19;
	Wed, 24 Sep 2025 15:25:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250911222501.1417765-1-max.kellermann@ionos.com>
References: <20250911222501.1417765-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-stable@vger.kernel.org
Subject: Re: [PATCH] fs/netfs: fix reference leak
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <745740.1758727499.1@warthog.procyon.org.uk>
Date: Wed, 24 Sep 2025 16:24:59 +0100
Message-ID: <745741.1758727499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Max Kellermann <max.kellermann@ionos.com> wrote:

> For my taste, the whole netfs code needs an overhaul to make reference
> counting easier to understand and less fragile & obscure.  But to fix
> this bug here and now and produce a patch that is adequate for a
> stable backport, I tried a minimal approach that quickly frees the
> request object upon early failure.

I'm not entirely satisfied with the refcounting either, as it's tricky with
the asynchronicity requirements.

> I decided against adding a second netfs_put_request() each time because that
> would cause code duplication which obscures the code further.  Instead, I
> added the function netfs_put_failed_request() which frees such a failed
> request synchronously under the assumption that the reference count is
> exactly 2 (as initially set by netfs_alloc_request() and never touched),
> verified by a WARN_ON_ONCE().

I like this.

> ... and frees the allocation (without the "call_rcu" indirection).

Unfortunately, this isn't good.  The request has already been added to the
proc list and is removed in netfs_deinit_request() by netfs_proc_del_rreq() -
but that means that someone reading /proc/fs/netfs/requests can be looking at
it as you free it.

You still need the call_rcu() - or you have to call synchronize_rcu().

I can change netfs_put_failed_request() to do the call_rcu() rather than
mempool_free()/netfs_stat_d().

Another possibility could be to defer the addition to the proc list to right
before we start adding subrequests.  Deleting from the proc list would be a
no-op if the thing isn't queued.

Thanks,
David


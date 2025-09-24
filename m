Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1499246787
	for <netfs@lists.linux.dev>; Wed, 24 Sep 2025 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741032; cv=none; b=VjX6GqmmPfLJcqRsIUfkDJrojQ+1ogFe2GGE2nWpgngT25OyKIPIAIx/yIZYv2gZ0239ecRcxdvdz+3/LsbVdN2naLcSwvvEIMKnCIT6cE/N1A1dAhqmA4ux5zuCktLw6JdaVThVmbhxhwinibhiJ1Sgne4y2p75s54XIgSrMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741032; c=relaxed/simple;
	bh=i2PMjx/cXgaQTrG0KMXN0AgihKLKUGq9Peg9IQvlriY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=taLekQBhC/gXCV+Y9YPcSdZKqzzJJxDao1UBkxyS68YC0nkLMtV4eZ7GI7USYPL448oXuSHNt8WoEPgyxwee1UnptUdSuzxK9Bk0jtGAihbGV2tYf27GBKMl0r2cGP2k0/DuveE+Rgs4cLaVFAOG/bvPJQqG+W4DIKhHfKuzCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC+gCD7L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CC+gCD7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758741029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZUgcBfuIwk+pfIkmYDv+UjUD6Xv+wEGZOugd4rqBGo=;
	b=CC+gCD7L5+lDecrTHl3MZKujlUi8qkmFV5vdG6lq6MR2NZez0lGO+Krh7OZ9Y3iadF32hF
	PTVEmnpZiCHNmCQeYsAKsO+oq/QBoe9/K1OrHTrFVDNrav+aL+pYI2YUT6q7Y9GqDq8aOk
	I0m5sy+VYDUs8wjiQCj7f3TF3rDDIls=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-RSGj-L68M0-J_jDOD8GUlA-1; Wed,
 24 Sep 2025 15:10:25 -0400
X-MC-Unique: RSGj-L68M0-J_jDOD8GUlA-1
X-Mimecast-MFC-AGG-ID: RSGj-L68M0-J_jDOD8GUlA_1758741024
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F6F81800357;
	Wed, 24 Sep 2025 19:10:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00171300018D;
	Wed, 24 Sep 2025 19:10:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+9Ym+dRHQiMvjvdisnb5jwca4_2ECbzOMLYso=xNvxeQQ@mail.gmail.com>
References: <CAKPOu+9Ym+dRHQiMvjvdisnb5jwca4_2ECbzOMLYso=xNvxeQQ@mail.gmail.com> <20250911222501.1417765-1-max.kellermann@ionos.com> <745741.1758727499@warthog.procyon.org.uk> <755695.1758728366@warthog.procyon.org.uk>
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
Content-ID: <845699.1758741020.1@warthog.procyon.org.uk>
Date: Wed, 24 Sep 2025 20:10:20 +0100
Message-ID: <845700.1758741020@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Max Kellermann <max.kellermann@ionos.com> wrote:

> >         if (!__refcount_sub_and_test(2, &rreq->ref, &r))
> >                 WARN_ON_ONCE(1);
> > ...
> >	trace_netfs_rreq_ref(rreq->debug_id, r, netfs_rreq_trace_put_failed);
> 
> You changed the refcount_read() check to an atomic decrement, but at
> this point, nobody cares for the reference counter anymore (and my
> check was just for bug-catching purposes).
> Why bother doing the decrement?

Well, an atomic subtract, but yes.  I would at least log the revised refcount
- which actually I've done wrong.  The trace line needs r-2, not r, as the
__refcount_*() routines return the original value, not the modified value (the
opposite of the atomic_*() routines).

I think the refcount should probably be 0 when we get to
netfs_free_request_rcu() for consistency (and I've occasionally had a check
there), but I can live with a just a warning and the trace line printing the
current refcount.

David


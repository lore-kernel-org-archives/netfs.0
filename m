Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763C305967
	for <netfs@lists.linux.dev>; Wed, 24 Sep 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728382; cv=none; b=RxM+tP3L6PsqEAx2lGR2SpPH5MHF8qyBDaVjm+iFRNHyH8kx2EzBRKdX/iilRscN0B7Xyfw+GVulFrc/Ikrd197m9x5gVayf3UsoE+nSjW65lOdYUADqJI4HXY+gTv2uR0FNykp1gorLpelr1QzLYsYEPa3E7/adAXHQpHv0u/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728382; c=relaxed/simple;
	bh=v/Cr/IL70HpmLDXq0/COC0G/ZI+89mZIjWnRZv6XJNQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lo8E3Qb1S6eaowvzHj2XUuxMNMvOsR2rwUDh4T8ncUxrq1PpZejRpjMRP5P2fqNAG7ynwDftzWSL7VwIZUFjpWB83vS93Oud1gOBGwLMb/hd3c12P9fyw4cUsNnuqxjLja4Va44UBTDlvg6d+uxrC0FwDRw9qjdSGN9qkBF9Mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3xcyrj9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3xcyrj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758728379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VW0CPi1vI6VVLJVg3ytdkJ52tq0kRHmrUbFeTNhR9kk=;
	b=H3xcyrj9zsNllcdApP8lJ+ENZ7hmTyhaqYdFAKPyrX/nZoAEsXu3PfO8mrzCL6ynJGoPme
	xUa/KuGO8w6q3Pz3MQbfN4WH/N25ieQ3KUr686cDiMwg/KOY7Oz8abQadwweg86t9++e8L
	C9aVKf1kVFa/oKTjGV5dKMGL30WvKHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-4lk1vFx3OCKtwoH6h-Rr2A-1; Wed,
 24 Sep 2025 11:39:35 -0400
X-MC-Unique: 4lk1vFx3OCKtwoH6h-Rr2A-1
X-Mimecast-MFC-AGG-ID: 4lk1vFx3OCKtwoH6h-Rr2A_1758728374
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 097E318002E0;
	Wed, 24 Sep 2025 15:39:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABDF41800451;
	Wed, 24 Sep 2025 15:39:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <745741.1758727499@warthog.procyon.org.uk>
References: <745741.1758727499@warthog.procyon.org.uk> <20250911222501.1417765-1-max.kellermann@ionos.com>
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
Content-ID: <755694.1758728365.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Sep 2025 16:39:26 +0100
Message-ID: <755695.1758728366@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

David Howells <dhowells@redhat.com> wrote:

> > ... and frees the allocation (without the "call_rcu" indirection).
> =

> Unfortunately, this isn't good.  The request has already been added to t=
he
> proc list and is removed in netfs_deinit_request() by netfs_proc_del_rre=
q() -
> but that means that someone reading /proc/fs/netfs/requests can be looki=
ng at
> it as you free it.
> =

> You still need the call_rcu() - or you have to call synchronize_rcu().
> =

> I can change netfs_put_failed_request() to do the call_rcu() rather than
> mempool_free()/netfs_stat_d().

How about:

/*
 * Free a request (synchronously) that was just allocated but has failed b=
efore
 * it could be submitted.
 */
void netfs_put_failed_request(struct netfs_io_request *rreq)
{
	int r;

	/* New requests have two references (see netfs_alloc_request(), and
	 * this function is only allowed on new request objects
	 */
	if (!__refcount_sub_and_test(2, &rreq->ref, &r))
		WARN_ON_ONCE(1);

	trace_netfs_rreq_ref(rreq->debug_id, r, netfs_rreq_trace_put_failed);
	netfs_free_request(&rreq->cleanup_work);
}

David


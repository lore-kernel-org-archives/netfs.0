Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528520DD42
	for <netfs@lists.linux.dev>; Thu, 25 Sep 2025 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805572; cv=none; b=PPa+9bUv4adoA9QXZ27+Kl6XXsfu+T7I0RdqzJAk2EyZeqZUnORXd86jnz9EAHebqy8udDn6Ugp1Vu4lL5GwbGfrSyRZw+onienYeDi8HBI03m9Ja8oSfLlYBHtaDvQiMldQ73FjKl5CtJZKPFPmur5Vco5iHHVA1ELU9cauzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805572; c=relaxed/simple;
	bh=ajYxpxIEP7k3WKP904coMp9f4mHHdqsixWrMIwGweq8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ivA+oCaC+MSlbBLVs63IX4JInr/kqlDBBeLhcxrapoCgfpJaScAhkqo3K7OylwfuEY3KI/aajl+g2XyKLSgw1bpcgRRA4vIX3kGMsuvXYgt1gU5nRPr3kakmCSFGqGtNZzHj0TaGo3crtxHU/UN6AMBIm3oiD96JeRPat918lTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3bvbNt8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3bvbNt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758805567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AB3mZ2yKlLlvsRucKaic5XIoAiIXSqCRYH3aq8AzEGg=;
	b=D3bvbNt8B66WYPj4s5MDXN3222aI4H9IKk/pd/4W9Ffb6LGFsz1wwkBOK0hUGCULzuz5x1
	rL4h6TP+R+1HXvmBmc1yTYnHw3xvtrUe1FPPmPCIyr9wNuXJiUK85y+dHn36uNe6joB0G0
	E7ZPMZDevQXd5D6IB1tfGDrZ5NqNtdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-a3bwBgLKPQC_zUxyIPWByA-1; Thu,
 25 Sep 2025 09:06:06 -0400
X-MC-Unique: a3bwBgLKPQC_zUxyIPWByA-1
X-Mimecast-MFC-AGG-ID: a3bwBgLKPQC_zUxyIPWByA_1758805565
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7EDA180034A;
	Thu, 25 Sep 2025 13:06:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 883991800446;
	Thu, 25 Sep 2025 13:06:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <928357.1758793097@warthog.procyon.org.uk>
References: <928357.1758793097@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v3] netfs: fix reference leak
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <936353.1758805561.1@warthog.procyon.org.uk>
Date: Thu, 25 Sep 2025 14:06:01 +0100
Message-ID: <936354.1758805561@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

David Howells <dhowells@redhat.com> wrote:

> +/*
> + * Free a request (synchronously) that was just allocated but has
> + * failed before it could be submitted.
> + */
> +void netfs_put_failed_request(struct netfs_io_request *rreq)
> +{
> +	/* new requests have two references (see
> +	 * netfs_alloc_request(), and this function is only allowed on
> +	 * new request objects
> +	 */
> +	WARN_ON_ONCE(refcount_read(&rreq->ref) != 2);
> +
> +	trace_netfs_rreq_ref(rreq->debug_id, 0, netfs_rreq_trace_put_failed);
> +	netfs_free_request(&rreq->cleanup_work);
> +}
> +

Sigh.  I forgot to commit my changes.  Will repost.

David


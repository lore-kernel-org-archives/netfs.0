Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E843BF69E
	for <netfs@lists.linux.dev>; Wed, 26 Aug 2026 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772290; cv=none; b=DAHzws/anQ1Kum7q0hWUZ+1ttHUzvCa6otXSqRBPaNehN7b8WTZF3eWvQezsrq1YmgKEryx2BsdMoMsPbKdTi3H6N6499fPum1tx7S4BtmFoG2agtFaeLnRzvNnRJITzJwrRtyIw4n91z2UG0u3HepyfNHbREBsD9FpaRD5ZpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772290; c=relaxed/simple;
	bh=eXs30EaAj61t5ZJxILJrQN/NFWqQlBBnHy3/xelc8b0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=bQB/ZP/zCtudzUzbgxnj5ufc5Ky/BEpdI3EXfPuwkWqbWVJU2cDyR9DoDKkqgMU2LJHeuvXwdgKznbWW2d0t/RG2I0Ta2UgLyqTWzVpd4b99JiB2uMSsUrnu2PFyhhExiBT1c1FwNgir/iQIj0j6LM+lwARyfkNcFvuHYJO0EeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSZfN3jF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSZfN3jF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787772279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXs30EaAj61t5ZJxILJrQN/NFWqQlBBnHy3/xelc8b0=;
	b=OSZfN3jFomgRXkMR+BJifMiE0VzZrA2bx1yMxK6TpowoS5KnTlt0LyUSDJ3VNrfaaqOlRe
	qYXarz/tTY+b98uATYWZ3bijmXN+RpAa7+kO0z+WTtYqvz6AuglH7SUwMUMVLBfyeq1WRs
	8WwfEcdSCsQD/K5Grc7bQUlpiV4nI0I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-yh7AEuykO8aHpuCPGpYKFw-1; Wed,
 26 Aug 2026 15:24:35 -0400
X-MC-Unique: yh7AEuykO8aHpuCPGpYKFw-1
X-Mimecast-MFC-AGG-ID: yh7AEuykO8aHpuCPGpYKFw_1787772273
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93C8D1934486;
	Wed, 26 Aug 2026 19:24:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 789047C5;
	Wed, 26 Aug 2026 19:24:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ao8xqMXoCfj4AWUw@kbusch-mbp>
References: <ao8xqMXoCfj4AWUw@kbusch-mbp> <1819786.1787768317@warthog.procyon.org.uk>
To: Keith Busch <kbusch@kernel.org>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 20:24:05 +0100
Message-ID: <1853652.1787772245@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: KbVcKZ8IsDh1U8UJwjwT7qhJI7MzceuKgl0OUFKXP1I_1787772273
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1853651.1787772245.1@warthog.procyon.org.uk>

Keith Busch <kbusch@kernel.org> wrote:

> iov_iter_alignment loops over all the vectors when we only need to
> examine the current one here.

Can the check be done earlier, then?

David


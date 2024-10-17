Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF31DB546
	for <netfs@lists.linux.dev>; Thu, 17 Oct 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163046; cv=none; b=oFXsL7Wqnwg+XFX7ZJ29yxim8qvjjSKudRd+Jw4RfTh6pqnxmWwzXOLB2vnqCyLhLBfjJns5ibx5BxMZGwZfl3NCykWaVk7XM58gSUlwRAs6TYByrL1U1EQCB3L+iEx4G1KHUIpZVYzSYIpYFWqhs9xrD2yetEFoAl2fwoSuWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163046; c=relaxed/simple;
	bh=Uozh1w9LZoXr6ha27kAfa1WuCkzQONJaDgQPc6sczFA=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=LFkWtCD4Yfx76gv1UeBD3jORWwFKu0Pq0Da4s/WB6+wn4Kiwauj7FMpwM1P/Ow8mWgXaOYU2X0UUgFwgQUL4Px5jyT7Ou8n4H9qqYKNt525720JKEdBYB3QqDb23i6x6/IPBJm8XdpoJTgtMOl67WNOCLZNdFVLbAYyZljF4xFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGbWLYJA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGbWLYJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729163043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uozh1w9LZoXr6ha27kAfa1WuCkzQONJaDgQPc6sczFA=;
	b=TGbWLYJASrl5d9qh91ganu4+4j1DveTydhS8xTSXfpO0aH22beIEV8GhgJrj5TL3wC/chN
	kqTn6yU6yyprQUf0+05O0Iwkz9ROrj/yODMecYR5NAEwu3xLbXpPH+qyMhELMeSl2tRa/L
	4/cfjkk13i5fnF5kidwIGDc5yhFiH04=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-Pi1RK835NXed1iR06uqpVA-1; Thu,
 17 Oct 2024 07:04:00 -0400
X-MC-Unique: Pi1RK835NXed1iR06uqpVA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 755D01955F45;
	Thu, 17 Oct 2024 11:03:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AE1419560A3;
	Thu, 17 Oct 2024 11:03:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1292002.1729090128@warthog.procyon.org.uk>
References: <1292002.1729090128@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kdoc of netfs_read_subreq_progress()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1395128.1729163036.1@warthog.procyon.org.uk>
Date: Thu, 17 Oct 2024 12:03:56 +0100
Message-ID: <1395129.1729163036@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ignore this, the fix needs to be applied to patches I haven't upstreamed yet.

David


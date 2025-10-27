Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3521F5846
	for <netfs@lists.linux.dev>; Mon, 27 Oct 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574617; cv=none; b=BbBnTI6VIRZxhPQhKDPlNAkaCsy49W0RJZsL0wrBAfQ76ljisS5ppoZmlgExvvbccHjGIGQOT7kZRcm1TDJKyP30lETW3OhZl37JA7JXTRwl6i2vyfko/vIMG4suIhSt3Qzft+i5Caw6napiUIOZJPEWb0iPtaupOdS24MxJVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574617; c=relaxed/simple;
	bh=Dw07KsxDMWK6q+1bhz3mU9heARrzOdVTlBmyFJYnSmI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FN+UvsJKb+03MHRJMLzsTLeG99SBMY8XtcOYWZlM3bMywSA+5LBf8hUElQ4llWGYwDr0I7wnppH9PWa3+OJ4xKlj8G1MU4kNCpaersgrjbQU/2sfZ0ldo/ZINyL/qM//84FP/OukmDuizq01C50vlWorG3eL3wBOPO9No5RZ/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehE6hBRE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehE6hBRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761574614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbCNymmtAjHzkTy2SVLqM8Su4bRxtmTnw/VNxtUHjlM=;
	b=ehE6hBREeHAtHmlYZkBnp0e12sycqiRQcPlySH8Ps1Ec6cQa4+xP3ibNkZiSExKfpNzUbJ
	fSDfPTnG0C5/VOjkCORnIyrcfyEc0gBXz5MzNJUSzRZaQ+ITNK6fGvGT/YpVUaT5e+jnbZ
	tKIs6p2Ie1YsbACFvg2/AgOmrsR3GFA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-NKKEwCypPy2h8Oh52ec7Xw-1; Mon,
 27 Oct 2025 10:16:50 -0400
X-MC-Unique: NKKEwCypPy2h8Oh52ec7Xw-1
X-Mimecast-MFC-AGG-ID: NKKEwCypPy2h8Oh52ec7Xw_1761574609
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E9C6180121B;
	Mon, 27 Oct 2025 14:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE84919540EB;
	Mon, 27 Oct 2025 14:16:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251024170822.1427218-9-willy@infradead.org>
References: <20251024170822.1427218-9-willy@infradead.org> <20251024170822.1427218-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev
Subject: Re: [PATCH 08/10] netfs: Use folio_next_pos()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2253015.1761574605.1@warthog.procyon.org.uk>
Date: Mon, 27 Oct 2025 14:16:45 +0000
Message-ID: <2253016.1761574605@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.

Should that be noted to the gcc bugzilla as a missed optimisation?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Paulo Alcantara <pc@manguebit.org>
> Cc: netfs@lists.linux.dev

Acked-by: David Howells <dhowells@redhat.com>


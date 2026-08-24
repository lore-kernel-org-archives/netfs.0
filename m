Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6A3F1AB9
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586447; cv=none; b=j069ikvoqj8vb57sDrh/wNhboQ1+Lphs3W2YfAP8diBQ6vTL9h32Z/dlYa2zlLNR3+8ExlHTiSL+rJXgXLiud/rnDKbHYe+/As8EngS2SEAo2kqC9GmGWfk3nFM5x0r8NNwSBjjSQEbPaud/f88lxQbI243EDCCe9hlU8zG9Bgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586447; c=relaxed/simple;
	bh=PZT33+ibftQlwuOaaMiHEkIF1aY2uOf1QRnWrW1klE4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=UZToIKGZVoLhHNe9/VqQXP3S2T2xmmWRKOtGzRL3BZzOveVWYW7ennhbnlPJBdgRKZ/T5/zrGdjVWJuP8OfwhYH1iTZ+cnYtUbXVZFzxdNnpD79r5F/a//ktEvk5S0TYIupzoosDm/Hhyh9wjyTezUYRgjhGjH+J2yy7Dx/10rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdSgDG4O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdSgDG4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787586436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Il8N7nbO1mkjntgx2+Ot5JQ5xla6YwgaEYuxmPUGsA=;
	b=IdSgDG4OjziaLp/gFLca2biRSO3+siVqvWtwbhE/2Uhu9yxFdvT1ctvm/gu4cJFV+oeXJX
	gLUkVDp/KHYGVu4giNhY6i8T9ahpukiV+M0Lt88ACTE1Y7UcDVb0x7x/ZEyxla3yG83LYT
	guYBpu5pK0HTZ85OVwzPvRy0IWuU8ts=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-qqXq3d1DMEqhc8ZuvMiiZQ-1; Mon,
 24 Aug 2026 11:47:13 -0400
X-MC-Unique: qqXq3d1DMEqhc8ZuvMiiZQ-1
X-Mimecast-MFC-AGG-ID: qqXq3d1DMEqhc8ZuvMiiZQ_1787586432
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 492B71945CAC;
	Mon, 24 Aug 2026 15:47:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73E8B1955F0F;
	Mon, 24 Aug 2026 15:47:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aoxidVrUtl3F0QUi@casper.infradead.org>
References: <aoxidVrUtl3F0QUi@casper.infradead.org> <761202.1787584160@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev
Subject: Re: Function to do end-writeback in bulk
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 16:47:08 +0100
Message-ID: <762789.1787586428@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7aGWxoJi_5D10205dYy6twFIXWaTRDxLCTrSssBOZK4_1787586432
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <762788.1787586428.1@warthog.procyon.org.uk>

Matthew Wilcox <willy@infradead.org> wrote:

> I hate this API.  I much prefer the _iter() style:

I'm not that keen on the _iter() style, but whatever.

However, does that make it harder to do the stats manipulation in bulk in
future?

I was looking at __folio_end_writeback(), and I see:

	....
			wb = inode_to_wb(inode);
			wb_stat_mod(wb, WB_WRITEBACK, -nr);
			__wb_writeout_add(wb, nr);
			if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
				wb_inode_writeback_end(wb);
				if (mapping->host)
					sb_clear_inode_writeback(mapping->host);
			}
	...
		lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
		node_stat_mod_folio(folio, NR_WRITTEN, nr);
	...

And I was thinking those could be done in bulk... but there seems to be an IRQ
disablement requirement around them.  Does the folio_xor_flags_has_waiters()
have to be done inside?  I presume this is to prevent a set/clear race on the
master WRITEBACK tag.

David


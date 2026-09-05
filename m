Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B336B910
	for <netfs@lists.linux.dev>; Sat,  5 Sep 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625614; cv=none; b=FpIzlDUwIpXRKt91f/qnGXhuZNijBiAqcfW91ysPc/ZJXo9yvjb1iCa0mj4jZq7ljTAXqKbaHyglrv5AvSu9uWGCDl8WieTdNIn9jTyrcniqB23+LnwMe6YAtpwbNHn2cOMe1TX9PBoi09nXVa3tibPlojLm8exm4xFiHMMj+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625614; c=relaxed/simple;
	bh=3SS2H5X7fEPe/WUlOi2ijPcY3Sm5sDXvvcBImIaTxig=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=ojwLWTyJ7oa9e8gnpsaiduDzmNA2wDq3Nwo1AWiEZ5rlRn+fkhpuPTUdsEg5XfQCiurJkJieaz3KbkQP1updKb8mhXeUrJ1dlcPC9kCNGjdXe+s3VxpE9qLHmnromLjmGnnizCoAor0NMwT9QmwASYabQ7oIeL1C03bvl7spL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDXSc0hP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDXSc0hP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788625612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxdp3KRdBVi8QQnCMsuF6AtR6CEzxy4cd18pQFv2r+o=;
	b=CDXSc0hPoaxdw2OZdktcaNvuzSdpxswphh7k2qM43DBoQxnAW9rpTiU8zePDYZWlmOx2je
	RjtfvFjb5Dsa17iw2Np2QdDrITuwhyn6XZqL26uSEL+GGP4W7wOeT4j2ZU5CRwaJy3cYgH
	0Xt+FOkuikWecHtSWoEOUS1iayCasUM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-XC2ypVG4MOqDjyQSHPGeXg-1; Sat,
 05 Sep 2026 12:26:48 -0400
X-MC-Unique: XC2ypVG4MOqDjyQSHPGeXg-1
X-Mimecast-MFC-AGG-ID: XC2ypVG4MOqDjyQSHPGeXg_1788625607
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D26C01801363;
	Sat,  5 Sep 2026 16:26:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D41F55B1;
	Sat,  5 Sep 2026 16:26:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <apsP3Hvlw-fpd6uF@kbusch-mbp>
References: <apsP3Hvlw-fpd6uF@kbusch-mbp> <20260902112743.GA11999@lst.de> <1819786.1787768317@warthog.procyon.org.uk> <1895550.1787777192@warthog.procyon.org.uk> <350212.1788514937@warthog.procyon.org.uk>
To: Keith Busch <kbusch@kernel.org>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
    Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 05 Sep 2026 17:26:40 +0100
Message-ID: <1183138.1788625600@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: N3s8CkkHhWoCac8_3GhkQ0QcaEOKbbtagtZKEdjcOg4_1788625607
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1183137.1788625600.1@warthog.procyon.org.uk>

Keith Busch <kbusch@kernel.org> wrote:

> If a block device behind an RDMA NIC really wants to DMA a single byte
> at a time, we can't describe that capability today. That would require a
> 0 mask, which is currently treated as "unset" and overridden with a
> default 512b mask.

The thing is, Christoph said:

    Massage __bio_iov_iter_get_pages so that it doesn't need the bio, and
    move it to lib/iov_iter.c so that it can be used by block code for
    other things than filling a bio and by other subsystems like netfs.

but unless it can have a 1-byte alignment, it's not actually much use for
netfslib (I have to be able to support "unbuffered writes", which are almost
exactly like DIO writes but without alignment restrictions).

Do block devices really need an aligned "start memory address" or just an
aligned "start file position" (whatever that means for a blockdev).

David


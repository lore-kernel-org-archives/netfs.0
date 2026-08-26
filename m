Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8148382E
	for <netfs@lists.linux.dev>; Wed, 26 Aug 2026 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775821; cv=none; b=uZF4bV6RmKk65jkeXdyBS+KhcJTrNMKwKxC9h8pCrF9w4b9mSs64+1OQwtc5eCEFpoIEDbOb+dMxfajJAKbCmP//L83gZTdkA4me+YyM7PHoQLgHbX/bLySEfeSLcGwhrmCXOnPQP/S218Wwr0ZQO8LNHrapLh/BvdAsRi0OALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775821; c=relaxed/simple;
	bh=hKNdcb4O36pMXXUw78XWvmtZ8Cm6SzYmwBSdUVVWCko=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=STZET3hfiC9n4mflfIm/0Rw5D2fKBRpXTUR0UTFJKIrz1KgQqBvHE+tph0fX2WDLlf63t0YMHSNPf6mOBUi6CgopFyEoTUTgi5IaKOwkyzdI+/+S99nEo/FvNIlrDupHUkzQER2Z5YFh2x5aCpZOcbGoxda+KbBPyEqhdeBey+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiJWlD2b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiJWlD2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787775819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9qT7qssYQfRq6O+ZWVrZCYJE2b1eCy9Sb45AALyhFQ=;
	b=CiJWlD2bo9FfmzMR8jFL66/WLGEltsw5eY4saSxhhJ24te/CAkPC2yegRmhQhzYkEOWOsD
	tdw/znr1mIhhakHItKlvvIUUCzUMBjI06jwIwig8hgsaoPwmKGbqRc3IwAwIRcvXL94Se2
	F2geC4V5pWbCuLvmdwLDMMJVG3EoWeg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-Ez1R0MTmOw2r8ezdmlwTyA-1; Wed,
 26 Aug 2026 16:23:36 -0400
X-MC-Unique: Ez1R0MTmOw2r8ezdmlwTyA-1
X-Mimecast-MFC-AGG-ID: Ez1R0MTmOw2r8ezdmlwTyA_1787775814
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75D6C1862D53;
	Wed, 26 Aug 2026 20:23:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4D8E195608A;
	Wed, 26 Aug 2026 20:23:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ao9CvZDRChrrxyCj@kbusch-mbp>
References: <ao9CvZDRChrrxyCj@kbusch-mbp> <ao8xqMXoCfj4AWUw@kbusch-mbp> <1819786.1787768317@warthog.procyon.org.uk> <1853652.1787772245@warthog.procyon.org.uk>
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
Date: Wed, 26 Aug 2026 21:23:30 +0100
Message-ID: <1885163.1787775810@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: TfqZqa5H4igTJA9oWsKju0uh6awHUYUVlzAlo3_3wlg_1787775814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1885162.1787775810.1@warthog.procyon.org.uk>

Keith Busch <kbusch@kernel.org> wrote:

> +	if (likely(iter_is_ubuf(iter) ||
> +		   iter_is_iovec(iter) ||
> +		   iov_iter_is_kvec(iter))) {

I wonder if it's worth making an exception for ITER_KVEC.  I know the structs
align, as it were, but do we use ITER_KVEC often enough?

Anyway, it seems to work, so you can add:

	Reviewed-by: David Howells <dhowells@redhat.com>

if you want to submit the patch yourself.

David


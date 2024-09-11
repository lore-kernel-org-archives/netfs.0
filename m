Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265A13C8F9
	for <netfs@lists.linux.dev>; Wed, 11 Sep 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046530; cv=none; b=WwCCWBzMYhiy9jotLeR69qYFHtE/uRcvXC3dXAtp12wH+jwnIoifa4IgqBcw5qdw9p9AiCe/QodJeYFNaiUj6yTnOTGGdKs2XhyJgTtPMgdngw/9Ib0T2goPvm5Jtn0Kc8t815JvCo/L8aCfAKllCLUu9rYM8HPst1r/bq2+9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046530; c=relaxed/simple;
	bh=zrBummcZeGnm/foE77TqhEpo1lrFMrUYjiQz+Bb0Dtc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=pZO9ZD7Q6lSl+OJ0tpzXngnfMvEpxJ6WBBjnDTboio/pPr2HISZYG1Vrse9LyWynhK2hberVJhiR3yjsCWSZ2gG0ZXj4eVNizCyuyrOmVo+pMG+WwjL24Sfu9eTsPtOMyZdw9AnG8xZ7ioGtOYPxWDIk1pjp+UbSvGpqGYg19h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aD9CQzRI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aD9CQzRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726046527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJB52gLbCmBHhz88g5jpQJjPjyqb9QPzJPx7QdTrxeI=;
	b=aD9CQzRI1iFlENrP9DGfAf1KsfArwHqmW7toZqLFvrvFEnEfQNuyRcoZVoHMKRlMkyMFZQ
	+TO+fQgT2KWbsqdHQBJuFce7m/3mNa0DHQV8jLMuhlaJNkVXwxmXwSglqQRltl70zOAz+y
	/szrL0ttJC/4u8MgVjTYYW3bHdQPFnQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378--k0OyN1tNUuQDIoc9F2iTA-1; Wed,
 11 Sep 2024 05:22:06 -0400
X-MC-Unique: -k0OyN1tNUuQDIoc9F2iTA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1281419560B0;
	Wed, 11 Sep 2024 09:22:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF8E2195605A;
	Wed, 11 Sep 2024 09:22:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6caf8f55-4eeb-4ada-8ecf-9c92ce83f40b@stanley.mountain>
References: <6caf8f55-4eeb-4ada-8ecf-9c92ce83f40b@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev
Subject: Re: [bug report] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 10:22:01 +0100
Message-ID: <755884.1726046521@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <755883.1726046521.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Dan Carpenter <dan.carpenter@linaro.org> wrote:

>     107         if (WARN_ON_ONCE(!folioq) ||
>                                  ^^^^^^^
> Check for NULL
>=20
>     108             WARN_ON_ONCE(!folioq_folio(folioq, slot)) ||
>     109             WARN_ON_ONCE(folioq_folio(folioq, slot)->index !=3D f=
pos / PAGE_SIZE)) {

None of these three conditions should be true - and if they are, the operat=
ion
is broken.  We cannot find the pages we need to unlock and processes will v=
ery
likely hang.

David


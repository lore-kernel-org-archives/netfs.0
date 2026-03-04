Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683253A1A54
	for <netfs@lists.linux.dev>; Wed,  4 Mar 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634860; cv=none; b=BCZfMhLmr0UFypYisthaZq+HaQyRmDJ1/0qJ87g1+47pGlGcqS8VWSqFSMCB+sxn6Uk4xkmWPfn82Hbd7AIBfGMD8WoMF4/b8qfK5PxFJpjp9AoiHQv7R/JZPWcK8vO0H1Yj9RlX9S12+5sAFxYVAhsWizh26uWjUu6VE+yjL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634860; c=relaxed/simple;
	bh=bpuGRVu4Y18L5xc3H1PJ2lREyhify4Ay9P9h5KY76nk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=DGyTFzo45gVq9/vezxdrHSOUTWrHVfHg0WcjRb4NZXGTzgBY39ZHonBQEl/arGmOkU8LarzuYsPQ3lR2nSRtszEkbVHjD3N3AJt+99naC8xRE7yUK4GbKq4/w9Y573DRMHrvf363CdYZCcOq4jD+vX4Oqhf2kEHyCTvKJvasJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/pSXnsK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/pSXnsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772634858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLC9JL4iyVNeLfPEDV0W2Yxh7iNZYOFRw/HOSKzzhuk=;
	b=R/pSXnsKkH1PjdkZPKOdCMoFB8MS9bYHEm94P3YRCtMMQvC1N5jyVJ0cKV/Of3s42lQgzY
	Suyx507PdB7lqD94CO0aceodg9qtmHyXHoeT1kCo2dSvij51vn1TH1gNnC2fa7ZFv7HO/3
	9VsbfRxKb+rw/GjZLFpV5OyAmj5WvPs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-S9NpySwlNAOll3R8_b-uzg-1; Wed,
 04 Mar 2026 09:34:14 -0500
X-MC-Unique: S9NpySwlNAOll3R8_b-uzg-1
X-Mimecast-MFC-AGG-ID: S9NpySwlNAOll3R8_b-uzg_1772634851
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E89519560B0;
	Wed,  4 Mar 2026 14:34:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40E33300019F;
	Wed,  4 Mar 2026 14:34:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aahA7rQVf5liFYMv@infradead.org>
References: <aahA7rQVf5liFYMv@infradead.org> <aag8fPUDCY_g-_LY@infradead.org> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-3-dhowells@redhat.com> <114166.1772634114@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
    Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
    Steve French <sfrench@samba.org>,
    Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>,
    Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 02/17] vfs: Implement a FIEMAP callback
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 04 Mar 2026 14:34:04 +0000
Message-ID: <156719.1772634844@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ORzPKMdDD9v3PZjdUHIVNNWluo80oH3ynjIsz8WH3fQ_1772634851
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <156718.1772634844.1@warthog.procyon.org.uk>

Christoph Hellwig <hch@infradead.org> wrote:

> > So I have to stick with SEEK_DATA/SEEK_HOLE for this?
> 
> Yes.  Why do you even want to move away from that?  It's the far
> better API.  Of course like all other reporting APIs it still is
> racy, but has far less problems than fiemap.

To find the next two extents of data, say, I have to make four calls into the
backing filesystem rather than one - with all the context set up and locking
those might incur.

Granted, the vast majority of files aren't sparse, so one pair of
SEEK_DATA/SEEK_HOLE should be able to establish that.

David


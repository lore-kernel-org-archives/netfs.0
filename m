Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE13A16AE
	for <netfs@lists.linux.dev>; Tue, 13 Oct 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879265; cv=none; b=bQ0DAUHffkoNJqMNa1MO/S/seaREaSfmtHdOZtZ5osSDB8778Mvla9bUaPNZuJ7vTSX8Uyq2qON7xn+2Tz63WAkhqrq5gHA/CxFgaH7ssBwzx+XVuoqckHOMAMEN8Cu/aBfCOWb92CDYkf8akeZSnkxAjrOBo0QpEOf65VJswg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879265; c=relaxed/simple;
	bh=IKFHO+kOl9Tc4S7kki9YjAh5N0Gn40d8snKchp+T/oQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=kAYhozlrdDVhIXt8h5ZLY9QlFCcJFeGGKAxjC+xPwU05UAiX7SQ9QACEA26zXCutbWHUg5DwsUa87ojuNyS75uts6zX0nfrD+IgTkDS0W7nIc43QvMaln3VA/dDqYAUQ+PGcvRz6Uk/m9c/g6mIXNG9IjOLLu4+rgejEMHSSZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZHkzcaC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZHkzcaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791879262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPcLZMrkmKQNPyJNJuuM2meyy3DGclfXgz3Bj4WDa04=;
	b=UZHkzcaCVzn9EwrMCt7bH+OUsxXYChrccUwLiE4NLumIr+//rrE0vNpJ6uyMy4wGQ9/XUn
	tmXv/uEE0i9n6LM2glEoCBd9JYDsHaLxZYbSDqKS2jDhJ5yw+YPdju0AVqjOJSnNPaUQTm
	g6jnivEVm3GCcWmSOl6+P64KZSzq1y4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-W3Z3eWXuN-uipHnTTMh3Aw-1; Tue,
 13 Oct 2026 08:14:19 +0000
X-MC-Unique: W3Z3eWXuN-uipHnTTMh3Aw-1
X-Mimecast-MFC-AGG-ID: W3Z3eWXuN-uipHnTTMh3Aw_1791879256
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC411956055;
	Tue, 13 Oct 2026 08:14:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F30691956095;
	Tue, 13 Oct 2026 08:14:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261011.cachefiles-seek-hole-walk.pchmelar@innovatrics.com>
References: <20261011.cachefiles-seek-hole-walk.pchmelar@innovatrics.com> <20260910220242.2165023-1-dhowells@redhat.com>
To: Petr Chmelar <petr.chmelar@innovatrics.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/5] netfs, cachefiles: Changes for next, primarily occupancy tracking-related
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 09:14:08 +0100
Message-ID: <1655915.1791879248@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: CLa4iwV2oA3M9X0t10LVKff3lvrcmqhLt1BorNZwmHY_1791879256
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1655914.1791879248.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Petr Chmelar <petr.chmelar@innovatrics.com> wrote:

> The cover letter leaves non-contiguous objects, which still use
> SEEK_DATA/SEEK_HOLE, for a later series.  We hit that case badly in
> production, so here are numbers in case they help with its priority.

I know.  But it's a tricky problem to solve as I need to store a map of the
content somewhere.  xattrs are painful as I can only read or write them
atomically and as whole blobs - and also I'm not sure if I need to limit th=
e
size of any given xattr to 512 bytes.  Further, the xattr wangling interfac=
e
inside the kernel assumes a flat virtual buffer rather than taking an I/O
iterator.

I have patches that store a bitmap in an xattr, with 1 bit per 256K block o=
f
cachefile, for a 512 byte xattr able to map up to 1G of file size.  I need =
to
revisit this at some point soon.  It may be better to switch to storing an
extent list, but:

> On our NFS clients (Ubuntu, v6.8, cache on XFS), a sequential read of a
> fully cached 184 GB object with 1,080,732 extents ran at 0.4 MB/s.

Trying to store a million+ extent records in a single xattr would kind of
suck.  Now, it might be possible to collapse that somewhat if a lot of the
extents are virtually sequential within the file, since I don't care about
physical sequentiality.

Also, can you tell if you have a preferred cache granularity?  Would a 256K
granularity, say, use too much space?

> I expect the right fix is for cachefiles to track what it has written
> itself, as CONTENT_ALL now does for contiguous files, rather than
> something like the above.

Indeed - as mentioned above.

> I can send the workaround if it's useful as a reference,

If you could, that would be great!

> and I'm happy to test whatever you plan for this case on our workload.

Thanks.  Now I just need to reproduce your bug.  Note that I posted another
cachefiles patch that Christian hasn't picked up yet:

https://lore.kernel.org/linux-fsdevel/1091807.1791483394@warthog.procyon.or=
g.uk/T/#u

David


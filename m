Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FBB20C00C
	for <netfs@lists.linux.dev>; Wed,  4 Mar 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634130; cv=none; b=BweflVhcXAeeT3zwe+4zjkAyDLjNbYFzFqzcjFrlPr6swhARetuMu03AAJWIDV4xq2eKToqqKVf+zLCss5sVh/w4j1u4/frfPRWoFYTAM3vcr9xemLKf8RzfadHbQkrwNG1vwKuJj28vRWJp5UrWWak5ndRiwphaFasn8fai9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634130; c=relaxed/simple;
	bh=i6B1COMSoOfOy1Ywp0Xy+nU+vpDghGuqfhet1X3zJ2o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=pHGoxBd7oio0pbT+vVTZhBL51luCpEHWIhZRZawDX9X1fWOPFeezjUJIFZDnKzAcpR2E0AjUDCMGZIX5FXr5UZAYQIKeNX6XQnDhDHsjf3uTuzenkGZCVoQyrlR7VLpCHZLMjcfRtnZi34559AeJv4EXu6ZDm091u82zyZ8afOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEjZAG3T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEjZAG3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772634128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZC/6b7qh9Tg+WradIFmtnRq/34sYFPOu2cQrV/3YGg=;
	b=CEjZAG3Tai9Wreh7at2w1dlMScaGHnvUng7ulvDQDr/7HIVIMlIsx361T0wBOwlTJMmTtO
	mNhVb56uJi4gJGMRUDm900fw0RUeKOTJjOIRKVDK9diE9xS1XsG6bOtAyen6duH6k3XYU3
	w5+FbUuO6abNsTgze0sUbLnA9J0vD9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-mIEEh07FNsmkxpV8oYyAkQ-1; Wed,
 04 Mar 2026 09:22:03 -0500
X-MC-Unique: mIEEh07FNsmkxpV8oYyAkQ-1
X-Mimecast-MFC-AGG-ID: mIEEh07FNsmkxpV8oYyAkQ_1772634121
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 934FB180035C;
	Wed,  4 Mar 2026 14:22:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2858430001A1;
	Wed,  4 Mar 2026 14:21:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aag8fPUDCY_g-_LY@infradead.org>
References: <aag8fPUDCY_g-_LY@infradead.org> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-3-dhowells@redhat.com>
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
Date: Wed, 04 Mar 2026 14:21:54 +0000
Message-ID: <114166.1772634114@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: a4KHc-ZkqbO4IRTKUeGsOUR-y8iM8d2X-LxbteYFe50_1772634121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <114165.1772634114.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 04, 2026 at 02:03:09PM +0000, David Howells wrote:
> > Implement a callback in the internal kernel FIEMAP API so that kernel u=
sers
> > can make use of it as the filler function expects to write to userspace=
.
> > This allows the FIEMAP data to be captured and parsed.  This is useful =
for
> > cachefiles and also potentially for knfsd and ksmbd to implement their
> > equivalents of FIEMAP remotely rather than using SEEK_DATA/SEEK_HOLE.
>=20
> Hell no.  FIEMAP is purely a debugging toool and must not get anywhere
> near a data path.  NAK to all of this.

So I have to stick with SEEK_DATA/SEEK_HOLE for this?

(Before you ask, yes, I do want to keep track of this myself, but working o=
ut
the best way to do that without reinventing the filesystem is the issue -
well, that and finding time to do it).

David


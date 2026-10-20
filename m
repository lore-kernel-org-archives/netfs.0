Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482358;
	b=aAkaUZPt32cCgYGveYG7DR1L5QIK8Tn3k5Rwf/ctfY0BhgOSzdCNQaIApAsUShoEdl2o
	 w927ckUhowA/HxXv6b7kNhO4ff1VcalZ63dFUkw6cf68D0Stj5pZW198QFmkuMlU7qR2j
	 rliQj950Mor4zcJvvcjqN9eWN811a+droYA/YNBGXaGQ7gUby738ZAP8Obb2jFtd/7qWn
	 J1Fn1b3egYChqSs3XSQ/0IsDkM8hw0TfTWIyZuosxnTnDoDjahD00d4Qi4HdbcEJK4bVd
	 oAoh8VJ0mbwddGM3+G0ZjlK126Pjb5jM0L0KDsOfbBtJJT3WjQOwMzhONmb0PVqCgGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482358;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID;
	bh=etJHoXzss+lLgalBskXJJBLUzw7KY5e4yuY8e35KdUo=;
	b=4Q1NT1iOPPkFp/S1Vp2nvbM89ioufVN3Yh3ye3Tz4gy5kJYF8hZUVMANm+JtGQwZlz/I
	 x5iWbFM9ewG0T6m2YRnk0wLUhZH/kkLLIE9+pSY1Tg5frkh0AIh77g37XEGEWUh/JjsUC
	 oep3TfKYJYLl5t1u6DCoV38lwZxokpnJwZ0ujd/9mdgEH1Y5Wbv5ZzOCMIG/2iC21S/IF
	 dwqwKdhAZ8vk1cHc41ysOQbYg1AmsZXpIM9k+9X2WJhGwjUGfynimRYLjDwPaTJ7qyL13
	 aPVlaIu7oEsvZCOgomaMB9/CDOTOmuCAo/dXGfwlNCgUDXH7ILRNk+oj43lGyS++fdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="hNSxP/Yj";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04A606A31C
	for <netfs@lists.linux.dev>; Tue, 20 Oct 2026 07:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A04A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hNSxP/Yj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792482356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etJHoXzss+lLgalBskXJJBLUzw7KY5e4yuY8e35KdUo=;
	b=hNSxP/YjGTAfYZKooGOlwzLaLxS3DbySf8gw701EFQB4hiBP+VifN5wZMQP+ALAbxemycN
	L3IEvexfPIyxGi3lAvVy5XjPv2JgtXdxvfjwJBW4NlamYf0FpUPj8NDoVBAVZpRAwJAQg0
	OQprVAu1vQRZxl0PP/WjOnMEfhWzHDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-y-UzeCQONTON4CooZ3kcPw-1; Tue,
 20 Oct 2026 07:45:55 +0000
X-MC-Unique: y-UzeCQONTON4CooZ3kcPw-1
X-Mimecast-MFC-AGG-ID: y-UzeCQONTON4CooZ3kcPw_1792482352
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B27DD1955DC3;
	Tue, 20 Oct 2026 07:45:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CED701800446;
	Tue, 20 Oct 2026 07:45:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1995693.1791971125@warthog.procyon.org.uk>
References: <1995693.1791971125@warthog.procyon.org.uk> <20261013.cachefiles-partial-zeros-trace.pchmelar@innovatrics.com> <20260910220242.2165023-1-dhowells@redhat.com> <20260910220242.2165023-5-dhowells@redhat.com> <20261011.cachefiles-partial-zeros.pchmelar@innovatrics.com> <1655268.1791878098@warthog.procyon.org.uk>
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
Subject: Re: [PATCH v12 4/5] cachefiles: Don't rely on backing fs storage map for most use cases
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 08:45:42 +0100
Message-ID: <2648476.1792482342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: BIkDFdu8ge3ZNeeMnRncYvvt98-P0YiegHYypvsSgSs_1792482352
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2648475.1792482342.1@warthog.procyon.org.uk>

Hi Petr,

Note that these patches are now upstream with this change incorporated.

David


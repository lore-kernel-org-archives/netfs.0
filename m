Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5E3B27FE
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511496; cv=none; b=XTuIW6HJbfZNpJoHAn8iIZk3b1trgJYiROnXUBY/IHgGy9mBkd5Sjd//dY0mGHsGRcocpw/3iJmRlsKecZYPdh2Zk4b/QGSGpJV8BtcIca/ZTzV5d1iG1G8Dcf18AkRNdrvCFCISdXBxRwg3jHuNNduB2QnlMlkzz/IOHTeFas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511496; c=relaxed/simple;
	bh=9yMY0Oft9j8AD9bB6lRfrS9aYWbSbCToUNZGJasdTtk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=dt35MDMsI+ZrVWkRmfHq/kEMpJT9siOWGyQp0JwVCwlG6Ff2dAOnF3Iu+cwTQ5FHBIwDQTNChXJGnCkpkNder+WyjibRiMBOW5fOrOiXr0GHdX8B5ldD2gtq+GYMq/EwP56aCOOUSLf+jnCST2EwM9WBK6LsndYbUEmPOrurSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B66SLJlV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B66SLJlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774511493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwTdnovHurdxaZYYo7V6Dev0j3q5EbtIM+A/6yqrwtY=;
	b=B66SLJlV80lH6HziXCZdQdkYfHExM/w9HyGBIGbWo67IAuU6/jQwqOZ8T7dJTFXM1j/t+O
	I2MIXNI7v88WTNevIAfpw4oJ1BAR7vexIWeUg+TO+oejxlGkO6wADJ2nP3lxQ4A5Wt3RiK
	1EAToEpLlHQPTOauYNHiXuyguOVWLgU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589--Wj_oSjYNFGdD8zxbeYj9g-1; Thu,
 26 Mar 2026 03:51:29 -0400
X-MC-Unique: -Wj_oSjYNFGdD8zxbeYj9g-1
X-Mimecast-MFC-AGG-ID: -Wj_oSjYNFGdD8zxbeYj9g_1774511488
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD3EC195608C;
	Thu, 26 Mar 2026 07:51:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F8171800576;
	Thu, 26 Mar 2026 07:51:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAB9dFdvs4=ZbqHeoMFXj39tPxCxKsApHXdyCxvjT8aAAbRCf6Q@mail.gmail.com>
References: <CAB9dFdvs4=ZbqHeoMFXj39tPxCxKsApHXdyCxvjT8aAAbRCf6Q@mail.gmail.com> <4001609.1774391729@warthog.procyon.org.uk> <4002225.1774392603@warthog.procyon.org.uk>
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: dhowells@redhat.com, NeilBrown <neil@brown.name>,
    Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 07:51:22 +0000
Message-ID: <405501.1774511482@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 31ty784zTy3wR-X_TiPlPj5ml0hG2ZuSL3IqK9oUbnM_1774511488
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <405500.1774511482.1@warthog.procyon.org.uk>

Marc Dionne <marc.c.dionne@gmail.com> wrote:

> I think it is the correct Fixes tag, but I'm not sure that this is
> actually the right fix.  7bb1eb45e43c switched other callers of
> cachefiles_bury_object to use start_removing_dentry, which gets an
> additional ref, and removed the extra dget from
> cachefiles_bury_object.  In the cachefiles_cull case however, the
> dentry is from start_removing and has a single ref on entry to
> cachefiles_bury_object, which is an issue as "rep" may be used there
> after end_removing may have put the last ref.  So the correct is
> probably for cachefiles_cull to add a dget() before the call to
> cachefiles_bury_object.

Ugh.  You're right.

The problem is that we're calling start_removing() without knowing whether we
can just unlink the object.  I wonder if I need to do the lookup in
cachefiles_lookup_for_cull() and only then call start_removing_dentry() if
it's not a directory (directories get moved to the graveyard for cachefilesd
to tear down).

I think the right solution is actually to move start_removing_dentry() down
into cachefiles_bury_object() and make it contingent on the dentry being a
non-dir.

David


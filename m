Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133731D131B
	for <netfs@lists.linux.dev>; Fri, 25 Oct 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843567; cv=none; b=UnfgyWcC4UgHywIuGa1T2jcIyrHSHOGGfZx5asrlFtOvM18h7zJ124nfVqcbZOkT3PqCaxvG0rvOIBtu2xJUyYt+ZMgNIxSHTovQZZjBTB52OTgScz0hCzJ4jPQvdqs/wfdmP+THlJNEm67BD1PG3vupDevuwShCHh2ODqJcwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843567; c=relaxed/simple;
	bh=ATaXUh+6mRM8+DzD6T9X0xAxW2Dm2ynHKp1/NJ1ZYS4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=IO9YyONCaZ8s+QTJ/xtMMkqAJgAA7SOmF58r7Ij+uH7JkLVRjvnKtObLhXenrvmkoD0VJO5TKg2g9biXZzrzrf7GDRAZALO1wXf/X5Hk4GjIoGY4onWqjBWubB+CbhSCMLWTDx6D5Ufp9R/EHBxRqMfrlNTK3EmXMN5mTo0INxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfmgmHXI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfmgmHXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729843563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJJHsXrgapppl7p0/PyNGlnzqEqHhWtD8NkXnb6nj9g=;
	b=WfmgmHXI3W4nNO9PPzBW71mGmK5SV6+ywrMwYLks82mWH65y2wiRvWdBKAUNAdoc2n+PXo
	n53DWlSTnG0kbhAV/vfsoqfRptd8PudznpPAMmitdmQGK6w2ldU6NWwVfhqWQ8y6LHyqJc
	THeZATKPwefaVu9fyTR/P7Pm1AR2h/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-FPE0XAzzPNeTRp9zwS178w-1; Fri,
 25 Oct 2024 04:05:58 -0400
X-MC-Unique: FPE0XAzzPNeTRp9zwS178w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1383A1955F43;
	Fri, 25 Oct 2024 08:05:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B461C1956056;
	Fri, 25 Oct 2024 08:05:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxshMEW4U7MTgQYa@gmail.com>
References: <ZxshMEW4U7MTgQYa@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Add a check for NULL folioq in netfs_writeback_unlock_folios
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3951591.1729843553.1@warthog.procyon.org.uk>
Date: Fri, 25 Oct 2024 09:05:53 +0100
Message-ID: <3951592.1729843553@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Chang Yu <marcus.yu.56@gmail.com> wrote:

> syzkaller reported a null-pointer dereference bug
> (https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16) in
> netfs_writeback_unlock_folios caused by passing a NULL folioq to
> folioq_folio. Fix by adding a check before entering the loop.

And, of course, the preceding:

	if (slot >= folioq_nr_slots(folioq)) {

doesn't oops because it doesn't actually dereference folioq.

However... if we get into this function, there absolutely *should* be at least
one folioq in the rolling buffer.  Part of the rolling buffer's method of
operation involves keeping at least one folioq around at all times so that we
don't need to use locks to add/remove from the queue.

Either the rolling buffer wasn't initialised yet (and it should be initialised
for all write requests by netfs_create_write_req()) or it has been destroyed
already.

Either way, your patch is, unfortunately, just covering up the symptoms rather
than fixing the root cause.  I suggest instead that we patch the function to
detect the empty rolling buffer up front, dump some information about the bad
request and return.

David


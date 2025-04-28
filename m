Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06072797B1
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855602; cv=none; b=d7F4GNw7RTIo8kZtZUGWTAacJWXjVMWt80vQ+C32L0aFIGeKUzUR8hNEfDHCqjuUHzSqET4KKnWhpdgU4qRRRRuNhQ990aptsQZeNwft5UvFC+2woIOSLXCGZ9crRk1jnMjlJrBtwgBg/qgIsL/r5H958FfNabTSPikwX4NTMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855602; c=relaxed/simple;
	bh=5cYNNf4wFqNqtaNOjGR5cKHx09Edg/U4QkNplcm9KN0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=tWzdCpCwxmwtNghMw9A0qP/Ae1gAfOooiC/QK5LhrQGnZLkXuavjxYwV2hbhFxurlcwU47mIJgYeciMfqOeIsIwWJGIhbzTeo7d5Ye1DUyT2VP55voF4T9Kuhst68PlDih3PV7iXKuErwfwOAt59xezNt6SQvOlaXaKc0LljOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E68iPjEe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E68iPjEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745855599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yFNAMhuU+PWVZiK9ijY/9ml9G6ViTLQrWpp9ndl8SK4=;
	b=E68iPjEer7jGtiNPcuvVKx4c1aNnCWx6JcWb3WFUGq+wFUvuIADGKVxW4tX33puPFnTAYe
	4P+OwahIUtJtoxYyYP27dDS8AjS/SlzLZRMu+Xw7TZCacb+Ba6wNUODYcOxHYvVOSsDiKV
	6EEJfzwOSCeQuaVbbxf/GQbkjNwagR4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-cV2W3rH7O5-TbKlPdw-rTg-1; Mon,
 28 Apr 2025 11:53:14 -0400
X-MC-Unique: cV2W3rH7O5-TbKlPdw-rTg-1
X-Mimecast-MFC-AGG-ID: cV2W3rH7O5-TbKlPdw-rTg_1745855593
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5639919560B1;
	Mon, 28 Apr 2025 15:53:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49648180045C;
	Mon, 28 Apr 2025 15:53:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250428131149.3195399-1-max.kellermann@ionos.com>
References: <20250428131149.3195399-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/netfs: remove unused netfs_io_request flags
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88830.1745855591.1@warthog.procyon.org.uk>
Date: Mon, 28 Apr 2025 16:53:11 +0100
Message-ID: <88831.1745855591@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Max Kellermann <max.kellermann@ionos.com> wrote:

> NETFS_RREQ_DONT_UNLOCK_FOLIOS has never been used ever since it was
> added by commit 3d3c95046742 ("netfs: Provide readahead and readpage
> netfs helpers").

I'm fine with removing DONT_UNLOCK_FOLIOS.

> NETFS_RREQ_BLOCKED was added by commit 016dc8516aec ("netfs: Implement
> unbuffered/DIO read support") but has never been used either.  Without
> NETFS_RREQ_BLOCKED, NETFS_RREQ_NONBLOCK makes no sense, and thus can
> be removed as well.

I'm less fine with removing the NONBLOCK handling I might need it for the ceph
conversion, so I think I'll split the patch in two.

David


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2E264613
	for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539018; cv=none; b=hXM2XVb4WTh5vXcoXb3K5VcvWeRcySXgbYJBD1APByLTZgQvL7EEBr8pKn2+0+GoEAnn+Z/l7A9YWHqgFFJbhBEN9QtM6DcdS/op64V/4uMfUV69wBzjudTfIKCfVRMMQ6+WiBvrCdol8dFeOugg/D2iQAm1QkhUcUbQ8BKu61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539018; c=relaxed/simple;
	bh=4z1f4w3fc/rS+rR37tw4jvKtssLmhg7xJF+noxM8VNw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=X8VrugN3DjPZpx/Xc4YNLu5GZPscJUaoauIp2CxWDOdjxr5K6anEGXlsE6KNzN6Rdbxe/dnJfkL4jvzO+YF24ds0hW7U/zPZdwdsZky19xbC44t0k+pE3PxgiowU8HiwPLWGOmf20wE7kGNhaaUXO4U69LedJQuuE3+K4LblZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGvpyO+w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGvpyO+w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739539015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M24UA7C5snSotQt93BcJrFNpx6zFhQ3V7OApt+YZfGE=;
	b=IGvpyO+wvq6OTBCk+PuwJIHoReE1eesGKtL9ZVsW9hSdZba6eXT2H8J7AnmVggTyDABEcI
	phZtuY+ULxVY5lCVLLOEy6TkY8xhF8aLcf93VzIbQzT9u+yCmXwHuHFrXENF0l0M8+ljK1
	wunNrsIvJDRW9n3k76+iNbth4yKeSIs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685--G0UtyqJM92QBVRVbsr8hA-1; Fri,
 14 Feb 2025 08:16:51 -0500
X-MC-Unique: -G0UtyqJM92QBVRVbsr8hA-1
X-Mimecast-MFC-AGG-ID: -G0UtyqJM92QBVRVbsr8hA_1739539011
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6BE71800875;
	Fri, 14 Feb 2025 13:16:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95DCF1941298;
	Fri, 14 Feb 2025 13:16:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250214131225.492756-1-max.kellermann@ionos.com>
References: <20250214131225.492756-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6.13 v2] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3979098.1739539008.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 13:16:48 +0000
Message-ID: <3979099.1739539008@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Max Kellermann <max.kellermann@ionos.com> wrote:

> When checking whether the edges of adjacent subrequests touch, the
> `prev` variable is deferenced, but it might not have been initialized.
> This causes crashes like this one:
> 
>  BUG: unable to handle page fault for address: 0000000181343843
> ...
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Signed-off-by: David Howells <dhowells@redhat.com>


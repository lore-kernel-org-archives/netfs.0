Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF523312A
	for <netfs@lists.linux.dev>; Mon,  9 Dec 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760245; cv=none; b=p+C3vJRV6RtSBrqJNFbCZ2u2slCOW7k2v+0i7YmP36PJODMJm0i0XchCowg/61upuHYMoAEef8/+kXLLHQsJabdbzAtKrp7PUmVdYgbe35JuI2oxVu4uoPAjuuUU3sBIzeEkeoo/jgKX03NzuLkNY7eWvNaDOi6W8EgwigD9U4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760245; c=relaxed/simple;
	bh=HcHrZ+agvz4D3sGtHxCE7PE6Arti4HiRiqeu5M1F8EI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Up8Ubm4nLg2W+vuIvqVpjfyvlUDBEfGNOIVkT4glAHgdvJcc4zRJQIs3YX9g03pvzBPpycHo11GcK5pl+k+IeK6initLg/QLR9xKb3/Ttff2CbVuasQzLbvNFJY8mQCZkwrewP7Qyi7I1fVQauLLseyaaqn9MotA/jioqeTAWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPTfDn/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPTfDn/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733760242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcHrZ+agvz4D3sGtHxCE7PE6Arti4HiRiqeu5M1F8EI=;
	b=jPTfDn/BGEJPJyCbwlyKxv9hf3cddC67vd/aYfvYrM31wPHIXuODSPC7k9o2+86OELu6ZL
	+cfiPVRuk8hQVfm9ghvQykDtuBZAEEobcjKh4iVxXFub+VPjssf607FurJLIkI+GIAXy8Z
	g7Rpo8bTwDseHyxeiMlOD5uW1ru5MXw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-eVdzHhjhMAC2XveG54Er6w-1; Mon,
 09 Dec 2024 11:03:58 -0500
X-MC-Unique: eVdzHhjhMAC2XveG54Er6w-1
X-Mimecast-MFC-AGG-ID: eVdzHhjhMAC2XveG54Er6w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 465B919541BC;
	Mon,  9 Dec 2024 16:03:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C8A2300018D;
	Mon,  9 Dec 2024 16:03:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241209141554.638708-1-max.kellermann@ionos.com>
References: <20241209141554.638708-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/cachefiles/daemon: parse the "secctx" immediately
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2133496.1733760235.1@warthog.procyon.org.uk>
Date: Mon, 09 Dec 2024 16:03:55 +0000
Message-ID: <2133497.1733760235@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Max Kellermann <max.kellermann@ionos.com> wrote:

> +#include <linux/security.h> // for security_secctx_to_secid()

You don't need a comment there.

David


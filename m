Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA7142915
	for <netfs@lists.linux.dev>; Mon,  8 Apr 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597614; cv=none; b=S5R/GVbSTjrHsp1gV81piDJLFHUUZA7iA+xVp3Umt0FqhH6U6/4wi7N8vGwZbV/M0RcQd1nEYtsj0n31BoqhDu6Aa6bCNJiX6/53IpH1NI8wHKnvP6fXvrxSF4tZwK8xfQ6ADPH7GlU02DqKcLcjCG2srFFk0snDYFX3ynxZ3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597614; c=relaxed/simple;
	bh=CfLaq95BkMSA0XtRlPnjFPaE2t4NcEfRmjGqf61OlLg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=t+OnsifvgFbJD9VOxASasNvxbZOnS40p+GLb7VrqjUU1ZRBRuD/eC0Ap8Suh1HE8jm5aZUVEsn86s2OcCGY7f+AoEoH5eHmyKH9zM03HDTzkMmBEjr9l9fTiPhs75Cac0r6akeFATA7enIIJH9KpWCKyQ57cvMOTbhMY6xSPzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw2LuE6k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw2LuE6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712597611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAzY052FFRL6Ki/cMLqOtCezbVtFnueMQ6ie7ljlA+Q=;
	b=gw2LuE6k/ZkF4PauqUifJg6vouANJ0x4MwSDQ4WAVfgZZ+RzNY7H+f/EePEADeKDwMxypV
	ry3mYkKnKLyWgsppxqbAfJAhKSc2RLT3NqkYCL/cpU8c8pDHH2G9kVmn+14pnmk6F2Hecj
	G83O/8J8SOPcLijp5DUpGFknzo6nGFs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-0OnwymV-NzKS73L3p8dJfA-1; Mon, 08 Apr 2024 13:33:30 -0400
X-MC-Unique: 0OnwymV-NzKS73L3p8dJfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D87C91044571;
	Mon,  8 Apr 2024 17:33:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75CAA47E;
	Mon,  8 Apr 2024 17:33:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <f61c6d0f-17ab-4182-b7fd-512c7de2047b@moroto.mountain>
References: <f61c6d0f-17ab-4182-b7fd-512c7de2047b@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev
Subject: Re: [bug report] netfs: New writeback implementation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 08 Apr 2024 18:33:08 +0100
Message-ID: <956318.1712597588@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <956317.1712597588.1@warthog.procyon.org.uk>

Dan Carpenter <dan.carpenter@linaro.org> wrote:

>     52         if ((group = netfs_folio_group(folio))) {
>     53                 if (group == NETFS_FOLIO_COPY_TO_CACHE) {
>                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>     54                         why = netfs_folio_trace_clear_cc;
> --> 55                         if (group == NETFS_FOLIO_COPY_TO_CACHE)
>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Duplicate check.  (This is an unpublished (too crappy) smatch check).

Oh, right, yes.  It used to lock the folio around the second one.

David


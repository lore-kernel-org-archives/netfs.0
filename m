Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC96360EC9
	for <netfs@lists.linux.dev>; Wed, 22 Jul 2026 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729055; cv=none; b=dIKnRlqnemQt6GNN2ZMdRirTJcntI6yjcB7uxz0WWgCmPiw+7hpIFEY36Nz+gAutsdS+bFQNe8QwNERSvJ/5ziFTe68XHONJA+5R08lJ3ZWUOtihijMq1rC7DictcnP21i3yxta+zvwKKuS6mw+EUM768yx2hdRO9XuXCRK+OkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729055; c=relaxed/simple;
	bh=+jE5RtHiFCFsqRctu8nubzAMJF+Q5ZrEUxZJ1z1zmqo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=UvEW95kTJZ1OysmeWVEYO77WwgtvxDCToPf2632FEEqJQk//ZYFD4UFy8oIqoyPNFcpM2WvHZOyPAePtv2J2/UkWXbI3Gzg5O/RcsJpS1YA1KP7fdYmgU3d06skJURbOA4VcA1M/S5MNhJ4aYnHkPYjg3wAZOemP0J5sv2+fEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCJctclC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCJctclC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784729053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOWY4gaKzic5dswrNjiYeY8YSOaB6YOZpY9kmZI2+j8=;
	b=JCJctclC43aMdfySyG+RX/uQUBFnha2ssKOLakOfgIoEpV86ERfrcp7g3K0AtIV71BjvUi
	j3EYeKplFVNeUmojDUvpMelrOtkqPqwnBEJccfcA/eDdqT805fTxTic8glKG6xQeEkCY8M
	ApSOAfFbg0JQs1sS2v1YuF4QygJWsh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-f5rT5wR2Myyf52nL3e7l1A-1; Wed,
 22 Jul 2026 10:04:09 -0400
X-MC-Unique: f5rT5wR2Myyf52nL3e7l1A-1
X-Mimecast-MFC-AGG-ID: f5rT5wR2Myyf52nL3e7l1A_1784729048
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCF9E1800628;
	Wed, 22 Jul 2026 14:04:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B67C18002B1;
	Wed, 22 Jul 2026 14:04:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260707052555.2055002-1-yun.zhou@windriver.com>
References: <20260707052555.2055002-1-yun.zhou@windriver.com>
To: Yun Zhou <yun.zhou@windriver.com>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Is writeback_iter() missing some error handling? -- was Re: [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to drain all dirty folios
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 15:04:03 +0100
Message-ID: <82546.1784729043@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: yBihqSB9H8y-rizhL9hsBMiX86zAEjEryLlg4jLjdlg_1784729048
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82544.1784729042.1@warthog.procyon.org.uk>

Yun Zhou <yun.zhou@windriver.com> wrote:

> When netfs_create_write_req() fails with -ENOMEM in netfs_writepages(),
> the couldnt_start error path redirties and unlocks the first folio, then
> calls writeback_iter() expecting it to return NULL. However, if the
> mapping contains multiple dirty folios, writeback_iter() returns the
> next one, triggering WARN_ON_ONCE(folio != NULL).
> 
> This can be reproduced via 9p (cache=loose) with shared mmap writes and
> fault injection (fail_nth), where v9fs_mmap_vm_close() triggers
> writeback on a mapping with multiple dirty folios during mmap overlap.
> 
> Fix this by looping over all remaining dirty folios in the ENOMEM path,
> redirtying and unlocking each one. This ensures all folios taken by the
> writeback iterator are properly released, and they will be retried on
> the next writeback cycle when memory is available.
>
> ...
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
> @@ -597,10 +597,11 @@ int netfs_writepages(struct address_space *mapping,
>  
>  couldnt_start:
>  	if (error == -ENOMEM) {
> -		folio_redirty_for_writepage(wbc, folio);
> -		folio_unlock(folio);
> -		folio = writeback_iter(mapping, wbc, folio, &error);
> -		WARN_ON_ONCE(folio != NULL);
> +		/* Redirty all dirty folios and let writeback retry later. */
> +		do {
> +			folio_redirty_for_writepage(wbc, folio);
> +			folio_unlock(folio);
> +		} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
>  	} else {
>  		netfs_kill_dirty_pages(mapping, wbc, folio);
>  	}

This seems like the wrong thing to do - or, at least, a bug in the
writeback_iter() API.  Getting something like ENOMEM would seem to indicate
that all subsequent writeback_iter() calls in this loop are pointless as it
looks like the sequence will just go { lock, undirty, dirty, unlock } for each
folio.

David


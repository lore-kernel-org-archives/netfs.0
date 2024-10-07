Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322E1D61B6
	for <netfs@lists.linux.dev>; Mon,  7 Oct 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310630; cv=none; b=oBCG2Rz66HpPmGvOeLi0hC4SaXdmwCqTedqc4ycaNIsLVtw9obVMUb5rfXMycB1Tyq4zGz79EmHJObFN9Lt0etp7w9M5K6hvqiFJaCCUrqMTm8C8WOG27srbewahciaqrv/J169hVBzCXpb5Nv7IVVrAtDeXBCfaPocaeDlZ0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310630; c=relaxed/simple;
	bh=u7ClgkijmuDdJzVEGH1EwztG5dTCm4cEuSWarOKj7/0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Zp8Y4p/9XJu2MBw5PVIn9ridsl1qFULusRwrUgcEvdTI5EOUvl0U37tIiSmw8ldzvzi/t49hZ1HDAg9cKounXbIBYnHn/6N8LD2Yqv+xj9er9dy2+kXuUwR1OiTilc0kXjmcmyF4yMsVhwS/+BFf0WnyrEZgaQy/GM2BGtTykZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IryR0X3p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IryR0X3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728310622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nt9+NMCe54ZPgr5XEk6vy7KjRpiXDO4UoWJRSikZ5Do=;
	b=IryR0X3pmMoSDpcH4m8YqzXEmSx7oI+6MfLb6RXcHz4a8xavdnlwcMDg1Yy1n/c4HjsKHv
	KTEaQeT6Daxmy40aIiLYE1fZSQTGlVysTwhbk2HbDm5ZU3C6CuOGcYQQCDYLVX/tkSm0ZT
	EstTWj3TS8nhQrzdpzQMLhuxb0ofEd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-yB7DJzB4PWm2nlTBjPjt2w-1; Mon,
 07 Oct 2024 10:14:54 -0400
X-MC-Unique: yB7DJzB4PWm2nlTBjPjt2w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31BD3197731F;
	Mon,  7 Oct 2024 14:14:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 120AD19560B2;
	Mon,  7 Oct 2024 14:14:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241005182307.3190401-4-willy@infradead.org>
References: <20241005182307.3190401-4-willy@infradead.org> <20241005182307.3190401-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] netfs: Remove unnecessary references to pages
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4027733.1728310486.1@warthog.procyon.org.uk>
Date: Mon, 07 Oct 2024 15:14:46 +0100
Message-ID: <4027734.1728310486@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> These places should all use folios instead of pages.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: David Howells <dhowells@redhat.com>


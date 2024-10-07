Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F261D54E3
	for <netfs@lists.linux.dev>; Mon,  7 Oct 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310444; cv=none; b=bR3h2ARe89ZYdlC2kdhXPB1kxhyq0p15pfH3WcmvbDRw7/yGDrw0iMUKKnLZiIAguscDw4QIcQnsXZYWrKxcWULk1+olVWscTG5PO4NgviRplIDODqJa0SwqT59VZW/BS6lw7jotFu/61Ivz7lPIBq0WIrXBqWFqNOHzJAC6AwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310444; c=relaxed/simple;
	bh=3uebTxn9YgI6i5zfpZtkhSyh67xtURKm0fPZi4CKTd0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CpC+/bIrSDX8zFUEvXJqczhIib1f+RPjkdK5kCfUne0tQKUlZ5i6r/cjQHVqgzyFgSCIehVq4U+4wWlCFh4PvZGDxYg4HuP1ypklmxU9DDkcRhMt1WuMj6Ri51pBuXkWVXb7TujUTao48v/xPGrZT/S4T7unmV9rF+Et+ckrNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrsZrCSJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrsZrCSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728310441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uebTxn9YgI6i5zfpZtkhSyh67xtURKm0fPZi4CKTd0=;
	b=hrsZrCSJmpULZNkkDiTN4ROHUeqWVtstpkmIFhylcsY+2Z6P267yoxMPe+JXZWl7byqqaF
	MdwMec+SxRMIgJxiP6JSW7C59I5NCLeWrpON5ITx+Y8/eHl4AzGd+b4RUURghuHFlldFez
	aCsyHPzT/T2DWvBvhCVzC6ehc9FQ19A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-iH58uYBVOJyWEmBMdLxVuw-1; Mon,
 07 Oct 2024 10:13:57 -0400
X-MC-Unique: iH58uYBVOJyWEmBMdLxVuw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D77C19560A5;
	Mon,  7 Oct 2024 14:13:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C148C19560A2;
	Mon,  7 Oct 2024 14:13:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241005182307.3190401-2-willy@infradead.org>
References: <20241005182307.3190401-2-willy@infradead.org> <20241005182307.3190401-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] netfs: Remove call to folio_index()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4027692.1728310433.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Oct 2024 15:13:53 +0100
Message-ID: <4027693.1728310433@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Calling folio_index() is pointless overhead; directly dereferencing
> folio->index is fine.
> =

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for bu=
ffered write")
Acked-by: David Howells <dhowells@redhat.com>


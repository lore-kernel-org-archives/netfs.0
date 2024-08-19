Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6322142900
	for <netfs@lists.linux.dev>; Mon, 19 Aug 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066919; cv=none; b=UQAPCe1NUqDEnHaN1tjFnJctNfB5+jm89Aak32IYXOmYo5NnLe4CBqy78/6d0Imxt9Ic0J46zUK6EvCI+AykGg3K5IP/E2ouzWfE8l3w8AlKiqpSW2DqTom+tUATLLGpmrDtZqVRksKFgFCw3HjOznL35SEKaUrC5/RUDatXfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066919; c=relaxed/simple;
	bh=pCdKbg2IonVUE7MsyUqnh2ZFiQjv3GCYxHDwmk/gJgM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=fc5GdWRa7Pe9qZ6aCSG6o/au7sdomKEXADzR8KTUN1MXMPERnd72mYBvyvKYUsnByCbBNnFaujTemOGPfw7juFzTurcrQpfXT9CU0GwDoLxHF1ZLWmPzU7q+kaGhzPxTgEkthSVx75+Eg7YqaVxrEhFh2/8fKgV8h3xn/PvABKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdxfA/sV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdxfA/sV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724066916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yp6fNF+eCA9e8aQaE3bPcLdJ4RiET3kZNbtEC5oE8sw=;
	b=XdxfA/sVCjv/KpTMaZ0YzPf6Fj1XARJUVcsxeQXwivGU5/XNx48O3bYV/LmPHuacS8hiOV
	G4evJsOyn+Cu2XMmRg8P6n0KQBrkT9/Oir/UPBOUe3ZH44EUkd9h3JvgvxVtmS8pF8MfLs
	uDiEXwbFAMw4CCZ5vug3sEx5RtZ5X9I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-4uSv0xDfO5Wzo_HlTfgoCw-1; Mon,
 19 Aug 2024 07:28:33 -0400
X-MC-Unique: 4uSv0xDfO5Wzo_HlTfgoCw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 005191955D44;
	Mon, 19 Aug 2024 11:28:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8EC030001A1;
	Mon, 19 Aug 2024 11:28:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240323092312.1643320-1-yangerkun@huawei.com>
References: <20240323092312.1643320-1-yangerkun@huawei.com>
To: yangerkun <yangerkun@huawei.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, hsiangkao@linux.alibaba.com,
    netfs@lists.linux.dev
Subject: Re: [PATCH] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 19 Aug 2024 12:28:28 +0100
Message-ID: <3402464.1724066908@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3402463.1724066908.1@warthog.procyon.org.uk>

yangerkun <yangerkun@huawei.com> wrote:

> The name of debug config used in fs/netfs/internal.h has a mismatch
> compared to the define in fs/netfs/Kconfig, which lead to that debug for
> netfs won't work.

Thanks, however this patch is now obsolete as of commit
fcad93360df4d04b172dba85b976c9f38ee0d5e0:

    netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG

David


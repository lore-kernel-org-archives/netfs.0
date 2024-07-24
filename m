Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81115252B
	for <netfs@lists.linux.dev>; Wed, 24 Jul 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814194; cv=none; b=i9VCnX3XFbJgPncfPV4X4Wdjr5Eh7v78zjiyF3w2lQMrwy/aZvtDgSG2PvW0QfBYl3iJud1nzgMRLlWUsRt+96DzrhLxBodRmcIlmSbJcekJLG784v8NwWCg5CTqoTUzRvszv/LAKNSzrFEHr0BVuGkGQEbZkmqOxQI/dtaawUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814194; c=relaxed/simple;
	bh=On3pfYPoO7z0t+5h4T28x9zYP+tznnS6VJGlMP61PsU=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=Lu1yW0A7i+JIonjKhuBxi5S4eyDxS7rX0eCvMHev5K4HwxGSDYlMJYkA/mopqOaWG6agNf/5FLjjRfMbZojbrRux0+d00iI/Bzzoo7uZsPFe4wZmk2s2ocWvQ5UK+R+w9JfnNOU2X6kqlmDgCM5qOul8AutVtbzh12YD3eiF1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIdTZNMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIdTZNMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721814192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=On3pfYPoO7z0t+5h4T28x9zYP+tznnS6VJGlMP61PsU=;
	b=OIdTZNMY1ucKBWGQ/539/CbutW9cHIzrCCZ9vhu1A4QzEVFqNnK/2fQ54gCLuUHtnF/OeL
	mtmwMd+cOMor9mrrLrCcpuXsXB5Sr+peOT9dhBtSFOD1j75PEHbyT8vrcwa5UksgRq6UgL
	OvTUhoqHO7rw2ptaVbDNAQkEDCXC6LM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-aiHBK3TROMqWK67A11NOKQ-1; Wed,
 24 Jul 2024 05:43:07 -0400
X-MC-Unique: aiHBK3TROMqWK67A11NOKQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E84B01955D57;
	Wed, 24 Jul 2024 09:43:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBDCF1955D42;
	Wed, 24 Jul 2024 09:42:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2299428.1721813616@warthog.procyon.org.uk>
References: <2299428.1721813616@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Gao Xiang <xiang@kernel.org>, netfs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix non-taking of sb_writers around set/removexattr
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2300460.1721814176.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jul 2024 10:42:56 +0100
Message-ID: <2300461.1721814176@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesy=
stem")


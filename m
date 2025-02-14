Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BB264A79
	for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538237; cv=none; b=cRcbMTSCGkamiQSIVQXpxaCMtwXQLJOwJ1X5QC36vnjvhts0M4bSR3qrXYlfwX3RnDdCK3gdR36BR7UWjbDc37+dTRPFzyb1b5oVqNArwEuZnWqgOG0nW0qhkBsfPfJP+aiOtvb5Hqp/wLCkrSTPJyo+aoOsJjhzVwbeEdSmxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538237; c=relaxed/simple;
	bh=+dRvZAEpzggpCGdlVHWJjVQQHmFiEjX9LCOV2fbhmjE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=WPcpAWMHYbFMx+vBB1L0YPGDGZCP9RHiJCvRDiod3nTplExuaPb6a9OAUaTt9uuwQhdA6Ako2merAqvtWWCjyxCXAsQnUjbEcdNIC6hyCsD2ETFYOZbUnHPvQsohlHFng1RrqhE+LTpWisdPSccESGzuJR6UTCAkzmQatamAJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crKONSKN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crKONSKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739538234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkmQoBgY6ibrO0SJlNLLatAXD9nZtLfLlyNK+9OBhaI=;
	b=crKONSKN+Hu0vh0OBsnGzatB1xNS08JnsSxPLc+5PqKiILkouxZWy2D8yvGXOc9P+Mznml
	Po2UD72qSAAcP7s9fgWp//yn/emdKNYqmnh6G5DTNK1NQsgYvwmeqQJD3tdNRzepyvIGMa
	B/JlQrUJLXM+FyrIs0lnlafUsCi5Ypg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Nol8qBg2MiuZsh45u0WI8Q-1; Fri,
 14 Feb 2025 08:03:52 -0500
X-MC-Unique: Nol8qBg2MiuZsh45u0WI8Q-1
X-Mimecast-MFC-AGG-ID: Nol8qBg2MiuZsh45u0WI8Q_1739538231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD5C18D95DE;
	Fri, 14 Feb 2025 13:03:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 847C51800352;
	Fri, 14 Feb 2025 13:03:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250211093432.3524035-1-max.kellermann@ionos.com>
References: <20250211093432.3524035-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Johannes Berg <johannes@sipsolutions.net>,
    netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3978534.1739538228.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 13:03:48 +0000
Message-ID: <3978535.1739538228@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Max Kellermann <max.kellermann@ionos.com> wrote:

>  		prev = list_prev_entry(subreq, rreq_link);
> ...
> +		if (subreq->start == prev->start + prev->len) {
> +			prev = list_prev_entry(subreq, rreq_link);

Actually, that doubles the setting of prev redundantly.  It shouldn't hurt,
but we might want to remove the inner one.

David


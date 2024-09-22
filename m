Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF5A23
	for <netfs@lists.linux.dev>; Sun, 22 Sep 2024 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726963618; cv=none; b=JXoXAEB8yOBwYNicuL5HBim3K4LMZiskfeqBPSDKQNb//dHlPYfGO1Qf90+i6y5LrDFQZ4qDe91Tfl+JI0RZRcosLWdWugjkgDgvLLnqMmNF8+ZwoiC4zjJ13nQufzUPb23zbpD7T1Gaq4bvM4Yd2AtbaB4h+6c8PD7io48g088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726963618; c=relaxed/simple;
	bh=WKyntDpY5RfpkJ3slVwHqlKCBjPxUylJnKPiT5ID+wg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=XERw2X3at3FlT3wL9vxzAZkCP7ix5EiRxIoW3ql6f25/S/6GMv6wPKezD8xyZdf4TsuF2oSDAh+jjqnTfGLnnawcAcFez86aqUCF9XBtzF8Y7FnuBRoYWlOzM4mFaFc04j1ZfUypKEw91+rmRLCokSDp+bs7kMBjmYqotBqwHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/BsWNL+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/BsWNL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726963615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08s6M0VfFhuosAR80HkD/E3XEVyWoGIAF2KhFDbJcRY=;
	b=M/BsWNL+5jtQXK785cjJVCbaDVFoeRCM4SlU+CAJDdUx27Ue80g6E2qoDGuufJAILzRCHf
	qHML/sccMNNUd8ACLNp6I28vlAPdPdFIwyC2ITviJ7Eiv043Yjxt/sTnz21desGhrwJOqV
	B0ljKobeSd2s8bjH5v3nEk0IBWpSBN4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-vSH2yiwgMliaspwAsY6mqQ-1; Sat,
 21 Sep 2024 20:06:52 -0400
X-MC-Unique: vSH2yiwgMliaspwAsY6mqQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FCDE19B9AB4;
	Sun, 22 Sep 2024 00:06:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A3F3195608A;
	Sun, 22 Sep 2024 00:06:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zu4doSKzXfSuVipQ@gmail.com>
References: <Zu4doSKzXfSuVipQ@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <557229.1726963607.1@warthog.procyon.org.uk>
Date: Sun, 22 Sep 2024 01:06:47 +0100
Message-ID: <557230.1726963607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Chang Yu <marcus.yu.56@gmail.com> wrote:

> -		tail = kmalloc(sizeof(*tail), GFP_NOFS);
> +		tail = kzalloc(sizeof(*tail), GFP_NOFS);

I'm deliberately not doing that because of the performance hit.  That's 31
pointers of which, in many cases, we're only going to use the first couple.
There's a bitmask indicating which pointers need putting and a counter that
indicates how many are used.

David


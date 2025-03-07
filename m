Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7AD1E1DE7
	for <netfs@lists.linux.dev>; Fri,  7 Mar 2025 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339015; cv=none; b=PWk/3/2XD8mKXDnYUyETh1P2UNJijBybqSOqFxibCzn6rc/C4uQrYRXVf3DwIaUva4bkVf7IPN4lj158v4A8YweSnqld3ghwuynukbUDPhkRX8TRual16hSwWew56jiNaHwI29MGJAMGe9JCTKhhSGIRCokgW9C1NvsK9koahpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339015; c=relaxed/simple;
	bh=9naYWS9DmuuzTQoJKgmUxl++eUtF4Jv2uz+NMWSac0o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=p/luhY3D4Px6QZhA6SvYPl3oKCFSTmN22G3bXIRqYug3ZpMEIGjV96w6h3cij4rFvxk1hj8kJFRsfEE3mBBPl327a9UljHEuGEPu3xRGDaqVSSBsDxm+92kvu8D/YIi+zWI+FaqZ1WfUfgUIl+km1KJ3YToqoKFCGDSa0nWJnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7QH+Xbw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7QH+Xbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741339012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orDHGV8SIyVMmUWDr1tKnib5V5l6gumVU2rqlRy0IjY=;
	b=A7QH+Xbwr4hbKJpqmdaniumyXRW6UAxmionR81amZcbX++yIsDrH/VCbePyL/VZyQ7/37z
	jBr8BDnbvUzlBYFDCjT3n4rERib6HyZWnW8oKMIY/9hdyTfDSbTI8c5gHIm/ajulOR4PAU
	/bdN8WDwKTKoeM7pRMywt9E7DfkfCUI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-E4nx8858P5aKiy2E8vIPQg-1; Fri,
 07 Mar 2025 04:16:50 -0500
X-MC-Unique: E4nx8858P5aKiy2E8vIPQg-1
X-Mimecast-MFC-AGG-ID: E4nx8858P5aKiy2E8vIPQg_1741339009
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8790E1956065;
	Fri,  7 Mar 2025 09:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3596418009AE;
	Fri,  7 Mar 2025 09:16:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2025021411-village-lash-4680@gregkh>
References: <2025021411-village-lash-4680@gregkh>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com, max.kellermann@ionos.com,
    Johannes Berg <johannes@sipsolutions.net>, netfs@lists.linux.dev,
    stable-commits@vger.kernel.org
Subject: Re: Patch "fs/netfs/read_pgpriv2: skip folio queues without `marks3`" has been added to the 6.13-stable tree
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <168197.1741339005.1@warthog.procyon.org.uk>
Date: Fri, 07 Mar 2025 09:16:45 +0000
Message-ID: <168198.1741339005@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

<gregkh@linuxfoundation.org> wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     fs/netfs/read_pgpriv2: skip folio queues without `marks3`
> 
> to the 6.13-stable tree which can be found at:

Can you add it to 6.12-stable also?

Thanks,
David


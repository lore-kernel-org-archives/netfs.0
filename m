Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339D477988
	for <netfs@lists.linux.dev>; Fri, 11 Sep 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132412; cv=none; b=KxrhV2U6uLTn28KD9pi+qUCeVBZxSDaJU6Mw7HPY74DP4RRqyxQ+5HcuWLR2kBTCP8XrRKU91eQnkwMhUK8DoKQKRBuaQCWoZy2/SKLQDlBxBiQFVatRfzxsk3Dj8ynjr73UBrI2T4mtrVZqbGZXTOfq5NW3CJP8HBP8QpX8MqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132412; c=relaxed/simple;
	bh=Tkr+JCbshi+MikFXz8lA+ivAi0uvu17bCSYP5N06Nl0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=VbICQA21hFSGq1isQXVH3uF6Jv8XgLVooKTVFX3KsxUPvoTjA6iw/YkXem5hrf6H8QUkgrU+vSMfuujs0UAqW1Mc9FnlXqLoKeaa2jRRrEPhF6JIh6TCjkMVRGScIrmUtB7l3e7JHoL7zUantvaLqnvPHV+GqZEv4l7Rnt4lqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T25uE3XS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T25uE3XS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789132410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjxTnG9+IOVo/iqAqVa63V6GPAWyKsYUAzyVdTc8b5Q=;
	b=T25uE3XSIOF9BhAj7I1wU5VQ1iIF1EYK/ezNJ7Tlu3baN7TdV1WMX+XMWq49lwJyqqrYgb
	FA9bLLVS9VAkMv66egXEq/kkM+P5yGLgmPDjmrOCLW519wq41yNtA8au6rCptELa1zvw/Q
	lwaHM06ueM/aO8Ge7RbmsQWLoVvyoVk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-bUcwOhp6PdSxf_wSkglX0w-1; Fri,
 11 Sep 2026 09:13:27 -0400
X-MC-Unique: bUcwOhp6PdSxf_wSkglX0w-1
X-Mimecast-MFC-AGG-ID: bUcwOhp6PdSxf_wSkglX0w_1789132405
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BF92180135F;
	Fri, 11 Sep 2026 13:13:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 819F941B;
	Fri, 11 Sep 2026 13:13:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3faab0c3-29be-44af-9569-1e12e8ed6a74@method-b.uk>
References: <3faab0c3-29be-44af-9569-1e12e8ed6a74@method-b.uk> <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk> <2226525.1789118704@warthog.procyon.org.uk>
To: Michael Mulqueen <mike@method-b.uk>
Cc: dhowells@redhat.com, ericvh@kernel.org, lucho@ionkov.net,
    asmadeus@codewreck.org, pc@manguebit.org, linux_oss@crudebyte.com,
    v9fs@lists.linux.dev, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL corruption of file data on cache modes with CACHE_WRITEBACK
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 14:13:19 +0100
Message-ID: <2319644.1789132399@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: E6U8NFSlEwdd5c_EnSQ4oZwXf5WtxueWbIbqPz8lCa8_1789132405
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2319643.1789132399.1@warthog.procyon.org.uk>

Michael Mulqueen <mike@method-b.uk> wrote:

> It appears that cachefiles isn't actually storing anything on 7.3.

Yeah.  There was a bug introduced into the iov iterator in the kernel.  The
fix is here:

https://lore.kernel.org/linux-block/1667275.1788941191@warthog.procyon.org.uk/

> > Does the attached work for you?
> 
> Yes, thanks, I get this on patched 7.2 and on patched 7.3-rc2:

Great, thanks!

David


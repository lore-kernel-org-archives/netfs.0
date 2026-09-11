Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B9411FA1
	for <netfs@lists.linux.dev>; Fri, 11 Sep 2026 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114272; cv=none; b=oe12CiMT6W/bLdHrSkz1CzWaOr1MBQkAA0+svteuxAngDfvTKrxTEAlW6CW+x5PPeY/6y+OCyp6A0Q7qvqhnlVo9X3KYnI4Xe2AU5ZyzXSxW+PC8EzC89cOkFrfXv2sfjKlxZAYkGR5D5IgRsATUm5S+tvUNg2A5TyJdTasoNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114272; c=relaxed/simple;
	bh=9EWyKxpvwDuyXTv1d+2e/EeTIXfhXvw4dndst9H/9BE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=Qd+onUg/2lwUwngZyIjFvta3nmcIRR0UCYSDbEeRsBbp9XrqnEmAfma0PAz+BA0ymb5hySZNDVRRIonQsDv8NMxY03TfhtahrMS79odQ9I2/bEeIM838PTbzLsyVAJUfWVjrFiyHrEuoV8eyuG2OR1Car9eeaBytcLi79COTiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cX+3Brqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cX+3Brqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789114270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KM7H7X1d32hwES9HmLQ+a3yj4IwaejBWYAwsQEvzy9Y=;
	b=cX+3BrqicfU/qzHopEyJDrNVkeNqmoB3/wLFb8S18ea+5RJqLFDjTa6NdJBpOeP7cBSB8x
	rhBwrNlWbJxDkB/CQ5Vjs+YPEek/oklG8G92IR0ydXqx6JEdDtLi6rx8rsOFbJGt/lg7TY
	765G2qO7D85D8XFTD5jY4xd9ytM5ixg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-tPEIzxiRNvWbEVqVnvybBw-1; Fri,
 11 Sep 2026 04:11:04 -0400
X-MC-Unique: tPEIzxiRNvWbEVqVnvybBw-1
X-Mimecast-MFC-AGG-ID: tPEIzxiRNvWbEVqVnvybBw_1789114262
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB9AF1956072;
	Fri, 11 Sep 2026 08:11:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 758071956088;
	Fri, 11 Sep 2026 08:10:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
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
Date: Fri, 11 Sep 2026 09:10:55 +0100
Message-ID: <2217384.1789114255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: tF_w1Qghp0gv1Wx8qQiod5CxLjoVXLnjxz65zySaCJo_1789114262
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2217383.1789114255.1@warthog.procyon.org.uk>

Michael Mulqueen <mike@method-b.uk> wrote:

>       cache=none       read   0/20  write   0/20  [cache=0x0]
>       cache=readahead  read   0/20  write   0/20  [cache=0x1]
>       cache=mmap       read  20/20  write  20/20  [cache=0x5]
>       cache=loose      read  20/20  write  20/20  [cache=0xf]
>       cache=fscache    read  20/20  write  20/20  [cache=0x8f]

I presume these should all be 0/20?  When I have a cachefiles cache active, I
see:

  cache=none       read   0/20  write   0/20  [cache=0x0]
  cache=readahead  read   0/20  write   0/20  [cache=0x1]
  cache=mmap       read  20/20  write  20/20  [cache=0x5]
  cache=loose      read  20/20  write  20/20  [cache=0xf]
  cache=fscache    read   0/20  write  20/20  [cache=0x8f]

so I suspect on the last one, the data is drawn from fscache, not from the
server.

David


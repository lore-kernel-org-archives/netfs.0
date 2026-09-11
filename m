Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8D43B3F7
	for <netfs@lists.linux.dev>; Fri, 11 Sep 2026 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111029; cv=none; b=ae4H2j2hDHHuCS1LnNcaDj/7aJ5g7QmWXATol/MMUTd1z1+7pfMwDHkvIvJW1mT0DlzzXBzkLB0HpxTZk6CKxZegZWSyFSNcPI8zRycoH7rincCzqaVodx9p3PvEjsSIHYaleF9leRPKmp9KlSObh6aXpeT+su1QHJTyNFwu9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111029; c=relaxed/simple;
	bh=6sM511Yghy0FHDLvevziRdPvpQEZD+8AKouYt7mgOik=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=uxudQ+rocMboSg0CKVlHdLiEOn33lbUoz0vTDGClg5pfkO4TLGQR9Wd137K1yduZ0ZEHNMgLM36Lt1OU7nklmCiBOiejmth8F10gO6aO6QAVSXJW1mWsDHKAgEr7NLfClQVX3F2ihVoEx9dr6Dt7dQwxMqYlhdIbwS9mebtdLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cn3leOXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cn3leOXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789111021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuQgHOd1pJjLYwSa9FuLfTu/u2Cf9iOR7RKv6iApg+w=;
	b=Cn3leOXi/l0VGMBcY3ACfLVkqSnYOdMF7lr2GVVVAcCVM4jdHSG4fBReMuF2wq9K+7SQ30
	iCdmu1gc/q3SoVLpfm9aVEI3OLDdEdkiM6diSSHTlHfGPNLIgUkgdPuoZKaAlE2IGB2gHu
	G7Crfox7EvpsCSCLDxVkqFfh1wanlSI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-7tEUIbcYPEuyro1qP9-SsA-1; Fri,
 11 Sep 2026 03:16:55 -0400
X-MC-Unique: 7tEUIbcYPEuyro1qP9-SsA-1
X-Mimecast-MFC-AGG-ID: 7tEUIbcYPEuyro1qP9-SsA_1789111013
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C92F218005B2;
	Fri, 11 Sep 2026 07:16:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 038F618004D4;
	Fri, 11 Sep 2026 07:16:47 +0000 (UTC)
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
Date: Fri, 11 Sep 2026 08:16:46 +0100
Message-ID: <2208516.1789111006@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Cysr1OSl2BVGYzsADsPpraaVzMDJyq1t3yP8wPl38Ic_1789111013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2208515.1789111006.1@warthog.procyon.org.uk>

Michael Mulqueen <mike@method-b.uk> wrote:

> A 9p mount returns NULs in place of file contents the server holds, and can
> write those NULs back over the server's copy. Nothing reports an error - the
> read succeeds and the file is the correct length. Affects CACHE_WRITEBACK 
> modes - mmap, loose and fscache - but not none or readahead.

Are you actually using this with a cache?  Or just enabling the "use a cache"
options?

David


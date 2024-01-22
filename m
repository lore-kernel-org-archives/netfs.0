Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D151017
	for <netfs@lists.linux.dev>; Mon, 22 Jan 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944162; cv=none; b=pL405IsZcYScFM709B4IZ1DKoJY32E8Q+tXyB/OUPZSacwO228ZzfBaduGOg02th2df9TkQTjTA7iR0xOHY8SjwYeP6VeTklL9u2TZbMoWsRvfyDpnSExjfbTadc3WiZwyuCRwd8LRrJaWYLy6PaA5awplkJxHOvNJYK6a2YEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944162; c=relaxed/simple;
	bh=BK4/OCHtn9ZOarkwg23KKNRxOtPDGGPmaFy8ysvVxZ8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=shupjE64HWXuRXSPED41dE8/+FQQ+d7ZZ6hyeZGy4lyRKT9D10xJd2/rAHFQtwYh6Mym6BPHjBqle3Vw7lueg9uHHC2CGh0Ry9CpWuo5mCFlpvpAG2vK6oZANr+nZ10pbTvrtnC20Cd7swcJi4M2iqnOExnu7yIcLYTuf+sbt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MorK0xNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MorK0xNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyL8HkrfuDx15VmmUYeIG1cK/wCgWeV9TZeHPttzNv8=;
	b=MorK0xNW+pps/DA6hgiAu17uaOf9uYBbtxftR4j2RLc2pSWAwDhxqSbELWoXro+6S0DGLa
	9X3xUdwJyEGvhsI419yytUWneyhNhR5HI9/nMZzp6xgQuZDYHiou7XeYvh8ly+M8iBu5A+
	8tgKrNT7PrrKU0zkkoD9N22yd15tK68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-HhQdjMHnNSCeJf9HAxnqqg-1; Mon, 22 Jan 2024 12:22:35 -0500
X-MC-Unique: HhQdjMHnNSCeJf9HAxnqqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A236285A597;
	Mon, 22 Jan 2024 17:22:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2C10C0FDCA;
	Mon, 22 Jan 2024 17:22:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>
References: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org> <20240122123845.3822570-1-dhowells@redhat.com> <20240122123845.3822570-2-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH 01/10] netfs: Don't use certain internal folio_*() functions
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3931925.1705944151.1@warthog.procyon.org.uk>
Date: Mon, 22 Jan 2024 17:22:32 +0000
Message-ID: <3931926.1705944152@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Jeff Layton <jlayton@kernel.org> wrote:

> > Filesystems should not be using folio->index not folio_index(folio) and
> 
> I think you mean "should be" here.

Ach.  I forgot to update the patch descriptions!

David


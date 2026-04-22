Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA336E476
	for <netfs@lists.linux.dev>; Wed, 22 Apr 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886065; cv=none; b=c17KiTKUYfB8jXesPiLa8DLLhaREu2Ghoxi4taw9Y56xORs2iDt/ZszmFaeEfgnoIFeZZtotnNlmnL2gP5T48c07txkdQmST0U5tXVh9ZLjPCYHqGM7IXcakukrWlAjqR5ammP/JBIxzCQ/cAeiPiWi4tNmm1tS7y080LX0JC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886065; c=relaxed/simple;
	bh=sCpZz8DKIb0a9ITD6VgOZkl1kX9/2pWXQzr5DsIMBmY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=fpW8y4rBFPB/lQ8TzWxhgO0OaGD0681zhKvOZ73fN0egh4XAVqTSy52JGHoG6v9/CeZRy3bfi+vomEGnYjYygaCHWob9uF6Oat0v6RJMqmru0WjTbpOmMbwGbz4FJ1LbfCKSk0f05TvgyP/L76cuON359KXMwO3P0Va0LQJ9k4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvLo04Ms; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvLo04Ms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776886061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBYaYouzssWXc9cpxxQoa8nnjZlmB9RxHMQkjbxQu1w=;
	b=IvLo04MsCxHfjO7sHNQu/5z2kg7ihAaI3ybN2rrb0PABeRtD9D9s9HZzJOihUtqHEi2lvb
	locqrFQes+QqX7IcpXbka3Mswp2W/LLjno6yzqv9PJDCAOeX6OhkW2TWyZ700oyonhNhNG
	6QwdyRkg2zeocFtAMv4or/JJcNA6TyQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-AGOcM57JP8WeybhnWfvI1A-1; Wed,
 22 Apr 2026 15:27:36 -0400
X-MC-Unique: AGOcM57JP8WeybhnWfvI1A-1
X-Mimecast-MFC-AGG-ID: AGOcM57JP8WeybhnWfvI1A_1776886055
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AC7818002CA;
	Wed, 22 Apr 2026 19:27:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E15219560AB;
	Wed, 22 Apr 2026 19:27:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <74ebe2eb03ce3b1ae3038badffc8397d82d3eff2.camel@redhat.com>
References: <74ebe2eb03ce3b1ae3038badffc8397d82d3eff2.camel@redhat.com> <20260401053109.1861724-1-max.kellermann@ionos.com>
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org,
    pc@manguebit.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: support RWF_DONTCACHE
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 20:27:30 +0100
Message-ID: <2639614.1776886050@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: PVzv_0_L9u9DxOjvo-Kf27KcS-8JP9DteGaA7FWpNOc_1776886055
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2639613.1776886050.1@warthog.procyon.org.uk>

Viacheslav Dubeyko <vdubeyko@redhat.com> wrote:

> The netfs_write_begin() is deprecated function. Maybe, it's time to switch
> CephFS on netfs_perform_write() finally?

I've got that on my to-do list for the next couple of weeks, wrapped around
LSF/MM.  The MM people would really like to get rid of some of the old things
ceph uses, such as PG_private_2.

David


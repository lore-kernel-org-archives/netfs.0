Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A51C1740
	for <netfs@lists.linux.dev>; Thu, 10 Oct 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556516; cv=none; b=ISRqFcc/xGAi+FKSpAJFwQdQSmANR6FUDGF2W3HqiGAILl4bocoFqADiPitoonzmI227ZgmRiWMMv8J39YwAyTNDjt6JEQjcJm4saQA9n6ZD+Jeg3uYsOVaCTGz7+fxMKZAdqbJsVYaqCaYMAoEJa3W/UDKAZo9JD1HPPMd6KZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556516; c=relaxed/simple;
	bh=Dq0XgAclNRaJbXT+vHvoLMbbmE+OqMekcNjkPra9cUI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Wa9kWF4Hw96n/umrM2grXDR3aPpktA1eHwKzIBywzx6qqZuhVCed5N15K3RbeitTyXG8Z9vwjyNW8t9i6TFrTMVSdu4bIzHEjUoUJNWAZCZhX6iFe/2tXEtUQLW9DGDWHqmHNOUucqy+fPvy/1Nf5kkxqDK89I+8S1Hty47ouvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPYtyKd1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPYtyKd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728556514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx+kPV8292G/Dzt3BTlua2EqMJ9Klq9hxRZJVfmtfTU=;
	b=UPYtyKd187OG8+u7cF6gtHxglLBUNnNyLBFFsrwJmW6/eDbc+Z4YxnOjrMMoM65+AcH6CC
	Kj6wVUNXvBGk8oJ8TauDdwHVjlp+TKlhbeIvTmRniShWdZtvxl2yjfE3WsVFJiBGk046oD
	sZyIW8rPCx8ebEGnMrAzZ1uv2Yb8iZI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-dLh36eegOY2DWn475u0HWA-1; Thu,
 10 Oct 2024 06:35:08 -0400
X-MC-Unique: dLh36eegOY2DWn475u0HWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 518751955F3E;
	Thu, 10 Oct 2024 10:35:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08CA11956089;
	Thu, 10 Oct 2024 10:35:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-2-wozizhi@huawei.com>
References: <20240821024301.1058918-2-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in __cachefiles_prepare_write()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <302545.1728556499.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 11:34:59 +0100
Message-ID: <302546.1728556499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the __cachefiles_prepare_write function, DIO aligns blocks using
> PAGE_SIZE as the unit. And currently cachefiles_add_cache() binds
> cache->bsize with the requirement that it must not exceed PAGE_SIZE.
> However, if cache->bsize is smaller than PAGE_SIZE, the calculated block
> count will be incorrect in __cachefiles_prepare_write().
> 
> Set the block size to cache->bsize to resolve this issue.

Have you tested this with 9p, afs, cifs, ceph and/or nfs?  This may cause an
issue there as it assumed that the cache file will be padded out to
PAGE_SIZE (see cachefiles_adjust_size()).

David


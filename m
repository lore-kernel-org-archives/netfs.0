Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE761C32F3
	for <netfs@lists.linux.dev>; Thu, 10 Oct 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559470; cv=none; b=eY1sBssV6/sdToBjR1Rpn9m9jyewM6hnDZOugaVwS+jc5ZEL9npuD5rGEMZGqUK/RN46poG/vOGCGbl5W7gg/LFpRrw3lKVhai+lzd0hWS8+mf+Pc0xlYr9zyaOQGiibjOUquuhH5chkTBF7t24upJ6Urtrg3W6w27SgQmAty0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559470; c=relaxed/simple;
	bh=91MakKXXdZ/X8v1/goDuWFlMTUMGbgqBgnskPiSeMP0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TLlQNyDpOSHYjM1D5gx6WJ4aPfQA9kmnKqGe6o2gd2WO4pXNcqzCCRBVNRosPAQlYy6ZYD8NKTxlMi27Qon4kwif8cciuIBhTm/wcWBT55YgjhFnVrPsdQDVReJ2BXqzTgqgY4zeFwfhaYAoyJcDDaJDKz5CXk5HnTgLqynTz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGAYCfSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGAYCfSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91MakKXXdZ/X8v1/goDuWFlMTUMGbgqBgnskPiSeMP0=;
	b=CGAYCfSzSnTFaGcaZZzUa2nV4fBVvIaN9+ue1YJ7e9VljXHMui2RKRk7QNRuyWGjPkauM7
	eybh6U9nk48J4U61Xd7qISeLpY5Dg01kWepVuFLrUe8nDObVodLrpsLSKHQ0ef8QPA2DwK
	x96NmyLOP2K8FVFkqsZ2U17foyXUUdg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-ppm18wj7PQSs_wzc0tN0EA-1; Thu,
 10 Oct 2024 07:24:24 -0400
X-MC-Unique: ppm18wj7PQSs_wzc0tN0EA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B128B195608C;
	Thu, 10 Oct 2024 11:24:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A21B819560AE;
	Thu, 10 Oct 2024 11:24:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-9-wozizhi@huawei.com>
References: <20240821024301.1058918-9-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 8/8] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303925.1728559457.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 12:24:17 +0100
Message-ID: <303926.1728559457@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Zizhi Wo <wozizhi@huawei.com> wrote:

> In fscache_create_volume(), there is a missing memory barrier between th=
e
> bit-clearing operation and the wake-up operation. This may cause a
> situation where, after a wake-up, the bit-clearing operation hasn't been
> detected yet, leading to an indefinite wait. The triggering process is a=
s
> follows:
> ...
> By combining the clear and wake operations into clear_and_wake_up_bit() =
to
> fix this issue.
> =

> Fixes: bfa22da3ed65 ("fscache: Provide and use cache methods to lookup/c=
reate/free a volume")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>


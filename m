Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECEB1FAC48
	for <netfs@lists.linux.dev>; Wed,  9 Jul 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077054; cv=none; b=sBupLDSgvPtC6q+R8nL5Nt2R5lHgCg2CQc1g8AFw8hIpcE161DIorGBHQLV+xP/a2QkoeDKv6962Uie7id8x1fMUyQup4KS1Uym0A9m1VKF4LwoVM7xszBqRwy1LHzI/vZc17oTXS1fRIRb1C/G0U0rHCleMkNTxjOEo77vyuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077054; c=relaxed/simple;
	bh=i3ZcrxUeGN+REuzZS1FQahN/BXcB/ZZRuCI1JLJJIJQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=svClITDP08fLK+sVr+U2+trg+liWS8SZrt1TF11s3tjhqEdm8Zb9ya+itaYhVKCSNAu3vL1bneI3y9Tq47PLA+ru2U51IJMq8yuM1gyRscJrMLWrsZ7Mj1TfcIvaMvzvFFNdyF1A+gJ1Fs4KaL35xl54Zo79r9dfqlB6YedMSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM5kmjrU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM5kmjrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752077052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3ZcrxUeGN+REuzZS1FQahN/BXcB/ZZRuCI1JLJJIJQ=;
	b=LM5kmjrUAW0Zu5sHqiAEOCixm3xeREoVWRDmPwLxL8/0D6S+lKx7IwKR9uyZSu9Q1LClVa
	Li2EAnCCJAouJuM46emjTlZ95/UnUa/5ZBbkCW7ZwTHaYjWfNkYNSnsB4nZrpofotpSdzH
	BxMzn84GWYCUKC6+je4/Wu3un1rQTN0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-HYXudR29PqKtraIOeLv7Wg-1; Wed,
 09 Jul 2025 12:04:06 -0400
X-MC-Unique: HYXudR29PqKtraIOeLv7Wg-1
X-Mimecast-MFC-AGG-ID: HYXudR29PqKtraIOeLv7Wg_1752077044
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16261955EC3;
	Wed,  9 Jul 2025 16:04:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 327E719560AB;
	Wed,  9 Jul 2025 16:03:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
References: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    brauner@kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, wozizhi@huawei.com,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH] cachefiles: Fix the incorrect return value in __cachefiles_write()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2731906.1752077037.1@warthog.procyon.org.uk>
Date: Wed, 09 Jul 2025 17:03:57 +0100
Message-ID: <2731907.1752077037@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I think this should only affect erofs, right?

David


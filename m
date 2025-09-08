Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8782EDD41
	for <netfs@lists.linux.dev>; Mon,  8 Sep 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325480; cv=none; b=XnwTg0w7JziYWv+/c4gvd/0HotZubvacHlP5cGCRujM0gzQEMGCMKL7PX25F6Weba6eLifvSymNWDW7ovgR0Y1X174NY49q6YIpmZjUPbY+mVUM6/yZ3hSCEDaXu2RrpwCqJCh42PZkofuCJ2utFS3xQ5P2ybK7pPLyQLWSrFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325480; c=relaxed/simple;
	bh=pNeha5NzhVmf2b7hPxmjuibxVc7jmXiZdeJsKpjfY/8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Tqyd92uGTzN1S3nhR/OMgFj4erZ/jfb3C3HdL/g1LEAZyS/xMc0j6+sbOetOzvbC8gn4IR8aoT3MBX0O1lME/gXeM6MP1SeJL+8oeFr6cmEJ6CeEW0YXYTbkRuVvIZbKxyZ7xNB5Zahz0tBRL3iyylBvn3mvXMEEFPIkHAxLgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edBffA0i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edBffA0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757325478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ytBuzOgrWlKNqcg4AWjhpdU4p9P4PKRd8bMQZz8RMg=;
	b=edBffA0iEUalI9HQAgqlHqlOCZB7mmPid5PfCrwf18pyqLNL3p2o/BjY4cWsNjva2zrT9R
	zJlAzqq7jYU8Hz0ofZRlpisBt0fJ7E/OeR95pYzvdAfKbL4j+FBPZA3+uX+BRI02H3nolw
	K0yLqeqIZoQnvBK6VUIWAAle/2bSN2Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-uHBJfTOiPm-t6lrBUIRvRw-1; Mon,
 08 Sep 2025 05:57:51 -0400
X-MC-Unique: uHBJfTOiPm-t6lrBUIRvRw-1
X-Mimecast-MFC-AGG-ID: uHBJfTOiPm-t6lrBUIRvRw_1757325469
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D9DE19560B6;
	Mon,  8 Sep 2025 09:57:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 036621800576;
	Mon,  8 Sep 2025 09:57:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250905015925.2269482-1-lizhi.xu@windriver.com>
References: <20250905015925.2269482-1-lizhi.xu@windriver.com> <68b9d0eb.050a0220.192772.000c.GAE@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Lizhi Xu <lizhi.xu@windriver.com>,
    syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, pc@manguebit.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] netfs: Prevent duplicate unlocking
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1476482.1757325464.1@warthog.procyon.org.uk>
Date: Mon, 08 Sep 2025 10:57:44 +0100
Message-ID: <1476483.1757325464@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Christian,

Can you pick this up and add:

	Acked-by: David Howells <dhowells@redhat.com>

Thanks,
David


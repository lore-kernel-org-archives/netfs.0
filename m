Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960940099F
	for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155772; cv=none; b=bnlHv/EHplXc6OCIydvfg8fJgCAb/k8PvwJ6SyU0wsWOgLqkKdWWwAptWEcZHUNUh7RQe7SdjRjJC7volJKKOvfVdD7mIjOf9TvslVCRcW/7JDKOaaoBF+0HV4ttwA7mpXvVPceqNoUTaz6UIypQKxhktcewKggMFHoC9etBcF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155772; c=relaxed/simple;
	bh=5IUqds/atRexeD+BX1Qj/nRZNoPbdWCeebTVUtm30Vs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=P6CG/dWDpOtsinGkr5RaPeHaPf/hR3zjOG9Sw+2YE1X6tgNja+SP2YyFraGhvkoSKZa+HrG14JMt26BU2aAk85vjTWOdUHAJ3w31GHUCDyjdgule7ORJPl7BJLvVzttM6J/9of8wuCWALfmqDGVCftGHQp1Kdy1Rj3/vLlB7RYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hk8AvdG4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk8AvdG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785155769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IUqds/atRexeD+BX1Qj/nRZNoPbdWCeebTVUtm30Vs=;
	b=Hk8AvdG4fvzhgeFUwPXI7wdU55vTrweQwtK0YuMQXN+xrKg4lhpZZT+gIQ0VJ/ClNY/DGf
	0odrV8NZUpJK6YxiPy7fHQaiQ3dm2JIgjq4lTYXV38ES5JEl+zsxu5HVUhkWh9OAmq1DGk
	bK9RxeB713QJTt3WH9qchhtHSosGEGo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-UXdWTtrlPGSL4LQ43z91aw-1; Mon,
 27 Jul 2026 08:36:04 -0400
X-MC-Unique: UXdWTtrlPGSL4LQ43z91aw-1
X-Mimecast-MFC-AGG-ID: UXdWTtrlPGSL4LQ43z91aw_1785155763
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEDE019540EF;
	Mon, 27 Jul 2026 12:36:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BFD61800480;
	Mon, 27 Jul 2026 12:35:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
References: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
To: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.org, Yun Zhou <yun.zhou@windriver.com>,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 13:35:57 +0100
Message-ID: <1098525.1785155757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: eij8RK6VK4h34BGPrZFai7r7JyX1tNIDX54edJUYIBo_1785155763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1098524.1785155757.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.=
git netfs-fixes


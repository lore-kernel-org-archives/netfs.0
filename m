Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D7248891
	for <netfs@lists.linux.dev>; Fri, 16 May 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422222; cv=none; b=d7n6wuOQHSc4HAJNWE0vhg/t2qsOi0qk2XICU8JhB6y9GTrPAQEFKjh/Ofr3DAJoRgZsP7gqBGuSswIdzcC/DQ4Qn54l7fVY0EPdNrBbJm6wW5Z34fRgVQWQ5FwNZwOMO9dOiCAvceDFDVYMtR6OkTKty5fagiJuE3rXtbV+3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422222; c=relaxed/simple;
	bh=Wk2d0x6Jja6BDe8vPt2pVFQXgWfevTDH54jv3B5FPHE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JVlQU/Z3Bg6uIiUHQJUg9E7ZX/5NcZY7noa7et22Q80CQSfOczz30P5pkzk/5k95Bziusepq2XMZ2pgl+hicELtlWIrg7wRh/TT3qdpKTyyLTR6Rz+sAUfePACkc8XdTsG3kmTs8SAZPS5c8LomkZDX/lWTZEYUkabfKFDoUa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTRyQZ+S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTRyQZ+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747422219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wk2d0x6Jja6BDe8vPt2pVFQXgWfevTDH54jv3B5FPHE=;
	b=PTRyQZ+SG4SKj4nVPUw4iruBYpk7MLVh1/5dXKQjOIme6a84lI4yW+Gk2RxcAmLuu92LMM
	4gxgayho/t3GxQYRGThLRkAnOuciMG2wwHQqIDMa/6RanpS5wN1ixCeD81stks4IGN90MV
	xe9A43UMgmfurA9XWay7VyGzVEgBJfA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-dWn05TtXNf2h9Ic8zkZYmQ-1; Fri,
 16 May 2025 15:03:35 -0400
X-MC-Unique: dWn05TtXNf2h9Ic8zkZYmQ-1
X-Mimecast-MFC-AGG-ID: dWn05TtXNf2h9Ic8zkZYmQ_1747422210
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8E48195608D;
	Fri, 16 May 2025 19:03:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88732195608D;
	Fri, 16 May 2025 19:03:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6824951b.a00a0220.104b28.000d.GAE@google.com>
References: <6824951b.a00a0220.104b28.000d.GAE@google.com>
To: syzbot <syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in iov_iter_revert
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2652585.1747422206.1@warthog.procyon.org.uk>
Date: Fri, 16 May 2025 20:03:26 +0100
Message-ID: <2652586.1747422206@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Note that the mount() syscall in the test program doesn't seem to work if
SELinux is enabled.

David


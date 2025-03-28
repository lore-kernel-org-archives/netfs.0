Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7131DFE36
	for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185708; cv=none; b=SAOpbaxBTWHOI0YFmGT1gDa8OrnGSqJ43M8sr2q6GboLy+tNCXJWpxCLM9KDqL45CHygKtJNAWY8/bZ+RWyfLft2aFUlssEtoilIXRZ3wf5qhm+hHTyR2OTxg+FC6WA6ZURIvZvs8suI4YjnOcrQKA9fe2UE8Rymv7mqoBSvWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185708; c=relaxed/simple;
	bh=S/CMxBiATfwIX8u78Ausp4MJO1mSJU8pkpiZjklIqC0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fYnhvajlYlHyKK33bd2IrV9lBZ4FNQIYeXVq6/DZWYz2JADdJge1qBaGlrCdxJk9wniFmpAIx47m9y+AY26WubZG3DmT3IN6iYe8/Uoxf4Cm/dRmycUrB3hxXKdVpSwfFYhjcWkjAQP6ODX0dSyqF7lrmde+Znx7iuQZbXk4NPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZigfkHjH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZigfkHjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743185705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oGU2c/jU+jROERJKnJ12bX6t4qhq3RiVRF861YZDSA=;
	b=ZigfkHjHcFdu5H/kttEj+Ov03/CBQLUfLJG7HwqCWE3m4aaHiAmNaX7C+J4tbTbNU0V8Wv
	DA7AuHtB8PEksPAwgAUtG8OOTpIT/890+U16KNy8pM08n+2YE7BPizktcTrGO9oDE9Jqeh
	u0MVBYJeAha7W1IRhX6IM3r0ohKUUQQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-EeBGk180Nuy2ybQ2ywBfvg-1; Fri,
 28 Mar 2025 14:15:01 -0400
X-MC-Unique: EeBGk180Nuy2ybQ2ywBfvg-1
X-Mimecast-MFC-AGG-ID: EeBGk180Nuy2ybQ2ywBfvg_1743185700
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB79719373DB;
	Fri, 28 Mar 2025 18:14:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B54B19560AB;
	Fri, 28 Mar 2025 18:14:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250323184848.GB14883@redhat.com>
References: <20250323184848.GB14883@redhat.com> <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, Oleg Nesterov <oleg@redhat.com>,
    brauner@kernel.org, jack@suse.cz, jlayton@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com,
    viro@zeniv.linux.org.uk, K Prateek Nayak <kprateek.nayak@amd.com>,
    "Sapkal,
 Swapnil" <swapnil.sapkal@amd.com>,
    Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <86990.1743185694.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Mar 2025 18:14:54 +0000
Message-ID: <86991.1743185694@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git netfs-fixes

  There's inconsistency with some wakeups between using rreq->waitq (a pri=
vate
  waitqueue) and using clear_and_wake_up_bit() (a shared global waitqueue)=
.
  The reason I didn't get round to posting the patches on this branch yet =
is
  that they *ought* to fix the problem, but Steve French still sees an
  occasional hang with cifs - but only in his automated testing thing, and=
 we
  haven't tracked it down yet.

  David


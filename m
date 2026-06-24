Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078C39184B
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286612; cv=none; b=Wzk8nXFFYrnc3XZiqYT1pl6hQOvMAiDpjQtb1Yq2f1o/Dgc6jCZWNUk+tqkDVe8XeTRyMUm9Qq9pw0wOcq3uSMTr3CWxdhhCgv75Y1exI8sFIKFoJfBO5f5pz2WbHD/ekYexUDDZxI3eZBbbQa/ImRM+DT9wZuCxkVTxQBuC1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286612; c=relaxed/simple;
	bh=7egr5alyJJ52tRox2vuf+XUOA5rUyZXYakR9coH87T0=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:From:Date:
	 Message-ID:Content-Type; b=XcRhZ2ihVT8PyyqyA9rrdEnT3HvCPEynkwYKYJCjnCn7YJtNaREelBprG95IxPQPKJEB9WClLXoN8OfgKJ/6gJuR8VSEQtGPTCPQQ34+bK9F1qZfKxGFAgIvmAyG81OpjcA3srv8qhU0nKFzO5WbX5DELc1Vxg7zNAvlGqikmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg6Gkh8I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg6Gkh8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782286608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw0tzm4ODwPeGn7+DKX2w3Xuv2p0WyccWbyosHh4Zm0=;
	b=Sg6Gkh8Ivt25UbFClRxKLdjfq2iNQWu3cYReuOzS7jjWOnnuxFeXZsGyOVcdHfBxCIjbR7
	KNlB1TufG0LViii7xUKA6NYWPRpWJrGEoTNkpoNbvpoLEKc+O5TuY4qPpkOqmmxy7TW+oL
	Vh/j3GxhnsyhkVgiFyvfCB48MFpba0o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-7Mtza7J_M7qMK-Ndaan5tg-1; Wed,
 24 Jun 2026 03:36:45 -0400
X-MC-Unique: 7Mtza7J_M7qMK-Ndaan5tg-1
X-Mimecast-MFC-AGG-ID: 7Mtza7J_M7qMK-Ndaan5tg_1782286603
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31FA31956052;
	Wed, 24 Jun 2026 07:36:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.49.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 832551800591;
	Wed, 24 Jun 2026 07:36:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <498534d3-e82e-40ce-bc7d-230580b2fcae@chenxiaosong.com>
References: <498534d3-e82e-40ce-bc7d-230580b2fcae@chenxiaosong.com> <33cc8eb4-8831-49b0-80d6-b06544a37920@chenxiaosong.com> <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com> <2912807.1782231053@warthog.procyon.org.uk>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: dhowells@redhat.com, hongao <hongao@uniontech.com>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com,
    Steve French <smfrench@gmail.com>,
    Namjae Jeon <linkinjeon@kernel.org>,
    "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed preparation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: David Howells <dhowells@redhat.com>
Date: Wed, 24 Jun 2026 08:36:38 +0100
Message-ID: <2939650.1782286598@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 5TsEfP3Rww43ICTqml9ewCvH3jh4WHU1h1z_mOD6LZY_1782286603
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2939568.1782286565.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

This excerpt would seem to show how the problem comes about:

  a.out-717 : netfs_sreq: R=3D00000001[13] UPLD PREP  f=3D000 s=3D240000 0/=
0 s=3D192 e=3D0
  a.out-717 : netfs_sreq: R=3D00000001[13] UPLD SUBMT f=3D100 s=3D240000 0/=
20000 s=3D192 e=3D0
  a.out-717 : netfs_sreq: R=3D00000001[13] UPLD TERM  f=3D310 s=3D240000 1f=
ac0/20000 s=3D160 e=3D0
  a.out-717 : netfs_rreq: R=3D00000001 UW WAKE-Q  f=3D1801
  a.out-717 : netfs_rreq: R=3D00000001 UW DONE-QUIESCE f=3D1801
  a.out-717 : netfs_sreq: R=3D00000001[13] UPLD RETRY f=3D210 s=3D240000 1f=
ac0/20000 s=3D160 e=3D-11
  a.out-717 : netfs_sreq: R=3D00000001[13] UPLD SUBMT f=3D100 s=3D240000 0/=
dbfac0 s=3D192 e=3D0
  a.out-717 : netfs_failure: R=3D00000001[13] UPLD f=3D500 s=3D240000 0/dbf=
ac0 write e=3D-5

It looks like there are two issues: firstly, why does the upload stop short=
?
Presumably that's forced by the test.  Secondly, I think it has miscalculat=
ed
the subreq size in the retry, hence the EIO.

David


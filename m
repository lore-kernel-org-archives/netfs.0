Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CC30D3EC
	for <netfs@lists.linux.dev>; Tue, 23 Jun 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231065; cv=none; b=BrihwCDC8T3mmNnmIlOok0/eBtl1aEbgvv23kNUdYWubYUClMFIxrXWH6CWlfCJ8q7aYxtX24GuofD8zWOmcsyv3TK6gT2v7uIRD7mTCeO9iFSaNa3ykNu83BB0wPQfBSpNFwbKPfZeDJgNFDtOLONSydSCwU/T1C3K501aJqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231065; c=relaxed/simple;
	bh=pritGVRZRMb+ElmOrsmum2PIMY4gU+4D/h7Hti1MNK4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=ihCPZuZtT+LR5Jad9S4iJ62HbC4DyRI7wu6fjkig9vr00Vh6v5JGSFKKEvwiaVS4DFmCGMu0KV9A7Hq/EhwxuYoDEsaOd/qOFcMQaCI1NIxU0JjEvWeaWPwUJcQTDvR5HP8ELhd9HbxZUsJYG+BTt4tzlYtgfNUjObCdOxNn47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdCmvv5E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdCmvv5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782231063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wgFx7V3JoLxPvYoJJ8JtntgngDc9RlW7Led92hwOrMM=;
	b=KdCmvv5ECX9HjlBNm0O7DbfIw42r0VHjk5ABD+naVri3l4qclWKuNV6ipg9GePhBXcn/B2
	0rN/dufnMMr9Z+RLJ0+ltvEmr/fy6PDsVJSaTxgBqFhdBmfrElf5k+Tesyl7uQGDmbA9mW
	8OdVzkSfWAto5MjKq+8IrAK5xxliHdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-N0dzrl9TOX2ubrDNJNNAEw-1; Tue,
 23 Jun 2026 12:11:00 -0400
X-MC-Unique: N0dzrl9TOX2ubrDNJNNAEw-1
X-Mimecast-MFC-AGG-ID: N0dzrl9TOX2ubrDNJNNAEw_1782231058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC6B41802665;
	Tue, 23 Jun 2026 16:10:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.242])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4E80180074B;
	Tue, 23 Jun 2026 16:10:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <33cc8eb4-8831-49b0-80d6-b06544a37920@chenxiaosong.com>
References: <33cc8eb4-8831-49b0-80d6-b06544a37920@chenxiaosong.com> <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: dhowells@redhat.com, hongao <hongao@uniontech.com>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed preparation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 17:10:53 +0100
Message-ID: <2912807.1782231053@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Yyz4F-4eLgWYGCSTDA5zoYNoiu8-aINNdUMBI7Zos2Q_1782231058
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2912806.1782231053.1@warthog.procyon.org.uk>

ChenXiaoSong <chenxiaosong@chenxiaosong.com> wrote:

> After applying this patch, I can still reproduce the use-after-free issue.

Can you get some tracing?  I have a suspicion it's a refcount bug.

The following tracepoints would be useful:

echo 1 > /sys/kernel/tracing/events/netfs/netfs_read/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_write/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_rreq/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_sreq/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_failure/enable
echo 1 > /sys/kernel/tracing/events/error_report/enable

And if you can capture this, can you compress the resulting trace and send it
to me?

Thanks,
David


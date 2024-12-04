Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BC1F6688
	for <netfs@lists.linux.dev>; Wed,  4 Dec 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320798; cv=none; b=jAZ/tFr1NAwzGARgnbNsxTaFS9wH6F1xwq2FTmXEPsEaNR2N1tkySmNaNJW0NTEEGHGhjpT6KH71q/sOHLkvob65rKoqEyPYepBzgDWy4gBsOupEMxUw8D/J2M+LaSfAXivS7VP5bgGI9tUcyZpWQJxnYdQIGMythRxF6ZabVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320798; c=relaxed/simple;
	bh=hCJGieBayjbqDQYDLIl3qGOXeKRe3qI2Xnda6A1WRx8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ml2pa5u87zWf7PBt8vP4KaMgG116leCx8lP396oljiRMGkLoIue6RNJXmi6zccKbEAXR9tUlhYLNbZjWUyiWRRQTVU/4Jv11Duv8NKA2LJOd9MUaAFZ3dw5DQVRPVQw3Nd+Z0smfrdDF3cDKHBXnIJyk3BStEluyAnkAcUlYJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpMKms9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpMKms9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733320795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXHqEqRS9/LFSrZEeoqJpw87pZ+M4Wa3wae0kObRmFc=;
	b=VpMKms9Jx0zH+7UmyRhvAHYseyPaPquxyNlsQS2W7n6dXgvk20dbGmG4yYI2qRQIunOe5P
	y9g6JmM0wp4K405a5vEkFU4mpqK/1RoANbYdF1idhDbiXn5XaoLuO7y+Z9pqdbJ9UTDfXP
	2ZPFZRKS8TGp7B2+vaZ6UnX/HS9Zmxc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-mfOpH00zMriqbxtjTeNZPw-1; Wed,
 04 Dec 2024 08:59:52 -0500
X-MC-Unique: mfOpH00zMriqbxtjTeNZPw-1
X-Mimecast-MFC-AGG-ID: mfOpH00zMriqbxtjTeNZPw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB666195608B;
	Wed,  4 Dec 2024 13:59:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E67A3000197;
	Wed,  4 Dec 2024 13:59:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67238110.050a0220.35b515.015e.GAE@google.com>
References: <67238110.050a0220.35b515.015e.GAE@google.com>
To: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1128091.1733320787.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Dec 2024 13:59:47 +0000
Message-ID: <1128092.1733320787@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t v6.13-rc1

netfs: Fix enomem handling in buffered reads

If netfs_read_to_pagecache() gets an error from either ->prepare_read() or
from netfs_prepare_read_iterator(), it needs to decrement ->nr_outstanding=
,
cancel the subrequest and break out of the issuing loop.  Currently, it
only does this for two of the cases, but there are two more that aren't
handled.

Fix this by moving the handling to a common place and jumping to it from
all four places.  This is in preference to inserting a wrapper around
netfs_prepare_read_iterator() as proposed by Dmitry Antipov[1].

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D404b4b745080b6210c6c
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dmitry Antipov <dmantipov@yandex.ru>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20241202093943.227786-1-dmantipov@yandex.r=
u/ [1]
---
 fs/netfs/buffered_read.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ac34550c403..e5c7dd5a4c90 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -275,22 +275,14 @@ static void netfs_read_to_pagecache(struct netfs_io_=
request *rreq)
 			netfs_stat(&netfs_n_rh_download);
 			if (rreq->netfs_ops->prepare_read) {
 				ret =3D rreq->netfs_ops->prepare_read(subreq);
-				if (ret < 0) {
-					atomic_dec(&rreq->nr_outstanding);
-					netfs_put_subrequest(subreq, false,
-							     netfs_sreq_trace_put_cancel);
-					break;
-				}
+				if (ret < 0)
+					goto prep_failed;
 				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 			}
 =

 			slice =3D netfs_prepare_read_iterator(subreq);
-			if (slice < 0) {
-				atomic_dec(&rreq->nr_outstanding);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
-				ret =3D slice;
-				break;
-			}
+			if (slice < 0)
+				goto prep_failed;
 =

 			rreq->netfs_ops->issue_read(subreq);
 			goto done;
@@ -302,6 +294,8 @@ static void netfs_read_to_pagecache(struct netfs_io_re=
quest *rreq)
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
 			slice =3D netfs_prepare_read_iterator(subreq);
+			if (slice < 0)
+				goto prep_failed;
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
@@ -310,6 +304,8 @@ static void netfs_read_to_pagecache(struct netfs_io_re=
quest *rreq)
 		if (source =3D=3D NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			slice =3D netfs_prepare_read_iterator(subreq);
+			if (slice < 0)
+				goto prep_failed;
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}
@@ -318,6 +314,13 @@ static void netfs_read_to_pagecache(struct netfs_io_r=
equest *rreq)
 		WARN_ON_ONCE(1);
 		break;
 =

+	prep_failed:
+		ret =3D slice;
+		subreq->error =3D ret;
+		atomic_dec(&rreq->nr_outstanding);
+		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+		break;
+
 	done:
 		size -=3D slice;
 		start +=3D slice;


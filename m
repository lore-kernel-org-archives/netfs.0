Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9854734E4
	for <netfs@lists.linux.dev>; Thu, 27 Aug 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838208; cv=none; b=VxT1SIibIt2OvLYbBXIdqvVph3Po7Jmmel+5nWt8fjPbJ5Do2DNzvgXOKn7mw6ocOlMn0nrWhW3mN4Da7rh3CVyO3bpNDvbLKFsGwhNHuM5b1zjhGb6R89MAM8m4woe6+4XFffsodbxB1rS+yac115XJf4JNCxJ10g+/1HoxnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838208; c=relaxed/simple;
	bh=txJCVMXbXZvWlCXPrv6gBGpM1BgXhBKNdFGr0ZEG6w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WGyAOMmdXa4evOjyk+R6J9LYWIsD07VnGobbtWLD9HWSfLSujaWIi630FeB9d0X/vZBU5u1c4wHzjALmapQcg4KFynwLE73IlCNRp3utaGSW3Z2c1nwTn6M1SU85jlKPF/jVlm261Qg2Bmc4ID96qPr3dtFhjPaQ02oOD1RF4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP60ejMc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP60ejMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787838203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CGY+glbrnxXmLvEdK2C6tXXpmZuhxXjkwnlUGFD0SY=;
	b=bP60ejMcB/j7JeTW5Y8/huGKzk6Ax8TKhAP/9qEp9FpYlaF6xYymrgAd7busyJz/ajWT8/
	CdCuE0E0Gg/cusvKw9q3dtwcLSh9BBioso427f3QF/bH1srGW07C47GCH7hvtxDcIiqwmT
	/HkawBd19ZLRB62TV4oVkIt4xvIjSfU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-GLyhZIivMGyir14htsIE-g-1; Thu,
 27 Aug 2026 09:43:22 -0400
X-MC-Unique: GLyhZIivMGyir14htsIE-g-1
X-Mimecast-MFC-AGG-ID: GLyhZIivMGyir14htsIE-g_1787838200
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D02B19775D7;
	Thu, 27 Aug 2026 13:43:20 +0000 (UTC)
Received: from warthog.com (unknown [10.22.88.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70A5A1800348;
	Thu, 27 Aug 2026 13:43:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] netfs: Fix unbuffered/DIO write partial transfer error return
Date: Thu, 27 Aug 2026 14:42:55 +0100
Message-ID: <20260827134304.2075713-3-dhowells@redhat.com>
In-Reply-To: <20260827134304.2075713-1-dhowells@redhat.com>
References: <20260827134304.2075713-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: jvSN2oT2sPiXpx-pv7mO0QlSN19au6LcCbfSvyjWMFE_1787838200
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix unbuffered/DIO write to return the amount of data transferred in
preference to an error if a partial transfer has been achieved, and to
prefer an error stashed in the request over the one returned by
netfs_unbuffered_write() (likely -EINTR or -ERESTARTSYS).

Fixes: a0b4c7a49137e ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Link: https://sashiko.dev/#/patchset/20260824120224.504575-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index b04019097ab8..544a4243fc59 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -139,13 +139,11 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
 			retry = true;
 		} else if (test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
-			ret = subreq->error;
-			wreq->error = ret;
+			wreq->error = subreq->error;
 			netfs_see_subrequest(subreq, netfs_sreq_trace_see_failed);
 			subreq = NULL;
 			break;
 		}
-		ret = 0;
 
 		if (!retry) {
 			netfs_unbuffered_write_collect(wreq, stream, subreq);
@@ -288,11 +286,11 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		ret = -EIOCBQUEUED;
 	} else {
 		ret = netfs_unbuffered_write(wreq);
-		if (ret < 0) {
-			_debug("begin = %zd", ret);
-		} else {
+		if (wreq->transferred) {
 			iocb->ki_pos += wreq->transferred;
-			ret = wreq->transferred ?: wreq->error;
+			ret = wreq->transferred;
+		} else if (wreq->error) {
+			ret = wreq->error;
 		}
 
 		netfs_put_request(wreq, netfs_rreq_trace_put_complete);


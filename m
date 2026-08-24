Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04E3546DF
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572958; cv=none; b=fgLADcJbGLW9bXd33nFr/HKRYTUetrBSYWWF2pGZNoc0E+qy3ltCO7EGLKoea/4+AuIDcHrEBvwbjU9ASrrsP9hyyGiS061Gq7K3bbRQ7E9XgcvBLKwHQvMlgNu9HZbNBFPPb2lsfCYBQOi+8IMzat7awMpB+SAT1q2mq58/TpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572958; c=relaxed/simple;
	bh=A4NhaUz0PFgkxGsOQggbmrHpH8MhWSAoy5EKuQCcgtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=hYBy/2hwU/m74r2GWfTE1VW4YkqbwcsApmz9k0n24BjQcC6Xy3+e6xiUi+xmrkX0/Rd1BkQu2ZNpiqcLJim3tY7gWN2b7ZSUhpRmbsKoIoB9ortkXl4ovugIn9o7STQj3AaPSiNYhYBju2u2QAL5HaZO2xgFv6/CRzDDc/+Rt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNQbOFN5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNQbOFN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787572956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dm6eVdzu1lSXF3tT287Ob1G0/L65ulpkOnLX+ANQp8A=;
	b=TNQbOFN536qtVwpOAdIZCzp0AnrGGaDDqfjK14hG65doC59hMh2oCmoiHr3j65MxhUsgAk
	gYDFBFNPPttRmQOzWVtj0pmdm4jCPw5zzvE17d5CgW3Ni36jUitJAMeS3aqEZDcb23i2iK
	70kcuaK54/feMP7Zwbe6h6VH6N8lKwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-3u4ezehPMn2u7Sv8Dqarwg-1; Mon,
 24 Aug 2026 08:02:34 -0400
X-MC-Unique: 3u4ezehPMn2u7Sv8Dqarwg-1
X-Mimecast-MFC-AGG-ID: 3u4ezehPMn2u7Sv8Dqarwg_1787572951
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA256197751A;
	Mon, 24 Aug 2026 12:02:30 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.15])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5254A434;
	Mon, 24 Aug 2026 12:02:26 +0000 (UTC)
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
Subject: [PATCH 0/3] netfs, cachefiles: Miscellaneous fixes
Date: Mon, 24 Aug 2026 13:02:19 +0100
Message-ID: <20260824120224.504575-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 9vuZNmUM8dqPsGLxiV0Pubm3uaS_yC1Kq_toritb9p4_1787572951
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Christian,

Here are a couple of miscellaneous fixes for netfslib and one for cachefiles,
if you could pick them up?

 (1) Fix an uninitialised return value from netfs_unbuffered_write().

 (2) Fix read progress reporting to avoid 64-bit tearing on a 32-bit
     machine.  This has been modified from the previous submission as part
     of a different series to take account of a sashiko reported issue[1].

 (3) Fix a potential UAF/KASAN warning reported by sashiko[1] in cachefiles in
     which the coherency data buffer is cast to a __be64* and dereferenced in
     a tracepoint - even though it might not be at least that large (or
     aligned).

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

[1] https://sashiko.dev/#/patchset/20260810144746.574036-1-dhowells%40redhat.com

David Howells (2):
  netfs: Fix read progress reporting
  cachefiles: Fix potential UAF/KASAN warning

Karl Mehltretter (1):
  netfs: Fix uninitialized return value in netfs_unbuffered_write()

 fs/cachefiles/xattr.c             | 16 ++++-----
 fs/netfs/buffered_read.c          |  4 +++
 fs/netfs/direct_write.c           |  2 +-
 fs/netfs/internal.h               |  1 +
 fs/netfs/objects.c                | 32 ++++++++++-------
 fs/netfs/read_collect.c           | 58 +++++++++++++++++++++++--------
 fs/netfs/read_single.c            |  2 ++
 include/linux/netfs.h             |  2 +-
 include/trace/events/cachefiles.h | 19 ++++++++--
 include/trace/events/netfs.h      | 21 +++++++++++
 10 files changed, 119 insertions(+), 38 deletions(-)


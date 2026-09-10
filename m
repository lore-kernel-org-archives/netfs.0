Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B866373BEC
	for <netfs@lists.linux.dev>; Thu, 10 Sep 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077783; cv=none; b=Y3GAQN1mZu8fyNeMbtZ5IWiYqJ/GTPpm5P+rIaTCD5Ea/gFZ2q/rbsruSyM+5PlpsHYx5HFvNbefaObycDIUAX3aym6PcW+6Sfy7b5ccteB+g3vvY7MeUtkPjf7y6EqDpsHp5VtwHSv0/78hCOXn1muWP06w+WL/SSqtHiRFwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077783; c=relaxed/simple;
	bh=BAAZhzk0dAIbmeXmLPZxSGD54t3+SbzTRmNSo8PYBJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=N1ZftMt7gF+3i9oIETzO+TqfsXqWwqZJwtAc0JlxFuVkToV3a237VDHpaB26WPDzIBf1fpxnvGc/JLFwue7p0vnR3N6pbPoxutGMopK4OrrDxXX/RUmVepPxm8yMAQrt5tK9GQ3uIQEh0Ra0aC3Mvvx4xnXrohBvbsPPTdhpyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0fqQKkS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0fqQKkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789077780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVKw1I3EmpaGgSZ8G5JtCSfBramlAPLtWqMErVRVz5g=;
	b=e0fqQKkSt1Cc4ZOE5Wa7R9f+17sFMgB9vnMxo/0z0cuFKLgVG1ODwVCShL1R3unszGh69x
	82QQpfI8vYV+YP2pd0bI0OpAVZXBkO8H8qNDQB37fgP95OGITUyFOQu8BWKIk6AZcjkJuc
	ZCjTUTHcItw7gScdD4TIzruuWJXSKfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Cwu28Ar4P3K9AulwJN_yhQ-1; Thu,
 10 Sep 2026 18:02:58 -0400
X-MC-Unique: Cwu28Ar4P3K9AulwJN_yhQ-1
X-Mimecast-MFC-AGG-ID: Cwu28Ar4P3K9AulwJN_yhQ_1789077775
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93F0E1800EFA;
	Thu, 10 Sep 2026 22:02:53 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBB3230002D1;
	Thu, 10 Sep 2026 22:02:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 0/5] netfs, cachefiles: Changes for next, primarily occupancy tracking-related
Date: Thu, 10 Sep 2026 23:02:35 +0100
Message-ID: <20260910220242.2165023-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Unsb3CSGejSJ36iRf2YXqCDC-OTXYkGdw_APFhpFnCI_1789077775
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Christian,

Could you pull these patches please into your vfs-7.4.netfs branch?  This
is the second of four batches, in this case dealing with cachefiles, and is
based upon the aforementioned branch.  This was split from v11 of a larger
netfslib series[1].

Cachefiles is modified to better implement caching for the class of files
that are opened new/truncated, written once sequentially with no seeking
and then closed (ie. the most common class):

 (1) The object type in the cachefiles file xattr is now correctly set to
     CACHEFILES_CONTENT_{SINGLE,ALL,BACKFS_MAP} rather than just being 0,
     to indicate whether we have one of: a single monolithic blob, all the
     data up to cache i_size with no holes or a sparse file with the data
     mapped by the backing file system (as currently upstream).

 (2) For "ALL" type files, the cache's i_size is used to track how much
     data is saved in the cache and no longer bears any relation to the
     netfs i_size.  The actual object size is stored in the xattr.

 (3) For most typical files which are contiguous and written progressively,
     the object type is now set to "ALL".  For anything else, cachefiles
     uses SEEK_DATA/HOLE to find extent outlines at before (this is the
     current behaviour and needs to be fixed, but in a separate set of
     patches as it's not trivial).

 (4) Reads of "ALL" type files can then skip the SEEK_DATA/HOLE step to
     determine the occupancy; backing file i_size and the object size field
     stored in the state xattr suffice.

Other changes are also made:

 (1) cachefile_do_prepare_read() is merged into cachefiles_prepare_read()
     now that the ondemand mode stuff got removed.

 (2) Some extra traces are added for write failure and insufficient space.

 (3) The state xattr on a cachefile is pre-set to try to avoid having to
     deal with ENOSPC from setxattr when committing the object.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-next-2

Thanks,
David

Changes
=======

ver #12)
- Split from v11 of "netfs: Keep track of folios in a segmented bio_vec[]
  chain"[1]

[1] https://lore.kernel.org/r/20260902173350.3468672-1-dhowells@redhat.com/

David Howells (5):
  cachefiles: Clean up cachefiles_do_prepare_read()
  netfs, cachefiles: Add a couple of traces for write failure
  cachefiles: Add a tracepoint to log insufficient space errors
  cachefiles: Don't rely on backing fs storage map for most use cases
  cachefiles: Preset the state xattr when creating a new file

 fs/afs/file.c                     |   1 -
 fs/cachefiles/interface.c         |  90 ++----
 fs/cachefiles/internal.h          |  14 +-
 fs/cachefiles/io.c                | 461 +++++++++++++++++++-----------
 fs/cachefiles/namei.c             |  34 +--
 fs/cachefiles/xattr.c             |  82 +++++-
 fs/netfs/buffered_read.c          | 188 +++++++-----
 fs/netfs/buffered_write.c         |   3 -
 fs/netfs/internal.h               |   2 +
 fs/netfs/objects.c                |   1 +
 fs/netfs/read_retry.c             |   2 +
 fs/netfs/read_single.c            |  40 +--
 fs/netfs/write_collect.c          | 132 +++++++--
 fs/netfs/write_issue.c            |  18 ++
 fs/netfs/write_retry.c            |   3 +
 include/linux/fscache.h           |  17 ++
 include/linux/netfs.h             |  38 ++-
 include/trace/events/cachefiles.h |  51 +++-
 include/trace/events/netfs.h      |  11 +-
 19 files changed, 785 insertions(+), 403 deletions(-)


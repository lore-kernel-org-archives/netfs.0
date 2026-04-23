Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1D37F8DC
	for <netfs@lists.linux.dev>; Thu, 23 Apr 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982948; cv=none; b=F3VTYc+4cYSWfrLkuh1usPMY1QwwA2dLy2vnDguvVDh7yU7SZdtwHxHzoojzlOKiFVJW94ogufzc8a4t6iRbEif8bYTKY6bgpHz/KG09mpWxd4TufQvtBf35Wz8KMo61UUNj/poIPGc8YoZ3z5gueRc7Nsa+wQC5/cUabOL+oII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982948; c=relaxed/simple;
	bh=YsZpbj1Xs1USGc+its3cFhc9yrcdmLUg4Kjt8OGM3sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=CBX52ijlLeI90Srm0D8Prm56G3kqv6D5/rRFiw50w6Aj5kQnmrE00bujfELprFU0Zs+6pCyuuATOzZAbufTKl8XNiZzCJjxigzjFIL6OJU5JvydfMLCsLSFyvRs30BUmiZUXTZUf0MJB6R9bo5Z/X1+prwY9WXmQoCzQKZdtzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWJdgpdb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWJdgpdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776982946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FLBZ3JamHmSsxpyB/S98F6Ri7h1MoQngzXKMceXD6+w=;
	b=BWJdgpdbA1MwAx/bDs8glyR1gyeHJi0eglyoXC0lH+h7fbBTSpWnSeIKGTtwYgKzF54h2J
	qKuFlAKppLeiEFShFFsBagIOLvcf8PXPU11VI65xo/CObndjrKZUFDGr+MBN+O4aHv5cwu
	bRh5Lq17LtT+0d2iini89n+SuL3lXlQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-a_PuY7yrPMOQDEIlOYyb7w-1; Thu,
 23 Apr 2026 18:22:22 -0400
X-MC-Unique: a_PuY7yrPMOQDEIlOYyb7w-1
X-Mimecast-MFC-AGG-ID: a_PuY7yrPMOQDEIlOYyb7w_1776982941
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A796418003F6;
	Thu, 23 Apr 2026 22:22:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CD55180047F;
	Thu, 23 Apr 2026 22:22:16 +0000 (UTC)
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
Subject: [PATCH 0/4] netfs: Yet further miscellaneous fixes
Date: Thu, 23 Apr 2026 23:22:03 +0100
Message-ID: <20260423222209.3054909-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: qu2kPQlXLi1wTl9IUNCB5piKu_iHGfGwJ2iuj2Iejtk_1776982941
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Christian,

Here are yet more miscellaneous fixes for netfslib, one found by Mark Brown
when integrating linux-next and the rest found by Sashiko.dev's AI review[1]:

 (1) Fix a return statement that should have been removed from
     netfs_read_sizes() and only happens on 32-bit SMP.

 (2) Fix read and write result collection use barriering correctly to
     access a request's subrequest lists without taking a lock.

     This adds list_add_tail_release() and list_first_entry_acquire() to
     appropriate incorporate barriering into some list functions.

 (3) Fix afs_get_link() to take the vnode->validate_lock around
     afs_read_single() to prevent a race with another caller of
     afs_get_link() also trying to read the symlink content.

 (4) Fix the RCU handling of symlinks in RCU pathwalk.  The problems were
     that afs_get_link() didn't use proper RCU pointer dereferencing and
     that AFS symlinks can be updated remotely, potentially causing the
     buffer memory to be changed.

These are applied on top of your vfs.fixes branch.  Patch 1 should fix the
problem in linux-next integration.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

[1] https://sashiko.dev/#/patchset/20260326104544.509518-1-dhowells%40redhat.com

base-commit: 986563b3799fee66965811df3f46f5bb76736084

David Howells (4):
  netfs: Fix wrong return from netfs_read_sizes() on 32-bit SMP arches
  netfs: Fix missing barriers when accessing stream->subrequests
    locklessly
  afs: Fix afs_get_link() to take validate_lock around afs_read_single()
  afs: Fix RCU handling of symlinks in RCU pathwalk

 fs/afs/Makefile          |   1 +
 fs/afs/dir.c             |  33 ++++--
 fs/afs/fsclient.c        |   4 +-
 fs/afs/inode.c           |  96 +---------------
 fs/afs/internal.h        |  35 ++++--
 fs/afs/symlink.c         | 242 +++++++++++++++++++++++++++++++++++++++
 fs/afs/yfsclient.c       |   4 +-
 fs/netfs/buffered_read.c |   9 +-
 fs/netfs/direct_read.c   |  15 +--
 fs/netfs/internal.h      |   3 +
 fs/netfs/read_collect.c  |   4 +-
 fs/netfs/read_single.c   |  12 +-
 fs/netfs/write_collect.c |   4 +-
 fs/netfs/write_issue.c   |   3 +-
 include/linux/list.h     |  37 ++++++
 include/linux/netfs.h    |   1 -
 16 files changed, 358 insertions(+), 145 deletions(-)
 create mode 100644 fs/afs/symlink.c


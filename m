Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502B4A2055
	for <netfs@lists.linux.dev>; Tue,  6 Oct 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320408; cv=none; b=lBVRBSWed7CRAz4MO0U4Id4BX8tsRcu+gIYfLO5pVI1g2dokPBZ/7+8yiSoVxTdl/9IlYtjGf+KkU1RieLz01VnEykg1KfIICYs7oqaNwOqvYdI/WcP2MZTrEMI3kkboaSZtiWGNTJWml1NmhPxn3FB4yWBVy01mZt3gNf1Ul2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320408; c=relaxed/simple;
	bh=H2FmTP0VWiKuvmUZWBnJoF4rBt8lms4tNq1kNCnaFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=YIiOiJXvpe71+dYcy88Ibay9qzhPmtlw8QlL6TAlaspsBy80VH1xaWQoyvdIT/38DWGv7voyNWS+bbzUeN7n/MR49t2zrzmLEfRnP9I2jQUX8fJxUOfzkQ90ODLLWGhlP9W9BYv6lIXfh98DZHhxeD7MLBZnu6ZME55Cmt+JGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glGCCDdD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glGCCDdD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791320405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3UTBequP+2ece8Flw/LLZvFi64Wq0UqNMDxKFvdMi4Q=;
	b=glGCCDdDEv5yTidkR72rg+nBtNjd1FoQ+9HqgPFAl6h1NUXxCzDvJ0O7YZAJKfSN0Zkmol
	orIzRCQE6s2FaBtNxJ5RlEbDdE4u0Q0pCE8taVf1kwD8ZeiOhGYCqZaZCo1jV8JOp7DpZd
	diGNNiUrsmNJ80L5gowlnzkyyTNXAX4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-OEPpxjTLNkucTpIWnjS7-A-1; Tue,
 06 Oct 2026 17:00:02 -0400
X-MC-Unique: OEPpxjTLNkucTpIWnjS7-A-1
X-Mimecast-MFC-AGG-ID: OEPpxjTLNkucTpIWnjS7-A_1791320400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CD3F1977303;
	Tue,  6 Oct 2026 20:59:59 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16CA1180058D;
	Tue,  6 Oct 2026 20:59:50 +0000 (UTC)
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
Subject: [PATCH v13 0/8] netfs: Use a bvecq chain position abstraction
Date: Tue,  6 Oct 2026 21:59:36 +0100
Message-ID: <20261006205947.608356-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: buzLRdWNsVjq7EtPh4WTsRRpY_75MlqG9NRVCyVWBwA_1791320400
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Christian,

Could you pull these patches please into your vfs-7.4.netfs branch?  This
is the fourth of five batches.  The primary purpose of this batch is to add
an abstraction for a position in a bvecq chain and make use of it.

With that in mind, this patchset does the following:

 (1) Add a struct, bvecq_pos, to refer to a position in a bvecq chain.
     This is a tuple of ( bvecq pointer, slot and offset } and the position
     struct holds (for now) a ref on the bvecq pointed to.

 (2) Change unbuffered/DIO to extract the supplied user buffers into a
     bvecq chain rather than a bio_vec[] up front.  This means that
     netfslib then uses bvecq chains for everything.

 (3) Add a folio count to the readahead_control struct and then makes
     readahead pre-create its buffer using that count to determine how many
     slots are required.

 (4) Change netfslib to use the bvecq_pos struct to keep track of the whole
     request buffer and various points in it where loading, dispatch and
     collection are taking place and to also keep track of the slice given
     to each subrequest.

This was split from v11 of a larger netfslib series[1].

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-next-4

Thanks,
David

Changes
=======
ver #13)
- Rebased on -rc6 to account for some conflicting fixes.
- Fixed a bug in netfs_prepare_read_iterator() where comparison was being
  made against the wrong thing when limiting a subreq's size.

ver #12)
- Split from v11 of "netfs: Keep track of folios in a segmented bio_vec[]
  chain"[1]

[1] https://lore.kernel.org/r/20260902173350.3468672-1-dhowells@redhat.com/

David Howells (8):
  mm: Make readahead store folio count in readahead_control
  netfs: Add a function to extract from an iter into a bvecq
  netfs: Make unbuffered/DIO read and write use bvecq
  netfs: Add some tools for managing a position in a bvecq chain
  netfs: Provide a func to load the readahead buffers into a bvecq chain
  netfs: Use bvecq_pos to hold the buffer positions
  netfs: Remove the rolling_buffer implementation
  netfs: Remove netfs_extract_user_iter()

 fs/afs/dir.c                   |   5 +-
 fs/afs/symlink.c               |   6 +-
 fs/cachefiles/io.c             |  12 -
 fs/netfs/Makefile              |   1 -
 fs/netfs/buffered_read.c       | 178 ++++++++-------
 fs/netfs/bvecq.c               | 310 ++++++++++++++++++++++++++
 fs/netfs/direct_read.c         |  77 +++----
 fs/netfs/direct_write.c        |  67 +++---
 fs/netfs/internal.h            |   4 +-
 fs/netfs/iterator.c            | 392 ++++++++++-----------------------
 fs/netfs/misc.c                |  18 --
 fs/netfs/objects.c             |  16 +-
 fs/netfs/read_collect.c        | 106 +++++----
 fs/netfs/read_pgpriv2.c        |  87 +++++---
 fs/netfs/read_retry.c          |  86 ++++----
 fs/netfs/read_single.c         |  16 +-
 fs/netfs/rolling_buffer.c      | 182 ---------------
 fs/netfs/write_collect.c       |  55 ++---
 fs/netfs/write_issue.c         | 166 +++++++++-----
 fs/netfs/write_retry.c         |  61 +++--
 include/linux/bvecq.h          | 184 ++++++++++++++++
 include/linux/netfs.h          |  25 ++-
 include/linux/pagemap.h        |  10 +
 include/linux/rolling_buffer.h |  47 ----
 include/trace/events/netfs.h   |  32 ++-
 mm/readahead.c                 |   5 +
 26 files changed, 1208 insertions(+), 940 deletions(-)
 delete mode 100644 fs/netfs/rolling_buffer.c
 delete mode 100644 include/linux/rolling_buffer.h


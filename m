Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A0301018
	for <netfs@lists.linux.dev>; Mon,  1 Dec 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582571; cv=none; b=o5M8FbOhfJf84jS1+/IeZvuuqll+i+wZlCDslD+MQV8AiKNpxlg9cdPtrw784fwAAaxONAg9EBQ+0aRYJZB8EW/dsnbjdep33me7dBnJvDNtthWXxeKCN3i7YJnKSK7IlU8FST341TI8nQ7hjp7sZzstLxfLlta2Z9TBMGXGutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582571; c=relaxed/simple;
	bh=Pn20/CLhDsAqda23nlqiFd9Tv9dv8/FGYAEgYZxk7Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Na+qinAgctZoehh7SgU9jvdTX5kg43S1ASqnjXCZoY9N0Wpil5UpMXJr4gXTx/+H8bQviVj9RPqAEXQTjTMdMnBfegGbt78QI42kqJiGSch9LmuGmjdnRcNYZ6AYqQr2Z+LOUoDD4eeAdxrYoFLOERTh14i2B6Q8vNecbpiopwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaYnnGYn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaYnnGYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764582569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m3IPpnExHbEY9OdTLRlmHupwtztlF6AGw3VpUFP1MYo=;
	b=EaYnnGYn79CmJ2LsFg4tUUMFbLDDrWh+hXg6KY2H0umGf5UHJ+qtGGP7nb1uwJ55b53Vpd
	EidNxMuwapEf1kJzBH6QBaWHMbDwaS/0Ws7ybWn11sxsiuW9RQPgN/QLFvgnUVVk2QD91b
	HNFOV1c5hjT23HRmIfsWU6/NqMtxnXY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-h2oASED-MM-MeB2BSExdtQ-1; Mon,
 01 Dec 2025 04:49:24 -0500
X-MC-Unique: h2oASED-MM-MeB2BSExdtQ-1
X-Mimecast-MFC-AGG-ID: h2oASED-MM-MeB2BSExdtQ_1764582562
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F245419560A2;
	Mon,  1 Dec 2025 09:49:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44C7718002AC;
	Mon,  1 Dec 2025 09:49:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] cifs: Miscellaneous prep patches for rewrite of I/O layer
Date: Mon,  1 Dec 2025 09:49:04 +0000
Message-ID: <20251201094916.1418415-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Steve,

Could you take these patches extracted from my I/O layer rewrite for the
upcoming merge window.  The performance change should be neutral, but it
cleans up the code a bit.

 (1) Rename struct mid_q_entry to smb_message.  In my rewrite, smb_message
     will get allocated in the marshalling functions in smb2pdu.c and
     cifssmb.c rather than in transport.c and used to hand parameters down
     - and so I think it could be better named for that.

 (2) Remove the RFC1002 header from the smb_hdr struct so that it's
     consistent with SMB2/3.  This allows I/O routines to be simplified and
     shared.

 (3) Make SMB1's SendReceive() wrap cifs_send_recv() and thus share code
     with SMB2/3.

 (4) Clean up a bunch of extra kvec[] that were required for RFC1002
     headers from SMB1's header struct.

 (5) Replace SendReceiveBlockingLock() with SendReceive() plus flags.

 (6) Remove the server pointer from smb_message.  It can be passed down
     from the caller to all places that need it.

 (7) Don't need state locking in smb2_get_mid_entry() as we're just doing a	
     single read inside the lock.  READ_ONCE() should suffice instead.

 (8) Add a tracepoint to log EIO errors and up to a couple of bits of info
     for each to make it easier to find out why an EIO error happened when
     the system is very busy without introducing printk delays.

 (9) Make some minor code cleanups.

The patches will be found here also when the git server is accessible
again:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-next

Thanks,
David

Changes
=======
ver #5)
 - Rebased on the ksmbd-for-next branch.
 - Drop the netfs_alloc patch as that's now taken.
 - Added a warning check requested by Stefan Metzmacher.
 - Switched to a branch without the header prototype cleanups.
 - Add a patch to make some minor code cleanups.
 - Don't do EIO changed in smbdirect.c as that interferes with Stefan's
   changes.

ver #4)
 - Rebased on the ksmbd-for-next branch.
 - The read tracepoint patch got merged, so drop it.
 - Move the netfs_alloc, etc. patch first.
 - Fix a couple of prototypes that need to be conditional (may need some
   post cleanup).
 - Fixed another couple of headers that needed their own prototype lists.
 - Fixed #include order in a couple of places.

ver #3)
 - Rebased on the ksmbd-for-next branch.
 - Add the patches to clean up the function prototypes in the headers.
   - Don't touch smbdirect.
   - Put prototypes into netlink.h and cached_dir.h rather than
     centralising them.
   - Indent the arguments in the prototypes to the opening bracket + 1.
 - Cleaned up most other checkpatch complaints.
 - Added the EIO tracepoint patch to the end.

ver #2)
 - Rebased on the ksmbd-for-next-next branch.
 - Moved the patch to use netfs_alloc/free_folioq_buffer() down the stack.

David Howells (9):
  cifs: Rename mid_q_entry to smb_message
  cifs: Remove the RFC1002 header from smb_hdr
  cifs: Make smb1's SendReceive() wrap cifs_send_recv()
  cifs: Clean up some places where an extra kvec[] was required for
    rfc1002
  cifs: Replace SendReceiveBlockingLock() with SendReceive() plus flags
  cifs: Remove the server pointer from smb_message
  cifs: Don't need state locking in smb2_get_mid_entry()
  cifs: Add a tracepoint to log EIO errors
  cifs: Do some preparation prior to organising the function
    declarations

 fs/smb/client/cached_dir.c    |   2 +-
 fs/smb/client/cifs_debug.c    |  51 +-
 fs/smb/client/cifs_debug.h    |   6 +-
 fs/smb/client/cifs_spnego.h   |   2 -
 fs/smb/client/cifs_unicode.h  |   3 -
 fs/smb/client/cifsacl.c       |  10 +-
 fs/smb/client/cifsencrypt.c   |  83 +--
 fs/smb/client/cifsfs.c        |  36 +-
 fs/smb/client/cifsglob.h      | 197 +++----
 fs/smb/client/cifspdu.h       |   2 +-
 fs/smb/client/cifsproto.h     | 200 ++++++--
 fs/smb/client/cifssmb.c       | 931 +++++++++++++++++++---------------
 fs/smb/client/cifstransport.c | 438 +++-------------
 fs/smb/client/compress.c      |  23 +-
 fs/smb/client/compress.h      |  19 +-
 fs/smb/client/connect.c       | 199 ++++----
 fs/smb/client/dir.c           |   8 +-
 fs/smb/client/dns_resolve.h   |   4 -
 fs/smb/client/file.c          |   6 +-
 fs/smb/client/fs_context.c    |   2 +-
 fs/smb/client/inode.c         |  14 +-
 fs/smb/client/link.c          |  10 +-
 fs/smb/client/misc.c          |  53 +-
 fs/smb/client/netmisc.c       |  21 +-
 fs/smb/client/readdir.c       |   2 +-
 fs/smb/client/reparse.c       |  53 +-
 fs/smb/client/sess.c          |  16 +-
 fs/smb/client/smb1ops.c       | 114 +++--
 fs/smb/client/smb2file.c      |   9 +-
 fs/smb/client/smb2inode.c     |  13 +-
 fs/smb/client/smb2maperror.c  |   6 +-
 fs/smb/client/smb2misc.c      |  11 +-
 fs/smb/client/smb2ops.c       | 178 +++----
 fs/smb/client/smb2pdu.c       | 230 +++++----
 fs/smb/client/smb2proto.h     |  18 +-
 fs/smb/client/smb2transport.c | 113 ++---
 fs/smb/client/trace.h         | 149 ++++++
 fs/smb/client/transport.c     | 305 +++++------
 fs/smb/client/xattr.c         |   2 +-
 fs/smb/common/smb2pdu.h       |   3 -
 fs/smb/common/smbglob.h       |   1 -
 41 files changed, 1800 insertions(+), 1743 deletions(-)


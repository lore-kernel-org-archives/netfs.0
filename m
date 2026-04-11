Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9E3368AC
	for <netfs@lists.linux.dev>; Sat, 11 Apr 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897820; cv=none; b=NPB8XRIhWSthPu5yCcndKYwiPfj2Zn7WY3fdynKIuXelxxRmQv1QzgEXVjXbmDNZelnIZEpdCmZl+QJKH/Cqy8X1/l5BkP27EEDufbJ58GwOV0ihfI7hyRUVQLJUGctJzDVodg0HC+Ub9UWN3EVjzKczyQOqr+0B32ANSg3m9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897820; c=relaxed/simple;
	bh=6IyTjJ0FkMoSea9J+AGLQ3aUcY30PRNbR4NncpohA1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=OlLgHer9XNEEUp1nzXqkDaO3jWaVPcdK9r+jKzT36g4wLyshQzeSFBMwfD6QG0MGHp5EJ8e3Kdl0+lLzgDuB/EW7ommuo136I0ubTyi/bvd6i+P0vtiSvvLI65zrSl8gUa2QOX29g1J5y5cTYHwPvK3/X6UD74zNxyH0XSySZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWRXy2hU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWRXy2hU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775897818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ki83Ytu611LIH2psopIG9xX0z9ofN4J/Dowiy8MC1r8=;
	b=UWRXy2hUrBmGZJeb8sAVZCE2Xz3wnHG0BBNUD8T1eKkcWQQbYp3Tne/hluloBLCECT8CtW
	yIpI7AGk0cQE51wccPSBsqYlRjItmOATsAZ4MoCAuxCfXXOAkc4cCopp8uEsRSRpwFZE4v
	4pL9Sk+TtDhgD1s7S/h68UvSh+h8vjw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-J6cteSNxMlWcHbnBDMk3Og-1; Sat,
 11 Apr 2026 04:56:52 -0400
X-MC-Unique: J6cteSNxMlWcHbnBDMk3Og-1
X-Mimecast-MFC-AGG-ID: J6cteSNxMlWcHbnBDMk3Og_1775897811
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B92B1956080;
	Sat, 11 Apr 2026 08:56:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 179D6195608E;
	Sat, 11 Apr 2026 08:56:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] netfs: Miscellaneous fixes
Date: Sat, 11 Apr 2026 09:56:38 +0100
Message-ID: <20260411085643.3221565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: YpD6DrYEntyOPF68K6a0UsnshNhY-prE0vrSmgHss5s_1775897811
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Christian,

Here are some miscellaneous fixes for netfslib:

 (1) Fix triggering of a VM_BUG_ON_FOLIO() in netfs_write_begin().

 (2) Fix error handling in netfs_extract_user_iter().

 (3) Fix the dentry refcounting in cachefiles_cull().

 (4) Fix netfs_invalidate_folio() to clear the page dirty bit if all dirty
     data removed.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (1):
  netfs: Fix netfs_invalidate_folio() to clear dirty bit if all changes
    gone

NeilBrown (1):
  cachefiles: fix incorrect dentry refcount in cachefiles_cull()

Paulo Alcantara (1):
  netfs: fix error handling in netfs_extract_user_iter()

Viacheslav Dubeyko (1):
  netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call

 fs/cachefiles/namei.c        |  5 +++++
 fs/netfs/iterator.c          | 13 ++++++++++---
 fs/netfs/misc.c              |  6 +++++-
 fs/netfs/read_retry.c        | 11 +++++++++--
 include/trace/events/netfs.h |  4 ++++
 5 files changed, 33 insertions(+), 6 deletions(-)


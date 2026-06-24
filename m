Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540533C1BD
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302273; cv=none; b=CtFetJJ+fP2yQFzt8576zqY0HGp1a27UERy+GJjSG6tM57Od4+h0Wr2JnkFOaT3+1/oieQZlNmXm1Sounexz8V0JRvUj3G/Z2BvH/4dimw4tliRkhwkQdvFJqGRYtdpq+gEkA19g8POkKOQDaoOdCOH6ush+Qhg9YNx1jzGBwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302273; c=relaxed/simple;
	bh=sdkjrnk1/aDo1isQHXHBjuOALl3FnBYe1rEFNLG9NR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=JEnPv64TNMYVGydImhR5sL2dJkG38Yc2epibYbfOqBMLdRqgUW3RRK0W8tSkK5sHkP/lZKdrbo7agIWSkoyyPgMxOuPh85SKlPZr3xS1UneoSUKfT2aBFWaLi3gbs02v+7Hl7UAkgKm/fqQjUhuN4zWPof/Qt9n4Sak+SckyRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZnr9mr8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZnr9mr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782302269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Jn6B1Enc2tDOLXfpCg5+RriHKZeuMcslvrPZlMTtbY=;
	b=PZnr9mr8DG5TIyE5a4GgR0dI2jmiU7jucbmq7CnaWg/POp0Bil5oJ5vr4buhLsu3hCh81V
	mYALCAi2lj0HFCLPHOWtxQ9i41vZNWDxUu9zZWl0jGoumIPEVCpbIrvEI2tHgCc6m3r699
	U6MqNOE5LX20B2DwFLRmAwO1TCpjP78=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-erOTOxkaNcSszkGUxkaMUQ-1; Wed,
 24 Jun 2026 07:57:46 -0400
X-MC-Unique: erOTOxkaNcSszkGUxkaMUQ-1
X-Mimecast-MFC-AGG-ID: erOTOxkaNcSszkGUxkaMUQ_1782302264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AF991955D84;
	Wed, 24 Jun 2026 11:57:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 795DE18004D4;
	Wed, 24 Jun 2026 11:57:41 +0000 (UTC)
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
Subject: [PATCH v2 00/14] netfs: Miscellaneous fixes
Date: Wed, 24 Jun 2026 12:57:21 +0100
Message-ID: <20260624115737.2964520-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 8Rn2MWsmFvTHBYzC4K1XBfkIWGjFy-6YVNqx8VaULFg_1782302264
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Christian,

Here are some miscellaneous fixes for netfslib.  I separated them from my
netfs-next branch.  Various Sashiko review comments[1][2][3] are addressed:

 (1) Fix the decision whether to disallow write-streaming due to fscache
     use.

 (2) Fix a double fput in cachefiles_create_tmpfile().

 (3) Fix alteration of S_KERNEL_FILE inode flag without holding inode lock.

 (4) Fix a potential mathematical underflow in
     iov_iter_extract_xarray_pages() and make it return 0 and free the
     array if no pages could be extracted.

 (5) Fix a missing alloc failure check in iov_iter_extract_bvec_pages().

 (6) Fix iov_iter_extract_user_pages() so that it doesn't leak the pages
     array if it returns an error or 0 (inasmuch as the leak is really in
     the callers).

 (7) Remove an unused variable in kunit_iov_iter.c.

 (8) Fix extract_xarray_to_sg() to calculate folio offset correctly.

 (9) Fix a kdoc comment.

(10) Replace the netfs_inode::wb_lock mutex with a bit lock so that the
     lock can be passed to the collector so that multiple asynchronous
     writebacks won't interfere with each other.

(11) Fix writeback error handling to go through writeback_iter() so that it
     can clean up its state.

(12) Fix ENOMEM handling in writeback to clean up the current folio if we
     can't allocate a rolling buffer segment.

(13) Fix unbuffered/DIO write retry for filesystems that don't have a
     ->prepare_write() method.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

[1] https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
[2] https://sashiko.dev/#/patchset/20260616100821.2062304-1-dhowells%40redhat.com
[3] https://sashiko.dev/#/patchset/20260619140646.2633762-1-dhowells%40redhat.com

Changes
=======
ver #2)
- Addressed various Sashiko comments[3]:
  - Changed some kfree() to kvfree().
  - Added some writeback error handling patches.
- Fixed DIO write retry.

ver #1)
- Added a fix for S_KERNEL_FILE in cachefiles_bury_object().
- Fixed how iov_iter_extract_*_pages() deals with *pages when returning 0
  or error.
- Fixed the replacement of wb_lock with bit lock:
  - Only release the bit lock for writeback, writethrough and write-single,
    not for PG_private_2-based I/O, which doesn't take the lock.
  - In netfs_writeback_single(), need to redirty the inode if can't get the
    lock.

David Howells (14):
  netfs: Fix decision whether to disallow write-streaming due to fscache
    use
  cachefiles: Fix double fput
  cachefiles: Fix file burial to take lock when unsetting S_KERNEL_FILE
  iov_iter: Fix potential underflow in iov_iter_extract_xarray_pages()
  iov_iter: Fix missing alloc fail check in
    iov_iter_extract_bvec_pages()
  iov_iter: Fix a memory leak in iov_iter_extract_user_pages()
  iov_iter: Remove unused variable in kunit_iov_iter.c
  scatterlist: Fix offset in folio calc in extract_xarray_to_sg()
  netfs: Fix kdoc warning
  netfs: Replace wb_lock with a bit lock for asynchronicity
  netfs: Fix writethrough to use collection offload
  netfs: Fix writeback error handling
  netfs: Fix folio state after ENOMEM whilst under writeback iteration
  netfs: Fix DIO write retry for filesystems without a ->prepare_write()

 fs/afs/symlink.c           |  4 +-
 fs/cachefiles/namei.c      |  3 +-
 fs/netfs/buffered_write.c  |  2 +-
 fs/netfs/direct_write.c    |  6 ---
 fs/netfs/internal.h        | 12 +++++
 fs/netfs/locking.c         | 95 ++++++++++++++++++++++++++++++++++++++
 fs/netfs/write_collect.c   | 10 ++++
 fs/netfs/write_issue.c     | 48 ++++++++-----------
 include/linux/netfs.h      | 13 ++++--
 lib/iov_iter.c             | 20 +++++++-
 lib/scatterlist.c          |  1 +
 lib/tests/kunit_iov_iter.c |  5 +-
 12 files changed, 171 insertions(+), 48 deletions(-)


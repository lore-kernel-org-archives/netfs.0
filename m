Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03A396B6F
	for <netfs@lists.linux.dev>; Mon, 18 May 2026 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138803; cv=none; b=Dr2oYi7TyeBf71on9YgyvHgUEQA3NwWis2TYDqwxeRy4LhDWoHDFHSo/Rp3WocL3d9KGqrhqR9ErXUadObZQ8pPw+Tl8KQvTwH4Y50PjBHXidl7DFZMMi/6Eqfp5fpiFHSD/9a6xWz3R8zA4PmDx9IZYWuLRZXYUMF7v1s0ec9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138803; c=relaxed/simple;
	bh=l+947l1b0Udd76daRUmZj0eg3Adlf2gLurzeVN+RKNs=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=pMlfEU8vwz64RxxtxwJMmoTBl+PvBFC/LE99F6t1CQ0HSRCw9pAW1hBL95Y/GHpQH9xst8ESFxMOGKnJZwLE9vezfWRqBWt07JEdHReU65cqya6LC2EjYbfSSixuNbuUF2csvrWXc5xHMOmUbKNOWZkzeFB7sbMIk7r6ppeE/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRvWCN08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRvWCN08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779138800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UFr2B466yutcDxYQYTWpHA69rwnG7hlf5tr2xYNRvZc=;
	b=iRvWCN087giiCZeNMdtZK21LLn70q/zByMAOlWfDtzv+BvyIHPZ7AmwLGbLqlW9er7Iyas
	7VHBDEHZ44sMAGYjZh84gfgcbjLIjvRaelfraqOX5+YOSX3QNCjxjYUnt8q3JrxD/E8UG5
	Gwd6/FpTejdWwPiwy0zjtyGWyktNw8c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-iK9HikplP56Rylpm-5s4yA-1; Mon,
 18 May 2026 17:13:17 -0400
X-MC-Unique: iK9HikplP56Rylpm-5s4yA-1
X-Mimecast-MFC-AGG-ID: iK9HikplP56Rylpm-5s4yA_1779138795
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F00BC195608D;
	Mon, 18 May 2026 21:13:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 131E51956053;
	Mon, 18 May 2026 21:13:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Nathan Chancellor <nathan@kernel.org>,
    kernel test robot <lkp@intel.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Christian Brauner <brauner@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix undefined variables
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 18 May 2026 22:13:09 +0100
Message-ID: <413536.1779138789@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: HCkuLaTohjHDFe9KkdUZtjpRD-_9sTaR6U7Mn-petdI_1779138795
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <413532.1779138789.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Fix a couple of undefined variables introduced by the patch to fix tearing
on ->remote_i_size and ->zero_point.  For some reason, make W=3D1 with gcc
doesn't give undefined variable warnings (but clang does).

Fixes: 2c8f4742bb76 ("netfs: Fix potential for tearing in ->remote_i_size a=
nd ->zero_point")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605031459.eX5UbO3K-lkp@int=
el.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202605021450.ca5QGqLH-lkp@int=
el.com/
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christian Brauner <brauner@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index feac491c5070..f557eb7875c7 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1304,7 +1304,7 @@ static loff_t cifs_remap_file_range(struct file *src_=
file, loff_t off,
 =09struct cifsFileInfo *smb_file_src =3D src_file->private_data;
 =09struct cifsFileInfo *smb_file_target =3D dst_file->private_data;
 =09struct cifs_tcon *target_tcon, *src_tcon;
-=09unsigned long long i_size, old_size, new_size, zero_point;
+=09unsigned long long i_size, new_size;
 =09unsigned long long destend, fstart, fend;
 =09unsigned int xid;
 =09int rc;
@@ -1372,7 +1372,7 @@ static loff_t cifs_remap_file_range(struct file *src_=
file, loff_t off,
 =09=09goto unlock;
=20
 =09spin_lock(&target_inode->i_lock);
-=09if (fend > zero_point)
+=09if (fend > target_cifsi->netfs._zero_point)
 =09=09netfs_write_zero_point(target_inode, fend + 1);
 =09i_size =3D target_inode->i_size;
 =09spin_unlock(&target_inode->i_lock);
@@ -1387,7 +1387,7 @@ static loff_t cifs_remap_file_range(struct file *src_=
file, loff_t off,
 =09if (target_tcon->ses->server->ops->duplicate_extents) {
 =09=09rc =3D target_tcon->ses->server->ops->duplicate_extents(xid,
 =09=09=09smb_file_src, smb_file_target, off, len, destoff);
-=09=09if (rc =3D=3D 0 && new_size > old_size) {
+=09=09if (rc =3D=3D 0 && new_size > i_size) {
 =09=09=09truncate_setsize(target_inode, new_size);
 =09=09=09fscache_resize_cookie(cifs_inode_cookie(target_inode),
 =09=09=09=09=09      new_size);


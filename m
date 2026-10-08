Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBC443E21
	for <netfs@lists.linux.dev>; Thu,  8 Oct 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446993; cv=none; b=iqCKRUEmXxwo/e304/d5F/H3kenUZSCofV6gwJX3+rbC9suKr4ZWZahxsjQeuAZaSST4HilCeWOywO6kv2SxYn721+euP8aRgM7RHtfQlyRIZxl6tA4ogh9ktFZuawREgfdrsYPgsHc3wXf1wHNTMYqlTif6PHnIivPY7c9V6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446993; c=relaxed/simple;
	bh=kRnd+LKIzxJxw6VwOHuLNA/79eD03JUg3/HpboULLUc=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=aSD+HkU2229p8UlDp2tdMdEDpX2msWKR/ilUnNl127h6hmNLjKrWek/R5VsdpNjHEbB7J9wf8lQY6P1lIb4BHZuFVR/f4C2aPT29PNwmEv5aStt9uCb+3NF43QJiVE5O2Ato474GtHerPnq7cAmbiAFlDRNpQhsNkPmBAKMIkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzH56eca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzH56eca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791446987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0iYekUw4inqNQ0sbMSu5SXUFvLuWYxZuMmGmMWMAsGs=;
	b=XzH56ecau/BbEfJeeetQBT1wHeolJx7bL9X+UgBuCmekndOu89INyaqjz5ZGcu1T3aT8uF
	4nf01P3SKhCmNPNUSFgE+XgG6yNcoyrUTY5WB3Xik2RIFeAWbVaHxH+Z95QlQ1UuCk0SG0
	blmWHx2z+RvN0cDo6ePAz/OFcoxN+HM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-YWhcksGfPFW6uvpRqzv4Zg-1; Thu,
 8 Oct 2026 08:09:41 +0000
X-MC-Unique: YWhcksGfPFW6uvpRqzv4Zg-1
X-Mimecast-MFC-AGG-ID: YWhcksGfPFW6uvpRqzv4Zg_1791446979
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 833F21955F12;
	Thu,  8 Oct 2026 08:09:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.90])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B7371956086;
	Thu,  8 Oct 2026 08:09:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache, cachefiles: Fix resize handling
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 09:09:34 +0100
Message-ID: <938341.1791446974@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: -U8AoRKndkFyI311WX0SgFSIP4D23qbk1Ysh_aeB3KE_1791446979
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <938340.1791446974.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Fix the resize handling in fscache and cachefiles by passing down the old
size as well as the new size so that the cache can work out whether the
file is being shrunk or expanded as the cache's idea of how big the file
should be may be stale.

The issue is that netfs_perform_write() updates the network filesystem's
file's i_size as it adds data to the pagecache, but the cache isn't updated
until writeback flushes that data.  A truncation may then scrap that data
and so the cache never sees it and doesn't update before it is told to
resize.  In the resize, cachefiles was comparing the new size against the
current cache size and then thinking the file was being expanded.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Fixes: 1a9fe4b6e787 ("cachefiles: Don't rely on backing fs storage map for =
most use cases")
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_inode.c             |    4 +++-
 fs/9p/vfs_inode_dotl.c        |    3 ++-
 fs/afs/inode.c                |    4 ++--
 fs/cachefiles/interface.c     |    4 ++--
 fs/ceph/cache.h               |    6 +++---
 fs/ceph/inode.c               |    5 +++--
 fs/netfs/fscache_io.c         |    4 ++--
 fs/smb/client/cifsfs.c        |    9 ++++++---
 fs/smb/client/inode.c         |    2 +-
 fs/smb/client/smb2ops.c       |   11 ++++++-----
 include/linux/fscache-cache.h |    2 +-
 include/linux/fscache.h       |   11 ++++++-----
 12 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3829554ca369..32f47c8ca45d 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1022,6 +1022,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 =09struct v9fs_session_info *v9ses;
 =09struct p9_fid *fid =3D NULL;
 =09struct p9_wstat wstat;
+=09uoff_t old_size =3D i_size_read(inode);
=20
 =09p9_debug(P9_DEBUG_VFS, "\n");
 =09retval =3D setattr_prepare(&nop_mnt_idmap, dentry, iattr);
@@ -1086,7 +1087,8 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 =09=09if (v9ses->cache & CACHE_FSCACHE) {
 =09=09=09struct v9fs_inode *v9inode =3D V9FS_I(inode);
=20
-=09=09=09fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size)=
;
+=09=09=09fscache_resize_cookie(v9fs_inode_cookie(v9inode),
+=09=09=09=09=09      old_size, iattr->ia_size);
 =09=09}
 #endif
 =09}
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 116b29e95f21..1a6a338eab08 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -519,6 +519,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 =09=09.uid =3D INVALID_UID,
 =09=09.gid =3D INVALID_GID,
 =09};
+=09uoff_t old_size =3D i_size_read(inode);
=20
 =09p9_debug(P9_DEBUG_VFS, "\n");
=20
@@ -580,7 +581,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 #ifdef CONFIG_9P_FSCACHE
 =09=09if (v9ses->cache & CACHE_FSCACHE)
 =09=09=09fscache_resize_cookie(v9fs_inode_cookie(V9FS_I(inode)),
-=09=09=09=09iattr->ia_size);
+=09=09=09=09=09      old_size, iattr->ia_size);
 #endif
 =09}
=20
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 634fbf8eb212..8fbca46a5755 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -744,7 +744,7 @@ static void afs_setattr_edit_file(struct afs_operation =
*op)
 =09=09if (size !=3D old) {
 =09=09=09truncate_pagecache(inode, size);
 =09=09=09netfs_resize_file(&vnode->netfs, size, true);
-=09=09=09fscache_resize_cookie(afs_vnode_cache(vnode), size);
+=09=09=09fscache_resize_cookie(afs_vnode_cache(vnode), old, size);
 =09=09}
 =09}
 }
@@ -817,7 +817,7 @@ int afs_setattr(struct mnt_idmap *idmap, struct dentry =
*dentry,
 =09=09=09truncate_setsize(inode, attr->ia_size);
 =09=09=09netfs_resize_file(&vnode->netfs, size, false);
 =09=09=09fscache_resize_cookie(afs_vnode_cache(vnode),
-=09=09=09=09=09      attr->ia_size);
+=09=09=09=09=09      i_size, attr->ia_size);
 =09=09=09ret =3D 0;
 =09=09=09goto out_unlock;
 =09=09}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 789ff6abe926..3857c64275fe 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -204,7 +204,7 @@ static bool cachefiles_shorten_object(struct cachefiles=
_object *object,
  * Resize the backing object.
  */
 static void cachefiles_resize_cookie(struct netfs_cache_resources *cres,
-=09=09=09=09     uoff_t new_size)
+=09=09=09=09     uoff_t old_size, uoff_t new_size)
 {
 =09struct cachefiles_object *object =3D cachefiles_cres_object(cres);
 =09struct cachefiles_cache *cache =3D object->volume->cache;
@@ -218,7 +218,7 @@ static void cachefiles_resize_cookie(struct netfs_cache=
_resources *cres,
 =09/* If the file is being shrunk, we need to downsize the backing file
 =09 * and clear the end of the final block.
 =09 */
-=09if (new_size < object->object_size) {
+=09if (new_size < old_size) {
 =09=09if (new_size >=3D i_size)
 =09=09=09goto out;
 =09=09cachefiles_begin_secure(cache, &saved_cred);
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 20efac020394..705ecd4df75e 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -31,14 +31,14 @@ static inline struct fscache_cookie *ceph_fscache_cooki=
e(struct ceph_inode_info
 =09return netfs_i_cookie(&ci->netfs);
 }
=20
-static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
+static inline void ceph_fscache_resize(struct inode *inode, uoff_t old_siz=
e, loff_t to)
 {
 =09struct ceph_inode_info *ci =3D ceph_inode(inode);
 =09struct fscache_cookie *cookie =3D ceph_fscache_cookie(ci);
=20
 =09if (cookie) {
 =09=09ceph_fscache_use_cookie(inode, true);
-=09=09fscache_resize_cookie(cookie, to);
+=09=09fscache_resize_cookie(cookie, old_size, to);
 =09=09ceph_fscache_unuse_cookie(inode, true);
 =09}
 }
@@ -96,7 +96,7 @@ static inline struct fscache_cookie *ceph_fscache_cookie(=
struct ceph_inode_info
 =09return NULL;
 }
=20
-static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
+static inline void ceph_fscache_resize(struct inode *inode, uoff_t old_siz=
e, loff_t to)
 {
 }
=20
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d52e2b389e0b..b23e117380db 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2303,10 +2303,11 @@ void __ceph_do_pending_vmtruncate(struct inode *ino=
de)
 {
 =09struct ceph_client *cl =3D ceph_inode_to_client(inode);
 =09struct ceph_inode_info *ci =3D ceph_inode(inode);
-=09u64 to;
+=09uoff_t old_size, to;
 =09int wrbuffer_refs, finish =3D 0;
=20
 =09mutex_lock(&ci->i_truncate_mutex);
+=09old_size =3D i_size_read(inode);
 retry:
 =09spin_lock(&ci->i_ceph_lock);
 =09if (ci->i_truncate_pending =3D=3D 0) {
@@ -2339,7 +2340,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode=
)
 =09      ci->i_truncate_pending, to);
 =09spin_unlock(&ci->i_ceph_lock);
=20
-=09ceph_fscache_resize(inode, to);
+=09ceph_fscache_resize(inode, old_size, to);
 =09truncate_pagecache(inode, to);
=20
 =09spin_lock(&ci->i_ceph_lock);
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 056a2bae5d99..bce0fa1f6e24 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -267,7 +267,7 @@ EXPORT_SYMBOL(__fscache_write_to_cache);
 /*
  * Change the size of a backing object.
  */
-void __fscache_resize_cookie(struct fscache_cookie *cookie, uoff_t new_siz=
e)
+void __fscache_resize_cookie(struct fscache_cookie *cookie, uoff_t old_siz=
e, uoff_t new_size)
 {
 =09struct netfs_cache_resources cres;
=20
@@ -281,7 +281,7 @@ void __fscache_resize_cookie(struct fscache_cookie *coo=
kie, uoff_t new_size)
 =09=09 * netfs's inode lock so that we're serialised with respect to
 =09=09 * writes.
 =09=09 */
-=09=09cookie->volume->cache->ops->resize_cookie(&cres, new_size);
+=09=09cookie->volume->cache->ops->resize_cookie(&cres, old_size, new_size)=
;
 =09=09fscache_end_operation(&cres);
 =09} else {
 =09=09fscache_stat(&fscache_n_resizes_null);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 98b610b2a114..ccc2cae2d06f 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1314,6 +1314,7 @@ static int cifs_precopy_set_eof(struct inode *src_ino=
de, struct cifsInodeInfo *s
 =09=09=09=09unsigned int xid, loff_t src_end)
 {
 =09struct cifsFileInfo *writeable_srcfile;
+=09uoff_t old_size =3D i_size_read(src_inode);
 =09int rc =3D -EINVAL;
=20
 =09writeable_srcfile =3D find_writable_file(src_cifsi, FIND_FSUID_ONLY);
@@ -1332,7 +1333,7 @@ static int cifs_precopy_set_eof(struct inode *src_ino=
de, struct cifsInodeInfo *s
 =09=09goto set_failed;
=20
 =09netfs_resize_file(&src_cifsi->netfs, src_end, true);
-=09fscache_resize_cookie(cifs_inode_cookie(src_inode), src_end);
+=09fscache_resize_cookie(cifs_inode_cookie(src_inode), old_size, src_end);
 =09return 0;
=20
 set_failed:
@@ -1538,6 +1539,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 =09struct cifs_tcon *src_tcon;
 =09struct cifs_tcon *target_tcon;
 =09ssize_t rc;
+=09uoff_t old_size;
=20
 =09if (len =3D=3D 0)
 =09=09return 0;
@@ -1584,7 +1586,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 =09 * Advance the EOF marker after the flush above to the end of the range
 =09 * if it's short of that.
 =09 */
-=09if (netfs_read_remote_i_size(src_inode) < off + len) {
+=09old_size =3D netfs_read_remote_i_size(src_inode);
+=09if (old_size < off + len) {
 =09=09rc =3D cifs_precopy_set_eof(src_inode, src_cifsi, src_tcon, xid, off=
 + len);
 =09=09if (rc < 0)
 =09=09=09goto unlock;
@@ -1628,7 +1631,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 =09=09=09netfs_resize_file(&target_cifsi->netfs,
 =09=09=09=09=09  i_size_read(target_inode), true);
 =09=09=09fscache_resize_cookie(cifs_inode_cookie(target_inode),
-=09=09=09=09=09      i_size_read(target_inode));
+=09=09=09=09=09      old_size, i_size_read(target_inode));
 =09=09}
 =09=09if (rc > 0) {
 =09=09=09spin_lock(&target_inode->i_lock);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index f29555f3c7d0..a398b2c10aaf 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3097,7 +3097,7 @@ void cifs_resize_file_locked(struct inode *inode, lof=
f_t old_size,
 =09=09return;
=20
 =09fscache_use_cookie(cookie, true);
-=09fscache_resize_cookie(cookie, offset);
+=09fscache_resize_cookie(cookie, old_size, offset);
 =09cifs_fscache_unuse_inode_cookie(inode, true);
 }
=20
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1e9018880639..fa019c67f9e5 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3545,7 +3545,7 @@ static long smb3_zero_range(struct file *file, struct=
 cifs_tcon *tcon,
 =09struct inode *inode =3D file_inode(file);
 =09struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
 =09struct cifsFileInfo *cfile =3D file->private_data;
-=09unsigned long long i_size, new_size, remote_i_size, zero_point;
+=09unsigned long long i_size, old_size, new_size, remote_i_size, zero_poin=
t;
 =09long rc;
 =09unsigned int xid;
=20
@@ -3554,8 +3554,9 @@ static long smb3_zero_range(struct file *file, struct=
 cifs_tcon *tcon,
 =09trace_smb3_zero_enter(xid, cfile->fid.persistent_fid, tcon->tid,
 =09=09=09      ses->Suid, offset, len);
=20
+=09old_size =3D i_size_read(inode);
 =09new_size =3D offset + len;
-=09if (!keep_size && i_size_read(inode) < new_size) {
+=09if (!keep_size && old_size < new_size) {
 =09=09rc =3D inode_newsize_ok(inode, new_size);
 =09=09if (rc)
 =09=09=09goto out;
@@ -3611,7 +3612,7 @@ static long smb3_zero_range(struct file *file, struct=
 cifs_tcon *tcon,
 =09=09=09if (offset < cifsi->netfs._zero_point)
 =09=09=09=09netfs_write_zero_point(inode, offset);
 =09=09=09spin_unlock(&inode->i_lock);
-=09=09=09fscache_resize_cookie(cifs_inode_cookie(inode), new_size);
+=09=09=09fscache_resize_cookie(cifs_inode_cookie(inode), old_size, new_siz=
e);
 =09=09}
 =09}
=20
@@ -4146,7 +4147,7 @@ static long smb3_collapse_range(struct file *file, st=
ruct cifs_tcon *tcon,
 =09netfs_resize_file(&cifsi->netfs, new_eof, true);
 =09netfs_write_zero_point(inode, new_eof);
 =09spin_unlock(&inode->i_lock);
-=09fscache_resize_cookie(cifs_inode_cookie(inode), new_eof);
+=09fscache_resize_cookie(cifs_inode_cookie(inode), old_eof, new_eof);
 out_2:
 =09filemap_invalidate_unlock(inode->i_mapping);
 out:
@@ -4208,7 +4209,7 @@ static long smb3_insert_range(struct file *file, stru=
ct cifs_tcon *tcon,
 =09spin_lock(&inode->i_lock);
 =09netfs_resize_file(&cifsi->netfs, i_size_read(inode), true);
 =09spin_unlock(&inode->i_lock);
-=09fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode));
+=09fscache_resize_cookie(cifs_inode_cookie(inode), old_eof, i_size_read(in=
ode));
=20
 =09/*
 =09 * Move [off, old_eof) right by len. The helper copies backwards if the
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index ee524c863fa9..351a52186bf3 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -67,7 +67,7 @@ struct fscache_cache_ops {
=20
 =09/* Change the size of a data object */
 =09void (*resize_cookie)(struct netfs_cache_resources *cres,
-=09=09=09      uoff_t new_size);
+=09=09=09      uoff_t old_size, uoff_t new_size);
=20
 =09/* Invalidate an object */
 =09bool (*invalidate_cookie)(struct fscache_cookie *cookie);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index f2d958bd1f48..05a562f7f0c1 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -184,7 +184,7 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, =
const uoff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
-extern void __fscache_resize_cookie(struct fscache_cookie *, uoff_t);
+void __fscache_resize_cookie(struct fscache_cookie *cookie, uoff_t old_siz=
e, uoff_t new_size);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, uo=
ff_t, unsigned int);
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, =
struct fscache_cookie *);
 extern int __fscache_begin_write_operation(struct netfs_cache_resources *,=
 struct fscache_cookie *);
@@ -394,8 +394,9 @@ void fscache_update_cookie(struct fscache_cookie *cooki=
e, const void *aux_data,
=20
 /**
  * fscache_resize_cookie - Request that a cache object be resized
- * @cookie: The cookie representing the cache object
- * @new_size: The new size of the object (may be NULL)
+ * @cookie: The cookie representing the cache object (may be NULL)
+ * @old_size: The old size of the object
+ * @new_size: The new size of the object
  *
  * Request that the size of an object be changed.
  *
@@ -403,10 +404,10 @@ void fscache_update_cookie(struct fscache_cookie *coo=
kie, const void *aux_data,
  * description.
  */
 static inline
-void fscache_resize_cookie(struct fscache_cookie *cookie, uoff_t new_size)
+void fscache_resize_cookie(struct fscache_cookie *cookie, uoff_t old_size,=
 uoff_t new_size)
 {
 =09if (fscache_cookie_enabled(cookie))
-=09=09__fscache_resize_cookie(cookie, new_size);
+=09=09__fscache_resize_cookie(cookie, old_size, new_size);
 }
=20
 /**


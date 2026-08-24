Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FC362152
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583725; cv=none; b=sRYyQWLqV7Lbd0NCXKqL8KpvoKhu0N1YQOV7S6zBJtGUqInl5v+yqNo2e4t2tVj/iMywudUjhXOh7BCgqgGbMt7CEdPWzOwkNs+mG4slOTBve86ocm3Hu9Aye0bi2qX16K/kS81Ab9MpwqeuPL+XNoeUb/VCkSV3r7H+XO8ofxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583725; c=relaxed/simple;
	bh=YzEDuU6a6vVVfTd8cZxAVSjwwNl9aaRRJGYYgXY42uk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=j5ZerRU4EdhkQY51j/bK+7M/02TNf8VyAAcFOvrwFxZk755Z5dWkkBX47Aes+40KVq5FU2UkxWFZmPRKeQx28mMQ0/aLZo8NlrVNvRd2KAVlVcBfi+uhKFpyag1NvbII/b1WeFT59hOmo2nI0RCbVhNKcrQ6xIR4VbnJVyJ1HjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BN4gJ6Uy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN4gJ6Uy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787583721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLArC6NVuVo29Q+kqGYDgXmNvJFFLyNjyyjuzg7H2h4=;
	b=BN4gJ6Uy4q/3y/3oPs4iEcN8p2MZIFSFBmPy3k9h0uO+0l3oXP9UmhF2IoAF6RUYsJtYpT
	DMJLAhVzQXK7abNWoQ2uaebZ/aDXNt8Q/TkkDVGwqfi8JGNWp42JyLKXB955bZViWW5Y5e
	bU7jJ9/+9BY4EPIbUD62lfvSueWICro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-qRaPtRW7NxmtGTjHvtDIvQ-1; Mon,
 24 Aug 2026 11:01:58 -0400
X-MC-Unique: qRaPtRW7NxmtGTjHvtDIvQ-1
X-Mimecast-MFC-AGG-ID: qRaPtRW7NxmtGTjHvtDIvQ_1787583713
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84A4A197753E;
	Mon, 24 Aug 2026 15:01:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68B031955F0F;
	Mon, 24 Aug 2026 15:01:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260824144130.759997-1-dhowells@redhat.com>
References: <20260824144130.759997-1-dhowells@redhat.com>
To: Paulo Alcantara <pc@manguebit.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 36/35] cachefiles: Preset the state xattr when creating a new file
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 16:01:45 +0100
Message-ID: <761012.1787583705@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ksTNaFRBcFC5C-4vx7ePs_OgU1j5X2ecFqZLmYGDANI_1787583713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <761011.1787583705.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

   =20
With a really small cache, cachefiles is likely to see a lot of writes
hitting ENOSPC - and this can include setxattr that sets the state xattr on
a cachefile - but we don't really want to successfully fill a cache file
only to have to scrap it because we can't set the xattr.

Instead, preset the xattr when we create the tmpfile we're going to use,
and scrap the file at that point if we get ENOSPC.  Only if setxattr
succeeds do we allow data to be written to the file.

Note that there is a potential performance loss in that writes to the cache
have to be delayed until this is completed - but we do the tmpfile/setxattr
in parallel, starting when the file is opened and only have to wait once
writeback occurs.

Further, a new tracepoint, cachefiles_no_space, has been added to log ENOSP=
C
events, along with a couple of subreq traces to log failure detection in
netfslib.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/internal.h          |    1=20
 fs/cachefiles/io.c                |   23 ++++++++++----
 fs/cachefiles/namei.c             |   15 ++++++++-
 fs/cachefiles/xattr.c             |   59 +++++++++++++++++++++++++++++++++=
++++-
 include/trace/events/cachefiles.h |   30 ++++++++++++++++++-
 include/trace/events/netfs.h      |    2 +
 6 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b2605111fd56..664be64ab538 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -283,6 +283,7 @@ void cachefiles_withdraw_volume(struct cachefiles_volum=
e *volume);
 /*
  * xattr.c
  */
+int cachefiles_preset_object_xattr(struct cachefiles_object *object, struc=
t file *file);
 extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object,
 =09=09=09=09    struct file *file);
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index a1580385d5fb..73c8ba01a9e2 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -672,10 +672,14 @@ int __cachefiles_prepare_write(struct cachefiles_obje=
ct *object,
 =09 * space, we need to see if it's fully allocated.  If it's not, we may
 =09 * want to cull it.
 =09 */
-=09if (cachefiles_has_space(cache, 0, *_len / cache->bsize,
-=09=09=09=09 cachefiles_has_space_check) =3D=3D 0)
+=09ret =3D cachefiles_has_space(cache, 0, *_len / cache->bsize,
+=09=09=09=09   cachefiles_has_space_check);
+=09if (ret =3D=3D 0)
 =09=09return 0; /* Enough space to simply overwrite the whole block */
=20
+=09if (ret =3D=3D -ENOBUFS)
+=09=09trace_cachefiles_no_space(object, cachefiles_trace_write_nospace_2);
+
 =09pos =3D cachefiles_inject_read_error();
 =09if (pos =3D=3D 0)
 =09=09pos =3D vfs_llseek(file, start, SEEK_HOLE);
@@ -704,8 +708,11 @@ int __cachefiles_prepare_write(struct cachefiles_objec=
t *object,
 =09return ret;
=20
 check_space:
-=09return cachefiles_has_space(cache, 0, *_len / cache->bsize,
-=09=09=09=09    cachefiles_has_space_for_write);
+=09ret =3D cachefiles_has_space(cache, 0, *_len / cache->bsize,
+=09=09=09=09   cachefiles_has_space_for_write);
+=09if (ret =3D=3D -ENOBUFS)
+=09=09trace_cachefiles_no_space(object, cachefiles_trace_write_nospace);
+=09return ret;
 }
=20
 static int cachefiles_prepare_write_old(struct netfs_cache_resources *cres=
,
@@ -757,10 +764,14 @@ static int cachefiles_issue_write(struct netfs_io_sub=
request *subreq)
 =09       wreq->debug_id, subreq->debug_index, start, start + len - 1);
=20
 =09if (!cachefiles_cres_file(cres)) {
-=09=09if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+=09=09if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE)) {
+=09=09=09trace_netfs_sreq(subreq, netfs_sreq_trace_cache_waitfail);
 =09=09=09return -ENOBUFS;
-=09=09if (!cachefiles_cres_file(cres))
+=09=09}
+=09=09if (!cachefiles_cres_file(cres)) {
+=09=09=09trace_netfs_sreq(subreq, netfs_sreq_trace_cache_nofile);
 =09=09=09return -ENOBUFS;
+=09=09}
 =09}
=20
 =09ret =3D netfs_prepare_write_buffer(subreq, BIO_MAX_VECS);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index a30df0f91e5e..ef656a319ede 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -117,8 +117,11 @@ struct dentry *cachefiles_get_directory(struct cachefi=
les_cache *cache,
 =09if (d_is_negative(subdir)) {
 =09=09ret =3D cachefiles_has_space(cache, 1, 0,
 =09=09=09=09=09   cachefiles_has_space_for_create);
-=09=09if (ret < 0)
+=09=09if (ret < 0) {
+=09=09=09if (ret =3D=3D -ENOBUFS)
+=09=09=09=09trace_cachefiles_no_space(NULL, cachefiles_trace_mkdir_nospace=
);
 =09=09=09goto mkdir_error;
+=09=09}
=20
 =09=09_debug("attempt mkdir");
=20
@@ -447,6 +450,11 @@ struct file *cachefiles_create_tmpfile(struct cachefil=
es_object *object)
 =09=09pr_notice("Cache does not support read_iter and write_iter\n");
 =09=09goto err_unuse;
 =09}
+
+=09/* Preallocate space for the xattr. */
+=09ret =3D cachefiles_preset_object_xattr(object, file);
+=09if (ret < 0)
+=09=09goto err_unuse;
 out:
 =09cachefiles_end_secure(cache, saved_cred);
 =09object->content_info =3D CACHEFILES_CONTENT_ALL;
@@ -470,8 +478,11 @@ static bool cachefiles_create_file(struct cachefiles_o=
bject *object)
=20
 =09ret =3D cachefiles_has_space(object->volume->cache, 1, 0,
 =09=09=09=09   cachefiles_has_space_for_create);
-=09if (ret < 0)
+=09if (ret < 0) {
+=09=09if (ret =3D=3D -ENOBUFS)
+=09=09=09trace_cachefiles_no_space(object, cachefiles_trace_create_nospace=
);
 =09=09return false;
+=09}
=20
 =09file =3D cachefiles_create_tmpfile(object);
 =09if (IS_ERR(file))
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 5c1794beca93..9f78710bfe4d 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -34,6 +34,57 @@ struct cachefiles_vol_xattr {
 =09__u8=09data[];=09=09/* netfs volume coherency data */
 } __packed;
=20
+/*
+ * Preset the state xattr on a cache file to allocate space for it.
+ */
+int cachefiles_preset_object_xattr(struct cachefiles_object *object, struc=
t file *file)
+{
+=09struct cachefiles_xattr *buf;
+=09struct dentry *dentry =3D file->f_path.dentry;
+=09unsigned int len =3D object->cookie->aux_len;
+=09int ret;
+
+=09buf =3D kzalloc(sizeof(struct cachefiles_xattr) + min(len, sizeof(__be6=
4)), GFP_KERNEL);
+=09if (!buf)
+=09=09return -ENOMEM;
+
+=09buf->type=09=09=3D CACHEFILES_COOKIE_TYPE_DATA;
+=09buf->content=09=09=3D CACHEFILES_CONTENT_DIRTY;
+
+=09ret =3D cachefiles_inject_write_error();
+=09if (ret =3D=3D 0) {
+=09=09ret =3D mnt_want_write_file(file);
+=09=09if (ret =3D=3D 0) {
+=09=09=09ret =3D vfs_setxattr(&nop_mnt_idmap, dentry,
+=09=09=09=09=09   cachefiles_xattr_cache, buf,
+=09=09=09=09=09   sizeof(struct cachefiles_xattr) + len, 0);
+=09=09=09mnt_drop_write_file(file);
+=09=09}
+=09}
+=09if (ret < 0) {
+=09=09trace_cachefiles_vfs_error(object, file_inode(file), ret,
+=09=09=09=09=09   cachefiles_trace_setxattr_error);
+=09=09trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+=09=09=09=09=09   object->object_size,
+=09=09=09=09=09   buf->data, buf->content,
+=09=09=09=09=09   cachefiles_coherency_set_fail);
+=09=09switch (ret) {
+=09=09case -ENOMEM:
+=09=09case -ENOSPC:
+=09=09=09break;
+=09=09default:
+=09=09=09cachefiles_io_error_obj(
+=09=09=09=09object,
+=09=09=09=09"Failed to set xattr with error %d", ret);
+=09=09=09break;
+=09=09}
+=09}
+
+=09kfree(buf);
+=09_leave(" =3D %d", ret);
+=09return ret;
+}
+
 /*
  * set the state xattr on a cache file
  */
@@ -82,10 +133,16 @@ int cachefiles_set_object_xattr(struct cachefiles_obje=
ct *object)
 =09=09trace_cachefiles_coherency(object, file_inode(file)->i_ino,
 =09=09=09=09=09   object_size, buf->data, buf->content,
 =09=09=09=09=09   cachefiles_coherency_set_fail);
-=09=09if (ret !=3D -ENOMEM)
+=09=09switch (ret) {
+=09=09case -ENOMEM:
+=09=09=09break;
+=09=09case -ENOSPC:
+=09=09default:
 =09=09=09cachefiles_io_error_obj(
 =09=09=09=09object,
 =09=09=09=09"Failed to set xattr with error %d", ret);
+=09=09=09break;
+=09=09}
 =09} else {
 =09=09trace_cachefiles_coherency(object, file_inode(file)->i_ino,
 =09=09=09=09=09   object_size, buf->data, buf->content,
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cache=
files.h
index 6146483300c2..3dca69126586 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -85,11 +85,13 @@ enum cachefiles_prepare_read_trace {
=20
 enum cachefiles_error_trace {
 =09cachefiles_trace_alignment_error,
+=09cachefiles_trace_create_nospace,
 =09cachefiles_trace_fallocate_error,
 =09cachefiles_trace_getxattr_error,
 =09cachefiles_trace_link_error,
 =09cachefiles_trace_lookup_error,
 =09cachefiles_trace_mkdir_error,
+=09cachefiles_trace_mkdir_nospace,
 =09cachefiles_trace_notify_change_error,
 =09cachefiles_trace_open_error,
 =09cachefiles_trace_read_error,
@@ -102,6 +104,8 @@ enum cachefiles_error_trace {
 =09cachefiles_trace_trunc_error,
 =09cachefiles_trace_unlink_error,
 =09cachefiles_trace_write_error,
+=09cachefiles_trace_write_nospace,
+=09cachefiles_trace_write_nospace_2,
 };
=20
 #endif
@@ -171,11 +175,13 @@ enum cachefiles_error_trace {
=20
 #define cachefiles_error_traces=09=09=09=09=09=09\
 =09EM(cachefiles_trace_alignment_error,=09"align")=09=09\
+=09EM(cachefiles_trace_create_nospace,=09"create-nospace")=09\
 =09EM(cachefiles_trace_fallocate_error,=09"fallocate")=09=09\
 =09EM(cachefiles_trace_getxattr_error,=09"getxattr")=09=09\
 =09EM(cachefiles_trace_link_error,=09=09"link")=09=09=09\
 =09EM(cachefiles_trace_lookup_error,=09"lookup")=09=09\
 =09EM(cachefiles_trace_mkdir_error,=09"mkdir")=09=09\
+=09EM(cachefiles_trace_mkdir_nospace,=09"mkdir-nospace")=09\
 =09EM(cachefiles_trace_notify_change_error, "notify_change")=09\
 =09EM(cachefiles_trace_open_error,=09=09"open")=09=09=09\
 =09EM(cachefiles_trace_read_error,=09=09"read")=09=09=09\
@@ -187,7 +193,9 @@ enum cachefiles_error_trace {
 =09EM(cachefiles_trace_tmpfile_error,=09"tmpfile")=09=09\
 =09EM(cachefiles_trace_trunc_error,=09"trunc")=09=09\
 =09EM(cachefiles_trace_unlink_error,=09"unlink")=09=09\
-=09E_(cachefiles_trace_write_error,=09"write")
+=09EM(cachefiles_trace_write_error,=09"write")=09=09\
+=09EM(cachefiles_trace_write_nospace,=09"write-nospace")=09\
+=09E_(cachefiles_trace_write_nospace_2,=09"write-nospace-2")
=20
=20
 /*
@@ -707,6 +715,26 @@ TRACE_EVENT(cachefiles_io_error,
 =09=09      __entry->error)
 =09    );
=20
+TRACE_EVENT(cachefiles_no_space,
+=09    TP_PROTO(struct cachefiles_object *obj, enum cachefiles_error_trace=
 trace),
+
+=09    TP_ARGS(obj, trace),
+
+=09    TP_STRUCT__entry(
+=09=09    __field(unsigned int,=09=09=09obj)
+=09=09    __field(enum cachefiles_error_trace,=09trace)
+=09=09=09     ),
+
+=09    TP_fast_assign(
+=09=09    __entry->obj=09=3D obj ? obj->debug_id : 0;
+=09=09    __entry->trace=09=3D trace;
+=09=09=09   ),
+
+=09    TP_printk("o=3D%08x %s",
+=09=09      __entry->obj,
+=09=09      __print_symbolic(__entry->trace, cachefiles_error_traces))
+=09    );
+
 #endif /* _TRACE_CACHEFILES_H */
=20
 /* This part must be outside protection */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index dfe08492d1ad..54e90694eda7 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -102,8 +102,10 @@
 =09EM(netfs_sreq_trace_abandoned,=09=09"ABNDN")=09\
 =09EM(netfs_sreq_trace_add_donations,=09"+DON ")=09\
 =09EM(netfs_sreq_trace_added,=09=09"ADD  ")=09\
+=09EM(netfs_sreq_trace_cache_nofile,=09"CA-!F")=09\
 =09EM(netfs_sreq_trace_cache_nowrite,=09"CA-NW")=09\
 =09EM(netfs_sreq_trace_cache_prepare,=09"CA-PR")=09\
+=09EM(netfs_sreq_trace_cache_waitfail,=09"CA-!W")=09\
 =09EM(netfs_sreq_trace_cache_write,=09"CA-WR")=09\
 =09EM(netfs_sreq_trace_cancel,=09=09"CANCL")=09\
 =09EM(netfs_sreq_trace_clear,=09=09"CLEAR")=09\


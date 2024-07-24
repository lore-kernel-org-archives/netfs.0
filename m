Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97E14C588
	for <netfs@lists.linux.dev>; Wed, 24 Jul 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813632; cv=none; b=taMz1adEs4jgK+uq2UAAbg8kunHaTbF4/qjz4IyUPnFxn/wlJs/6F3m9QSq2QtbyzYUGd75TJc07oH+ByS2lEEPcQmTs+axvRvc2wuZKn1GSDt+6Oktm+b5XD45n362q9O7nSLP3x6M+WGvTdyMB9/YXyTT78bfJtePJ5tqLbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813632; c=relaxed/simple;
	bh=JwAN0p9xGTAtBVInec8HKaT/5oiojA+fFig7rXhiNr0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=JACR7qBSQqPnCNFwL4tdVNIh6sIbMCN32f0r1powPLNYAVZ+fMqVI5ja8h68myGxeaK00KthMBirsPj5aEGUnQu6LPQK3V1gL35MjJj2JjjMvNgwlJekPIPgYnY9O5Om3byD2U+v3WlWQRbOKvA4cAJO7ABpgPmozH+EJBgS1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCi1/OJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCi1/OJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721813629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GoY4pFrqHX8MXBZW22RszHtr+lnU6O5VxxiYvvR8an8=;
	b=eCi1/OJZWV300jgmcmyMAjfK48lDwjPPzCPYZFpaMD9NvLMN23Zvb4NQJlBfYhtedLp9C1
	2Eba4y1L2bhn7zfLkO22DZ0y7qufYjMbFeD1yv71XbqO48SIFaWhLUjhHxryqclwK458yv
	RF3KPtjBFfKkGqReRucmXZ9n19E+UXk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-mb8YA0wBNQSdkhUQDlftnQ-1; Wed,
 24 Jul 2024 05:33:41 -0400
X-MC-Unique: mb8YA0wBNQSdkhUQDlftnQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 152C51955F43;
	Wed, 24 Jul 2024 09:33:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAD9E1955D42;
	Wed, 24 Jul 2024 09:33:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Gao Xiang <xiang@kernel.org>,
    netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: Fix non-taking of sb_writers around set/removexattr
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2299427.1721813616.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jul 2024 10:33:36 +0100
Message-ID: <2299428.1721813616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Unlike other vfs_xxxx() calls, vfs_setxattr() and vfs_removexattr() don't
take the sb_writers lock, so the caller should do it for them.

Fix cachefiles to do this.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Gao Xiang <xiang@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/xattr.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 4dd8a993c60a..7c6f260a3be5 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -64,9 +64,15 @@ int cachefiles_set_object_xattr(struct cachefiles_objec=
t *object)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 =

 	ret =3D cachefiles_inject_write_error();
-	if (ret =3D=3D 0)
-		ret =3D vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	if (ret =3D=3D 0) {
+		ret =3D mnt_want_write_file(file);
+		if (ret =3D=3D 0) {
+			ret =3D vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache, buf,
+					   sizeof(struct cachefiles_xattr) + len, 0);
+			mnt_drop_write_file(file);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
@@ -151,8 +157,14 @@ int cachefiles_remove_object_xattr(struct cachefiles_=
cache *cache,
 	int ret;
 =

 	ret =3D cachefiles_inject_remove_error();
-	if (ret =3D=3D 0)
-		ret =3D vfs_removexattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache)=
;
+	if (ret =3D=3D 0) {
+		ret =3D mnt_want_write(cache->mnt);
+		if (ret =3D=3D 0) {
+			ret =3D vfs_removexattr(&nop_mnt_idmap, dentry,
+					      cachefiles_xattr_cache);
+			mnt_drop_write(cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
 					   cachefiles_trace_remxattr_error);
@@ -208,9 +220,15 @@ bool cachefiles_set_volume_xattr(struct cachefiles_vo=
lume *volume)
 	memcpy(buf->data, p, volume->vcookie->coherency_len);
 =

 	ret =3D cachefiles_inject_write_error();
-	if (ret =3D=3D 0)
-		ret =3D vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, len, 0);
+	if (ret =3D=3D 0) {
+		ret =3D mnt_want_write(volume->cache->mnt);
+		if (ret =3D=3D 0) {
+			ret =3D vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache,
+					   buf, len, 0);
+			mnt_drop_write(volume->cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
 					   cachefiles_trace_setxattr_error);


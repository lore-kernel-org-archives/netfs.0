Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE530F815
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520141; cv=none; b=k9ThJZnFB7301BBAdTZy5zQbfw+a6Naq70IdAZwpHiruHhJfL6Z044FmEgq7vtdMH4m/h9Voo41SLkVuH0oheK6+D1YwM1yqPPhSDttIArMBCCawKi64KPWyyhtb5aU/rLUzbEX3r/Mfm/OzvJD9go1pqS/ASv16AoxnbLKScBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520141; c=relaxed/simple;
	bh=W0RSubsvuNUP/MY+w/2zHRDsOkwolFMbD9JJNN69e5U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=bgi5tYFpIPfWrQsPWE8JRBnadAPm9m2dnLMl7+8nf46+x4eBlL4MLmlWewMwvbt1xBwcQwWHFqPsLvSthE6I7jeWDYQ5sjKWQaf1ycdI8fsUJHLRrz0JSMKWCIoLBuUE7zEW2tmS9xd/qy4+sN3fbcSQriJ1lYM+vNVV5Jq8nwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKe8vS7L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKe8vS7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774520138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0v3gzSjGywfYDE/j1yc8G6gToL1M6HVG21hZM/li6Hw=;
	b=fKe8vS7L2yhCqVJ4aZOEgS7cRMvple++FwRGFpSAvN4TLiTyi5TaxDK8gJjxhTR1BJQsPG
	ZjpETrr0JKi49Y3Rlk5GeK6Zywploqz/bbiHb+Rzgl7jDudL9D1wEbIqKavIdok5rFGvpB
	Rqp8mgcf9IHuq9n+ymQ7vne+krE+nyk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-hIhGNZZ5N-Kc2XEvrZSWWQ-1; Thu,
 26 Mar 2026 06:15:35 -0400
X-MC-Unique: hIhGNZZ5N-Kc2XEvrZSWWQ-1
X-Mimecast-MFC-AGG-ID: hIhGNZZ5N-Kc2XEvrZSWWQ_1774520133
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30FD81955DB6;
	Thu, 26 Mar 2026 10:15:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 767FF1800351;
	Thu, 26 Mar 2026 10:15:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4001609.1774391729@warthog.procyon.org.uk>
References: <4001609.1774391729@warthog.procyon.org.uk>
To: NeilBrown <neil@brown.name>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 10:15:28 +0000
Message-ID: <508495.1774520128@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: rHMicd6_hAqJuSfssgpiROYZOZZQEJ9y-9QOEamCSKU_1774520133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <508494.1774520128.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

   =20
When cachefiles_cull() calls cachefiles_bury_object(), the latter eats the
former's ref on the victim dentry that it obtained from
cachefiles_lookup_for_cull().  However, commit 7bb1eb45e43c left the dput
of the victim in place, resulting in occasional:

  WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7: cachefilesd/11=
831
  cachefiles_cull+0x8c/0xe0 [cachefiles]
  cachefiles_daemon_cull+0xcd/0x120 [cachefiles]
  cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]
  vfs_write+0xc3/0x480
  ...

reports.

Actually, it's worse than that: cachefiles_bury_object() eats the ref it
was given - and then may continue to access the now-unref'd dentry it if it
turns out to be a directory.  So simply removing the aberrant dput() is not
sufficient.

Fix this by making cachefiles_bury_object() retain the ref itself around
end_removing() if it needs to keep it and then drop the ref before returnin=
g.

Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing() a=
nd end_removing()")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: NeilBrown <neil@brown.name>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index e5ec90dccc27..20138309733f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -287,14 +287,14 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,
 =09if (!d_is_dir(rep)) {
 =09=09ret =3D cachefiles_unlink(cache, object, dir, rep, why);
 =09=09end_removing(rep);
-
 =09=09_leave(" =3D %d", ret);
 =09=09return ret;
 =09}
=20
 =09/* directories have to be moved to the graveyard */
 =09_debug("move stale object to graveyard");
-=09end_removing(rep);
+=09dget(rep);
+=09end_removing(rep); /* Drops ref on rep */
=20
 try_again:
 =09/* first step is to make up a grave dentry in the graveyard */
@@ -304,8 +304,10 @@ int cachefiles_bury_object(struct cachefiles_cache *ca=
che,
=20
 =09/* do the multiway lock magic */
 =09trap =3D lock_rename(cache->graveyard, dir);
-=09if (IS_ERR(trap))
-=09=09return PTR_ERR(trap);
+=09if (IS_ERR(trap)) {
+=09=09ret =3D PTR_ERR(trap);
+=09=09goto out;
+=09}
=20
 =09/* do some checks before getting the grave dentry */
 =09if (rep->d_parent !=3D dir || IS_DEADDIR(d_inode(rep))) {
@@ -313,25 +315,27 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,
 =09=09 * lock */
 =09=09unlock_rename(cache->graveyard, dir);
 =09=09_leave(" =3D 0 [culled?]");
-=09=09return 0;
+=09=09ret =3D 0;
+=09=09goto out;
 =09}
=20
+=09ret =3D -EIO;
 =09if (!d_can_lookup(cache->graveyard)) {
 =09=09unlock_rename(cache->graveyard, dir);
 =09=09cachefiles_io_error(cache, "Graveyard no longer a directory");
-=09=09return -EIO;
+=09=09goto out;
 =09}
=20
 =09if (trap =3D=3D rep) {
 =09=09unlock_rename(cache->graveyard, dir);
 =09=09cachefiles_io_error(cache, "May not make directory loop");
-=09=09return -EIO;
+=09=09goto out;
 =09}
=20
 =09if (d_mountpoint(rep)) {
 =09=09unlock_rename(cache->graveyard, dir);
 =09=09cachefiles_io_error(cache, "Mountpoint in cache");
-=09=09return -EIO;
+=09=09goto out;
 =09}
=20
 =09grave =3D lookup_one(&nop_mnt_idmap, &QSTR(nbuffer), cache->graveyard);
@@ -343,11 +347,12 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,
=20
 =09=09if (PTR_ERR(grave) =3D=3D -ENOMEM) {
 =09=09=09_leave(" =3D -ENOMEM");
-=09=09=09return -ENOMEM;
+=09=09=09ret =3D -ENOMEM;
+=09=09=09goto out;
 =09=09}
=20
 =09=09cachefiles_io_error(cache, "Lookup error %ld", PTR_ERR(grave));
-=09=09return -EIO;
+=09=09goto out;
 =09}
=20
 =09if (d_is_positive(grave)) {
@@ -362,7 +367,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cac=
he,
 =09=09unlock_rename(cache->graveyard, dir);
 =09=09dput(grave);
 =09=09cachefiles_io_error(cache, "Mountpoint in graveyard");
-=09=09return -EIO;
+=09=09goto out;
 =09}
=20
 =09/* target should not be an ancestor of source */
@@ -370,7 +375,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cac=
he,
 =09=09unlock_rename(cache->graveyard, dir);
 =09=09dput(grave);
 =09=09cachefiles_io_error(cache, "May not make directory loop");
-=09=09return -EIO;
+=09=09goto out;
 =09}
=20
 =09/* attempt the rename */
@@ -404,8 +409,10 @@ int cachefiles_bury_object(struct cachefiles_cache *ca=
che,
 =09__cachefiles_unmark_inode_in_use(object, d_inode(rep));
 =09unlock_rename(cache->graveyard, dir);
 =09dput(grave);
-=09_leave(" =3D 0");
-=09return 0;
+=09_leave(" =3D %d", ret);
+out:
+=09dput(rep);
+=09return ret;
 }
=20
 /*
@@ -812,7 +819,6 @@ int cachefiles_cull(struct cachefiles_cache *cache, str=
uct dentry *dir,
=20
 =09ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
 =09=09=09=09     FSCACHE_OBJECT_WAS_CULLED);
-=09dput(victim);
 =09if (ret < 0)
 =09=09goto error;
 


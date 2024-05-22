Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5047F7D1
	for <netfs@lists.linux.dev>; Wed, 22 May 2024 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367140; cv=none; b=m+CjzTZwxUxe6aK97Msuos19Zftr8rT92ZNzGwQZz1u7AWQjA7f2XyhOryqANg00tTEZ1rfDhl9M4G2C4SpgCR/iSJeKfMsSv9JeN9gRVg+CdoVmU3xMVBzpGiIiN/k4VMMQRTMYchY48sr4qRaXAbRj2uJ7ga1Gxnh5KkZLM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367140; c=relaxed/simple;
	bh=/RnVnFs+KBCUyJM9I5ehIQyQQbahNe1uMoXF8W9mSLQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=WzdK2z+8NQNS7uHnlAbJa6f7ZU57yjNVVhhqFSE9dzTmGgmU9vYpT2c9/R1Iw9RcATNvaJb8F10F/wtEoMNGS9EDYpD8Cw50HBiRUthHn+bTfLO7QzYd4LQtbmVdZgOCtj5QS+Ob+MFdF8u1zXVrJNzF+15xAFfsICoj8TCSe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSdSVRy8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSdSVRy8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716367137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQwhx3neX6nMoV4M7dECoGraKOSt02xj+EKmgIl1zZ4=;
	b=TSdSVRy8QBW9dz9IV7QJp0gZg4wHtfF5LOXyRons5JLIM5mLBfVV0wxl6/6o/6nQvhXUXv
	pA73M0I8ej6sZ70lBHhEC3g1kWbr1mQku15u2aAwWH3CysxWO2h4BQKgVhsolQjpk++QXF
	1/cYGgBeN/Ys5BtXjOxytRyfjxXA+Gw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-hqowDmYNMsW252bSaIgkLQ-1; Wed, 22 May 2024 04:38:51 -0400
X-MC-Unique: hqowDmYNMsW252bSaIgkLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07227101A52C;
	Wed, 22 May 2024 08:38:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 419C3200A35C;
	Wed, 22 May 2024 08:38:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix smb3_insert_range() to move the zero_point
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <367855.1716367128.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2024 09:38:48 +0100
Message-ID: <367856.1716367128@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Fix smb3_insert_range() to move the zero_point over to the new EOF.
Without this, generic/147 fails as reads of data beyond the old EOF point
return zeroes.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
---
 fs/smb/client/smb2ops.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ef18cd30f66c..b87b70edd0be 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3636,6 +3636,7 @@ static long smb3_insert_range(struct file *file, str=
uct cifs_tcon *tcon,
 	rc =3D smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
 	if (rc < 0)
 		goto out_2;
+	cifsi->netfs.zero_point =3D new_eof;
 =

 	rc =3D smb3_zero_data(file, tcon, off, len, xid);
 	if (rc < 0)


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83227E7E2
	for <netfs@lists.linux.dev>; Tue,  1 Jul 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387981; cv=none; b=uvT4Q+kHKhbSMXTsn2kn6XsEuGQ/vzxvjbCeJl1ZzdUxECt+Acdb19pZ0Tr62Jh6xc8TU5hP+oUodJXXp4r28tucxWapOW9yJ0b5XIShKmVX3p8HcUnkOEe55ldII8l9vquGUwbV3Alldm3sC/gJHvFtkO3EitL3E7eKxKFT8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387981; c=relaxed/simple;
	bh=lE0I550bhsgE1g/V0aBd3UIZc8b5m611RVpdNJbAflg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX6HZ2nGrKfmryIQ9Sc+Flyucmo1bjNgcNWpNFBLg96V/FNBZfyMCCXX14osxXVsGz6ykH2Owgi4zqg7T/o9BmRTj7qklcjWDLkO31r7PfnRZXB61ePAX67/x2LuJsLtix1T4+93P7ly1u/O8mU+DSJvpF7rXgyb5BMrS7qfEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnIBbOEa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnIBbOEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751387978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+0wONjmqODJXPxuYkHRh4BlZQI1gbh0EMhSNzL5f/Ww=;
	b=XnIBbOEavETcrmiJDx20bdp6TT0JqoJqmsCQErqZpYBxwTPna1S5DAH7TXXEUd3lFS2jh2
	BYBCfpaSDSUra6Ee9alBvpByIzWWqi/NDbJVE5TzedqRp+UukD/ZQIFLvm0SSdqc/waw2l
	jGFKu0oRpA691kGs/IqJdJtWZshIM6Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-2HukLdyCPga_5Fu06oC2Ug-1; Tue,
 01 Jul 2025 12:39:37 -0400
X-MC-Unique: 2HukLdyCPga_5Fu06oC2Ug-1
X-Mimecast-MFC-AGG-ID: 2HukLdyCPga_5Fu06oC2Ug_1751387975
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A876E18011DF;
	Tue,  1 Jul 2025 16:39:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AF3B195608F;
	Tue,  1 Jul 2025 16:39:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 07/13] smb: client: set missing retry flag in cifs_readv_callback()
Date: Tue,  1 Jul 2025 17:38:42 +0100
Message-ID: <20250701163852.2171681-8-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
References: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Paulo Alcantara <pc@manguebit.org>

Set NETFS_SREQ_NEED_RETRY flag to tell netfslib that the subreq needs
to be retried.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org
Cc: netfs@lists.linux.dev
---
 fs/smb/client/cifssmb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 7216fcec79e8..f9ccae5de5b8 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1335,6 +1335,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
 		rdata->result = -EAGAIN;
 		if (server->sign && rdata->got_bytes)
 			/* reset bytes number since we can not check a sign */


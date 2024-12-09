Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1D1B0405
	for <netfs@lists.linux.dev>; Mon,  9 Dec 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750062; cv=none; b=MFg2RschVUr7wJv0hDjTx5Nu/pTzzUTDeGnQeYijVX/fCe0daqejtlnSD3Sg2aZO0aPeB5Y71zpy0c6Aam2iENznK5hvH8mRbpCkkVD1QcWP2RtErP+i+zEqnamEn/8mKnrarDrJRWp4uvDsSn++vQTSas4e8lxgjhDDAbfugXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750062; c=relaxed/simple;
	bh=h6QARE/caL5bX1/fTS/81RmE6jFI7Wcw5PJZSDe8wRU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PlllwUzZDcqcwJiUS93dgDZNTdotP7yxlPGig782d7Vsok/S7EBcx5reCR2f85fZ8NUHDHZwZWpWGW+6iGIG4/+LXaS4Bt/1x6zfnj1A7c4laxTBtzTBuQlHfbclCBQ7Ebl/UwcA8nSZ/P7kiK6TLjTV+4FgQ0m0B2RhUfqzrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdkVb2qe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdkVb2qe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733750060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ4m5E5/bsh+47B5T+BAoMFzf3uOEkW9Xl/M2Y5SYQI=;
	b=MdkVb2qeaqu4YzwTs1hBFAEAuwofz1PaY/F/Te5YjoADj4JCcXBHQdcspCIYWhF6RlB/ho
	39orz7RNAt/IWt+Njka43tyq8YhsvPFrmEYwhakAmpBkgGG+Fm1vp70qgtZDNlZIpGJEPP
	hWr+OR8SnzekVljNw81nWUuZrlCBD+Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-G_8VxTJJNoilOLMDj3UWqg-1; Mon,
 09 Dec 2024 08:14:18 -0500
X-MC-Unique: G_8VxTJJNoilOLMDj3UWqg-1
X-Mimecast-MFC-AGG-ID: G_8VxTJJNoilOLMDj3UWqg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B8D91954215;
	Mon,  9 Dec 2024 13:14:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3D8B1956089;
	Mon,  9 Dec 2024 13:14:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com>
References: <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com> <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com> <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com> <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com> <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com> <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix ceph copy to cache on write-begin
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2117976.1733750054.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Dec 2024 13:14:14 +0000
Message-ID: <2117977.1733750054@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Max,

Could you try this?

David
---
netfs: Fix ceph copy to cache on write-begin

At the end of netfs_unlock_read_folio() in which folios are marked
appropriately for copying to the cache (either with by being marked dirty
and having their private data set or by having PG_private_2 set) and then
unlocked, the folio_queue struct has the entry pointing to the folio
cleared.  This presents a problem for netfs_pgpriv2_write_to_the_cache(),
which is used to write folios marked with PG_private_2 to the cache as it
expects to be able to trawl the folio_queue list thereafter to find the
relevant folios, leading to a hang.

Fix this by not clearing the folio_queue entry if we're going to do the
deprecated copy-to-cache.  The clearance will be done instead as the folio=
s
are written to the cache.

This can be reproduced by starting cachefiles, mounting a ceph filesystem
with "-o fsc" and writing to it.

Reported-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 849f40f64443..72a16222b63b 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -62,10 +62,14 @@ static void netfs_unlock_read_folio(struct netfs_io_su=
brequest *subreq,
 		} else {
 			trace_netfs_folio(folio, netfs_folio_trace_read_done);
 		}
+
+		folioq_clear(folioq, slot);
 	} else {
 		// TODO: Use of PG_private_2 is deprecated.
 		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
 			netfs_pgpriv2_mark_copy_to_cache(subreq, rreq, folioq, slot);
+		else
+			folioq_clear(folioq, slot);
 	}
 =

 	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
@@ -77,8 +81,6 @@ static void netfs_unlock_read_folio(struct netfs_io_subr=
equest *subreq,
 			folio_unlock(folio);
 		}
 	}
-
-	folioq_clear(folioq, slot);
 }
 =

 /*


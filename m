Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71A2144C4
	for <netfs@lists.linux.dev>; Thu, 12 Dec 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019244; cv=none; b=hQZM1pViT5kfmPsTIkIH40SOAsC7dsix2PGouieB00DIbHCaPnUmlE9+gkPc/uwvq6La7fcjEoN4Y2EoBjY2a2rpsAEtO6+jsnczla2rr4+DIgaLuif6nDn0kkmsjlGmDhYmYFvIjBWSlmtoyULI4JxhJr1s5wkgPwRbs1MH9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019244; c=relaxed/simple;
	bh=rc/A+zfoLgMcw4oFtpNwtbEKHPWwHyKWpzGQCrZqPtg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=MM2NP8Xic39jVieDhvDtDDbYq3v37UazmMlvDkn+qEQRbKikB5bAvMSsvgzO2CIqSAd+woke03HhbPuJCHGi3yZDLc35AFDsQ/lAJZT9rTmAaL8UVeTvdXHdQGiLhqrksQCmylvdZcej0kK9unfE1V0unFKr+0cRBwdrPZExBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBmJHt4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBmJHt4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734019240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGHoUas+hoBNTIO/X3iEVw0m4f2DhD0T8Dmi/UxHTe8=;
	b=GBmJHt4pEOmi9lBB/0PRS0tKbkrgCO2rDHWHWvL1R6Pqwr6pYXMAu+QvE8Mc0dpchMC8Ym
	xZlr5bkyIgqLzKQk3D92eIQxPlu+e75IF4siSYEBN204FOid3QYgwOcnhUAxITZICUv4Cd
	Heo5SDcqWOqCoCyL2y527+cvB/5OsKM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-dnGvJIAhO0uUkB_inXMfxA-1; Thu,
 12 Dec 2024 11:00:37 -0500
X-MC-Unique: dnGvJIAhO0uUkB_inXMfxA-1
X-Mimecast-MFC-AGG-ID: dnGvJIAhO0uUkB_inXMfxA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F1C119560BA;
	Thu, 12 Dec 2024 16:00:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FF461955F43;
	Thu, 12 Dec 2024 16:00:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+-Bpds7-Ocb-tBMs1==YzVhhx01+FaiokiGR3A-W9t_gQ@mail.gmail.com>
References: <CAKPOu+-Bpds7-Ocb-tBMs1==YzVhhx01+FaiokiGR3A-W9t_gQ@mail.gmail.com> <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com> <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com> <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com> <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com> <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com> <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com> <2117977.1733750054@warthog.procyon.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix ceph copy to cache on write-begin
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2787699.1734019232.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Dec 2024 16:00:32 +0000
Message-ID: <2787700.1734019232@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

How about if you add the attached?

For convenience, I've put the outstanding fix patches I have here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

David
---
commit d0bc2ecca996105f55da22e8867905ca1dad7c8f
Author: David Howells <dhowells@redhat.com>
Date:   Thu Dec 12 15:26:24 2024 +0000

    netfs: Fix the (non-)cancellation of copy when cache is temporarily di=
sabled
    =

    When the caching for a cookie is temporarily disabled (e.g. due to a D=
IO
    write on that file), future copying to the cache for that file is disa=
bled
    until all fds open on that file are closed.  However, if netfslib is u=
sing
    the deprecated PG_private_2 method (such as is currently used by ceph)=
, and
    decides it wants to copy to the cache, netfs_advance_write() will just=
 bail
    at the first check seeing that the cache stream is unavailable, and
    indicate that it dealt with all the content.
    =

    This means that we have no subrequests to provide notifications to dri=
ve
    the state machine or even to pin the request and the request just gets
    discarded, leaving the folios with PG_private_2 set.
    =

    Fix this by jumping directly to cancel the request if the cache is not
    available.  That way, we don't remove mark3 from the folio_queue list =
and
    netfs_pgpriv2_cancel() will clean up the folios.
    =

    This was found by running the generic/013 xfstest against ceph with an=
 active
    cache and the "-o fsc" option passed to ceph.  That would usually hang
    =

    Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
    Reported-by: Max Kellermann <max.kellermann@ionos.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Jeff Layton <jlayton@kernel.org>
    cc: Ilya Dryomov <idryomov@gmail.com>
    cc: Xiubo Li <xiubli@redhat.com>
    cc: netfs@lists.linux.dev
    cc: ceph-devel@vger.kernel.org
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index ba5af89d37fa..54d5004fec18 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -170,6 +170,10 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io=
_request *rreq)
 =

 	trace_netfs_write(wreq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
+	if (!wreq->io_streams[1].avail) {
+		netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+		goto couldnt_start;
+	}
 =

 	for (;;) {
 		error =3D netfs_pgpriv2_copy_folio(wreq, folio);


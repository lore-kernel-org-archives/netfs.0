Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142B386C21
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598874; cv=none; b=AkEdZ82Q1YP3QzwURGHzH0mBvLzzvhW19tIHJZ09HTUFGO7lmKGOPH59vlCfY+7Utrhsxoj40I0KtBBfpM5MMBaD5cJ6sX1K4sgWRyJmAOiqUIaK/o52Q5UwOU5RXv34dC6kpFL5PdAAvU1Tz2Sl2A/spR+lcoPwGpsPHxX8igY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598874; c=relaxed/simple;
	bh=SxdXJcKBdazaDGU/ge+C/QB19+vPXclDzBHeUVvpmx8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=NE0b3yk2ghOTY0vcDweXeKQgvpCW2J4v4rFQ3rCX3Nc8mdUWhwaSoplymOO1yINfj8rwZfw4cb/YaseZgPHZknnuCxD+Y4K9fNu/Ajbz/Fxp0j0FLMedmMbu13ZYQh+PQtUfQkyKB5S2Mh1arHz6C8cY90v2sOdgAVykFAe5luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaL5kCWw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaL5kCWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787598872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ho26chldBrY3Lg5Zu2B6jAh13+WHvLNQWNj3ywDuRw0=;
	b=TaL5kCWw9Yen9xEYh+uvIGzYFdkyD94fsonEWA41TWsPNNLxO73f6Q8B+IrLNE+qzE5CAO
	hW0Z8fulk661Iy0FAv/5BM05xx7CxifZiBmAQ0kUkWMK6FKizwzJYSVoJ6D1wVfEw/mrSp
	vWhv+wxOawNCeWUuK1xv4l7jEmQCwJU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-pG5ItClePkSSbSIU3hVElw-1; Mon,
 24 Aug 2026 15:14:30 -0400
X-MC-Unique: pG5ItClePkSSbSIU3hVElw-1
X-Mimecast-MFC-AGG-ID: pG5ItClePkSSbSIU3hVElw_1787598869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF32B19344FC;
	Mon, 24 Aug 2026 19:14:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC36C18005B4;
	Mon, 24 Aug 2026 19:14:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aoxueo-kIy1Hkmc-@casper.infradead.org>
References: <aoxueo-kIy1Hkmc-@casper.infradead.org> <aoxidVrUtl3F0QUi@casper.infradead.org> <761202.1787584160@warthog.procyon.org.uk> <762789.1787586428@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev
Subject: Re: Function to do end-writeback in bulk
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 20:14:25 +0100
Message-ID: <770270.1787598865@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Bh4Di4_11yNXaEgmOI1-cbfLdK2ubD4JfjNK4Yiaf0_1787598869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <770269.1787598865.1@warthog.procyon.org.uk>

Matthew Wilcox <willy@infradead.org> wrote:

> Jan's more of an expert on the writeback path than I am, but once we've
> cleared the PG_writeback flag on the folio, there's nothing preventing
> us from removing the folio from the pagecache, right?  So the inode could
> then be evicted, and then doing mapping->host would be a UAF.

netfs inode cleanup waits for all outstanding requests to complete, which
would include writeback.

David


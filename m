Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC34570D4
	for <netfs@lists.linux.dev>; Tue,  1 Sep 2026 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247070; cv=none; b=DaSadCYUZJQ8nFrLz+HD2C7oWpxowWjc4O1SIb2BwA+N/r71fwwCBsHF62iJtD4IkYJr/fiFxQtVNY363IAsrSclqCCk3aAzSFSLaLj7BUm1XPV8PqicoLrXWhvG8ifgvfN28yNjuCahTZpWJgV1LMl8MlIYzcjk3PsM+l5ZnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247070; c=relaxed/simple;
	bh=iP6+x/7TSx8+Kr7fm8uHfAek67WjapzFJ6mtX00EKTw=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:From:Date:
	 Message-ID:Content-Type; b=egC0F9P3A56e49Elo5z1R5lIg2z/n+pfsCSdRo1FEtJWML/YGkqJ59TALPfu06nisp/pJD3cuMJLnIEg90NdGyMY4FPKIkZIV3eUmJlzauB1UKy/bF9ZmasS2oDuo7JqbvQqQoveTwno6NG3Q8vqh7IQqn/JnKO1kheooMWBBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekuUp/s3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekuUp/s3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788247067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnAMR1OuJ/mopWGKlGIEuX6Z7FdYlRbeCxORc7j3IRE=;
	b=ekuUp/s3EXEfoN7KcBp/PC6VpM9lEpF2TigWd3ilUFCkc0wL6j2Al30irTIZsasb2IOqDb
	ahXmOvGSsfTJma1hKtQtZ7bPPMAlXNUsMGQPbxVbO6vdTkYKd7YMsHD6JbUOngvRJmn5DJ
	09NS6jMZswIQXozBE479p1EAFyTHC6w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-x5EecXT9MVyV_CDNpyI38A-1; Tue,
 01 Sept 2026 03:17:46 -0400
X-MC-Unique: x5EecXT9MVyV_CDNpyI38A-1
X-Mimecast-MFC-AGG-ID: x5EecXT9MVyV_CDNpyI38A_1788247065
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7D0A1954B18;
	Tue,  1 Sep 2026 07:17:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEF941955F7C;
	Tue,  1 Sep 2026 07:17:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <762789.1787586428@warthog.procyon.org.uk>
References: <762789.1787586428@warthog.procyon.org.uk> <aoxidVrUtl3F0QUi@casper.infradead.org> <761202.1787584160@warthog.procyon.org.uk>
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
From: David Howells <dhowells@redhat.com>
Date: Tue, 01 Sep 2026 08:17:41 +0100
Message-ID: <2748868.1788247061@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 95r5kUB8W7UNpLBz7xB1gTEfjO_YEuzl65Ef-ICvdqA_1788247065
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2748595.1788247021.1@warthog.procyon.org.uk>

David Howells <dhowells@redhat.com> wrote:

> 		lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
> 		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
> 		node_stat_mod_folio(folio, NR_WRITTEN, nr);

Actually, those can't necessarily be bulked.  The first is in the folio's
memcg, the second is in the folio's zone and the third in the folio's pgdat.
I don't know how much these can vary between between folios attached to the
same inode.

David


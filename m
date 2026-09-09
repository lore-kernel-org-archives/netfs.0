Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA833644C7
	for <netfs@lists.linux.dev>; Wed,  9 Sep 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974088; cv=none; b=gNZVu72ccMCXUYiS/PP+GUI8m7ZI/As7/YgTEzYFZg43IESlQEWOcXtuk/F3jtHOepwqqHLfUUHIE1lAD6RxswBZ+EyD+xKk8n20nwMGaMWRSvS1DTKYraPfA6uB0UA7it0bdT0OX3PjZrI5QrinqWMKIFQqaD/WKRc6vChc6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974088; c=relaxed/simple;
	bh=AhG9uZP5Vc+oU60yw43Lea20JRbSBt/2ZAdLmmE7+58=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=QQ2lnRBg+yhEmmmov4LFSExHvCTpYygaJWOQ7B7axgSsArqVpAj3PFwMJX8mKJIxssYZKonF1EDNSlpJkXcaT9TirIyHMmWlP04sg2p/7pYIv8yoc+Pkzqp1cdWkx7ERH62/uu4W1k/Wbsz+zoc6ncnM1agLQaPoHilN/lqibhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0LZ5wLs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0LZ5wLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788974085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrrcFv43Y6IitaL5MyShgfkwkQfgO8qX9JD4vZRKPPY=;
	b=R0LZ5wLsb/y+X9FsRjK9+s/B9qntuzmtdcYI2VHE1r4Dr7lyUCGiigvsw9jUwI0jQYwVxb
	wBF121C4QpAtJaJf+L/r0iKXI37JhsSMlHEc5c1FkAvL4g2d6Jp/W2ZLce0DpI54tMA8Ht
	LnwZawGB5tNciMwTkTbhevwn36woHWY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-v8CazuleNgmALlpzy5bkZw-1; Wed,
 09 Sep 2026 13:14:40 -0400
X-MC-Unique: v8CazuleNgmALlpzy5bkZw-1
X-Mimecast-MFC-AGG-ID: v8CazuleNgmALlpzy5bkZw_1788974077
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94F59195605F;
	Wed,  9 Sep 2026 17:14:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5422F1955F19;
	Wed,  9 Sep 2026 17:14:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1729858.1788973986@warthog.procyon.org.uk>
References: <1729858.1788973986@warthog.procyon.org.uk> <afd68097-b2b2-47e5-889b-fb077e7a9247@redhat.com> <a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com> <1714046.1788952509@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, sorenson@redhat.com,
    Paulo Alcantara <pc@manguebit.org>, Jeff Layton <jlayton@kernel.org>,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    CIFS <linux-cifs@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: netfs_read_gaps(): aliased sink folio makes the read destination unreadable, SIGBUS on cifs with signing
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 09 Sep 2026 18:14:33 +0100
Message-ID: <1729917.1788974073@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: yLTOAWFIByTJc6sU08RKpyhOjli2WaD3v-oSjpHRFt8_1788974077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1729916.1788974073.1@warthog.procyon.org.uk>

David Howells <dhowells@redhat.com> wrote:

> +			folio_unlock(bvec_folio(&bvec[sink_from]));

Meh.  Nevermind.  There are two of them.

David


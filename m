Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904C222585
	for <netfs@lists.linux.dev>; Mon, 24 Nov 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995095; cv=none; b=szSpTQuA/juJ3jA+JzFP6zD0udwxAh0neBiSMBNUYesnZzE8vc+82GI88CORHhcdv6ZRr5I96k175/hs3F24bz4b5xj87cXO6wrP343P2/EiFYOmupystEp5CQDLQfqBSofMCZBpJS4xWgGjrSmz4H42fmIYf1If53q2w9rFjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995095; c=relaxed/simple;
	bh=B9dtQP2sraJQY39GwNGhh+Xoy8eX+Fuq0DQ8cERk7Q4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rzjBlk0w0q0Vqv5f8WoHwpxTsP8mrm+7JxpPDvEYzYVimLcZybHlGWzilkInGQGtDXk3pnlrundqAKzbzjWhL3obzQAqGfQlq+H6VCW2WpFD7hHfRY47OpPdppykksDmmW1/k4BuNZoblvbQgIdgomqNstNNJcjQ2FuVLbGTNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMZaOW8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMZaOW8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763995093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9dtQP2sraJQY39GwNGhh+Xoy8eX+Fuq0DQ8cERk7Q4=;
	b=KMZaOW8dB5TsYWtNLcxlwn1Do2XUJI4Og3VdBxzV+kCj8OyXQr6iZ5lExhUTuE8SRebOEw
	s2pTA87CpN46lH4lYxrQRaxSBsMkhRUamzTSdWlxQ76ASypYrg40l7MuLwU0qFDqupaTI9
	T+im08T1qEsULiaEKJKvdcYgl94W6LI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-nky6k9zlPmu4mNlpESda7A-1; Mon,
 24 Nov 2025 09:38:08 -0500
X-MC-Unique: nky6k9zlPmu4mNlpESda7A-1
X-Mimecast-MFC-AGG-ID: nky6k9zlPmu4mNlpESda7A_1763995086
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAA9519560A2;
	Mon, 24 Nov 2025 14:38:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB3201956056;
	Mon, 24 Nov 2025 14:38:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <026c8869-b90d-47df-859a-9f0a6c56d653@samba.org>
References: <026c8869-b90d-47df-859a-9f0a6c56d653@samba.org> <20251124124251.3565566-1-dhowells@redhat.com> <20251124124251.3565566-12-dhowells@redhat.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/11] cifs: Add a tracepoint to log EIO errors
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3636008.1763995083.1@warthog.procyon.org.uk>
Date: Mon, 24 Nov 2025 14:38:03 +0000
Message-ID: <3636009.1763995083@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stefan Metzmacher <metze@samba.org> wrote:

> would you mind if we remove all smbdirect.c changes from this patch,
> as my changes I'm currently rebasing on this would remove them again
> anyway.

Sure.

David


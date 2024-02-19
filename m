Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DE39855
	for <netfs@lists.linux.dev>; Mon, 19 Feb 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355455; cv=none; b=rCrQNBkD/kMweHqLkk5tvNPRlUY76ze0p/IOCTHfMvIrjRwLP0ktFrCjiAv6LkjMslU9w/smejEknqLIG+WemoKlDbN6xhrqYugo3RsVBSwmPRh6kkG1QgpfLbF9ToUxTPTv/rbqMESELuEXamveIhrkWlddjIPuBptzKjOx9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355455; c=relaxed/simple;
	bh=o6fyOf6G7BhIiVO7M4QfgNflaD8M9HcGvUR8Y5llcxQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=COEQ2jYNbw82HFdWpi1arXMEo19nfvADOmmRdHSvLVCZjsZcqsVO8yZAwykQvzDbbpJ2Tu39wTvCvYP6Ecd60rQI68qWxgU4ufNPTWq5YQBXyNca2lQNdX2iho3VaNhbiJ5Sxsz9/NtOS6hIU7CmSkg+oLfcnXM094t8I9ma5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfxDOLC4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfxDOLC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708355450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSqXWjK+LddXqIK8pJkcj8gOwnFmQLsFMFK0s1Et2YI=;
	b=OfxDOLC4A/4bdeN5vRLoPD/SDad0L9wbGFyh1DFORzhimF8gXinZF8DMfYIjFcxpB2p924
	EoSILQ5J+uExYWtyE2xZ370RZOqGfpbL7vn67UDhlLnGz3AGWfuVopK93sBAdyTM/gX2L7
	1YJVJf6YWYRCOm98InRRTe1YR/rKg5I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-H-vk5ZXBOuiyEmjzhFTpBQ-1; Mon, 19 Feb 2024 10:10:48 -0500
X-MC-Unique: H-vk5ZXBOuiyEmjzhFTpBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7698881C87;
	Mon, 19 Feb 2024 15:10:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 014748077;
	Mon, 19 Feb 2024 15:10:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240209105947.GF1516992@kernel.org>
References: <20240209105947.GF1516992@kernel.org> <20240205225726.3104808-1-dhowells@redhat.com> <20240205225726.3104808-10-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH v5 09/12] cifs: Cut over to using netfslib
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <140601.1708355444.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 15:10:44 +0000
Message-ID: <140602.1708355444@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Simon Horman <horms@kernel.org> wrote:

> >  /* Functions related to files and directories */
> > +extern const struct netfs_request_ops cifs_req_ops;
> >  extern const struct file_operations cifs_file_ops;
> >  extern const struct file_operations cifs_file_direct_ops; /* if direc=
tio mnt */
> >  extern const struct file_operations cifs_file_strict_ops; /* if stric=
tio mnt */
> =

> Nit: this hunk would probably be better placed in the
>      patch at adds cifs_req_ops to fs/smb/client/file.c

I'm not sure I understand what you mean.  Is there a bit missing between "=
at"
and "adds" in that?

David


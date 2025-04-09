Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F226E148
	for <netfs@lists.linux.dev>; Wed,  9 Apr 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211044; cv=none; b=cmlKlV+//Zdl6zoX5jrxAOu9LjSb2q7fhpBOmebRqhl2S1WwbNAIEMz6Z0VHSDDxGHnxtaSSb+OsbzCmqfOIg2LbVnw4+tZnIihdov7a3qbERh6rDyaLdNqy35U39ZxDovIRkNHyHd6YQ8qWk1p+Wq0pzpEOtTZQIC9zQRQKJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211044; c=relaxed/simple;
	bh=oqpWJBYbkroHFEUQdjREHV/huht+JSeb/D4fycGG8dM=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=QbggvJ1lvwdkpfX5HX8RQnU4y6oSrxjuQc4U3FaifpHDiiAgN7W7HBXz/Q43Ud9lbwIDhLzJcrX32mmAPPxUJ86AKpNK4y1bBVoZOzwBA7JYQtkmzIIjSXaNQvY/nwP5HWxDygMQJQDImXAplEn0ZKRBtWIMZHQZuYB00IxmEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUq6Cn9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUq6Cn9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744211041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oqpWJBYbkroHFEUQdjREHV/huht+JSeb/D4fycGG8dM=;
	b=IUq6Cn9B3Qko43/74nOmvNe6Y6sZIl3erM17Qi5vJLZTqt7lGIiRdSn1NprvWlMHw5+ieF
	OyabykKmObRVk1S1ELXcmzRsjzq359oKCxNtsWPQLf04iQcXmwkZZDmocXkt99QvsVNtTE
	uCcnsPKm+ozYmrfQokC8LCMZKM1nxOY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-DD8Pc8seNeObwO6PoCHcqg-1; Wed,
 09 Apr 2025 11:03:49 -0400
X-MC-Unique: DD8Pc8seNeObwO6PoCHcqg-1
X-Mimecast-MFC-AGG-ID: DD8Pc8seNeObwO6PoCHcqg_1744211028
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECD5B19560B3;
	Wed,  9 Apr 2025 15:03:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89B3D1955D81;
	Wed,  9 Apr 2025 15:03:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1478622.1744097510@warthog.procyon.org.uk>
References: <1478622.1744097510@warthog.procyon.org.uk> <b395436343d8df2efdebb737580fe976@manguebit.com> <20250407184730.3568147-1-song@kernel.org>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Song Liu <song@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] netfs: Let netfs depends on PROC_FS
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1691553.1744211025.1@warthog.procyon.org.uk>
Date: Wed, 09 Apr 2025 16:03:45 +0100
Message-ID: <1691554.1744211025@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David Howells <dhowells@redhat.com> wrote:

> It should marked be module_init(), not fs_initcall().

Actually, it does need to use fs_initcall() so that when it's built in, it
gets initialised before any filesystems that use module_init().

David


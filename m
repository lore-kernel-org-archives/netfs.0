Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EF3655C0
	for <netfs@lists.linux.dev>; Thu, 27 Aug 2026 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815886; cv=none; b=NbHRGbyS9oo11n6dW6uRk//sDPhXq+wGctJyCWCKRL8TLB46PVRF0L/Rf6T9LmRtYvZWEXorI0y9KmZjLB6W8mhiaYkWGfgldqhKi6/L3m7bSXiXLbOmcfeU8skXpDGF4w9RuvsLGgXQG5+cadpb3J1DOZrBPFn58CzDT/6bR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815886; c=relaxed/simple;
	bh=OX+9OYS8ReByP/94EupI0N5Xpt6Kz9ER6xF2/yoHhnk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=X4Xb7y+uRQb5vH/q1VJNrP4wbSJBi+T9mV8isEExvXVkFOGTX3zDqPn6boHi0d8sZKEnoaXjLnZhqvp8b48kqod9OQKTT10u5szB/DFFKo8w0kUiaGkyELmgKPndh2SyQP8YaI32XScwdHUIRjQIDXB6TeOSwNF5QlyFDa7Ybx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn0l/LzT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn0l/LzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787815883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfoMUYax+Ia10lp9LMOjRZATKtFivECVEX6/+plOxWQ=;
	b=Nn0l/LzTFJNC4HgOn2erm0xuuxLbV1NsTHbLuTbjDO1gvyDJomX6H4qL6CReDqGUm9J+BZ
	bl0Ah3h1yIGFBoqluccJOJwNDT1K7+lR/TlX4mLbnc10VhvIfly1QDXoqZPzEkzDkNAyPA
	QRSUIKj+BqLt5oY+C0S+Wes64xl78/0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-HjkHOimGM2i-eShqLCE8JQ-1; Thu,
 27 Aug 2026 03:31:21 -0400
X-MC-Unique: HjkHOimGM2i-eShqLCE8JQ-1
X-Mimecast-MFC-AGG-ID: HjkHOimGM2i-eShqLCE8JQ_1787815881
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 815F91835AEB;
	Thu, 27 Aug 2026 07:31:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.88.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 498B71800641;
	Thu, 27 Aug 2026 07:31:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260827061444.2404961-1-chenyichong@uniontech.com>
References: <20260827061444.2404961-1-chenyichong@uniontech.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: fix out-of-bounds read in coherency trace
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 08:31:18 +0100
Message-ID: <1924988.1787815878@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: A1agrjRUZvGPvNvCwKCMl45hKRWrfJ8xToOLSpFccWg_1787815881
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1924987.1787815878.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Thanks, but I have a patch for this.  See patch 9 here:

https://lore.kernel.org/linux-fsdevel/20260825132045.1000787-1-dhowells@red=
hat.com/

I don't want to call memcpy() like this just for the purposes of a tracepoi=
nt
that is almost certainly not actually be active.

You're also moving buf->content into a variable rather than using it direct=
ly
- is there a reason for that?

David


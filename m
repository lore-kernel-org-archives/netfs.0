Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801E2CCC5
	for <netfs@lists.linux.dev>; Sat, 11 Apr 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898120; cv=none; b=qMb95QTYsS8I6AsLiyDDPIxJqoK3Cs+FVtPc15wlr2OVOfU869pRZnIwaNlYZuWo90xQgZk5rSJPwMuE+nTL8Nqi9e/RWxc6JWFJCILKgdULn600V9nEj9ZGADLJ0Z1z7eL8nXcrcVLCEgnHV+7WKv7iLrL2mYm965vdRKn1pXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898120; c=relaxed/simple;
	bh=t3UHLKt+LZbIDHauS9SUNEPbHq6s3Dz66D9uzGJEC4c=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=Ata66PZAegj8ZwXVu6sNAvcoLS2ra5My+/TozXKEFonnPFPsu66TdFVbM8JX2Efz4NAwcauUjucLrmOivV1MVTp06HYQEonmMZSEpTThFNJFkHazL34NCQeKAJeTzmyg+wCknaJkRUYWCm172PkA4RZBcplNStP+v7PfvbpSvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUUP+vdy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUUP+vdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775898118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3UHLKt+LZbIDHauS9SUNEPbHq6s3Dz66D9uzGJEC4c=;
	b=PUUP+vdy5cA6S3HYcF+SvpmSb+/1V/bNx+aw2JyXQoqpp32/GbqEmo88crL5hwKzYK/i8l
	hF9yzFNRuAjnHg6emEcGug/jMGGcAraS9+d2Ru1ChcF6JjxgjwuN/aZLzhy1iFPkpQWAQr
	2SlZXrP0pS3YZdXefi4LvZXTnLkL9d0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-fDuhLqYOMZS583ifo6Dxtg-1; Sat,
 11 Apr 2026 05:01:54 -0400
X-MC-Unique: fDuhLqYOMZS583ifo6Dxtg-1
X-Mimecast-MFC-AGG-ID: fDuhLqYOMZS583ifo6Dxtg_1775898113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FEF31800365;
	Sat, 11 Apr 2026 09:01:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC3771955D86;
	Sat, 11 Apr 2026 09:01:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260411085643.3221565-5-dhowells@redhat.com>
References: <20260411085643.3221565-5-dhowells@redhat.com> <20260411085643.3221565-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/4] netfs: Fix netfs_invalidate_folio() to clear dirty bit if all changes gone
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 11 Apr 2026 10:01:47 +0100
Message-ID: <3222155.1775898107@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 0w0AZLRdoowVH3MdauSMoqpDGyDYSMohX0bRK1DGAW0_1775898113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3222154.1775898107.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Fixes: 9ebff83e6481 ("netfs: Prep to use folio->private for write grouping =
and streaming write")


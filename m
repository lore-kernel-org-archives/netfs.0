Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205D1E480
	for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537277; cv=none; b=exhNO9uHbB/2w8UepAazXRjZiZJAdtbMLwZU/tY8LDaKICgCiUUyoXjJbbU1pKV5vVJNyIju/ZWh3B/0l/TN9l9V7g7U8oNzyvBFQjoa3r3hXQxgvA/GJJLyaAcpG24XNsgQ4TeUVrFySKMhdb6xqLd2ZHDwrg4fPpMi+TMOkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537277; c=relaxed/simple;
	bh=fTxzODGBi+ZFclXpeeFV0TXc1T6oteColu9HTfZjLOQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ag8zrVK7h9BXcSgGKbjlb4dXDmabI2Panixg/sEdwyVwsmc5OvcKmZ1rlSUBvRj2HIyvdPkpj0N/ZJlqot5WSimF/XPnWh/g0k8xSqplg8d1aeFhe9nhaUk1XTtAUyYk+UOZxqmpUEk3Ye3/v05YYuFkfUQXR8BdycmgghMAtjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLHqizC6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLHqizC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739537274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3Fb4WVL3Q4Hub/F9v0HPdCmHn7KOYV+2x0h+73fMEI=;
	b=CLHqizC6DCl3E6CmMNBecNHEdkLXti+h1ZfaVXPDXkF6nWuYSV+lXge4/W46xyUDpimuZk
	bYwrXJfdaUZcgF1qH/vxUpJHQLJWkNTRcuvNLIskNEhYLVbl9tJSXhpgnaQg1opc1vESe9
	fNQm7Jbst4jiV1i7m0xWc4x1wE69aW4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-xQlZE2t8M9CGTtNzXbW_Mg-1; Fri,
 14 Feb 2025 07:47:50 -0500
X-MC-Unique: xQlZE2t8M9CGTtNzXbW_Mg-1
X-Mimecast-MFC-AGG-ID: xQlZE2t8M9CGTtNzXbW_Mg_1739537270
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF9721800873;
	Fri, 14 Feb 2025 12:47:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E95B61955DCE;
	Fri, 14 Feb 2025 12:47:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250210191118.3444416-1-max.kellermann@ionos.com>
References: <20250210191118.3444416-1-max.kellermann@ionos.com> <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3978044.1739537266.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Feb 2025 12:47:46 +0000
Message-ID: <3978045.1739537266@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Max Kellermann <max.kellermann@ionos.com> wrote:

> David, this seems to fix the bug for me.  Please also check if we need
> a "donation_changed" check.

Shouldn't do since at that point we've been holding rreq->lock since the l=
ast
check.

> If multiple subrequests donate data to the same "next" request
> (depending on the subrequest completion order), each of them would
> overwrite the `prev_donated` field, causing data corruption and a
> BUG() crash ("Can't donate prior to front").
> =

> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysn=
PadkmHOyB7Gz0iSMA@mail.gmail.com/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Signed-off-by: David Howells <dhowells@redhat.com>


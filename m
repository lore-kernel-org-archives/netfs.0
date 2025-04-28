Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418025D8E8
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854916; cv=none; b=RltM/+pM91tgsoRA96cCzLjzMLjdZiQ4vD4t1oPSLjb1IoSFHicnItiQI1bDg1uYxWPSAKILx8cf8f4p1dVHgNjGje5qa4C1bdtzKFtaIBXRBLGwzGkSFqElr68IW3Ae9KnqA3c6WrcGqVUhPkWulvkMR8RLpl1xVgVBugNgsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854916; c=relaxed/simple;
	bh=8ch5DQp8Kty/KrAmpmYdxykrRR1k8iE2m3/U5B8Iy6s=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RAMUSvGPbAG1Ix3T5nxeYYTrISb3V9FkNW+AseFSmxbyKX5CrlWRzfO3KgpYDjt5Xu6jYbwKlitlprS0epboJtds9i/GWZN7B/sx1vPAUlWhUFBUeI0Vx3JnXRTVXaraA7WWhy5szVCQnUzrnSG9UMJAmW8rGRemxaZ4N1cu96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2IQk0mn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2IQk0mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745854913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vA+l+B4aNk1ah9Kc7JRny/fIOHu+wRpfqoGduvsEtpc=;
	b=L2IQk0mnmwjJ9kFjMFF6Zl5GUg5dQRE08aGlmh/9saczojBDDywItXeXbq8EH9Qyn5lKR6
	qfbq0Ji2wijzcVUjVPF+Q74zDMzHdgeTxHiy7Bhbw/9mYBOX3Y2Uj8DE31mTna8S+afsgk
	fgH+l4iQry9evOVqCRzEJ7ScXkU5wLI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-KhzhVJ9FObuM8tkOx93nEw-1; Mon,
 28 Apr 2025 11:41:50 -0400
X-MC-Unique: KhzhVJ9FObuM8tkOx93nEw-1
X-Mimecast-MFC-AGG-ID: KhzhVJ9FObuM8tkOx93nEw_1745854909
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DF8B1800874;
	Mon, 28 Apr 2025 15:41:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E36919560A3;
	Mon, 28 Apr 2025 15:41:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250428114842.3180169-1-max.kellermann@ionos.com>
References: <20250428114842.3180169-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/netfs/read_collect: remove duplicate line
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88036.1745854906.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Apr 2025 16:41:46 +0100
Message-ID: <88037.1745854906@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Max Kellermann <max.kellermann@ionos.com> wrote:

> The `ret` variable has already been assigned before the `switch`
> block.
> =

> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only us=
e one work item")

Please hold off on this one.  I want to submit the two patches at the bott=
om
of here instead:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

	netfs: Fix the request's work item to not require a ref
	netfs: Fix wait/wake to be consistent about the waitqueue used

and this code gets moved and commonalised with the wait-for-write function=
s.

The reason I haven't posted them yet is that there may be an issue with ci=
fs -
and only in Steve's testfarm - though I'm not sure whether it's actually
directly related to the changes here or whether it was masked just by it.

Thanks,
David


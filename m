Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23E230D1E
	for <netfs@lists.linux.dev>; Fri, 14 Feb 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537628; cv=none; b=F1K29lfZsYS98/uuVT9PirEaB6TdnsC6QdZwMf3MjsZCEwN6KjDF6TZt2OFt2sSjPsk4U+ZtQlWDIzPUjHEGLITI9RS3+QhN2Dyg1Nubpoax4Qo/8oBQNha+mRnwpP2f6t2uDRjEtyrfVJ8EFX0zhs2oKvl8/Z+HtXRFulV7MqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537628; c=relaxed/simple;
	bh=4z1f4w3fc/rS+rR37tw4jvKtssLmhg7xJF+noxM8VNw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KuRi2VWHDZnXn61IkiA3qr2yXKZuyEFHecHu0c1D0sQh3x+8oM5QN3pEb2jI6ErHHXYTNF0TQCxG74glZGK4W9DpRweHrBdqpY/CWtlNxWPrfG6etU0PkCxs1Q/iNrPFmDUnY91ty/9RCGha8uSze5Mn+MsEHk5k4E1vaLNGYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APdeHuzq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APdeHuzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739537625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M24UA7C5snSotQt93BcJrFNpx6zFhQ3V7OApt+YZfGE=;
	b=APdeHuzqWiAPyeVwhM6SihAGjMPF2PL8UxAhIioyWOUiylcCAp0b3thMS8B7VlnKGeED0F
	3kw2BBiaeFqFhPhV04uycJ2G1crQEfisDKYBlPz3au0E691O+W5yZyMZ+AWJMTJluEMNJE
	y74ihJZLVGUZNoqOWqieaMaqVEJfe8c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-rFv_Yn9pNEeo8NemprD6KA-1; Fri,
 14 Feb 2025 07:53:42 -0500
X-MC-Unique: rFv_Yn9pNEeo8NemprD6KA-1
X-Mimecast-MFC-AGG-ID: rFv_Yn9pNEeo8NemprD6KA_1739537621
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF2281800879;
	Fri, 14 Feb 2025 12:53:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 668DC300018D;
	Fri, 14 Feb 2025 12:53:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250211093432.3524035-1-max.kellermann@ionos.com>
References: <20250211093432.3524035-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3978181.1739537619.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 12:53:39 +0000
Message-ID: <3978182.1739537619@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Max Kellermann <max.kellermann@ionos.com> wrote:

> When checking whether the edges of adjacent subrequests touch, the
> `prev` variable is deferenced, but it might not have been initialized.
> This causes crashes like this one:
> 
>  BUG: unable to handle page fault for address: 0000000181343843
> ...
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Signed-off-by: David Howells <dhowells@redhat.com>


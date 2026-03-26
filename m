Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C88405AA6
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541056; cv=none; b=WB/2El7WmCJdk4zLqLCN7dEbjHieeJ8WxBigw50K5Qm8FgGr/ykjd3zoPZ8xjZfE4yR3RCxK/z0lXJCp+OVQeATOVCjlyEHtsk2CMQw6zhdxF59FWxCPfp2Sq6w6iygkCpWYD+wEIndCnC7x3mKRWckZuQE8onIohj7WWVdrHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541056; c=relaxed/simple;
	bh=rsVTEqVvqT+FCm4DEJX59+WBq24WfTkd7Prn+gG+gUs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=g5kWVHYHHe6N8QH6UCtK3hPT8fBinHEYiPsdOUDRPm2nGorK1wCvGcNzxYh8Cf32xtyPddQ9lmsM6Ed38LYgpDgC6oOuKvmDeTzxFA72kl5r2u1QgcJHTsw8zUO1Qon2132iHWpeJcOncyRBloCribF7vtrNbcEt3N+kaS/GOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMLXzZlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMLXzZlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774541054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmOLbJ/a44uO5P3Gay64iTGN4ie/YnDzKWmPSQou7aM=;
	b=aMLXzZlr/Azl+RIEXz1Kv2gz9mghsJ2AQihoVoR3HlXRRlIgaxFzwlHDnMOc0Yyn+6frJG
	4BJpvnBWtzocB730QN80TUh+zYLlXVfLq985V+VRlpMGsFwYyLxKb4iDcnQOuycTRqmJqY
	mxzzc2/DaoXBLp/atK7aA+ASKEcVsRA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-CmVImOaqPX6uS923ObBGYg-1; Thu,
 26 Mar 2026 12:04:09 -0400
X-MC-Unique: CmVImOaqPX6uS923ObBGYg-1
X-Mimecast-MFC-AGG-ID: CmVImOaqPX6uS923ObBGYg_1774541048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 110CC19772DA;
	Thu, 26 Mar 2026 16:04:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 414CC1955E91;
	Thu, 26 Mar 2026 16:04:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <177451605242.1851489.9347587959983302502@noble.neil.brown.name>
References: <177451605242.1851489.9347587959983302502@noble.neil.brown.name> <CAB9dFdvs4=ZbqHeoMFXj39tPxCxKsApHXdyCxvjT8aAAbRCf6Q@mail.gmail.com>, <4001609.1774391729@warthog.procyon.org.uk>, <4002225.1774392603@warthog.procyon.org.uk>, <405501.1774511482@warthog.procyon.org.uk>
To: NeilBrown <neil@brown.name>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.c.dionne@gmail.com>,
    "Paulo
 Alcantara" <pc@manguebit.org>,
    "Christian Brauner" <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 16:04:00 +0000
Message-ID: <682795.1774541040@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: buo8Gyg847XyKZLaTgiaFBjAgFm0Otj17_s0e00p8hM_1774541048
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <682794.1774541040.1@warthog.procyon.org.uk>

NeilBrown <neilb@ownmail.net> wrote:

> -	ret = cachefiles_bury_object(cache, NULL, dir, victim,
> +	ret = cachefiles_bury_object(cache, NULL, dir, dget(victim),

I would prefer the dget() to be on a line on its own before this one to make
it easier to spot.

> If you agree I can post a properly formated patch which explanation.

That would be great!

Thanks,
David


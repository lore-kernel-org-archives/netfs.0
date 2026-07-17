Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F9334C1C
	for <netfs@lists.linux.dev>; Fri, 17 Jul 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280447; cv=none; b=mDx4v3hiJ8gHEBUmYBu26Zo+XOXOJPcBouRK9udBj9eNszwTBa8870R8Kp3efunUnACz7CLuVBeyb8/JAbjFVq6UIYFHyC2DxZxdVuE4ibRXU7jSjPCGlilu/jCE2bcqPQx2sSXZXiCYZb7av0mTTOifcGxPE4KEFl6feZlIcqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280447; c=relaxed/simple;
	bh=nQ7A0qnqnEEMoVqDVr4eFiEA6xwF0n6YaMnHCQfNK3o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=HoXTPvVFLbMIKsq9KMZ1fmFYnskzkytPDGF1vuiNsQLDp9P0BxPn3IvbL2RKAZXxqAyQovKUOd/tuFZGW7qeZ1e53jNkHylEmMjUZ+QCU5d1DwwHHq2sZSUOReThtmnWkWW4MOox3itvb2RZ9qYDmBPYhbjPOd0FFDgFe8L03G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+CLRYkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+CLRYkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784280444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2ohRF12baSBn/pM1LHJIdPp9zYWwkw7DqwenEX+bKc=;
	b=f+CLRYkpCQQr7rWRQMYt1w0/Mek4BinSF7nFnE24BdDFvZkyPx9A1IU/reAF8xBXgIaV+P
	mfFZWQS+QpEltJ/jsKw17a/l/bCaEGGXfIA1zmB2kRF4naiVcjFquRJL5MBYtnh9Psljya
	fUzIx4Hk4X7nHBFGoFC/AUCly/2PP2A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-0-v8TEHPPFeCOQNSxAUgFw-1; Fri,
 17 Jul 2026 05:27:22 -0400
X-MC-Unique: 0-v8TEHPPFeCOQNSxAUgFw-1
X-Mimecast-MFC-AGG-ID: 0-v8TEHPPFeCOQNSxAUgFw_1784280440
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 811AD1800750;
	Fri, 17 Jul 2026 09:27:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA72AD72;
	Fri, 17 Jul 2026 09:27:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260706030439.14212-1-xiang@kernel.org>
References: <20260706030439.14212-1-xiang@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 17 Jul 2026 10:27:14 +0100
Message-ID: <3594659.1784280434@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: uILx2ZsJtNkaw8LDEBsSbC-9NFvsK1y99AVi_UwgC40_1784280440
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3594658.1784280434.1@warthog.procyon.org.uk>

There are a number of mostly minor issues with this patch, as can be found
listed here by Sashiko:

	https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com

I've fixed them up in my tree and they'll appear in v7 of my "netfs: Keep
track of folios in a segmented bio_vec[] chain" patches.

David


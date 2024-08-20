Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317528E8
	for <netfs@lists.linux.dev>; Tue, 20 Aug 2024 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137341; cv=none; b=dsijSGF5PIuBWIkPvAWPUaTQI4fB4gcVa/mfEwJwNiKQhMwzcU0sHNDi2L6MwLVMJd6v6FCHGKaC1hR2p9k+Q6tSekQDxnLbl9xa0HDSLKhS2hVACjZbCBm4DedRUpMu3DBg99wkAwKElRKhJiIOkn40wJDO4Pi/9dj8Tk6ATEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137341; c=relaxed/simple;
	bh=4RvDm81YuYGUGtZK63aOvTreC1FK+b+j3aGtsr4Xuj4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YYlnLeYJWLH8kSobFKD8/7ujhmktMruCGVhacjc6fUXrD5UgSbD7SBF7eEt4JhBV1bg5z73K/A67YBP8tnddNS29hyvkg+0kM6n1+jZuCeczrwhmpZkmXxDS6eDSAYFxfFDwV0cUtJbF8Na/pxsdAUrs4K7hpz9kzpYekxbjFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbH5sx0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbH5sx0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724137339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6tg+78ssHLoUiJiuLkOUbKvdvvwfkuyAkYgEhna4vY=;
	b=RbH5sx0N77HPx/IslJ0fCMvKB6quRuWxWTAO4DWY3K2Iqvz+HUMRNx9RuSvpKBsWcKH88p
	muxbKq6hyehmEYwRok893JksVZLwjmt4E4e2jah8lgdtxH2HNhNc3lAKkeYY1iFCqd0ERL
	KHimuubLCjX4VACRES2htG4PX8+HUmg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-5HP8PYE4P6aH5o6ka1-ocw-1; Tue,
 20 Aug 2024 03:02:16 -0400
X-MC-Unique: 5HP8PYE4P6aH5o6ka1-ocw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 190251954220;
	Tue, 20 Aug 2024 07:02:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75AC219560AA;
	Tue, 20 Aug 2024 07:02:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240817084619.2075189-1-yangerkun@huaweicloud.com>
References: <20240817084619.2075189-1-yangerkun@huaweicloud.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: dhowells@redhat.com, brauner@kernel.org, jack@suse.cz,
    jlayton@kernel.org, hsiangkao@linux.alibaba.com,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3536138.1724137331.1@warthog.procyon.org.uk>
Date: Tue, 20 Aug 2024 08:02:11 +0100
Message-ID: <3536139.1724137331@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Thanks, but this is obsolete as of commit
fcad93360df4d04b172dba85b976c9f38ee0d5e0.

    netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG

David


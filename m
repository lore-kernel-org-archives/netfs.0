Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5032D372D
	for <netfs@lists.linux.dev>; Sat,  7 Mar 2026 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772891524; cv=none; b=dxZ3qg19aaE5AddPjiNCzXyOMuDDmnU+1sCaQvebYQcTHBBFJ3vYOg/6ilW+MY9R8FuzgOQdAGsLc0EG/6BMeak7yato2nxcp1PkuzFU2Pb0J2773d6vZTYf8j6aheKRxJeDqfvk1QT4gYgXvQWUmYccom3QFRpp7XxSaIC/Ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772891524; c=relaxed/simple;
	bh=uJNhmH0X69qWf38wy6vI+VE51fiNAFZIgqEBFzaembo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=NCdgOL92KwgLoQC6vCvGRhajGJqcwVV2Zw5a55Nw9FR/0ir6mkiCbDnP+G3GcbLq8f0JTLKNaHThIrAuNofaBfGRvCRHIy+w4ZdI11W26ZGI/F4htC/u64oChTyoa6Q/YDv/2gCarzPcvggxQItG/jew7eLc4jvLA3yQAKnygF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kj8DpEPG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kj8DpEPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772891522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJNhmH0X69qWf38wy6vI+VE51fiNAFZIgqEBFzaembo=;
	b=Kj8DpEPGCgGUYkyjxHcw1UONLYCdNm2W1bVrx7zaNJs9sIJyp8q/Kbzxa74HhdKZhxPhgA
	ueJOxL7ylskTlN/9AniUR9JS9tVeZpMXSykY9616oBpD7v9mDRs6b63L6uiUdBtWsapyMg
	+MdCfrKFXej8pPO2V7ZhFq2GBKFZjdk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-yi40-dcEOB64WlabGVo4lA-1; Sat,
 07 Mar 2026 08:51:58 -0500
X-MC-Unique: yi40-dcEOB64WlabGVo4lA-1
X-Mimecast-MFC-AGG-ID: yi40-dcEOB64WlabGVo4lA_1772891517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31B22195608E;
	Sat,  7 Mar 2026 13:51:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADBFB1958DC5;
	Sat,  7 Mar 2026 13:51:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260307090041.359870-1-kartikey406@gmail.com>
References: <20260307090041.359870-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: dhowells@redhat.com, pc@manguebit.org, jlayton@kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 07 Mar 2026 13:51:53 +0000
Message-ID: <683948.1772891513@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: nZBjYE5l67u8gvUz3OgmWcRsunRjLi4m2Q2lyODrc1w_1772891517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <683947.1772891513.1@warthog.procyon.org.uk>

Thanks very much for these two patches :-)

David


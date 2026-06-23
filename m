Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A33D5241
	for <netfs@lists.linux.dev>; Tue, 23 Jun 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226445; cv=none; b=u1LJQUbpsApGM8du9QuSnzIpowCG8dshlBfHitL7cUiYXye+GinQonTiR1N6ErrBAb3oWjqqPKgVgKCFx+7ftfpIm7TcEjeLw9ONWMpH8S3v4Ce20smcNejTZURIkfDI+ql6FxVw+jxSp0zl94GLHvVQinmCPx21f1FUDZs9NM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226445; c=relaxed/simple;
	bh=c70XTwAJzKyuNR6knoPrJL/ckuTGiXDPNfBF6DPn9zA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=Kl5Oim8voP6NBLy7pmfj2bJyhwBQ+0IBh1amwMmmJP7szBz27m1+ucpvYD6V6HEY5npKw9lp0qFvEpNJXTKWDR8S+q9U/zmhIt147e1qK+SLnx6Brba3QTQ6vf/B3gMUUjlRdwKoGUKdI8cn2leSVpu1hJx8c7K+Sn9Yfq+zUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqhAEHUW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqhAEHUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782226443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIBLs4b9hYj+9u/PkWZNtPRlc9DDx0+KA2+1Ck2RjNs=;
	b=CqhAEHUWUaMwyrc134iDgqcERI+iigjwLtIIwiPNMWKkMoTHvPCmKC7qmjVHW6jXlf+0la
	6sfainnvJy5UjUXRakd5Vw7PNtPZv29BP31FFr+hqHoOXEfaQ32jlc7wMuJS/mvV/pujyl
	Vopdrl5Jhu7vhAKTQlt2fAmnKQSO1YI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-Peeeg8DNNMipx1qbUp_h4g-1; Tue,
 23 Jun 2026 10:53:59 -0400
X-MC-Unique: Peeeg8DNNMipx1qbUp_h4g-1
X-Mimecast-MFC-AGG-ID: Peeeg8DNNMipx1qbUp_h4g_1782226438
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CFC4195607C;
	Tue, 23 Jun 2026 14:53:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28AD51955F74;
	Tue, 23 Jun 2026 14:53:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
References: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
To: hongao <hongao@uniontech.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed preparation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 15:53:53 +0100
Message-ID: <2877069.1782226433@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: xbe2T0mwQtnI6dL4lvFF_dyWM-EoLnZ7GXsV9xiywNE_1782226438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2877068.1782226433.1@warthog.procyon.org.uk>

hongao <hongao@uniontech.com> wrote:

>  		/* Check if (re-)preparation failed. */
>  		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
> -			netfs_write_subrequest_terminated(subreq, subreq->error);
> -			wreq->error = subreq->error;
> +			ret = subreq->error;
> +			wreq->error = ret;
> +			netfs_write_subrequest_terminated(subreq, ret);
>  			break;
>  		}

This shouldn't be effective as all netfs_write_subrequest_terminated() will do
is pass control of the subreq struct back to the app thread.

David


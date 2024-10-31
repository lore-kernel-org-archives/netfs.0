Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEA19DF99
	for <netfs@lists.linux.dev>; Thu, 31 Oct 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383596; cv=none; b=MrcGS6X/EUyrQlAW/4jWOJqqKuOuSSOMWp+MaO+2HREDcljHsmAWJ1eM2y32h+ba7DNZlSaz3nEiPpzsHJw1bBWswftMBc02T/WLIHCtdERA/L/HOAf2BTHJnuSOxOFoqCu9S4343S/G6UrfbmzLNnNfgZOOx7n3xaxqbV/6Z5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383596; c=relaxed/simple;
	bh=E2KT+T9OslwegLV2Yahds9iB6UcOxov4tYT/ePJZVb8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mKh9DWF8W+46MznK5PQuawzQEfO28eOwFCPeUdVz36Rc1JViKs8Ls4VBHnWTlBY1BgjYuDVQlaC6mbbtZ3IZYVWiFz4pjDfFOj3mbrw4hZXL64bBOkoci4uDj8rBnYPuVRzEhA85ccYo7l4iRpzJ3uSA0W/NSHR+FmuTEJzueLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfJxFV68; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfJxFV68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730383593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPw0KC7y3KQoqhkgCzl+fitTPqNxmfYkVKmmEZs0RSc=;
	b=ZfJxFV68mT6SVYLx1aqFXJ8S6vRP22AQrCt01YIWcjZ7N0CZ8QHa6MOPMHb0UcOLD3CIwg
	V10rP8fhY4iORsHMl6vqcxlGLUALEw9yrbJqZ3XHoHi3K/u//WVJyScrgHCzSt5f8qUKww
	CmN/0ZIwFeZJ6jT7Xx7ne1yeqp7fJOo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-6ND1lZdzNDuKhxZkv0XDGg-1; Thu,
 31 Oct 2024 10:06:28 -0400
X-MC-Unique: 6ND1lZdzNDuKhxZkv0XDGg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 680DE1955F57;
	Thu, 31 Oct 2024 14:06:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B3231956054;
	Thu, 31 Oct 2024 14:06:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zxw_UgtVWOHHfkoD@gmail.com>
References: <Zxw_UgtVWOHHfkoD@gmail.com> <ZxshMEW4U7MTgQYa@gmail.com> <3951592.1729843553@warthog.procyon.org.uk>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Add a check for NULL folioq in netfs_writeback_unlock_folios
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45854.1730383584.1@warthog.procyon.org.uk>
Date: Thu, 31 Oct 2024 14:06:24 +0000
Message-ID: <45855.1730383584@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Chang Yu <marcus.yu.56@gmail.com> wrote:

> I see. This might be a stupid question, but is it ever possible that we have
> exactly one folioq and at the same time
> 
>         slot >= folioq_nr_slots(folioq)
> 
> is true? Then I imagine netfs_delete_buffer_head would return NULL and
> cause the bug to trigger as well?

Whilst it is possible for "slot >= folioq_nr_slots(folioq)" to be true on what
is currently the last folioq, wreq->cleaned_to suggests that there must be
still-locked folios in the queue:

		unsigned long long clean_to = min(wreq->collected_to, wreq->contiguity);
		if (wreq->cleaned_to < clean_to)
			netfs_writeback_unlock_folios(wreq, clean_to, &notes);

David


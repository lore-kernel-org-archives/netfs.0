Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E37221D99
	for <netfs@lists.linux.dev>; Mon, 17 Mar 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205804; cv=none; b=uNh8bJC2IggfmE5wIJTWVjCfrIh/mAiMDeCZDPM0GrvDzeyuyxRxIWv6v7TnrcMC2kDU1P+V/sFIKZTZxrCZpdin0OmlcOg3Yp7PSbxgcI6FRkQ5x3uxiI8EIVoxRyboVoIIYvrLKXvbxQDN+OvQjdWNBzh5ym43mUhcfPaQygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205804; c=relaxed/simple;
	bh=ypZ17jJfpN+bq6gupq+Ho+KrCCKX7qiYeSCHx1uvw2M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JYgmKiAvwPA+B5qvR2w7t5ladbyfhK+zJwi1qYQ/u/0OVIRwe26/+4yUTUBM/h207Oa1vUMjEQhkiNxrfKqAIkw/Fvs8nPD+liqNg5A09QyUPyUBu0NWB0HrLGiLJgfFyC75AnmfwaEzvNwzlUP4lhe3vB+EKjde28kfQoDAUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaeQsD7C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaeQsD7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742205801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypZ17jJfpN+bq6gupq+Ho+KrCCKX7qiYeSCHx1uvw2M=;
	b=QaeQsD7CW0rIYkrF4QWhRKWEFgds2QpaLKnwW5dQS1Ob+7KQeNERS0HUIKna7nKSHL5Xuf
	7I+4Wh0sRO490u2JsHQVSsBdd729/7SIkPmR2UdW45ooFXsPbhGenx18ieCZ5IyqloFN42
	D7sZuwauMA5pwfpqRIdJ2WtI5kiyFb8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-GtkgsP6UO8qCsvDShsm1mg-1; Mon,
 17 Mar 2025 06:03:18 -0400
X-MC-Unique: GtkgsP6UO8qCsvDShsm1mg-1
X-Mimecast-MFC-AGG-ID: GtkgsP6UO8qCsvDShsm1mg_1742205796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8CFB18001E6;
	Mon, 17 Mar 2025 10:03:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2DD519560AD;
	Mon, 17 Mar 2025 10:03:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250220152450.1075727-1-max.kellermann@ionos.com>
References: <20250220152450.1075727-1-max.kellermann@ionos.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2110404.1742205792.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Mar 2025 10:03:12 +0000
Message-ID: <2110405.1742205792@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Greg,

Could you pick this up for 6.12.y and 6.13.y?

https://lore.kernel.org/netfs/20250220152450.1075727-1-max.kellermann@iono=
s.com/

Thanks,
David


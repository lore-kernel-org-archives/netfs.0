Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE735972
	for <netfs@lists.linux.dev>; Mon, 10 Feb 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200867; cv=none; b=aegVdUCEcrVEspuu/tIGZfBIQx+ZYuqjEFe4diePCserIWv+Jpv1tOiL29i94paF72TQQ6nfCk1EDaJrLavZegW8kx3lUJwgSy6y1+OuoXOL5lDPQ8vtark9/Hc45d5CGL6zOqH5ENi4BW2YnWu9qfw/QpJN91s0zjO8GmgeJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200867; c=relaxed/simple;
	bh=0Xqr41ZZrJh4bjEnx7vr7pghbDcp783elzwI1NPzerA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=tWZsPBZXcyasG6V2ZHhs5tpFcC1cgn+Oa2jTDxm2b7/eMIqFcGrOVVfLO3EAryJGk6cBcDM2EGgwy+eDdEv18UJ5OUgMQ+3bPf1mr8K8VsBj0wBP3KX5zp1Vq5YNQntcuO8Uo4A0BSSGiNYcTw9cXZo7CZK6lMbmpuSbbhZDg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVwbAlqW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVwbAlqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739200864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAstyOUmLoPinPyGE4XOBnF1VKWvwKwEIte6lZZxCB0=;
	b=eVwbAlqW/lXNfjCV8+CLW7ZgwdcsUUOOoh9P/p++Ha1gzEcGG/hnqwzddEAo6qCBcR1u/E
	qXX62Q6jzDcRv1YcGVu048ibPta3jxIjmMd7Gjkh7U6VXS/C/fd2rRqCyuYsyn+32dZWI+
	XL+pNo/D6Z8sPZKX48NNnJlp4HjYL9s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-RovH38c7NdyDoa5jgB-uhQ-1; Mon,
 10 Feb 2025 10:21:00 -0500
X-MC-Unique: RovH38c7NdyDoa5jgB-uhQ-1
X-Mimecast-MFC-AGG-ID: RovH38c7NdyDoa5jgB-uhQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 865F219560AF;
	Mon, 10 Feb 2025 15:20:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A69530001AB;
	Mon, 10 Feb 2025 15:20:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250122090306.1524098-1-brahmajit.xyz@gmail.com>
References: <20250122090306.1524098-1-brahmajit.xyz@gmail.com> <20250121091530.1316673-1-brahmajit.xyz@gmail.com>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: dhowells@redhat.com, david.laight.linux@gmail.com,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH v2 1/1] cachefiles: fix build with GCC 15
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2025 15:20:57 +0000
Message-ID: <3055183.1739200857@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Brahmajit Das <brahmajit.xyz@gmail.com> wrote:

> Building with GCC 15 results in the following error
>=20
> fs/cachefiles/key.c:12:9: error: initializer-string for array of =E2=80=
=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
>    12 |         "0123456789"                    /* 0 - 9 */
>       |         ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> This due to GCC 15 having enabled -Wunterminated-string-initialization
> by default[0]. Here we're increasing the size of cachefiles_charmap from
> 64 to 65 to ensure space for NUL. Unfortunately using
> __attribute__((nonstring)) or converting to unsigned char [] didn't help
> in this case (thanks to David Laight <david.laight.linux@gmail.com>).
>=20
> Please also refer:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178, and
> https://gcc.gnu.org/pipermail/gcc-patches/2024-December/671714.html
>=20
> [0]:
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-untermi=
nated-string-initialization
>=20
> Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>

Acked-by: David Howells <dhowells@redhat.com>

